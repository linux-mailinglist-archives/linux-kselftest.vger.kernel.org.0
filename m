Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD21775089
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Aug 2023 03:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbjHIBxJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Aug 2023 21:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbjHIBxI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Aug 2023 21:53:08 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FE01BDA
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Aug 2023 18:53:06 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1bbbbb77b38so39899465ad.3
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Aug 2023 18:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1691545986; x=1692150786;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UtoNrqFUKslO70ZXL4UNEXOjKDOXZBueUpk6sT8KlRA=;
        b=StgyxgerM/v48ko0wif1IouoNrGfeAt0DQ9gH4XXOfXEvWdda9w/lRT/W0WLrYHw8Y
         HCI7mRrtJwdyITpgruffl82O3nc4neJFoCZmYn2rwc6n5b5kkyueu/OV3qwN5pQNXVjl
         gD8c72+AoAbNzG6wi0yhhdTdeZvrG/v/2GNuSusbIxt4H5XAhxp95/5j4s6pBgDkjjgj
         F/RYJYuDwMyJLNFUBnuiYtOePN6sMW+75O0ck7p0+zzR2FqrHGhUp0KePrWL3VR1nPHt
         GqWhS4Dsi1mH1CKzHnPDOBNf/lzH42O7nktuH/HgyW4DJE8IY/sa6GNje/dgSwG+MxS+
         CteQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691545986; x=1692150786;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UtoNrqFUKslO70ZXL4UNEXOjKDOXZBueUpk6sT8KlRA=;
        b=arahY8PM8c/stRstJYEJUB/IMdM/cl/ymu5NdjEhjzogbIp/tl78UIxyIrvdKMndP6
         6BgdLmr214PC46Ong3pOZyDhzTYA+eRk75uUHwQKqU7sRNCHsRnozSAwL5NvFBVLWUtX
         U9WmLKco2uSWScgX1ZIDX+2ZpSSx5aJMPs1DTfHezYQ3foOV0Q6iWF2tIsFDtjW5avNf
         +ydHpME6Bl93aa2jKtiMZNNndVyUfwfMlyY01NtipX4PoC04YZDA8bbQxHz0nAW8nIrv
         FrNgbPZ/yrFcJfQmiNVs9flUIQlZrWQyng6Z17DaWArUFIunlS3f+9fRjklyEHLzNOSA
         JJwQ==
X-Gm-Message-State: AOJu0YzV6tu1b0msxheGWA5YDjoruU/xu/7fzRlE569j+qw0JlTEX42/
        Di5XV9FICcwI3Llot7RZtsGHiA==
X-Google-Smtp-Source: AGHT+IETK47y7WHfs1Fi+VVpMxPGO7IsKhzhbeCiVg2BmCKUP+WGC7R8S47dwV+JENhl+KILQ0Yv9A==
X-Received: by 2002:a17:903:2351:b0:1b8:9ecd:8b86 with SMTP id c17-20020a170903235100b001b89ecd8b86mr1790925plh.5.1691545986411;
        Tue, 08 Aug 2023 18:53:06 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id bj7-20020a170902850700b001b87bedcc6fsm9657591plb.93.2023.08.08.18.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 18:53:05 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     charlie@rivosinc.com, conor@kernel.org, paul.walmsley@sifive.com,
        palmer@rivosinc.com, aou@eecs.berkeley.edu, anup@brainfault.org,
        konstantin@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        mick@ics.forth.gr, jrtc27@jrtc27.com, rdunlap@infradead.org,
        alexghiti@rivosinc.com
Subject: [PATCH v9 0/4] RISC-V: mm: Make SV48 the default address space
Date:   Tue,  8 Aug 2023 18:51:06 -0700
Message-Id: <20230809015110.3290774-1-charlie@rivosinc.com>
X-Mailer: git-send-email 2.34.1
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
 arch/riscv/include/asm/pgtable.h              | 29 +++++++--
 arch/riscv/include/asm/processor.h            | 52 +++++++++++++--
 tools/testing/selftests/riscv/Makefile        |  2 +-
 tools/testing/selftests/riscv/mm/.gitignore   |  2 +
 tools/testing/selftests/riscv/mm/Makefile     | 15 +++++
 .../riscv/mm/testcases/mmap_bottomup.c        | 35 ++++++++++
 .../riscv/mm/testcases/mmap_default.c         | 35 ++++++++++
 .../selftests/riscv/mm/testcases/mmap_test.h  | 64 +++++++++++++++++++
 .../selftests/riscv/mm/testcases/run_mmap.sh  | 12 ++++
 11 files changed, 258 insertions(+), 12 deletions(-)
 create mode 100644 tools/testing/selftests/riscv/mm/.gitignore
 create mode 100644 tools/testing/selftests/riscv/mm/Makefile
 create mode 100644 tools/testing/selftests/riscv/mm/testcases/mmap_bottomup.c
 create mode 100644 tools/testing/selftests/riscv/mm/testcases/mmap_default.c
 create mode 100644 tools/testing/selftests/riscv/mm/testcases/mmap_test.h
 create mode 100755 tools/testing/selftests/riscv/mm/testcases/run_mmap.sh

-- 
2.34.1

