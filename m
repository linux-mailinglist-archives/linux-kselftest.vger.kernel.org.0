Return-Path: <linux-kselftest+bounces-22893-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DB79E6029
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 22:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E016281AC6
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 21:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8361BD4E5;
	Thu,  5 Dec 2024 21:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="g3Sn6VK7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7563A1BF
	for <linux-kselftest@vger.kernel.org>; Thu,  5 Dec 2024 21:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733434513; cv=none; b=cRacFYYbRDNQPMv+T1y6Yn2SE0i+hT+its5JeT36pIlmwOy+IK3h/5vEzcdCBzS954aE1EAg0IlcE7f1oCXqOM5a2niiV7/sfqwyMx7+f6/gvx0fMMSFB/VOOe7uxJ0K1Cxiq74KICAlp55+qja8aUpa4y0fKZisTCbbNo47FLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733434513; c=relaxed/simple;
	bh=wdD8jAZRCjMd3Gu+Lv3upW2aM9UHvcVExGMABP3l5PM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=TmnD5TwZgueA48WtvGkssJcxbwAzg5nobG/DMS1NEpP87cxsGLyIsIKWDXOfFJ/j0kCBuFCs3W7oXxphBU5c+dvBb8M2tJRjZBhcj3RYx6hE4rRkSIPz5jLmW+MOK4UjBVimGn5FxkM991sEsqnoy/5uFOFXT7enWmL7LegUPZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=g3Sn6VK7; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-215909152c5so16041905ad.3
        for <linux-kselftest@vger.kernel.org>; Thu, 05 Dec 2024 13:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1733434511; x=1734039311; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pwsdH+QfnICBuJ92pYJftuHgr7/FjfSggIF1Mo3ejbQ=;
        b=g3Sn6VK7qJtwuTn3szQtNhrjxs2uxhuaoFWbEJxqtSlpNbtqsVwOOGNnR9RR/OMJmj
         /wyLQMXql4b/2s58QSEO3vBrlzxnRlGBp8FtrJ50V06G45mFRFf2Tnano+P0lCXICbm1
         F6nRVPG1w7+hlhF5UPqZmjGJrduYuFKWeCyUzv6+qzpI2IY/7yzmbAi4c7roJM6FNlhv
         UQRsLYfLDMH1EXljIqAvlEe5OhdhEUl6KCzHAG5j+njQaS+QcxE6FaK1RqJ4hZm+hYNj
         eF+9BOkYIo7xDW9DcGmlTRiUY9lo0+tLCR7ejVFLiLpvH3LBl9Xg/2ctbtLhM9KqSJVX
         18DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733434511; x=1734039311;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pwsdH+QfnICBuJ92pYJftuHgr7/FjfSggIF1Mo3ejbQ=;
        b=SPfmbVh6wBMmJQnxcvJFwJLGqKcL59pQp1zeesbztntpwKA1GIgoR2yVUe28j0KlZB
         hv7PWs9+JgN3K8LJT83vmWZBQXpLAQqyWAaA1XfebbOUKgXd3KMqcm7UUaUgtblt2JnO
         sFuyiiyRJK/4T0M6PYa/698MQlPs5etsPIHjamb/35Gs2t2/Cn/n03t5fPuF1yCbW3sw
         Qpe5c+n4umLJt78kqnMR1WdnRVA110VSWuIOCyq4JcMUfzmw5cg+qQRK3puiZUl1TwRp
         fWkzcJ2dWEo93NY4MKp2SYXVXh6nFyTMGJZZ+aXgyPEbNrb+OUOXyaf+a9YyxkAXsKfc
         SrHA==
X-Gm-Message-State: AOJu0YwuH4C7HfTNumrPUgZmbbUANch8H+XDLuQTZJFAbt3ehZYU9p+p
	GlQG4y4CvoE8/R91hU3J1xjkYCUf1RYxG4Elc6N6gmhBMBFBhcx7bDssRBqGzj8=
X-Gm-Gg: ASbGncskRFr+BCMtzfbDsoJoD45cy9e0CYciXny2AAYRd/Tk6yAMnWwsUNG4EITg4Og
	emzpAJz+/kEvcBk4duHt0MV0UMc9dJQ+5pAdep+4xWSF1Sp1IwzalpwLRiW+Dk8SIUFmyPj/MML
	OxdTMrqd9Mg6dAD3PlvCwtka17AtKzj1ZumSM9OR0oqSxjHDEXCt8CBnsd9YDQC4WQPSEd/yK2E
	6Z8JQrk2Vqjx5eLMDqv+yhBCytl+6on6ENK6vavEQFC4NSsPu4UeVXSj+qziS7a5g==
X-Google-Smtp-Source: AGHT+IGw0B69pcIiyWd5mzMp+7QZEvAdzKCqvYC84V0ko8+KVSirsXGLwn19nZI7HpRamxqVkm4+8A==
X-Received: by 2002:a17:903:110c:b0:215:6f9b:e447 with SMTP id d9443c01a7336-21614db3f47mr6536815ad.30.1733434511348;
        Thu, 05 Dec 2024 13:35:11 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8e3e414sm16857975ad.56.2024.12.05.13.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 13:35:10 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Thu, 05 Dec 2024 13:34:43 -0800
