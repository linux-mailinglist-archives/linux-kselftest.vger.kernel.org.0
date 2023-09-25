Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4FA47AD948
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Sep 2023 15:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbjIYNjh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Sep 2023 09:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbjIYNjg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Sep 2023 09:39:36 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF3C107
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Sep 2023 06:39:28 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c5c91bec75so42654725ad.3
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Sep 2023 06:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1695649168; x=1696253968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gV6mGP1XJq3xnVTxbQIHP/QVhp+GQJw7IZPtitWR2ag=;
        b=A6WdT3Ms5qTGJi16CIzV3LYdlwDMjnbBLsEPGCDcOKQcyZA921afkObt2VLhpHKZLC
         6MfulKaJCE7NanK54WJ2oJjaohRAYzI2ByVbfFc2HKj9UOB4rc/whHNUmS5eHdtgJyXi
         AINXkgngAKvugN8i1lKGeAyf/9UmFacUHb1lbXIXHMJGhqg0yopKuLT7FKKoE77efTk+
         /BNs8WWIfyN50EM9vgT4Rr7YiMJueTGOWSGC65XyiO49OowomkkyCxMFYN4FFmgiC78s
         +G9bBk6uiDNkruPtvj6vjcrseTHAOWydCDGUhJ4H/JTP8P4n57RSxXQZpidOBOA78eoy
         E3YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695649168; x=1696253968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gV6mGP1XJq3xnVTxbQIHP/QVhp+GQJw7IZPtitWR2ag=;
        b=MXhj9yPQuHCpj0vJmUZeYBIHeXeJLlJ5MxfasZClyt6dh52OUymMBCp110d7zw7xOK
         zipXauW/utVVbe4rd58QZRoWZPokvWYpxcnzgNa8rZ9r+V5iBN7ej1R/tFQw4qMsVLk6
         f2QTykGgWInIZBabkyJAGeGrYP+uZjRY+JbuEqXCRYyCwo+gjqQ6F6sA2GdmeLSa83de
         zF7+B5LCZh3KVbzexArAXoqXdx26zxCsGuLkbwSWTctBrY//7Z6al62DemdrZNgE6urt
         CaggJUejNrO5ld90mmdO4gHsjNW31ir6gcZLgQ+82EOqpRlEZpE4h8/F7S4muwawzS9f
         00Lw==
X-Gm-Message-State: AOJu0YzdJ5wIHYfuabI4t46FsBRFBQhx1n2N3UluCmTaEtyJ5JKfPJod
        glr8ER/0sx7H/Qz6RW3BNWLubw==
X-Google-Smtp-Source: AGHT+IEDXrhyEx6eaSZ6frtjTYSejpa1s2eAnJYzebqP5g4HzZCjNkN/tfngtcIrEJra3Z7D04o6Dg==
X-Received: by 2002:a17:902:c10c:b0:1c5:741d:f388 with SMTP id 12-20020a170902c10c00b001c5741df388mr4868718pli.9.1695649167770;
        Mon, 25 Sep 2023 06:39:27 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id p11-20020a170902eacb00b001c625d6ffccsm969433pld.129.2023.09.25.06.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 06:39:27 -0700 (PDT)
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
Subject: [PATCH v2 2/9] RISC-V: Detect XVentanaCondOps from ISA string
Date:   Mon, 25 Sep 2023 19:08:52 +0530
Message-Id: <20230925133859.1735879-3-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230925133859.1735879-1-apatel@ventanamicro.com>
References: <20230925133859.1735879-1-apatel@ventanamicro.com>
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

The Veyron-V1 CPU supports custom conditional arithmetic and
conditional-select/move operations referred to as XVentanaCondOps
extension. In fact, QEMU RISC-V also has support for emulating
XVentanaCondOps extension.

Let us detect XVentanaCondOps extension from ISA string available
through DT or ACPI.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
---
 arch/riscv/include/asm/hwcap.h | 1 +
 arch/riscv/kernel/cpufeature.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 0f520f7d058a..b7efe9e2fa89 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -59,6 +59,7 @@
 #define RISCV_ISA_EXT_ZIFENCEI		41
 #define RISCV_ISA_EXT_ZIHPM		42
 #define RISCV_ISA_EXT_SMSTATEEN		43
+#define RISCV_ISA_EXT_XVENTANACONDOPS	44
 
 #define RISCV_ISA_EXT_MAX		64
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 3755a8c2a9de..3a31d34fe709 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -182,6 +182,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(svinval, RISCV_ISA_EXT_SVINVAL),
 	__RISCV_ISA_EXT_DATA(svnapot, RISCV_ISA_EXT_SVNAPOT),
 	__RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
+	__RISCV_ISA_EXT_DATA(xventanacondops, RISCV_ISA_EXT_XVENTANACONDOPS),
 };
 
 const size_t riscv_isa_ext_count = ARRAY_SIZE(riscv_isa_ext);
-- 
2.34.1

