Return-Path: <linux-kselftest+bounces-6957-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 548CC894674
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Apr 2024 23:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09A9428326C
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Apr 2024 21:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E8554919;
	Mon,  1 Apr 2024 21:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SLMB0qjT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6088480
	for <linux-kselftest@vger.kernel.org>; Mon,  1 Apr 2024 21:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712006391; cv=none; b=pHW8Z99xLtpJQUB8J50qsLVS6ZwexxANwrZ5VWHUvUNqERC/OjzoqlNTVEgrS4daVSTiDjOAsgOAUoQl3Tx2+U9ImjEV0ABZLeULYQUEDjuylbmIjMG4M4y6ORzLwz8vGFBrGDK0/G2cmgoHRHqJAV5V9TThuUqjwGaebTazszE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712006391; c=relaxed/simple;
	bh=kdpmtDg4h+ZaTEw599M0gGG7yvAN5EtrhRYwskEeHao=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=n+Hin8P/3sBXL3NMiawLprGwEgSW+Bvq1MvshT1W2vz8okXoHou/EmGxfk0/7Is/kylg5uGmt/ukD+woB/iHt/oCpGNZGqatN6cbg/pOHLDMotePTP2A1QpMHoy+nMr+oqlMSxauYVLwBxHzTKcfdkzrE+GlflnIIugn++vRvTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SLMB0qjT; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e252f2bf23so10520475ad.2
        for <linux-kselftest@vger.kernel.org>; Mon, 01 Apr 2024 14:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712006389; x=1712611189; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qatYW0FVH4vK7aU+YtR0sJpjoSbWBUdIZVdcV4l8QGY=;
        b=SLMB0qjThrdJUoSmtLaih/i6PwBjwEeUWjMtQ7bGA6VE5Lr782qWf5h/SwAVYv6Tt3
         XUXGEvTJ67G0WQpnjUKeepK4B82kqrgEBq08bB8aqcwBzU4u0xqAX1vU7tIi24haQ/+P
         vZ/pvoXXMDcGZYXxJ7ERtkjldInvq/tBulXmf3NwsyefMzlTtOGNVfJw+uNqB6c6WWHg
         x/HQC3MmsxdJwsid1DstAvHtssRsc0EaPOwv43t9ufE6bTD9Be+pgZnogB0pACu6rhc0
         O9aWE/eS00sXJhNMu2Y4zo8VLDfnN8RQsEy7XMtXmmFajQ/71gr1p7YQG1MzW7eMuSqO
         QKKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712006389; x=1712611189;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qatYW0FVH4vK7aU+YtR0sJpjoSbWBUdIZVdcV4l8QGY=;
        b=mYZ6+LpveBvT/DMbWb246GvjfqNtbO2S0SEXRTtBGmt8n9cFldfVG2O8jkI3V58wmA
         irXXypLPfNGgWnqsKE285GMXqO1YlS6V5LiHhORV0nDIxM9CzVzuZJrkVFfJQZU1WD69
         DWgKsHQkRBxPaAlPcOZmo9hhYl6MqaM91I0xamsGcOm4M0sdx8Ehi564CyKeB/rONbxa
         ws6UdGObqUBBvuSafalrxm9Pe1Cu78biEeiIZV3TBBuC4oNC0oNOXFF8n3myEmbIEjbR
         ANPCrL3wFS9kwkOBPx25EivBt98h+p2axQsgLLWpI6FpDcKrKgJOtRmc5E9X/43iOTgf
         Gnpg==
X-Forwarded-Encrypted: i=1; AJvYcCWFYI6ndeUH+PwXXIemYQZo9kdD1QCqMzcWinn3Cak0ww1yw7gkfUZjrpEbV4/34IzJFWE7poVWU6QWodYVvNB0pLWftG4ylhl4UrGSvtU4
X-Gm-Message-State: AOJu0YyZdwfTfOS4m08Df7wUbWm3AtzuLkz1DPkkqTspWASH65yAN3Yl
	WMttKA7C0/dMxMVZL3x+jOL0dchHKrBRefb65oro3oKNjbsvMrUT
X-Google-Smtp-Source: AGHT+IFyatp8pZR7m4gdRImie5+Pxs8LyqcglgAU6FWLI1nl9divwmsv0dBs9FwBXQCCuhdsSLfAqg==
X-Received: by 2002:a17:902:ea11:b0:1e2:3e0a:fc61 with SMTP id s17-20020a170902ea1100b001e23e0afc61mr9242312plg.34.1712006389310;
        Mon, 01 Apr 2024 14:19:49 -0700 (PDT)
Received: from [10.0.2.15] ([103.48.100.252])
        by smtp.gmail.com with ESMTPSA id kv7-20020a17090328c700b001e0d8fd208fsm9449296plb.291.2024.04.01.14.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 14:19:49 -0700 (PDT)
Message-ID: <4398bb88a2f3b58646267e3d6ceb5414c86b65cb.camel@gmail.com>
Subject: [PATCH] Add test for more file systems in landlock - ext4
From: Saasha Gupta <saashaa1122@gmail.com>
To: outreachy@lists.linux.dev, mic@digikod.net,
 linux-kselftest@vger.kernel.org,  linux-kselftest@vger.kernel.org
Cc: alison.schofield@intel.com, paul@paul-moore.com, julia.lawall@inria.fr, 
	saashaa1122@gmail.com
Date: Tue, 02 Apr 2024 02:49:14 +0530
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

From 7bb9c34291b295e192155d2b800d2ef7ce910dfc Mon Sep 17 00:00:00 2001
From: Saasha Gupta <saashaa1122@gmail.com>
Date: Mon, 1 Apr 2024 19:59:56 +0530
Subject: [PATCH] Add test for more file systems in landlock - ext4

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

diff --git a/tools/testing/selftests/landlock/fs_test.c
b/tools/testing/selftests/landlock/fs_test.c
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
+			static const fallocate_argv[] =3D { "fallocate",
"--length",
+						   "4M", "test-
ext4.img",
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
+			if (!WIFEXITED(status) || WEXITSTATUS(status)
!=3D 0) {
+				TH_LOG(stderr,
+					"Failed to create ext4
filesystem image: fallocate failed\n");
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
+			static const mkfs_argv[] =3D { "mkfs.ext4", "-
q",
+					      "test-ext4.img", "mnt",
NULL };
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
+			if (!WIFEXITED(status) || WEXITSTATUS(status)
!=3D 0) {
+				TH_LOG(stderr,
+					"Failed to format ext4
filesystem image: mkfs.ext4 failed\n");
+				exit(EXIT_FAILURE);
+			}
+		}
+	}
 }
=20
 FIXTURE_TEARDOWN(layout3_fs)
--=20
2.44.0



