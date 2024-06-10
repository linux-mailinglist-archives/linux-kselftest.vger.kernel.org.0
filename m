Return-Path: <linux-kselftest+bounces-11600-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B899029B9
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 22:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA5401F21081
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 20:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4008214F121;
	Mon, 10 Jun 2024 20:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LVRm4k/G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18771B812;
	Mon, 10 Jun 2024 20:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718050163; cv=none; b=VbYsJH8VQ5FyhWVsCc3lTxvJiE2TTEDMMgcSoyXSKNdjSDDW0RTlldOT2jvSU+QMUjuztKSkifjp+ImMZwG1yrKuek6Wzr4GfKb5RiT7txs1vp0+K/wPvTaj9lC4VzYwvvbHHQimFqouPdSHCN/MOK/nQ774/vdJA7jA2pIjn5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718050163; c=relaxed/simple;
	bh=c1BneUUhSn4t+cH+YqJuyxjKUHmeZACdZHTDo5SeE1M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=lF+C6TILoxmtYc/xyNSB5B2AaKLxKsujQmGbO+Va/Rw4pF9luZerPFrnWbKr98kGzsk/tMOeC/wO/E40JEKtVWDP+Lsu6voQlqI7JLB7B7AKjcQnDQLq3WJNnBGlBhGenmKTFpOx9Oe1ry0kY/ZkMWLGgpC5IBSuhHJ8FUaZGN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LVRm4k/G; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2c315b569c8so323597a91.0;
        Mon, 10 Jun 2024 13:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718050161; x=1718654961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0C8Qu+cw7poJliJ7fKZVJslfoPcxeWgTVGFWkb83UUc=;
        b=LVRm4k/GvJgcB/VxjAEFCBHe2KkUbwHAlXmmqvYM7hL3hlhXm9+8ZDUqo7L9VybkKF
         1Z7rpagl9dVrDmHSWh4DsQSYd8AO6aSHBTuv5pIyk/6E/HHmwFd9z6slX/FIYgJPSLeT
         hhx9+3yQPaLPQPSWWpspdwm1dUGHwDSEJe93sLCaj/UOX3rJHHJeArm+CMOqSCk96c5L
         MF2Sh0Gez7pkmrhTErlp9v1EHZmFqZFqBeyP/FlXgn9dToSuykOokS12BMJmrvaMrhRh
         2I9MBujT6Ry2oC0aN4qGsYCoVksQU7mmX5EyhwjMJoTnTqHIfmiz0vOrAMUvHi02Vi5G
         1fmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718050161; x=1718654961;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0C8Qu+cw7poJliJ7fKZVJslfoPcxeWgTVGFWkb83UUc=;
        b=cDgbuzUljIaYAFoepgUY+6U2iOksrMDIRnQUWpzF6if6WYwq59SuEJJ34Sn/Aj3qL2
         uYFXAUTpkfTfGo4JGH0l/t+O998GuikS0yr2fLs8T8HUbGWPVZi1WHbS5twp39ZpY52/
         g05c8Stam3llzd6uVTNaQvRvCFFCvza6Fz/64Z6miCs5cjiU5NgRWh4Fi7HaERUUBrzc
         CNpNlGHCofJ99RzzW7T2iUUKlXWC20DF7KFBJXXI4ejBDwNicLcTwXWV70EYvSHFQ0cx
         UhIGH+1vqlzh6FM/okpj4UPWvsofYT0fAM4TkgFvC7LHHRMmgfqrRso2T2gM4Eszqrv7
         8A8g==
X-Forwarded-Encrypted: i=1; AJvYcCWmsGPShw4mimaUIloGTaj+Q0SF3if/+6aNKTCSqgAnq3jBHYpZgbYKooRJ16IdOZV2k5Kj7gp2SyevTVnM0gftj7M0vKcJOdzf5Yvdbrd8qbbnHeZfD1xCd3rm2ACEtV2TLnIgIE324g4C7Sqf
X-Gm-Message-State: AOJu0Yw/rqD+FjU0oklJFhAoaQEyDo+Gg6+lNM016XYQMo564MlMggZ7
	x9+maZ7q1JC2Xtutwqdg/GvDrwJ4ejpSdg3B29+mYpYmNI+8r0gN
X-Google-Smtp-Source: AGHT+IG5RJTxDye8IWs6NAUfz0dC5ivrbZ8nUVy7iBZ2iO4vXvb4o3ZYxtEy61V0ReP9FwXy5od/4Q==
X-Received: by 2002:a17:90a:5d18:b0:2c3:1e2a:b5f3 with SMTP id 98e67ed59e1d1-2c31e2ab6b2mr1868898a91.15.1718050160921;
        Mon, 10 Jun 2024 13:09:20 -0700 (PDT)
Received: from dev0.. ([47.31.175.114])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c31ed7133esm1176606a91.8.2024.06.10.13.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 13:09:20 -0700 (PDT)
From: Abhinav Jain <jain.abhinav177@gmail.com>
To: shuah@kernel.org,
	brauner@kernel.org,
	mszeredi@redhat.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com,
	jain.abhinav177@gmail.com
Subject: [PATCH] selftests: filesystems: add return value checks
Date: Mon, 10 Jun 2024 20:09:09 +0000
Message-Id: <20240610200909.55819-1-jain.abhinav177@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add ksft_exit_fail_msg() return value checks for fchdir() & chroot()
to address the selftests statmount test compile warnings

statmount_test.c:127:2: warning: ignoring return value of ‘fchdir’,
declared with attribute warn_unused_result [-Wunused-result]
  127 |  fchdir(orig_root);
      |  ^~~~~~~~~~~~~~~~~
statmount_test.c:128:2: warning: ignoring return value of ‘chroot’,
declared with attribute warn_unused_result [-Wunused-result]
  128 |  chroot(".");
      |  ^~~~~~~~~~~

Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>
---
 .../filesystems/statmount/statmount_test.c          | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/filesystems/statmount/statmount_test.c b/tools/testing/selftests/filesystems/statmount/statmount_test.c
index e6d7c4f1c85b..b5e1247233b6 100644
--- a/tools/testing/selftests/filesystems/statmount/statmount_test.c
+++ b/tools/testing/selftests/filesystems/statmount/statmount_test.c
@@ -125,8 +125,17 @@ static uint32_t old_root_id, old_parent_id;
 
 static void cleanup_namespace(void)
 {
-	fchdir(orig_root);
-	chroot(".");
+	int ret;
+
+	ret = fchdir(orig_root);
+	if (ret == -1)
+		ksft_exit_fail_msg("changing current directory: %s\n",
+				strerror(errno));
+
+	ret = chroot(".");
+	if (ret == -1)
+		ksft_exit_fail_msg("chroot: %s\n", strerror(errno));
+
 	umount2(root_mntpoint, MNT_DETACH);
 	rmdir(root_mntpoint);
 }
-- 
2.34.1


