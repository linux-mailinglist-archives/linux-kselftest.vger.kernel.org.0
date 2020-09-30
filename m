Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A34E927F504
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Oct 2020 00:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731449AbgI3WV6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Sep 2020 18:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731259AbgI3WV6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Sep 2020 18:21:58 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB42C0613D0
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Sep 2020 15:21:57 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id e190so3174050ybf.18
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Sep 2020 15:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:cc;
        bh=M0Jnd5wDs989jegufD80A647gOObA9k7fcoXOfGIBiI=;
        b=boDpHG4YKr/2sBYi+LXa7BYu2zahi8BWNiXF87MohJyyIman1YZgh2emp0eq+ALxVF
         N8Rorega2dCLqmupg5pggd4PEd0bioiDmLQNT/uayIfQYI/mK9sOXXXaXnkfAPLGDmJx
         /Co7dHpFXUZPb6JhgzEuOs4vsL7nB/ouZzo9v6V4300dN5vLptrbHO4vapViZXwBudAh
         Ek2t7vH58qT4ABFOsGeFw8dE9HSppt8Cv93fwPd7G3MmAMn3Em8oG/bsv6UWDPJ3jGbg
         m/Zl/8FLGMadTgwwz/0FCcE3Bg5lmumAkFDQr0+kGeF1/sPrtYOu+Lj4tH/9bYQCLPbI
         YrzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=M0Jnd5wDs989jegufD80A647gOObA9k7fcoXOfGIBiI=;
        b=D+Mw3j7FoCB8bSQfuzT5TzZSTQ7DJKtshJJz9CvczSDAyfYGOXAfLhrhYEbqBekgNS
         z/NvqNBsJgGsXgw8N50Ds3oHUWOXimvxvANdEdNXiu6tX2e3Riuy4C9oR+vXflKfMf28
         Boz2vFd4AnawDbt3BlrU7hZXNMGy9AAHwDQ8waFm6eMRfCg/t/znh0bH9n4AfV2/BZlA
         CkQxbH7+FXfG5qD3qqtR9+YzhpKX0Y2KmmJA9x8Puq336P0Ks7XDzQPjO/1Bd1z+Ss2q
         +7QrGiC2aA9lmoNxygcAwqlH/eLXnE+dA0tE2pB5RDWzrKOROWZsE79igRsXNOuS+mkX
         WJNw==
X-Gm-Message-State: AOAM532PGzjgcJrSKrqB0pF2RXx+f+sKzhBWNZ8i2ItiNubjeNVESh4p
        twoaPP8XeRCdlfyF0X7c0YXdjYuf9Ofoy5Ih8g==
X-Google-Smtp-Source: ABdhPJzpG054ym1h9s82GZx0gEkFQHO8lOnhV52qK7oqfRRBlQ4XabfPxVWgnQguS08M76s/iC40L0YtMGRjB+Vw+Q==
Sender: "kaleshsingh via sendgmr" <kaleshsingh@kaleshsingh.c.googlers.com>
X-Received: from kaleshsingh.c.googlers.com ([fda3:e722:ac3:10:14:4d90:c0a8:2145])
 (user=kaleshsingh job=sendgmr) by 2002:a25:ae9f:: with SMTP id
 b31mr6084827ybj.437.1601504516920; Wed, 30 Sep 2020 15:21:56 -0700 (PDT)
Date:   Wed, 30 Sep 2020 22:21:19 +0000
In-Reply-To: <20200930222130.4175584-1-kaleshsingh@google.com>
Message-Id: <20200930222130.4175584-3-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20200930222130.4175584-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH 2/5] arm64: mremap speedup - Enable HAVE_MOVE_PMD
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
        Sami Tolvanen <samitolvanen@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Hassan Naveed <hnaveed@wavecomp.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@kernel.org>, Gavin Shan <gshan@redhat.com>,
        Mark Brown <broonie@kernel.org>, Jia He <justin.he@arm.com>,
        Zhenyu Ye <yezhenyu2@huawei.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Sandipan Das <sandipan@linux.ibm.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Mina Almasry <almasrymina@google.com>,
        Colin Ian King <colin.king@canonical.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        SeongJae Park <sjpark@amazon.de>,
        Brian Geffon <bgeffon@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
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
2.28.0.709.gb0816b6eb0-goog

