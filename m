Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 347416C6775
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Mar 2023 13:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjCWMBh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Mar 2023 08:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjCWMBK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Mar 2023 08:01:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DD7633B23B;
        Thu, 23 Mar 2023 04:59:41 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D80F4B3;
        Thu, 23 Mar 2023 05:00:10 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.53.155])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 991403F766;
        Thu, 23 Mar 2023 04:59:24 -0700 (PDT)
Date:   Thu, 23 Mar 2023 11:59:14 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Chaitanya S Prakash <chaitanyas.prakash@arm.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 0/5] selftests/mm: Implement support for arm64 on va
Message-ID: <ZBw/CVePzmshvMu7@FVFF77S0Q05N>
References: <20230323105243.2807166-1-chaitanyas.prakash@arm.com>
 <20230323111436.mj2kbesfxfmvj5by@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323111436.mj2kbesfxfmvj5by@box.shutemov.name>
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Mar 23, 2023 at 02:14:36PM +0300, Kirill A. Shutemov wrote:
> On Thu, Mar 23, 2023 at 04:22:38PM +0530, Chaitanya S Prakash wrote:
> > The va_128TBswitch selftest is designed and implemented for PowerPC and
> > x86 architectures which support a 128TB switch, up to 256TB of virtual
> > address space and hugepage sizes of 16MB and 2MB respectively. Arm64
> > platforms on the other hand support a 256Tb switch, up to 4PB of virtual
> > address space and a default hugepage size of 512MB when 64k pagesize is
> > enabled.
> > 
> > These architectural differences require introducing support for arm64
> > platforms, after which a more generic naming convention is suggested.
> > The in code comments are amended to provide a more platform independent
> > explanation of the working of the code and nr_hugepages are configured
> > as required. Finally, the file running the testcase is modified in order
> > to prevent skipping of hugetlb testcases of va_high_addr_switch.
> > 
> > This series has been tested on 6.3.0-rc3 kernel, both on arm64 and x86
> > platforms.
> > 
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> > Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Cc: Shuah Khan <shuah@kernel.org>
> > Cc: linux-mm@kvack.org
> > Cc: linux-kselftest@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org 
> > 
> > Chaitanya S Prakash (5):
> >   selftests/mm: Add support for arm64 platform on va switch
> >   selftests/mm: Rename va_128TBswitch to va_high_addr_switch
> >   selftests/mm: Add platform independent in code comments
> >   selftests/mm: Configure nr_hugepages for arm64
> >   selftests/mm: Run hugetlb testcases of va switch
> > 
> >  tools/testing/selftests/mm/Makefile           |  4 +-
> >  tools/testing/selftests/mm/run_vmtests.sh     | 12 +++++-
> >  ...va_128TBswitch.c => va_high_addr_switch.c} | 41 +++++++++++++++----
> >  ..._128TBswitch.sh => va_high_addr_switch.sh} |  6 ++-
> >  4 files changed, 49 insertions(+), 14 deletions(-)
> >  rename tools/testing/selftests/mm/{va_128TBswitch.c => va_high_addr_switch.c} (86%)
> >  rename tools/testing/selftests/mm/{va_128TBswitch.sh => va_high_addr_switch.sh} (89%)
> 
> The patchset looks sane to me, but I have question: why arm64 has switch
> on 256TB. The reason we have the switch is to keep system backward
> compatible.

It's the same reason, it's just that arm64 initially supported 48-bits / 256TB
of user addresses (0x0000000000000000..0x0000ffffffffffff), while x86_64
supported 47-bits / 128TB (0x0000000000000000..0x00007fffffffffff).

Note: arm64 has separate page tables for the user / kernel halves of the VA
space, which in practice means we get an extra bit of address range for each
half.

> Maybe it is better to make arm64 switch also on 128TB to make it
> compatible across architectures?

I don't think that's something that we can change; user addresses between 128TB
and 256TB have been the case for over a decade now, and avoiding that by
default could easily break something.

Thanks,
Mark.
