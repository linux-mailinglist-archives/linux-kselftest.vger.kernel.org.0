Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE07763CD5
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jul 2023 18:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbjGZQqe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jul 2023 12:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbjGZQqd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jul 2023 12:46:33 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA6A270B
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jul 2023 09:46:30 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1bb2468257fso38365425ad.0
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jul 2023 09:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1690389989; x=1690994789;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=taA43ETpLC9XelDxU6ZtNji2uVvqZo51XsvT9ZpAUOw=;
        b=VZu9MJSwZY921d+CgkyRoxwMZ9iNSRGcNwXdvnISwMB6ZrvGY+S7PdYNnCTN09Ml//
         9OT/zZSv24aoMTT4p8YMqfNMaKALTuecJg7AAfyMvLYvUtCBWMHD8HmcPWG3A6DhHADY
         9zndIIv6HUn5DPGDsaK9svaN+56XhvqriI612ahHA8eL4BMQerz9GE7C7DWqrlrqyhrD
         2oFORFcvVABTahHZpXH/yATcrYwkLWjanAhlDeD98fff8tZGesgkvYndd+KcVx+PyB7n
         x3UZ7zYxPGWO/u8h37KPbndip2DXWlV/eE+HdzkbisNcgPAZzhTJsRw9oxmYcPU+eeIu
         4kFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690389989; x=1690994789;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=taA43ETpLC9XelDxU6ZtNji2uVvqZo51XsvT9ZpAUOw=;
        b=aC7WpYLPQrqASLroLs9itme1WQT2YKdB4PlBkTCTCvs9adsqFudr9CEYGXWXbS1mEm
         XHsunCHa/UabYIq8NAPu07B+sPGBJXiHJ1yIDybmJC8MXjH0saYLfaHaBvay6nQ86nEq
         QinCqgmsBUEqidCkVuikmwv+dx/5gPO0K7vWtaD3sDzZgMdX+xaCPEjNeq8yzEAXbhwc
         uBWuPzD0kmwqw0K7Q8Ig7ihiVhC79LcJU1s5UBdFw49RAJMc03QBWBjAio/nZvqFdzR9
         FUvo0gXR8cvW7XZwsza2eFZzYqpY/53tqrmRtC7pxDF6JdcvdltYA9LcDlj+L1eTVTIu
         wRUg==
X-Gm-Message-State: ABy/qLa4MsDWxU9hxchkfkMe30J4yAgq2XsWAJBAo6eA3gNN4Z0zXWQK
        V+Av3QGdfdsrjbOp4ciMJ8egeQ==
X-Google-Smtp-Source: APBJJlH6j0Ww1otYztDyN7R8yPQEX4DMdjE4EaTSbvjzsuEj6+yeD2BZI9v3UPAjEZlsbhq1mBWpeg==
X-Received: by 2002:a17:903:2308:b0:1b8:aef2:773e with SMTP id d8-20020a170903230800b001b8aef2773emr2582222plh.46.1690389989599;
        Wed, 26 Jul 2023 09:46:29 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id h5-20020a170902f54500b001bb6c5ff4edsm11628870plf.173.2023.07.26.09.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 09:46:29 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     charlie@rivosinc.com, conor@kernel.org, paul.walmsley@sifive.com,
        palmer@rivosinc.com, aou@eecs.berkeley.edu, anup@brainfault.org,
        konstantin@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        mick@ics.forth.gr, jrtc27@jrtc27.com, rdunlap@infradead.org,
        alexghiti@rivosinc.com
Subject: [PATCH v7 0/4] RISC-V: mm: Make SV48 the default address space
Date:   Wed, 26 Jul 2023 09:45:54 -0700
Message-ID: <20230726164620.717288-1-charlie@rivosinc.com>
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
 arch/riscv/include/asm/pgtable.h              | 21 ++++--
 arch/riscv/include/asm/processor.h            | 47 ++++++++++++--
 tools/testing/selftests/riscv/Makefile        |  2 +-
 tools/testing/selftests/riscv/mm/.gitignore   |  2 +
 tools/testing/selftests/riscv/mm/Makefile     | 15 +++++
 .../riscv/mm/testcases/mmap_bottomup.c        | 35 ++++++++++
 .../riscv/mm/testcases/mmap_default.c         | 35 ++++++++++
 .../selftests/riscv/mm/testcases/mmap_test.h  | 64 +++++++++++++++++++
 .../selftests/riscv/mm/testcases/run_mmap.sh  | 12 ++++
 11 files changed, 244 insertions(+), 13 deletions(-)
 create mode 100644 tools/testing/selftests/riscv/mm/.gitignore
 create mode 100644 tools/testing/selftests/riscv/mm/Makefile
 create mode 100644 tools/testing/selftests/riscv/mm/testcases/mmap_bottomup.c
 create mode 100644 tools/testing/selftests/riscv/mm/testcases/mmap_default.c
 create mode 100644 tools/testing/selftests/riscv/mm/testcases/mmap_test.h
 create mode 100755 tools/testing/selftests/riscv/mm/testcases/run_mmap.sh

-- 
2.41.0

