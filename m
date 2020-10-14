Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAE9728DCBC
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Oct 2020 11:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730424AbgJNJTy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Oct 2020 05:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730448AbgJNJTk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Oct 2020 05:19:40 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFACC0251B6
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Oct 2020 17:54:14 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id ec4so1077656qvb.21
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Oct 2020 17:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:cc;
        bh=TvfbBMDu2+s5YUKb/QcLi0FhzELrCQpbsXkcpSpM+Nk=;
        b=G3gn7F39iSNCnEd7q8+PVe/kEIgBPlqHPHHGmF2OPFgrjxC5QoofX4MDKRT2oC2O9r
         hV6n/EbqK4wdl8qi76HX5kMbwSIvdJepo6MbII62VZq0Uy9vM7eSpi7J/fSzRBT/x9VJ
         JmtkqQIxbilR0WKfR9oQqXFr+CHI0qaZQjOkejT7V7SEYKvDoY1wJYkfB/RI+1G+l9wa
         4F+5fRoIJwXTMOXh4Al28eIZc71nv6AtVZ00GVY1xil+lb0YwwPFO+2RInHsXiVBfhWx
         25Jblpp8+HkwMPVx/nTi2L97HVLH2HmXAPfuxhlAVRLFAVdeUvqn9aN9v2fAuYxiIA5i
         9iKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=TvfbBMDu2+s5YUKb/QcLi0FhzELrCQpbsXkcpSpM+Nk=;
        b=BrSkiMKajsQmpa9WdokXKq/FI+s6Aea09CU7YxpU7gcaaiEAIojeiFgwwW1kZj7lfI
         VAqzsXYAj6eDmms+EFWz1xSY7nB2T9NArle2s2BtqL7i6uWWtYud2IeEbJgP8aus53f+
         k2Oyp5WYfLqc0W6JBoFbzEqaryElxDmAm/sRArOU98pfqH2ra86K/AYnOb9LB4nEqsdc
         Fi0ES6qbK+dZjJNxXlMC9v+2hPd4tAZlH2Xqy4FDTkjh/tc6d2V47ufvVbCaOUqNMdxZ
         QSvXl3I7TjYZ18E6NySGKauSVQCbx64PE5vWs3Kde/1ITsJjiWO0LnqkdcvyqFzmS7HS
         nxaQ==
X-Gm-Message-State: AOAM531pboeX8YyggL2avv0CRpHxvgh6zMLrw9hzGYoAyUG6TXnT0+Xo
        jvxXfEq/jxaFhH9VuiO3N+E5PS5A9k7qZLYzyQ==
X-Google-Smtp-Source: ABdhPJw3tFbAz+wnBZvW4VQhuqFS/HjgU1bMTVbFcRuRjcOeKAwU0JK4uA8tv1QRCL/TMwPmerYSJ8B0YbB0LRqP4g==
Sender: "kaleshsingh via sendgmr" <kaleshsingh@kaleshsingh.c.googlers.com>
X-Received: from kaleshsingh.c.googlers.com ([fda3:e722:ac3:10:14:4d90:c0a8:2145])
 (user=kaleshsingh job=sendgmr) by 2002:ad4:46a8:: with SMTP id
 br8mr2664505qvb.24.1602636853194; Tue, 13 Oct 2020 17:54:13 -0700 (PDT)
Date:   Wed, 14 Oct 2020 00:53:07 +0000
In-Reply-To: <20201014005320.2233162-1-kaleshsingh@google.com>
Message-Id: <20201014005320.2233162-3-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20201014005320.2233162-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v4 2/5] arm64: mremap speedup - Enable HAVE_MOVE_PMD
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     surenb@google.com, minchan@google.com, joelaf@google.com,
        lokeshgidra@google.com, kaleshsingh@google.com,
        kernel-team@android.com,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Shuah Khan <shuah@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Hassan Naveed <hnaveed@wavecomp.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mark Brown <broonie@kernel.org>, Gavin Shan <gshan@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Jia He <justin.he@arm.com>, John Hubbard <jhubbard@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ram Pai <linuxram@us.ibm.com>,
        Mina Almasry <almasrymina@google.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Sandipan Das <sandipan@linux.ibm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Brian Geffon <bgeffon@google.com>,
        SeongJae Park <sjpark@amazon.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

HAVE_MOVE_PMD enables remapping pages at the PMD level if both the
source and destination addresses are PMD-aligned.

HAVE_MOVE_PMD is already enabled on x86. The original patch [1] that
introduced this config did not enable it on arm64 at the time because
of performance issues with flushing the TLB on every PMD move. These
issues have since been addressed in more recent releases with
improvements to the arm64 TLB invalidation and core mmu_gather code as
Will Deacon mentioned in [2].

From the data below, it can be inferred that there is approximately
8x improvement in performance when HAVE_MOVE_PMD is enabled on arm64.

--------- Test Results ----------

The following results were obtained on an arm64 device running a 5.4
kernel, by remapping a PMD-aligned, 1GB sized region to a PMD-aligned
destination. The results from 10 iterations of the test are given below.
All times are in nanoseconds.

Control    HAVE_MOVE_PMD

9220833    1247761
9002552    1219896
9254115    1094792
8725885    1227760
9308646    1043698
9001667    1101771
8793385    1159896
8774636    1143594
9553125    1025833
9374010    1078125

9100885.4  1134312.6    <-- Mean Time in nanoseconds

Total mremap time for a 1GB sized PMD-aligned region drops from
~9.1 milliseconds to ~1.1 milliseconds. (~8x speedup).

[1] https://lore.kernel.org/r/20181108181201.88826-3-joelaf@google.com
[2] https://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg140837.html

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
Changes in v4:
  - Add Kirill's Acked-by.

 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 4b136e923ccb..434d6791e869 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -123,6 +123,7 @@ config ARM64
 	select GENERIC_VDSO_TIME_NS
 	select HANDLE_DOMAIN_IRQ
 	select HARDIRQS_SW_RESEND
+	select HAVE_MOVE_PMD
 	select HAVE_PCI
 	select HAVE_ACPI_APEI if (ACPI && EFI)
 	select HAVE_ALIGNED_STRUCT_PAGE if SLUB
-- 
2.28.0.1011.ga647a8990f-goog

