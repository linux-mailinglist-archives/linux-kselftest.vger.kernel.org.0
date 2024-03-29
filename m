Return-Path: <linux-kselftest+bounces-6861-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 663218915E2
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 10:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A499281609
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 09:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E500F657B3;
	Fri, 29 Mar 2024 09:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="bxepa0GE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0B05F860
	for <linux-kselftest@vger.kernel.org>; Fri, 29 Mar 2024 09:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711704480; cv=none; b=OvIJc+mGrcTwOzC0/GFgVLrH79dg5MuHspW0inf67gZy07P78pIugjkc8rN9dl4MD83wxiKn52fXsvDtbSr/BJDC95d92PlnidlXbLCS+xF91U+NXHIwLlhbTD7cp2XTLpCvPD9dL82xReVba7lZlGMeOo3AqayC2KTo8tgC47s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711704480; c=relaxed/simple;
	bh=byQyJ+mUVDPrSJinRBDLAgeflaiBNndaObFYJicDYXw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E2jAbIHW/c7u+ghZiEtyjq13cCzg8KGPG5e7GktY9J0UzqgwHPDuV3D6vMxYusmtwEqTc9wMU5DJjIlzPYvRpBve2AXqxxAvsnq3Gmg/H14+6alU1VbCDBE36FExNGvffZ8EQCWsZEZ57t5RE9sZ5s5+UIvKP/8cAnGpgSOKWBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=bxepa0GE; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-29df0ca87d1so1512063a91.2
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Mar 2024 02:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711704478; x=1712309278; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YfructPGSDbFIY5KANyP0OUZ/rAlg6UVQSMNURcUx/Q=;
        b=bxepa0GEVFLUDtuop8ELhwkgu/KuNGfRsK2zCJU2wDPijHaYc1lkgyt/Ao78GDKEqy
         dtsgMQe/rOnp00h9D8Zy19p0OExENv4jjRaRBIJ0QEujxXlkhBe+hW5skSYXVyg2chnl
         RpX9pN9MdMT5XV3Ek5L/iHVY/oIT55kPx3+ef0d2suATgm0ivZRpGXm+Sb5MsHM9XFuQ
         O440QmxmXNWNCjucNWCkNZypl3RgEreezbGv02KQO0WMrOLWXu4oiOtTM3LlOdmvL8Im
         SCTTK/sRoCkHHKVqymFY48ubOH1AI6xjYGuJMMZBuuw+hOVeDjx72G+m0z/DzC/zL3b0
         J8yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711704478; x=1712309278;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YfructPGSDbFIY5KANyP0OUZ/rAlg6UVQSMNURcUx/Q=;
        b=RmtV0BetmPmN95UbOtrVev8nmMP0M9a/Jjd+3c76/RskakSS1JhZULnIp6OBG8vmC/
         aNhAHmxsXOd0mGm0+h8oUZJARHXUnLrg6gZXqjnlGVfmH4D2JVQbvLBdryPHcDJrrgn9
         TV5AHIGb/8ocTXCizYKvz8baczt180B815D8CUDCIgVzqp91+Ty9uQNisLKVlZ8Dk1M6
         GIu3te2ccYGGMG5UfNnryNIJGYp8GI5I1IokLYgrtwzJp2j1Fi4VzY3swE2gWAcQEnI8
         Xr20ehCjimoLgiBmQuF6vCzoHGheeH6IPheNR2kRWMqdFq06RRI0+OhnZlg9omu2hpaF
         kaJA==
X-Forwarded-Encrypted: i=1; AJvYcCVX8tNedJkoSqJnM4dF6JsOyR4FgVSmRXYnVIamYwCLjQwoE3T3zKdXi9CQc4SKE+nhIAcabNs+mG2sHGkYXK1oVhWL4UWzO6uXTJZXRCTt
X-Gm-Message-State: AOJu0YwZqPFJEoD1R/AE8BbkmPCLPZ8Wn8TXlg+clj0hisj98FP33QYQ
	L9KnwMHgwosBTQ7iu4n+F3nsQxsc2VRNVCUTJvG8IQdwA6eloeJAzcoAIqw5zS0=
X-Google-Smtp-Source: AGHT+IEgRCohje6FoItkAA90Oov//fQs26jLa2d7M0gq96y2GMdC43oOYqp9fbQEYyu5BFzz1OlNNA==
X-Received: by 2002:a17:90a:7d02:b0:2a0:4495:1f3d with SMTP id g2-20020a17090a7d0200b002a044951f3dmr2125693pjl.0.1711704478186;
        Fri, 29 Mar 2024 02:27:58 -0700 (PDT)
