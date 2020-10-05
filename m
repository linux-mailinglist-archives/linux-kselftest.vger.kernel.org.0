Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5833B283B63
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Oct 2020 17:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbgJEPlj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Oct 2020 11:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728800AbgJEPlO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Oct 2020 11:41:14 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A026C0613CE
        for <linux-kselftest@vger.kernel.org>; Mon,  5 Oct 2020 08:41:12 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id p29so1921193qve.17
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Oct 2020 08:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:cc;
        bh=A4+tWYJC+Fdx2lTpRNnDkPfjCAnLWkjDYMNCZGAhfI0=;
        b=W2aOWNF9PsP0MZcadNdtub1GL6B+1QEv2O6Tx/gfiiqRQrQ7sZ2eN0RLDb51NqwTf2
         5Rwk0gro4+qBtPMNI2l5xlU3U8/6Luiau8YNKUNkauTENCGXDsWYVJKPe8QOvHAmYhwB
         QKkz99XZMdn81N/UKOnZAyk8RyF8RhCGuAsYMcIvhy8FmEyP/YQ8XU4tIOVzrs2A5uYt
         sSw18nX8ARS7WlBHu/wLjtkuPPwAhp3hk4q1HPOtxz0nfrymx4x9azSzkbfjQSQ48+Fs
         c9fqzdbm+NLNQygBtOAaOl5dSQO1qzNo96WzL+jrkL/IxLY6k0ZqTVu4WCo7gRbyqE3u
         1ttA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=A4+tWYJC+Fdx2lTpRNnDkPfjCAnLWkjDYMNCZGAhfI0=;
        b=pG80l/jX9LMpbhOfPf21kiJOh+2ueCCGtYF8TEtU+Od+mNDZrnJlQF45lCj5H1YJeZ
         Tc0TqFSZ1TtwiNt+TxySF72fgbd3T7y4uSNAcI2V+dCP3ouaHV/FD8SmRm/il23WO7ln
         LwBzaADBCMGAPNSjRxLw9u+6B5LLOpX5UHmZ/3XzolPjyww2DSVD/BQWkZ6NUBbykZX7
         Mxp5sF6AwbkQQtTAK+pwnL5fF8X6rw4ZqODh1imb2WRmxs52ZmneZNlNpiKkuVo6ob+t
         rmSZWHWmnQ9Bu7uMHIafa5Pvpsq02MhGLB287NYxClFK2y8GaI9M5b3VBRXva3iJ9N89
         pPYg==
X-Gm-Message-State: AOAM533il8Iteb4/8Rl24kaPoRtHZdVBEZrplHSX9COs4oqTq2zeufkR
        8UbH667onVmpv5xaYSp20HM/a4NNbdVOQKs7TQ==
X-Google-Smtp-Source: ABdhPJwqH4Axuv8vQCr8AfVkLchHe5yXirxmBMUhO08uFxA9uxjk4KI3PjyIYdGPjqJpAGRfK7VpShrpY66rRcAmTA==
Sender: "kaleshsingh via sendgmr" <kaleshsingh@kaleshsingh.c.googlers.com>
X-Received: from kaleshsingh.c.googlers.com ([fda3:e722:ac3:10:14:4d90:c0a8:2145])
 (user=kaleshsingh job=sendgmr) by 2002:a05:6214:a03:: with SMTP id
 dw3mr251880qvb.44.1601912471400; Mon, 05 Oct 2020 08:41:11 -0700 (PDT)
Date:   Mon,  5 Oct 2020 15:40:07 +0000
In-Reply-To: <20201005154017.474722-1-kaleshsingh@google.com>
Message-Id: <20201005154017.474722-5-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20201005154017.474722-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.28.0.806.g8561365e88-goog
Subject: [PATCH v3 4/5] arm64: mremap speedup - Enable HAVE_MOVE_PUD
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
        Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Sami Tolvanen <samitolvanen@google.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Hassan Naveed <hnaveed@wavecomp.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@kernel.org>, Gavin Shan <gshan@redhat.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Mark Brown <broonie@kernel.org>, Jia He <justin.he@arm.com>,
        Zhenyu Ye <yezhenyu2@huawei.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Zi Yan <ziy@nvidia.com>, Ram Pai <linuxram@us.ibm.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Mina Almasry <almasrymina@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Sandipan Das <sandipan@linux.ibm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
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
---
Change in v3:
  - Add set_pud_at() macro - Used by move_normal_pud().

 arch/arm64/Kconfig               | 1 +
 arch/arm64/include/asm/pgtable.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 844d089668e3..4d521f0a5863 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -122,6 +122,7 @@ config ARM64
 	select HANDLE_DOMAIN_IRQ
 	select HARDIRQS_SW_RESEND
 	select HAVE_MOVE_PMD
+	select HAVE_MOVE_PUD
 	select HAVE_PCI
 	select HAVE_ACPI_APEI if (ACPI && EFI)
 	select HAVE_ALIGNED_STRUCT_PAGE if SLUB
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index d5d3fbe73953..8848125e3024 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -415,6 +415,7 @@ static inline pmd_t pmd_mkdevmap(pmd_t pmd)
 #define pfn_pud(pfn,prot)	__pud(__phys_to_pud_val((phys_addr_t)(pfn) << PAGE_SHIFT) | pgprot_val(prot))
 
 #define set_pmd_at(mm, addr, pmdp, pmd)	set_pte_at(mm, addr, (pte_t *)pmdp, pmd_pte(pmd))
+#define set_pud_at(mm, addr, pudp, pud)	set_pte_at(mm, addr, (pte_t *)pudp, pud_pte(pud))
 
 #define __p4d_to_phys(p4d)	__pte_to_phys(p4d_pte(p4d))
 #define __phys_to_p4d_val(phys)	__phys_to_pte_val(phys)
-- 
2.28.0.806.g8561365e88-goog

