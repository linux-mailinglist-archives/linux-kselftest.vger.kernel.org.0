Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 998047A88D7
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Sep 2023 17:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236839AbjITPqu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Sep 2023 11:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236867AbjITPqr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Sep 2023 11:46:47 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96BCF3
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Sep 2023 08:46:40 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c0c6d4d650so62522335ad.0
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Sep 2023 08:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1695224800; x=1695829600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JEpzhn0/r3h7zE+n/9TA9uRn8epPj0d0ldcwcNh6iPI=;
        b=pnsIS2+MTr2syyrsxFZt/NPneM/jbrZM+vk1hWMRdcktLCahZ5qNh6DdmvHWfLanSC
         dMQoxCi0zx9jP7VvVr56THiz0lVK53+LZwo918oBaWIKxGP2IhN0ZqEEvboE/P39Ae+p
         xjvUwmA3QiXbuJ1Ao389VLBWeiLw8qa7eWlfXdYadW/5ftumg9+MEE0IkVlazRqrhqPK
         +Vt6+ZUldom8MdnnhmP7fWC6M62qLLlUgYToMcobwhptAeFgTP//T5KHqO/QJdrWufg4
         3Uz5LPOmZBwhemVi5dy9akfH6dEJxTvghjgY8ClQcigL77zLBFivRv6Vqfjw3iyOWtG0
         bs5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695224800; x=1695829600;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JEpzhn0/r3h7zE+n/9TA9uRn8epPj0d0ldcwcNh6iPI=;
        b=AevIOrbteoa1DRXavszqsSIX9AAew/oaNACeD1f4hxWa2FEV9tdXe/pUPBZAZhZopF
         LshyMHNknVIAkt6gSuPZFXjZm2BxtCkeaVYkQnw0gpS6fYrDVlKiK9c6NG7zjLiT7dhQ
         MF82VL3S3SCKn9wYGZIO6YlWHOF5+ANb3XBihpXAaUXHrZv9FAYK9dS480g29dZavKul
         Zd6YBqEgRBd8uO0pBarGg62Ey6EsRI+6Eps/T6B8IlNzQaHOBxxhQ0ZVcNbWdLtYlhK2
         a1IRd+NftXCs6277RogUAtPxOSL+mkQbww1JGeYAMFgQKdza2AjONkfaUgrr8pUzk/AP
         jAdg==
X-Gm-Message-State: AOJu0YwM5J6tLppEzNuz1afWwNU3Nmi68MG+A9hyieOX3fniXgnDQM75
        PAgZeWxRibo9dGK8lCE/nH10accpwgWr/bltglc=
X-Google-Smtp-Source: AGHT+IH0BX50WXqhda/5zYoaq97TFshDXBpBPxC7g6dc7L/kU35EsxkrRUvI9RxqMXaOowOkBXyeUQ==
X-Received: by 2002:a17:902:c142:b0:1c4:bc8:4b64 with SMTP id 2-20020a170902c14200b001c40bc84b64mr2711290plj.5.1695224799935;
        Wed, 20 Sep 2023 08:46:39 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([171.76.85.109])
        by smtp.gmail.com with ESMTPSA id m7-20020a170902db0700b001c0de73564dsm11995153plx.205.2023.09.20.08.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 08:46:39 -0700 (PDT)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Atish Patra <atishp@atishpatra.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Andrew Jones <ajones@ventanamicro.com>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>
Subject: [PATCH v2 4/4] KVM: riscv: selftests: Selectively filter-out AIA registers
Date:   Wed, 20 Sep 2023 21:16:08 +0530
Message-Id: <20230920154608.1447057-5-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230920154608.1447057-1-apatel@ventanamicro.com>
References: <20230920154608.1447057-1-apatel@ventanamicro.com>
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

Currently the AIA ONE_REG registers are reported by get-reg-list
as new registers for various vcpu_reg_list configs whenever Ssaia
is available on the host because Ssaia extension can only be
disabled by Smstateen extension which is not always available.

To tackle this, we should filter-out AIA ONE_REG registers only
when Ssaia can't be disabled for a VCPU.

Fixes: 477069398ed6 ("KVM: riscv: selftests: Add get-reg-list test")
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
---
 .../selftests/kvm/riscv/get-reg-list.c        | 23 +++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
index 76c0ad11e423..9f99ea42f45f 100644
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
+		return isa_ext_cant_disable[KVM_RISCV_ISA_EXT_SSAIA];
 	default:
 		break;
 	}
@@ -71,14 +82,22 @@ static inline bool vcpu_has_ext(struct kvm_vcpu *vcpu, int ext)
 
 void finalize_vcpu(struct kvm_vcpu *vcpu, struct vcpu_reg_list *c)
 {
+	unsigned long isa_ext_state[KVM_RISCV_ISA_EXT_MAX] = { 0 };
 	struct vcpu_reg_sublist *s;
+	int rc;
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

