Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3FA5776CC1
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Aug 2023 01:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbjHIXYX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Aug 2023 19:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjHIXYW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Aug 2023 19:24:22 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B45E42
        for <linux-kselftest@vger.kernel.org>; Wed,  9 Aug 2023 16:24:21 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bc6bfc4b58so3381935ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 09 Aug 2023 16:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1691623461; x=1692228261;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E8p58LaqwOO5/ryDFldME9XzaZs3YH0sEVcGA0akbb4=;
        b=4uH4uUlE2xAaY7umOQx+lAB4pjHab4NR0rLyooYYTvaojxHoTJRIyzeyPysMLlOFjT
         FuWa/Ta3xZBNpqk6gIYdVLCOBj2ZH4vVvdXeM35aKaheH4pjDk0IHj7u9amuqZqeP3GS
         HlATLPmsxaOkny4mEM/N4Vlp6kVWLtuaB+0ShdcMcoQ7cRqUhOoljaQ5ZiejA9+572wC
         rwH7mn9AVdHsHV0BzWCeXxrc2E/qHJm6SkSFC7Q955SApUeNaerG1WDOnSEgcYV+BvCG
         8WuiYD1/xas2rQKxwU4xMEJ2Yybia07rR7vd+sLVWztI074scG3BBh1aDAkq+/8u7ur5
         nSmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691623461; x=1692228261;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E8p58LaqwOO5/ryDFldME9XzaZs3YH0sEVcGA0akbb4=;
        b=MYZFKIXBrlGgMozxmoh7xE2p0DzcxJujTt6y5gewm/xeKQD56PZzu2J2yY9gW9JJ17
         QeIVFyfDFxjtGU3aMGnnQpPrEzRuYPoXAvtzAkjmvRpXSrU/9CDYT8q1Nm/BfO4KlpPh
         LL5Q0NEoQVCPz1EEZ/Xxp9Yoz07GR16P+cJBkO+X63hVPURi0igcahx9+ORWpx1r58M2
         A6mSOFZvgjqZpBshiH/2WuB2jSsejJ7ylpZ6motpsy1ZnGB56qq0RAhBOLfZY8XvYVMt
         9VV7xDFbds9JOysnmV8GXgBQ7gJqKM5w8FueOCUuUqM0i9hGiAXtjkWYCL949v1Gn/DH
         EhfQ==
X-Gm-Message-State: AOJu0YzAYu6j9QnD/hI9azFVbvGshimq9AB6076++sDmkPIdo2HZWYDg
        W2dSGAge3TD9+YSklCHxWWa6Gw==
X-Google-Smtp-Source: AGHT+IE1fGW+XmCV+CY5PBYWciXsspEbmsKGDkSe/osIjCyGdMaRaYBOeNCrMXuf1vRXYhEruWBSbA==
X-Received: by 2002:a17:902:a407:b0:1b5:561a:5c9a with SMTP id p7-20020a170902a40700b001b5561a5c9amr544010plq.39.1691623461301;
        Wed, 09 Aug 2023 16:24:21 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id l18-20020a170902d35200b001b54d064a4bsm82765plk.259.2023.08.09.16.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 16:24:20 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     charlie@rivosinc.com, conor@kernel.org, paul.walmsley@sifive.com,
        palmer@rivosinc.com, aou@eecs.berkeley.edu, anup@brainfault.org,
        konstantin@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        mick@ics.forth.gr, jrtc27@jrtc27.com, rdunlap@infradead.org,
        alexghiti@rivosinc.com
Subject: [PATCH v10 0/4] RISC-V: mm: Make SV48 the default address space
Date:   Wed,  9 Aug 2023 16:22:00 -0700
Message-ID: <20230809232218.849726-1-charlie@rivosinc.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Make sv48 the default address space for mmap as some applications
currently depend on this assumption. Users can now select a
desired address space using a non-zero hint address to mmap. Previously,
requesting the default address space from mmap by passing zero as the hint
address would result in using the largest address space possible. Some
applications depend on empty bits in the virtual address space, like Go and
Java, so this patch provides more flexibility for application developers.

-Charlie

---
v10:
- Move pgtable.h defintions into a no __ASSEMBLY__ region to resolve compilation
  conflicts (pointed out by Conor)
- Will now compile with allmodconfig

v9:
- Raise the mmap_end default to STACK_TOP_MAX to allow the address space to grow
  beyond the default of sv48 on sv57 machines as suggested by Alexandre
- Some of the mmap macros had unnecessary conditionals that I have removed

v8:
- Fix RV32 and the RV32 compat mode of RV64 (suggested by Conor)
- Extract out addr and base from the mmap macros (suggested by Alexandre)

v7:
- Changing RLIMIT_STACK inside of an executing program does not trigger
  arch_pick_mmap_layout(), so rewrite tests to change RLIMIT_STACK from a
  script before executing tests. RLIMIT_STACK of infinity forces bottomup
  mmap allocation.
- Make arch_get_mmap_base macro more readible by extracting out the rnd
  calculation.
- Use MMAP_MIN_VA_BITS in TASK_UNMAPPED_BASE to support case when mmap
  attempts to allocate address smaller than DEFAULT_MAP_WINDOW.
- Fix incorrect wording in documentation.

v6:
- Rebase onto the correct base

v5:
- Minor wording change in documentation
- Change some parenthesis in arch_get_mmap_ macros
- Added case for addr==0 in arch_get_mmap_ because without this, programs would
  crash if RLIMIT_STACK was modified before executing the program. This was
  tested using the libhugetlbfs tests. 

v4:
- Split testcases/document patch into test cases, in-code documentation, and
  formal documentation patches
- Modified the mmap_base macro to be more legible and better represent memory
  layout
- Fixed documentation to better reflect the implmentation
- Renamed DEFAULT_VA_BITS to MMAP_VA_BITS
- Added additional test case for rlimit changes
---


Charlie Jenkins (4):
  RISC-V: mm: Restrict address space for sv39,sv48,sv57
  RISC-V: mm: Add tests for RISC-V mm
  RISC-V: mm: Update pgtable comment documentation
  RISC-V: mm: Document mmap changes

 Documentation/riscv/vm-layout.rst             | 22 +++++++
 arch/riscv/include/asm/elf.h                  |  2 +-
 arch/riscv/include/asm/pgtable.h              | 33 ++++++++--
 arch/riscv/include/asm/processor.h            | 52 +++++++++++++--
 tools/testing/selftests/riscv/Makefile        |  2 +-
 tools/testing/selftests/riscv/mm/.gitignore   |  2 +
 tools/testing/selftests/riscv/mm/Makefile     | 15 +++++
 .../riscv/mm/testcases/mmap_bottomup.c        | 35 ++++++++++
 .../riscv/mm/testcases/mmap_default.c         | 35 ++++++++++
 .../selftests/riscv/mm/testcases/mmap_test.h  | 64 +++++++++++++++++++
 .../selftests/riscv/mm/testcases/run_mmap.sh  | 12 ++++
 11 files changed, 261 insertions(+), 13 deletions(-)
 create mode 100644 tools/testing/selftests/riscv/mm/.gitignore
 create mode 100644 tools/testing/selftests/riscv/mm/Makefile
 create mode 100644 tools/testing/selftests/riscv/mm/testcases/mmap_bottomup.c
 create mode 100644 tools/testing/selftests/riscv/mm/testcases/mmap_default.c
 create mode 100644 tools/testing/selftests/riscv/mm/testcases/mmap_test.h
 create mode 100755 tools/testing/selftests/riscv/mm/testcases/run_mmap.sh

-- 
2.34.1

