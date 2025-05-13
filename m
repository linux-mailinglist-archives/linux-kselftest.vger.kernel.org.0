Return-Path: <linux-kselftest+bounces-32918-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28CF5AB5F2C
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 00:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CA317ADDCD
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 May 2025 22:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A9820B1FC;
	Tue, 13 May 2025 22:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TO9JqyCU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB189202C48;
	Tue, 13 May 2025 22:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747174492; cv=none; b=A3jtuqG/8rpLkQ6dzMKiYsQ9KAExLFpmRbA5sQeaN/rwOyu1J+Hlg29Ixb0pnUWZTHExldpC0AP0y2KGn6V2yEwP+VROjdEXSMeqxRJS77DWCoIunjopVir0mXddE/41QzWYW5jgIPUaKf3+ReotNMoNFyKpTTobPs6RN9dexS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747174492; c=relaxed/simple;
	bh=maKoMyNUptWEACg33q1vpy/GSFWTvEqnX6P66Eb3NJE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WMkr9/G7ULCweHEfu+RdrXnx01I7zxnw3Fv2U+TvGdcalYQ2uEgDiJvMMWvLs9m0lhgP7HVltj4APuH6tm9uvWQG1CUMPF629t6lNKMCxEgQANo3ArgiAwCBkI+Rgk+/cPD0pJxHocMErNL1UGH0boVoh448Ip7ViRjRlOmUHfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TO9JqyCU; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a0b3f62d1aso757195f8f.1;
        Tue, 13 May 2025 15:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747174489; x=1747779289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z6twoJszxPLDnRSsZ54kwRwjtDyPeTyb0lPKYWaATxI=;
        b=TO9JqyCU9HhsftWOLKM1s5vaYvUmJPGgcy6aGR2annZ4CpnldgZn6a9mSBVVmV7JFe
         kYaH806cLuie7X/szBMqwb1mw8pAp+gw58tiWnGJziRWEFaYqeUlimk3iz9DTPXYQbeu
         zZK1cFPRo/nE4+wbpnKaz2kvduK/2dx26XXw6lTlREFvYDMFslnM7IvU1e2gGL7ZkHOf
         M/TowDDm8ClBJN7Kyu2jrTjYvQUCQMkkqQjiTsx4xmKf4NKXeK2y1GxunhTXGG0KVRye
         IartBV4tYsgz1nCJpev4euXNu13HA8frZswnm2CR0+L0WovhYYhcF++0GFO7YFbUKsfX
         6HeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747174489; x=1747779289;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z6twoJszxPLDnRSsZ54kwRwjtDyPeTyb0lPKYWaATxI=;
        b=JRj64fKTMQoN+8aUXuDfsjI6gvN4+nLGkKB26sOS3Wc1Ak+UtDpJrZwJBn/C6II0pK
         WlYKgxl5/1lEWJ315A6lrIyi4WhOy2xyh0R9scDD5BQm4rnTkU2YRTLPTOr70KD/MVaU
         i+fovwAv0QeCV4+xYVYqJjLci1ig3Fcm7ZHgKSKmaWryKxPz6NhKg1mafvYokEVQvb/+
         16VzSABsYX2M64hHhC6mfGDZihLtGvYwKvtRapUHzjhj1OHApNNEz41cSVzVVqROCy4e
         U02rIU1FNwYZuk23GIR2+8NXwHvJgQ56FA/PhLd8cagfbrfTK4PtJ/SdjHUI6tqR90jN
         KdZA==
X-Forwarded-Encrypted: i=1; AJvYcCVKW3t99ivbRyNoramkhE+nPgGTy5x2O7iUeTx4a8nSBDk/VZtPLK5JVu7K72is1iJitiekGjyQOa6VcDU=@vger.kernel.org
X-Gm-Message-State: AOJu0YycTKNn34Wth4I/qZIOgexcT6VjngCXpTzdekveQPFBnuoyrEh/
	JIo7YsY0nAuzNZS8tqdUyfJpoH25n2wPer7n0q1pN7c9GnHEsI3P
X-Gm-Gg: ASbGncuhdxuFZkSbqaYi/RsaQFeN9AOEEz3e59kXqPRPUsu5tu9JHSx0C3WYIfH2KB7
	9eEfX/A88MPGSxA2vz2622Gr+Xwe9JCSu2TAYng4+77spID7aDTj8czvEZooj4Wk2Tn2zCyAxgS
	V8TTNwmtAT3hiEJnHRejxfFuL8SY6hgnQdFCf329Fv/MDH4LWj8Q5tjoQNV/mAf+4wiCBCjBsrq
	FYWJS4/aXHv5itfAbvK/pvKLXGpiV0Te+aHzFszoGX5XRsN0Inncahabwt+UxuuTba4j39QBJ1s
	SvFuTVytKHVhO4i+oXXPeWibizHUlm9kTBhlLIKn4PGX6N+qit6oRnIFw9gsP/phpd8zylryLzg
	l5t0Slrqko3/k
X-Google-Smtp-Source: AGHT+IHgrMjW9Ba1gwxGTJLcFIR6YYXzawIfwNKz16y8Eau2B+r2Bk5p9TNdYT7x/IbG5+ngKJe5SQ==
X-Received: by 2002:a05:6000:240a:b0:3a2:133:b1a4 with SMTP id ffacd0b85a97d-3a3499454c3mr257125f8f.13.1747174488910;
        Tue, 13 May 2025 15:14:48 -0700 (PDT)
Received: from localhost.localdomain ([102.44.114.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f3951a97sm3194375e9.23.2025.05.13.15.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 15:14:48 -0700 (PDT)
From: Abdelrahman Fekry <abdelrahmanfekry375@gmail.com>
X-Google-Original-From: Abdelrahman Fekry <Abdelrahmanfekry375@gmail.com>
To: shuah@Kernel.org,
	skhan@linuxfoundation.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	Abdelrahman Fekry <Abdelrahmanfekry375@gmail.com>
Subject: [PATCH] selftests: acct: fix grammar and clarify output messages
Date: Wed, 14 May 2025 01:14:26 +0300
Message-Id: <20250513221426.303691-1-Abdelrahmanfekry375@gmail.com>
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

Signed-off-by: Abdelrahman Fekry <Abdelrahmanfekry375@gmail.com>
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


