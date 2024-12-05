Return-Path: <linux-kselftest+bounces-22895-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA749E603F
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 22:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64CD3169268
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Dec 2024 21:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8DC1CD208;
	Thu,  5 Dec 2024 21:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Lr0R/22v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9071B87FB
	for <linux-kselftest@vger.kernel.org>; Thu,  5 Dec 2024 21:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733435384; cv=none; b=aK3sRQVPhVUyaKJ4ntgTU4axUUkwBZ7/NWIaGCVD3Ag4k1lUIIv8mNb+fHEcS7HKGoVG1vhKS0/s9dBepBXFRTnh6z7T6PuM6pDvOxnO2P4FOEYeSlwhEbuNWy6x4hMAvnNjZqOcTcP8ytTkhfcsitPM2823MTeReXEXZ0M6SJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733435384; c=relaxed/simple;
	bh=8FnRi21KlrzOAiYqaiv4ehq3t7YDIRIjKXA+qmcuaUE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Un+0gK25nRqzwgr9BSODHWfqh3D0UK9jd7DC29bSH6sF8q0zbbA5FRADPYdLLLonM0rcZH7U1+PhjmUQblwZleQPG3f111AH/tVvq63m+Y9KPFoAvegfPz4mWAMAc7qg+i8jS7GNTuYmc1c0Ok4pyFaeVNO4sXdroBhrjyZXRcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Lr0R/22v; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2153e642114so14029515ad.0
        for <linux-kselftest@vger.kernel.org>; Thu, 05 Dec 2024 13:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1733435380; x=1734040180; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ylsolAa24KJioSknE/TsKey3hUL/pRTv+tYnTAIOBOU=;
        b=Lr0R/22vtsW0zJLXjpi7Nh0FyoBYgopUY4T1UGRy2rBMubgYwIxWlHNrOHCMg3aq/k
         6kZtr1UXMtWgArRBQRgny5+YtD8xGWknTBFe9raPzhYlFlU61NY6PEIWnaVt16bwsKD8
         oZU4teDzB8aRSS4n2NR1jjkAmsL9OJkUewFOYmGw1cqS25zG176wBS8D+MzVIE3pT0tf
         E8m4JQVrmtJkKx0MCelgVM4N2lSWA6yzVRpPnZpLBcCDHKgLxoGeCtKfA44znj8I4acm
         9brlUWb8UdA3dl4ew20vOyaEBbp0AdWb7zXlrm/4DwsoXC2WmWtuaf8d9NUusxNcXOLA
         hIdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733435380; x=1734040180;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ylsolAa24KJioSknE/TsKey3hUL/pRTv+tYnTAIOBOU=;
        b=aeAR0oflgJ9b8k+3XkB8I8L+/iekHlmWCEgRtTkXQ4vedAvEgVRUM66Y87nUIjC0LS
         vwR+iYJcxKMV0PxOym53T/vDrLZSDJ+sRKpBgS4IrbAVyQJ5w68Y0almmLepKtLtPVUB
         dDnq7d/N2Y+OBa++P601u7BemLX3Dmsct4GfhIf5hK4Xk+YNzBwqJz/SJmUfjDaZK5QR
         96/szfagUsCDwzr5DjFzgwGNoHM5xEGWYsdHt9h5/YwWnJ0H2OF7ka2q2+nDJSG2VPAJ
         qRrsAX8ILvVUen+p3Tllji7UnDnpX7XCv4mChGXPxEJqXHJTfFuqtubZIS3x81FhdEV7
         bU6g==
X-Gm-Message-State: AOJu0YxDJhRohLigH6iNMjJ0jAQdz2fMOnn0lDgvTADQQOMMsEEQkR+g
	UyIAVPPhL1esBzAV7HmpUZEGQ6oQ1iwQdOdmDaed8nHbqeZIEUFgq1ApG5dsEgM=
