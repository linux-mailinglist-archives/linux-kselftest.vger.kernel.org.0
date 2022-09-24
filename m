Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 538AD5E8822
	for <lists+linux-kselftest@lfdr.de>; Sat, 24 Sep 2022 06:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbiIXEBr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 24 Sep 2022 00:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233282AbiIXEBp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 24 Sep 2022 00:01:45 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9903913CE4;
        Fri, 23 Sep 2022 21:01:43 -0700 (PDT)
Received: from [192.168.10.9] (unknown [39.45.35.73])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6E124660223A;
        Sat, 24 Sep 2022 05:01:38 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663992100;
        bh=wb24NBkS1aRl7XDSNP7kUYUqCb7fKdYQTFKsgvnDNF8=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=H+XerpGVWvqe0iDJaaVwxYvaJpaeFEeth+1/APLMGJIze1HWzH6G1pebDbgFFOkF+
         2MXs4qIdfz+qy3zRs7V0CJEpcom6ori0feJil/6ccuCd6GVBfnqxuQIPz5d7+j6lgn
         ec8D8fIfdIExm1pfi04laf8BCwy+DMgqIIBog/lUvDGuHUdIOdAI4uCKtL8e0mR1XH
         TfVN/wsthQxjup7ZUi8OEjSxFyrqsK3ziDAUOaUWn2ZIGolstLLFsYsYYzqU7Xc2Od
         pUvQ7yzWv4A2uqUoKJtp4vewdkGmONl/hplsELJBESyfYSZOYt2yyZPE8Fv1e7YPqW
         YeFom7ysQHffQ==
Message-ID: <df8f5779-28e7-76c4-2a39-eab0273d45d8@collabora.com>
Date:   Sat, 24 Sep 2022 09:01:34 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Cc:     usama.anjum@collabora.com,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel@collabora.com, krisman@collabora.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, Joel Savitz <jsavitz@redhat.com>
Subject: Re: [PATCH v6 1/2] selftests: vm: bring common functions to a new
 file
Content-Language: en-US
To:     Nico Pache <npache@redhat.com>, Shuah Khan <shuah@kernel.org>
References: <20220420084036.4101604-1-usama.anjum@collabora.com>
 <01f64e01-580e-abca-2b86-aa586d987bf4@redhat.com>
 <c3df7c71-79c1-7876-e39a-15cffc444da3@collabora.com>
 <CAA1CXcAMeoaSTc3Oa-ZppX9GqpDRH=cJ+aLnTgWU1-=OEcwTsw@mail.gmail.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <CAA1CXcAMeoaSTc3Oa-ZppX9GqpDRH=cJ+aLnTgWU1-=OEcwTsw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/24/22 3:35 AM, Nico Pache wrote:
