Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEDE3765E20
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jul 2023 23:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjG0V07 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jul 2023 17:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjG0V0z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jul 2023 17:26:55 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74531984
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Jul 2023 14:26:51 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-686f38692b3so1100507b3a.2
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Jul 2023 14:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1690493211; x=1691098011;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u1j+kMh0iOsH0JqfJ3WA4QtOF313IMeXkg3gc/f9dpg=;
        b=UW/Zl61NXORbuErLMYKrPm9BFy7QuUh39/eAy5ZU0tDpiY0EdHKcfvtC+GjtpmoDS8
         UmDlC5OLbd58dgYVEmXHluzRe1t2fY8rL1HiaDUFiSJTNyiVKx7Yj/LsR1iXdWF2JcNt
         tnIjNEFLAtyVNtQnc5o/YyMDw8iqDLdEFxqRSU0Vz15wWVg7u5g7H6whC3n/cJHzTAky
         FzfPpDUZfB16CXzC3uQVY4b74zmqkbLxl/LvpVr/5df/t64hI95eiPpq/tX3SGZn8pXV
         wROKldHqphBhUMtg69MS22I/iovR/Qy3rcvDDNxH4lNhhgWxzukwhDjXh3ehAlzbnPa8
         7Cyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690493211; x=1691098011;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u1j+kMh0iOsH0JqfJ3WA4QtOF313IMeXkg3gc/f9dpg=;
        b=WgRL838AHLS0vZhlSESHISP/nDr/xEz9p9TcQPbpwEpsAqtj0YIn3Kre0mBJA3ypvW
         X5yJEm1JUMTUrWAjpJLz4+p7bKxoQHW+g/7iz+sH09vYYYS29fOdDv2g+GbsEwxCHyNR
         uubRGh98evW+X09QLo38vx8ezAADZb9TT3rHgbC9WArQ8O/qoTtvSDRQNrEcUvMxHUxv
         3FF7MZtsElBc9T2G4MPWfuHwBJpCJzowIi3vDByD3l2rQs/m1KV2olU/qyCLMJhKz/oC
         2gsPtjNncf/7vsCt8etjVH9GzO0YaWviB+jeYZ8YZ6juCuFC8kE37lLiRt2kO5/EKnKl
         N4SA==
X-Gm-Message-State: ABy/qLb6Ncltlmnt6+XI9fyGilRzkTTpdioCgB36zmvIm+mLftw/VmLA
        7un19rUnbHY3rTxcuf/9APdqKA==
X-Google-Smtp-Source: APBJJlHqQrVV0xCK9fwk96H8JBXhaJwlU8jA71nZ4nPqPKjFylYfA9+6fmKC0mo2E6CfNC7prqLhUw==
X-Received: by 2002:a05:6a20:2c98:b0:13b:ceea:6b50 with SMTP id g24-20020a056a202c9800b0013bceea6b50mr262249pzj.47.1690493211124;
        Thu, 27 Jul 2023 14:26:51 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id c5-20020aa78c05000000b00682562b1549sm1912312pfd.24.2023.07.27.14.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 14:26:50 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     charlie@rivosinc.com, conor@kernel.org, paul.walmsley@sifive.com,
        palmer@rivosinc.com, aou@eecs.berkeley.edu, anup@brainfault.org,
        konstantin@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        mick@ics.forth.gr, jrtc27@jrtc27.com, rdunlap@infradead.org,
        alexghiti@rivosinc.com
Subject: [PATCH v8 0/4] RISC-V: mm: Make SV48 the default address space
Date:   Thu, 27 Jul 2023 14:26:25 -0700
Message-ID: <20230727212647.4182407-1-charlie@rivosinc.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
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

Make sv48 the default address space for mmap as some applications
currently depend on this assumption. Users can now select a
desired address space using a non-zero hint address to mmap. Previously,
requesting the default address space from mmap by passing zero as the hint
address would result in using the largest address space possible. Some
applications depend on empty bits in the virtual address space, like Go and
Java, so this patch provides more flexibility for application developers.

-Charlie

---
v8:
- Fix RV32 and the RV32 compat mode of RV64
- Extract out addr and base from the mmap macros
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
 arch/riscv/include/asm/pgtable.h              | 28 ++++++--
 arch/riscv/include/asm/processor.h            | 52 +++++++++++++--
 tools/testing/selftests/riscv/Makefile        |  2 +-
 tools/testing/selftests/riscv/mm/.gitignore   |  2 +
 tools/testing/selftests/riscv/mm/Makefile     | 15 +++++
 .../riscv/mm/testcases/mmap_bottomup.c        | 35 ++++++++++
 .../riscv/mm/testcases/mmap_default.c         | 35 ++++++++++
 .../selftests/riscv/mm/testcases/mmap_test.h  | 64 +++++++++++++++++++
 .../selftests/riscv/mm/testcases/run_mmap.sh  | 12 ++++
 11 files changed, 257 insertions(+), 12 deletions(-)
 create mode 100644 tools/testing/selftests/riscv/mm/.gitignore
 create mode 100644 tools/testing/selftests/riscv/mm/Makefile
 create mode 100644 tools/testing/selftests/riscv/mm/testcases/mmap_bottomup.c
 create mode 100644 tools/testing/selftests/riscv/mm/testcases/mmap_default.c
 create mode 100644 tools/testing/selftests/riscv/mm/testcases/mmap_test.h
 create mode 100755 tools/testing/selftests/riscv/mm/testcases/run_mmap.sh

-- 
2.41.0

