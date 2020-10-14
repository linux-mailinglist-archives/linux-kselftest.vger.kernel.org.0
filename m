Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1816628DCFB
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Oct 2020 11:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730872AbgJNJVf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Oct 2020 05:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731004AbgJNJUk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Oct 2020 05:20:40 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E98C0251BD
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Oct 2020 17:54:51 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id w32so1110520qvw.8
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Oct 2020 17:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:cc;
        bh=+sRzkUE+scrQPOvt1hpaJRFlbY+mLiTASxfxA+AvDzY=;
        b=jw3IYuqhYk3bNCks48afsywsfyXpRda22JQ0j0vZleZASO4yZwS1bbAuklB3w73SDu
         nVAc5RTpyaQR83VAqaD5XtkkdxVMh+0WBUMs27BJbmYfuDR1MW5kWP4aQfuVJrwkj8hh
         ZUBpB5ib1AH/FLfmvSzZMAn6wB7H0IpN8t+GBiHXJ7r60tAz2aTiCECnYOE5ke/1OYb5
         WloVpKbiCNwWXyA4+oAnzoKO4VvGLId6i4oBNn44HJh83Bd1hMW1gtw8oN04wN5EK01s
         gowS/qx8dBNy3W+Q/r388jANZjwOF21UjBdBC73CjCeTbc9Ads94fCnBq1FmwxpHOw7G
         axtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=+sRzkUE+scrQPOvt1hpaJRFlbY+mLiTASxfxA+AvDzY=;
        b=N/sst9Im9ujXHMAUsKG8dXZUYoCFakaaFaTJBeNbdBb30jNSkC5rqrKczEEthvjD9S
         LRSgHov1XR4Vh1iHBu9fV61wegxbZ7jeOBVZ+0yKis0IvDCiBEG+QJR+1qKABKRk6eX3
         XM0DPxcjzwz1kWm64H+UNlPbTRrYsGD4wTet3rOO7a5wjpWCin1+1ymDLZwd9Djf8LUz
         97/5RGctB5YE93z6bun0N7qeIjGbXh7BgDC+XJ+fcA9M8KFnzlttlhXlq7lyxg8Xa+as
         lG45SiMt14fcQFbYvB2P2siMBtD9eqrS6H/JmxBOCIy4j4/0aoXB8S43YbdhpeoMz0mG
         msTg==
X-Gm-Message-State: AOAM5337Gsg4j2+Bpg42Hm4+At4g42sonlHY435DGG/uAxx4yNzBSEns
        qL0SuCyJAQjOCvIM5zwH8J9cfY8eIJeg58aaTQ==
X-Google-Smtp-Source: ABdhPJyfDvKvdmHyyap2eUwDhm0Me8oBd98Fxe3Nu61XFgLJneYAMnVgTd1Giuoe//Q/MlLcMZyeZ5E1JL9dS9zouw==
Sender: "kaleshsingh via sendgmr" <kaleshsingh@kaleshsingh.c.googlers.com>
X-Received: from kaleshsingh.c.googlers.com ([fda3:e722:ac3:10:14:4d90:c0a8:2145])
 (user=kaleshsingh job=sendgmr) by 2002:ad4:4150:: with SMTP id
 z16mr2651885qvp.50.1602636890894; Tue, 13 Oct 2020 17:54:50 -0700 (PDT)
Date:   Wed, 14 Oct 2020 00:53:10 +0000
In-Reply-To: <20201014005320.2233162-1-kaleshsingh@google.com>
Message-Id: <20201014005320.2233162-6-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20201014005320.2233162-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH v4 5/5] x86: mremap speedup - Enable HAVE_MOVE_PUD
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     surenb@google.com, minchan@google.com, joelaf@google.com,
        lokeshgidra@google.com, kaleshsingh@google.com,
        kernel-team@android.com,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Hassan Naveed <hnaveed@wavecomp.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Gavin Shan <gshan@redhat.com>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Jia He <justin.he@arm.com>, John Hubbard <jhubbard@nvidia.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Sandipan Das <sandipan@linux.ibm.com>, Zi Yan <ziy@nvidia.com>,
        Mina Almasry <almasrymina@google.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Dave Hansen <dave.hansen@intel.com>,
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
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: H. Peter Anvin <hpa@zytor.com>
---
Changes in v4:
  - Add Kirill's Acked-by.

 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 835d93006bd6..e199760d54fc 100644
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
2.28.0.1011.ga647a8990f-goog

