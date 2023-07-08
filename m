Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1418F74BAEB
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jul 2023 03:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbjGHBMW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Jul 2023 21:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232449AbjGHBMU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Jul 2023 21:12:20 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C5B210B
        for <linux-kselftest@vger.kernel.org>; Fri,  7 Jul 2023 18:12:19 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b8ad8383faso17038105ad.0
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Jul 2023 18:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1688778739; x=1691370739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VGYD7N8wGDu1tDg8VZbK81LUzFuUntAfMahEoaG4sqc=;
        b=HGN3ju79/NcRtAH1rWTzt1SF66qlIOEIPW+h8YCZSLaemLUac5sLeNcc06JOpcpXYS
         Cj+44tx2Z+rwnRiNelURAceDB/qdaKXjyGvhTuZuZecJIPAZ93DUuWf9RMS8856fmHx8
         Umn9pcJZq+zDFbW3kfivmOjwAuguRCJGOID7fJdAs9Nbn12i9eOGzLQ76DGuAdP1h2/F
         EC/pD0QZPhElZ7NCVIs4iLArjS3xtiJrVYm/2wZeUdSifvbekOHDtDtmS8cMIhwN9VIH
         81Hbh7TQSzo/OJgjK4nyg7wVpciIrnm85nU2hbGdj1OHDOVQwJk4nRSRz6OyiZoPcTy9
         ci6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688778739; x=1691370739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VGYD7N8wGDu1tDg8VZbK81LUzFuUntAfMahEoaG4sqc=;
        b=jvimAF71u1VMw109MaSxk540xAEXihL4HcLRcmosOS8uzdifGMHuXZnEHF/TEiNEfS
         VVjDNuhH/9HVyzsbE7H5k486vIMin8ejXO0hZt1l+C5ffE/kTIG4zQzeSaRvJgJmgZeo
         8JvGRf+C1bAVM23yo89KNJ06eO5M6nYp/GDAF/Wb5/2er0bkpl91Y4i5dCUNX5CAO9WC
         jnKa+r++TBy91LUWJzMvPFHjbyj0994UMkxSvj643B5nV0sTU5bSNfrVyY/qyJJZIqai
         BoxB94rT7Fht8FBMzovVna29jMwGyOADlprc9XFmNPE8fhL5NIjvqMp64hqO7H34Gu75
         rccg==
X-Gm-Message-State: ABy/qLYE+OfBiFSFLPYjSx5s/hXh1h9/ZWmVKnLDZoKH4eJBO1vfrEzA
        4V+QlpZgIV6/o9ZCHJPzPwIyaQ==
X-Google-Smtp-Source: APBJJlHkZ1VNL0aalCS0nI4K5MUssbBtfN29EiaKPdj3R58vKoRX7bIN9ly2ZZTe32HyTdXxVRe5ag==
X-Received: by 2002:a17:902:c951:b0:1b8:3e15:46a1 with SMTP id i17-20020a170902c95100b001b83e1546a1mr8516813pla.67.1688778738940;
        Fri, 07 Jul 2023 18:12:18 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id x24-20020a170902b41800b001b87d3e845bsm3830654plr.149.2023.07.07.18.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 18:12:18 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     charlie@rivosinc.com, conor@kernel.org, paul.walmsley@sifive.com,
        palmer@rivosinc.com, aou@eecs.berkeley.edu, anup@brainfault.org,
        konstantin@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        mick@ics.forth.gr, jrtc27@jrtc27.com, rdunlap@infradead.org
Subject: [PATCH v4 3/4] RISC-V: mm: Update pgtable comment documentation
Date:   Fri,  7 Jul 2023 18:11:34 -0700
Message-ID: <20230708011156.2697409-4-charlie@rivosinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230708011156.2697409-1-charlie@rivosinc.com>
References: <20230708011156.2697409-1-charlie@rivosinc.com>
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
---
 arch/riscv/include/asm/pgtable.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index a8090ebea705..e6bbe8c0e583 100644
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

