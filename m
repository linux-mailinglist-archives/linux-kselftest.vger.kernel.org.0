Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09FE66C7C51
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Mar 2023 11:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbjCXKQA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Mar 2023 06:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjCXKQA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Mar 2023 06:16:00 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5ECADDBEB;
        Fri, 24 Mar 2023 03:15:58 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2EC4011FB;
        Fri, 24 Mar 2023 03:16:42 -0700 (PDT)
Received: from [192.168.0.110] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 600463F6C4;
        Fri, 24 Mar 2023 03:15:55 -0700 (PDT)
Message-ID: <9a2fc29b-ab4c-b13a-0ac3-772a47039750@arm.com>
Date:   Fri, 24 Mar 2023 15:45:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 0/5] selftests/mm: Implement support for arm64 on va
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>,
        Chaitanya S Prakash <chaitanyas.prakash@arm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
References: <20230323105243.2807166-1-chaitanyas.prakash@arm.com>
 <20230323144910.b07df164acc1d85bc76dc933@linux-foundation.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20230323144910.b07df164acc1d85bc76dc933@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 3/24/23 03:19, Andrew Morton wrote:
> On Thu, 23 Mar 2023 16:22:38 +0530 Chaitanya S Prakash <chaitanyas.prakash@arm.com> wrote:
> 
>> The va_128TBswitch selftest is designed and implemented for PowerPC and
>> x86 architectures which support a 128TB switch, up to 256TB of virtual
>> address space and hugepage sizes of 16MB and 2MB respectively. Arm64
>> platforms on the other hand support a 256Tb switch, up to 4PB of virtual
>> address space and a default hugepage size of 512MB when 64k pagesize is
>> enabled.
>>
>> These architectural differences require introducing support for arm64
>> platforms, after which a more generic naming convention is suggested.
>> The in code comments are amended to provide a more platform independent
>> explanation of the working of the code and nr_hugepages are configured
>> as required. Finally, the file running the testcase is modified in order
>> to prevent skipping of hugetlb testcases of va_high_addr_switch.
>>
>> This series has been tested on 6.3.0-rc3 kernel, both on arm64 and x86
>> platforms.
> 
> Would it make sense to get this series into the ARM tree, so it sees
> more testing on ARM
Rather, it will be better for this series to go via the mm tree instead
(via linux-next first) for better coverage on all platforms, this being
a common test.