> On Wed, Sep 21, 2022 at 5:06 AM Muhammad Usama Anjum
> <usama.anjum@collabora.com> wrote:
>>
>> On 9/9/22 8:06 AM, Nico Pache wrote:
>>>
>>>
>>> On 4/20/22 04:40, Muhammad Usama Anjum wrote:
>>>> Bring common functions to a new file while keeping code as much same as
>>>> possible. These functions can be used in the new tests. This helps in
>>>> avoiding code duplication.
>>>
>>> This commit breaks a pattern in the way tests are run in the current scheme.
>>> Before this commit the only executable (or TEST_PROGS) that was executed was
>>> run_vmselftests.sh. Now both madv_populate and split_huge_page_test are being
>>> run as well.
>>>>
>>>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>>> ---
>>>> Changes in V6:
>>>> - Correct header files inclusion
>>>>
>>>> Changes in V5:
>>>> Keep moved code as same as possible
>>>> - Updated macros names
>>>> - Removed macro used to show bit number of dirty bit, added a comment
>>>>   instead
>>>> - Corrected indentation
>>>> ---
>>>>  tools/testing/selftests/vm/Makefile           |   7 +-
>>>>  tools/testing/selftests/vm/madv_populate.c    |  34 +-----
>>>>  .../selftests/vm/split_huge_page_test.c       |  79 +------------
>>>>  tools/testing/selftests/vm/vm_util.c          | 108 ++++++++++++++++++
>>>>  tools/testing/selftests/vm/vm_util.h          |   9 ++
>>>>  5 files changed, 124 insertions(+), 113 deletions(-)
>>>>  create mode 100644 tools/testing/selftests/vm/vm_util.c
>>>>  create mode 100644 tools/testing/selftests/vm/vm_util.h
>>>>
>>>> diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
>>>> index 5e43f072f5b76..4e68edb26d6b6 100644
>>>> --- a/tools/testing/selftests/vm/Makefile
>>>> +++ b/tools/testing/selftests/vm/Makefile
>>>> @@ -34,7 +34,7 @@ TEST_GEN_FILES += hugepage-mremap
>>>>  TEST_GEN_FILES += hugepage-shm
>>>>  TEST_GEN_FILES += hugepage-vmemmap
>>>>  TEST_GEN_FILES += khugepaged
>>>> -TEST_GEN_FILES += madv_populate
>>>> +TEST_GEN_PROGS = madv_populate
>>> madv_populate is already being run in run_vmselftests.sh
>>>>  TEST_GEN_FILES += map_fixed_noreplace
>>>>  TEST_GEN_FILES += map_hugetlb
>>>>  TEST_GEN_FILES += map_populate
>>>> @@ -47,7 +47,7 @@ TEST_GEN_FILES += on-fault-limit
>>>>  TEST_GEN_FILES += thuge-gen
>>>>  TEST_GEN_FILES += transhuge-stress
>>>>  TEST_GEN_FILES += userfaultfd
>>>> -TEST_GEN_FILES += split_huge_page_test
>>>> +TEST_GEN_PROGS += split_huge_page_test
>>>>  TEST_GEN_FILES += ksm_tests
>>>>
>>>>  ifeq ($(MACHINE),x86_64)
>>>> @@ -91,6 +91,9 @@ TEST_FILES := test_vmalloc.sh
>>>>  KSFT_KHDR_INSTALL := 1
>>>>  include ../lib.mk
>>>>
>>>> +$(OUTPUT)/madv_populate: vm_util.c
>>>> +$(OUTPUT)/split_huge_page_test: vm_util.c
>>> Not sure what this does but if we add a run entry for split_huge_page_test in
>>> run_vmselftests.sh we wont really need this patch.
>>>
>>> I'm not sure the reduction in code size is worth the change in run behavior.
>>>
>>> Unless I'm missing something I suggest we revert this patch and add a run entry
>>> for split_huge_page_test in run_vmselftests.sh. I can do this if no one objects.
>> The run behavior isn't being changed here. Only the build behavior is
>> being changed as we want to keep the common code in one file. You can
>> add the run entry as required. I don't know why do you think the
>> Makefile has changed the run behavior.
> 
> Before your commit running
>     `make TARGETS=vm; make TARGETS=vm run_tests`
> had the following run behavior:
>     - The only thing executed via the run_tests wrapper is run_vmtests.sh
>     - TAP output is 1/1:
>         TAP version 13
>         1..1
>         # selftests: vm: run_vmtests.sh
>         # arm64 ia64 mips64 parisc64 ppc64 ppc64le riscv64 s390x sh64
> sparc64 x86_64
>         # -----------------------
>         # running ./hugepage-mmap
>         # -----------------------
>         ....
> 
> After your commit:
>     - Multiple executables (madv_populate, soft-dirty,
> split_huge_page_test, run_vmtests.sh) are defined and ran:
>          # selftests: vm: madv_populate
>          not ok 1 selftests: vm: madv_populate # exit=1
>          # selftests: vm: soft-dirty
>          ok 2 selftests: vm: soft-dirty
>          # selftests: vm: split_huge_page_test
>          ok 3 selftests: vm: split_huge_page_test
>          # selftests: vm: run_vmtests.sh
>          ok 4 selftests: vm: run_vmtests.sh # SKIP
> 
> I'm not saying utilizing the TEST_GEN_PROG variable is incorrect, I'm
> just pointing out that we have a sudden change in run behavior via the
> run_test wrapper. I personally think the TEST_GEN_PROG output is
> cleaner, but having two different ways of outputting results may be
> harder/confusing to parser. Additionally there is still the issue that
> madv_populate is being run twice for no reason.
Thank you for sharing. A directory inside selftests like selftests/vm
can have multiple individual tests. To me, it means that it can have
multiple binaries to run as individual tests. For selftests/vm,
historically we have this run_vmtests.sh as the only script which runs
all the tests inside the directory. This kind of script isn't present in
other selftests. So normally contributors are not aware of this script.
People use different ways to run selftests. So it doesn't get caught
easily. The tests can be run with different arguments through
run_vmtests.sh. But we shouldn't depend on run_vmtests.sh to run all the
tests as there are tests which have multiple source files and their
binary gets listed separately.

At this point, the parser can be updated. The duplicate runs of the
tests should be removed:
diff --git a/tools/testing/selftests/vm/run_vmtests.sh
b/tools/testing/selftests/vm/run_vmtests.sh
index e780e76c26b8..3bf946437ad9 100755
--- a/tools/testing/selftests/vm/run_vmtests.sh
+++ b/tools/testing/selftests/vm/run_vmtests.sh
@@ -166,9 +166,6 @@ run_test ./mremap_dontunmap

 run_test ./test_hmm.sh smoke

-# MADV_POPULATE_READ and MADV_POPULATE_WRITE tests
-run_test ./madv_populate
-
 run_test ./memfd_secret

 # KSM MADV_MERGEABLE test with 10 identical pages

The separate binaries are being run as I'd used TEST_GEN_PROGS. I hadn't
found any other way to build test with more than one source file. If
there is some other way, that should be used and supremacy of the
run_vmtests.sh can be kept.

> 
> Cheers,
> -- Nico
> 
>>
>>>
>>> Cheers,
>>> -- Nico
>>>
>>
>> --
>> Muhammad Usama Anjum
>>
> 

-- 
Muhammad Usama Anjum
