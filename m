Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD302752619
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jul 2023 17:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbjGMPFP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 11:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbjGMPFD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 11:05:03 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 410DF2D7B;
        Thu, 13 Jul 2023 08:04:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 724981570;
        Thu, 13 Jul 2023 08:05:29 -0700 (PDT)
Received: from [10.1.30.48] (C02Z41KALVDN.cambridge.arm.com [10.1.30.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8538A3F73F;
        Thu, 13 Jul 2023 08:04:45 -0700 (PDT)
Message-ID: <2b586ba2-7522-a823-afd6-7b4d978f18c2@arm.com>
Date:   Thu, 13 Jul 2023 16:04:44 +0100
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
        linux-kselftest@vger.kernel.org
References: <20230713135440.3651409-1-ryan.roberts@arm.com>
 <20230713135440.3651409-10-ryan.roberts@arm.com>
 <d77c6592-09f4-036d-ad00-a7a28de1da3f@redhat.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <d77c6592-09f4-036d-ad00-a7a28de1da3f@redhat.com>
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

On 13/07/2023 15:50, David Hildenbrand wrote:
> On 13.07.23 15:54, Ryan Roberts wrote:
>> It is very unclear to me how one is supposed to run all the mm selftests
>> consistently and get clear results.
>>
>> Most of the test programs are launched by both run_vmtests.sh and
>> run_kselftest.sh:
>>
>>    hugepage-mmap
>>    hugepage-shm
>>    map_hugetlb
>>    hugepage-mremap
>>    hugepage-vmemmap
>>    hugetlb-madvise
>>    map_fixed_noreplace
>>    gup_test
>>    gup_longterm
>>    uffd-unit-tests
>>    uffd-stress
>>    compaction_test
>>    on-fault-limit
>>    map_populate
>>    mlock-random-test
>>    mlock2-tests
>>    mrelease_test
>>    mremap_test
>>    thuge-gen
>>    virtual_address_range
>>    va_high_addr_switch
>>    mremap_dontunmap
>>    hmm-tests
>>    madv_populate
>>    memfd_secret
>>    ksm_tests
>>    ksm_functional_tests
>>    soft-dirty
>>    cow
>>
> 
> Which run_kselftest.sh are you referring to, the one in the parent directory?

run_kselftest.sh is the uniform way of executing all the kselftests. mm seems to
be trying to be special as far as I can see. Certainly if you run the `install`
make target, kselftests will create a list of all the tests (including non-mm
tests if you have included them in the TARGETS variable) and copy that test list
and run_kselftest.sh to the install path along with all the test binaries. Then
the user can invoke any of the collections or specific tests in the collections
using that tool. It also wraps everything with tap output, runs tests with a
timeout, etc.

See Documentation/dev-tools/kselftest.rst

> 
> How to invoke it to run these mm tests?
> 
> (I never dared invoking something different than
> run_vmtests.sh ;) )

# single test:
$ sudo ./run_kselftest.sh -t mm:<test_name>

or

# all tests in collection:
$ sudo ./run_kselftest.sh -c mm

> 
> [...]
> 
>>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>   tools/testing/selftests/mm/Makefile       | 79 ++++++++++++-----------
>>   tools/testing/selftests/mm/run_vmtests.sh | 23 +++++++
>>   tools/testing/selftests/mm/settings       |  2 +-
>>   3 files changed, 64 insertions(+), 40 deletions(-)
>>
>> diff --git a/tools/testing/selftests/mm/Makefile
>> b/tools/testing/selftests/mm/Makefile
>> index 66d7c07dc177..881ed96d96fd 100644
>> --- a/tools/testing/selftests/mm/Makefile
>> +++ b/tools/testing/selftests/mm/Makefile
>> @@ -35,39 +35,39 @@ MAKEFLAGS += --no-builtin-rules
>>   CFLAGS = -Wall -I $(top_srcdir) $(EXTRA_CFLAGS) $(KHDR_INCLUDES)
>>   LDLIBS = -lrt -lpthread
>>   -TEST_GEN_PROGS = cow
>> -TEST_GEN_PROGS += compaction_test
>> -TEST_GEN_PROGS += gup_longterm
>> -TEST_GEN_PROGS += gup_test
>> -TEST_GEN_PROGS += hmm-tests
>> -TEST_GEN_PROGS += hugetlb-madvise
>> -TEST_GEN_PROGS += hugepage-mmap
>> -TEST_GEN_PROGS += hugepage-mremap
>> -TEST_GEN_PROGS += hugepage-shm
>> -TEST_GEN_PROGS += hugepage-vmemmap
>> -TEST_GEN_PROGS += khugepaged
>> -TEST_GEN_PROGS += madv_populate
>> -TEST_GEN_PROGS += map_fixed_noreplace
>> -TEST_GEN_PROGS += map_hugetlb
>> -TEST_GEN_PROGS += map_populate
>> -TEST_GEN_PROGS += memfd_secret
>> -TEST_GEN_PROGS += migration
>> -TEST_GEN_PROGS += mkdirty
>> -TEST_GEN_PROGS += mlock-random-test
>> -TEST_GEN_PROGS += mlock2-tests
>> -TEST_GEN_PROGS += mrelease_test
>> -TEST_GEN_PROGS += mremap_dontunmap
>> -TEST_GEN_PROGS += mremap_test
>> -TEST_GEN_PROGS += on-fault-limit
>> -TEST_GEN_PROGS += thuge-gen
>> -TEST_GEN_PROGS += transhuge-stress
>> -TEST_GEN_PROGS += uffd-stress
>> -TEST_GEN_PROGS += uffd-unit-tests
>> -TEST_GEN_PROGS += soft-dirty
>> -TEST_GEN_PROGS += split_huge_page_test
>> -TEST_GEN_PROGS += ksm_tests
>> -TEST_GEN_PROGS += ksm_functional_tests
>> -TEST_GEN_PROGS += mdwe_test
>> +TEST_GEN_FILES = cow
>> +TEST_GEN_FILES += compaction_test
>> +TEST_GEN_FILES += gup_longterm
>> +TEST_GEN_FILES += gup_test
>> +TEST_GEN_FILES += hmm-tests
>> +TEST_GEN_FILES += hugetlb-madvise
>> +TEST_GEN_FILES += hugepage-mmap
>> +TEST_GEN_FILES += hugepage-mremap
>> +TEST_GEN_FILES += hugepage-shm
>> +TEST_GEN_FILES += hugepage-vmemmap
>> +TEST_GEN_FILES += khugepaged
>> +TEST_GEN_FILES += madv_populate
>> +TEST_GEN_FILES += map_fixed_noreplace
>> +TEST_GEN_FILES += map_hugetlb
>> +TEST_GEN_FILES += map_populate
>> +TEST_GEN_FILES += memfd_secret
>> +TEST_GEN_FILES += migration
>> +TEST_GEN_FILES += mkdirty
>> +TEST_GEN_FILES += mlock-random-test
>> +TEST_GEN_FILES += mlock2-tests
>> +TEST_GEN_FILES += mrelease_test
>> +TEST_GEN_FILES += mremap_dontunmap
>> +TEST_GEN_FILES += mremap_test
>> +TEST_GEN_FILES += on-fault-limit
>> +TEST_GEN_FILES += thuge-gen
>> +TEST_GEN_FILES += transhuge-stress
>> +TEST_GEN_FILES += uffd-stress
>> +TEST_GEN_FILES += uffd-unit-tests
>> +TEST_GEN_FILES += soft-dirty
>> +TEST_GEN_FILES += split_huge_page_test
>> +TEST_GEN_FILES += ksm_tests
>> +TEST_GEN_FILES += ksm_functional_tests
>> +TEST_GEN_FILES += mdwe_test
> 
> IIRC, we recently converted all to TEST_GEN_PROGS. See
> 
> commit aef6fde75d8c6c1cad4a0e017a8d4cbee2143723
> Author: Peter Xu <peterx@redhat.com>
> Date:   Wed Apr 12 12:42:18 2023 -0400
> 
>     selftests/mm: use TEST_GEN_PROGS where proper
>         TEST_GEN_PROGS and TEST_GEN_FILES are used randomly in the mm/Makefile to
>     specify programs that need to build.  Logically all these binaries should
>     all fall into TEST_GEN_PROGS.
>         Replace those TEST_GEN_FILES with TEST_GEN_PROGS, so that we can reference
>     all the tests easily later.
> 
> 
> Why is that change required, and how does it interact with
> run_kselftest.sh? (Not clear from you patch description.)

TEST_GEN_PROGS will compile and install the tests and will add them to the list
of tests that run_kselftest.sh will run. TEST_GEN_FILES will compile and install
the tests but will not add them to the test list.

Note that run_vmtests.sh is added to TEST_PROGS, which means it ends up in the
test list. (the lack of "_GEN" means it won't be compiled, but simply copied).

So with this change at the kselftest level, there is a single test in its list;
run_vmtests.sh. And all the other tests that were previously in that list are
moved into run_vmtests.sh (if they weren't there already).

I've only learnt all this today; All based on info in kselftest.rst.

> 

