Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B28028DCF5
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Oct 2020 11:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731027AbgJNJVa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Oct 2020 05:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731025AbgJNJUl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Oct 2020 05:20:41 -0400
Received: from mail-ua1-x94a.google.com (mail-ua1-x94a.google.com [IPv6:2607:f8b0:4864:20::94a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1FBC0251BC
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Oct 2020 17:54:39 -0700 (PDT)
Received: by mail-ua1-x94a.google.com with SMTP id x5so239148uau.13
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Oct 2020 17:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:cc;
        bh=htuM5XIelPXQQXL8oIf2e/a5DAtFUl+iOYnn4bwvhGc=;
        b=CMRAL6JAtDqSgRV7ZpF02r6NBp/0nc+94iGdBDTPU4PFiUZAv/Y8jRqN27jzxwPPnp
         vFLsngZcAyUU4xkRcpm1NFeKRmryyQP+fIVaPMNUpCX7nipK//0mhwToBcbbm//49Us7
         ECHrX/3nZUKbULbZaqhOX1/zGLBAGzJ3WfYq2z5KhQXv6oORHwIN3MpulDFaG6oq722y
         2/Kw2pi8QZLqn1DCHLaOFIvLY5/Yvg/aRP6S/Rz0VbFMh8XltQKWyAkMsZt3sNViURIJ
         l3jVm32z1TgDhRNocvrC/nsAUzCWhkrMOnW355gs+qtWsum8sO+E9aDZI11FZLqRBAOQ
         saZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=htuM5XIelPXQQXL8oIf2e/a5DAtFUl+iOYnn4bwvhGc=;
        b=ivruwrIIReWYiVJmPW/oQwzn3zu+U8EiXJxc3FgTzOcYVgsH6vHjmRXes0Lwp80zDH
         AJGqssiCHzRoVsGnC6iH0pKxbn5d4/mrPTCpdlDTt2m5K1ltDDTXWIyWoukAgY252p2B
         4lolz2tlflSwtH3Q3N1U22KID5zMovkmp8OB9PeV74IcRJz9Cjyl0+yx2J6KMfzaQZMy
         f0M3hNZRlNiYuLH14KR4jEvN00PGcWCDkCvP5QTgjLl21b3IKt1xFuPXMIy9+swFy3hN
         giCBgEmOxcqmZSzHIWA48pQX1QLAyQg9qmQimyp+R/NpEzDJxPPqiS8uhSoBbqUFb7gj
         s3Ag==
X-Gm-Message-State: AOAM530MapS6Q3z1zC7nOSoW2JMhD19g6P1PybgDKNl+zAt9jD5GWLNK
        7ZPdP+6+ugootjSUo/HGOiSLbrqqzJVd8RzdEw==
X-Google-Smtp-Source: ABdhPJzHDHcV5e3UInygktDbdw7yXMcUWhr9PYP72zl9/yMs684UPaTPlpY9Qpc7526JumFcKN8SYtlhOEeScdw1og==
Sender: "kaleshsingh via sendgmr" <kaleshsingh@kaleshsingh.c.googlers.com>
X-Received: from kaleshsingh.c.googlers.com ([fda3:e722:ac3:10:14:4d90:c0a8:2145])
 (user=kaleshsingh job=sendgmr) by 2002:a05:6122:804:: with SMTP id
 4mr1935610vkj.15.1602636878883; Tue, 13 Oct 2020 17:54:38 -0700 (PDT)
Date:   Wed, 14 Oct 2020 00:53:09 +0000
In-Reply-To: <20201014005320.2233162-1-kaleshsingh@google.com>
Message-Id: <20201014005320.2233162-5-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20201014005320.2233162-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v4 4/5] arm64: mremap speedup - Enable HAVE_MOVE_PUD
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
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Hassan Naveed <hnaveed@wavecomp.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Gavin Shan <gshan@redhat.com>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Jia He <justin.he@arm.com>, John Hubbard <jhubbard@nvidia.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Mina Almasry <almasrymina@google.com>,
        Sandipan Das <sandipan@linux.ibm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Brian Geffon <bgeffon@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        SeongJae Park <sjpark@amazon.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

HAVE_MOVE_PUD enables remapping pages at the PUD level if both the
source and destination addresses are PUD-aligned.

With HAVE_MOVE_PUD enabled it can be inferred that there is approximately
a 19x improvement in performance on arm64. (See data below).

------- Test Results ---------

The following results were obtained using a 5.4 kernel, by remapping
a PUD-aligned, 1GB sized region to a PUD-aligned destination.
The results from 10 iterations of the test are given below:

Total mremap times for 1GB data on arm64. All times are in nanoseconds.

Control          HAVE_MOVE_PUD

1247761          74271
1219896          46771
1094792          59687
1227760          48385
1043698          76666
1101771          50365
1159896          52500
1143594          75261
1025833          61354
1078125          48697

1134312.6        59395.7    <-- Mean time in nanoseconds

A 1GB mremap completion time drops from ~1.1 milliseconds
to ~59 microseconds on arm64. (~19x speed up).

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
Changes in v3:
  - Add set_pud_at() macro - Used by move_normal_pud().

Changes in v4:
  - Add Kirill's Acked-by.

 arch/arm64/Kconfig               | 1 +
 arch/arm64/include/asm/pgtable.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 434d6791e869..7191a79fb44d 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -124,6 +124,7 @@ config ARM64
 	select HANDLE_DOMAIN_IRQ
 	select HARDIRQS_SW_RESEND
 	select HAVE_MOVE_PMD
+	select HAVE_MOVE_PUD
 	select HAVE_PCI
 	select HAVE_ACPI_APEI if (ACPI && EFI)
 	select HAVE_ALIGNED_STRUCT_PAGE if SLUB
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index a11bf52e0c38..0b0b36974757 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -454,6 +454,7 @@ static inline pmd_t pmd_mkdevmap(pmd_t pmd)
 #define pfn_pud(pfn,prot)	__pud(__phys_to_pud_val((phys_addr_t)(pfn) << PAGE_SHIFT) | pgprot_val(prot))
 
 #define set_pmd_at(mm, addr, pmdp, pmd)	set_pte_at(mm, addr, (pte_t *)pmdp, pmd_pte(pmd))
+#define set_pud_at(mm, addr, pudp, pud)	set_pte_at(mm, addr, (pte_t *)pudp, pud_pte(pud))
 
 #define __p4d_to_phys(p4d)	__pte_to_phys(p4d_pte(p4d))
 #define __phys_to_p4d_val(phys)	__phys_to_pte_val(phys)
-- 
2.28.0.1011.ga647a8990f-goog

