Return-Path: <linux-kselftest+bounces-33907-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C6AAC5E9E
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 03:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A96561BA6594
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 01:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFE03EA63;
	Wed, 28 May 2025 01:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CeisiwWZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F5035946;
	Wed, 28 May 2025 01:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748394539; cv=none; b=tpVtsOiTJQpBn9grdOdm75LZvVZ+dCpwZy7YaVwct0f4afcLk7398C+DmeWhcZzhxmps5H3SE+p/ph4C+vlKk1/iwkmFDx7iMa1TxTbecEtbizPYuk07cuq3OJAaOtZSs3OMfd2hJZny3qVMOu7tRWX/XyVdGc+e88s173jfmZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748394539; c=relaxed/simple;
	bh=RHmhcEGlgpIpqZCuN5g3GCt3XbK7KWAgn3FXaMURsYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nJS45oY4zMaNLwNIq7Q5O2sT+dU5MpiwlvURosP1oZMoEXKKz1D5Gxi0VLH0xE0Yh7/A0FcQBDcA1PLOljGhH/5ukKy7Lvf0TKWDoHUGM3SOuAT7fvOrqKlXbJ3IQ/kK5n0dlnigyannPz20firvg/95nawWutSk/JwnaublXn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CeisiwWZ; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-742c73f82dfso2999648b3a.2;
        Tue, 27 May 2025 18:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748394537; x=1748999337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GLM3hLni2Jj89lFQeYe7kqpyPiECq/X84sxAUjwagJ4=;
        b=CeisiwWZYM3fac0BLqMKz0+D0sm4emj0JrF0lxicF67PASgqiLmBXn5kfSq3itjXqO
         WWg/Y5Hax7++wDKjwhewo1/r/YNaxWnwoMmpQtUkxDyJAP0HLO5ssyMXOzdNHiBbGe7A
         IOuM6kMFa3Kc5SnIiEwyJbZhQWWNPoO3btfWRuG8OWglFoK1uChHJLODzuQbbG3w6n2l
         0O/G2xntdxGsVhLBB3Zx7CFjsFi30YvDUCcloTczgXcMHzgmwvERlcpZE3XLUHFcrfhj
         gqTOKw2j10GmzKnf+6IxLuhxhFnn7rvxmpBzVyti9PWKkX+S3gY97RghpnxdaehKzN3v
         EEpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748394537; x=1748999337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GLM3hLni2Jj89lFQeYe7kqpyPiECq/X84sxAUjwagJ4=;
        b=jz2VP/5VoS2BdJ3t1Q5Cvl7W7hdwlDO/ACMKCju6eRXiENuC+l32XD1bhSYDtfciFT
         UDCTVMLEWPCclXIqAA/qW1srujfHpabhvFiaZEm45G0thH7SqA+tsywGG9FVhG7bfoeF
         8TMY8fV7fUiZb4B2JQmtYo/Zrjhi91ap2DnQjgCFNJ3HAhXoUZEwyXEh2rOnEb/wUhaw
         zZLxMdWyRZj3D0UeuLXP3IKBES1+DLcxhuHTKcrLnha/Q35DZc8F0PAGqzPsvAU/TDzn
         mnyxqLorpzlfG8Xwmoob9uiqMNiR9ZMf5+i7+g5oIlf/Qu/489dJXVpa0/SbLeO3FnYj
         rwfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWX/N9PMYAZqUDAwjhoimWFCvkptKc/+M4BPGB5+3MJctjt45sbL+zIGNgM6sR0swstB91cwKP+tEzKEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLMm4qFCgzm2OZk2U5LuQnQedtPaK+BDxI41pqy3YCBHTO6GbF
	jpp+NNowRqotrzFnj0uiBbOgl2BOPAwj48hYptc9t5q+QfuyEvWfaGdrrbgpJx3pdg==
X-Gm-Gg: ASbGncslozT95Dqw95wxnsXGBpr5XhcDu03foxAFf9RJ87cMZ/VnicgQxEvQT0mbNoT
	eFUKdd1xm0EJLZBa6GcBV9yDWLLMsEdFIESssCVWyIVzJTbhcfJw9hHIvdCfosHWdRti/9heBsz
	DWt35PIFJzyoq4g6EQ1vQhMLCbFm8jP7Yigch8X8jG73+eFwn5sZTD+jjdoF+1gv01bkoLqeyq9
	VXUNfvLA61LEOvufRGlmGAIn+ozurUH4/TWGKHJR2i2odOPFwXxcOM93Z/uN3vB/a3QWaxxM/a9
	AdDuxC3n3zcT4PEXBQ2XhQOKEKSttisCcW8gxu6L0uOsCyWj0ZT0q+dnQeRm5bpib8MoG1mtFEC
	5VAVh41D7mzk=
X-Google-Smtp-Source: AGHT+IHkVqOg9vaQ3pUbeyie0Cfuy9jQWWgN2q5HctZ7ddnSM3cCJNflvehTWlYL2QG6n5LXMXGYVA==
X-Received: by 2002:a05:6a21:1089:b0:216:6060:971d with SMTP id adf61e73a8af0-2188c3b49bemr24082383637.37.1748394536678;
        Tue, 27 May 2025 18:08:56 -0700 (PDT)
Received: from samee-VMware-Virtual-Platform.. ([2409:40c2:117:451b:24c2:65a:a9cc:adaa])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2d99ed9301sm77722a12.71.2025.05.27.18.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 18:08:56 -0700 (PDT)
From: Sameeksha Sankpal <sameekshasankpal@gmail.com>
To: skhan@linuxfoundation.org,
	kees@kernel.org,
	luto@amacapital.net,
	wad@chromium.org,
	shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sameeksha Sankpal <sameekshasankpal@gmail.com>
Subject: [PATCH v2] selftests/seccomp: Improve error logging in get_proc_stat()
Date: Wed, 28 May 2025 06:38:39 +0530
Message-ID: <20250528010839.11594-1-sameekshasankpal@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <202505190816.2A78B3153@keescook>
References: <202505190816.2A78B3153@keescook>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use TH_LOG to report failure when reading /proc/<pid>/stat in
get_proc_stat(), following kernel test framework conventions.

Previously, printf() was used which is discouraged.

Suggested-by: Kees Cook <kees@kernel.org>

Signed-off-by: Sameeksha Sankpal <sameekshasankpal@gmail.com>
---
v1 -> v2:
- Used TH_LOG instead of printf for error logging
- Moved variable declaration to the top of the function
- Applied review suggestion by Kees Cook

 tools/testing/selftests/seccomp/seccomp_bpf.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index d6a85d7b26da..0f12052ef1c7 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -4505,14 +4505,14 @@ static char get_proc_stat(struct __test_metadata *_metadata, pid_t pid)
 	char proc_path[100] = {0};
 	char status;
 	char *line;
+	int rc;
 
 	snprintf(proc_path, sizeof(proc_path), "/proc/%d/stat", pid);
 	ASSERT_EQ(get_nth(_metadata, proc_path, 3, &line), 1);
-	int rc = get_nth(_metadata, proc_path, 3, &line);
-    	if (rc != 1) {
-        	printf("[ERROR] user_notification_fifo: failed to read stat for PID %d (rc=%d)\n", pid, rc);
-    	}
-    	ASSERT_EQ(rc, 1);
+	rc = get_nth(_metadata, proc_path, 3, &line);
+    ASSERT_EQ(rc, 1) {
+		TH_LOG("user_notification_fifo: failed to read stat for PID %d (rc=%d)", pid, rc);
+	}
 	status = *line;
 	free(line);
 
-- 
2.43.0


