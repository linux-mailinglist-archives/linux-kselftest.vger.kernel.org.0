Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07AB776CC9
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Aug 2023 01:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbjHIXYb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Aug 2023 19:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbjHIXY3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Aug 2023 19:24:29 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA821734
        for <linux-kselftest@vger.kernel.org>; Wed,  9 Aug 2023 16:24:26 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso293775a12.3
        for <linux-kselftest@vger.kernel.org>; Wed, 09 Aug 2023 16:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1691623465; x=1692228265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yZ0IVnzj5yL9SoUKLkLsC9JEkQ8y1OJuZ3kbIa3etj8=;
        b=DPqz69bvmOi0drz5sANCyS+ejDOE4tK2aPT6CgqMeO23pKOSYzYTRtQqX2sUrjiJmC
         RrSZUkbRkQCVs7wzIENC1wePmX11ZnFj1kEpsCllQfjH8OdDSh+ynaBkruLDhKbxi/y7
         hNKWT+H9FuM6BoaCv58BuAIhRmwJFzvP7uVm9tr4dtvvEe/YDApQvNm32rOzdMYd7vlm
         L6nJ3tcaqJbaF9pxp0H0xccKqzMXdCN5FaL8hF9CFS4XTf6Avl0vGc+i3JB23oEo+UYb
         B70BdpKfpKDQSAPKlmFJOXdwGmfAe0rv+GpuSvzqq6Fu2b/L19mwtUPiLUPiPFcaAgxf
         UibQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691623465; x=1692228265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yZ0IVnzj5yL9SoUKLkLsC9JEkQ8y1OJuZ3kbIa3etj8=;
        b=VmX/HPNpmuxfQ4nRyE5lavCqcOczCxaTlPVLhc0Y22XjccSck3VlhYb+gpRR5kTeJU
         lNz8+arxMr/Kfu97EvRh2AsZDXySr02n+AuTwKg6MqiKKCdtSgaElz22ovDfEp87gHSc
         uyM8u96mvyiumjkwVBvuUksZSvMem3e1rozjDq0ZzyxDJaE542r3FoCE46CvCaKpJyGg
         qeutCAtoHWinSsKuyMi5kJSzc8yhGrHM6ljvQgDGomWBuF22Bydp1Y+rujHZnrrpRowd
         WMgyQqpRoQ+m5PQdflG+tVrnL5KkdzyVBgtZegSpfQiGQImZAI1iSmbiwBeduNl+aHgp
         vUmQ==
X-Gm-Message-State: AOJu0Yxl+7LjWu1F3erUPCuSJOM4rL2UU2m3k+BiA7yUmQ1UEYIsCrLh
        R0WCFD9Ok4rLe0bnZ7rUdyv1ig==
X-Google-Smtp-Source: AGHT+IGNqJdWSYMcQx8TPRNJ4iYLWH440g3FftcqWpJUU1qXCbGZJ1xpxGkgBJ1xgrmbxMZywlEjtw==
X-Received: by 2002:a17:903:110f:b0:1b8:b5f8:c485 with SMTP id n15-20020a170903110f00b001b8b5f8c485mr741164plh.50.1691623465574;
        Wed, 09 Aug 2023 16:24:25 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id l18-20020a170902d35200b001b54d064a4bsm82765plk.259.2023.08.09.16.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 16:24:25 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     charlie@rivosinc.com, conor@kernel.org, paul.walmsley@sifive.com,
        palmer@rivosinc.com, aou@eecs.berkeley.edu, anup@brainfault.org,
        konstantin@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        mick@ics.forth.gr, jrtc27@jrtc27.com, rdunlap@infradead.org,
        alexghiti@rivosinc.com
Subject: [PATCH v10 3/4] RISC-V: mm: Update pgtable comment documentation
Date:   Wed,  9 Aug 2023 16:22:03 -0700
Message-ID: <20230809232218.849726-4-charlie@rivosinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809232218.849726-1-charlie@rivosinc.com>
References: <20230809232218.849726-1-charlie@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
index bb0b9ac7b581..2c5f6c8edc8a 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -851,14 +851,16 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
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

