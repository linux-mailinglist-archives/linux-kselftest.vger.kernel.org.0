Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4286B752E2C
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jul 2023 02:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbjGNAOw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 20:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjGNAOv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 20:14:51 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD85B2735
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Jul 2023 17:14:50 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-666e3b15370so998157b3a.0
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Jul 2023 17:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1689293690; x=1689898490;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7dKdw/fRpGMhPZx5yucAo2VmH/W0zeKNkjERAr97oOc=;
        b=DK487UlEpW2G5KFRjrV2Qfjy60Qn/3kFcFt39vvQNjsEy/EdjOhr/PmBjKDr5CA3ue
         oNYqCOjXL+TSPHDxeqvlWpse/XFj2PCH5gOs1+zKgSASKGaJaZdpuXaFcEcq8Rnz3g+y
         ts2DnoxMIPwZa5nAYgO2k12ohjijX+QJLCxmRGkoqm7IiF1YhtJDNVLQLoyjr/QWeryV
         sLBQARcgGMGbDvBPNh+ho4raziT+pePlPpswVWZYtwuJDXPVf3INeH9eVA7RV0TqGEU+
         p+gBY6VSbMqvdZfHFgkT4xA+5jHK7jye8x+ul57+5ybnNDFunisuInIaNp+Xb9wIXcyi
         quGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689293690; x=1689898490;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7dKdw/fRpGMhPZx5yucAo2VmH/W0zeKNkjERAr97oOc=;
        b=hElUpQ7YqIHpRz14jzWRvzfQF7oSYSBzE8UFfLGDXX8XCXesSn4Fr2lNw3KOtssMgE
         zQtTcFvogfb4TStpKYOV/Ua+42Y1umPHkB2mhx7KPjHgFoFypbgzaCC0l556elhnxihn
         7cSc9FDmLpqcnYYoSn9rDEw+D5/GBZrrAaSntUXD8evwIbaZB426fDBXLbLhHqd0WOSu
         dLQIoxN2O2Up+6WNSGPY1yIGPUZ9vw5ng/KCF8XRRXnjnY5X7hiRnYrCDWLjFHjKM0SO
         6aRq5OEAENEtvlx3POWJUI/G7byhxYu+IsxIQxsh2XcyGGWdDTAcMG2YRHeaS9pg6HkC
         MItQ==
X-Gm-Message-State: ABy/qLY08MWn1rCp1xFpiFWgk3wHSfVrOWbtNc1S1SMiJl85t86fND8X
        v7V0HZlIPQCjdPzd2KwClc1mUA==
X-Google-Smtp-Source: APBJJlGnN8YBws+YDNmDKckQ6/RCNHOhLy80mxzCgKrfd+QSmAYMBcKo9f0Tl8SPbx+/J+Wj39dEBQ==
X-Received: by 2002:a05:6a20:394f:b0:12f:952:11ee with SMTP id r15-20020a056a20394f00b0012f095211eemr2554686pzg.43.1689293690271;
        Thu, 13 Jul 2023 17:14:50 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id x25-20020aa793b9000000b00673e652985esm5938107pff.44.2023.07.13.17.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 17:14:49 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     charlie@rivosinc.com, conor@kernel.org, paul.walmsley@sifive.com,
        palmer@rivosinc.com, aou@eecs.berkeley.edu, anup@brainfault.org,
        konstantin@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        mick@ics.forth.gr, jrtc27@jrtc27.com, rdunlap@infradead.org,
        alexghiti@rivosinc.com
Subject: [PATCH v5 0/4] RISC-V: mm: Make SV48 the default address space
Date:   Thu, 13 Jul 2023 17:13:59 -0700
Message-ID: <20230714001430.75798-1-charlie@rivosinc.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

 Documentation/riscv/vm-layout.rst             |  22 +++
 arch/riscv/include/asm/elf.h                  |   2 +-
 arch/riscv/include/asm/pgtable.h              |  20 ++-
 arch/riscv/include/asm/processor.h            |  46 +++++-
 tools/testing/selftests/riscv/Makefile        |   2 +-
 tools/testing/selftests/riscv/mm/.gitignore   |   1 +
 tools/testing/selftests/riscv/mm/Makefile     |  21 +++
 .../selftests/riscv/mm/testcases/mmap.c       | 133 ++++++++++++++++++
 8 files changed, 234 insertions(+), 13 deletions(-)
 create mode 100644 tools/testing/selftests/riscv/mm/.gitignore
 create mode 100644 tools/testing/selftests/riscv/mm/Makefile
 create mode 100644 tools/testing/selftests/riscv/mm/testcases/mmap.c

-- 
2.41.0