X-Gm-Gg: ASbGncvX7P0W8Supo4/x7JmgcIs5JdWDa96EGXjGWj/1CtsuGZgbKH4mfaYqY7GFcoq
	Jl5BcUCXIniOFgxL9Yci6uX5UzAciKfUm8CCpJo6QLrLu01CwMpkoZitV4cnhJxQ1W0GYAowLeV
	FEETp0K5LKkeOs6xJaC3dzh0QtEk7mpWWfQMIVD8tkXbGJd5wQ6F1ChLtE+2U5Javk6ebbTLB03
	Ef0Ckzfk/sDq0+DZjJ8WDxlfIF4Fhlsk1qMNxDBKM280keYjrPrTfgbs2TQG5UVfA==
X-Google-Smtp-Source: AGHT+IFTb2VVc0pKxcp/N8wkyZ083cyONyg4oc637ROCo07u90M4wR/yDH/PPfe8ZbpGqnrUUyfdNA==
X-Received: by 2002:a17:902:d4ca:b0:215:96bc:b670 with SMTP id d9443c01a7336-21614d3ac68mr5579825ad.18.1733435379862;
        Thu, 05 Dec 2024 13:49:39 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8ef9dafsm16496085ad.120.2024.12.05.13.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 13:49:38 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Thu, 05 Dec 2024 13:49:31 -0800
Subject: [PATCH v4] riscv: selftests: Fix warnings pointer masking test
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241205-fix_warnings_pointer_masking_tests-v4-1-0c77eb725486@rivosinc.com>
X-B4-Tracking: v=1; b=H4sIAOofUmcC/5XNQQrCMBQE0KtI1kaSNKmtK+8hUtL4ox8xKfklK
 qV3N7oScaHLGZg3EyNICMQ2i4klyEgYQwl6uWDuZMMROB5KZkooLZXQ3OOtu9oUMBypGyKGEVJ
 3sXQuRTcCjcSrphagfWW0almBhgRl9TrZ7Us+IY0x3V+fWT7bv/gsueRgJbR1bRys7TZhjoTBr
 Vy8sOdDVv+rqqiy98IZ0Rpvmi9q9a6an9SqqMapphe+rbU4fKjzPD8AG0LWz4MBAAA=
To: Shuah Khan <shuah@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Andrew Jones <ajones@ventanamicro.com>, Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3049; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=8FnRi21KlrzOAiYqaiv4ehq3t7YDIRIjKXA+qmcuaUE=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ3qQ/JtKlok/ngWsEnDPXCFRfe2C1zl5v6oHFxLMZS1EJ
 md/yEjsKGVhEONgkBVTZOG51sDceke/7Kho2QSYOaxMIEMYuDgFYCL5RQx/xVd1fP3e1uLwcYuO
 oUAil+CKPN/D6+qKZ7NY3vhl4hSmzPBPT8vkr5TN5waVDWVTp9ZNZ5h/Z+ZCTuPjs+wUJnvabDz
 KDQA=
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
 tools/testing/selftests/riscv/abi/pointer_masking.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/riscv/abi/pointer_masking.c b/tools/testing/selftests/riscv/abi/pointer_masking.c
index dee41b7ee3e3..759445d5f265 100644
--- a/tools/testing/selftests/riscv/abi/pointer_masking.c
+++ b/tools/testing/selftests/riscv/abi/pointer_masking.c
@@ -189,6 +189,8 @@ static void test_tagged_addr_abi_sysctl(void)
 {
 	char value;
 	int fd;
+	int ret;
+	char *err_pwrite_msg = "failed to write to /proc/sys/abi/tagged_addr_disabled\n";
 
 	ksft_print_msg("Testing tagged address ABI sysctl\n");
 
@@ -200,18 +202,32 @@ static void test_tagged_addr_abi_sysctl(void)
 	}
 
 	value = '1';
-	pwrite(fd, &value, 1, 0);
+	ret = pwrite(fd, &value, 1, 0);
+	if (ret != 1) {
+		ksft_test_result_skip(err_pwrite_msg);
+		goto err_pwrite;
+	}
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
+	ksft_test_result_fail(err_pwrite_msg);
 }
 
 static void test_tagged_addr_abi_pmlen(int pmlen)

---
base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
change-id: 20241204-fix_warnings_pointer_masking_tests-3860e4f35429
-- 
- Charlie


