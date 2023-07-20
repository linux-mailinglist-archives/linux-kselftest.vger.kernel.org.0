Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F00C75A8DE
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jul 2023 10:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjGTIO0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Jul 2023 04:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbjGTIOX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Jul 2023 04:14:23 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A90142686;
        Thu, 20 Jul 2023 01:14:20 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 767472F4;
        Thu, 20 Jul 2023 01:15:03 -0700 (PDT)
Received: from [10.1.38.38] (C02Z41KALVDN.cambridge.arm.com [10.1.38.38])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A74923F67D;
        Thu, 20 Jul 2023 01:14:18 -0700 (PDT)
Message-ID: <0e512516-6453-f7cb-67ee-f32c17eceea2@arm.com>
Date:   Thu, 20 Jul 2023 09:14:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v2 8/8] selftests/mm: Run all tests from run_vmtests.sh
To:     Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Mark Brown <broonie@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
References: <20230717103152.202078-1-ryan.roberts@arm.com>
 <20230717103152.202078-9-ryan.roberts@arm.com>
 <5a12536a-2e33-7a68-6cfd-fd991ddf875a@redhat.com> <ZLhLeSLgYgqSMSEA@x1n>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <ZLhLeSLgYgqSMSEA@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 19/07/2023 21:45, Peter Xu wrote:
> On Mon, Jul 17, 2023 at 07:27:13PM +0200, David Hildenbrand wrote:
>> On 17.07.23 12:31, Ryan Roberts wrote:
>>> It is very unclear to me how one is supposed to run all the mm selftests
>>> consistently and get clear results.
>>>
>>> Most of the test programs are launched by both run_vmtests.sh and
>>> run_kselftest.sh:
>>>
>>>    hugepage-mmap
>>>    hugepage-shm
>>>    map_hugetlb
>>>    hugepage-mremap
>>>    hugepage-vmemmap
>>>    hugetlb-madvise
>>>    map_fixed_noreplace
>>>    gup_test
>>>    gup_longterm
>>>    uffd-unit-tests
>>>    uffd-stress
>>>    compaction_test
>>>    on-fault-limit
>>>    map_populate
>>>    mlock-random-test
>>>    mlock2-tests
>>>    mrelease_test
>>>    mremap_test
>>>    thuge-gen
>>>    virtual_address_range
>>>    va_high_addr_switch
>>>    mremap_dontunmap
>>>    hmm-tests
>>>    madv_populate
>>>    memfd_secret
>>>    ksm_tests
>>>    ksm_functional_tests
>>>    soft-dirty
>>>    cow
>>>
>>> However, of this set, when launched by run_vmtests.sh, some of the
>>> programs are invoked multiple times with different arguments. When
>>> invoked by run_kselftest.sh, they are invoked without arguments (and as
>>> a consequence, some fail immediately).
>>>
>>> Some test programs are only launched by run_vmtests.sh:
>>>
>>>    test_vmalloc.sh
>>>
>>> And some test programs and only launched by run_kselftest.sh:
>>>
>>>    khugepaged
>>>    migration
>>>    mkdirty
>>>    transhuge-stress
>>>    split_huge_page_test
>>>    mdwe_test
>>>    write_to_hugetlbfs
>>>
>>> Furthermore, run_vmtests.sh is invoked by run_kselftest.sh, so in this
>>> case all the test programs invoked by both scripts are run twice!
>>>
>>> Needless to say, this is a bit of a mess. In the absence of fully
>>> understanding the history here, it looks to me like the best solution is
>>> to launch ALL test programs from run_vmtests.sh, and ONLY invoke
>>> run_vmtests.sh from run_kselftest.sh. This way, we get full control over
>>> the parameters, each program is only invoked the intended number of
>>> times, and regardless of which script is used, the same tests get run in
>>> the same way.
>>>
>>> The only drawback is that if using run_kselftest.sh, it's top-level tap
>>> result reporting reports only a single test and it fails if any of the
>>> contained tests fail. I don't see this as a big deal though since we
>>> still see all the nested reporting from multiple layers. The other issue
>>> with this is that all of run_vmtests.sh must execute within a single
>>> kselftest timeout period, so let's increase that to something more
>>> suitable.
>>>
>>> In the Makefile, TEST_GEN_PROGS will compile and install the tests and
>>> will add them to the list of tests that run_kselftest.sh will run.
>>> TEST_GEN_FILES will compile and install the tests but will not add them
>>> to the test list. So let's move all the programs from TEST_GEN_PROGS to
>>> TEST_GEN_FILES so that they are built but not executed by
>>> run_kselftest.sh. Note that run_vmtests.sh is added to TEST_PROGS, which
>>> means it ends up in the test list. (the lack of "_GEN" means it won't be
>>> compiled, but simply copied).
>>>
>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>> ---
>>
>> Acked-by: David Hildenbrand <david@redhat.com>
> 
> Thanks for letting me know, David.  Sorry for the late response, still
> catching up things.
> 
> I used to justify that from mm/ itself that everything should be PROG, but
> I see that from higher level where TEST_GEN_FILE|PROG is really used this
> makes sense.  As long as vm_utils.o will be properly linked I'll be happy
> enough..

Yep that's the case; I've set it up so that vm_utils.o is linked in for both
TEST_GEN_FILE and TEST_GEN_PROG binaries.

> 
> Acked-by: Peter Xu <peterx@redhat.com>

Thanks!

> 
> Thanks,
> 