Received: from [127.0.1.1] (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id cv17-20020a17090afd1100b002a02f8d350fsm2628830pjb.53.2024.03.29.02.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 02:27:57 -0700 (PDT)
From: Max Hsu <max.hsu@sifive.com>
Date: Fri, 29 Mar 2024 17:26:21 +0800
Subject: [PATCH RFC 05/11] riscv: cpufeature: Add Sdtrig optional CSRs
 checks
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240329-dev-maxh-lin-452-6-9-v1-5-1534f93b94a7@sifive.com>
References: <20240329-dev-maxh-lin-452-6-9-v1-0-1534f93b94a7@sifive.com>
In-Reply-To: <20240329-dev-maxh-lin-452-6-9-v1-0-1534f93b94a7@sifive.com>
To: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
 Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: Palmer Dabbelt <palmer@sifive.com>, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, kvm@vger.kernel.org, 
 kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 Max Hsu <max.hsu@sifive.com>
X-Mailer: b4 0.13.0

Sdtrig extension introduce two optional CSRs [hcontext/scontext],
that will be storing PID/Guest OS ID for the debug feature.

The availability of these two CSRs will be determined by
DTS and Smstateen extension [h/s]stateen0 CSR bit 57.

If all CPUs hcontext/scontext checks are satisfied, it will enable the
use_hcontext/use_scontext static branch.

Signed-off-by: Max Hsu <max.hsu@sifive.com>
---
 arch/riscv/include/asm/switch_to.h |   6 ++
 arch/riscv/kernel/cpufeature.c     | 161 +++++++++++++++++++++++++++++++++++++
 2 files changed, 167 insertions(+)

diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
index 7efdb0584d47..07432550ed54 100644
--- a/arch/riscv/include/asm/switch_to.h
+++ b/arch/riscv/include/asm/switch_to.h
@@ -69,6 +69,12 @@ static __always_inline bool has_fpu(void) { return false; }
 #define __switch_to_fpu(__prev, __next) do { } while (0)
 #endif
 
+DECLARE_STATIC_KEY_FALSE(use_scontext);
+static __always_inline bool has_scontext(void)
+{
+	return static_branch_likely(&use_scontext);
+}
+
 extern struct task_struct *__switch_to(struct task_struct *,
 				       struct task_struct *);
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 080c06b76f53..44ff84b920af 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -35,6 +35,19 @@ static DECLARE_BITMAP(riscv_isa, RISCV_ISA_EXT_MAX) __read_mostly;
 /* Per-cpu ISA extensions. */
 struct riscv_isainfo hart_isa[NR_CPUS];
 
+atomic_t hcontext_disable;
+atomic_t scontext_disable;
+
+DEFINE_STATIC_KEY_FALSE_RO(use_hcontext);
+EXPORT_SYMBOL(use_hcontext);
+
+DEFINE_STATIC_KEY_FALSE_RO(use_scontext);
+EXPORT_SYMBOL(use_scontext);
+
+/* Record the maximum number that the hcontext CSR allowed to hold */
+atomic_long_t hcontext_id_share;
+EXPORT_SYMBOL(hcontext_id_share);
+
 /**
  * riscv_isa_extension_base() - Get base extension word
  *
@@ -719,6 +732,154 @@ unsigned long riscv_get_elf_hwcap(void)
 	return hwcap;
 }
 
+static void __init sdtrig_percpu_csrs_check(void *data)
+{
+	struct device_node *node;
+	struct device_node *debug_node;
+	struct device_node *trigger_module;
+
+	unsigned int cpu = smp_processor_id();
+
+	/*
+	 * Expect every cpu node has the [h/s]context-present property
+	 * otherwise, jump to sdtrig_csrs_disable_all to disable all access to
+	 * [h/s]context CSRs
+	 */
+	node = of_cpu_device_node_get(cpu);
+	if (!node)
+		goto sdtrig_csrs_disable_all;
+
+	debug_node = of_get_compatible_child(node, "riscv,debug-v1.0.0");
+	of_node_put(node);
+
+	if (!debug_node)
+		goto sdtrig_csrs_disable_all;
+
+	trigger_module = of_get_child_by_name(debug_node, "trigger-module");
+	of_node_put(debug_node);
+
+	if (!trigger_module)
+		goto sdtrig_csrs_disable_all;
+
+	if (!(IS_ENABLED(CONFIG_KVM) &&
+	      of_property_read_bool(trigger_module, "hcontext-present")))
+		atomic_inc(&hcontext_disable);
+
+	if (!of_property_read_bool(trigger_module, "scontext-present"))
+		atomic_inc(&scontext_disable);
+
+	of_node_put(trigger_module);
+
+	/*
+	 * Before access to hcontext/scontext CSRs, if the smstateen
+	 * extension is present, the accessibility will be controlled
+	 * by the hstateen0[H]/sstateen0 CSRs.
+	 */
+	if (__riscv_isa_extension_available(NULL, RISCV_ISA_EXT_SMSTATEEN)) {
+		u64 hstateen_bit, sstateen_bit;
+
+		if (__riscv_isa_extension_available(NULL, RISCV_ISA_EXT_h)) {
+#if __riscv_xlen > 32
+			csr_set(CSR_HSTATEEN0, SMSTATEEN0_HSCONTEXT);
+			hstateen_bit = csr_read(CSR_HSTATEEN0);
+#else
+			csr_set(CSR_HSTATEEN0H, SMSTATEEN0_HSCONTEXT >> 32);
+			hstateen_bit = csr_read(CSR_HSTATEEN0H) << 32;
+#endif
+			if (!(hstateen_bit & SMSTATEEN0_HSCONTEXT))
+				goto sdtrig_csrs_disable_all;
+
+		} else {
+			if (IS_ENABLED(CONFIG_KVM))
+				atomic_inc(&hcontext_disable);
+
+			/*
+			 * In RV32, the smstateen extension doesn't provide
+			 * high 32 bits of sstateen0 CSR which represent
+			 * accessibility for scontext CSR;
+			 * The decision is left on whether the dts has the
+			 * property to access the scontext CSR.
+			 */
+#if __riscv_xlen > 32
+			csr_set(CSR_SSTATEEN0, SMSTATEEN0_HSCONTEXT);
+			sstateen_bit = csr_read(CSR_SSTATEEN0);
+
+			if (!(sstateen_bit & SMSTATEEN0_HSCONTEXT))
+				atomic_inc(&scontext_disable);
+#endif
+		}
+	}
+
+	/*
+	 * The code can only access hcontext/scontext CSRs if:
+	 * The cpu dts node have [h/s]context-present;
+	 * If Smstateen extension is presented, then the accessibility bit
+	 * toward hcontext/scontext CSRs is enabled; Or the Smstateen extension
+	 * isn't available, thus the access won't be blocked by it.
+	 *
+	 * With writing 1 to the every bit of these CSRs, we retrieve the
+	 * maximum bits that is available on the CSRs. and decide
+	 * whether it's suit for its context recording operation.
+	 */
+	if (IS_ENABLED(CONFIG_KVM) &&
+	    !atomic_read(&hcontext_disable)) {
+		unsigned long hcontext_available_bits = 0;
+
+		csr_write(CSR_HCONTEXT, -1UL);
+		hcontext_available_bits = csr_swap(CSR_HCONTEXT, hcontext_available_bits);
+
+		/* hcontext CSR is required by at least 1 bit */
+		if (hcontext_available_bits)
+			atomic_long_and(hcontext_available_bits, &hcontext_id_share);
+		else
+			atomic_inc(&hcontext_disable);
+	}
+
+	if (!atomic_read(&scontext_disable)) {
+		unsigned long scontext_available_bits = 0;
+
+		csr_write(CSR_SCONTEXT, -1UL);
+		scontext_available_bits = csr_swap(CSR_SCONTEXT, scontext_available_bits);
+
+		/* scontext CSR is required by at least the sizeof pid_t */
+		if (scontext_available_bits < ((1UL << (sizeof(pid_t) << 3)) - 1))
+			atomic_inc(&scontext_disable);
+	}
+
+	return;
+
+sdtrig_csrs_disable_all:
+	if (IS_ENABLED(CONFIG_KVM))
+		atomic_inc(&hcontext_disable);
+
+	atomic_inc(&scontext_disable);
+}
+
+static int __init sdtrig_enable_csrs_fill(void)
+{
+	if (__riscv_isa_extension_available(NULL, RISCV_ISA_EXT_SDTRIG)) {
+		atomic_long_set(&hcontext_id_share, -1UL);
+
+		/* check every CPUs sdtrig extension optional CSRs */
+		sdtrig_percpu_csrs_check(NULL);
+		smp_call_function(sdtrig_percpu_csrs_check, NULL, 1);
+
+		if (IS_ENABLED(CONFIG_KVM) &&
+		    !atomic_read(&hcontext_disable)) {
+			pr_info("riscv-sdtrig: Writing 'GuestOS ID' to hcontext CSR is enabled\n");
+			static_branch_enable(&use_hcontext);
+		}
+
+		if (!atomic_read(&scontext_disable)) {
+			pr_info("riscv-sdtrig: Writing 'PID' to scontext CSR is enabled\n");
+			static_branch_enable(&use_scontext);
+		}
+	}
+	return 0;
+}
+
+arch_initcall(sdtrig_enable_csrs_fill);
+
 void riscv_user_isa_enable(void)
 {
 	if (riscv_cpu_has_extension_unlikely(smp_processor_id(), RISCV_ISA_EXT_ZICBOZ))

-- 
2.43.2


