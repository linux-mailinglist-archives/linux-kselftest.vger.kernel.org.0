Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC0F2283B53
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Oct 2020 17:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbgJEPky (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Oct 2020 11:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728027AbgJEPkq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Oct 2020 11:40:46 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6157C0613CE
        for <linux-kselftest@vger.kernel.org>; Mon,  5 Oct 2020 08:40:45 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id y53so6787361qth.2
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Oct 2020 08:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:cc;
        bh=KNj3DAoXl6FY4HLNmjfsIeWPw6NmzA5m1h25nAFriyA=;
        b=G05LJGMSS4nGQxD55nnPiFMozAlJTpF0Yva9yVs0JE0FGn+2WW0CmY9ZOVCFAH4Z08
         qjjcoVjiDSxIUSuj0Dngh1WTo5LuQB3XA6AK/9P3MzCbu+HVGt9WGL37M/edJjtq2vDr
         tAXqm5Wotf38Vf24CdvV4NyTXKwJnCgDZi6EqBWIVZsI0+8rG2YODm1uLsE4UcaTqEeL
         7SrrLz38CluwfmZwRU65Be9YOO61GwbfrBcpNxLjYG6lHqk0pb4bGrPV5ZbCmQ0akf/i
         1U5p5SFA/SVIQOb+TiA0cicTuyLSptJMMSieasKQqoQJGauvubqhaxnYxjU9NfxRRYjg
         jqUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=KNj3DAoXl6FY4HLNmjfsIeWPw6NmzA5m1h25nAFriyA=;
        b=VUCfrHjP0bbs1LLP1G8DYbPxA4sQPwMd7HIGuCA6lyNtSYcIVNeVPKlZ4yrZJeCuVA
         RcgXJTlGh+fr+NlZjSxcrcbVcn/IdaEUO9caV3jOKczOlrrIaQDvZM1kdS9/tIN9+WTX
         Bl3HncZPOZyhd3lLBjymBraMF9kU4egEIS6ofiNE0Frs5tboSiWrXn1CorRoLi4r2TnA
         xnFjAZ6LHXtonjTJyAeZVL/Gm6Uh7L6s7dmCCWaOcBHXK/iBu1dy1Ct+mWxd8bncLqsm
         k83yhIkrGuOTDvj7x1AGvQINrqf2waQo7G7Z0P+7WsAQq7pgTOdHbcxDMuIO2z2//R4s
         bNew==
X-Gm-Message-State: AOAM533R7lNqvX6tjxeQFmalUlp9tCIB5Yfm4tuSuf30+5yAGYO4qPaJ
        UagR4AhJSoFxWIR2ZDBuFFsttevgAR54cV5o0g==
X-Google-Smtp-Source: ABdhPJwG12ZLaDAfde6kCuzuNBgRgVAZ2cfeDTVTpsfwVYnSTyYZDI3BCmNc0oTZe2CrTCv/sza/LsBHBT7q4e3JtA==
Sender: "kaleshsingh via sendgmr" <kaleshsingh@kaleshsingh.c.googlers.com>
X-Received: from kaleshsingh.c.googlers.com ([fda3:e722:ac3:10:14:4d90:c0a8:2145])
 (user=kaleshsingh job=sendgmr) by 2002:a0c:c284:: with SMTP id
 b4mr203054qvi.6.1601912444879; Mon, 05 Oct 2020 08:40:44 -0700 (PDT)
Date:   Mon,  5 Oct 2020 15:40:05 +0000
In-Reply-To: <20201005154017.474722-1-kaleshsingh@google.com>
Message-Id: <20201005154017.474722-3-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20201005154017.474722-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.28.0.806.g8561365e88-goog
Subject: [PATCH v3 2/5] arm64: mremap speedup - Enable HAVE_MOVE_PMD
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
        Arnd Bergmann <arnd@arndb.de>,
        Sami Tolvanen <samitolvanen@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Hassan Naveed <hnaveed@wavecomp.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Mike Rapoport <rppt@kernel.org>, Gavin Shan <gshan@redhat.com>,
        Zhenyu Ye <yezhenyu2@huawei.com>, Jia He <justin.he@arm.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Colin Ian King <colin.king@canonical.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Mina Almasry <almasrymina@google.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Sandipan Das <sandipan@linux.ibm.com>, Zi Yan <ziy@nvidia.com>,
        Brian Geffon <bgeffon@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
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
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 6d232837cbee..844d089668e3 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -121,6 +121,7 @@ config ARM64
 	select GENERIC_VDSO_TIME_NS
 	select HANDLE_DOMAIN_IRQ
 	select HARDIRQS_SW_RESEND
+	select HAVE_MOVE_PMD
 	select HAVE_PCI
 	select HAVE_ACPI_APEI if (ACPI && EFI)
 	select HAVE_ALIGNED_STRUCT_PAGE if SLUB
-- 
2.28.0.806.g8561365e88-goog

