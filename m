Return-Path: <linux-kselftest+bounces-35595-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE11AE3491
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 06:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36F5E188CE23
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 04:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544571C5D72;
	Mon, 23 Jun 2025 04:57:55 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AAA2FB2;
	Mon, 23 Jun 2025 04:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750654675; cv=none; b=LVJ8fK2vT9s3UH4tiM2pOO2vYvZXKUc00G5RyG6Egn018LV25k5BS4O7xYHmosd1yPuKRsWsOo4IS1wvf8pV6HOPv63ngereSbjSH/xcNI/XVo7bYupfhTuViBa+/UMcFA6MTrOw5SqX682A8vK5wXA/9nYa9gAedx2taJ7Ly4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750654675; c=relaxed/simple;
	bh=3HdyFmyFWwPodew6rdH05czp91pWASMT2yuPAjJ0Wss=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b3RGyRCBwxKGg6MUEqUr0klHArBCryEWE7Bjo1Us6BkdhgKkEKRLvnQOT5YtMJzKP8gPOTqZ6Ahb5xvVME8qNtR0k0QAzdUPJcESmN2fWFqamRvULAnvURzQZDDp0oQuSZHxHmVNl7IW4aPesuwtPcrzdkc9OjzuhqdFIDnTQcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7d38b84984dso770248985a.0;
        Sun, 22 Jun 2025 21:57:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750654671; x=1751259471;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zi4fwdz+jkLqD78wCtaHsLO9NKQRdW/fZ01b+my+Si4=;
        b=NHuuzZoxq2SLenYeWz28+tZ047dg1dWjZY3rWEHOlX2zuoVnjKirDMUJ/xJV1l/mBd
         ai5ibqT1cJIVlseKxge/BWg5WlRdRXZEGX3mjvCBBykICr/QwG478AiutBVZihgw/rz/
         0TtbuZp66DvnY1Xge1xKqMCf2PCqORhD/V1M+ngDeEDo+2OEJb1UayHgCy0L99CKzyYS
         324S10OnGYZfadHNbXZRzOuTPkYehX8RZdrXqpHx+aJes3cRwhsYmLLp6ott/nI/R6gk
         ErcCiw9BkV3A8U9eT4LaDUoqsQopVRYd3gnknZyVq4GwdkE4t7ksuVGqt1FB3xsztltw
         j0nw==
X-Forwarded-Encrypted: i=1; AJvYcCUjNk0TQrcFvfYurSi0fHbqeGIBRHaX6iJGtFVll+w35wZmNnwwIUFBRJsvU6gvVbMh9NL533+27UGmbcc=@vger.kernel.org, AJvYcCVmx0ppgIlLnPIqTLDEdLVwiF7B/XaRwgTTmcz/H6dWmctRGaifZQIBFceNiSpeKLLH6N6lwWVmyY7EP8ujaboE@vger.kernel.org
X-Gm-Message-State: AOJu0YzcJ7XRDD7qDHPAU/xo8sTaqI4e9he8zaYHFqEhApXRWmP7fLXo
	pZW/AyyIZf9j+u8Uqjw1PjWJSsW/04q1TGQPUrPK5JdDGMo4JtETDWyv
X-Gm-Gg: ASbGncuUk7g7ZY1t0GsgPHP1EOJ3esDaxfDEXVXo2Xo9IZvg/OKa9vy6KFWGB0sXYMX
	7FKiUpIit9l5TIv3xsJkiQJJnmV1K0BI8MCuN88lUKvsrY+9v9mLzanw0o5tUnb1jPQb06I3aLT
	N+J2DJXoTN047VEv8BO+ModCIATnXKDd20xIcBgixf2J5VZDOFTiba7chrsFRRSUVtQXehwDFrL
	Tq2c5B6uJDzuE3TkkS/dDjwAdporwR4he66OXeD4sxIhGh0JbsQFa/MOrNw6uwadkt/wisQ+NaD
	siaOghpcSI9Myr8ME8tx8mScpi0gPFXttW8jkQ2l4rbq3nkFzC53ob18zT12UmTDqTPA7X8BJqi
	jhKWmP2jyDu2GdmlE+5SrVQ==
