Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB7D57DF1F9
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Nov 2023 13:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235519AbjKBMGf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Nov 2023 08:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235577AbjKBMEj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Nov 2023 08:04:39 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA1C10F7
        for <linux-kselftest@vger.kernel.org>; Thu,  2 Nov 2023 05:02:07 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1cc394f4cdfso6525205ad.0
        for <linux-kselftest@vger.kernel.org>; Thu, 02 Nov 2023 05:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1698926527; x=1699531327; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ftnYGlHohU4PgAvOLDfsNbFmXMcl+RaArmfMB/fCVZg=;
        b=T+jOFR+8YUBSxO12vO53oCoIukGFpca/JywKIajBwzf3v3VdE/wUsYzG32sjxJVR4c
         +9ZHUOvqPMaGaIUfoSClF44U8nOeXepH6kD0C8KwWbjmNLNzFOn0O47moht18tVoEDv6
         99xwWaKryihz/Euxj8t6JhgQN6gbpmdkpE1LWIYQ/fIi36zj5dirgdtrMqxJd+1o4p1t
         XHsYpr21UJikwH2Cwa10hq/99llIbo33DGLTN34S7daCVPxEd7xF1IIowf13GdD3x4Eq
         WmmpP3yjZQT14KYBbf2q/PZ0E52hnxBNdw9d8U9YqtTK2gK5GWeT0SfdTeHit9XYfOfH
         mVXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698926527; x=1699531327;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ftnYGlHohU4PgAvOLDfsNbFmXMcl+RaArmfMB/fCVZg=;
        b=S04EmRISPYJaHn8gG62OSnHKUPRcT5zW74wEmYmN1Bwun6KeduMjqCeU6/GG85QX/+
         H+2LQD+uoAtYked53MggObskg+Aq82RNHc97lK5Fk37ESpd0GaePPlVGSGaJww9x3/HI
         47St+SqmkyQoujhzzH/+bl4hyo17dzXmHxT/jkwlyOpeNAyYe8FEK6bRpbwiWp/k6gJX
         eESLBdyxH1yriMpe/vJZOvoEFwENQEmgRfwYMPimm1Tu3WVfGBG0A5dNN+xpHTRKgb+2
         L2bYqH21uFT9aXqlVDQhpRDP7UmxqdEKfICBjMah1lofFyyRLj9g8YyreHNEG/iyGkIw
         6jxw==
X-Gm-Message-State: AOJu0YxSnc0A1KOeRGN3TKqcjoNSjW0gWzYjo+vcr32Q7b5bthZLAFpu
        ASyXpqV3LU5lg+mJeYshZp1ERA==
X-Google-Smtp-Source: AGHT+IGak6vYxyYxJboQzPYtlVELlojzQHOYOuIewHMFX+Z9YpUdKomQpySY+4ZD8wRCrq38FcVPbQ==
X-Received: by 2002:a17:902:d50d:b0:1cc:3875:e654 with SMTP id b13-20020a170902d50d00b001cc3875e654mr12967681plg.26.1698926526894;
        Thu, 02 Nov 2023 05:02:06 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id l12-20020a170902f68c00b001cc0f6028b8sm2969008plg.106.2023.11.02.05.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 05:02:06 -0700 (PDT)
From:   Yong-Xuan Wang <yongxuan.wang@sifive.com>
To:     linux-riscv@lists.infradead.org, kvm-riscv@lists.infradead.org
Cc:     greentime.hu@sifive.com, vincent.chen@sifive.com, tjytimi@163.com,
        alex@ghiti.fr, conor.dooley@microchip.com, ajones@ventanamicro.com,
        Yong-Xuan Wang <yongxuan.wang@sifive.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        Haibo Xu <haibo1.xu@intel.com>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] KVM: riscv: selftests: Add Svadu Extension to get-reg-list testt
Date:   Thu,  2 Nov 2023 12:01:25 +0000
Message-Id: <20231102120129.11261-5-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231102120129.11261-1-yongxuan.wang@sifive.com>
References: <20231102120129.11261-1-yongxuan.wang@sifive.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Update the get-reg-list test to test the Svadu Extension is available
for guest OS.

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
---
 .../testing/selftests/kvm/riscv/get-reg-list.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
index 9f99ea42f45f..972538d76f48 100644
--- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
+++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
@@ -49,6 +49,7 @@ bool filter_reg(__u64 reg)
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZICSR:
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZIFENCEI:
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZIHPM:
+	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_SVADU:
 		return true;
 	/* AIA registers are always available when Ssaia can't be disabled */
 	case KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CSR_AIA_REG(siselect):
@@ -340,6 +341,7 @@ static const char *isa_ext_id_to_str(__u64 id)
 		"KVM_RISCV_ISA_EXT_ZICSR",
 		"KVM_RISCV_ISA_EXT_ZIFENCEI",
 		"KVM_RISCV_ISA_EXT_ZIHPM",
+		"KVM_RISCV_ISA_EXT_SVADU",
 	};
 
 	if (reg_off >= ARRAY_SIZE(kvm_isa_ext_reg_name)) {
@@ -700,6 +702,10 @@ static __u64 fp_d_regs[] = {
 	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_D,
 };
 
+static __u64 svadu_regs[] = {
+	KVM_REG_RISCV | KVM_REG_SIZE_ULONG | KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_SVADU,
+};
+
 #define BASE_SUBLIST \
 	{"base", .regs = base_regs, .regs_n = ARRAY_SIZE(base_regs), \
 	 .skips_set = base_skips_set, .skips_set_n = ARRAY_SIZE(base_skips_set),}
@@ -739,6 +745,9 @@ static __u64 fp_d_regs[] = {
 #define FP_D_REGS_SUBLIST \
 	{"fp_d", .feature = KVM_RISCV_ISA_EXT_D, .regs = fp_d_regs, \
 		.regs_n = ARRAY_SIZE(fp_d_regs),}
+#define SVADU_REGS_SUBLIST \
+	{"svadu", .feature = KVM_RISCV_ISA_EXT_SVADU, .regs = svadu_regs, \
+		.regs_n = ARRAY_SIZE(svadu_regs),}
 
 static struct vcpu_reg_list h_config = {
 	.sublists = {
@@ -876,6 +885,14 @@ static struct vcpu_reg_list fp_d_config = {
 	},
 };
 
+static struct vcpu_reg_list svadu_config = {
+	.sublists = {
+	BASE_SUBLIST,
+	SVADU_REGS_SUBLIST,
+	{0},
+	},
+};
+
 struct vcpu_reg_list *vcpu_configs[] = {
 	&h_config,
 	&zicbom_config,
@@ -894,5 +911,6 @@ struct vcpu_reg_list *vcpu_configs[] = {
 	&aia_config,
 	&fp_f_config,
 	&fp_d_config,
+	&svadu_config,
 };
 int vcpu_configs_n = ARRAY_SIZE(vcpu_configs);
-- 
2.17.1

