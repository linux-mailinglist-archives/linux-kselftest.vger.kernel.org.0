Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4EF57A581F
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Sep 2023 05:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbjISDy5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Sep 2023 23:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbjISDyy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Sep 2023 23:54:54 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC0813E
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Sep 2023 20:54:35 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-2765c9f2a39so1205072a91.0
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Sep 2023 20:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1695095673; x=1695700473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mq3LOReqduF1SDuSYPSNNB82Nem1JwUvHmVZElovfds=;
        b=jP2jLzDLsF4BnBOeBcERmQS0jcgdMAqbPUmddejL8pU7AtF17NMV/BpBi3M3e6PU1z
         xCPfD1PFPdiDOgCU5nl2NsrRVD4plgO/NcEPiE8kHQ79l0Mqn+uZNgYNSB3JzzQzm4xD
         UWuD1FTpRqsSxr2AY9wHstQZpLjaFN28OrCFqQ8aHIhxF3OhvZg8TwKs8M8E4K+oUTNH
         CwdXqLUpPWBqatlakh/kXgtqwQHsFHs2AirjoduyFGCS+fWXqE5WsI2inC9fplKS5UzT
         3/HTieyTC8mMRCK+qUH28yUtx/Yha4bDKd2RXXBtPZ64F7TShuEz1HV0HI+mmxYlkuam
         FYXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695095673; x=1695700473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mq3LOReqduF1SDuSYPSNNB82Nem1JwUvHmVZElovfds=;
        b=cM+P8i1+L5FN80gmFSDWhVYqhsUvNE6svDJuy6HPVNDzRU6IyIrNGwtZe/RCwCJ5bK
         sVBKe8d8+3bznBI4pBORO2mgsBuQs81aFD5NqJ6g4zop+coDJWEOzraTumvdSiB1zU+b
         Rjf3+icd+INWlR4BQsAZm3qNAJ9iuJ4jPuuj+yqeOEcujZVQWTlwa5npGBvz2OYGPM4u
         DNaKxF0n0aImunYNR7JDWr1IVGkggnNLx9YE+iebwfYjKaffn/0Q/KmvcUjXTgs2UvbW
         RzekJnXe0o0aPSmZf9PBgFKn8UfP5q1PgBnKrvMnhsC7vFgrYnAQTyINNnT+wgVG/QxT
         RKrQ==
X-Gm-Message-State: AOJu0YyFl0DK4bmiISgDKWxnMNHcBu0E3p3APi17LHwfXUFNDvj7lLLI
        sTdtqrNBMNmryxx8UlbpIFVYxQ==
X-Google-Smtp-Source: AGHT+IGn8GgNjnqWNdJgMIfQx0naxl2pKkZTSagr+WObJKilG7NALzfMEtJZtUBpsH6o6ifSqzEiWA==
X-Received: by 2002:a17:90b:4b11:b0:273:ed60:ad52 with SMTP id lx17-20020a17090b4b1100b00273ed60ad52mr8476738pjb.37.1695095672905;
        Mon, 18 Sep 2023 20:54:32 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id 3-20020a17090a034300b00273fc850342sm4000802pjf.20.2023.09.18.20.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 20:54:32 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Andrew Jones <ajones@ventanamicro.com>,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        devicetree@vger.kernel.org, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 6/7] KVM: riscv: selftests: Add smstateen registers to get-reg-list test
Date:   Tue, 19 Sep 2023 09:23:42 +0530
Message-Id: <20230919035343.1399389-7-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230919035343.1399389-1-apatel@ventanamicro.com>
References: <20230919035343.1399389-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

We have a new smstateen registers as separate sub-type of CSR ONE_REG
interface so let us add these registers to get-reg-list test.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 .../selftests/kvm/riscv/get-reg-list.c        | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
index 0928c35470ae..9f464c7996c6 100644
--- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
+++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
@@ -49,6 +49,7 @@ bool filter_reg(__u64 reg)
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZICSR:
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZIFENCEI:
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZIHPM:
+	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_SMSTATEEN:
 		return true;
 	/* AIA registers are always available when Ssaia can't be disabled */
 	case KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CSR_AIA_REG(siselect):
@@ -184,6 +185,8 @@ static const char *core_id_to_str(const char *prefix, __u64 id)
 	"KVM_REG_RISCV_CSR_GENERAL | KVM_REG_RISCV_CSR_REG(" #csr ")"
 #define RISCV_CSR_AIA(csr) \
 	"KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CSR_REG(" #csr ")"
