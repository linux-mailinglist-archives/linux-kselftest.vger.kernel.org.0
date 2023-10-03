Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBDE77B5F9A
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Oct 2023 05:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239053AbjJCDxX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Oct 2023 23:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239073AbjJCDxT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Oct 2023 23:53:19 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F157D112
        for <linux-kselftest@vger.kernel.org>; Mon,  2 Oct 2023 20:53:05 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c3f97f2239so3767465ad.0
        for <linux-kselftest@vger.kernel.org>; Mon, 02 Oct 2023 20:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1696305185; x=1696909985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uNHkjMM9HHYX8X83JcKOMwoHgKf/W4d95vsynq44CKo=;
        b=Xjx551QKjNTT10UwvcHUpTKwgSNpfC0K/VSYUrheVC65rfOnViJkBc9EsRrV88FsMJ
         zgTBXgbCmwY5nyJXzAtLTwMnUIwCa0lUr/Km5NWm+vmZ5SGQW9p+qd93O1M+4B4Nn8eM
         PNjDrlysdAHRa2iEZQIHy5TYTU2kIXvYUuI3rHj1o21U+ki3ba0ZrdozjP3OC0JzXtOg
         OwwX2WsQImpiiowdhSHc+4N+iMdzyBw2cq0jdrWQeO1f9+HyxsombSlJnIUFhGoimhG9
         MkLMESKHB4ALdqCnJuZqzwoOnDZ1wckQfASlW+Kk6DmyiXManlcVd4MRJuQ2dSweopp0
         JEOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696305185; x=1696909985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uNHkjMM9HHYX8X83JcKOMwoHgKf/W4d95vsynq44CKo=;
        b=G9X0isI4G6kZcttDi3ZlkyDtGqWtzGOIC6FshcHppn/H3ZsrqdbBn7KMHqR0j2ILwd
         r1RZbJ7TTnFfk5iWu+BO6Cxy1IVZqY32LVyXTWi/2rAPay5ZqdbJz2eFnwG3pj/RkGfk
         5BcpC1dagYL+ZedqdiioImjB7ZdjJ4sk0j/RObsHzuUvHM1tZ4fsrMXigk37Rw+DTqgb
         PdEv5sIpvgwBfODSzmlE7Lik1W0bkhUlSPqLU94QyoGo66WvAnAf6df2koWKYoM5ToUW
         hD2fw6RpUKRjTOHoR1f5UR0j2zGV3MdjI0Zj4W2Gw5RalLNKyY9JnaykZn/E6xHYu9Ok
         WeYw==
X-Gm-Message-State: AOJu0Yzgz5Q0PXy0jkZyN+lCjbMSpTovnlr1R25CFqs3yI9dYh4y4GgC
        musu5yWkjobYT6bv9uRUvBNHlA==
X-Google-Smtp-Source: AGHT+IH9oz/kuIZIp/ZgruyeZ4AtQo9yUx4+ANVBCHNlKxlrjpKUWGdvAqvEer5x/ZfYlM6knxcDrg==
X-Received: by 2002:a17:903:2309:b0:1bd:d911:2a85 with SMTP id d9-20020a170903230900b001bdd9112a85mr16292011plh.12.1696305185046;
        Mon, 02 Oct 2023 20:53:05 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([171.76.84.132])
        by smtp.gmail.com with ESMTPSA id ja7-20020a170902efc700b001bf846dd2d0sm277381plb.13.2023.10.02.20.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 20:53:04 -0700 (PDT)
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
Subject: [PATCH v3 5/6] KVM: riscv: selftests: Add smstateen registers to get-reg-list test
Date:   Tue,  3 Oct 2023 09:22:25 +0530
Message-Id: <20231003035226.1945725-6-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003035226.1945725-1-apatel@ventanamicro.com>
References: <20231003035226.1945725-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

We have a new smstateen registers as separate sub-type of CSR ONE_REG
interface so let us add these registers to get-reg-list test.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 .../selftests/kvm/riscv/get-reg-list.c        | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
index 6cec0ef75cc7..625118d53b74 100644
--- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
+++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
@@ -36,6 +36,7 @@ bool filter_reg(__u64 reg)
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_I:
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_M:
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_V:
+	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_SMSTATEEN:
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_SSAIA:
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_SSTC:
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_SVINVAL:
@@ -186,6 +187,8 @@ static const char *core_id_to_str(const char *prefix, __u64 id)
 	"KVM_REG_RISCV_CSR_GENERAL | KVM_REG_RISCV_CSR_REG(" #csr ")"
 #define RISCV_CSR_AIA(csr) \
 	"KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CSR_REG(" #csr ")"
+#define RISCV_CSR_SMSTATEEN(csr) \
+	"KVM_REG_RISCV_CSR_SMSTATEEN | KVM_REG_RISCV_CSR_REG(" #csr ")"
 
 static const char *general_csr_id_to_str(__u64 reg_off)
 {
@@ -243,6 +246,18 @@ static const char *aia_csr_id_to_str(__u64 reg_off)
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
@@ -255,6 +270,8 @@ static const char *csr_id_to_str(const char *prefix, __u64 id)
 		return general_csr_id_to_str(reg_off);
 	case KVM_REG_RISCV_CSR_AIA:
 		return aia_csr_id_to_str(reg_off);
+	case KVM_REG_RISCV_CSR_SMSTATEEN:
+		return smstateen_csr_id_to_str(reg_off);
 	}
 
 	TEST_FAIL("%s: Unknown csr subtype: 0x%llx", prefix, reg_subtype);
@@ -332,6 +349,7 @@ static const char *isa_ext_id_to_str(__u64 id)
 		KVM_ISA_EXT_ARR(I),
 		KVM_ISA_EXT_ARR(M),
 		KVM_ISA_EXT_ARR(V),
+		KVM_ISA_EXT_ARR(SMSTATEEN),
 		KVM_ISA_EXT_ARR(SSAIA),
 		KVM_ISA_EXT_ARR(SSTC),
 		KVM_ISA_EXT_ARR(SVINVAL),
@@ -637,6 +655,11 @@ static __u64 aia_regs[] = {
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
@@ -744,6 +767,8 @@ static __u64 fp_d_regs[] = {
 	{"zihpm", .feature = KVM_RISCV_ISA_EXT_ZIHPM, .regs = zihpm_regs, .regs_n = ARRAY_SIZE(zihpm_regs),}
 #define AIA_REGS_SUBLIST \
 	{"aia", .feature = KVM_RISCV_ISA_EXT_SSAIA, .regs = aia_regs, .regs_n = ARRAY_SIZE(aia_regs),}
+#define SMSTATEEN_REGS_SUBLIST \
+	{"smstateen", .feature = KVM_RISCV_ISA_EXT_SMSTATEEN, .regs = smstateen_regs, .regs_n = ARRAY_SIZE(smstateen_regs),}
 #define FP_F_REGS_SUBLIST \
 	{"fp_f", .feature = KVM_RISCV_ISA_EXT_F, .regs = fp_f_regs, \
 		.regs_n = ARRAY_SIZE(fp_f_regs),}
@@ -871,6 +896,14 @@ static struct vcpu_reg_list aia_config = {
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
@@ -903,6 +936,7 @@ struct vcpu_reg_list *vcpu_configs[] = {
 	&zifencei_config,
 	&zihpm_config,
 	&aia_config,
+	&smstateen_config,
 	&fp_f_config,
 	&fp_d_config,
 };
-- 
2.34.1

