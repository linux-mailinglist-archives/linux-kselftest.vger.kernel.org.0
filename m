Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1A92817C5
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Oct 2020 18:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388169AbgJBQWi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Oct 2020 12:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388076AbgJBQWh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Oct 2020 12:22:37 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B67C0613E2
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Oct 2020 09:22:37 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id g44so1386623qtb.15
        for <linux-kselftest@vger.kernel.org>; Fri, 02 Oct 2020 09:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:cc;
        bh=bMnBZVJZ0gP6yWIahq+ggDCPy47CsnYvJiYw0n333nM=;
        b=Z2BhCB0ionBjY9f7rJg975U+QnCTCPpylLVtNijw2nkc9jOX0nWeWzaScP/MiSCHxb
         VlNw+IBd6+iMm5/zsKLjJhp4Av/TRf3MlDYx51iPzzIF3DYfrx3bJCSrtH9C//COkKxc
         xSYhR8fO9b21qmYKgflHjxUWg6wu/GpUAhEGJPmZeDcdY7rbfDAfRXb8euzLbp12Zh88
         edKzBO0V9SHioyYGqGPIsn7hVLnsZnoCKmyX8mkVd22fnpHi1uxrWXuN4V+FYJ+VfUUh
         jHc4fZgacTCxZJu3LoVwWYVB64D6hIAt2jp6nQ4THkRgwkXaDAkjk/QHsk/CbqUR/Y1b
         Hr2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=bMnBZVJZ0gP6yWIahq+ggDCPy47CsnYvJiYw0n333nM=;
        b=hlD8wg4EtCw+pwZgVUghbcRNzAc7YCqw1G7OVOWJjCCl3WbAWSKgctbgCn44TWdEAX
         qzWa7Y3bqaK0tOV7WsP267integQrmIVcXp0iqtoOWITKHRJxBKuR+cWrINsvKzZaKJV
         H4hDbKmh3gu943BqJY5pwEiCOzCtP/FPHBMyacMWFN7a1goiBogEX6aKkIJvHRKikFKV
         vR3AoRi29rEwacPqKhiCExUQ2RA/czA5VNXt8Mnvr8GcfIVOJyKW4NA7XIKbkyUqrDee
         nY3vMAp55uIzXr+ZzCmEndNEOKdwWm13W3HIVShyJQrGzlv3ot0Hf5WZTNEqv69HvFaT
         PjmQ==
X-Gm-Message-State: AOAM533vqtoyGJFs8En/MnVuAzHcEuPixm34KxN/kXqHFv1AHOZwn3Gx
        EUbce1XvtFHDl/GIYkVy+LrQgXkPUZ05kfH3HA==
X-Google-Smtp-Source: ABdhPJwWzjZJWRiWHzB7SAUtAP2b0hza2Y8k4Vz+cdfMrWfqG4bkLxAOeDCVeFU+z7OT3ayRXnDmDOceZZsYYAHZbg==
Sender: "kaleshsingh via sendgmr" <kaleshsingh@kaleshsingh.c.googlers.com>
X-Received: from kaleshsingh.c.googlers.com ([fda3:e722:ac3:10:14:4d90:c0a8:2145])
 (user=kaleshsingh job=sendgmr) by 2002:ad4:4527:: with SMTP id
 l7mr3023885qvu.2.1601655756530; Fri, 02 Oct 2020 09:22:36 -0700 (PDT)
Date:   Fri,  2 Oct 2020 16:20:51 +0000
In-Reply-To: <20201002162101.665549-1-kaleshsingh@google.com>
Message-Id: <20201002162101.665549-7-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20201002162101.665549-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.28.0.806.g8561365e88-goog
Subject: [PATCH v2 6/6] x86: mremap speedup - Enable HAVE_MOVE_PUD
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
        Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Mike Rapoport <rppt@kernel.org>, Gavin Shan <gshan@redhat.com>,
        Zhenyu Ye <yezhenyu2@huawei.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Jia He <justin.he@arm.com>, John Hubbard <jhubbard@nvidia.com>,
        Zi Yan <ziy@nvidia.com>, Dave Hansen <dave.hansen@intel.com>,
        Mina Almasry <almasrymina@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Sandipan Das <sandipan@linux.ibm.com>,
        Brian Geffon <bgeffon@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
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
a 13x improvement in performance on x86. (See data below).

------- Test Results ---------

The following results were obtained using a 5.4 kernel, by remapping
a PUD-aligned, 1GB sized region to a PUD-aligned destination.
The results from 10 iterations of the test are given below:

Total mremap times for 1GB data on x86. All times are in nanoseconds.

Control        HAVE_MOVE_PUD

180394         15089
235728         14056
238931         25741
187330         13838
241742         14187
177925         14778
182758         14728
160872         14418
205813         15107
245722         13998

205721.5       15594    <-- Mean time in nanoseconds

A 1GB mremap completion time drops from ~205 microseconds
to ~15 microseconds on x86. (~13x speed up).

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 7101ac64bb20..ff6e2755cab8 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -198,6 +198,7 @@ config X86
 	select HAVE_MIXED_BREAKPOINTS_REGS
 	select HAVE_MOD_ARCH_SPECIFIC
 	select HAVE_MOVE_PMD
+	select HAVE_MOVE_PUD
 	select HAVE_NMI
 	select HAVE_OPROFILE
 	select HAVE_OPTPROBES
-- 
2.28.0.806.g8561365e88-goog

