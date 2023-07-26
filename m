Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CACCB763CDD
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jul 2023 18:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbjGZQqw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jul 2023 12:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbjGZQqj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jul 2023 12:46:39 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B7D26AE
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jul 2023 09:46:34 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1bbc64f9a91so12657645ad.0
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jul 2023 09:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1690389993; x=1690994793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nxXmOdIWe/bZgFmovuliVgy5AL4XQqsEakBY4VilH/8=;
        b=uGj1t6oL4u1fl4y0bUjyIo+gEG6FvyX76N3UvGsKUanjjrHB6wnIUkhEejMij86pkP
         EVcq1qYhmhAsWKH/bTv86zK02/LQZMQq7g4GucihnDv97RSd4YvXnrbgbDWPGh57Gm43
         otyrPfQG7tSPmnn1LK0ZKv6nS+RjBkhyBwtgizouPL3Kq5x8fU1JxqHm8ESNdJya0Equ
         u60fTChXgviIE+TR2UEeszDN/H3aPv73hS0hvyNcKuH0qJi9wFqWw0PjC0ks4SU85S2Z
         5glfdqvmMevya7khD8CyeEfxUGRd305Yi1lCbXYzBjv2vJ/zFMEBiJB9hvll+QMy0/cX
         T8VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690389993; x=1690994793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nxXmOdIWe/bZgFmovuliVgy5AL4XQqsEakBY4VilH/8=;
        b=D6l9QGFdWsFpoRMJEwbZvZy5RE6SernxBDE4G1FVJXTKJ3AiYQTaUDbNCXo7x1lqj9
         7HLTfyRyFt25DG75YIEwBMPuy8etVnXc7JR7UFl2t29Gr6Qjj2LB+ichrvpPX6dCPfKl
         0jLVrA699+nsEWRnXm8lTuIxYWYPTPyHXxekgaGaXrcIz4SmDp7F/kFaOFRCCVfGtjXJ
         xUGpP1TVeqU/P4Jt1ZWcTT3jPqetTlZlwa1ylD6TLqyWsllCOqTiinpVKqaGeaoJ0EaH
         dRswp0zUKuWsyqGXIqaxS6pcOAHP1muYhAWENI3zg3l8IilsFBOeWQqhP1ZojU+HOZgb
         opzg==
X-Gm-Message-State: ABy/qLbQ2bdQPNpmfdG8oEf+NvROasVwbjGqngaOoB+RyUWdvN8mXsrK
        SoAnaPcok1WCYJkloFNYPCphuw==
X-Google-Smtp-Source: APBJJlHd8ZanXubRsLvs8LnpqdeDXtlGfjvqC1HSJQRHauQPQgT6PVzi7mdT5yfnVwFo9B2eoHwlEA==
X-Received: by 2002:a17:902:c205:b0:1b5:219a:cbbd with SMTP id 5-20020a170902c20500b001b5219acbbdmr2429756pll.3.1690389993609;
        Wed, 26 Jul 2023 09:46:33 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id h5-20020a170902f54500b001bb6c5ff4edsm11628870plf.173.2023.07.26.09.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 09:46:33 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     charlie@rivosinc.com, conor@kernel.org, paul.walmsley@sifive.com,
        palmer@rivosinc.com, aou@eecs.berkeley.edu, anup@brainfault.org,
        konstantin@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        mick@ics.forth.gr, jrtc27@jrtc27.com, rdunlap@infradead.org,
        alexghiti@rivosinc.com
Subject: [PATCH v7 3/4] RISC-V: mm: Update pgtable comment documentation
Date:   Wed, 26 Jul 2023 09:45:57 -0700
Message-ID: <20230726164620.717288-4-charlie@rivosinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230726164620.717288-1-charlie@rivosinc.com>
References: <20230726164620.717288-1-charlie@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

sv57 is supported in the kernel so pgtable.h should reflect that.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/include/asm/pgtable.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 530f6a171a2b..cd09ccd876b9 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -841,14 +841,16 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
  * Task size is 0x4000000000 for RV64 or 0x9fc00000 for RV32.
  * Note that PGDIR_SIZE must evenly divide TASK_SIZE.
  * Task size is:
- * -     0x9fc00000 (~2.5GB) for RV32.
- * -   0x4000000000 ( 256GB) for RV64 using SV39 mmu
- * - 0x800000000000 ( 128TB) for RV64 using SV48 mmu
+ * -        0x9fc00000	(~2.5GB) for RV32.
+ * -      0x4000000000	( 256GB) for RV64 using SV39 mmu
+ * -    0x800000000000	( 128TB) for RV64 using SV48 mmu
+ * - 0x100000000000000	(  64PB) for RV64 using SV57 mmu
  *
  * Note that PGDIR_SIZE must evenly divide TASK_SIZE since "RISC-V
  * Instruction Set Manual Volume II: Privileged Architecture" states that
  * "load and store effective addresses, which are 64bits, must have bits
  * 63–48 all equal to bit 47, or else a page-fault exception will occur."
+ * Similarly for SV57, bits 63–57 must be equal to bit 56.
  */
 #ifdef CONFIG_64BIT
 #define TASK_SIZE_64	(PGDIR_SIZE * PTRS_PER_PGD / 2)
-- 
2.41.0

