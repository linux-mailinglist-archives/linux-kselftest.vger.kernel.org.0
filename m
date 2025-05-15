Return-Path: <linux-kselftest+bounces-33052-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E43B5AB8068
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 10:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EC8B177F55
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 08:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA79C28DB52;
	Thu, 15 May 2025 08:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="FcHH/svy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9056C28A735
	for <linux-kselftest@vger.kernel.org>; Thu, 15 May 2025 08:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747297432; cv=none; b=ZyCRsOQoAgN/zPyImbHz8MHHr6Jlir/sPvuH77LhPrRzjvlF7MBXoveOLxyaV+OhbVrCtEjLe74nv+t+s6OLVYXRbJRnOJ+MyLcDV9LcQdujGmW6gSNzcZOUQnEcTGo9r87Of9uJ/bx/+Ds+ySQ+/3EoQnn0w5Fw4JoWGrXdUy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747297432; c=relaxed/simple;
	bh=IrQydkaY6DjwPRJK+9IUCeQaVW2h03QqX2m5JrkLHsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ge2zKGj7SF1fbMR89C7wbuvoy0ihrzbGDS+pV4E6POuwLhmMKp5s7b99bnBt23wt4UJEs8Hs929vM2VURoFKP6XnUQmZeAMLSfVEEuy+l8xjTOtax/arnWa0Q4SmbkOeRlokhTKlemeAFXohlhdVgxUEFqOgAtZPL0lhWg8F5FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=FcHH/svy; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a1f8c85562so371401f8f.1
        for <linux-kselftest@vger.kernel.org>; Thu, 15 May 2025 01:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1747297429; x=1747902229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JOCKOWdc9Rm9mheK+/kf775/MsCKzvlzcdVw7vqLpnQ=;
        b=FcHH/svyXIzVPxmjz6E+H53OWL+Onrh21R0zhbBna5NB2i+ay4FR4Dv+A1QmprWHgj
         ZMNiC6xrYmz8eDiBxmtgCByHemxlduCT4hgABSEsgsA0xV/efa9GcsQC0Ld3EkUkxiO0
         F7KKMyrRSMSjacHrYnN7OSDBI1ZrGBpzehncjhzG1K54zc+XZMPp52uqL3ud94DDOLaM
         1JeOV6ln6TUOth3iOjczsLzIr5cZxlMVagKRCxQ4/jxvN7g0IReoOJl/LUnwfvtckx2W
         Q/NjNXlpcvIUkxNULgooLXUJBYL0PHrQ68x3KfECe3r42HuSdsm7vyOUbgYneKAVRl6a
         hG6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747297429; x=1747902229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JOCKOWdc9Rm9mheK+/kf775/MsCKzvlzcdVw7vqLpnQ=;
        b=H7hxGyCtmjtB0wIW0DKVJmkVseBnpe2o5AS7vE0cq1aIn/7QBI3wYvxOZJi5FyB837
         gbIHj7Qg9AHINdAfgwCrrspds6joPbLydG56ynk46zAF9tc4SDLBlHWwzgxwRpsp2gzL
         iEseWPRbkTOzUXO5WJpmopLcg2siUehJ7fwkCf+PxCGgI5oAQGproszi8lSxlZMQOBl4
         5N+TVU37wOwubapia34a207zpYXICHVE1Hm/v5zweHBMSBMFOD4SEg1Id6HX+GIMbVPX
         6MTTRBmXBcFmpedtSZ7ADNdE/hYjXXaJPv6f5pTBXb2Z0u6uWBe194vXRtahNrTAnpvI
         xyCw==
X-Forwarded-Encrypted: i=1; AJvYcCWdRaDqP4xG4JR6e9/EK7dO7cWazqJHDkS5eYs1l/USFNuKuGe9FRrmH3INT93IOotLwcxy29YZF10RuPB7KN0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcUidw3uAfPY7enEA1xxLuSvAKq3VeMRCUw1U0caWh4MPEVxyf
	kHVwzazZGP8XUzYPnSql1BxU9LxS9ZzD/jl7oBXVbgtYbMVUJ6toxmdizCNLzWM=
X-Gm-Gg: ASbGncvI9B2OSR7AMZuasML/wSvm9CDjIxSZ28dnPhapo5fcJDaMcHiLY/dHCoFwgKJ
	xExsTKFMl9ANBj7nKZqHptBI3y0Aew78TKntGW6cjlI1AZLFUXdrKNstrjE95wBZVdD5Lh8To/r
	JqGPtPszaJJvI1clAj6/obTXoNhm0BkgPbOOLmS1o8VqkqcmVg8KsH/u8DbBaN8CCH3uF6BSItY
	zMDs1HIge641ZbxCKwRLwI8WjgWQ5UAPn/LGVKcm0OVjqIvKa0T9rgc+ysxi9YQQ+e0RFHRL9XO
	fCrMDgr8xFBNzR/Kpt9zgdzDreO4sv7Rue3hyBkkaf75gXege0c=
