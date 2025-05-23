Return-Path: <linux-kselftest+bounces-33631-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B67AAAC20EE
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 12:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B6D65026CA
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 10:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124F6237186;
	Fri, 23 May 2025 10:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="yMrtqUMl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7881F229B2A
	for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 10:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747995718; cv=none; b=U9LLTx5PPJrdmQ1ENjUXME1g0CFmSIPT3Jco4ErjPssXo2unui3HaSZ5XS7ZK1EpwJ3Qp/JVuF3rO4wYOcRJ2gAKTjZix3FG+lUpu/O/9Q3UHGdnZ7t5u1aBMI7OXzX3RGgtbAT/jDMxGkHSuwztUhomeEQMSXTc2LpsSvIicnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747995718; c=relaxed/simple;
	bh=MaIrwOKv+YVVxdhE/r+zc5gTHYqZ311Osy8lrbnqATY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FvNIdaBeP10MBQpwZ0LKvQVIXsQhcyMQ1rMMpPI2yDUjd8sGW4NJ7IwZ+eE22TaMqnWKxxZ5L1z8FfStDRSlN7lB54pPGp8C3w+3Qf1Y0btoE5fXk6w1fclmDtl2Q/FEn/w9mddl7xt1oV1gqwGVSrEiRLti4xl0h8YJvztcxOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=yMrtqUMl; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-742b0840d98so5371277b3a.1
        for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 03:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1747995715; x=1748600515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0iF+NUUhZJ5jxYVuPSRzuPMezDiacMrJKv4fNDBdRi4=;
        b=yMrtqUMlz+nxJOf9HsPSzCfSgeQVBPEsX1wp2SxYEMT5QIFZ6VAHO1pj6GnO62LQ0f
         DIHAff2AWzcjxCA2r8kBAOdlhJ9boIswRj/O+BUAkGwZPUGwssQWwZLd/bHfbCc7ytvU
         CrGCLDTUj+iYGk2/GCVfwjrO+W4CdnKsyc3/vTQVHGzUWTWriH5oPJFUn6el4DOruNyD
         I/AB7+e07zmpMO4H/6It1VZz1v7IMIgg/RLV1OeErz7O2mndvqyqjxt/Ujou4nawgB14
         GP6vpgUsaJhcLNi1wnzYfG7v1gUeXOM99XcgrvAJL6zRAKe0ESGRdesOxg6Bs8bnaugL
         MBBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747995715; x=1748600515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0iF+NUUhZJ5jxYVuPSRzuPMezDiacMrJKv4fNDBdRi4=;
        b=YVvFy1a5oUBWvd0WIz34Y3eGl4cswtSEqA37r213jZQkkSJDkC43TkMsHyrqaOJShs
         ag32lbwgAwvrJIJT+Trcv9z3jCysQWXG3mGC87ePC8qP1QzDX9zhmWyAXRibax6vIHMa
         GifxNKB8nW1MM3/j32AVO9TK9A1yJVIAAdrBuep9+uUZcwzQDquacDFKYuV+QKqw4Wv3
         fYTEiV3+jJXLrShqtN92OZndKwHU5wZstBdHOVZ2ffprKVmBvr7d3As3TjTeJtRQeApj
         uT0bh9NXkZHrCxuAYUED7KXN5jlnfk6Gv+yITRxpCSSGsTzMLA6E4u23B80V6ciqDA0d
         xM3w==
X-Forwarded-Encrypted: i=1; AJvYcCUeQCiHOYI67nyrzcz7NgEDu2ZuFhi/R4P8ec4WkT81ShcKyK7YQHwrmBesDTuO6CyEY+rZtbR7JWaicveh3vs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPnicNqp68Fi06BiAVheBTc2uSk8I4357rBd+IxP8M1O8ZCC+H
	i7dz43tCS/OE9pAyl7alJajjboEiZohVxiicOouefZiWChk+2fa3sPIdZculcQgE8qI=