Subject: [PATCH v3] riscv: selftests: Fix warnings pointer masking test
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241205-fix_warnings_pointer_masking_tests-v3-1-5c28b0f9640d@rivosinc.com>
X-B4-Tracking: v=1; b=H4sIAHIcUmcC/5WNwQ6CMBAFf8X0bE1bKIIn/8MYUusCG0NLuk3VE
 P7dwtEbx3nJm5kZQUAgdjnMLEBCQu8yFMcDs4NxPXB8ZmZKqFIqUfIOP+3bBIeup3by6CKEdjT
 0ykMbgSLxoq4ElF2hS9WwLJoC5NcWud0zD0jRh+/WTHJdd+mT5JKDkdBUlbZwNteAyRM6e7J+Z
 Gshqf1Wla3y0QmrRaM7Xf9Zl2X5AUDmzdUtAQAA
To: Shuah Khan <shuah@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Andrew Jones <ajones@ventanamicro.com>, Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2769; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=wdD8jAZRCjMd3Gu+Lv3upW2aM9UHvcVExGMABP3l5PM=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ3qQTFPQcfty272Tki0Tp9hVqomnGGX7rOyL86y7/yaNf
 fN5Hq2OUhYGMQ4GWTFFFp5rDcytd/TLjoqWTYCZw8oEMoSBi1MAJmIgzMiwOLJj3XaT6aty+7UK
 Hu/M+srF3f3i2TzBPw5xLmF8UWd7GP7XRf/XLcy/e0Dgwf7+0zbnVmu8eVK56/itfR/y7CYxVp/
 jBwA=
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

When compiling the pointer masking tests with -Wall this warning
is present:

pointer_masking.c: In function ‘test_tagged_addr_abi_sysctl’:
pointer_masking.c:203:9: warning: ignoring return value of ‘pwrite’
declared with attribute ‘warn_unused_result’ [-Wunused-result]
  203 |         pwrite(fd, &value, 1, 0); |
      ^~~~~~~~~~~~~~~~~~~~~~~~ pointer_masking.c:208:9: warning:
ignoring return value of ‘pwrite’ declared with attribute
‘warn_unused_result’ [-Wunused-result]
  208 |         pwrite(fd, &value, 1, 0);

I came across this on riscv64-linux-gnu-gcc (Ubuntu
11.4.0-1ubuntu1~22.04).

Fix this by checking that the number of bytes written equal the expected
number of bytes written.

Fixes: 7470b5afd150 ("riscv: selftests: Add a pointer masking test")
Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
Changes in v3:
- Fix sysctl enabled test case (Drew/Alex)
- Move pwrite err condition into goto (Drew)
- Link to v2: https://lore.kernel.org/r/20241204-fix_warnings_pointer_masking_tests-v2-1-1bf0c5095f58@rivosinc.com

Changes in v2:
- I had ret != 2 for testing, I changed it to be ret != 1.
- Link to v1: https://lore.kernel.org/r/20241204-fix_warnings_pointer_masking_tests-v1-1-ea1e9665ce7a@rivosinc.com
---
 tools/testing/selftests/riscv/abi/pointer_masking.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/riscv/abi/pointer_masking.c b/tools/testing/selftests/riscv/abi/pointer_masking.c
index dee41b7ee3e3..2367b24a2b4e 100644
--- a/tools/testing/selftests/riscv/abi/pointer_masking.c
+++ b/tools/testing/selftests/riscv/abi/pointer_masking.c
@@ -189,6 +189,7 @@ static void test_tagged_addr_abi_sysctl(void)
 {
 	char value;
 	int fd;
+	int ret;
 
 	ksft_print_msg("Testing tagged address ABI sysctl\n");
 
@@ -200,18 +201,30 @@ static void test_tagged_addr_abi_sysctl(void)
 	}
 
 	value = '1';
-	pwrite(fd, &value, 1, 0);
+	ret = pwrite(fd, &value, 1, 0);
+	if (ret != 1)
+		goto err_pwrite;
+
 	ksft_test_result(set_tagged_addr_ctrl(min_pmlen, true) == -EINVAL,
 			 "sysctl disabled\n");
 
 	value = '0';
-	pwrite(fd, &value, 1, 0);
+	ret = pwrite(fd, &value, 1, 0);
+	if (ret != 1)
+		goto err_pwrite;
+
 	ksft_test_result(set_tagged_addr_ctrl(min_pmlen, true) == 0,
 			 "sysctl enabled\n");
 
 	set_tagged_addr_ctrl(0, false);
 
 	close(fd);
+
+	return;
+
+err_pwrite:
+	close(fd);
+	ksft_test_result_fail("failed to write to /proc/sys/abi/tagged_addr_disabled\n");
 }
 
 static void test_tagged_addr_abi_pmlen(int pmlen)

---
base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
change-id: 20241204-fix_warnings_pointer_masking_tests-3860e4f35429
-- 
- Charlie


