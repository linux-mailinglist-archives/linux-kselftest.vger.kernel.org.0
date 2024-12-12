Return-Path: <linux-kselftest+bounces-23240-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3479EDFCC
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 08:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EB57188BFC3
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 07:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7564E204C0E;
	Thu, 12 Dec 2024 07:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="wuhCtCa5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4A52054F1
	for <linux-kselftest@vger.kernel.org>; Thu, 12 Dec 2024 07:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733986931; cv=none; b=D9VRp6WRxRIwocVL2PZILIh1iVVUmdqqNvSS+ESsEbNQDHqxAIE6F0CEj99cwOt85OLNQSCl7zXhjTCUG2F+SP9CK0ywlCDwiQI0cWntcLKazL49oGdh9lpKu4gvGquleh3yybUTLa3TGXIfWeiigLV2JCY+WRguwR/MlyWOuR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733986931; c=relaxed/simple;
	bh=oRAcg2/hExWeoK3VTcSjnjMHrzycrG0KO39nZHe9kSA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=eOvEnNrMzkF8rVCtSwC2bLE21/YWY3fhvG+HjXDst6RAYclTCokzIAQiY0D/EUrRTloIw3UW5c4QiN9aGrj1vtTcsmHNVO4nxbw4EbJMTRd0KKuhi/jaxgOvuxJE2lv69IdQAR0LsUHTKHUcfFRQxFQsAJ+giemMujYEFY1ZDes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=wuhCtCa5; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-725ecc42d43so242761b3a.3
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Dec 2024 23:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1733986929; x=1734591729; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OGZhgzI92zZ53/39Sn1Oo9uqJ+TialabZU7b4n5pT6I=;
        b=wuhCtCa5OW6pX4mZfq4Z6ac1xOtE3gcyKXIb/VCKsnbbsTj8+y29I8Ejm97LpLxMxS
         sASqLGf2EO4cdhQXbXpJO6YoM0c/lLGEM2gX4oSwm8H6AnpIPRZb+xvbFYve1KlssxN8
         dJwcK04xtwkG7npVaiN6F6gtUmoxPg8c1lHZgbfr+EU7LKIim9+K0xnSSf1F6ZSVCx0Y
         jX6wTnAZiNuQOKWzaAGQOZfLTElCTLnRKTLoqgeb7G/Hn9CObGrhci4PblSVm012f6uN
         dj0pYCgG8bm2Obm8R1z6EDizEi8RvermjePBmfQHglIhmHNxxQ/h6XYM9f7lii68i3uV
         +3Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733986929; x=1734591729;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OGZhgzI92zZ53/39Sn1Oo9uqJ+TialabZU7b4n5pT6I=;
        b=xHCJ8RGW9D5PNdCB4zIqnSnMjBIx5wAKUFD+Q2jbn7KBHrT1x5qbNutGx3nKmVJ63D
         1yUCLNDyNgjBcGpJeyZ1+WDQbuU11Ee2d/acg7aLRosJqo4jGiiBnO/V5IW9tESulD3z
         C1x7pukF7qYLEUfd4DZLCdXAEHTDJWxGGV4jmqdst56CGP8Osj8KkErrzHwbAARde10S
         asEJqwrmQbgGEIUltpXNZmYwHcBGQF9CG7rFxx2CEAnZjeyrGEEKWa4hD9SQLBgpAmPu
         M0k8/bHVDmE/6BnjgJXbTgufjYjQ+LkCQ6NT+ItAk0vmFzIvQkN7fEw8Y+GyFVPsWf1A
         SAow==
X-Gm-Message-State: AOJu0YyUXMDZAMkJ4JhTcmebIpREARki+eTOGtO1HmgESKmYpjNW2eyi
	pi6KuW0f/eWojDuHuD5QhnVpoOXwsCxfhR6b6gEk+0Qa1Ez1mJctRwOT6XZoAxE=
X-Gm-Gg: ASbGncs6hbvaZftdUTPqzaAZas3Cp1bYKad9RorEt63IIAKZgVTF6deKDipCvfE505Z
	/A8kqjqUIkVGEfZl9ZNXkCqEawtKIaSqh/x570eR4t9AlmE1NY/Uq/Ii0bc16tsYZ6Id4QNrQMn
	9uY8mTZexKQP+FuJErLKYFdXJSoTWpxGpGVwVw9OQuADJyet+hJfjcFuU2KhJuELE4Ze7FMTLf9
	eAo0V8wo76Vi1K6MlapD1mE41kvnto/la4zoS0kCgfY7/jJ+CjEa6QTWW5bL8Va0H0GMSQG
X-Google-Smtp-Source: AGHT+IFVhoqBC+FHK0O0yj4L3ROsxkwQrItwr6XNYnjRPa8c45hGqnxiby8r0RoTiwqRnzYyUk6n5A==
X-Received: by 2002:a05:6a20:d8b:b0:1e0:cc4a:caab with SMTP id adf61e73a8af0-1e1ceae20demr2907188637.19.1733986928653;
        Wed, 11 Dec 2024 23:02:08 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd552c0a6asm5350471a12.63.2024.12.11.23.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 23:02:07 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 11 Dec 2024 23:01:43 -0800