+#define RISCV_CSR_SMSTATEEN(csr) \
+	"KVM_REG_RISCV_CSR_SMSTATEEN | KVM_REG_RISCV_CSR_REG(" #csr ")"
 
 static const char *general_csr_id_to_str(__u64 reg_off)
 {
@@ -241,6 +244,18 @@ static const char *aia_csr_id_to_str(__u64 reg_off)
 	return NULL;
 }
 
+static const char *smstateen_csr_id_to_str(__u64 reg_off)
+{
+	/* reg_off is the offset into struct kvm_riscv_smstateen_csr */
+	switch (reg_off) {
+	case KVM_REG_RISCV_CSR_SMSTATEEN_REG(sstateen0):
+		return RISCV_CSR_SMSTATEEN(sstateen0);
+	}
+
+	TEST_FAIL("Unknown smstateen csr reg: 0x%llx", reg_off);
+	return NULL;
+}
+
 static const char *csr_id_to_str(const char *prefix, __u64 id)
 {
 	__u64 reg_off = id & ~(REG_MASK | KVM_REG_RISCV_CSR);
@@ -253,6 +268,8 @@ static const char *csr_id_to_str(const char *prefix, __u64 id)
 		return general_csr_id_to_str(reg_off);
 	case KVM_REG_RISCV_CSR_AIA:
 		return aia_csr_id_to_str(reg_off);
+	case KVM_REG_RISCV_CSR_SMSTATEEN:
+		return smstateen_csr_id_to_str(reg_off);
 	}
 
 	TEST_FAIL("%s: Unknown csr subtype: 0x%llx", prefix, reg_subtype);
@@ -342,6 +359,7 @@ static const char *isa_ext_id_to_str(__u64 id)
 		"KVM_RISCV_ISA_EXT_ZICSR",
 		"KVM_RISCV_ISA_EXT_ZIFENCEI",
 		"KVM_RISCV_ISA_EXT_ZIHPM",
+		"KVM_RISCV_ISA_EXT_SMSTATEEN",
 	};
 
 	if (reg_off >= ARRAY_SIZE(kvm_isa_ext_reg_name)) {
@@ -629,6 +647,11 @@ static __u64 aia_regs[] = {
 	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_SSAIA,
 };
 
+static __u64 smstateen_regs[] = {
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_SMSTATEEN | KVM_REG_RISCV_CSR_SMSTATEEN_REG(sstateen0),
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_SMSTATEEN,
+};
+
 static __u64 fp_f_regs[] = {
 	KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_RISCV_FP_F_REG(f[0]),
 	KVM_REG_RISCV | KVM_REG_SIZE_U32 | KVM_REG_RISCV_FP_F | KVM_REG_RISCV_FP_F_REG(f[1]),
@@ -736,6 +759,8 @@ static __u64 fp_d_regs[] = {
 	{"zihpm", .feature = KVM_RISCV_ISA_EXT_ZIHPM, .regs = zihpm_regs, .regs_n = ARRAY_SIZE(zihpm_regs),}
 #define AIA_REGS_SUBLIST \
 	{"aia", .feature = KVM_RISCV_ISA_EXT_SSAIA, .regs = aia_regs, .regs_n = ARRAY_SIZE(aia_regs),}
+#define SMSTATEEN_REGS_SUBLIST \
+	{"smstateen", .feature = KVM_RISCV_ISA_EXT_SMSTATEEN, .regs = smstateen_regs, .regs_n = ARRAY_SIZE(smstateen_regs),}
 #define FP_F_REGS_SUBLIST \
 	{"fp_f", .feature = KVM_RISCV_ISA_EXT_F, .regs = fp_f_regs, \
 		.regs_n = ARRAY_SIZE(fp_f_regs),}
@@ -863,6 +888,14 @@ static struct vcpu_reg_list aia_config = {
 	},
 };
 
+static struct vcpu_reg_list smstateen_config = {
+	.sublists = {
+	BASE_SUBLIST,
+	SMSTATEEN_REGS_SUBLIST,
+	{0},
+	},
+};
+
 static struct vcpu_reg_list fp_f_config = {
 	.sublists = {
 	BASE_SUBLIST,
@@ -895,6 +928,7 @@ struct vcpu_reg_list *vcpu_configs[] = {
 	&zifencei_config,
 	&zihpm_config,
 	&aia_config,
+	&smstateen_config,
 	&fp_f_config,
 	&fp_d_config,
 };
-- 
2.34.1