X-Google-Smtp-Source: AGHT+IHDji/DS9MuRgS5GuHLdfabjPuoluHmMree0dbY2yIUn3aj6FTAjr2vjYLUie5Jn705C8OqXw==
X-Received: by 2002:a05:620a:718e:b0:7d4:219:50d4 with SMTP id af79cd13be357-7d402195202mr931998085a.34.1750654671558;
        Sun, 22 Jun 2025 21:57:51 -0700 (PDT)
Received: from localhost.localdomain (ip171.ip-51-81-44.us. [51.81.44.171])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3f99fbea0sm349065485a.98.2025.06.22.21.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 21:57:51 -0700 (PDT)
From: Chen Linxuan <chenlinxuan@uniontech.com>
To: Shuah Khan <shuah@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Jan Kara <jack@suse.cz>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Chen Linxuan <chenlinxuan@uniontech.com>
Cc: zhanjun@uniontech.com,
	niecheng1@uniontech.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] selftests/filesystems/mount-notify: fix unused unused result warning
Date: Mon, 23 Jun 2025 12:56:34 +0800
Message-ID: <20250623045711.3564655-2-chenlinxuan@uniontech.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When running `make kselftest`, the following compilation warning was encountered:

mount-notify_test.c: In function ‘fanotify_rmdir’:
mount-notify_test.c:490:17: warning: ignoring return value of ‘chdir’ declared with attribute ‘warn_unused_result’ [-Wunused-result]
  490 |                 chdir("/");
      |                 ^~~~~~~~~~

Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>
---
Changes in v3:
- Apply changes suggested by Muhammad Usama Anjum
- Link to v2: https://lore.kernel.org/all/20250620035125.2938774-2-chenlinxuan@uniontech.com/
Changes in v2:
- Apply changes suggested by Shuah Khan
- Link to v1: https://lore.kernel.org/all/20250610020758.2798787-2-chenlinxuan@uniontech.com/
---
 .../filesystems/mount-notify/mount-notify_test.c       | 10 +++++-----
 .../filesystems/mount-notify/mount-notify_test_ns.c    | 10 +++++-----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
index 5a3b0ace1a88c..30ed5e00800ba 100644
--- a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
+++ b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test.c
@@ -458,12 +458,12 @@ TEST_F(fanotify, rmdir)
 	ASSERT_GE(ret, 0);
 
 	if (ret == 0) {
-		chdir("/");
-		unshare(CLONE_NEWNS);
-		mount("", "/", NULL, MS_REC|MS_PRIVATE, NULL);
-		umount2("/a", MNT_DETACH);
+		ASSERT_EQ(chdir("/"), 0);
+		ASSERT_EQ(unshare(CLONE_NEWNS), 0);
+		ASSERT_EQ(mount("", "/", NULL, MS_REC | MS_PRIVATE, NULL), 0);
+		ASSERT_EQ(umount2("/a", MNT_DETACH), 0);
 		// This triggers a detach in the other namespace
-		rmdir("/a");
+		ASSERT_EQ(rmdir("/a"), 0);
 		exit(0);
 	}
 	wait(NULL);
diff --git a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c
index d91946e69591a..11a2cfeb1eb94 100644
--- a/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c
+++ b/tools/testing/selftests/filesystems/mount-notify/mount-notify_test_ns.c
@@ -486,12 +486,12 @@ TEST_F(fanotify, rmdir)
 	ASSERT_GE(ret, 0);
 
 	if (ret == 0) {
-		chdir("/");
-		unshare(CLONE_NEWNS);
-		mount("", "/", NULL, MS_REC|MS_PRIVATE, NULL);
-		umount2("/a", MNT_DETACH);
+		ASSERT_EQ(chdir("/"), 0);
+		ASSERT_EQ(unshare(CLONE_NEWNS), 0);
+		ASSERT_EQ(mount("", "/", NULL, MS_REC | MS_PRIVATE, NULL), 0);
+		ASSERT_EQ(umount2("/a", MNT_DETACH), 0);
 		// This triggers a detach in the other namespace
-		rmdir("/a");
+		ASSERT_EQ(rmdir("/a"), 0);
 		exit(0);
 	}
 	wait(NULL);
-- 
2.43.0


