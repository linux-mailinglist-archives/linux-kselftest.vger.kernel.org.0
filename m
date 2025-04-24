Return-Path: <linux-kselftest+bounces-31584-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B794CA9B563
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 19:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F3005A093C
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 17:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5530C29116E;
	Thu, 24 Apr 2025 17:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="1VZgrW3i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BD328E610
	for <linux-kselftest@vger.kernel.org>; Thu, 24 Apr 2025 17:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745516100; cv=none; b=DXb7z0m1drGvSpnRIS3IocfEshXBk9RFtEPHfQl+i9GunIRooAhjSP+vyX5AMtT+SXnGduNsftaHpB8RfCTVZ8UnXZBvMf0MrQ/9dLWSh909L26z41FX5ABamw9vjzV/lHrIUzlZd89aiSx/imPuBg1YST+ogcrtBemh80j4j1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745516100; c=relaxed/simple;
	bh=i5EIv8p28s9SzqwrmxjoQqEJ1yfHwtC674KTF1pprHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jnDCUz7m8t7kak6Mnnv8S2aciUoeXqhYliGfD6osASD8CMsHLSuAMXFM8jXFvfreu3E/nEsMqF1pooTCPbgn+Byzk/HrMxpBVniUm1nSR/XDiTZSidvSqUp03RbT7KK+S2DSypsXVMlu4i5vLw2XQmArAWTeAbnFgEJkUzYQ/HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=1VZgrW3i; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-227cf12df27so13335705ad.0
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Apr 2025 10:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1745516097; x=1746120897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d9V9rr9KXScjB209CCQhOyL2xY7TO+2YEqW9Zt14WVs=;
        b=1VZgrW3ieCTJyupdtrSzNRChjSrTt4vxjboJO3oYPeJCPtFhgXTsz0TdL/sckxV5Cw
         RAoNKuRJjYYlodoeNheGzH959ekAGgr4OS0V4z0DOvR4kUXK25OwlLy71LHSL5tJbFsS
         8NT9wO+qyG/DpBM7Q+qwHKQhjSlKm+BUrxcqhRyte1b+6WmBBw/ohVnOmVlM28vdrVI3
         W3lY377hDMPfCUUrU8YEzEFLPh+iETYA6DEednsSwelK8nO27b2xFxq5ddW3t/Dzo9z8
         90PSicaUF1TZ8EgBeQ8Dt4B7fXd1CyIrc1HcUsLIM+eXII5k7UfeRbmqeEee3k46kZks
         btvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745516097; x=1746120897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d9V9rr9KXScjB209CCQhOyL2xY7TO+2YEqW9Zt14WVs=;
        b=bfRVrNS/CEI/jD/1Jn7dq/m5OmYE1e4Z6gaMdIvQOqIjfQRMlUok99Ur9bFb1s569j
         4QVKYu9IPEIAJFsE1nlmerODG0kcvbEV0maAxsxXfKGpIIsH08WYGSG6W+di+OBDpCOi
         Q3NcZSpJePuYkFN4Q14XRpyVEdCGQUXeLcbCOm6ybA1ZlGDedP13bb24vcDcVuA/3Znb
         1sXL3JMOdZu9EX+6TotDcARGcJnvTRB8/l3m5M9A8hVAhG16m08PidF98u8y6JO0nmNZ
         8QAAuDjncMQz8u+Bnmc6KdE2X7oNNtWDwrt4IEaJl2EP5nJVzL3F4iGF7zKWOfB/wtyR
         RpcA==
X-Forwarded-Encrypted: i=1; AJvYcCVoTu4RNw8lwQkWt6nnU3BmHihyLJRHnTFJLZEOuEZXuqJo4egVqxqDDXRbsvwGUYBOJspV7m/nyMAcQUBMFxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfqWPBch8wBUary38uqpDWnwhx7M+Im6LZ1SqisgyJN/nhCc19
	OyT8fZfFYJN6DvMGQQIUFUS7KpHgxqcvk8t89kWwm6nfi1l6pubkfs+f5b2El/0=
X-Gm-Gg: ASbGncvweLwjCaqYNE13ekc149Z+JWdSn49VYxJlXmiOt3ugRE/bZRCzFc5D5MlZIST
	qcQcCx+bQOeGzh2+G9PQQ0gtHqGozEM86poXRVCepn4bBFf5eD/faGNfLkMX0Ta02+hQgxNv5QN
	VqxVPEuQmg/zRdLg4AArYedR3EU7Gv4lvG/HE2s5mVYzVz9hbtmFcADQmY9DiXODJiL8HnCBwnR
	ncrSQ6wsgTaAKUm/8ETA2cWbheBnwUxXfwDDhepdEe7PUjGlAqDnDcI29DhV+uOCG2HbLIU6DSP
	Cws/Dk7QiwL+0ucFbMVe4diNFbfMRE4B1DYZV8wVcse3qM5nPF5X
X-Google-Smtp-Source: AGHT+IGAQrQw/KilPGjWcs2DXTqeGJNePUSlT3bxzRIay4dKTLJvYkpcmDxPXRgdgSxGOsYJ0V1TjQ==
X-Received: by 2002:a17:903:14b:b0:223:607c:1d99 with SMTP id d9443c01a7336-22db46a3332mr45750265ad.0.1745516097242;
        Thu, 24 Apr 2025 10:34:57 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db5100c4esm16270255ad.173.2025.04.24.10.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 10:34:56 -0700 (PDT)
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
Subject: [PATCH v6 09/14] riscv: misaligned: move emulated access uniformity check in a function
Date: Thu, 24 Apr 2025 19:31:56 +0200
Message-ID: <20250424173204.1948385-10-cleger@rivosinc.com>
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

Split the code that check for the uniformity of misaligned accesses
performance on all cpus from check_unaligned_access_emulated_all_cpus()
to its own function which will be used for delegation check. No
functional changes intended.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/kernel/traps_misaligned.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index e02e9b4b0fc5..410b2e0e0765 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -666,10 +666,20 @@ static int cpu_online_check_unaligned_access_emulated(unsigned int cpu)
 	return 0;
 }
 
-bool __init check_unaligned_access_emulated_all_cpus(void)
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
+bool __init check_unaligned_access_emulated_all_cpus(void)
+{
 	/*
 	 * We can only support PR_UNALIGN controls if all CPUs have misaligned
 	 * accesses emulated since tasks requesting such control can run on any
@@ -677,10 +687,8 @@ bool __init check_unaligned_access_emulated_all_cpus(void)
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
2.49.0


