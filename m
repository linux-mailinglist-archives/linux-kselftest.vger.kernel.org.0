Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68EA57A88D1
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Sep 2023 17:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236769AbjITPqk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Sep 2023 11:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236814AbjITPqj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Sep 2023 11:46:39 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69BDDC
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Sep 2023 08:46:32 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bf6ea270b2so53809615ad.0
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Sep 2023 08:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1695224792; x=1695829592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0WW4VSH0fAhQvFEKg4libvP4KxfqhgcxX9zTpJuWWZQ=;
        b=JTE3Q4KZNmEdUfs+/qgEQ9QGU4qBiEoXXDvkuzh7Y12FlV2UT9u2VeRkPLvlLXBQRt
         cmL+MPPPRg0zZRNrj6oNwTLOkiT6+cHpFqErMXA0jrt0m5OeAsJ50DMoW6F0WBh8QYPY
         s+VuqRmdHOKmxFU+VaBJzZ2lD/1mru24rThiVBFdah+jxtOgMHHH/cSKBD5qSMnjlkdv
         F7kKZOul0ARaXEqqf+AFPu5BSQMu+wW2PG4sN4IgeXhOTLgKSBY31uilyP9gra+JZ3bs
         YLJuDAq6hbjjAWeFFRZBm35V3U77XzQAYfvPG3AO2moqG8HXcuBUg9j/5DMifXU3QiAV
         XkBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695224792; x=1695829592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0WW4VSH0fAhQvFEKg4libvP4KxfqhgcxX9zTpJuWWZQ=;
        b=WhL/SdfOwTS74dyR7Y3jQkaVoxoLKwgKyzLAt0m/yoSOC2D7vPzdq2YhyQT0VVCTpj
         BVvuX2nkghOdVVatanONvMVB0Xz4+yBDqd7AK/qDA+vU59bDKJHo0h7ir/Yk0MVQd/RI
         FVvLucuOvmRRsDNQVHlOnmPXw33WqEyGeDFD2Cw4qEqGOQsCnlIrbmMlUbDwlQQEUQvb
         OfcUgjbFJt0laWohGBBkzC1Qct2kEpl/bSSWDbN0GYlorGXgW6FBw4PRaOpT9iEUFlUI
         SXiQW56EocHP86qreQbn00VNtpXATR5tniY+EulSy+19UIbAs1Ez9a43HjYJReVcJUBD
         H+QQ==
X-Gm-Message-State: AOJu0YzdHuYPMdHpAoUC5+fq99aPjHRO86tPArYiaYMVt/NmtELE1hgj
        bslBxetBy5iaqI6YnLNn+BHb017Qa4jhoXSVMqs=
X-Google-Smtp-Source: AGHT+IEQwIPKCinnV/MX16/4WhhXgBUWvl9vAEkhPYp7GStfJsefOl4SMlV88d8R5cEXT5ASSUov4A==
X-Received: by 2002:a17:902:ed54:b0:1c3:9764:764f with SMTP id y20-20020a170902ed5400b001c39764764fmr2676177plb.48.1695224792293;
        Wed, 20 Sep 2023 08:46:32 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([171.76.85.109])
        by smtp.gmail.com with ESMTPSA id m7-20020a170902db0700b001c0de73564dsm11995153plx.205.2023.09.20.08.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 08:46:31 -0700 (PDT)
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
Subject: [PATCH v2 2/4] RISC-V: KVM: Fix riscv_vcpu_get_isa_ext_single() for missing extensions
Date:   Wed, 20 Sep 2023 21:16:06 +0530
Message-Id: <20230920154608.1447057-3-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230920154608.1447057-1-apatel@ventanamicro.com>
References: <20230920154608.1447057-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The riscv_vcpu_get_isa_ext_single() should fail with -ENOENT error
when corresponding ISA extension is not available on the host.

Fixes: e98b1085be79 ("RISC-V: KVM: Factor-out ONE_REG related code to its own source file")
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/kvm/vcpu_onereg.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
index e7e833ced91b..b7e0e03c69b1 100644
--- a/arch/riscv/kvm/vcpu_onereg.c
+++ b/arch/riscv/kvm/vcpu_onereg.c
@@ -460,8 +460,11 @@ static int riscv_vcpu_get_isa_ext_single(struct kvm_vcpu *vcpu,
 	    reg_num >= ARRAY_SIZE(kvm_isa_ext_arr))
 		return -ENOENT;
 
-	*reg_val = 0;
 	host_isa_ext = kvm_isa_ext_arr[reg_num];
+	if (!__riscv_isa_extension_available(NULL, host_isa_ext))
+		return -ENOENT;
+
+	*reg_val = 0;
 	if (__riscv_isa_extension_available(vcpu->arch.isa, host_isa_ext))
 		*reg_val = 1; /* Mark the given extension as available */
 
-- 
2.34.1

