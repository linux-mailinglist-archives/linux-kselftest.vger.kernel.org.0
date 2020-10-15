Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2FCB28F06D
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Oct 2020 12:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbgJOKz4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 15 Oct 2020 06:55:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:39562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726654AbgJOKz4 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 15 Oct 2020 06:55:56 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A66B22249;
        Thu, 15 Oct 2020 10:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602759355;
        bh=te9muqVH1TRG904u4JJ4FrQCvPp6MwdDgE/Yv30w3PU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ckJ3wyU5jbwGNq4/krnO1Iy1JWHTNJXBDCx/Edql4YEfgqOnqGc+7gvGYh77bhyG6
         ZzO52I3qNsQ+7Ma4k76UevjKNz+Su710g/JPRn1RDafdL7bYn/BUxX+tX5YYYmcJWV
         0h1zvbDXckgkqYAVWhf9Fo7QapayWowt7udV4KE0=
Date:   Thu, 15 Oct 2020 11:55:43 +0100
From:   Will Deacon <will@kernel.org>
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     surenb@google.com, minchan@google.com, joelaf@google.com,
        lokeshgidra@google.com, kernel-team@android.com,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
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
Subject: Re: [PATCH v4 2/5] arm64: mremap speedup - Enable HAVE_MOVE_PMD
Message-ID: <20201015105542.GA5110@willie-the-truck>
References: <20201014005320.2233162-1-kaleshsingh@google.com>
 <20201014005320.2233162-3-kaleshsingh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201014005320.2233162-3-kaleshsingh@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 14, 2020 at 12:53:07AM +0000, Kalesh Singh wrote:
> HAVE_MOVE_PMD enables remapping pages at the PMD level if both the
> source and destination addresses are PMD-aligned.
> 
> HAVE_MOVE_PMD is already enabled on x86. The original patch [1] that
> introduced this config did not enable it on arm64 at the time because
> of performance issues with flushing the TLB on every PMD move. These
> issues have since been addressed in more recent releases with
> improvements to the arm64 TLB invalidation and core mmu_gather code as
> Will Deacon mentioned in [2].
> 
> From the data below, it can be inferred that there is approximately
> 8x improvement in performance when HAVE_MOVE_PMD is enabled on arm64.
> 
> --------- Test Results ----------
> 
> The following results were obtained on an arm64 device running a 5.4
> kernel, by remapping a PMD-aligned, 1GB sized region to a PMD-aligned
> destination. The results from 10 iterations of the test are given below.
> All times are in nanoseconds.
> 
> Control    HAVE_MOVE_PMD
> 
> 9220833    1247761
> 9002552    1219896
> 9254115    1094792
> 8725885    1227760
> 9308646    1043698
> 9001667    1101771
> 8793385    1159896
> 8774636    1143594
> 9553125    1025833
> 9374010    1078125
> 
> 9100885.4  1134312.6    <-- Mean Time in nanoseconds
> 
> Total mremap time for a 1GB sized PMD-aligned region drops from
> ~9.1 milliseconds to ~1.1 milliseconds. (~8x speedup).
> 
> [1] https://lore.kernel.org/r/20181108181201.88826-3-joelaf@google.com
> [2] https://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg140837.html
> 
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
> Changes in v4:
>   - Add Kirill's Acked-by.

Argh, I thought we already enabled this for PMDs back in 2018! Looks like
that we forgot to actually do that after I improved the performance of
the TLB invalidation.

I'll pick this one patch up for 5.10.

Will
