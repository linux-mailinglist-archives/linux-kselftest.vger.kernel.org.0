Return-Path: <linux-kselftest+bounces-22850-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A179E4C86
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 03:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FCA31649D9
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 02:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A14A188733;
	Thu,  5 Dec 2024 02:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="wZiKSkCN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BC1156F5D
	for <linux-kselftest@vger.kernel.org>; Thu,  5 Dec 2024 02:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733367435; cv=none; b=C0uR/unUZDe3d6uYYdaylyUFJi5sSJc6EpuBVdBqPKN14wgf7yvFr8Mi5iQel2gQgzYqib1yD8UmahAw1hZ1uZHfeVAvKUukalqloJUBFlkK4peN+af/6zzXcA5bXwPR9Ax5Sg6VHLtWbbWBtFwb9JrNjHNZ6DJBWszBc1bwrEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733367435; c=relaxed/simple;
	bh=0kdYtWwDnP1BFgEDmuauQ4kRcQgJT5fkZ+DZ/JMhTyA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=U/JF3ikuwkENo7oik47KyNwpSLIy5hCSBFZb3BsD/n+1Yy1er6eccpyQ698RtnnPinhG1KQAbOZJ8X2aNqsDJVW2BRMW1fWm5tHjWNxrr0HGE66D7K0pE9Kg8y0jwIvXVbwK2/V5/HCC9xUWxyoeCe80ycG5bb0ncMOnN4Q7CJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=wZiKSkCN; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-71d40fdde2fso245333a34.3
        for <linux-kselftest@vger.kernel.org>; Wed, 04 Dec 2024 18:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1733367433; x=1733972233; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ipBWW2dnxGgAKU4Po5grW4q1klpnbh+IbcwsuY+B1d4=;
        b=wZiKSkCNHGlr1TVP4iy9UYrsEDDdHborp25nIvOWHhgH4W08Kplx3LiFavPQNF1eeS
         B9jw8+rxWpthSsajU+kXUrnmXEW2gM5Pl1czv8l1JpUdU49DU3/IBs4n7jvII7bDb8Po
         XV7PHvgz4heI2Rn3mt0S/MtCKcOEYy5Y9KRJAEYeXbgxjSuFiA8EMrEP4/RKOrlefpIV
         hmlp0Jw9Oeosnw6OWBU6tBjn0nysaxlgitX4zCpe6/u5xXOqO4z37ABAg81jzZ+P9WRU
         7bvsepI/eFjLbCd07kESXrXYLgg+DNFXxsj+nF2tIYRPmL6+iY1tieIGWVAE0dDDNV9M
         xLfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733367433; x=1733972233;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ipBWW2dnxGgAKU4Po5grW4q1klpnbh+IbcwsuY+B1d4=;
        b=mcxbrCJefBAS0oSm92DqAK9Y2Zt+gC6VrIgHsC6RxPXQGLH8OUOHLiCOhFrWdV/v30
         WGOoGebAlfQiXN8N5UkytM1RhGFmRqoRIiGyw90LG/VpBOX1RQfvWOdzeV6bxvEzFYwY
         8E9Jcuz3HzFaJKYLuu9hoOg41r3TpIJisBpGRpXfsy8iyyyvdmqg5R63Q3aKAppqrWbU
         b4PD05rNBO3QXLiaUxbOOrXLHOlmzXgTn4QE2R73xjmM+msPrbAZNVgPl0XoBinBvXLP
         KmZb3rucyT8m2ioi72TBbsclybBluo5vR3c9XxuGT5NOxQjxzRS7thS4L58lnosh2jLC
         hyQg==
X-Gm-Message-State: AOJu0YyzBKPHAYUuYUjcpFCS7dWYCv6BBjgWcawTVdEep/Y1ZM+4JHH8
	EBFN8i9iZkZOCJB8VUDKWZhoB4TpPCPjBLjMncEeEw2qrAN9q9IUc18wk2zngSA=
X-Gm-Gg: ASbGncvJxCAJ3UbJdRF+4/LJ3hvhI7SiR6yPttnGHow7hju3qQCkV+G5jAmIiU3XNAo
	CE/gk8Lk/AQvSdrhOlQJ4BopAtt3zk0+8Ovkcf8rNxWbLZdyC8i3N5begDeqRTfMt3dJK/HHYBF
	lH+QR4k6dLN/3NwqsbeEJ1Zs6EkHEVi8RCx1j9ExR0UzRbVmGJ8lOS/HG6WVi1S6IPZjki/Vm4M
	8Uva9z5sSm3TYU5FqKMXH4Ayvawbe+ID0U95dpTQzqe1rtdOUD82tFjF6c1ZXergw==
X-Google-Smtp-Source: AGHT+IFEHWkyCS6LHG+yi34gQLK5jMcjxCLqzFDhxH1oJQf1pgNGxOZbslnPeagR+v0TgGJ8kNbHbQ==
X-Received: by 2002:a05:6830:6016:b0:718:9d30:3c5a with SMTP id 46e09a7af769-71dad5edda4mr11520783a34.2.1733367432913;
        Wed, 04 Dec 2024 18:57:12 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd1568f26asm269581a12.9.2024.12.04.18.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 18:57:12 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 04 Dec 2024 18:57:10 -0800
Subject: [PATCH v2] riscv: selftests: Fix warnings pointer masking test
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241204-fix_warnings_pointer_masking_tests-v2-1-1bf0c5095f58@rivosinc.com>
X-B4-Tracking: v=1; b=H4sIAIYWUWcC/5WNQQ6CMBBFr0K6toaWguLKexjSNHWAiaElM03VE
 O5u9QYu30v++5tgIAQWl2oTBBkZYyigD5XwswsTSLwXFrrWRunayBFf9ukoYJjYrhFDArKL40c
 RNgEnls25q8GMTWt0L0poJSir38ltKDwjp0jv32dWX/tXPiupJDgFfde1Hk7uSpgjY/BHHxcx7
 Pv+Afx+3AbXAAAA
To: Shuah Khan <shuah@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Samuel Holland <samuel.holland@sifive.com>
Cc: linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2606; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=0kdYtWwDnP1BFgEDmuauQ4kRcQgJT5fkZ+DZ/JMhTyA=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ3qgWLsNj3bsWpZHUWmFDRf+m6jKrLVaPXf1Re3UfeFvX
 Bl0nzh0lLIwiHEwyIopsvBca2BuvaNfdlS0bALMHFYmkCEMXJwCMJGeckaGy5E31Z6ZyXT2rDnV
 soktz/XWx30OxXv/KUQ/5P53Y87MDIZ/Gv4nj0isVhPeJ/664rZD2799yYbFnE81f2c6z9NKvqb
 DBQA=
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
Changes in v2:
- I had ret != 2 for testing, I changed it to be ret != 1.
- Link to v1: https://lore.kernel.org/r/20241204-fix_warnings_pointer_masking_tests-v1-1-ea1e9665ce7a@rivosinc.com
---
 tools/testing/selftests/riscv/abi/pointer_masking.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/riscv/abi/pointer_masking.c b/tools/testing/selftests/riscv/abi/pointer_masking.c
index dee41b7ee3e3..229d85ccff50 100644
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
+	if (ret != 1) {
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


