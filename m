Return-Path: <linux-kselftest+bounces-6971-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E093894D2B
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Apr 2024 10:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F339E283074
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Apr 2024 08:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293583DBB2;
	Tue,  2 Apr 2024 08:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EkMa/rJ3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC4145007;
	Tue,  2 Apr 2024 08:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712045303; cv=none; b=TzaLfWSJ1tbPd2t5os1i3Ylze4h2V5VVGuSXI4BvZibP4laWC6TpPL6Aw5BhUoYflQj5j3HABbsNuJRscLXVsp+nmis965gh+xN03C0XR1HJfjsUGauinjJ8frV3Eg4jn6OUOJ5FuVNjqy+mP6UvYMwCNDfEiMP5Zi0/o0gN8P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712045303; c=relaxed/simple;
	bh=RvjIoEFCnlt4dJMFpZZIOO4Sc8JyrvCLEP31AeMdHHA=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=MfqIYGMdioJNwzk8TLFu6YB5N1SnNL1t9rSEpS9qiQmY+XLb50vAXTpGean7AL7D0wzMvCxJbkA1JAkUueAFFM3UVDuGKT8P9igbZYCk/slau+/mUMVVI/8GGddsm+BpS9pJobSjnP1WTUsb+L4bU1R2krXbENvS4lqFfivLmF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EkMa/rJ3; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e267238375so4451985ad.1;
        Tue, 02 Apr 2024 01:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712045300; x=1712650100; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cXS4cJz05mC2M6wLT/RtjR7duIEuJE+jEDewfgJLeHk=;
        b=EkMa/rJ3py4cFd/fEaAzcZ2+G6HzxCuI3V7pr4mdgVDZiXrq97zP4BOJZGT8htwtxP
         eK3pn3Aupo4LSecgfnH8E+LR4tdF3NparpvnC8yHDsYmEg41oiZWd0zOKcbuoWhBbbiP
         UqnpRoLnD08eDc6a5xrrrs+V/epQyouqfA2PREPohQosGtqchXpRbXiRUOu6y4o67Lrp
         ZSnp0WU9CjAV9WkJTFnA5Kc8ltiymFlDzFaV+0doPSxQ1LdbW2qdLpFA4XsPu2mzGrCR
         eNIV/btpCGYL1qmQbiNJTrXMn3t/cMCmpvNJyQgMvE1tgg1xAJbo9Z4Hu4eFwrgQQnUj
         IWpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712045300; x=1712650100;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cXS4cJz05mC2M6wLT/RtjR7duIEuJE+jEDewfgJLeHk=;
        b=oMawHz35B9JeCrSRKDNyiOy7+bh+UzWLOtPeAeEnl0T/ZFpndo4LsBCu3+8imQFtUx
         PUpu2rywi2zV9oLiwA0pmouP+MVYwmsZmsHYVOVh2jbWQR6XlkO18u/PFIE0PXgMwD+k
         31wSEorsroC4osd0MT/bUj98cq/jVgq8IwMzoGKiVUX0CtJr2tjiQ1Q7cWKnWVuv2IAB
         y8oXuH+pKtKCfaGtZ5a78EI5wqToI4Qez22fmqq1BK0746y+PQzf9u3A9fThUZYl4eE8
         C3WH4V19ynFeE/mo/d8jNoKSbdv6bnw9ieRZFhz9R6YFwZNKif+TKwVM+A2fG4t+EyUk
         LANA==
X-Forwarded-Encrypted: i=1; AJvYcCX9S+M97rkqVCtvTRhpl/LuiiGvsBmUh0XCNdI42U4CqmIHElR5WWMusFdsQVyr/mP6UzTgOok1srlxBb6rWu3OK3zB1yRMpmwSD+IkJRxAay62KVISy9PILAQNNXvvWXrMJ5hEUpgJFLccLIIAkkAUdj7wSXGL
X-Gm-Message-State: AOJu0YwXwX7AmKKeTNIxb1xNeBUHqHR9MMWWbp8YDw7fAlCUazEgacJ0
	PxKlByeTHDPb7uFzWTHxqEPXUdkJUgMZA5dJTfO2RR1EEQVGbRkL
X-Google-Smtp-Source: AGHT+IE34CFOHQtWBVwkAC+tfxS3OlSnWZqxk6sERGtnE+HKd+m7AK82BE8k/HW5JOx8TzyByc9RTg==
X-Received: by 2002:a17:902:f68e:b0:1e0:c070:b082 with SMTP id l14-20020a170902f68e00b001e0c070b082mr23405632plg.14.1712045299863;
        Tue, 02 Apr 2024 01:08:19 -0700 (PDT)
