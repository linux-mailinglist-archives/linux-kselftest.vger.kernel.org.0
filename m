Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 583187AD950
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Sep 2023 15:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbjIYNjt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Sep 2023 09:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232078AbjIYNjr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Sep 2023 09:39:47 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4D011F
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Sep 2023 06:39:41 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c60f1a2652so16003425ad.0
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Sep 2023 06:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1695649181; x=1696253981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G0o9lQ4GgOP7dFq6KPsGtVotlHRRQlDwzXlKCC3Ypps=;
        b=gwCl1sa8ieneOtMpWBzxOynwDwUY4AWoiWG6ZeedXFCFSjA9JHkSAW+2gcDWMafss1
         wVRptBE4st3m8NKHX2A0CkkyXJqwSzSqKssRybbOagQoRfz3tmuTWRXBkH/z2v9iSev5
         SJi+U8zRYsftlfA2qLMCtHgvYZAAaNcIbAK2Sh9gTn2Ck5oLOEOQsbY92/7SpmBLVUyz
         xuRbMvmn76EPyaGDqvMTIg6bPzQW+TyvwdmsN/HUc0KnMxqdWMnEvYTGEwvF/XUpwpUP
         s4QnlK4QIGjGLpK9PY40RcH1FBb4774L8JvMNXth6f2rjqkbqD3H7HZLcgFDO4izF5se
         99Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695649181; x=1696253981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G0o9lQ4GgOP7dFq6KPsGtVotlHRRQlDwzXlKCC3Ypps=;
        b=sF/qPFQtVbyTmkvADOt+I421e8N9MgT9XtFcMC8rc1NTxYCZhvE0XXot3eg363VwOR
         R7MfhBD9h2CPqQ7qZMG+BqdO+N9qGrAT36+Zb3+7AzqUstma/+qFHAahthyONU71UYVM
         6DrqFuAVMpHJHltTitn8JMCKNeTtexLC+2q/7F4ytjDmrqcxaafJzVAXDRVN4TYA2DEg
         Sv6trnLKSmdAjzmLgS25gyU1N5rcrUvoH44bUQ620oW2w7Sqfy1KrzrWBgBIqdioiS8B
         GWxCK49pCoLEEXjo/OGhJ/rIlHEMMu79d2sFEh26KTln350dKR81VbprLpVW0htxB07b
         0kSg==
X-Gm-Message-State: AOJu0YzXpZ2UFB/NQ9rrGZCJ1Iw86/b2qBhvucJGZ0fqqU/l/eMikmUg
        QdeOnyice2k9vF5F45Rwd5owtQ==
X-Google-Smtp-Source: AGHT+IHWCYspI/fUj+Ig0k3L9hYf5Uzb2FzPkjigw9xzhpmfqfpqTqSt/ibnnqx7qGmYx7Sty1gsrA==
X-Received: by 2002:a17:902:e5d1:b0:1c3:868f:5958 with SMTP id u17-20020a170902e5d100b001c3868f5958mr14239969plf.20.1695649180488;
        Mon, 25 Sep 2023 06:39:40 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.165.210])
        by smtp.gmail.com with ESMTPSA id p11-20020a170902eacb00b001c625d6ffccsm969433pld.129.2023.09.25.06.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 06:39:40 -0700 (PDT)
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
Subject: [PATCH v2 4/9] RISC-V: Detect Zicond from ISA string
Date:   Mon, 25 Sep 2023 19:08:54 +0530
Message-Id: <20230925133859.1735879-5-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230925133859.1735879-1-apatel@ventanamicro.com>
References: <20230925133859.1735879-1-apatel@ventanamicro.com>
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

The RISC-V integer conditional (Zicond) operation extension defines
standard conditional arithmetic and conditional-select/move operations
which are inspired from the XVentanaCondOps extension. In fact, QEMU
RISC-V also has support for emulating Zicond extension.

Let us detect Zicond extension from ISA string available through
DT or ACPI.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/include/asm/hwcap.h | 1 +
 arch/riscv/kernel/cpufeature.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index b7efe9e2fa89..15bafc02ffd4 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -60,6 +60,7 @@
 #define RISCV_ISA_EXT_ZIHPM		42
 #define RISCV_ISA_EXT_SMSTATEEN		43
 #define RISCV_ISA_EXT_XVENTANACONDOPS	44
+#define RISCV_ISA_EXT_ZICOND		45
 
 #define RISCV_ISA_EXT_MAX		64
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 3a31d34fe709..7f683916f2c2 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -167,6 +167,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(zicbom, RISCV_ISA_EXT_ZICBOM),
 	__RISCV_ISA_EXT_DATA(zicboz, RISCV_ISA_EXT_ZICBOZ),
 	__RISCV_ISA_EXT_DATA(zicntr, RISCV_ISA_EXT_ZICNTR),
+	__RISCV_ISA_EXT_DATA(zicond, RISCV_ISA_EXT_ZICOND),
 	__RISCV_ISA_EXT_DATA(zicsr, RISCV_ISA_EXT_ZICSR),
 	__RISCV_ISA_EXT_DATA(zifencei, RISCV_ISA_EXT_ZIFENCEI),
 	__RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
-- 
2.34.1

