Return-Path: <linux-kselftest+bounces-31580-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C48CA9B54F
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 19:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9833F1B67811
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 17:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95DE28E5F4;
	Thu, 24 Apr 2025 17:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="vrABEJbx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332DD288CB5
	for <linux-kselftest@vger.kernel.org>; Thu, 24 Apr 2025 17:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745516063; cv=none; b=YKn2D5WjziFISvb4mvJ7/Bq0vAoAjb/eZqJjw5DsOmTWGwurGiWPpx5GiMCIQbXhWF/oPsR3CK84hlhipdK7jXRV1ZJ/OEd/2/A9OhEKktwujvSPZ9h9MEfrlbkoVmlbthMt4sHY2AnsDwiRXYjk8hMTTw0z79oi2hTcfZZGDpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745516063; c=relaxed/simple;
	bh=WFmpbMMF8HntgsLUUpVbwFoU5lFzEDsl21mQjoTPJz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o2kYxs4LWm6n95yXFWdtFM8Qr8x2YNVu/U260WYFTPQWpWyEMAKsmZ3K7YWC8231FmGDo2JS+OWVCqam9IJdqJBZRTlhpzNH4C9R/DW2XvnaQN4aXIRHSWYx+/uPxrXz4N7cWoewPpbGrR1a9Ue+CE9XyPazjPxu+DqmXmop5jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=vrABEJbx; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-22409077c06so21047265ad.1
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Apr 2025 10:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1745516061; x=1746120861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3eGkKF9qJdSzcJjZFaybinwNECXrhVepEnvdsnCoIkY=;
        b=vrABEJbxwBMRtIyYIwPcHH5MTwJ69rs1sdTNR2yrbw3Jv2LN27K5WZ1xO9m0DMeCEt
         eskgkmEtXtjIjgJoBTrVSIN//nCm8uY6IY7uEJaq0lCDhnUSVRqtX5UCLjULMXH95fZ3
         AQVf9p5V/gMwJe+059AV9EAs84DZQFWGF4vQEPinsNuUJG9DGDXVITp/JtDCPOZY7TkL
         IRh3RG1Q5rH+vupKn06ayea4WoHCk4vsw5LjJwGKyJyhshnY8NxJgdkC62cKM7uvrHmr
         X924iIKWJBj2E+ciH878r87l9gi3SWBmxg3OAJ8erl6p2AgwkGqUBB3fRimwOJ6X4jHH
         5pPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745516061; x=1746120861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3eGkKF9qJdSzcJjZFaybinwNECXrhVepEnvdsnCoIkY=;
        b=tzb68AhSS0VhAN+kHTgFwcc785NqNzQRkR4fEamU/KpkwfFgUCu2tCd+F9vbPkD39z
         ZUapJPuhvn+lTEY2cOzmalQLUrxM1jMM0HbIm+btylS4OIsgcz1ar/ecSfZCQhx5iDeo
         hwbB+NPOpMFV0l6/IQoF5cyppqEfcEGp9Rf9PAmNTpQiE9VMGOmhQTF4dFBd2kXdL4Pp
         TLY3GVSuF5wU21jgArhc2q5tipQqBATcZ8PTDU1gmbF2NPooH9pcKOqOt+Cslza/qIvn
         hrT/FP9KuC3jbICOGM7+vsao5Rolo6QHbTfy0uP5nqGHx2Tex1CU2K4jbYFODWoCp51J
         08EQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvm1ivL4YK7fob/UyJcypgvcVB26BbPu3/TCWsFI+heyrZPT6f45uK7ATijpJA9YfBAgrBRKq156OWQqbPGbI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8KblHTl1DxYf1xzJzwr6VO4rmW5OQa0YiPImEKp2PMfKlmrM3
	xh3hCZZsrj1FaOvN23+4Gixa75dK1P+f5aT6eht8YES7kMgVRNcYsVKBnqy4Ieg=
