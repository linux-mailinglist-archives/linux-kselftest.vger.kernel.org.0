Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB22C752719
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jul 2023 17:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbjGMPau (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 11:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbjGMPa0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 11:30:26 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 781D31FDB;
        Thu, 13 Jul 2023 08:30:21 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A104C1570;
        Thu, 13 Jul 2023 08:31:03 -0700 (PDT)
Received: from [10.1.30.48] (C02Z41KALVDN.cambridge.arm.com [10.1.30.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A37C33F73F;
        Thu, 13 Jul 2023 08:30:19 -0700 (PDT)
Message-ID: <a8084196-38fc-7bbe-174c-3db4c174e3c8@arm.com>
Date:   Thu, 13 Jul 2023 16:30:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v1 9/9] selftests/mm: Run all tests from run_vmtests.sh
To:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Mark Brown <broonie@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Florent Revest <revest@chromium.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, Peter Xu <peterx@redhat.com>
References: <20230713135440.3651409-1-ryan.roberts@arm.com>
 <20230713135440.3651409-10-ryan.roberts@arm.com>
 <d77c6592-09f4-036d-ad00-a7a28de1da3f@redhat.com>
 <2b586ba2-7522-a823-afd6-7b4d978f18c2@arm.com>
 <57f4cfe0-2f20-c50a-439f-ee914dde1693@redhat.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <57f4cfe0-2f20-c50a-439f-ee914dde1693@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 13/07/2023 16:25, David Hildenbrand wrote:
>>>
>>> Which run_kselftest.sh are you referring to, the one in the parent directory?
>>
>> run_kselftest.sh is the uniform way of executing all the kselftests. mm seems to
>> be trying to be special as far as I can see. Certainly if you run the `install`
>> make target, kselftests will create a list of all the tests (including non-mm
>> tests if you have included them in the TARGETS variable) and copy that test list
>> and run_kselftest.sh to the install path along with all the test binaries. Then
>> the user can invoke any of the collections or specific tests in the collections
>> using that tool. It also wraps everything with tap output, runs tests with a
>> timeout, etc.
>>
>> See Documentation/dev-tools/kselftest.rst
>>
> 
> Got it, thanks!
> 
>>>
>>> How to invoke it to run these mm tests?
>>>
>>> (I never dared invoking something different than
>>> run_vmtests.sh ;) )
>>
>> # single test:
>> $ sudo ./run_kselftest.sh -t mm:<test_name>
>>
>> or
>>
>> # all tests in collection:
>> $ sudo ./run_kselftest.sh -c mm
>>
> 
> Ah, that makes sense. So I guess mm is then one "collection".

yep, the collections are the directories under tools/testing/selftests with a
few special exceptions.

> 
>>>
>>> [...]
>>>
>>>>
>>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>>> ---
>>>>    tools/testing/selftests/mm/Makefile       | 79 ++++++++++++-----------
>>>>    tools/testing/selftests/mm/run_vmtests.sh | 23 +++++++
>>>>    tools/testing/selftests/mm/settings       |  2 +-
>>>>    3 files changed, 64 insertions(+), 40 deletions(-)
>>>>
>>>> diff --git a/tools/testing/selftests/mm/Makefile
>>>> b/tools/testing/selftests/mm/Makefile
>>>> index 66d7c07dc177..881ed96d96fd 100644
>>>> --- a/tools/testing/selftests/mm/Makefile
>>>> +++ b/tools/testing/selftests/mm/Makefile
>>>> @@ -35,39 +35,39 @@ MAKEFLAGS += --no-builtin-rules
>>>>    CFLAGS = -Wall -I $(top_srcdir) $(EXTRA_CFLAGS) $(KHDR_INCLUDES)
>>>>    LDLIBS = -lrt -lpthread
>>>>    -TEST_GEN_PROGS = cow
>>>> -TEST_GEN_PROGS += compaction_test
>>>> -TEST_GEN_PROGS += gup_longterm
>>>> -TEST_GEN_PROGS += gup_test
>>>> -TEST_GEN_PROGS += hmm-tests
>>>> -TEST_GEN_PROGS += hugetlb-madvise
>>>> -TEST_GEN_PROGS += hugepage-mmap
>>>> -TEST_GEN_PROGS += hugepage-mremap
>>>> -TEST_GEN_PROGS += hugepage-shm
>>>> -TEST_GEN_PROGS += hugepage-vmemmap
>>>> -TEST_GEN_PROGS += khugepaged
>>>> -TEST_GEN_PROGS += madv_populate
>>>> -TEST_GEN_PROGS += map_fixed_noreplace
>>>> -TEST_GEN_PROGS += map_hugetlb
>>>> -TEST_GEN_PROGS += map_populate
>>>> -TEST_GEN_PROGS += memfd_secret
>>>> -TEST_GEN_PROGS += migration
>>>> -TEST_GEN_PROGS += mkdirty
>>>> -TEST_GEN_PROGS += mlock-random-test
>>>> -TEST_GEN_PROGS += mlock2-tests
>>>> -TEST_GEN_PROGS += mrelease_test
>>>> -TEST_GEN_PROGS += mremap_dontunmap
>>>> -TEST_GEN_PROGS += mremap_test
>>>> -TEST_GEN_PROGS += on-fault-limit
>>>> -TEST_GEN_PROGS += thuge-gen
>>>> -TEST_GEN_PROGS += transhuge-stress
>>>> -TEST_GEN_PROGS += uffd-stress
>>>> -TEST_GEN_PROGS += uffd-unit-tests
>>>> -TEST_GEN_PROGS += soft-dirty
>>>> -TEST_GEN_PROGS += split_huge_page_test
>>>> -TEST_GEN_PROGS += ksm_tests
>>>> -TEST_GEN_PROGS += ksm_functional_tests
>>>> -TEST_GEN_PROGS += mdwe_test
>>>> +TEST_GEN_FILES = cow
>>>> +TEST_GEN_FILES += compaction_test
>>>> +TEST_GEN_FILES += gup_longterm
>>>> +TEST_GEN_FILES += gup_test
>>>> +TEST_GEN_FILES += hmm-tests
>>>> +TEST_GEN_FILES += hugetlb-madvise
>>>> +TEST_GEN_FILES += hugepage-mmap
>>>> +TEST_GEN_FILES += hugepage-mremap
>>>> +TEST_GEN_FILES += hugepage-shm
>>>> +TEST_GEN_FILES += hugepage-vmemmap
>>>> +TEST_GEN_FILES += khugepaged
>>>> +TEST_GEN_FILES += madv_populate
>>>> +TEST_GEN_FILES += map_fixed_noreplace
>>>> +TEST_GEN_FILES += map_hugetlb
>>>> +TEST_GEN_FILES += map_populate
>>>> +TEST_GEN_FILES += memfd_secret
>>>> +TEST_GEN_FILES += migration
>>>> +TEST_GEN_FILES += mkdirty
>>>> +TEST_GEN_FILES += mlock-random-test
>>>> +TEST_GEN_FILES += mlock2-tests
>>>> +TEST_GEN_FILES += mrelease_test
>>>> +TEST_GEN_FILES += mremap_dontunmap
>>>> +TEST_GEN_FILES += mremap_test
>>>> +TEST_GEN_FILES += on-fault-limit
>>>> +TEST_GEN_FILES += thuge-gen
>>>> +TEST_GEN_FILES += transhuge-stress
>>>> +TEST_GEN_FILES += uffd-stress
>>>> +TEST_GEN_FILES += uffd-unit-tests
>>>> +TEST_GEN_FILES += soft-dirty
>>>> +TEST_GEN_FILES += split_huge_page_test
>>>> +TEST_GEN_FILES += ksm_tests
>>>> +TEST_GEN_FILES += ksm_functional_tests
>>>> +TEST_GEN_FILES += mdwe_test
>>>
>>> IIRC, we recently converted all to TEST_GEN_PROGS. See
>>>
>>> commit aef6fde75d8c6c1cad4a0e017a8d4cbee2143723
>>> Author: Peter Xu <peterx@redhat.com>
>>> Date:   Wed Apr 12 12:42:18 2023 -0400
>>>
>>>      selftests/mm: use TEST_GEN_PROGS where proper
>>>          TEST_GEN_PROGS and TEST_GEN_FILES are used randomly in the
>>> mm/Makefile to
>>>      specify programs that need to build.  Logically all these binaries should
>>>      all fall into TEST_GEN_PROGS.
>>>          Replace those TEST_GEN_FILES with TEST_GEN_PROGS, so that we can
>>> reference
>>>      all the tests easily later.
>>>
>>>
>>> Why is that change required, and how does it interact with
>>> run_kselftest.sh? (Not clear from you patch description.)
>>
>> TEST_GEN_PROGS will compile and install the tests and will add them to the list
>> of tests that run_kselftest.sh will run. TEST_GEN_FILES will compile and install
>> the tests but will not add them to the test list.
>>
>> Note that run_vmtests.sh is added to TEST_PROGS, which means it ends up in the
>> test list. (the lack of "_GEN" means it won't be compiled, but simply copied).
>>
>> So with this change at the kselftest level, there is a single test in its list;
>> run_vmtests.sh. And all the other tests that were previously in that list are
>> moved into run_vmtests.sh (if they weren't there already).
> 
> That sound good to me. (worth adding to the patch description)
> 
> Let me CC Peter, so he's aware.

Thanks - would be good to hear his opinion!


