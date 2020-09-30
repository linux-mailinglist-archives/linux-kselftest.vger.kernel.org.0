Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89DDB27F509
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Oct 2020 00:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731255AbgI3WWS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Sep 2020 18:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730201AbgI3WWS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Sep 2020 18:22:18 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A43BC0613D0
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Sep 2020 15:22:18 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id w92so2245665qte.19
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Sep 2020 15:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:cc;
        bh=r9i4rFwlO0Ri1Z8TnSbsRvxZfWKWakVdyJrZ8aN7lSY=;
        b=W1iWTcIgxIUy2UVtGwKg/FWOAbFwxj1yZWmUPz5Pi/125KT5znQ+tf41yAd1LXtU3d
         Uib3iflcCUIsFkmFwF65SPdIo0tOd05bt6iEjAmwvgkuxVugygP1L5ds1Ja8WufaiuMV
         xz81lcY5xrAL+nyfM3Z0hdPj/tJ43t16HfcFkrJ+MxmieS3E1BV/xbXh8PvXr1ROpI8b
         rCKYtMByUOGystQtiQJjncYyQgIpF3rGdUXr5N8/ZwBTqs43v+RaP/0IRmqIv5X0KeCw
         wjabq5p+HsWNPVNiSZT1vRrkK3OoQqkBQQ+qiqurkNU1dwg9e3kAqbptm+mdcIc9xW87
         dADg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=r9i4rFwlO0Ri1Z8TnSbsRvxZfWKWakVdyJrZ8aN7lSY=;
        b=iNvB5JSprU4uklO1HZJykVZgm2wrP6uWvfRy6Hj6r3AaDT+lh3zs/7lMqecY7sPfDT
         GXJH0pehd/Xx3bJH4XlqFsDQdFKG3K7K1b2ui71shtrX+mouf7KUDFBVATyTmaDoC00B
         EPodeq7Rgs+LPnmRdbWRD+DiWfe1I3lpHPR11El1NnO5TCNq5oNQdv7kqj8iXOaGGikL
         T8f7FYhYZicUzAHr6LQaV6eX3Jy5qnH0EhqAHoZhQzRkTIiurU8kyrit4pXN+p6CZdg7
         ExLMOXemfzdenS/HLq4S2AwlNUdYJNanQHwxgmJ9LTNvvRv3sRZu3soDIU/sAUfftfFZ
         Bo1A==
X-Gm-Message-State: AOAM533nHMNCj0rAWxaaN4OfCKoiOQXw3LCIfzRtvrK+F5fva5gB3IpM
        MxdKTD8MnkaeVn4fZbWtznELlTzvGZ9OQ7C6Cw==
X-Google-Smtp-Source: ABdhPJw/sR64l5kK5cZN6wHaMabXV7sFr12f7agBjeiB0rYDcGu7AUGvx40hqtjxrcgjvKmLH0L0Diy+P9Slii6SiQ==
Sender: "kaleshsingh via sendgmr" <kaleshsingh@kaleshsingh.c.googlers.com>
X-Received: from kaleshsingh.c.googlers.com ([fda3:e722:ac3:10:14:4d90:c0a8:2145])
 (user=kaleshsingh job=sendgmr) by 2002:ad4:58e3:: with SMTP id
 di3mr4707465qvb.54.1601504537414; Wed, 30 Sep 2020 15:22:17 -0700 (PDT)
Date:   Wed, 30 Sep 2020 22:21:21 +0000
In-Reply-To: <20200930222130.4175584-1-kaleshsingh@google.com>
Message-Id: <20200930222130.4175584-5-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20200930222130.4175584-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH 4/5] arm64: mremap speedup - Enable HAVE_MOVE_PUD
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
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Hassan Naveed <hnaveed@wavecomp.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Mike Rapoport <rppt@kernel.org>, Gavin Shan <gshan@redhat.com>,
        Dave Martin <Dave.Martin@arm.com>, Jia He <justin.he@arm.com>,
        Zhenyu Ye <yezhenyu2@huawei.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Zi Yan <ziy@nvidia.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Mina Almasry <almasrymina@google.com>,
        Sandipan Das <sandipan@linux.ibm.com>,
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
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

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
-- 
2.28.0.709.gb0816b6eb0-goog