X-Gm-Gg: ASbGncvh2nF6KAR1lJXNwA4rBNZPkmNhknsG2uuDqFcX/t/eNrOqmf1hVHDT7dddfx+
	XW1dNXKPQvEBoA2WiV/hPQyO4+akYz3tylOxXqoTZ2jXqm2kHpnGDkKQdkWyqsZu0VTjw6pLpFk
	nPKcoAgxCYfTDtpvddqgAC1oen/QcbgpIiU1UiTPh72I006yx6R+k0THX8v4Zc3rlXyq/kRdT3v
	nnLmUMptS0ejeraVOEHZm2OMfG8VKTsJd+aNOPyJUX5nC7ctEMY5DXtZU1PxZ7fbnLny9LWGoiu
	A5Ud7C5ErP2WolO74LHniIMBUCLydM7FBytgHyfKIw==
X-Google-Smtp-Source: AGHT+IEs4ew4uugiJtDbQhNEaEfxtdPEFF4bo2T+1eF9T2VcpqRrkFtRa0ffscLhiLfSNXEuYhJu4Q==
X-Received: by 2002:a17:902:db11:b0:223:5a6e:b16 with SMTP id d9443c01a7336-22dbd3f9de4mr5146115ad.5.1745516061340;
        Thu, 24 Apr 2025 10:34:21 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db5100c4esm16270255ad.173.2025.04.24.10.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 10:34:20 -0700 (PDT)
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
	Samuel Holland <samuel.holland@sifive.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v6 05/14] riscv: sbi: add SBI FWFT extension calls
Date: Thu, 24 Apr 2025 19:31:52 +0200
Message-ID: <20250424173204.1948385-6-cleger@rivosinc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250424173204.1948385-1-cleger@rivosinc.com>
References: <20250424173204.1948385-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add FWFT extension calls. This will be ratified in SBI V3.0 hence, it is
provided as a separate commit that can be left out if needed.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/kernel/sbi.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
index d57e4dae7dac..070014ff35d4 100644
--- a/arch/riscv/kernel/sbi.c
+++ b/arch/riscv/kernel/sbi.c
@@ -299,6 +299,8 @@ static int __sbi_rfence_v02(int fid, const struct cpumask *cpu_mask,
 	return 0;
 }
 
+static bool sbi_fwft_supported;
+
 /**
  * sbi_fwft_set() - Set a feature on the local hart
  * @feature: The feature ID to be set
@@ -309,7 +311,15 @@ static int __sbi_rfence_v02(int fid, const struct cpumask *cpu_mask,
  */
 int sbi_fwft_set(u32 feature, unsigned long value, unsigned long flags)
 {
-	return -EOPNOTSUPP;
+	struct sbiret ret;
+
+	if (!sbi_fwft_supported)
+		return -EOPNOTSUPP;
+
+	ret = sbi_ecall(SBI_EXT_FWFT, SBI_EXT_FWFT_SET,
+			feature, value, flags, 0, 0, 0);
+
+	return sbi_err_map_linux_errno(ret.error);
 }
 
 struct fwft_set_req {
@@ -348,6 +358,9 @@ int sbi_fwft_set_cpumask(const cpumask_t *mask, u32 feature,
 		.error = ATOMIC_INIT(0),
 	};
 
+	if (!sbi_fwft_supported)
+		return -EOPNOTSUPP;
+
 	if (feature & SBI_FWFT_GLOBAL_FEATURE_BIT)
 		return -EINVAL;
 
@@ -679,6 +692,11 @@ void __init sbi_init(void)
 			pr_info("SBI DBCN extension detected\n");
 			sbi_debug_console_available = true;
 		}
+		if (sbi_spec_version >= sbi_mk_version(3, 0) &&
+		    sbi_probe_extension(SBI_EXT_FWFT)) {
+			pr_info("SBI FWFT extension detected\n");
+			sbi_fwft_supported = true;
+		}
 	} else {
 		__sbi_set_timer = __sbi_set_timer_v01;
 		__sbi_send_ipi	= __sbi_send_ipi_v01;
-- 
2.49.0


