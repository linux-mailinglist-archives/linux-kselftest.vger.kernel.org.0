Return-Path: <linux-kselftest+bounces-9803-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E85B28C12CE
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 18:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CB4628398C
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2024 16:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2C6171E4A;
	Thu,  9 May 2024 16:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="AfQ3C+da"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35690170844
	for <linux-kselftest@vger.kernel.org>; Thu,  9 May 2024 16:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715272071; cv=none; b=udKxm+xFnFhMWHaT4p6lBFuGNYMN+LG0tP6VW0jXxYq3/k9hGFsQWq3HvM/mYfwRVjvS67HFWDhTq2QhXxUIaB92QwWUMHH6H4ket89C4xeND8ZSC0+jp8/UwjRQniCiv37Dr9wbv971y+Yai0oUieD9qxFaNLNpd31QwAIOJ/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715272071; c=relaxed/simple;
	bh=UA+sAfg7J53AaOM6Ue2Iy8Wh+lRWAucEd6oSKKm9RZo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ok7AMFHl9i8EQ9cj/aLAPUOkipFso62fAznqtzFeGaDFpEdCLJ8ymtKNStFgASXfLTkFuCLC0/IHenPfmD8Tnnn3wDVAuHFSVERkvKDA+rXecKCKGT7n7iKLC5wf1zi9avetaYeFdN1vVcFURaMt3nrEPfw3QsOoEmvVRE6y9GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=AfQ3C+da; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e9ffd3f96eso9075895ad.3
        for <linux-kselftest@vger.kernel.org>; Thu, 09 May 2024 09:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1715272068; x=1715876868; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1QNNwCwa8ku9/k6tpLOmcrT1B9BtNzaXfpTEHBEwtaA=;
        b=AfQ3C+dajL7pr/ynLdVlVUex0Lzk19OKwO4bxAmMwR7668gspZZD2qfqzPtQBr5wgE
         1t9RPdQfarE+8Y32IZ4/QwG4btOLcBkEndm8cIRKf/3aCXGcdVv68GpscwVyaHlgvXcN
         zHhKi9OwQYEW+xVl1yZR1NBpSboIGB/WjYuLnEOFOQOQ6FJU8t5UpCdfCJVU3A+SCw3R
         fhw5T4SpfMxf1Y2BIRqMhc7Z15CUef1g2v3Ilt4VxkOLLhgtFnYz0jiXjgtgjIUdkMUm
         90lolNbtzFyXJwcUFQJVDo8JotPoVpfBt1DDqeMWqf0dd+uX6T0Y+Snv+35lDTJzZ3Qv
         H+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715272068; x=1715876868;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1QNNwCwa8ku9/k6tpLOmcrT1B9BtNzaXfpTEHBEwtaA=;
        b=WazWyYhgnLo+dnC66c8+zdKhzVnENBlkXomirZkc/mtwwKYZ+mbaIHqmCe890cF1hr
         Th+xc/uRU5DA2VZeAcM1dS+iHGfZBkC7TIfcXDp9uECF+qVPCLX8fsWlMUc4LVkfH4I6
         20rOPXmTt6aSYw+iv4g1kkm3OX2+IvRywITRDIHRvZW9a6tuZnF/vSpxfJxK4jyPcKmU
         gs3EWUGOnS0IjXYCIs7VmtPchwgeCyJHZa2KWZreUJES3DRrq4l3qjj/VxCu5At6HF5g
         AloS1UX9GzojVn7AS6NvXLrxhk7Yuih0iS9IU8saS9rN1st19c829tIDaARjJ44su0i6
         6iBw==
X-Forwarded-Encrypted: i=1; AJvYcCXzPbKccLTTDrR8ZdQ8KFr4EfGqXvjb9pNG+9bg1KVwdAx37RzlGA0TR3ZFoi10XR3005cQv7OAX/izUicmk/KyH8Hzx+i6tZpoT2cXZr3y
X-Gm-Message-State: AOJu0YzaVeWssDvw8HVh3JtvopjPo6x385cYx0/EuHMEwgV/lsmgKByO
	Uo8ukCWoL1IyAix6Tp6QLfdVp9Qs7bz3Kgb/9B1hGSQAjAuUI6MLHDqlqOvgWKQ=
