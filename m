Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F0F7AD966
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Sep 2023 15:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbjIYNkk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Sep 2023 09:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232255AbjIYNkX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Sep 2023 09:40:23 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C868CCDB
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Sep 2023 06:40:13 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c44c0f9138so44156065ad.2
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Sep 2023 06:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1695649213; x=1696254013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4s1mdQKNja8rRVRNvpznVdJduDgGmg/7wDSFseU/UmI=;
        b=LrsLJ8qOr/6RMNQ8sKJV8ZVjL21ftj8GjZsA4COF5lrjbX1jCcGCCYRSzIsbXbKEVH
         Sm+N674AIfxi2JkgNTBnkeaU8RwZ1/1CqcDsBNlht45RxJau/ZWambmKD0Q4xUgAsrOa
         Oi548MQJUlGtcAMUi6bM7XdYWRKUQJjnpk5lBOYrqX368X8oMcM5yDoMBP+yl7RECoRa
         eEK0TSnbV6GeWWfZ1q2NFb9eVg7oXldnpkmqGsC3wWMx0d+R0LtUT0/XfFpTmi7fUAmR
         5KOaDTYcwHq7IAFnx/0L2bXHdWNeOeVxweW709ZpNjmrlywT74EcNyGzNiFbPTc9YXMd
         tMLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695649213; x=1696254013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4s1mdQKNja8rRVRNvpznVdJduDgGmg/7wDSFseU/UmI=;
        b=tVjXhFNMTrH63vuSVu2BAsSKAijHTgcXqKYglClBwfi0/QmiW77RBzeECjMGJE/MGj
         u0Ltij5wLg9GO9UAXcLBOvFLmm7B3OVemQCKFHJLN6JtExbd86NWzXcmghAvdNggC3BO
         dY1UNv5dEW2ErnCnuWcOAm5o6eu9qLpiPhT2/vUV9QdBtkERQGo1E/JycHlBA65KnjsS
         9YzwjcKQvkCD0vc1YkMb3UESI1U5ZXIu7il7B0Ss5yif5DA+STs9A5iXffB2FwvjgASB
         sdUWbAH7H6cs420TbfaY9b6SpRggqd+dvG82leg1lYbfEl5j+VBn+/0B43hic9dITLhr
         IY1Q==
X-Gm-Message-State: AOJu0Yx0PnbsTKBCMxnZRnNBk4kj+ONjpCeuPCpb6tGBi2Bs1EmDoYwm
        HUhVFD+JXYhflzWU/xWncksF2g==
X-Google-Smtp-Source: AGHT+IHwYx5uxjulfoXkoeURKGAldzLHqGYkvOLbEpGq9sn4ycnd7NcTYbii8mDYFgDlQkGlqzyNeA==
X-Received: by 2002:a17:903:444:b0:1b6:6c32:59a8 with SMTP id iw4-20020a170903044400b001b66c3259a8mr4289356plb.36.1695649212949;
        Mon, 25 Sep 2023 06:40:12 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id p11-20020a170902eacb00b001c625d6ffccsm969433pld.129.2023.09.25.06.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 06:40:12 -0700 (PDT)
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
Subject: [PATCH v2 9/9] KVM: riscv: selftests: Add condops extensions to get-reg-list test
Date:   Mon, 25 Sep 2023 19:08:59 +0530
Message-Id: <20230925133859.1735879-10-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230925133859.1735879-1-apatel@ventanamicro.com>
References: <20230925133859.1735879-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

We have a new conditional operations related ISA extensions so let us
add these extensions to get-reg-list test.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 .../selftests/kvm/riscv/get-reg-list.c        | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
index 625118d53b74..cb1bb95b5df2 100644
--- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
+++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
@@ -42,12 +42,14 @@ bool filter_reg(__u64 reg)
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_SVINVAL:
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_SVNAPOT:
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_SVPBMT:
+	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_XVENTANACONDOPS:
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZBA:
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZBB:
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZBS:
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZICBOM:
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZICBOZ:
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZICNTR:
+	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZICOND:
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZICSR:
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZIFENCEI:
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZIHINTPAUSE:
@@ -355,12 +357,14 @@ static const char *isa_ext_id_to_str(__u64 id)
 		KVM_ISA_EXT_ARR(SVINVAL),
 		KVM_ISA_EXT_ARR(SVNAPOT),
 		KVM_ISA_EXT_ARR(SVPBMT),
