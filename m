Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D14A75BFCB8
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Sep 2022 13:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiIULGO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Sep 2022 07:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiIULGN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Sep 2022 07:06:13 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D05C832C9;
        Wed, 21 Sep 2022 04:06:12 -0700 (PDT)
Received: from [192.168.10.9] (unknown [39.45.34.16])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id ADB3F6602028;
        Wed, 21 Sep 2022 12:06:08 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663758371;
        bh=nuKvXuAY4Qozyni7h0nt+ch9rX1wpz7qK5yc710ELL8=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=AP5Ygg/TB0BOpHeku/CfraDNwnteQItCpz1LXbjC5qASX68yK99F44dzXYi8lI5xp
         IAslEbJqK1fKFDFTQJOFObd5vIBOaN3AqL5RcyETSQUxDDOCJxh+tisaeexMV7SyGM
         4BNdWykfRlqZctcj3O4JxNSxJl3+OdYN2hlW61aFxXfXyqxTcjMK8Jk2zI2S+v/OAN
         feFEbtBJvWYOwt0JDVoJ/1MWipBWRyir3qOLMT/mg/RLnC0WqNSKOlpteE6Hxxot9n
         lgxx5eAlnwPMDCiG2KNzTZXRKb/69nHz/xBceFZcLdsmdTG5+2CIYS97i3jiDfAmkR
         kFMZThPHEc8og==
Message-ID: <c3df7c71-79c1-7876-e39a-15cffc444da3@collabora.com>
Date:   Wed, 21 Sep 2022 16:06:03 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Cc:     usama.anjum@collabora.com, kernel@collabora.com,
        krisman@collabora.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Joel Savitz <jsavitz@redhat.com>
Subject: Re: [PATCH v6 1/2] selftests: vm: bring common functions to a new
 file
Content-Language: en-US
To:     Nico Pache <npache@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>
References: <20220420084036.4101604-1-usama.anjum@collabora.com>
 <01f64e01-580e-abca-2b86-aa586d987bf4@redhat.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <01f64e01-580e-abca-2b86-aa586d987bf4@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/9/22 8:06 AM, Nico Pache wrote:
> 
> 
> On 4/20/22 04:40, Muhammad Usama Anjum wrote:
>> Bring common functions to a new file while keeping code as much same as
>> possible. These functions can be used in the new tests. This helps in
>> avoiding code duplication.
> 
> This commit breaks a pattern in the way tests are run in the current scheme.
> Before this commit the only executable (or TEST_PROGS) that was executed was
> run_vmselftests.sh. Now both madv_populate and split_huge_page_test are being
> run as well.
>>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>> Changes in V6:
>> - Correct header files inclusion
>>
>> Changes in V5:
>> Keep moved code as same as possible
>> - Updated macros names
>> - Removed macro used to show bit number of dirty bit, added a comment
>>   instead
>> - Corrected indentation
>> ---
>>  tools/testing/selftests/vm/Makefile           |   7 +-
>>  tools/testing/selftests/vm/madv_populate.c    |  34 +-----
>>  .../selftests/vm/split_huge_page_test.c       |  79 +------------
>>  tools/testing/selftests/vm/vm_util.c          | 108 ++++++++++++++++++
>>  tools/testing/selftests/vm/vm_util.h          |   9 ++
>>  5 files changed, 124 insertions(+), 113 deletions(-)
>>  create mode 100644 tools/testing/selftests/vm/vm_util.c
>>  create mode 100644 tools/testing/selftests/vm/vm_util.h
>>
>> diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
>> index 5e43f072f5b76..4e68edb26d6b6 100644
>> --- a/tools/testing/selftests/vm/Makefile
>> +++ b/tools/testing/selftests/vm/Makefile
>> @@ -34,7 +34,7 @@ TEST_GEN_FILES += hugepage-mremap
>>  TEST_GEN_FILES += hugepage-shm
>>  TEST_GEN_FILES += hugepage-vmemmap
>>  TEST_GEN_FILES += khugepaged
>> -TEST_GEN_FILES += madv_populate
>> +TEST_GEN_PROGS = madv_populate
> madv_populate is already being run in run_vmselftests.sh
>>  TEST_GEN_FILES += map_fixed_noreplace
>>  TEST_GEN_FILES += map_hugetlb
>>  TEST_GEN_FILES += map_populate
>> @@ -47,7 +47,7 @@ TEST_GEN_FILES += on-fault-limit
>>  TEST_GEN_FILES += thuge-gen
>>  TEST_GEN_FILES += transhuge-stress
>>  TEST_GEN_FILES += userfaultfd
>> -TEST_GEN_FILES += split_huge_page_test
>> +TEST_GEN_PROGS += split_huge_page_test
>>  TEST_GEN_FILES += ksm_tests
>>  
>>  ifeq ($(MACHINE),x86_64)
>> @@ -91,6 +91,9 @@ TEST_FILES := test_vmalloc.sh
>>  KSFT_KHDR_INSTALL := 1
>>  include ../lib.mk
>>  
>> +$(OUTPUT)/madv_populate: vm_util.c
>> +$(OUTPUT)/split_huge_page_test: vm_util.c
> Not sure what this does but if we add a run entry for split_huge_page_test in
> run_vmselftests.sh we wont really need this patch.
> 
> I'm not sure the reduction in code size is worth the change in run behavior.
> 
> Unless I'm missing something I suggest we revert this patch and add a run entry
> for split_huge_page_test in run_vmselftests.sh. I can do this if no one objects.
The run behavior isn't being changed here. Only the build behavior is
being changed as we want to keep the common code in one file. You can
add the run entry as required. I don't know why do you think the
Makefile has changed the run behavior.

> 
> Cheers,
> -- Nico
> 

-- 
Muhammad Usama Anjum
