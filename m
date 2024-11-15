Return-Path: <linux-kselftest+bounces-22118-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC569CF4C8
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 20:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FB5BB2D3A6
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 19:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D013E1D9359;
	Fri, 15 Nov 2024 19:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5B3RBOA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64828153800;
	Fri, 15 Nov 2024 19:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731698252; cv=none; b=ohH3wywhSdn9d+Ck/9VbBvRr1u27bW/Cg8HKIWT9+j5AYVHRwOdp0Prwgm9KhRsNMWyUsIjt3YdJoT1nYWO7DgwWF8Dnu2v/zqgjhiBneHBhCN+vRk9d0hjAr/KPdSimgNYITRDx+nVHbq5+CWPAY6DnE+BrZxDE/z7GeRTrwWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731698252; c=relaxed/simple;
	bh=8koZbwPC2H4bLC9frGSUx9pbezudIhUhODD7e1SHI/I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z0SXJ/8W1F448ishiK2Fxu8X4Na0EXtAe6TgaLa7tGqReehxSkILUWCmR0QfbOC3X0nslhJBXZtq5EKAPj2jwOsflxETkBP8G44w3nfR5LJNNevebElvRjBKSjKqyr0q0W7OIhZpz6fj4AxiEinpXPsSI9UZXHnhzVhwKRzqweM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D5B3RBOA; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7ae3d7222d4so736072a12.3;
        Fri, 15 Nov 2024 11:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731698251; x=1732303051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e0aUmyk+GZprbUmfNA9/OPdlp/BkuZ7LGGSu0baTK0k=;
        b=D5B3RBOAZyz2iqcZ/XyS2Z80wNEkWX1UyfljFvHzTMB2psi0+UCHea2hDUuOU78UfG
         fErh1gENcvelcITM9yXWIlQFB1y+RS7PZIVywMTObNryO3YBBdEw9FY+EStzwgLNfvbm
         nXyOqF1FpXPJdGoubjH829Pi60L4GhUDSSl/m2KLXoLkyLXDt8iY4EoHGSxuhKSJWh9u
         jedNMZl9gfmrc53DGIZ4qTAQS0kG+hvIGDp8z8OlyhlfVC5oX6H8YWXMJbPBg9QInD/h
         I0mUxjISa9uhCHcuKQM3zGmk/aBXLQ9ek3pEjKRVCYuBMU1BqfBBZpKgGjkw3zx8U01c
         8DLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731698251; x=1732303051;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e0aUmyk+GZprbUmfNA9/OPdlp/BkuZ7LGGSu0baTK0k=;
        b=htOoCHYflI0Wd8eur9zxB5HyCOKPIlK67Lqe70Sv44ZrfwyL/Y38VC3JD3wZSOE+4A
         F/x2JSQcWWbDxLxJo8p9prfPA08Oq7huPHl3CgwpmX33le+7Q3/FpZfIy+PKBUo81u0A
         /vzSfQjdV2EtXIUtOOJs0WaFJBEBPczy/cb8E+jX1M/5ubYc/SUVfQzbDaxHyNW7t5Bd
         sR/b8wBF7g3KA4kPusptkChvLMqbJLi7dbBrt7t4eNnowhs604FId9QIGV2vnqwZxY85
         97qsomjT1+KaEF2esNV5Fx3inzECWSHecus6/po3bbH2FlJ5kCz2ChMhB//CMP6omYRU
         1ujQ==
X-Forwarded-Encrypted: i=1; AJvYcCVb1nRN53hDSppxB0QSCJj0igRpLLLOLD3016lugCzuAIF+wMRYgj3CXgUJcltMm6l+pTgEBxF2TWCRs0g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8qzIDGfaNiDdAM9uS3Dhdanu2FL0WC74Agp74wdsjjaNiJ+J7
	fsf88xpQioFX3BeEFbI9CyJ1ChC8kvWgzvxAjt0AzxqdiVf8hRfnk7fp/a6/
X-Google-Smtp-Source: AGHT+IGBvGPvvMltDvpHe8Qj1dm9O9e20uFbsTypjKqOmO0NS9OtLFmAZhfD/tHSrHtA1OKDjysGhA==
X-Received: by 2002:a05:6a20:43ab:b0:1db:e3b6:e4df with SMTP id adf61e73a8af0-1dc90b4bed7mr4604560637.21.1731698250655;
        Fri, 15 Nov 2024 11:17:30 -0800 (PST)
Received: from localhost.localdomain ([116.73.78.102])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7247711d2f0sm1726181b3a.52.2024.11.15.11.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 11:17:30 -0800 (PST)
From: Shivam Chaudhary <cvam0000@gmail.com>
To: shuah@kernel.org,
	abdulrasaqolawani@gmail.com
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shivam Chaudhary <cvam0000@gmail.com>
Subject: [PATCH] selftests: acct: Add ksft_exit_fail if not running as root
Date: Sat, 16 Nov 2024 00:47:21 +0530
Message-ID: <20241115191721.621381-1-cvam0000@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the selftest is not running as root, it should fail and
give an appropriate warning to the user. This patch adds
ksft_exit_fail_msg() if the test is not running as root.

Logs:

Before change:

TAP version 13
1..1
ok 1 # SKIP This test needs root to run!

After change:

TAP version 13
1..1
Bail out! Error : Need to run as root# Planned tests != run tests (1 != 0)
Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: Shivam Chaudhary <cvam0000@gmail.com>
---
 tools/testing/selftests/acct/acct_syscall.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/acct/acct_syscall.c b/tools/testing/selftests/acct/acct_syscall.c
index e44e8fe1f4a3..7c65deef54e3 100644
--- a/tools/testing/selftests/acct/acct_syscall.c
+++ b/tools/testing/selftests/acct/acct_syscall.c
@@ -24,8 +24,7 @@ int main(void)
 
 	// Check if test is run a root
 	if (geteuid()) {
-		ksft_test_result_skip("This test needs root to run!\n");
-		return 1;
+		ksft_exit_fail_msg("Error : Need to run as root");
 	}
 
 	// Create file to log closed processes
-- 
2.45.2


