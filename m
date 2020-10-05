Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96461283B39
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Oct 2020 17:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbgJEPki (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Oct 2020 11:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728249AbgJEPkW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Oct 2020 11:40:22 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9061C0613CE
        for <linux-kselftest@vger.kernel.org>; Mon,  5 Oct 2020 08:40:21 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id h191so6935465qke.1
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Oct 2020 08:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:cc
         :content-transfer-encoding;
        bh=roRRmpnOQfqBgouvFdnsiNMWHoFG1to3sn9HMTXsuVQ=;
        b=ISCc2/Q+3RqQHnmu/kT5NtbJpNZ7wC8V64UlYxth0OYKIluZdxX7K1qgddenEuyZkZ
         Wc8U6+kyTzsPPNyB+D9cDFo3M4s3lBLOfMlJJxYiV4Ltu9WPKkx8LeCnf3CGMyu8pe24
         QIGKxtMSedAWRhEGXxS0Czaq2oiy71ShEVY7Ny+oG2nkFMpoiSWHyoAzbffu/G8vt1qm
         eXe1gnFdmR2B0WLUvrfX5yF+c/CGo5F5OCtcPRN88pnNiyl4nNnJeDRa7KIyr/t/xLbn
         r+McOy57d3h71tj/brwaYwm0tHmetXO0th1kYsTBVqPc0WeiLDFOn5mbQ/vuX5IbqSp1
         CFqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :cc:content-transfer-encoding;
        bh=roRRmpnOQfqBgouvFdnsiNMWHoFG1to3sn9HMTXsuVQ=;
        b=tZrJt5Uj0GHpBNZHTcVAl6qFhdL7He7REo/Ro2ILT6qdPawYFgfyFMmD1MyE1INWt6
         Ux/OwUgDQmNN+l5sGGx+1UW/+BnDuPT0dwzqb098sNSgMwYDdKJFMfycLls9NqZtWedz
         XYVNwtoYEXDYcQHF2CzAfxAaXWGcY12z6Tle/0MGlU7ksXd70xfBXz8+3ZNLqK6hPsyD
         jT6XBgKEEHkxq1lVn84Wb43x0PfS8mu3pUKNy/4X3/pIo3oBjQLKkCj1Xu3gwz3W70YA
         nr9EQpDTuFsfT4VCoZlfYl3oi31mC/vwYhC15ekaFWAqZ4FFe87deV+B2KH2WV9GYI4u
         SQeg==
X-Gm-Message-State: AOAM531oQLX1vrNBAuV1leBwcAIVxP4gzO4+Q2MAbj8eQkHZw+5vjIjY
        L4foJQBSscwbG7CrtlZ9WkW+cGFJ66rSQVQIuw==
X-Google-Smtp-Source: ABdhPJzWIPbd8bmYokW5hjiB2Kdv49nELig2YTyft80Zu/HTSnekvJDgjzVfD9yHuYp1YWGhjsp5xyZutg5nHRLLjw==
Sender: "kaleshsingh via sendgmr" <kaleshsingh@kaleshsingh.c.googlers.com>
X-Received: from kaleshsingh.c.googlers.com ([fda3:e722:ac3:10:14:4d90:c0a8:2145])
 (user=kaleshsingh job=sendgmr) by 2002:ad4:58c7:: with SMTP id
 dh7mr278895qvb.20.1601912420924; Mon, 05 Oct 2020 08:40:20 -0700 (PDT)
Date:   Mon,  5 Oct 2020 15:40:03 +0000
Message-Id: <20201005154017.474722-1-kaleshsingh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.806.g8561365e88-goog
Subject: [PATCH v3 0/5] Speed up mremap on large regions
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
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Hassan Naveed <hnaveed@wavecomp.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Mike Rapoport <rppt@kernel.org>, Gavin Shan <gshan@redhat.com>,
        Jia He <justin.he@arm.com>, Zhenyu Ye <yezhenyu2@huawei.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Sandipan Das <sandipan@linux.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mina Almasry <almasrymina@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
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

This version 3 of the mremap speed up patches previously posted at:
v1 - https://lore.kernel.org/r/20200930222130.4175584-1-kaleshsingh@google.=
com
v2 - https://lore.kernel.org/r/20201002162101.665549-1-kaleshsingh@google.c=
om

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


base-commit: 549738f15da0e5a00275977623be199fbbf7df50
--=20
2.28.0.806.g8561365e88-goog

