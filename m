Return-Path: <linux-kselftest+bounces-35594-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6FBAE348E
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 06:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C67E16D5DE
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 04:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559901CDFD4;
	Mon, 23 Jun 2025 04:55:58 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4D33FFD;
	Mon, 23 Jun 2025 04:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750654558; cv=none; b=L1ST7t5SYnvZvxeMXH0MAci4BqGQJjMuYvAA+AG1Yichbow6HEj/4VU1gg+e/B0kE5Y44ojfzSmqXvScdbDnK8Sm91tfKM5rc5rPp5cquBokJsbLHR9741VDgqBANBdApd0tQmTl5LGQnHrqb/PnubJr+CshmJSfCuNyHv2vb98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750654558; c=relaxed/simple;
	bh=3HdyFmyFWwPodew6rdH05czp91pWASMT2yuPAjJ0Wss=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TG/PN57c0HiGwbGgfo7xPQpacJ1VXZ82AFPYK9TLucqe3yE50DopcQBt3/D9/lqZCW/I9zIUfyASoEDbRupAZDKpMcjXiNi6CBtnEwBJ4byDzw6EuJrPTkEwdfxHDMNVN78Rmd29pe7qycmN3ON+oLSJd5VWqWtrLYL37FauRGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6fafaa60889so22919236d6.3;
        Sun, 22 Jun 2025 21:55:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750654554; x=1751259354;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zi4fwdz+jkLqD78wCtaHsLO9NKQRdW/fZ01b+my+Si4=;
        b=iaMkHkep3AgvAEFgQj40Dzqfg7uyhaxyWj82925OP/8UZtQfpgm18z5hWaWcsxbZRO
         lEjk4XB2YdjZ4vLbde/xA8iDaajcR9kBx3NC0zydnoYIqIp2QZoNKXhgtqL8nljYQ0fz
         C2QuKAybhjSUfMv3gvGzMolKvcPwAdW0S30PXWzpODHes/tyU9dfEtSIZ5+MPBLTE9LN
         VAZWXF3phxm/Ox+tpFzGAAOzq7gvV2KM+7klZJaiS28DvuNTIfEciPTyBLDOpyv9XEBL
         MSupEJWJsudCcKBKFtHSNnfFSTQyvza0uCJx8HdrPLQDEd0+zF6Xa+wAuILf6XwVE98z
         63Yg==
X-Forwarded-Encrypted: i=1; AJvYcCU0uUTPeQ8RjjsxwkEb/YaCyw8rtb8E8UPGrljhjYQRYoiM2lmPzjnRafTn7pSDWfgKffrkTF1+RihO43E=@vger.kernel.org, AJvYcCUwfprBBvcn9zlXVma+g9J0e1KFKQYw5xu3KVEF3VFRyOhdnZUPRT7uZshIZA0vXqDvL9nbdz9FlWvgj6kG+TW7@vger.kernel.org
X-Gm-Message-State: AOJu0YwQZmj1+/iLK5jt4V84O0R/DS8EEltddNPMdycsL33Zdff47nF1
	rfKSpObhTrOIqqSAAExpvDMYqw9XvPFDVzk0LT5IVoR+ky6hpbrCWzeo
X-Gm-Gg: ASbGncv88jBrD20asVkjXEofy9/vjymlS/+5AL4B04eTGUSu367vf0gBNZg7hAdqYuV
	4BadZc2ia5fJHIQs4tneLsB57i0WB6etPCqkyx06TQbpC+hI+aE5XDQFPBQC4+rQWiueL4x0Ssi
	szH/bAJ4zz92sqPANuslWKpu2AJvJvc+xO71VEEsSfAGhNUlaiT7h48BHw4qQnuVVdcVbdV9+zu
	lU8Egs3c/KqllACmJ6Bmkyrzt+JOl3BEbHvSl/VoTlW4VtMAQa8RZTPjevxUyiu/+yP4HoG/MvX
	gtdYHKYQzGSvTDsB+V1BeLvaB35Zcv+n3zX9GfcnFUg2zoBaTFFfOI4YAW7EdN5bUbWKiba8X2N
	JgXv1oZ7YJDG9eXu6ob53Gw==
X-Google-Smtp-Source: AGHT+IFoI5no4RrLNwr/EvLzYW3Ht6iyJDOWgHV92gU1yogKMvM2YGrM6e4sOqyHCq6eO2CcUaDaYQ==
X-Received: by 2002:a05:6214:2463:b0:6fa:cc39:9f with SMTP id 6a1803df08f44-6fd0a5784c6mr204368686d6.32.1750654553852;
        Sun, 22 Jun 2025 21:55:53 -0700 (PDT)
Received: from localhost.localdomain (ip171.ip-51-81-44.us. [51.81.44.171])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd09597409sm40600846d6.105.2025.06.22.21.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 21:55:53 -0700 (PDT)
From: Chen Linxuan <chenlinxuan@uniontech.com>
To: Shuah Khan <shuah@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Chen Linxuan <chenlinxuan@uniontech.com>,
	Jan Kara <jack@suse.cz>
Cc: zhanjun@uniontech.com,
	niecheng1@uniontech.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/filesystems/mount-notify: fix unused unused result warning
Date: Mon, 23 Jun 2025 12:54:11 +0800
Message-ID: <20250623045447.3564143-3-chenlinxuan@uniontech.com>
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


