Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D89D27F50B
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Oct 2020 00:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731548AbgI3WW3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Sep 2020 18:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731339AbgI3WW2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Sep 2020 18:22:28 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16B3C0613D0
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Sep 2020 15:22:28 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id y2so1885859qvs.14
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Sep 2020 15:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:cc;
        bh=Mra73tAqzotShWNgSXv1vhLyePg3f0HjrcFvwMDeq9o=;
        b=jDIKOMNUrsBzgzsboYR6brg4WOYp4kCRZqrCWAvAZbpkekxYpp5uwWu1VMa3jBM1D4
         qePDAkhwPaS7ozmJhvpiPn8rqjAEru5rJyPx6RWU/8Ay/7inrR7CHVJ77p9zaJZ1IwI9
         Dy5ixhsQoV7e7t6GjskB9KRoGi6vhUEOJIOmUECHIHMNA/6dx0Mfp5sk/qPevZgAIWJD
         dSDgUoz8vPO96wn0mRJrwb6JU+kn6sz1n4gmMp04q1wpnavCaWjLkLkQER3ZYnT7jxHz
         JbrMiGc+vRmaiWx7InwR9v7+c9MnvzgX9b4pL1qHoSDq+DWQYdeR0dkqLDkbjTEQELIk
         LT7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=Mra73tAqzotShWNgSXv1vhLyePg3f0HjrcFvwMDeq9o=;
        b=Nbg4A/v9qmuaPwe1ahSdm42837ykdhAAGjW3MSDzpktRCNkXM6+g/ES7RKL2daBbUx
         HPUB/WEv5NhDsIfTw8QBqKHK4y9FOO+HFKmsBh87ekP+7AUg5pv5VaqB4qv7eGQ1z3N9
         6duZ22L7dakGYSs7efDO5l5mGjhgoM3JOFJTAeozcdVXNxv2J8/aqUwqpEpxJ6517Cev
         yILvYtQZuwxeN2oWhfRbuqkJTUqYHPP57t2FPzoLd71XoNkfUJ2Q5dFNXxEfh7OJEaf0
         GpIdxyQ6n1gxK0ERvmvTTTbvANNjGdhJ9s6P+/lVKsg7vcZ6Ndcl3RKZs1CdoeR0qjcH
         Fr6Q==
X-Gm-Message-State: AOAM530fPe8dj4Lk72wN7s3oriB6t1nN3NfTsCu8Hcp9+T/H0SVMPJzL
        AKRgLvqOXYeTFd+vr5LtJBT2M7PNV5jkSrqTPw==
X-Google-Smtp-Source: ABdhPJyLR6MYlSTS4XQqoJzvYxjrHwSWIVNtfhqTdtx45lsRl3oJwBhgd7X3m6yDztZJ8ANUp7tpdCXWxqNC36OyAw==
Sender: "kaleshsingh via sendgmr" <kaleshsingh@kaleshsingh.c.googlers.com>
X-Received: from kaleshsingh.c.googlers.com ([fda3:e722:ac3:10:14:4d90:c0a8:2145])
 (user=kaleshsingh job=sendgmr) by 2002:a0c:b39a:: with SMTP id
 t26mr4865208qve.19.1601504547782; Wed, 30 Sep 2020 15:22:27 -0700 (PDT)
Date:   Wed, 30 Sep 2020 22:21:22 +0000
In-Reply-To: <20200930222130.4175584-1-kaleshsingh@google.com>
Message-Id: <20200930222130.4175584-6-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20200930222130.4175584-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH 5/5] x86: mremap speedup - Enable HAVE_MOVE_PUD
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
        Mark Brown <broonie@kernel.org>,
        Mike Rapoport <rppt@kernel.org>, Gavin Shan <gshan@redhat.com>,
        Steven Price <steven.price@arm.com>,
        Zhenyu Ye <yezhenyu2@huawei.com>, Jia He <justin.he@arm.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Ram Pai <linuxram@us.ibm.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Mina Almasry <almasrymina@google.com>,
        Sandipan Das <sandipan@linux.ibm.com>,
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
2.28.0.709.gb0816b6eb0-goog

