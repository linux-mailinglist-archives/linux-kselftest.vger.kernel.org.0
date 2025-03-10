Return-Path: <linux-kselftest+bounces-28637-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29294A59972
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 16:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 808243A958A
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Mar 2025 15:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F6E222D4D9;
	Mon, 10 Mar 2025 15:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="B6DGJh1z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A7F22D791
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Mar 2025 15:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741619627; cv=none; b=ORKFZthHruvOJ491N6Y2PqCknc4T1PQUkIyTk0gxg7n1qmWxE+fP9iAmi2monMyLm/+4Og5u4F52pBhccbF8XD8uu0NQb3IGRoP24AotFBIQSG6ZvxOgqns9e8G34GX9oK/KWZth8s0hc4NVoH5J12KEOKMlwt93+gFr+nvLRgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741619627; c=relaxed/simple;
	bh=H3PXCUjUDQNq8xHh3lVfD9Ld90vm+7TqlKnnpyNaoKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eq+JfCnT9masFKAD3K5e/nBJR8StJ0LBmVZiQge2C7IVLn0uYOvgRTl57onzwYapweB2MrCYvk8o4REwrqUyQBwb5vewEc5iZlbVSaxvLWcFuw8aJcjNhkxGi19MY+2GeV/HojLBSccxgbr0m8HVJOVzjpMJAeKKp/u0KW58xVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=B6DGJh1z; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22359001f1aso105549495ad.3
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Mar 2025 08:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1741619625; x=1742224425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yCBi+dVMU97ACIzU1KLcK/YVJVSSJGwq4MBxilXjNH4=;
        b=B6DGJh1zHetrwu+X5n9C9trKUGkqoYM2zJNlCOJDqQ0fsOHKobJKOYLLzDQolAt+mI
         itNOoNKYpmtMa56vK1qoaCNOz6IP1J7VRYaUSCVOkiAkKvZgSeod+A9rxQSl75cIWx5M
         J4oOgLL9KVHZD49YUc7aTpbRYgjdVTURzu/c3UW1K1WhmdO3Y69BgV89eqppxOJQ9zMr
         0XZHDj5Su2qYNg/0fMUGbLFJauOKFPwf6uF8cm0lt3LztsrTunpdchDxLUOVPmPKef9X
         bQj9VYaEkOm9jCtpcM4AXfNY/vJq9Fi+vEGaToqvJEVmDbbH9nX6eid3nEFvhlMnk7rv
         34MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741619625; x=1742224425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yCBi+dVMU97ACIzU1KLcK/YVJVSSJGwq4MBxilXjNH4=;
        b=QnCMFPU4da21J0YhF9xTFbXeYELFxlnUSgn8M1A1NP4rraSDyNOSrzn4CzEXH3PWcc
         9qBrrPC7GLiwBp1LnlVEGhOMn+QmPIsprYskUXlGmrgq1i//eoNGjyzszvqvWrJZChcg
         gmEYpbShr0tmIJHmCAmA/q8JqW/1JpZErRF1D2xVd3bnzOrAD2zUqfggr5y2/m4l4pXK
         fp099UQqglJYOZaGrWhPnRSp4POOM2IK7sz/iyG19Qhc+FzBXThT2+ylyFU9I7AhaLEs
         22PLn5lkIT+IX6Biz2fTzvaVe+6bZYK/e/1dhVbvpiAIbIRrPOGMwja76Qpg0v005k/W
         eOKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBlgjxOgRNhgaj+MPtBcqWRsW6/LiOObhpMXU1hU+JWXsNsat+dPPrc6KSXeILE5405i0ZHlOf3rbvBtmDcAw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsIbY4QKDWKUlo6cbX+kITSU4MrzHkO7SHch2YA2/n/ANgicGn
	NrKZB1BjhfB9rCF33NtzBlePG3Y2NnWpuF3g+kQGRzXnZguRKcCfNkG0BQTmyEw=
X-Gm-Gg: ASbGncuv9JhFFZYvGwFZi1yzCwl0K+RyPmaK4YtlvKufLI3lS9BlY0loKvdW8pQsQpF
	QAOqEywZjTcDkQF41j0/7Gbag3I4Dl8icfpOIWeWDMuD6tSo9uSsS6kkLcLpBg+TYHwnN9vKQEB
	y3uTQ5Tjiw+Ag+niRBt2EoDEiPb4JBwmV2rpJGSAPZe5ifhqiWPzC/98x6eYCxo8W1tRim+O0zl
	SfyctDl34pyR7xDYgV+vlqvZSedki3F9CvzuW+njtBxigkkFt3KnXFaB7U+WuLguLaAiflWh/S1
	MOV34Xrf/DyPlnOVzBcIGkzcnLhTdXPgGK0ozWMBZT4iRQ==
X-Google-Smtp-Source: AGHT+IEfHZuAa7IrsxCaNkSR7EwHAs8m2MJ5ac0OEsbyXjAWI9w4OglgcFN0I6P8WNfULj+ZAYb2cg==
X-Received: by 2002:a17:903:283:b0:21f:1bd:efd4 with SMTP id d9443c01a7336-2242888ab0cmr237920295ad.19.1741619625536;
        Mon, 10 Mar 2025 08:13:45 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109e99dfsm79230515ad.91.2025.03.10.08.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 08:13:44 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Shuah Khan <shuah@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v3 07/17] riscv: misaligned: move emulated access uniformity check in a function
Date: Mon, 10 Mar 2025 16:12:14 +0100
Message-ID: <20250310151229.2365992-8-cleger@rivosinc.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250310151229.2365992-1-cleger@rivosinc.com>
References: <20250310151229.2365992-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Split the code that check for the uniformity of misaligned accesses
performance on all cpus from check_unaligned_access_emulated_all_cpus()
to its own function which will be used for delegation check. No
functional changes intended.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
---
 arch/riscv/kernel/traps_misaligned.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index 7fe25adf2539..db31966a834e 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -673,10 +673,20 @@ static int cpu_online_check_unaligned_access_emulated(unsigned int cpu)
 	return 0;
 }
 
-bool check_unaligned_access_emulated_all_cpus(void)
+static bool all_cpus_unaligned_scalar_access_emulated(void)
 {
 	int cpu;
 
+	for_each_online_cpu(cpu)
+		if (per_cpu(misaligned_access_speed, cpu) !=
+		    RISCV_HWPROBE_MISALIGNED_SCALAR_EMULATED)
+			return false;
+
+	return true;
+}
+
+bool check_unaligned_access_emulated_all_cpus(void)
+{
 	/*
 	 * We can only support PR_UNALIGN controls if all CPUs have misaligned
 	 * accesses emulated since tasks requesting such control can run on any
@@ -684,10 +694,8 @@ bool check_unaligned_access_emulated_all_cpus(void)
 	 */
 	on_each_cpu(check_unaligned_access_emulated, NULL, 1);
 
-	for_each_online_cpu(cpu)
-		if (per_cpu(misaligned_access_speed, cpu)
-		    != RISCV_HWPROBE_MISALIGNED_SCALAR_EMULATED)
-			return false;
+	if (!all_cpus_unaligned_scalar_access_emulated())
+		return false;
 
 	unaligned_ctl = true;
 	return true;
-- 
2.47.2


