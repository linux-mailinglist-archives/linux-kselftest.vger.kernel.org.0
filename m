Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 200086D7353
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Apr 2023 06:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236797AbjDEEW0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Apr 2023 00:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236701AbjDEEWZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Apr 2023 00:22:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CD1CDE79;
        Tue,  4 Apr 2023 21:22:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF62F1684;
        Tue,  4 Apr 2023 21:23:07 -0700 (PDT)
Received: from [10.162.42.140] (a077209.arm.com [10.162.42.140])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E94F3F73F;
        Tue,  4 Apr 2023 21:22:20 -0700 (PDT)
Message-ID: <1b2cf3b4-fd11-43db-7f22-76a762ec8aa6@arm.com>
Date:   Wed, 5 Apr 2023 09:52:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 0/5] selftests/mm: Implement support for arm64 on va
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
References: <20230323105243.2807166-1-chaitanyas.prakash@arm.com>
Content-Language: en-US
From:   Chaitanya S Prakash <chaitanyas.prakash@arm.com>
In-Reply-To: <20230323105243.2807166-1-chaitanyas.prakash@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 3/23/23 16:22, Chaitanya S Prakash wrote:
> The va_128TBswitch selftest is designed and implemented for PowerPC and
> x86 architectures which support a 128TB switch, up to 256TB of virtual
> address space and hugepage sizes of 16MB and 2MB respectively. Arm64
> platforms on the other hand support a 256Tb switch, up to 4PB of virtual
> address space and a default hugepage size of 512MB when 64k pagesize is
> enabled.
> 
> These architectural differences require introducing support for arm64
> platforms, after which a more generic naming convention is suggested.
> The in code comments are amended to provide a more platform independent
> explanation of the working of the code and nr_hugepages are configured
> as required. Finally, the file running the testcase is modified in order
> to prevent skipping of hugetlb testcases of va_high_addr_switch.
> 
> This series has been tested on 6.3.0-rc3 kernel, both on arm64 and x86
> platforms.

Gentle ping, any updates?
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kselftest@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> 
> Chaitanya S Prakash (5):
>    selftests/mm: Add support for arm64 platform on va switch
>    selftests/mm: Rename va_128TBswitch to va_high_addr_switch
>    selftests/mm: Add platform independent in code comments
>    selftests/mm: Configure nr_hugepages for arm64
>    selftests/mm: Run hugetlb testcases of va switch
> 
>   tools/testing/selftests/mm/Makefile           |  4 +-
>   tools/testing/selftests/mm/run_vmtests.sh     | 12 +++++-
>   ...va_128TBswitch.c => va_high_addr_switch.c} | 41 +++++++++++++++----
>   ..._128TBswitch.sh => va_high_addr_switch.sh} |  6 ++-
>   4 files changed, 49 insertions(+), 14 deletions(-)
>   rename tools/testing/selftests/mm/{va_128TBswitch.c => va_high_addr_switch.c} (86%)
>   rename tools/testing/selftests/mm/{va_128TBswitch.sh => va_high_addr_switch.sh} (89%)
> 
