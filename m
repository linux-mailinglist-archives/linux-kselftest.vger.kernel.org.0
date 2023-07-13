Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07C67526E1
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jul 2023 17:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbjGMP1I (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 11:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234684AbjGMP0t (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 11:26:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0ADF1FD6
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Jul 2023 08:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689261956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YTyQOOC//U8Og4/WA4jzJJru1aS6+IZedvreavXkuvE=;
        b=Iwp1FruxbwW8WJ8x76cwdOdlSdNjFO0tzOp/UYHpBXaA8i8p7Ce29fG5LkPTdZsMSJFzHf
        Yl2svFwBkTtB/Y4GuYtJA/HVGAPIvLHMee/aNoAQ4xqsEoTLoXdt3oA1nHn+mtAWED1PiQ
        cHhCi1Q1Z8zVrXp5qQ0zB1hBP7MEy10=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-HwTkj0x4P3mXK4Uy3ntYyw-1; Thu, 13 Jul 2023 11:25:55 -0400
X-MC-Unique: HwTkj0x4P3mXK4Uy3ntYyw-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2b6ad88815eso8408851fa.3
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Jul 2023 08:25:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689261938; x=1691853938;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YTyQOOC//U8Og4/WA4jzJJru1aS6+IZedvreavXkuvE=;
        b=iyFKkBBE0Zf3bERAm/ejevfqpCqFn63tIS/m3lS/bWv91A26d+3efjvpH6fjyog1Lg
         KgsCKf9XhIciLMM/NaRBRQ4M8TcA7+2gMS+9H5zUUpr43MVJ6EXlnwRpIvJTgxrR9WCW
         86pHM3YO5s0gdkyZ+57BEm2j3BowRRhzgNi/zrmvbEsuleawtb7Q+6b2+/nfwN+kIv+S
         rNE3OmBvpLE4GiWsKxLcwTgIbjN/ednmS3rGxOokCNOWz+dRMwolKx/eZ9pt2V42vwdn
         830mtiIcvXcmiCOdjaUku3PMiBfl1iLYrSgj+4Nq+fu9RlHs3IrrBD2rvoTnWYbsob7R
         UQhw==
X-Gm-Message-State: ABy/qLZZGhNkjvD1gatujxLQQ4qLBdfQcpWWumu6uypa04lDb4ABegrl
        R2P5QDP6Va/enPp8TUxxl2cznW2YzwmJzFRKR+Qcp0WaVH2H3vqQt1dJXsa2DoKuwBrfy2dcrU+
        UzPupExID8sbxnrQh0z/OmGQtL1CR
X-Received: by 2002:a2e:98d2:0:b0:2b6:cd12:24f7 with SMTP id s18-20020a2e98d2000000b002b6cd1224f7mr1871074ljj.44.1689261938037;
        Thu, 13 Jul 2023 08:25:38 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGYa8s8q1BOcKvw6NzmwI8a8tReA9pD5wtqHyEdYGSX1dP/THfRMRenFXA2BpekJVW87YhtUw==
X-Received: by 2002:a2e:98d2:0:b0:2b6:cd12:24f7 with SMTP id s18-20020a2e98d2000000b002b6cd1224f7mr1871051ljj.44.1689261937629;
        Thu, 13 Jul 2023 08:25:37 -0700 (PDT)
Received: from ?IPV6:2003:cb:c717:6100:2da7:427e:49a5:e07? (p200300cbc71761002da7427e49a50e07.dip0.t-ipconnect.de. [2003:cb:c717:6100:2da7:427e:49a5:e07])
        by smtp.gmail.com with ESMTPSA id k6-20020a05600c0b4600b003fc00702f65sm17464841wmr.46.2023.07.13.08.25.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 08:25:37 -0700 (PDT)
Message-ID: <57f4cfe0-2f20-c50a-439f-ee914dde1693@redhat.com>
Date:   Thu, 13 Jul 2023 17:25:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1 9/9] selftests/mm: Run all tests from run_vmtests.sh
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>,
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <2b586ba2-7522-a823-afd6-7b4d978f18c2@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

>>
>> Which run_kselftest.sh are you referring to, the one in the parent directory?
> 
> run_kselftest.sh is the uniform way of executing all the kselftests. mm seems to
> be trying to be special as far as I can see. Certainly if you run the `install`
> make target, kselftests will create a list of all the tests (including non-mm
> tests if you have included them in the TARGETS variable) and copy that test list
> and run_kselftest.sh to the install path along with all the test binaries. Then
> the user can invoke any of the collections or specific tests in the collections
> using that tool. It also wraps everything with tap output, runs tests with a
> timeout, etc.
> 
> See Documentation/dev-tools/kselftest.rst
> 

Got it, thanks!

>>
>> How to invoke it to run these mm tests?
>>
>> (I never dared invoking something different than
>> run_vmtests.sh ;) )
> 
> # single test:
> $ sudo ./run_kselftest.sh -t mm:<test_name>
> 
> or
> 
> # all tests in collection:
> $ sudo ./run_kselftest.sh -c mm
> 

Ah, that makes sense. So I guess mm is then one "collection".