Subject: [PATCH v6] riscv: selftests: Fix warnings pointer masking test
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241211-fix_warnings_pointer_masking_tests-v6-1-c7ae708fbd2f@rivosinc.com>
X-B4-Tracking: v=1; b=H4sIAFaKWmcC/5XQQWrDMBAF0KsErasiyRrJ7qr3KMHY8igZSqQgG
 TUl+O6VswrFi3j5P8z7MHeWMRFm9nG4s4SFMsVQg3k7MHcewgk5TTUzJZSWSmju6db/DClQOOX
 +GinMmPrLkL9r0c+Y58yb1gjUvgGtOlaha8J69Rj5OtZ8pjzH9PvYLHJtd/FFcslxkNgZAw7t8
 JmoxEzBvbt4YetCUftVVVU5euFAdOCh3VCbZxVeUpuqglPtKHxntJg2VL1f1VUVzlocrQLdmg0
 VnlXzkgrrXycwximvLP7/wLIsf6r477gvAgAA
X-Change-ID: 20241204-fix_warnings_pointer_masking_tests-3860e4f35429
To: Shuah Khan <shuah@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Andrew Jones <ajones@ventanamicro.com>, Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3794; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=oRAcg2/hExWeoK3VTcSjnjMHrzycrG0KO39nZHe9kSA=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ3pUV8Y5ae794gckLbey7U68dcarPu/979j780O1XLx+8
 t4SMrjbUcrCIMbBICumyMJzrYG59Y5+2VHRsgkwc1iZQIYwcHEKwESYhRgZXrxw/5qz8mrnrK4F
 mpvXnHG2yeJUfc03i7U4zno+21LOUob/WSePyZ79cthSSVBt+obtc+62r8i//qdzB9Oj600LZgY
 lMgIA
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
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
Changes in v6:
- Add back ksft_test_result() (Samuel)
- Link to v5: https://lore.kernel.org/r/20241206-fix_warnings_pointer_masking_tests-v5-1-ed566c2f27e8@rivosinc.com

Changes in v5:
- No longer skip second pwrite if first one fails
- Use wrapper function instead of goto (Drew)
- Link to v4: https://lore.kernel.org/r/20241205-fix_warnings_pointer_masking_tests-v4-1-0c77eb725486@rivosinc.com

Changes in v4:
- Skip sysctl_enabled test if first pwrite failed
- Link to v3: https://lore.kernel.org/r/20241205-fix_warnings_pointer_masking_tests-v3-1-5c28b0f9640d@rivosinc.com

Changes in v3:
- Fix sysctl enabled test case (Drew/Alex)
- Move pwrite err condition into goto (Drew)
- Link to v2: https://lore.kernel.org/r/20241204-fix_warnings_pointer_masking_tests-v2-1-1bf0c5095f58@rivosinc.com

Changes in v2:
- I had ret != 2 for testing, I changed it to be ret != 1.
- Link to v1: https://lore.kernel.org/r/20241204-fix_warnings_pointer_masking_tests-v1-1-ea1e9665ce7a@rivosinc.com
---
 .../testing/selftests/riscv/abi/pointer_masking.c  | 28 +++++++++++++++++-----
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/riscv/abi/pointer_masking.c b/tools/testing/selftests/riscv/abi/pointer_masking.c
index dee41b7ee3e323150d55523c8acbf3ec38857b87..059d2e87eb1f737caf44f692b239bf3e49c233b4 100644
--- a/tools/testing/selftests/riscv/abi/pointer_masking.c
+++ b/tools/testing/selftests/riscv/abi/pointer_masking.c
@@ -185,8 +185,20 @@ static void test_fork_exec(void)
 	}
 }
 
+static bool pwrite_wrapper(int fd, void *buf, size_t count, const char *msg)
+{
+	int ret = pwrite(fd, buf, count, 0);
+
+	if (ret != count) {
+		ksft_perror(msg);
+		return false;
+	}
+	return true;
+}
+
 static void test_tagged_addr_abi_sysctl(void)
 {
+	char *err_pwrite_msg = "failed to write to /proc/sys/abi/tagged_addr_disabled\n";
 	char value;
 	int fd;
 
@@ -200,14 +212,18 @@ static void test_tagged_addr_abi_sysctl(void)
 	}
 
 	value = '1';
-	pwrite(fd, &value, 1, 0);
-	ksft_test_result(set_tagged_addr_ctrl(min_pmlen, true) == -EINVAL,
-			 "sysctl disabled\n");
+	if (!pwrite_wrapper(fd, &value, 1, "write '1'"))
+		ksft_test_result_fail(err_pwrite_msg);
+	else
+		ksft_test_result(set_tagged_addr_ctrl(min_pmlen, true) == -EINVAL,
+				 "sysctl disabled\n");
 
 	value = '0';
-	pwrite(fd, &value, 1, 0);
-	ksft_test_result(set_tagged_addr_ctrl(min_pmlen, true) == 0,
-			 "sysctl enabled\n");
+	if (!pwrite_wrapper(fd, &value, 1, "write '0'"))
+		ksft_test_result_fail(err_pwrite_msg);
+	else
+		ksft_test_result(set_tagged_addr_ctrl(min_pmlen, true) == 0,
+				 "sysctl enabled\n");
 
 	set_tagged_addr_ctrl(0, false);
 

---
base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
change-id: 20241204-fix_warnings_pointer_masking_tests-3860e4f35429
-- 
- Charlie


