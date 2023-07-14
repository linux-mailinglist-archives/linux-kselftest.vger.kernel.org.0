Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72296754006
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jul 2023 18:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236168AbjGNQ4E (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Jul 2023 12:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236121AbjGNQ4B (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Jul 2023 12:56:01 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39BD7359E
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Jul 2023 09:56:00 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-66c729f5618so2060110b3a.1
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Jul 2023 09:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1689353759; x=1689958559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WogNqZmM5qIDEUwvyRv9RC9FRo2r68Wx4DIsyw3FtoM=;
        b=0OBaa8eGB7H0rgB6atdvkGk65g6hngFNmUyQKFx3pt0cyXW/YlErSR1NFqPJjQVIBn
         Qbx2cPxubOqOi6CSq5mhghxg0+jKeUjUth4gkGEcm1phj0JCTkUT4Z0lC3uJHMPft2S9
         cPfIhhdmeOpgAr3dJxiUolv0aIchuoAsBArXrM1/wxA34E4mOly1ZMEShAAkToUUbVKM
         T+UDmYWmaiy+RMU7RefKaOVjxXWMIriJy9dkCKzFl17rP0lW4tlkFRkQ312UxNQYk2ZT
         R+0aW+ORT+YA+DbgWTkxGEBc255W3YFG1qbu5NQulHcux6fpsOtYFyHkWoDqKBUEUQsz
         f9gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689353759; x=1689958559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WogNqZmM5qIDEUwvyRv9RC9FRo2r68Wx4DIsyw3FtoM=;
        b=YxBwBlpC1mAosQ3UXHk/RkXrqKQxr6wU56sGXmpbIiRpLg+kGUFAAVJvo+bho87GQY
         3dJgAV1dN4QUz5R1ZXYgBLxkk56jV4J0lzA89GJCIKbDygHXOpjIy5ljoBD7CplkfrLF
         N3SOV8rUPglC3zCGCNVU2G7KgSPWj35GdLsSYZ2HlvDYTjIo3KgL87xFyjFpmbLlkDOR
         NyHC+ymwKZa8ko7vJSSTfLGIrguxzyRg2O82OSGFlmb0gq1mj4/RCGt0OEyK1f1ceFDw
         I+KYhlHWnbIIdNuQNkRSeUdrT1Oio2Qhjtt1OcZDc+By5H03VuncZlbUqUvoBJ/qUYal
         Mlpg==
X-Gm-Message-State: ABy/qLYHI4PWgkTcVp6r87fAtO4IjIqQMG2szjppQBQejn13ugWp31wO
        pmQe+Euvx3pKmGt/zVXAFShLcw==
X-Google-Smtp-Source: APBJJlFI//JCJ/vZz+Q9PwxyNeL/qKz+QPWaKPFke/aicziyFeQBMzZv9VLqcfrN88UuwdEdg68umg==
X-Received: by 2002:a05:6a20:639e:b0:133:ee16:5677 with SMTP id m30-20020a056a20639e00b00133ee165677mr1028643pzg.59.1689353759643;
        Fri, 14 Jul 2023 09:55:59 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id s8-20020a170902b18800b001b694140d96sm8008081plr.170.2023.07.14.09.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 09:55:59 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     charlie@rivosinc.com, conor@kernel.org, paul.walmsley@sifive.com,
        palmer@rivosinc.com, aou@eecs.berkeley.edu, anup@brainfault.org,
        konstantin@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        mick@ics.forth.gr, jrtc27@jrtc27.com, rdunlap@infradead.org,
        alexghiti@rivosinc.com
Subject: [PATCH v6 3/4] RISC-V: mm: Update pgtable comment documentation
Date:   Fri, 14 Jul 2023 09:54:51 -0700
Message-ID: <20230714165508.94561-4-charlie@rivosinc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230714165508.94561-1-charlie@rivosinc.com>
References: <20230714165508.94561-1-charlie@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
index e13f5872bfe9..28660bab754c 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -840,14 +840,16 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
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

