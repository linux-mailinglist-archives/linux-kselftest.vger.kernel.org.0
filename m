Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1858B7A5818
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Sep 2023 05:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbjISDyi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Sep 2023 23:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbjISDya (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Sep 2023 23:54:30 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3D3114
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Sep 2023 20:54:21 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso4304075a12.3
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Sep 2023 20:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1695095660; x=1695700460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qG0THHfqd29pFm5IKGVp9LhjXXrDBkkPoZXxS9VdOEc=;
        b=TZ5xxNnGjVRaLITJk3VaXZt0svnu+dsuSNrWUWMrrRCj1qJ8qH6SaI7xv/32I9oWxn
         o8aaWxjf973SBHkiewutc38hEcYTyWxsLV5iXy/Ed/hDcRzQ1FJq8oSgRqe6CXnfGrUC
         KA7/3ID8NjKCk61avxOuetX7QwIl4yQYrmEqmig1tMTUBeX568kiQbE/euK+50KQbLJT
         aOevDDNdnrwO0UO+5SbwYxrW41oCbtFAON1gW1ROL03Isz0MRq6KOJEtdtXTqqwy67nt
         Vi54KQ9482+kmbekMOtYicgs4ke5YXO//DwZaDjXsg71TFERrlZAxlfUJAG3KdWvmXGh
         T1RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695095660; x=1695700460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qG0THHfqd29pFm5IKGVp9LhjXXrDBkkPoZXxS9VdOEc=;
        b=DM+y+6IaynxBkvqZD8rhn6BAZqnIFYcoiVT4HZE6mtSL08G+Sfyo5qjrGKpBGToQ4B
         V+5c6MiI9p9e7NIruet0hwwOVJVn6J6vKj2p7ekK9ykZs2i+BedclxTKL3eJzhsS25d+
         pJ9RII+P+QqW4PVQbN7Vq9tg7daEoRJeoOXFa9Cl5+2ct9dIfBYQLZM629Fmbt6ulBN9
         TO1/LOjelcrEw557ZP2eNih9wXTC7PKuFQsRJKIYYULq8j8ecqMEsa4y4ECV6GHF2MEY
         aEIa72GZZn9rNpkiVhd8WSLBdbrv9CxuHTrdWuOwWZqtrf8NQYBZAk9ENDjBlo/YwjDx
         +PVA==
X-Gm-Message-State: AOJu0YxRwSf3Y9pZQld+pSikU9M7qxHJX+wUXy25mPMyWO5FJV1HSui2
        QSOJ8Y1TLCbmJLpkJWi3lXPhIA==
X-Google-Smtp-Source: AGHT+IHwzyVCSxSfbot4344shbzr2uf/C2yvQ6tC3JEnX6sYep3WTmCTb6K0EpxLdSLw7odC/FlDig==
X-Received: by 2002:a05:6a20:7288:b0:135:7975:f55 with SMTP id o8-20020a056a20728800b0013579750f55mr13927437pzk.47.1695095660280;
        Mon, 18 Sep 2023 20:54:20 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id 3-20020a17090a034300b00273fc850342sm4000802pjf.20.2023.09.18.20.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 20:54:19 -0700 (PDT)
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
Subject: [PATCH 4/7] RISC-V: KVM: Allow Zicond extension for Guest/VM
Date:   Tue, 19 Sep 2023 09:23:40 +0530
Message-Id: <20230919035343.1399389-5-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230919035343.1399389-1-apatel@ventanamicro.com>
References: <20230919035343.1399389-1-apatel@ventanamicro.com>
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

We extend the KVM ISA extension ONE_REG interface to allow KVM
user space to detect and enable Zicond extension for Guest/VM.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/include/uapi/asm/kvm.h | 1 +
 arch/riscv/kvm/vcpu_onereg.c      | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/asm/kvm.h
index e030c12c7dfc..35ceb38a4eff 100644
--- a/arch/riscv/include/uapi/asm/kvm.h
+++ b/arch/riscv/include/uapi/asm/kvm.h
@@ -139,6 +139,7 @@ enum KVM_RISCV_ISA_EXT_ID {
 	KVM_RISCV_ISA_EXT_ZIHPM,
 	KVM_RISCV_ISA_EXT_SMSTATEEN,
 	KVM_RISCV_ISA_EXT_XVENTANACONDOPS,
+	KVM_RISCV_ISA_EXT_ZICOND,
 	KVM_RISCV_ISA_EXT_MAX,
 };
 
diff --git a/arch/riscv/kvm/vcpu_onereg.c b/arch/riscv/kvm/vcpu_onereg.c
index 17a847a1114b..d3ca4969c985 100644
--- a/arch/riscv/kvm/vcpu_onereg.c
+++ b/arch/riscv/kvm/vcpu_onereg.c
@@ -47,6 +47,7 @@ static const unsigned long kvm_isa_ext_arr[] = {
 	KVM_ISA_EXT_ARR(ZICBOM),
 	KVM_ISA_EXT_ARR(ZICBOZ),
 	KVM_ISA_EXT_ARR(ZICNTR),
+	KVM_ISA_EXT_ARR(ZICOND),
 	KVM_ISA_EXT_ARR(ZICSR),
 	KVM_ISA_EXT_ARR(ZIFENCEI),
 	KVM_ISA_EXT_ARR(ZIHINTPAUSE),
@@ -95,6 +96,7 @@ static bool kvm_riscv_vcpu_isa_disable_allowed(unsigned long ext)
 	case KVM_RISCV_ISA_EXT_ZBB:
 	case KVM_RISCV_ISA_EXT_ZBS:
 	case KVM_RISCV_ISA_EXT_ZICNTR:
+	case KVM_RISCV_ISA_EXT_ZICOND:
 	case KVM_RISCV_ISA_EXT_ZICSR:
 	case KVM_RISCV_ISA_EXT_ZIFENCEI:
 	case KVM_RISCV_ISA_EXT_ZIHINTPAUSE:
-- 
2.34.1