X-Gm-Gg: ASbGncvWE2wXncSqxkHPMu5qU4zDNYs6MFDeWBQGdkcXiw19scNRTMdn1d80K39IFaZ
	gzuffQymnUPFHbB51pBgbe/G7QPiN2DeXxCHU6b5gOqk6HzoCnORqfB2JCTY5/6xSx4vC4e/Djx
	p+MqmwU5JsmIET2gaV5ythx3Q5v9BMwvT1Ay8Lk6jbzq88Njz2Wz8o/1zwFukUzDCGzctcenhPU
	EM2TC8+zMcNPg3n9q1Oy3JLUjQrDM+dh8ev5q2PhrmAWTdhhlCHMgw5CsuaytoFf/XtN9NnBLEd
	4rSh+2VdA64i7Dk4QRa2uuFZqJ7wOeXBPVkCrKvClFD0x2fXDfaJDeO4/kFLEpA=
X-Google-Smtp-Source: AGHT+IGnAPommgiaP/CHramKAPhXT2HV8FVP99uDHVdDg9TxfQgHz5LyukuEd2GDLOcnoMCuXHDtSQ==
X-Received: by 2002:a05:6a00:858f:b0:73e:1566:5960 with SMTP id d2e1a72fcca58-742acd507c1mr36450146b3a.19.1747995715587;
        Fri, 23 May 2025 03:21:55 -0700 (PDT)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9829ce8sm12466688b3a.118.2025.05.23.03.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 03:21:55 -0700 (PDT)
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
	Deepak Gupta <debug@rivosinc.com>,
	Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v8 07/14] riscv: misaligned: use on_each_cpu() for scalar misaligned access probing
Date: Fri, 23 May 2025 12:19:24 +0200
Message-ID: <20250523101932.1594077-8-cleger@rivosinc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250523101932.1594077-1-cleger@rivosinc.com>
References: <20250523101932.1594077-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

schedule_on_each_cpu() was used without any good reason while documented
as very slow. This call was in the boot path, so better use
on_each_cpu() for scalar misaligned checking. Vector misaligned check
still needs to use schedule_on_each_cpu() since it requires irqs to be
enabled but that's less of a problem since this code is ran in a kthread.
Add a comment to explicit that.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/kernel/traps_misaligned.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/traps_misaligned.c b/arch/riscv/kernel/traps_misaligned.c
index 592b1a28e897..34b4a4e9dfca 100644
--- a/arch/riscv/kernel/traps_misaligned.c
+++ b/arch/riscv/kernel/traps_misaligned.c
@@ -627,6 +627,10 @@ bool __init check_vector_unaligned_access_emulated_all_cpus(void)
 {
 	int cpu;
 
+	/*
+	 * While being documented as very slow, schedule_on_each_cpu() is used since
+	 * kernel_vector_begin() expects irqs to be enabled or it will panic()
+	 */
 	schedule_on_each_cpu(check_vector_unaligned_access_emulated);
 
 	for_each_online_cpu(cpu)
@@ -647,7 +651,7 @@ bool __init check_vector_unaligned_access_emulated_all_cpus(void)
 
 static bool unaligned_ctl __read_mostly;
 
-static void check_unaligned_access_emulated(struct work_struct *work __always_unused)
+static void check_unaligned_access_emulated(void *arg __always_unused)
 {
 	int cpu = smp_processor_id();
 	long *mas_ptr = per_cpu_ptr(&misaligned_access_speed, cpu);
@@ -688,7 +692,7 @@ bool __init check_unaligned_access_emulated_all_cpus(void)
 	 * accesses emulated since tasks requesting such control can run on any
 	 * CPU.
 	 */
-	schedule_on_each_cpu(check_unaligned_access_emulated);
+	on_each_cpu(check_unaligned_access_emulated, NULL, 1);
 
 	for_each_online_cpu(cpu)
 		if (per_cpu(misaligned_access_speed, cpu)
-- 
2.49.0


