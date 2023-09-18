Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38AC67A51AA
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Sep 2023 20:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjIRSHh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Sep 2023 14:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjIRSH0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Sep 2023 14:07:26 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACDB2CD7
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Sep 2023 11:07:16 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c46b30a1ceso15885185ad.3
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Sep 2023 11:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1695060436; x=1695665236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bpLoyMijHBoqQ//iQuuQg2kQqMONVlRrgQK7tTPKQvg=;
        b=mhaPApHPeu6Ramd6n9ddV0AZ872+Rnt6Mz9YNzMaEbyJnre9Y0ROlOAG39xjKofO9t
         b5/omxnvKmE6q4xNcupPKPKNCI+SvyxcyZ+Fl7unkwCbGB7NPDJ88VMGY03Xwhszl+el
         5Sk8VFU7er7EHryhjCpjZXS0rAOwnf/UrUoPe7z8KQA6BNG+JLe5ygXQcrthkxpzUcSl
         Y3u9H/a1G69tb2O/UMLu5nw6tfYvtzkpmi2BK2HJ1FHOh+qIJMMnWPf1qzWYWzKpjhuc
         pB6Iq/thu3ptdvZQHFPx/YZBOqaL1VRNVNGJS5P9//oyO41Xm1rH+RLcbI1aCE2/yH+w
         NSLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695060436; x=1695665236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bpLoyMijHBoqQ//iQuuQg2kQqMONVlRrgQK7tTPKQvg=;
        b=gLUJHT6Ann0jJRETz1M4gmak75E9+aeFSFSdK39u+m0EyfFRggf77oeZGw3GMVu0pb
         +TxbHyyH/oI70I4Uz6o12K3uS7lSAqIMLgWgiXQ11e3T61jfPo7/hBMkBqG9ii+j8OdV
         eDJW75IGUD3BLxIjHlL0E/lnBSXqtmf1oGDtAj1yVr25Hhx7Z64ILJ7Av6VTM1ExJXP+
         WHMmC/IRIF0ptwfglJLtq7iCbpVdSXzspEawrSzsTIa92j+gAehbs1yFB8mi0b+gOMag
         gxEkiR+2EPkCEXJpRiHgaDo4j2jlWUIKl7nuBjwq0MscpZO6vr4aUClph9uE4cKsCXRU
         YQRg==
X-Gm-Message-State: AOJu0YwOuvGNvCP/CLgoz13hnSfElG7oDJAj1dcEw6iMfeF8yfGrsG0Y
        nT8HwQpztz6yt42jZp4zaIJGuw==
X-Google-Smtp-Source: AGHT+IG7/yjGEY6FtMJ+Y1Dl4iuR/zuJXn3aFtsAD+Wt3c7P+oz0dDSdwrMz0aB8dDmosI1me7MJ+Q==
X-Received: by 2002:a17:902:728a:b0:1bb:d048:3173 with SMTP id d10-20020a170902728a00b001bbd0483173mr10004616pll.61.1695060435836;
        Mon, 18 Sep 2023 11:07:15 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id h7-20020a170902704700b001aaf2e8b1eesm8556720plt.248.2023.09.18.11.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 11:07:15 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Andrew Jones <ajones@ventanamicro.com>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 4/4] KVM: riscv: selftests: Selectively filter-out AIA registers
Date:   Mon, 18 Sep 2023 23:36:46 +0530
Message-Id: <20230918180646.1398384-5-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230918180646.1398384-1-apatel@ventanamicro.com>
References: <20230918180646.1398384-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently the AIA ONE_REG registers are reported by get-reg-list
as new registers for various vcpu_reg_list configs whenever Ssaia
is available on the host because Ssaia extension can only be
disabled by Smstateen extension which is not always available.

To tackle this, we should filter-out AIA ONE_REG registers only
when Ssaia can't be disabled for a VCPU.

Fixes: 477069398ed6 ("KVM: riscv: selftests: Add get-reg-list test")
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 .../selftests/kvm/riscv/get-reg-list.c        | 23 +++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
index 76c0ad11e423..85907c86b835 100644
--- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
+++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
@@ -12,6 +12,8 @@
 
 #define REG_MASK (KVM_REG_ARCH_MASK | KVM_REG_SIZE_MASK)
 
+static bool isa_ext_cant_disable[KVM_RISCV_ISA_EXT_MAX];
+
 bool filter_reg(__u64 reg)
 {
 	switch (reg & ~REG_MASK) {
@@ -48,6 +50,15 @@ bool filter_reg(__u64 reg)
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZIFENCEI:
 	case KVM_REG_RISCV_ISA_EXT | KVM_RISCV_ISA_EXT_ZIHPM:
 		return true;
+	/* AIA registers are always available when Ssaia can't be disabled */
+	case KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CSR_AIA_REG(siselect):
+	case KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CSR_AIA_REG(iprio1):
+	case KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CSR_AIA_REG(iprio2):
+	case KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CSR_AIA_REG(sieh):
+	case KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CSR_AIA_REG(siph):
+	case KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CSR_AIA_REG(iprio1h):
+	case KVM_REG_RISCV_CSR | KVM_REG_RISCV_CSR_AIA | KVM_REG_RISCV_CSR_AIA_REG(iprio2h):
+		return isa_ext_cant_disable[KVM_RISCV_ISA_EXT_SSAIA] ? true : false;
 	default:
 		break;
 	}
@@ -71,14 +82,22 @@ static inline bool vcpu_has_ext(struct kvm_vcpu *vcpu, int ext)
 
 void finalize_vcpu(struct kvm_vcpu *vcpu, struct vcpu_reg_list *c)
 {
+	int rc;
 	struct vcpu_reg_sublist *s;
+	unsigned long isa_ext_state[KVM_RISCV_ISA_EXT_MAX] = { 0 };
+
+	for (int i = 0; i < KVM_RISCV_ISA_EXT_MAX; i++)
+		__vcpu_get_reg(vcpu, RISCV_ISA_EXT_REG(i), &isa_ext_state[i]);
 
 	/*
 	 * Disable all extensions which were enabled by default
 	 * if they were available in the risc-v host.
 	 */
-	for (int i = 0; i < KVM_RISCV_ISA_EXT_MAX; i++)
-		__vcpu_set_reg(vcpu, RISCV_ISA_EXT_REG(i), 0);
+	for (int i = 0; i < KVM_RISCV_ISA_EXT_MAX; i++) {
+		rc = __vcpu_set_reg(vcpu, RISCV_ISA_EXT_REG(i), 0);
+		if (rc && isa_ext_state[i])
+			isa_ext_cant_disable[i] = true;
+	}
 
 	for_each_sublist(c, s) {
 		if (!s->feature)
-- 
2.34.1

