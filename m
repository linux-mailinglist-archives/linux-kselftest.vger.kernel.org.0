Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1894227F529
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Oct 2020 00:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725823AbgI3WcV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Sep 2020 18:32:21 -0400
Received: from mga05.intel.com ([192.55.52.43]:33895 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbgI3WcV (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Sep 2020 18:32:21 -0400
IronPort-SDR: xOC0ktZfK1NCNWeQogukt8i330INMNoUsqwMibEqWS0UwC+Gwc39nP2491n0TvpnPDsbBdY9lJ
 UmmUHaZZAxfA==
X-IronPort-AV: E=McAfee;i="6000,8403,9760"; a="247286591"
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="247286591"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2020 15:32:19 -0700
IronPort-SDR: Q7rxTOYZCmdrYkAyQbw0lh7HWMnLV4/XuKBvDgBo1VQoNDv2ETCE5XAs1PQ1BJnxZZojLYXOdv
 zUvQHx6xucDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="308332496"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 30 Sep 2020 15:32:08 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id B4156A8; Thu,  1 Oct 2020 01:32:07 +0300 (EEST)
Date:   Thu, 1 Oct 2020 01:32:07 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     surenb@google.com, minchan@google.com, joelaf@google.com,
        lokeshgidra@google.com, kernel-team@android.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Hassan Naveed <hnaveed@wavecomp.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@kernel.org>, Gavin Shan <gshan@redhat.com>,
        Zhenyu Ye <yezhenyu2@huawei.com>, Jia He <justin.he@arm.com>,
        John Hubbard <jhubbard@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Sandipan Das <sandipan@linux.ibm.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Mina Almasry <almasrymina@google.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Brian Geffon <bgeffon@google.com>,
        SeongJae Park <sjpark@amazon.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 0/5] Speed up mremap on large regions
Message-ID: <20200930223207.5xepuvu6wr6xw5bb@black.fi.intel.com>
References: <20200930222130.4175584-1-kaleshsingh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930222130.4175584-1-kaleshsingh@google.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Sep 30, 2020 at 10:21:17PM +0000, Kalesh Singh wrote:
> mremap time can be optimized by moving entries at the PMD/PUD level if
> the source and destination addresses are PMD/PUD-aligned and
> PMD/PUD-sized. Enable moving at the PMD and PUD levels on arm64 and
> x86. Other architectures where this type of move is supported and known to
> be safe can also opt-in to these optimizations by enabling HAVE_MOVE_PMD
> and HAVE_MOVE_PUD.
> 
> Observed Performance Improvements for remapping a PUD-aligned 1GB-sized
> region on x86 and arm64:
> 
>     - HAVE_MOVE_PMD is already enabled on x86 : N/A
>     - Enabling HAVE_MOVE_PUD on x86   : ~13x speed up
> 
>     - Enabling HAVE_MOVE_PMD on arm64 : ~ 8x speed up
>     - Enabling HAVE_MOVE_PUD on arm64 : ~19x speed up
> 
>           Altogether, HAVE_MOVE_PMD and HAVE_MOVE_PUD
>           give a total of ~150x speed up on arm64.

Is there a *real* workload that benefit from HAVE_MOVE_PUD?

-- 
 Kirill A. Shutemov
