Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B76DA28DCF8
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Oct 2020 11:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731021AbgJNJVb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Oct 2020 05:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731022AbgJNJUl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Oct 2020 05:20:41 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445FBC025278
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Oct 2020 17:53:49 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id w8so1584690ybj.14
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Oct 2020 17:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:cc
         :content-transfer-encoding;
        bh=kqal+0zLGFPhz9I+TIzRUZfLWtzX1D3uO8CqpABK0Y0=;
        b=WVUVCVw4XS9agygn2X5xXGsf6TB48LO7rOqfRM26gPVAcIi/Q0oNF1DmibxWSjxvAs
         umqZ3cfMD9qO8wONFXAV1wVytwjdvMH7Iqeu//x9hJm4vxVOfjDJ98PK+VXVClZTGTCG
         0y3Rh/MhLWD6DC1A2hLxY66SD1DNrE0QRDtvOp/lj9yp1fFI130ysngIs7343WzrLyWV
         vAwj1nW2id05cmwRLC9a8wH1x5ttIdjCeTv8vih/+GMRjVdUKKR/pF48iDG0sGWo42ns
         5vmFdl3WQlhAHmw2TuEqZOWYE+pmhQORZLE+F+93WPbOaTRJN3ZpC+ltSa7l+3PJv/iA
         TOtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :cc:content-transfer-encoding;
        bh=kqal+0zLGFPhz9I+TIzRUZfLWtzX1D3uO8CqpABK0Y0=;
        b=t7Z8eaVMPj0z34OtKA/xx6zYKS/HfdbIESFse1CNx6C+021z6qrgl/UyPtzh6Vjsc1
         5+n3/mLV/xxPUrLO6cBzUgWVCEUDMf3lbHKBg4eqlImofIrVA0eAMljQ1KPdN+GpmgC8
         3UQEnnfxJPn/6YQYsvTjpf5tCKp03cRf8KxSzilh210ssdV9DvCxRLwvRnzyeCXnOPdb
         dZbp7proN2H14Xs8pKftSAO/sTF6/WAk3+CFgF2DJmQWZtmmw3EPGx8wcfAdbSrmjm3D
         UP2qb0VfwOS8W6s4YZfY7Cu0+7iNM0MWf6kOEYl0SZCRtVpssFSFnwWtJ1QuiM1R0sFB
         vNdA==
X-Gm-Message-State: AOAM530LtZGKSdtIUH3ZjSgnSsTm42Sof257cJ3wFYrIGIMNjZ0vTTkP
        hbiK9fWoLRKFdr7DxGa9AetQLvnE0PfuvJmskg==
X-Google-Smtp-Source: ABdhPJxcUglBSX8zjEb9PvLiSn3/zi25+djWBaggtZDkIuOyPU3cZl6r6XPSEWn/Zr5eA1goeDpmGvNtLwj26KYQ5g==
Sender: "kaleshsingh via sendgmr" <kaleshsingh@kaleshsingh.c.googlers.com>
X-Received: from kaleshsingh.c.googlers.com ([fda3:e722:ac3:10:14:4d90:c0a8:2145])
 (user=kaleshsingh job=sendgmr) by 2002:a25:c709:: with SMTP id
 w9mr3716846ybe.327.1602636828326; Tue, 13 Oct 2020 17:53:48 -0700 (PDT)
Date:   Wed, 14 Oct 2020 00:53:05 +0000
Message-Id: <20201014005320.2233162-1-kaleshsingh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v4 0/5] Speed up mremap on large regions
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
        Peter Zijlstra <peterz@infradead.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Hassan Naveed <hnaveed@wavecomp.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mark Brown <broonie@kernel.org>, Gavin Shan <gshan@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Jia He <justin.he@arm.com>, John Hubbard <jhubbard@nvidia.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mina Almasry <almasrymina@google.com>,
        Sandipan Das <sandipan@linux.ibm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Brian Geffon <bgeffon@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        SeongJae Park <sjpark@amazon.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a repost of the mremap speed up patches, adding Kirill's
Acked-by's (from a separate discussion). The previous versions are
posted at:
v1 - https://lore.kernel.org/r/20200930222130.4175584-1-kaleshsingh@google.=
com
v2 - https://lore.kernel.org/r/20201002162101.665549-1-kaleshsingh@google.c=
om
v3 - http://lore.kernel.org/r/20201005154017.474722-1-kaleshsingh@google.co=
m

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

Changes in v3:
  - Make lines 80 cols or less where they don=E2=80=99t need to be longer,
    per John.
  - Removed unused PATTERN_SIZE in mremap_test
  - Added Reviewed-by tag for patch 1/5 (mremap kselftest patch).
  - Use switch() instead of ifs in get_extent(), per Kirill
  - Add BUILD_BUG() is get_extent() default case.
  - Move get_old_pud() and alloc_new_pud() out of
    #ifdef CONFIG_HAVE_MOVE_PUD, per Kirill.
  - Have get_old_pmd() and alloc_new_pmd() use get_old_pud() and
    alloc_old_pud(), per Kirill.
  - Replace #ifdef CONFIG_HAVE_MOVE_PMD / PUD in move_page_tables()
    with IS_ENABLED(CONFIG_HAVE_MOVE_PMD / PUD), per Kirill.
  - Fold Add set_pud_at() patch into patch 4/5, per Kirill.

[1] https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org/thread/CKP=
GL4FH4NG7TGH2CVYX2UX76L25BTA3/

Kalesh Singh (5):
  kselftests: vm: Add mremap tests
  arm64: mremap speedup - Enable HAVE_MOVE_PMD
  mm: Speedup mremap on 1GB or larger regions
  arm64: mremap speedup - Enable HAVE_MOVE_PUD
  x86: mremap speedup - Enable HAVE_MOVE_PUD

 arch/Kconfig                             |   7 +
 arch/arm64/Kconfig                       |   2 +
 arch/arm64/include/asm/pgtable.h         |   1 +
 arch/x86/Kconfig                         |   1 +
 mm/mremap.c                              | 230 ++++++++++++---
 tools/testing/selftests/vm/.gitignore    |   1 +
 tools/testing/selftests/vm/Makefile      |   1 +
 tools/testing/selftests/vm/mremap_test.c | 344 +++++++++++++++++++++++
 tools/testing/selftests/vm/run_vmtests   |  11 +
 9 files changed, 558 insertions(+), 40 deletions(-)
 create mode 100644 tools/testing/selftests/vm/mremap_test.c

--=20
2.28.0.1011.ga647a8990f-goog

