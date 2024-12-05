Return-Path: <linux-kselftest+bounces-22849-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 293E89E4C83
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 03:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2A92160F35
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 02:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE805183CCA;
	Thu,  5 Dec 2024 02:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="zPbDmK1P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37ED176AC8
	for <linux-kselftest@vger.kernel.org>; Thu,  5 Dec 2024 02:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733367221; cv=none; b=Gcb8GAcdcbgxv+62U1TZUQBtiVfpg0xia6usXw1NikmNXXvGD4rd4RoSWMWgxq88NglxdE0IFrij0Cvf7sGoMClLK4lVUJd3NkIvFofP3DbOO3HBszTiW/SXrKVT9vVA2J9godvjiDhRTDOMPoqjw9xFcpVr+PyFfUPb4wEdM6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733367221; c=relaxed/simple;
	bh=h5pkF7WFsF6QKVOZr0OZCA6MCXRJdUGJ2thXdNkkSus=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Dd8kIYozLJpSVhbhyTadRTrAOlzEGWBVJMLmacMpIsqiNSL1in77JdupRyWPc2L/TOMRjCNMatn1+Obn1gnuC0gJu2ItX3J/PfR3PUwHBqWwCy54qBmMOkT82NAJGSUVHO8irYkhpTsWPskVwD321g6SH1vxQvN/FJR8TW3UnY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=zPbDmK1P; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-215c54e5f24so3477885ad.2
        for <linux-kselftest@vger.kernel.org>; Wed, 04 Dec 2024 18:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1733367219; x=1733972019; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y5i2W/fX0uIIT+J5MfXCDS794yT/hd4XA/lGS5kDrh8=;
        b=zPbDmK1PDYrvD/d1U7IofH5xeW6hmcFbFFIk6qU0yHAeRtlOrUeAQ20vnSQZmu/RlN
         TA88ovcPl7FzN4/4XjIzU8N/b2ddq3P0NJGXE8XsJ6zvA1YjRX9Z6DX8WQXbXayoOMJk
         xuTA3CbSHxfR2BNbzpyKlNa9s2y3uV7T9AV3Rds8BPakVlWuuzZXJ2IqyjhilbHTYr9e
         zhxwBVXWiTQ5wn7SZsoxrdfcpYPs9PzDla0YnY7tU5OzAo2PCThbGSy+MOOmTgMaW3Pb
         U3dTofuH4z054rE6GrKqU6YcB+L173zNvy5g+eQxi3pz5bPBCix/KoUIZ/9OZd0c/xtO
         Jx7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733367219; x=1733972019;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y5i2W/fX0uIIT+J5MfXCDS794yT/hd4XA/lGS5kDrh8=;
        b=ZPn7iR3LHLhHVtRc3apShISyRvdm0zl6I/Gp9AukaNpUY72birT0XAE3TJoDGX6IZK
         iDRU31d5VR3xIvfEGfVXI+qOABF0agdQPlM7DC1bWidi28G7ckPMH3YZET6OayszXkzc
         gvMlLEI6EvdKtXD8ObTOdZMo5bxhRcy672NjBEgC5ifFWJQAt0ECDuVke6xkdPCCeRp1
         iie5BORvx3cwYFEIwkzjGu/KaXUO30cMyCj71vDD1bYqH0tTs3PuwT4TL7Q7iPIzVQzX
         76qSOSe94NpvvIQQHbAXYabTWBj8J6xQhSR6FLngOrqXZeukoFM5xmkbEPNFNMldVoZ8
         pouw==
X-Gm-Message-State: AOJu0YyYYZRzDtpAh0XCXcJgghL8q5TlVApuR5fSHsHG4zK1+D09hRiP
	Ig9S8j+gVHXAZeS/tXfVw8ugmQPnYhzA3olgzMOfx3rOkT7ySu8OfL+4mhvJO+o=
X-Gm-Gg: ASbGncsH/CmSiWHvqzkgQ1pSMMNkF19ZWkOEahgr0II7uMZteiK13kjO9/jTq20fqeT
	xclIT4FYX2yERceAMo6Zqyhzaz6oWPy5Eu57H9skjUHzYwiU+uU/LvmvrIwuemY0oy13EIR0Ji2
	sVg5BGTq9BmIPPjtahEsAlrVs1nAGBXfjQU4MWkbdRt4ACNJlYGFD/wx41LqCoyWZQJEy1S9/Nj
	FXLLb6g+QZZIejBWGFNNTHIqZiaMBqQ5jbrJiBIQ9Uy5cjDR4aKAS1L2vbyvPMhyQ==
