Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C94F32817B8
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Oct 2020 18:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgJBQVT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Oct 2020 12:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgJBQVS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Oct 2020 12:21:18 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA65C0613D0
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Oct 2020 09:21:15 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id 205so1441176qkd.2
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Oct 2020 09:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:cc;
        bh=ihKrgqyZCQ8XMMYJ7a58uDLMLyOCJFezWU7B9DhnIPM=;
        b=eyT9arWU6MZav0P+TwNEl1M7D8mJOHf3BUXg5k6iIys+Fh+YkGI6KydRKCjp0rh/P4
         ZIWMBLXY7zzQQHlr/S3Lx5C4etTuxRCFoGHF1Ya4oKLctPQawr3dgToLEYDCo2RxQxpW
         VphxbuMFtNZKjZYvp5JBjNyz46aSF6rVyQxXPjqsmOFDg4nt+M4DynJrQdDw72lP0oj8
         HUD1CMNUmzpVcXWUUH4qO82oXyFcssOJKtUH1cFmW1D8cDnCdjzLLlwum6mPPRt6wg76
         /hnqLxabSgYRtmgswS9ZkOnzO5dG/ElIaT3sIPnm/N2KLUkMfmHYoUh6sh5awof9/01c
         ElJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :cc;
        bh=ihKrgqyZCQ8XMMYJ7a58uDLMLyOCJFezWU7B9DhnIPM=;
        b=UHo8yxdMsyAnICY6C6CZ2ufipNAvU5POGDg4QHD7PkZ3+fwham8xhRUVkhoL9D8kWj
         ncWJBXxnFgSYtoRc+BY3G/DYiSF7LX/SW/eNt7EJ68TXs8/glcx5v0w74QtLBfMMA5ri
         +LTdZZvgxPxC2HXPQg/vZBHCpqFm5VV2owvKRpeAu6yS3ELnHSjAJo0yovbRSgfVFFH8
         LPsm0eGrkYSEq3DruGDCYdUuAxkAsleLHk09XExdej8g27Pp2/gLruCafoBPeWlYQ7AU
         NlLGabWwUfz3/T8TBNE83MdXdGipz2JQaq6pCtiTtoCfJ0joQ3IheHIu5bsxNKo9bB5+
         6UwA==
X-Gm-Message-State: AOAM5338wXlZzHG78vRSCeEXXhH9RXAXWRNAoLgQD5q07vN5/9gr/9BR
        LNwVc5uY7O1ZufLcjpmlhJdxa7klv4tgSTlvPA==
X-Google-Smtp-Source: ABdhPJygoU2Ty06g5ZIiYrS6tuTHOeKqGmyxuIaNuoeVgzt+NiTCT4wV08YAgwGNDXrC6bntUe6q/jFKCM/nrckqWg==
Sender: "kaleshsingh via sendgmr" <kaleshsingh@kaleshsingh.c.googlers.com>
X-Received: from kaleshsingh.c.googlers.com ([fda3:e722:ac3:10:14:4d90:c0a8:2145])
 (user=kaleshsingh job=sendgmr) by 2002:a0c:8091:: with SMTP id
 17mr2893377qvb.19.1601655674261; Fri, 02 Oct 2020 09:21:14 -0700 (PDT)
Date:   Fri,  2 Oct 2020 16:20:45 +0000
Message-Id: <20201002162101.665549-1-kaleshsingh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.806.g8561365e88-goog
Subject: [PATCH v2 0/6] Speed up mremap on large regions
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     surenb@google.com, minchan@google.com, joelaf@google.com,
        lokeshgidra@google.com, kaleshsingh@google.com,
        kernel-team@android.com, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Hassan Naveed <hnaveed@wavecomp.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Mike Rapoport <rppt@kernel.org>, Gavin Shan <gshan@redhat.com>,
        Zhenyu Ye <yezhenyu2@huawei.com>,
        Steven Price <steven.price@arm.com>,
        Jia He <justin.he@arm.com>, John Hubbard <jhubbard@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Mina Almasry <almasrymina@google.com>,
        Ram Pai <linuxram@us.ibm.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Sandipan Das <sandipan@linux.ibm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Brian Geffon <bgeffon@google.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        SeongJae Park <sjpark@amazon.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This version 2 of the mremap speed up patches previously posted at:
https://lore.kernel.org/r/20200930222130.4175584-1-kaleshsingh@google.com

mremap time can be optimized by moving entries at the PMD/PUD level if
the source and destination addresses are PMD/PUD-aligned and
PMD/PUD-sized. Enable moving at the PMD and PUD levels on arm64 and
x86. Other architectures where this type of move is supported and known to
be safe can also opt-in to these optimizations by enabling HAVE_MOVE_PMD
and HAVE_MOVE_PUD.

Observed Performance Improvements for remapping a PUD-aligned 1GB-sized
region on x86 and arm64:

    - HAVE_MOVE_PMD is already enabled on x86 : N/A
    - Enabling HAVE_MOVE_PUD on x86   : ~13x speed up

    - Enabling HAVE_MOVE_PMD on arm64 : ~ 8x speed up
    - Enabling HAVE_MOVE_PUD on arm64 : ~19x speed up

          Altogether, HAVE_MOVE_PMD and HAVE_MOVE_PUD
          give a total of ~150x speed up on arm64.

Changes in v2:
  - Reduce mremap_test time by only validating a configurable
    threshold of the remapped region, as per John.
  - Use a random pattern for mremap validation. Provide pattern
    seed in test output, as per John.
  - Moved set_pud_at() to separate patch, per Kirill.
  - Use switch() instead of ifs in move_pgt_entry(), per Kirill.
  - Update commit message with description of Android
    garbage collector use case for HAVE_MOVE_PUD, as per Joel.
  - Fix build test error reported by kernel test robot in [1].

[1] https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org/thread/CKPGL4FH4NG7TGH2CVYX2UX76L25BTA3/

Kalesh Singh (6):
  kselftests: vm: Add mremap tests
  arm64: mremap speedup - Enable HAVE_MOVE_PMD
  mm: Speedup mremap on 1GB or larger regions
  arm64: Add set_pud_at() functions
  arm64: mremap speedup - Enable HAVE_MOVE_PUD
  x86: mremap speedup - Enable HAVE_MOVE_PUD

 arch/Kconfig                             |   7 +
 arch/arm64/Kconfig                       |   2 +
 arch/arm64/include/asm/pgtable.h         |   1 +
 arch/x86/Kconfig                         |   1 +
 mm/mremap.c                              | 220 +++++++++++++--
 tools/testing/selftests/vm/.gitignore    |   1 +
 tools/testing/selftests/vm/Makefile      |   1 +
 tools/testing/selftests/vm/mremap_test.c | 333 +++++++++++++++++++++++
 tools/testing/selftests/vm/run_vmtests   |  11 +
 9 files changed, 547 insertions(+), 30 deletions(-)
 create mode 100644 tools/testing/selftests/vm/mremap_test.c


base-commit: 472e5b056f000a778abb41f1e443de58eb259783
-- 
2.28.0.806.g8561365e88-goog

