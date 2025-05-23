Return-Path: <linux-kselftest+bounces-33555-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 951ADAC19D4
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 03:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECAF91C045AA
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 01:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018B01624C2;
	Fri, 23 May 2025 01:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXkF3ou3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3894C2DCBE1;
	Fri, 23 May 2025 01:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747965271; cv=none; b=hhXcMNLa9nQK111paTnpiiR22Lj6kk6E77ROAnFzs0XvKmTzri1nJykB2tjYpYlftT+nuas96nQfW0/Zfy1bHUJWbEA+stDl9fB4UFaTeT9qqiXEL5uDmuUqvnTh6kcCirDtcw+j4p+GEHW/9twVP6XFZ1+q1Yykg8GcYzaYYy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747965271; c=relaxed/simple;
	bh=yHNn1kpmygwg53ZHi34KtfiW/yfFROg8GODehdXTALE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QNDwIwuTD7ngxkOOWHV/xeKifHyKYtilRvI3SvM26c2nkQjeZ8Dpzxv8xJG3SVM7ca4LOPBOTTTHBgw+dbajZVg6+T/QlutoQE8wlnXOkBs1AUO+yY199eT5t8dwaIzBMzXB/VJl/NE66URWFCsJghTO8SlJNHT06iUkWqaNY04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nXkF3ou3; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a37b5de515so651825f8f.2;
        Thu, 22 May 2025 18:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747965268; x=1748570068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=79V167OlWoOMjxF5WYVMw8k6BQD80P80B7UPNjk48/Q=;
        b=nXkF3ou32sC6OzMu6Ck6l3B0bOM9mxdlwpO9pjU6DE/bpEfpLol62re8PLwymGsDOp
         BrU+nVThOPokVd1hW1ndeP7NLUxBk7FlYPmtfPORQovTXqep8qyufkbg3/NSPLe2WQ9U
         Jy4z9m7cv+DCxZ4+pK3+EGofVJZM8CTTs/7VfMZK8FBdjuCA/MF/8xU5X2Zgn0J8dOu2
         XOn0VPUZ23q3260Acb42DHGwgtgPPLD5V88jNFiWeZkVVtAd5dMmhZU1rXK2wVPZk5wa
         2/2PHb+kwgeB3KaZSPf5+A5raNEushUBt2IKvlf/SEIN7ufdg8x9IZGd4V4c08J3KysW
         Ky/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747965268; x=1748570068;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=79V167OlWoOMjxF5WYVMw8k6BQD80P80B7UPNjk48/Q=;
        b=P36yheaR5U76h09jM+6V7WOMXlEUT6hXTDoeVWscTzLR46oFBnJI9uCsI4/IK7S2Yp
         A8bmmwWvrNQUabjqMwR7hpyZtgW+46W2I7cvExXyVj6ZVt6tMmouwpKKGaqFcGBIeUna
         VD+317kWDQ6Tj+AIVnUbfQDB7Yc9oNqjZXZ9UjTs/YJoHLOwAKtVi8apJ9lj2eL379dW
         anA68QISGcoyZKUmd7JUwm8qCbKcBqhhTjtH7Z+R2degdUNh3dGyogsI/kRpGwYlCuNu
         u1l6MPWaEb6HLcuJMq6A6RP/Ptkfk5KVsObbbHBRW1SrfriBbMraftZnXMwQYlt61MM6
         0pXg==
X-Forwarded-Encrypted: i=1; AJvYcCWYwJf1arJ7Azud7ZX7bejCcF/iE/x/od5Tq1KsSmwkIrsYpePJVj+zcPGP/frdOPKSIyZZ0wddwvpl3jk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0kmSCDY3hZ3T+E/pH8vf4nBUGOpmFVvDGWMFwmBsqyOqLdTP8
	2mnzNmo0QnRVpSQEQQ19bZpFZuxu7LbSHLgwYXSS4iVzZiGTmHHVfeXX61ZdTJb+
X-Gm-Gg: ASbGncsmEUFDC9JKsVU3yKFiBAhcqYT/Csucq8yjqBMEQEIxmfD6dXYOUZuC+J1yO9x
	H9ZXzfB/TFTcnCOK/20OgcLZX4yAFSVv/z9ae6cVHc2McXb29nfMtbzu4ancmI2KsoxWEqknKaP
	fWUihFNby4Eanq6EGpTcTbjT2K7OQFljpxNh3Bt1qCQP/69jmw0FY7dU0/nDF5dfIjX1CER0Uip
	ZqjVAe6Re5buhAnuAvEDsq3VoBXDpLBIxs0qZfTihyNMw7XsIK5Kox3Z5MBhBCH9I1cplo+aTEf
	QxLsdYNBZUwY75VBBFUX8UDK51JmWXPQ5Iou/qkf1CTcJz3C5XmLw5YY8Fvavasw4W7d7AANYv4
	MiCMFxzRavA==
X-Google-Smtp-Source: AGHT+IGP/OcQmZ+8Rez1eXPN6RCO//j5OyG61fsbXNCAyeBF66j+q2Pl5U4WUL+7/oxCe6xrEteKQA==
X-Received: by 2002:a05:600c:350c:b0:442:e0e0:24d with SMTP id 5b1f17b1804b1-44b8cc9bf92mr1760595e9.7.1747965268035;
        Thu, 22 May 2025 18:54:28 -0700 (PDT)
Received: from localhost.localdomain ([156.208.37.0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f1ef032esm130309995e9.9.2025.05.22.18.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 18:54:27 -0700 (PDT)
From: Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>
To: shuah@kernel.org,
	skhan@linuxfoundation.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>
Subject: [PATCH v2] selftests: acct: fix grammar and clarify output messages - Fixed email case mismatch in Signed-off-by
Date: Fri, 23 May 2025 04:54:01 +0300
Message-Id: <20250523015401.9712-1-abdelrahmanfekry375@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch improves the clarity and grammar of output messages in the acct()
selftest. Minor changes were made to user-facing strings and comments to make
them easier to understand and more consistent with the kselftest style.

Changes include:
- Fixing grammar in printed messages and comments.
- Rewording error and success outputs for clarity and professionalism.
- Making the "root check" message more direct.

These updates improve readability without affecting test logic or behavior.

Signed-off-by: Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>
---
 tools/testing/selftests/acct/acct_syscall.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/acct/acct_syscall.c b/tools/testing/selftests/acct/acct_syscall.c
index 87c044fb9293..2c120a527574 100644
--- a/tools/testing/selftests/acct/acct_syscall.c
+++ b/tools/testing/selftests/acct/acct_syscall.c
@@ -22,9 +22,9 @@ int main(void)
 	ksft_print_header();
 	ksft_set_plan(1);
 
-	// Check if test is run a root
+	// Check if test is run as root
 	if (geteuid()) {
-		ksft_exit_skip("This test needs root to run!\n");
+		ksft_exit_skip("This test must be run as root!\n");
 		return 1;
 	}
 
@@ -52,7 +52,7 @@ int main(void)
 	child_pid = fork();
 
 	if (child_pid < 0) {
-		ksft_test_result_error("Creating a child process to log failed\n");
+		ksft_test_result_error("Failed to create child process for logging\n");
 		acct(NULL);
 		return 1;
 	} else if (child_pid > 0) {
-- 
2.25.1