X-Google-Smtp-Source: AGHT+IF9YLscVKA/v48suhgFjgLq2LEgwRZmAvKPOqejEXCSJdkMF5M4ISIIbOi/4lCzoWr9myCmQQ==
X-Received: by 2002:a17:903:228f:b0:1ed:36dc:a570 with SMTP id d9443c01a7336-1ef44050742mr1707285ad.49.1715272068499;
        Thu, 09 May 2024 09:27:48 -0700 (PDT)
Received: from [127.0.1.1] (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0c13805asm16210285ad.264.2024.05.09.09.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 09:27:48 -0700 (PDT)
From: Andy Chiu <andy.chiu@sifive.com>
Date: Fri, 10 May 2024 00:26:57 +0800
Subject: [PATCH v5 7/8] riscv: vector: adjust minimum Vector requirement to
 ZVE32X
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240510-zve-detection-v5-7-0711bdd26c12@sifive.com>
References: <20240510-zve-detection-v5-0-0711bdd26c12@sifive.com>
In-Reply-To: <20240510-zve-detection-v5-0-0711bdd26c12@sifive.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Conor Dooley <conor.dooley@microchip.com>, Heiko Stuebner <heiko@sntech.de>, 
 Andy Chiu <andy.chiu@sifive.com>, Guo Ren <guoren@kernel.org>, 
 Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Jonathan Corbet <corbet@lwn.net>, Evan Green <evan@rivosinc.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Palmer Dabbelt <palmer@rivosinc.com>, 
 Vincent Chen <vincent.chen@sifive.com>, 
 Greentime Hu <greentime.hu@sifive.com>, devicetree@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Joel Granados <j.granados@samsung.com>
X-Mailer: b4 0.13-dev-a684c

Make has_vector() to check for ZVE32X. Every in-kernel usage of V that
requires a more complicate version of V must then call out explicitly.

Also, change riscv_v_first_use_handler(), and boot code that calls
riscv_v_setup_vsize() to accept ZVE32X.

Most kernel/user interfaces requires minimum of ZVE32X. Thus, programs
compiled and run with ZVE32X should be supported by the kernel on most
aspects. This includes context-switch, signal, ptrace, prctl, and
hwprobe.

One exception is that ELF_HWCAP returns 'V' only if full V is supported
on the platform. This means that the system without a full V must not
rely on ELF_HWCAP to tell whether it is allowable to execute Vector
without first invoking a prctl() check.

Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
Acked-by: Joel Granados <j.granados@samsung.com>
---
Changelog v5:
 - Remove the paramerter from has_vector()'s prototype. Instead, make it
   check for ZVE32X only. Everything else should make additional
   alternative checks. (Conor)
Changelog v4:
 - check static_assert for !CONFIG_RISCV_ISA_V case in has_vector.
Changelog v2:
 - update the comment in hwprobe.
---
 arch/riscv/include/asm/vector.h | 10 +++++-----
 arch/riscv/kernel/cpufeature.c  |  5 ++++-
 arch/riscv/kernel/sys_hwprobe.c |  6 +++++-
 arch/riscv/kernel/vector.c      |  5 ++++-
 arch/riscv/lib/uaccess.S        |  2 +-
 5 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/arch/riscv/include/asm/vector.h b/arch/riscv/include/asm/vector.h
index 731dcd0ed4de..be7d309cca8a 100644
--- a/arch/riscv/include/asm/vector.h
+++ b/arch/riscv/include/asm/vector.h
@@ -37,7 +37,7 @@ static inline u32 riscv_v_flags(void)
 
 static __always_inline bool has_vector(void)
 {
-	return riscv_has_extension_unlikely(RISCV_ISA_EXT_v);
+	return riscv_has_extension_unlikely(RISCV_ISA_EXT_ZVE32X);
 }
 
 static inline void __riscv_v_vstate_clean(struct pt_regs *regs)
@@ -91,7 +91,7 @@ static __always_inline void __vstate_csr_restore(struct __riscv_v_ext_state *src
 {
 	asm volatile (
 		".option push\n\t"
-		".option arch, +v\n\t"
+		".option arch, +zve32x\n\t"
 		"vsetvl	 x0, %2, %1\n\t"
 		".option pop\n\t"
 		"csrw	" __stringify(CSR_VSTART) ", %0\n\t"
@@ -109,7 +109,7 @@ static inline void __riscv_v_vstate_save(struct __riscv_v_ext_state *save_to,
 	__vstate_csr_save(save_to);
 	asm volatile (
 		".option push\n\t"
-		".option arch, +v\n\t"
+		".option arch, +zve32x\n\t"
 		"vsetvli	%0, x0, e8, m8, ta, ma\n\t"
 		"vse8.v		v0, (%1)\n\t"
 		"add		%1, %1, %0\n\t"
@@ -131,7 +131,7 @@ static inline void __riscv_v_vstate_restore(struct __riscv_v_ext_state *restore_
 	riscv_v_enable();
 	asm volatile (
 		".option push\n\t"
-		".option arch, +v\n\t"
+		".option arch, +zve32x\n\t"
 		"vsetvli	%0, x0, e8, m8, ta, ma\n\t"
 		"vle8.v		v0, (%1)\n\t"
 		"add		%1, %1, %0\n\t"
@@ -153,7 +153,7 @@ static inline void __riscv_v_vstate_discard(void)
 	riscv_v_enable();
 	asm volatile (
 		".option push\n\t"
-		".option arch, +v\n\t"
+		".option arch, +zve32x\n\t"
 		"vsetvli	%0, x0, e8, m8, ta, ma\n\t"
 		"vmv.v.i	v0, -1\n\t"
 		"vmv.v.i	v8, -1\n\t"
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index ad3e613ee30f..53be3365e302 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -720,11 +720,14 @@ void __init riscv_fill_hwcap(void)
 		elf_hwcap &= ~COMPAT_HWCAP_ISA_F;
 	}
 
-	if (elf_hwcap & COMPAT_HWCAP_ISA_V) {
+	if (__riscv_isa_extension_available(NULL, RISCV_ISA_EXT_ZVE32X)) {
 		/*
 		 * This cannot fail when called on the boot hart
 		 */
 		riscv_v_setup_vsize();
+	}
+
+	if (elf_hwcap & COMPAT_HWCAP_ISA_V) {
 		/*
 		 * ISA string in device tree might have 'v' flag, but
 		 * CONFIG_RISCV_ISA_V is disabled in kernel.
diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index 35390b4a5a17..83fcc939df67 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -69,7 +69,7 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
 	if (riscv_isa_extension_available(NULL, c))
 		pair->value |= RISCV_HWPROBE_IMA_C;
 
-	if (has_vector())
+	if (has_vector() && riscv_isa_extension_available(NULL, v))
 		pair->value |= RISCV_HWPROBE_IMA_V;
 
 	/*
@@ -113,6 +113,10 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
 		EXT_KEY(ZICOND);
 		EXT_KEY(ZIHINTPAUSE);
 
+		/*
+		 * All the following extensions must depend on the kernel
+		 * support of V.
+		 */
 		if (has_vector()) {
 			EXT_KEY(ZVE32X);
 			EXT_KEY(ZVE32F);
diff --git a/arch/riscv/kernel/vector.c b/arch/riscv/kernel/vector.c
index 6727d1d3b8f2..682b3feee451 100644
--- a/arch/riscv/kernel/vector.c
+++ b/arch/riscv/kernel/vector.c
@@ -173,8 +173,11 @@ bool riscv_v_first_use_handler(struct pt_regs *regs)
 	u32 __user *epc = (u32 __user *)regs->epc;
 	u32 insn = (u32)regs->badaddr;
 
+	if (!has_vector())
+		return false;
+
 	/* Do not handle if V is not supported, or disabled */
-	if (!(ELF_HWCAP & COMPAT_HWCAP_ISA_V))
+	if (!riscv_v_vstate_ctrl_user_allowed())
 		return false;
 
 	/* If V has been enabled then it is not the first-use trap */
diff --git a/arch/riscv/lib/uaccess.S b/arch/riscv/lib/uaccess.S
index bc22c078aba8..bbe143bb32a0 100644
--- a/arch/riscv/lib/uaccess.S
+++ b/arch/riscv/lib/uaccess.S
@@ -14,7 +14,7 @@
 
 SYM_FUNC_START(__asm_copy_to_user)
 #ifdef CONFIG_RISCV_ISA_V
-	ALTERNATIVE("j fallback_scalar_usercopy", "nop", 0, RISCV_ISA_EXT_v, CONFIG_RISCV_ISA_V)
+	ALTERNATIVE("j fallback_scalar_usercopy", "nop", 0, RISCV_ISA_EXT_ZVE32X, CONFIG_RISCV_ISA_V)
 	REG_L	t0, riscv_v_usercopy_threshold
 	bltu	a2, t0, fallback_scalar_usercopy
 	tail enter_vector_usercopy

-- 
2.44.0.rc2


