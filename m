Return-Path: <linux-kselftest+bounces-39165-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABC3B291E1
	for <lists+linux-kselftest@lfdr.de>; Sun, 17 Aug 2025 08:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B64717A235
	for <lists+linux-kselftest@lfdr.de>; Sun, 17 Aug 2025 06:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E41236A73;
	Sun, 17 Aug 2025 06:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+1avdbs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A3E1C862E;
	Sun, 17 Aug 2025 06:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755412986; cv=none; b=X2mNg6BYZXBbtfEAEhXubXoM0zXJ/U+lwLQ73CsLHxJOhMCnT1WreYyoF6ZOfuoLK58OxwwCk/QaCHpVwwds4H+PaOiidsnbg4KnkJtKwPxo+JwLCNLMkJDl4r3y+6B4/nGKH3OU2H5W1X/SRy71ipslRaaQ/CCcqFmip2ozGBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755412986; c=relaxed/simple;
	bh=G8Ws5RAlLtsmmnqiyaRHoQ795zsH/Uilo1vRqCFghj8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kWKbWwu7jyxr8YPRUjq7UrpfhLhng+8WFQFDtOh92ADyWGGralP4uDq1iiHDsNgT/9P4ziE+8zgOHmW9X6zWkb1u0voHnnErNIELhKOyslL3QsCaaCGi07UBfQInHhR4sN9Yo75BRV/rGCYwhOo7qZpLl7Cauk5N+vf/Hc984mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+1avdbs; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-76e2eb49b83so1874187b3a.3;
        Sat, 16 Aug 2025 23:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755412984; x=1756017784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YQfQftWule41oW8gXo5dyeqZg4dowgHJFmWaCWcJmwU=;
        b=G+1avdbsOFZ6kVEkDFsIOX/V0FgiFWas/gLcDMpm9Uicou2XKcEYuStW45THt+ASAF
         PT84X/blJh0stYcDQeankmv2idogR1o1Kev/iOUVn3nHg2c3UEw0YU8Z086xvJYu8wSn
         zkosFkbk1FEQfFTGeQDv6qEc8s4/uvWv9t65dGM8PoAHxxLVwELfrcGPAeFrpcIm2pEj
         UktYYjJ4fOEoPsYoPiGJdPSNPe59QoWIiqxh66a7DTq5FGdMHL95BJYsz8EslVsiRNHh
         v3TQU8SkFRI+Y0GtkIUqyGz6KzM03k7Po0w2MNC29oUZMHSJUrE/GWpCYLM+PSq1O+dI
         glTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755412984; x=1756017784;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YQfQftWule41oW8gXo5dyeqZg4dowgHJFmWaCWcJmwU=;
        b=f2xPxYYDbiqLEf3X/mDDZhNUBIhTBNQOx2gixLFoXBKo++QTeUigAhhbR8eQOV7qnN
         tZtifPePWM07/PD4Mffazn3Ui9Y0KfY6v5jkIlZ+7FM2UikRWBHHIgXh4JtKIkfGZMKd
         HOiieDjLj4usKLXjJ52pFOY8BymZm7+KC5FV/AAMDE/X3giH/VE6AecqBr5klwlQiN8N
         VWFmfGUr+b+/4PXI//QDA8a2kE5o19oNuRQsBZBnTPbIk5aqOhDMa0FPE62dEqeGz1/w
         fiD34ZkqaAfybdailawYUBXK+fxMOtmlh5zCGtwsN1RE6DKFqQywnSaZXw5j+InPwnDQ
         JARA==
X-Forwarded-Encrypted: i=1; AJvYcCWWfts6SyM0exiPQTUG3qhIohEStImvEZ9sCnXNuKfns1biWYHRP0UuQYRWuhkbPGcauNV0KqVYXLitO4E=@vger.kernel.org, AJvYcCXaCelrv5mKU0RmVizStQlzeLKVlcSCyl/2EBYqRhQP7DW1845B/u0cb0kzxFXFFUW1K0tyL4KsUOZsIMAj6IWo@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzad47jO3S9AKHqXh9yPkQdQksBCICzZzM7v2NyhYeUMjax4hW
	a+aCxGljOqAuhhGHmCCQANrviw2waI5wcIEUC6HW2zKECT+ffNepbmxd
