Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB59A2817BC
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Oct 2020 18:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388030AbgJBQVk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Oct 2020 12:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387856AbgJBQVj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Oct 2020 12:21:39 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 621B6C0613E2
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Oct 2020 09:21:39 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id w3so1365796qtn.16
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Oct 2020 09:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:cc;
        bh=KNj3DAoXl6FY4HLNmjfsIeWPw6NmzA5m1h25nAFriyA=;
        b=SWSITLXoYBp7yRaYvXhJIOfUQ0+WxGu3JpdKX8dFE/fNTZMF6v5PFDYR3jy8+MgdQp
         tZLS7uiyPoGn0n+djf+PmvNOiiJwUEN4ag80gUHytq35k8ckK5drIIgveVqH2KnxvRuE
         IyUED/LyVYcy2WCy1ZkMbWXSC9CDXV9hhBXgKCTGP+Mnje71NVfxQO3Xij6heAQX7jrS
         vn+BJAXlRI1RmkPGQrml2YmXHCtztRAiTmms9bKK5lTEZ/yy4sLAktgaEfNF/ahlLzl9
         p+IwrlzofYdi0hKb/8nRKjmW7dlqF/dg521zphFh3XOYiNFj/lK/lt5f89D9bOEWgfNX
         QhQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=KNj3DAoXl6FY4HLNmjfsIeWPw6NmzA5m1h25nAFriyA=;
        b=dkWkGsgUTGQRXBqVkmMBa8pz7qLD7y4PeRXdll3290rPOX4cwN9yC7CX+uLbimUAo3
         aNzLUdLKCa6c7U5CkVhckK20Vq+p7Njd/i0miZdAz772MQzQmW8PCcZ8Buf/3WHO6kak
         zQAhJAhY52GlmiQndhyKSu9bJPxHteARlSfVgxhY2MiS6I7CBZvYY39CGzWbyvFjHq55
         96MZUb9GCYPBr9FLjuragFAm/RaPnROswKgxSiBj2G1P/CVXcllAxqdmiTi4nznEP685
         OlN2c1EFgB5Ux1zgWCKsAC1ovQMbdvbXYKmC3afTMLK4lSNU+6yQZBujpLq/8pXiNqsz
         jdCA==
X-Gm-Message-State: AOAM532NVGsoXMJ2cX2mMYG20Gz0facLAUR+o6vWZ6vj/NtKca2nJtPl
        HIkJ7Bv049lrKR/gOorVvc72RRvEqHiDTHSKcQ==
X-Google-Smtp-Source: ABdhPJzAcDzqBLOfrOtUkHbp2ct++BpAXy2BN0jF0742eLl9Z7QHKpd7tITMB94KYDpe2P+caZGnT+Xj149VKfshrg==
Sender: "kaleshsingh via sendgmr" <kaleshsingh@kaleshsingh.c.googlers.com>
X-Received: from kaleshsingh.c.googlers.com ([fda3:e722:ac3:10:14:4d90:c0a8:2145])
 (user=kaleshsingh job=sendgmr) by 2002:ad4:4b34:: with SMTP id
 s20mr2944829qvw.51.1601655698451; Fri, 02 Oct 2020 09:21:38 -0700 (PDT)
Date:   Fri,  2 Oct 2020 16:20:47 +0000
In-Reply-To: <20201002162101.665549-1-kaleshsingh@google.com>
Message-Id: <20201002162101.665549-3-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20201002162101.665549-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.28.0.806.g8561365e88-goog
Subject: [PATCH v2 2/6] arm64: mremap speedup - Enable HAVE_MOVE_PMD
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
        Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@kernel.org>, Gavin Shan <gshan@redhat.com>,
        Mark Brown <broonie@kernel.org>, Jia He <justin.he@arm.com>,
        Zhenyu Ye <yezhenyu2@huawei.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Dave Hansen <dave.hansen@intel.com>, Zi Yan <ziy@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mina Almasry <almasrymina@google.com>,
        Sandipan Das <sandipan@linux.ibm.com>,
        Colin Ian King <colin.king@canonical.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        SeongJae Park <sjpark@amazon.de>,
        Ira Weiny <ira.weiny@intel.com>,
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
2.28.0.806.g8561365e88-goog