X-Google-Smtp-Source: AGHT+IEDgFHO6gLcxW55XNJ4ZpshV/UtxVM8HE5Xz/T24HqOjUp3uFD1+/lwkhut6j4hCuDDjciWCg==
X-Received: by 2002:a05:6000:1ac6:b0:3a1:fd29:b892 with SMTP id ffacd0b85a97d-3a3537b4926mr1265289f8f.49.1747297428847;
        Thu, 15 May 2025 01:23:48 -0700 (PDT)
Received: from carbon-x1.. ([91.197.138.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f395166fsm59310785e9.18.2025.05.15.01.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 01:23:47 -0700 (PDT)
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
	Atish Patra <atishp@rivosinc.com>
Subject: [PATCH v7 04/14] riscv: sbi: add FWFT extension interface
Date: Thu, 15 May 2025 10:22:05 +0200
Message-ID: <20250515082217.433227-5-cleger@rivosinc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250515082217.433227-1-cleger@rivosinc.com>
References: <20250515082217.433227-1-cleger@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This SBI extensions enables supervisor mode to control feature that are
under M-mode control (For instance, Svadu menvcfg ADUE bit, Ssdbltrp
DTE, etc). Add an interface to set local features for a specific cpu
mask as well as for the online cpu mask.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/sbi.h | 17 +++++++++++
 arch/riscv/kernel/sbi.c      | 57 ++++++++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+)

diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
index 0938f2a8d01b..341e74238aa0 100644
--- a/arch/riscv/include/asm/sbi.h
+++ b/arch/riscv/include/asm/sbi.h
@@ -503,6 +503,23 @@ int sbi_remote_hfence_vvma_asid(const struct cpumask *cpu_mask,
 				unsigned long asid);
 long sbi_probe_extension(int ext);
 
+int sbi_fwft_set(u32 feature, unsigned long value, unsigned long flags);
+int sbi_fwft_set_cpumask(const cpumask_t *mask, u32 feature,
+			 unsigned long value, unsigned long flags);
+/**
+ * sbi_fwft_set_online_cpus() - Set a feature on all online cpus
+ * @feature: The feature to be set
+ * @value: The feature value to be set
+ * @flags: FWFT feature set flags
+ *
+ * Return: 0 on success, appropriate linux error code otherwise.
+ */
+static inline int sbi_fwft_set_online_cpus(u32 feature, unsigned long value,
+					   unsigned long flags)
+{
+	return sbi_fwft_set_cpumask(cpu_online_mask, feature, value, flags);
+}
+
 /* Check if current SBI specification version is 0.1 or not */
 static inline int sbi_spec_is_0_1(void)
 {
diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
index 1d44c35305a9..818efafdc8e9 100644
--- a/arch/riscv/kernel/sbi.c
+++ b/arch/riscv/kernel/sbi.c
@@ -299,6 +299,63 @@ static int __sbi_rfence_v02(int fid, const struct cpumask *cpu_mask,
 	return 0;
 }
 
+struct fwft_set_req {
+	u32 feature;
+	unsigned long value;
+	unsigned long flags;
+	atomic_t error;
+};
+
+static void cpu_sbi_fwft_set(void *arg)
+{
+	struct fwft_set_req *req = arg;
+	int ret;
+
+	ret = sbi_fwft_set(req->feature, req->value, req->flags);
+	if (ret)
+		atomic_set(&req->error, ret);
+}
+
+/**
+ * sbi_fwft_set() - Set a feature on the local hart
+ * @feature: The feature ID to be set
+ * @value: The feature value to be set
+ * @flags: FWFT feature set flags
+ *
+ * Return: 0 on success, appropriate linux error code otherwise.
+ */
+int sbi_fwft_set(u32 feature, unsigned long value, unsigned long flags)
+{
+	return -EOPNOTSUPP;
+}
+
+/**
+ * sbi_fwft_set_cpumask() - Set a feature for the specified cpumask
+ * @mask: CPU mask of cpus that need the feature to be set
+ * @feature: The feature ID to be set
+ * @value: The feature value to be set
+ * @flags: FWFT feature set flags
+ *
+ * Return: 0 on success, appropriate linux error code otherwise.
+ */
+int sbi_fwft_set_cpumask(const cpumask_t *mask, u32 feature,
+			       unsigned long value, unsigned long flags)
+{
+	struct fwft_set_req req = {
+		.feature = feature,
+		.value = value,
+		.flags = flags,
+		.error = ATOMIC_INIT(0),
+	};
+
+	if (feature & SBI_FWFT_GLOBAL_FEATURE_BIT)
+		return -EINVAL;
+
+	on_each_cpu_mask(mask, cpu_sbi_fwft_set, &req, 1);
+
+	return atomic_read(&req.error);
+}
+
 /**
  * sbi_set_timer() - Program the timer for next timer event.
  * @stime_value: The value after which next timer event should fire.
-- 
2.49.0