+		KVM_ISA_EXT_ARR(XVENTANACONDOPS),
 		KVM_ISA_EXT_ARR(ZBA),
 		KVM_ISA_EXT_ARR(ZBB),
 		KVM_ISA_EXT_ARR(ZBS),
 		KVM_ISA_EXT_ARR(ZICBOM),
 		KVM_ISA_EXT_ARR(ZICBOZ),
 		KVM_ISA_EXT_ARR(ZICNTR),
+		KVM_ISA_EXT_ARR(ZICOND),
 		KVM_ISA_EXT_ARR(ZICSR),
 		KVM_ISA_EXT_ARR(ZIFENCEI),
 		KVM_ISA_EXT_ARR(ZIHINTPAUSE),
@@ -632,6 +636,10 @@ static __u64 zicntr_regs[] = {
 	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZICNTR,
 };
 
+static __u64 zicond_regs[] = {
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZICOND,
+};
+
 static __u64 zicsr_regs[] = {
 	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZICSR,
 };
@@ -644,6 +652,10 @@ static __u64 zihpm_regs[] = {
 	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZIHPM,
 };
 
+static __u64 xventanacondops_regs[] = {
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_XVENTANACONDOPS,
+};
+
 static __u64 aia_regs[] = {
 	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CSR_AIA_REG(siselect),
 	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CSR_AIA_REG(iprio1),
@@ -759,12 +771,16 @@ static __u64 fp_d_regs[] = {
 	{"zbs", .feature = KVM_RISCV_ISA_EXT_ZBS, .regs = zbs_regs, .regs_n = ARRAY_SIZE(zbs_regs),}
 #define ZICNTR_REGS_SUBLIST \
 	{"zicntr", .feature = KVM_RISCV_ISA_EXT_ZICNTR, .regs = zicntr_regs, .regs_n = ARRAY_SIZE(zicntr_regs),}
+#define ZICOND_REGS_SUBLIST \
+	{"zicond", .feature = KVM_RISCV_ISA_EXT_ZICOND, .regs = zicond_regs, .regs_n = ARRAY_SIZE(zicond_regs),}
 #define ZICSR_REGS_SUBLIST \
 	{"zicsr", .feature = KVM_RISCV_ISA_EXT_ZICSR, .regs = zicsr_regs, .regs_n = ARRAY_SIZE(zicsr_regs),}
 #define ZIFENCEI_REGS_SUBLIST \
 	{"zifencei", .feature = KVM_RISCV_ISA_EXT_ZIFENCEI, .regs = zifencei_regs, .regs_n = ARRAY_SIZE(zifencei_regs),}
 #define ZIHPM_REGS_SUBLIST \
 	{"zihpm", .feature = KVM_RISCV_ISA_EXT_ZIHPM, .regs = zihpm_regs, .regs_n = ARRAY_SIZE(zihpm_regs),}
+#define XVENTANACONDOPS_REGS_SUBLIST \
+	{"xventanacondops", .feature = KVM_RISCV_ISA_EXT_XVENTANACONDOPS, .regs = xventanacondops_regs, .regs_n = ARRAY_SIZE(xventanacondops_regs),}
 #define AIA_REGS_SUBLIST \
 	{"aia", .feature = KVM_RISCV_ISA_EXT_SSAIA, .regs = aia_regs, .regs_n = ARRAY_SIZE(aia_regs),}
 #define SMSTATEEN_REGS_SUBLIST \
@@ -864,6 +880,14 @@ static struct vcpu_reg_list zicntr_config = {
 	},
 };
 
+static struct vcpu_reg_list zicond_config = {
+	.sublists = {
+	BASE_SUBLIST,
+	ZICOND_REGS_SUBLIST,
+	{0},
+	},
+};
+
 static struct vcpu_reg_list zicsr_config = {
 	.sublists = {
 	BASE_SUBLIST,
@@ -888,6 +912,14 @@ static struct vcpu_reg_list zihpm_config = {
 	},
 };
 
+static struct vcpu_reg_list xventanacondops_config = {
+	.sublists = {
+	BASE_SUBLIST,
+	XVENTANACONDOPS_REGS_SUBLIST,
+	{0},
+	},
+};
+
 static struct vcpu_reg_list aia_config = {
 	.sublists = {
 	BASE_SUBLIST,
@@ -932,9 +964,11 @@ struct vcpu_reg_list *vcpu_configs[] = {
 	&zbb_config,
 	&zbs_config,
 	&zicntr_config,
+	&zicond_config,
 	&zicsr_config,
 	&zifencei_config,
 	&zihpm_config,
+	&xventanacondops_config,
 	&aia_config,
 	&smstateen_config,
 	&fp_f_config,
-- 
2.34.1

