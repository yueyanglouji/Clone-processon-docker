-- Adminer 4.8.1 PostgreSQL 14.1 (Debian 14.1-1.pgdg110+1) dump

DROP TABLE IF EXISTS "Chart";
CREATE TABLE "public"."Chart" (
    "id" uuid DEFAULT uuid_generate_v4() NOT NULL,
    "title" text,
    "deleted" boolean DEFAULT false,
    "elements" json,
    "page" json,
    "theme" json,
    "ownerId" uuid,
    "createTime" timestamp DEFAULT now(),
    "lastModify" timestamp DEFAULT now(),
    CONSTRAINT "Chart_pkey" PRIMARY KEY ("id")
) WITH (oids = false);


DROP TABLE IF EXISTS "Comment";
CREATE TABLE "public"."Comment" (
    "id" uuid DEFAULT uuid_generate_v4() NOT NULL,
    "shapeId" text,
    "name" text,
    "replyId" text,
    "time" integer,
    "content" text,
    "userId" text,
    "chartId" uuid,
    CONSTRAINT "Comment_pkey" PRIMARY KEY ("id")
) WITH (oids = false);


DROP TABLE IF EXISTS "History";
CREATE TABLE "public"."History" (
    "id" uuid DEFAULT uuid_generate_v4() NOT NULL,
    "title" text,
    "remark" text,
    "elements" json,
    "page" json,
    "theme" json,
    "userId" uuid,
    "chartId" uuid,
    "createTime" timestamp DEFAULT now(),
    CONSTRAINT "History_pkey" PRIMARY KEY ("id")
) WITH (oids = false);


DROP TABLE IF EXISTS "Post";
CREATE TABLE "public"."Post" (
    "id" uuid DEFAULT uuid_generate_v4() NOT NULL,
    "title" text,
    "content" text,
    "published" boolean DEFAULT false,
    "authorId" uuid,
    CONSTRAINT "Post_pkey" PRIMARY KEY ("id")
) WITH (oids = false);


DROP TABLE IF EXISTS "User";
CREATE TABLE "public"."User" (
    "id" uuid DEFAULT uuid_generate_v4() NOT NULL,
    "name" text,
    "password" text,
    "email" text,
    "avatar_url" text,
    "emailCheckCode" text,
    "checked" boolean DEFAULT true,
    CONSTRAINT "User_email_key" UNIQUE ("email"),
    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
) WITH (oids = false);

INSERT INTO "User" ("id", "name", "password", "email", "avatar_url", "emailCheckCode", "checked") VALUES
('bc24ab0e-f24c-4388-b2bf-f86660a92051',	'test2',	'$2b$10$/WtVfFG0WHBLBHU9KxsBIeI/3mLZa8.iq8Y9.GwRPGB7dR0Yqkm3y',	'test2@test.com',	NULL,	'$2b$10$/WtVfFG0WHBLBHU9KxsBIeiFiepIYivVNWAl7vxV..DGVI.XaAP1K',	'0'),
('994e60cc-7307-4b5d-b28f-4970e3d9be6b',	'test',	'$2b$10$/WtVfFG0WHBLBHU9KxsBIeI/3mLZa8.iq8Y9.GwRPGB7dR0Yqkm3y',	'test@test.com',	NULL,	'P2022',	'1');

ALTER TABLE ONLY "public"."Chart" ADD CONSTRAINT "Chart_ownerid_fkey" FOREIGN KEY ("ownerId") REFERENCES "User"(id) NOT DEFERRABLE;

ALTER TABLE ONLY "public"."Comment" ADD CONSTRAINT "Comment_chartid_fkey" FOREIGN KEY ("chartId") REFERENCES "Chart"(id) NOT DEFERRABLE;

ALTER TABLE ONLY "public"."History" ADD CONSTRAINT "History_chartid_fkey" FOREIGN KEY ("chartId") REFERENCES "Chart"(id) NOT DEFERRABLE;
ALTER TABLE ONLY "public"."History" ADD CONSTRAINT "History_userid_fkey" FOREIGN KEY ("userId") REFERENCES "User"(id) NOT DEFERRABLE;

ALTER TABLE ONLY "public"."Post" ADD CONSTRAINT "Post_authorid_fkey" FOREIGN KEY ("authorId") REFERENCES "User"(id) NOT DEFERRABLE;

-- 2021-12-31 07:52:59.84367+00