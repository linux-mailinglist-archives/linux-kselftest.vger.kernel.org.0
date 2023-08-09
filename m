Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4E2775091
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Aug 2023 03:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjHIBxQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Aug 2023 21:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbjHIBxM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Aug 2023 21:53:12 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A6D1BD3
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Aug 2023 18:53:11 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b8b2b60731so39944655ad.2
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Aug 2023 18:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1691545991; x=1692150791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5q2lf0ErqSwJrn3JbgeuhvaoxCnqdWFIkpf1V4h3asg=;
        b=KQfNpvZbwPfJw4InJH3Gop3jL8C3JwJPDbX7mWsYj121ubZsb8RGRA2aI9F/PwCRVF
         VythodBAkVElVzcYFFbi1lDli1YK6i88YBAyJ4izWsKPC7TciTmEvVoHSJFMyct3/A1C
         QCjr27vWn57/CGMNexhGRhDrj7RKrU+Fm1uLuqZAWixGoxJgCb59LKtThbuUpPvCKADL
         SV/MKjcJ/vt528cSHhB3ZDKQVmxe2Pl4qLNnNm+Usxd5J+XvPi8hxQoSr+RdZwvLVwxq
         XkZe4sqD/xdLk4MoYZctFEDxxFdlv5Rih9i/apAmP5jgpZqpVJTVwvCWYM3sPWvQD09+
         Qnvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691545991; x=1692150791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5q2lf0ErqSwJrn3JbgeuhvaoxCnqdWFIkpf1V4h3asg=;
        b=M/PPFGMvPag+Vj0poWZGH96+rmPNKdMuRTL2scRwBBenoBT/iaeLR02b6VRmQddJCo
         GEiKglevoR1G9O9YSSeQhJ6Z6dGEu6s025n7OW4Vpgdt1m9K8YuMdM0eaWLEsg5Mmx10
         t79Mv1k/rUcWzzwn50vlHO1VytxIcjyrEHie9UNjhCaAO9fDMvXJaaQTaXK8hq7jV003
         ScCB1p6MvZ8g4B+W0pQ+twLdkO8GQYPAGZzvw/qTdXRiEt8AMBTjjaBpgSG/VMPRSQ2f
         i7jXRq/IorgSI/5ubuXHFQ2WLWYC/lSE9CB4jLYQyzvOzkSJ0ral1PmAa8P12aQ3fEb+
         PxBw==
X-Gm-Message-State: AOJu0YweKiHAcL6WgrPy/5a21t7PLMn3Eavq4GIpU0tyAi8BuVXrsrJa
        7dZGv8knzwGz4qjK2D+8U+Q12g==
X-Google-Smtp-Source: AGHT+IGg+v5KFzlU+jQrk/Y4IPjZqAfK6IzCZuHeB5tm9d5fjhnx1QdE7SY5R0FlUS9hkHWQ+fZbQA==
X-Received: by 2002:a17:902:d2cf:b0:1bc:3f9b:d96 with SMTP id n15-20020a170902d2cf00b001bc3f9b0d96mr1444563plc.49.1691545990966;
        Tue, 08 Aug 2023 18:53:10 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id bj7-20020a170902850700b001b87bedcc6fsm9657591plb.93.2023.08.08.18.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 18:53:10 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     charlie@rivosinc.com, conor@kernel.org, paul.walmsley@sifive.com,
        palmer@rivosinc.com, aou@eecs.berkeley.edu, anup@brainfault.org,
        konstantin@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        mick@ics.forth.gr, jrtc27@jrtc27.com, rdunlap@infradead.org,
        alexghiti@rivosinc.com
Subject: [PATCH v9 3/4] RISC-V: mm: Update pgtable comment documentation
Date:   Tue,  8 Aug 2023 18:51:09 -0700
Message-Id: <20230809015110.3290774-4-charlie@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230809015110.3290774-1-charlie@rivosinc.com>
References: <20230809015110.3290774-1-charlie@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
index 2611c1324a7c..76907b95109a 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -849,14 +849,16 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
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
2.34.1