X-Google-Smtp-Source: AGHT+IF0E05Cz0CNGSRzqNmt+I+ohBvI+aYOdKpP0GLbqUbjAZpdOYjCbypomo4HQRAuwyG/o5iD3A==
X-Received: by 2002:a17:903:2442:b0:215:a98c:aabb with SMTP id d9443c01a7336-215bd0e66a5mr135859375ad.24.1733367219179;
        Wed, 04 Dec 2024 18:53:39 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8e62c36sm2468565ad.65.2024.12.04.18.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 18:53:38 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 04 Dec 2024 18:53:28 -0800
Subject: [PATCH] riscv: selftests: Fix warnings pointer masking test
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241204-fix_warnings_pointer_masking_tests-v1-1-ea1e9665ce7a@rivosinc.com>
X-B4-Tracking: v=1; b=H4sIAKcVUWcC/x2N0QrCMAxFf2Xk2ULXVVF/RaSULa1BzEZSVBj79
 4U9ngvnnhUUhVDh3q0g+CWlmQ36UwfjK3NFR5MxBB9iH3x0hf7pl4WJq6ZlJm4o6ZP1bUNqqE3
 dcL14jGU4x3ADO1oEzToij+e27SDGsaZ0AAAA
To: Shuah Khan <shuah@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Samuel Holland <samuel.holland@sifive.com>
Cc: linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2409; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=h5pkF7WFsF6QKVOZr0OZCA6MCXRJdUGJ2thXdNkkSus=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ3qg6MoFCz3CMjK6WW9+Xj7vzKoNdvv6WxY//7S91L3LQ
 fve+dW6HaUsDGIcDLJiiiw81xqYW+/olx0VLZsAM4eVCWQIAxenAEyk3ozhf7klwyeXpJcfj+S0
 X121KjA9Lpf1y9ZW3ZyL5p3/Tj6bas7IcEDHblf3zqw9WfE7GXaWXpL7s/DgNf7JpQ5ejlbvv31
 7ywUA
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
 tools/testing/selftests/riscv/abi/pointer_masking.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/riscv/abi/pointer_masking.c b/tools/testing/selftests/riscv/abi/pointer_masking.c
index dee41b7ee3e3..5ae941e9ac73 100644
--- a/tools/testing/selftests/riscv/abi/pointer_masking.c
+++ b/tools/testing/selftests/riscv/abi/pointer_masking.c
@@ -189,6 +189,7 @@ static void test_tagged_addr_abi_sysctl(void)
 {
 	char value;
 	int fd;
+	int ret;
 
 	ksft_print_msg("Testing tagged address ABI sysctl\n");
 
@@ -200,14 +201,24 @@ static void test_tagged_addr_abi_sysctl(void)
 	}
 
 	value = '1';
-	pwrite(fd, &value, 1, 0);
+	ret = pwrite(fd, &value, 1, 0);
+	if (ret != 1) {
+		ksft_test_result_fail("Write to /proc/sys/abi/tagged_addr_disabled failed.\n");
+		return;
+	}
+
 	ksft_test_result(set_tagged_addr_ctrl(min_pmlen, true) == -EINVAL,
 			 "sysctl disabled\n");
 
 	value = '0';
-	pwrite(fd, &value, 1, 0);
-	ksft_test_result(set_tagged_addr_ctrl(min_pmlen, true) == 0,
-			 "sysctl enabled\n");
+	ret = pwrite(fd, &value, 1, 0);
+	if (ret != 2) {
+		ksft_test_result_fail("Write to /proc/sys/abi/tagged_addr_disabled failed.\n");
+		return;
+	}
+
+	ksft_test_result(set_tagged_addr_ctrl(min_pmlen, true) == -EINVAL,
+			 "sysctl disabled\n");
 
 	set_tagged_addr_ctrl(0, false);
 

---
base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
change-id: 20241204-fix_warnings_pointer_masking_tests-3860e4f35429
-- 
- Charlie


