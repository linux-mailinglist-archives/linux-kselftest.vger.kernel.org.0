Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA8E7A88CD
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Sep 2023 17:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236783AbjITPqg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Sep 2023 11:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236769AbjITPqf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Sep 2023 11:46:35 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9408D3
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Sep 2023 08:46:28 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-690d8fb3b7eso997324b3a.1
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Sep 2023 08:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1695224788; x=1695829588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sAr/f3EP2NDO5TcbIFTZtzzZHLVf3n++r+Cj6Pd3+Fs=;
        b=Drsvbd7BiH5l19WrmmwzoEKJC8NtpPdS0J9DbFak31f859CyaM6sOmnUBMDp/IfL1F
         LkJ5jteocsE2/eQBBmGI9+fDXDxTR7EbIwNIr1Bzsb+oidwi2oqYqFwN1ki2jk1CNGgz
         gPXgEMAJ2R35uCLOUn6qRKZU6vrWFLf7kyincqCPQ6NgH8cpf7BNzIwpaZv+8bgVvKqq
         UXF9DYK/3uZvaKEe3AF0xPCHYdr8qkVSUo1nLUe+bdQMTfiNPXLMoqr6MeuNXvYu+pva
         YJ1Ky/7r9zVEZVb4PEgymE0HF8ibqr4rV9kS9nmDK7xgrkIwJXjPB2GQXdkUGmtnTtoD
         JPRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695224788; x=1695829588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sAr/f3EP2NDO5TcbIFTZtzzZHLVf3n++r+Cj6Pd3+Fs=;
        b=k0JVYjPZjYphcJULz8o4TZHOVnZInUEGPBde9l8LeYc3uLyvtu6wHT4/wr5PdzHNPc
         iQMS1MCqoBndilSVR5beoE96sR0mUQUV0U2o7p3FWulQ4+vFJ8F5LXAlDzs/ol/qPQs1
         X/TwlETgHBqdHl6fQLoQCv/BRWHQioec1ttpJjTVu9pKvhWXJ9rvWJW5fuuj0j8dzh+P
         Z1+el47Sk9X/DWwVp/C50XlT4x6NYHx+jyB4kgzhKt3+uDi2+3fIT5GXJ1gm1dCFK0Tz
         3Fs9y44EdGnSQT3HCQFR4KJU07On/SPYArFav9vyK/GvRScdcNiizwR4WQf+cbqapGwV
         iOpQ==
X-Gm-Message-State: AOJu0YwSOGZRMkr6olsJrPLI3rYX/ycx10mIlSisKRmnr91ONOQ18+sa
        Y3OSNCD1Vm27Wbj/Cr6OulWWKg==
X-Google-Smtp-Source: AGHT+IGnfiCYXMUmmIwvFThBwyKCEOTkAK3sfnR/6AJriLPtWNmFBovg3gxnmLqki1f202xQpXq59A==
X-Received: by 2002:a05:6a20:8410:b0:12e:5f07:7ede with SMTP id c16-20020a056a20841000b0012e5f077edemr3874367pzd.41.1695224787947;
        Wed, 20 Sep 2023 08:46:27 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([171.76.85.109])
        by smtp.gmail.com with ESMTPSA id m7-20020a170902db0700b001c0de73564dsm11995153plx.205.2023.09.20.08.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 08:46:27 -0700 (PDT)
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
Subject: [PATCH v2 1/4] RISC-V: KVM: Fix KVM_GET_REG_LIST API for ISA_EXT registers
Date:   Wed, 20 Sep 2023 21:16:05 +0530
Message-Id: <20230920154608.1447057-2-apatel@ventanamicro.com>
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

The ISA_EXT registers to enabled/disable ISA extensions for VCPU
are always available when underlying host has the corresponding
ISA extension. The copy_isa_ext_reg_indices() called by the
KVM_GET_REG_LIST API does not align with this expectation so
let's fix it.

Fixes: 031f9efafc08 ("KVM: riscv: Add KVM_GET_REG_LIST API support")
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/kvm/vcpu_onereg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
index 1b7e9fa265cb..e7e833ced91b 100644
--- a/arch/riscv/kvm/vcpu_onereg.c
+++ b/arch/riscv/kvm/vcpu_onereg.c
@@ -842,7 +842,7 @@ static int copy_isa_ext_reg_indices(const struct kvm_vcpu *vcpu,
 		u64 reg = KVM_REG_RISCV | size | KVM_REG_RISCV_ISA_EXT | i;
 
 		isa_ext = kvm_isa_ext_arr[i];
-		if (!__riscv_isa_extension_available(vcpu->arch.isa, isa_ext))
+		if (!__riscv_isa_extension_available(NULL, isa_ext))
 			continue;
 
 		if (uindices) {
-- 
2.34.1