X-Gm-Gg: ASbGncu8u9rUW1DlTWZtVywxM0kaehlCr3kPJvtiQbwmx5usuT7WS4prSPJzWutU5lz
	4+AYZMSExRZ+/gQMsYj9n7Wycimv+iPt/fIeect8mpr6bGlLJOpHCrZT96TIHXf2dD7mT1nI3kH
	uS6y9eE68bHwjvucosvPyksQ972jrpX0XSrjxmknF7z0pJFhfjkNm9zamkmAX8cXOe7D2Ft+t9G
	BRsmb7Po1Fm5vVO/kOYneW4sBangGzh8p3N9xWsTdmFy/VhnjbWf0btkr0Jo0j3CZoDM7u53Zkq
	Vs9DZQJWyxS282qg7UUhGofDf8/m7pLeEjEmuzFRbxh90ACp6PR79l0xMBtBbl5KJ2chVq8MVXj
	m55VDdVm8OKIv
X-Google-Smtp-Source: AGHT+IHkOgjEKYt4Y0kIPImqWCxoPi2vjNDJLS8XR9jBrgF31S2z7u4BHsBBJ5zrViphNH/PnLHM3Q==
X-Received: by 2002:a05:6a00:2189:b0:76b:995c:4bb1 with SMTP id d2e1a72fcca58-76e518951f9mr5914611b3a.15.1755412983918;
        Sat, 16 Aug 2025 23:43:03 -0700 (PDT)
Received: from Arch ([103.240.99.207])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e452666a5sm4459306b3a.19.2025.08.16.23.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 23:43:03 -0700 (PDT)
From: Ayash-Bera <ayashbera@gmail.com>
To: shuah@kernel.org
Cc: kees@kernel.org,
	luto@amacapital.net,
	wad@chromium.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ayash-Bera <ayashbera@gmail.com>
Subject: [PATCH] selftests/seccomp: improve clarity of test messages and comments
Date: Sun, 17 Aug 2025 12:12:52 +0530
Message-ID: <20250817064252.40996-1-ayashbera@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace ambiguous language in comments and test descriptions to improve
code readability and make test intentions clearer.

Changes made:
- Make TODO comment more specific about 64-bit vs 32-bit argument
  handling test requirements  
- Clarify comment about task termination during syscall execution
- Replace vague "bad recv()" with specific "invalid recv() with NULL parameter"
- Replace informal "bad flags" with "invalid flags" for consistency

These improvements help maintainers and contributors better understand
the expected test behavior.

Signed-off-by: Ayash Bera <ayashbera@gmail.com>

---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 61acbd45ffaa..bded07f86a54 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -933,7 +933,7 @@ TEST(KILL_unknown)
 	ASSERT_EQ(SIGSYS, WTERMSIG(status));
 }
 
-/* TODO(wad) add 64-bit versus 32-bit arg tests. */
+/* TODO(wad) add tests for 64-bit versus 32-bit argument handling differences. */
 TEST(arg_out_of_range)
 {
 	struct sock_filter filter[] = {
@@ -3514,7 +3514,7 @@ TEST(user_notification_kill_in_middle)
 	ASSERT_GE(listener, 0);
 
 	/*
-	 * Check that nothing bad happens when we kill the task in the middle
+	 * Check that killing the task in the middle of a syscall does not cause crashes or hangs when we kill the task in the middle
 	 * of a syscall.
 	 */
 	pid = fork();
@@ -3798,7 +3798,7 @@ TEST(user_notification_fault_recv)
 	if (pid == 0)
 		exit(syscall(__NR_getppid) != USER_NOTIF_MAGIC);
 
-	/* Do a bad recv() */
+	/* Test invalid recv() with NULL parameter */
 	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, NULL), -1);
 	EXPECT_EQ(errno, EFAULT);
 
@@ -4169,13 +4169,13 @@ TEST(user_notification_addfd)
 	addfd.id = req.id;
 	addfd.flags = 0x0;
 
-	/* Verify bad newfd_flags cannot be set */
+	/* Verify invalid newfd_flags cannot be set */
 	addfd.newfd_flags = ~O_CLOEXEC;
 	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_ADDFD, &addfd), -1);
 	EXPECT_EQ(errno, EINVAL);
 	addfd.newfd_flags = O_CLOEXEC;
 
-	/* Verify bad flags cannot be set */
+	/* Verify invalid flags cannot be set */
 	addfd.flags = 0xff;
 	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_ADDFD, &addfd), -1);
 	EXPECT_EQ(errno, EINVAL);
-- 
2.50.1