>>
>> [...]
>>
>>>
>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>> ---
>>>    tools/testing/selftests/mm/Makefile       | 79 ++++++++++++-----------
>>>    tools/testing/selftests/mm/run_vmtests.sh | 23 +++++++
>>>    tools/testing/selftests/mm/settings       |  2 +-
>>>    3 files changed, 64 insertions(+), 40 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/mm/Makefile
>>> b/tools/testing/selftests/mm/Makefile
>>> index 66d7c07dc177..881ed96d96fd 100644
>>> --- a/tools/testing/selftests/mm/Makefile
>>> +++ b/tools/testing/selftests/mm/Makefile
>>> @@ -35,39 +35,39 @@ MAKEFLAGS += --no-builtin-rules
>>>    CFLAGS = -Wall -I $(top_srcdir) $(EXTRA_CFLAGS) $(KHDR_INCLUDES)
>>>    LDLIBS = -lrt -lpthread
>>>    -TEST_GEN_PROGS = cow
>>> -TEST_GEN_PROGS += compaction_test
>>> -TEST_GEN_PROGS += gup_longterm
>>> -TEST_GEN_PROGS += gup_test
>>> -TEST_GEN_PROGS += hmm-tests
>>> -TEST_GEN_PROGS += hugetlb-madvise
>>> -TEST_GEN_PROGS += hugepage-mmap
>>> -TEST_GEN_PROGS += hugepage-mremap
>>> -TEST_GEN_PROGS += hugepage-shm
>>> -TEST_GEN_PROGS += hugepage-vmemmap
>>> -TEST_GEN_PROGS += khugepaged
>>> -TEST_GEN_PROGS += madv_populate
>>> -TEST_GEN_PROGS += map_fixed_noreplace
>>> -TEST_GEN_PROGS += map_hugetlb
>>> -TEST_GEN_PROGS += map_populate
>>> -TEST_GEN_PROGS += memfd_secret
>>> -TEST_GEN_PROGS += migration
>>> -TEST_GEN_PROGS += mkdirty
>>> -TEST_GEN_PROGS += mlock-random-test
>>> -TEST_GEN_PROGS += mlock2-tests
>>> -TEST_GEN_PROGS += mrelease_test
>>> -TEST_GEN_PROGS += mremap_dontunmap
>>> -TEST_GEN_PROGS += mremap_test
>>> -TEST_GEN_PROGS += on-fault-limit
>>> -TEST_GEN_PROGS += thuge-gen
>>> -TEST_GEN_PROGS += transhuge-stress
>>> -TEST_GEN_PROGS += uffd-stress
>>> -TEST_GEN_PROGS += uffd-unit-tests
>>> -TEST_GEN_PROGS += soft-dirty
>>> -TEST_GEN_PROGS += split_huge_page_test
>>> -TEST_GEN_PROGS += ksm_tests
>>> -TEST_GEN_PROGS += ksm_functional_tests
>>> -TEST_GEN_PROGS += mdwe_test
>>> +TEST_GEN_FILES = cow
>>> +TEST_GEN_FILES += compaction_test
>>> +TEST_GEN_FILES += gup_longterm
>>> +TEST_GEN_FILES += gup_test
>>> +TEST_GEN_FILES += hmm-tests
>>> +TEST_GEN_FILES += hugetlb-madvise
>>> +TEST_GEN_FILES += hugepage-mmap
>>> +TEST_GEN_FILES += hugepage-mremap
>>> +TEST_GEN_FILES += hugepage-shm
>>> +TEST_GEN_FILES += hugepage-vmemmap
>>> +TEST_GEN_FILES += khugepaged
>>> +TEST_GEN_FILES += madv_populate
>>> +TEST_GEN_FILES += map_fixed_noreplace
>>> +TEST_GEN_FILES += map_hugetlb
>>> +TEST_GEN_FILES += map_populate
>>> +TEST_GEN_FILES += memfd_secret
>>> +TEST_GEN_FILES += migration
>>> +TEST_GEN_FILES += mkdirty
>>> +TEST_GEN_FILES += mlock-random-test
>>> +TEST_GEN_FILES += mlock2-tests
>>> +TEST_GEN_FILES += mrelease_test
>>> +TEST_GEN_FILES += mremap_dontunmap
>>> +TEST_GEN_FILES += mremap_test
>>> +TEST_GEN_FILES += on-fault-limit
>>> +TEST_GEN_FILES += thuge-gen
>>> +TEST_GEN_FILES += transhuge-stress
>>> +TEST_GEN_FILES += uffd-stress
>>> +TEST_GEN_FILES += uffd-unit-tests
>>> +TEST_GEN_FILES += soft-dirty
>>> +TEST_GEN_FILES += split_huge_page_test
>>> +TEST_GEN_FILES += ksm_tests
>>> +TEST_GEN_FILES += ksm_functional_tests
>>> +TEST_GEN_FILES += mdwe_test
>>
>> IIRC, we recently converted all to TEST_GEN_PROGS. See
>>
>> commit aef6fde75d8c6c1cad4a0e017a8d4cbee2143723
>> Author: Peter Xu <peterx@redhat.com>
>> Date:   Wed Apr 12 12:42:18 2023 -0400
>>
>>      selftests/mm: use TEST_GEN_PROGS where proper
>>          TEST_GEN_PROGS and TEST_GEN_FILES are used randomly in the mm/Makefile to
>>      specify programs that need to build.  Logically all these binaries should
>>      all fall into TEST_GEN_PROGS.
>>          Replace those TEST_GEN_FILES with TEST_GEN_PROGS, so that we can reference
>>      all the tests easily later.
>>
>>
>> Why is that change required, and how does it interact with
>> run_kselftest.sh? (Not clear from you patch description.)
> 
> TEST_GEN_PROGS will compile and install the tests and will add them to the list
> of tests that run_kselftest.sh will run. TEST_GEN_FILES will compile and install
> the tests but will not add them to the test list.
> 
> Note that run_vmtests.sh is added to TEST_PROGS, which means it ends up in the
> test list. (the lack of "_GEN" means it won't be compiled, but simply copied).
> 
> So with this change at the kselftest level, there is a single test in its list;
> run_vmtests.sh. And all the other tests that were previously in that list are
> moved into run_vmtests.sh (if they weren't there already).

That sound good to me. (worth adding to the patch description)

Let me CC Peter, so he's aware.

-- 
Cheers,

David / dhildenb

