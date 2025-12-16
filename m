Return-Path: <linux-kselftest+bounces-47601-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6F6CC2451
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Dec 2025 12:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6996A3016BB6
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Dec 2025 11:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8895341AAE;
	Tue, 16 Dec 2025 11:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="inC0fctk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515DB34166B
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Dec 2025 11:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765884765; cv=none; b=qO6mw6YniIBfejBRwxD+o2cvzCVYbH4pD37o0hBQHi2xxKUh3K7VKWlOzhFDAZtv10zCQm524tBuV3oU7kbQ4yyYXI3ZPi6Rat3XvRJSz3MXA+osvKaTjhwecfahQtd+U1PHOCwsOp6t+xmj8rMxlq50MlFiqLjtgGJoinu/zlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765884765; c=relaxed/simple;
	bh=8i1Q4oq+cytJl0IcVUuiEN7sbmcQ3V9vJUtywYQr9Sk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uwqThz/S47CTiFZ2oV9Vo/nBhpbvGdUGBRP+FWT1TgZKFnwm9SK7VDkgwcD9HNiEvl7MtgqOwc6ZRbLtDX3ZXKDxfxrNbPVLXsNNpvRCvO2NEKKP0mD0SaxQkaR9X6debi/b3b+AODdeo23eRsZCgstpwB50XrOBR6SpTjQ3i5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=inC0fctk; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7aae5f2633dso4767181b3a.3
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Dec 2025 03:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765884763; x=1766489563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZZ3tmZ1IHwFtnfG4tSNUz05gU5jSKEuY1R6lKbDLdrU=;
        b=inC0fctk4PbkP6kADsRSNclspaw0RfjsDRquvm3Bejba6ZxYGhQSTlftiMOisfwdAi
         OkXfEAriFqXasOlKY9cHayoDbBN9E2xOlIq0fT6i/BweM103Z9R1tZOHn/VhPYzDyIab
         V1ugx6TVWYqiDI4l0S4Nrdyp8aEbM342N6uBwC0q1cmu0GdJpagZdmAgd8qQV6Nd7FWL
         wvCP9LQvFIr1cu9WONY2zV/AEdXmfN/c98CZ4yjAviJYj1zK+k0BUeoigU7JWJ33z4OL
         Sx5DZeXA3+/Gn97l7SKcAPDu8N1R27R3DgTbeVCsjoBVPWkyWDUkIddVpeUPTdt/N1FO
         aUaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765884763; x=1766489563;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZ3tmZ1IHwFtnfG4tSNUz05gU5jSKEuY1R6lKbDLdrU=;
        b=a/kvK0sv1hGinqQtaJgEBrDYT8IH/GJLJfxU2546rxDZHfxJ/QoMLohLGSDu7coDW4
         AwRBD11uBI2kFD/7lWYN6BQeFq8xl9JnStBvOe1lqADDJdbOTGU+f3iWaCniya491fv3
         O1EKbVVibXtv5bOsEzV7XDP8sLiOm1sfmbp+dVJ4JQiy5a7434dIIbrMBywyC60A3Uvi
         WkYf8bGPpzpDO25yPrV0FinOq7HtlLhToZgW6z1x7BHwdY8Cuens2Ig5E6HZqcroaYqs
         IWVYtHrnNx0fgHowkj6+W3VDFi2vaMa+UQzoIR5nV9bXbMDFLKI1Yaj0pbJwFwsKtBAw
         n7EQ==
X-Gm-Message-State: AOJu0YxA40ev0hMRZo5NNQV/6QPcGkDSEoLbvukayB+lvfytYGFivSkt
	KyT919bpHgvPkbKimzF/1OVvZmZH+Kw/jhvtBjeMZN0rsdpJS6NTEHd6
X-Gm-Gg: AY/fxX5r1SYBVWyGl+XE/E3UhfzcdR/eFt+6F7DBePhLA8vu8aFU0vEwnalnM0vs4Fc
	0NNdH6ioBaY93Zhn7eto1s5lQRusHkqPMitFSL/W9sqc0k71LSVx81YbxpF8SgAb3y3s9VinM6O
	hCYqTt2a+NkzpT1Qw23ozdpPdEr0OKacDJVNJJfuyyplMzzsQl9t+FxVUzPQL8+VrEHhVFXKf0M
	+uVDA6YhrlI+KZtKXWJjEmhQOL//OQEvAmWSjCX0nwc4hKoonZgXO7P8N0RiBkGbz0T2qMTgLC2
	lTWMu6v1LsruFIlgbQKvo/LypdlSTd0loRU5fzwe/j27nPZDon81AHrL8Taem11jGTUPbU81an3
	0hNFL9/Nuvh7IZ3KxRuO6rzIDdtUszT8ChVT2f1mNmw/NA6BT7mcm81ITgWPL+NNS4mbExe904r
	gtkUCURkh4Ng7lE9fi8kO2Qx2gUoDOvFag+1g=
