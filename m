Return-Path: <linux-kselftest+bounces-24545-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5849EA11763
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 03:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78421162B83
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 02:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D443922DFB8;
	Wed, 15 Jan 2025 02:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="N9vqMPRe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326F34206B
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Jan 2025 02:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736908864; cv=none; b=qAT787yvn+EU9MFbNxWBaaO1FWCobWbnM/wzial41efhl2yJgAa+beodojcLCKLzAa5a5WmUnHHYHKgzUcOB33XMg+JQ8IOUsXyYHwS9A5pV5mSamq3M66fX5BplPqnPQhUxYb8ixg8t5oIVewJn04rLfb1GSQ/yJFQ1WFYg/Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736908864; c=relaxed/simple;
	bh=G+K9MvSpAIpwDwMmunI0YSdJnqQJGTJZcC3ONEVxX60=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AjMgDzCilf3jEURCofFYKPKFWhSTaOAB4DmIQgcYAmNWoU2JVL4E+JzbBojY61uPZGoBhKhDns3zSVl6AzEmbEgQHWoDHiXrEz8LnXlv8hU+19c5xX8p9dvdoHgkDSCSfJa2CJuQw2g35u2LEaB6kzd96lIA8sdfpBsaQ99ouS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=N9vqMPRe; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21680814d42so92271545ad.2
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Jan 2025 18:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1736908862; x=1737513662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n+lHU8O3OzxopxeMRFW7AZqN84liiT6mDTuuIRoGMNs=;
        b=N9vqMPRelNsEAHkyRKo7lK/eY6HPffqDkwqLLl9XD08GJblRfKsJKzA+709019O5Zg
         fCTzTkG5qCJKrdSP1NZTC5783REeByOZADHoMnRAfy1MgewDNe6AUPmyvmb3O5+i0PAL
         FSIdFfIGCxXploC4DPx7LPCtiX/lom8JiOdfJOIRYrsnWGlwUYssHiZmof8hCgf9PUcs
         ga7PSF/fnvpO2Z6Ubz/UmZcZWbyN7mUc+t53sd4HWPhJaE5M3tI7uB97SXouLLrTY5l2
         6rIE2Pt/NY+jDZpAW8U422tpJRhCo8sIQzbqeRhDrkBEJOu2i8G/Q+WFwVjci6oC1cfe
         IQRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736908862; x=1737513662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n+lHU8O3OzxopxeMRFW7AZqN84liiT6mDTuuIRoGMNs=;
        b=pvOSLuEC4WCbQZBc1f5NvqYBfh0zmCcwC0SLDi8NOIpxC3k31v66teBE1Fah3SVdHm
         RYS3g7vf7uZZeeIojJNVjMguDbcTujNqc1bIiakVXhFIkYP6oPg+n96mTR8TfqCOihuE
         CXt3EhK1bPacjNWbmcBH5uzoy6FKT0xV+fAHGQOnk3sCvjw2Ap9taR/UDEWcTERsEqLn
         uapOmxqRajbstZcPPRjbVz5fgqQb2VXOwnanUNYds3I17GHt9WnWrEDyMEefQBnS4q+d
         Pw0dw4ovaXvmZErXil5nh/f4Y3FA1LZGX85wkOaBt+kkhBcz+4V/wryGCwKQX2mDd0G0
         y55w==
X-Forwarded-Encrypted: i=1; AJvYcCXaKRQidj+eBadf5TKe/WcOXH66yw7RxwEgR2Fj+lRQpECBSHvywPoLizhLTRcgGXIxuaLky7xaadOg64+26j8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAF2d/qlmpUJPPQWPUncrw9Vk6VvUiYH1TyrjpWGNlweYG+OPw
	oCCzgjdrnOSo4VvMhq5DzV8fxJYFuwN7g4G7wV0ghj5dE4BcH+D39HI+++xz1Ic=
X-Gm-Gg: ASbGncs/aXV/yb8YAoZb4hWMZWs9xnVrpy/0jLoTWhKjC9lVw+PEj64J3FbNOsiu1jX
	Z3ygK8EThxSoptVR8KjaSgCp8W2t7P7EBFdHRZc+PIlLAamDQdvzUwApbw1tcv7TJ6+uklnhG+d
	GpLGz3BsmbVLFW3/8w1vX78L+nzW2v7W5CwRAVDRuc9Kg9FuarFtUdZPqVYjiSug5Omlc56Dnk4
	245zuZcIqqug5kSxhRN2aXYVoiYuwhLI3Ga4/p91De0S4bIPhl0bvAwjLG8zqYnE0PdlqTz32ry
	MYHH4d7GDS/yGvU=
X-Google-Smtp-Source: AGHT+IHRs+ZLjJaMOCMFOSev5yey8o2EV/Ai+cdpqR0LkTXM3ZpNmIhiXmJyiWzASfW23X6Ls0/4fg==
X-Received: by 2002:a05:6a00:4502:b0:724:f86e:e3d9 with SMTP id d2e1a72fcca58-72d21f64f72mr39087001b3a.14.1736908862297;
        Tue, 14 Jan 2025 18:41:02 -0800 (PST)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d40680e67sm8321841b3a.139.2025.01.14.18.40.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Jan 2025 18:41:01 -0800 (PST)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: ajones@ventanamicro.com,
	alexghiti@rivosinc.com,
	andybnac@gmail.com,
	aou@eecs.berkeley.edu,
	charlie@rivosinc.com,
	cleger@rivosinc.com,
	conor.dooley@microchip.com,
	conor@kernel.org,
	corbet@lwn.net,
	cuiyunhui@bytedance.com,
	evan@rivosinc.com,
	jesse@rivosinc.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	samuel.holland@sifive.com,
	shuah@kernel.org
Subject: [PATCH v5 1/3] RISC-V: Enable cbo.clean/flush in usermode
Date: Wed, 15 Jan 2025 10:40:22 +0800
Message-Id: <20250115024024.84365-2-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20250115024024.84365-1-cuiyunhui@bytedance.com>
References: <20250115024024.84365-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enabling cbo.clean and cbo.flush in user mode makes it more
convenient to manage the cache state and achieve better performance.

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/riscv/kernel/cpufeature.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index c0916ed318c2..60d180b98f52 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -30,6 +30,7 @@
 #define NUM_ALPHA_EXTS ('z' - 'a' + 1)
 
 static bool any_cpu_has_zicboz;
+static bool any_cpu_has_zicbom;
 
 unsigned long elf_hwcap __read_mostly;
 
@@ -87,6 +88,8 @@ static int riscv_ext_zicbom_validate(const struct riscv_isa_ext_data *data,
 		pr_err("Zicbom disabled as cbom-block-size present, but is not a power-of-2\n");
 		return -EINVAL;
 	}
+
+	any_cpu_has_zicbom = true;
 	return 0;
 }
 
@@ -944,6 +947,11 @@ void __init riscv_user_isa_enable(void)
 		current->thread.envcfg |= ENVCFG_CBZE;
 	else if (any_cpu_has_zicboz)
 		pr_warn("Zicboz disabled as it is unavailable on some harts\n");
+
+	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_ZICBOM))
+		current->thread.envcfg |= ENVCFG_CBCFE;
+	else if (any_cpu_has_zicbom)
+		pr_warn("Zicbom disabled as it is unavailable on some harts\n");
 }
 
 #ifdef CONFIG_RISCV_ALTERNATIVE
-- 
2.39.2