Received: from [10.0.2.15] ([103.111.134.151])
        by smtp.gmail.com with ESMTPSA id b15-20020a170902650f00b001dda64281a9sm10575031plk.85.2024.04.02.01.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 01:08:19 -0700 (PDT)
Message-ID: <860c9cadb2fa06c8f10db42ad38405ee19d43a16.camel@gmail.com>
Subject: Subject: [PATCH] Add test for more file systems in landlock - ext4
From: Saasha Gupta <saashaa1122@gmail.com>
To: outreachy@lists.linux.dev, mic@digikod.net, 
	linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: alison.schofield@intel.com, paul@paul-moore.com, shuah@kernel.org, 
	saashaa1122@gmail.com
Date: Tue, 02 Apr 2024 13:37:44 +0530
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Date: Mon, 2 Apr 2024 19:59:56 +0530

RE: This patch is now properly preformatted.

Landlock LSM, a part of the security subsystem, has some tests in place
for synthetic filesystems such as tmpfs, proc, sysfs, etc. The goal of
the new issue, and hence this patch is to add tests for non synthetic
file systems, such as ext4, btrfs, etc

This patch adds tests for the ext4 file system. This includes creation
of a loop device (test-ext4.img) and formating with mkfs.

Signed-off-by: Saasha Gupta <saashaa1122@gmail.com>
---
 tools/testing/selftests/landlock/fs_test.c | 65 ++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/sel=
ftests/landlock/fs_test.c
index 9a6036fbf..b2f2cd5a5 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -4675,6 +4675,14 @@ FIXTURE_VARIANT_ADD(layout3_fs, hostfs) {
 	.cwd_fs_magic =3D HOSTFS_SUPER_MAGIC,
 };
=20
+/* Add more filesystems */
+FIXTURE_VARIANT_ADD(layout3_fs, ext4) {
+	.mnt =3D {
+		.type =3D "ext4",
+	},
+	.file_path =3D TMP_DIR "/dir/file",
+};
+
 FIXTURE_SETUP(layout3_fs)
 {
 	struct stat statbuf;
@@ -4728,6 +4736,63 @@ FIXTURE_SETUP(layout3_fs)
 		self->has_created_file =3D true;
 		clear_cap(_metadata, CAP_DAC_OVERRIDE);
 	}
+
+	/* Create non synthetic file system - ext4 */
+	if (stat(self->dir_path, &statbuf) !=3D 0) {
+		pid_t pid =3D fork();
+
+		if (pid =3D=3D -1) {
+			perror("Failed to fork");
+			exit(EXIT_FAILURE);
+		} else if (pid =3D=3D 0) {
+			static const fallocate_argv[] =3D { "fallocate", "--length",
+						   "4M", "test-ext4.img",
+						   NULL };
+			execvp(fallocate_argv[0], fallocate_argv);
+			perror("execvp failed");
+			exit(EXIT_FAILURE);
+		} else {
+			int status;
+
+			if (waitpid(pid, &status, 0) =3D=3D -1) {
+				perror("waitpid failed");
+				exit(EXIT_FAILURE);
+			}
+			if (!WIFEXITED(status) || WEXITSTATUS(status) !=3D 0) {
+				TH_LOG(stderr,
+					"Failed to create ext4 filesystem image: fallocate failed\n");
+				exit(EXIT_FAILURE);
+			}
+		}
+	}
+
+	/* Formate and mount non synthetic file system - ext4 */
+	if (stat("mnt", &statbuf) !=3D 0) {
+		pid_t pid =3D fork();
+
+		if (pid =3D=3D -1) {
+			perror("Failed to fork");
+			exit(EXIT_FAILURE);
+		} else if (pid =3D=3D 0) {
+			static const mkfs_argv[] =3D { "mkfs.ext4", "-q",
+					      "test-ext4.img", "mnt", NULL };
+			execvp(mkfs_argv[0], mkfs_argv);
+			perror("execvp failed");
+			exit(EXIT_FAILURE);
+		} else {
+			int status;
+
+			if (waitpid(pid, &status, 0) =3D=3D -1) {
+				perror("waitpid failed");
+				exit(EXIT_FAILURE);
+			}
+			if (!WIFEXITED(status) || WEXITSTATUS(status) !=3D 0) {
+				TH_LOG(stderr,
+					"Failed to format ext4 filesystem image: mkfs.ext4 failed\n");
+				exit(EXIT_FAILURE);
+			}
+		}
+	}
 }
=20
 FIXTURE_TEARDOWN(layout3_fs)
--=20
2.44.0