X-Google-Smtp-Source: AGHT+IFHsfLEVVPCBJUNo6ehMO6o3DkxZJTvcaro+U6PBAF85TV3OLtEPW0YkxInyTeBVEV720SCaQ==
X-Received: by 2002:a05:6a00:3007:b0:7e8:450c:61b1 with SMTP id d2e1a72fcca58-7f67156b80amr14130957b3a.33.1765884763520;
        Tue, 16 Dec 2025 03:32:43 -0800 (PST)
Received: from clint-ThinkPad-L14-Gen-2.. ([110.226.180.190])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7f4c22848a7sm15317899b3a.3.2025.12.16.03.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 03:32:43 -0800 (PST)
From: Clint George <clintbgeorge@gmail.com>
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	david.hunter.linux@gmail.com,
	linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	khalid@kernel.org,
	Clint George <clintbgeorge@gmail.com>
Subject: [PATCH] kselftest/anon_inode: replace null pointers with empty arrays
Date: Tue, 16 Dec 2025 17:02:35 +0530
Message-ID: <20251216113235.4896-1-clintbgeorge@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make use of empty (NULL-terminated) array instead of NULL pointer to
avoid compiler errors while maintaining the behavior of the function
intact

Signed-off-by: Clint George <clintbgeorge@gmail.com>
---

[] Testing:
The diff between before and after of running the kselftest test of the
module shows no regression on system with x86 architecture

Let me know if any more testing is needed to be done

[] Error log:
~/Desktop/kernel-dev/linux-v1/tools/testing/selftests/filesystems$ make LLVM=1 W=1
  CC       devpts_pts
  CC       file_stressor
  CC       anon_inode_test
anon_inode_test.c:45:37: warning: null passed to a callee that requires a non-null argument [-Wnonnull]
   45 |         ASSERT_LT(execveat(fd_context, "", NULL, NULL, AT_EMPTY_PATH), 0);
      |                                            ^~~~
/usr/lib/llvm-18/lib/clang/18/include/__stddef_null.h:26:14: note: expanded from macro 'NULL'
   26 | #define NULL ((void*)0)
      |              ^~~~~~~~~~
/home/clint/Desktop/kernel-dev/linux-v1/tools/testing/selftests/../../../tools/testing/selftests/kselftest_harness.h:535:11: note: expanded from macro 'ASSERT_LT'
  535 |         __EXPECT(expected, #expected, seen, #seen, <, 1)
      |                  ^~~~~~~~
/home/clint/Desktop/kernel-dev/linux-v1/tools/testing/selftests/../../../tools/testing/selftests/kselftest_harness.h:758:33: note: expanded from macro '__EXPECT'
  758 |         __typeof__(_expected) __exp = (_expected); \
      |                                        ^~~~~~~~~
1 warning generated.


 tools/testing/selftests/filesystems/anon_inode_test.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/filesystems/anon_inode_test.c b/tools/testing/selftests/filesystems/anon_inode_test.c
index 94c6c81c2..2c4c50500 100644
--- a/tools/testing/selftests/filesystems/anon_inode_test.c
+++ b/tools/testing/selftests/filesystems/anon_inode_test.c
@@ -42,7 +42,10 @@ TEST(anon_inode_no_exec)
 	fd_context = sys_fsopen("tmpfs", 0);
 	ASSERT_GE(fd_context, 0);
 
-	ASSERT_LT(execveat(fd_context, "", NULL, NULL, AT_EMPTY_PATH), 0);
+	char *const empty_argv[] = {NULL};
+	char *const empty_envp[] = {NULL};
+
+	ASSERT_LT(execveat(fd_context, "", empty_argv, empty_envp, AT_EMPTY_PATH), 0);
 	ASSERT_EQ(errno, EACCES);
 
 	EXPECT_EQ(close(fd_context), 0);
-- 
2.43.0


