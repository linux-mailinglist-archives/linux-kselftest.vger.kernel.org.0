Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D15B7B5871
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Oct 2023 18:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238453AbjJBQTs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Oct 2023 12:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238505AbjJBQTn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Oct 2023 12:19:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401771B8
        for <linux-kselftest@vger.kernel.org>; Mon,  2 Oct 2023 09:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696263571; x=1727799571;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ygurDVhGKv+TzjXIv5LAIV75jB0n75sru77K8KD4nPU=;
  b=MJ56BM3ixHoDusQ3TUmQFq29dWYrpU00c4aiU8e+N3TWq9gkaLjoU8C5
   cWSuKjMAjBzABdJf+r0thGaJgADLOb2pkNwgtNYnZqtN9R2uZJIiNpzSm
   TRUaA8gSRfT+yQ+p259mzqmh5QGwoIPa4EzedK0OG4FNo/oLyv/K3I1JL
   pIu5CJ6sbTPP1hsauqSjXkODl2fyhV+N9vJ+rWSrXFqNMb3UMLI/rxKTn
   HS2LFxG6oN1uWPl7eWrLFl7Rjap02ZJDptnRmCDdBSyLl3xVxNFOUSI4i
   Zx17NF9tBBiN3cOrflPFrAe/hG11+093ZBjaXbB48QY+dKG/RP1Q+Qwot
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="362949995"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="362949995"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 09:17:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="816340379"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="816340379"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmsmga008.fm.intel.com with ESMTP; 02 Oct 2023 09:17:34 -0700
Received: from [10.249.132.112] (mwajdecz-MOBL.ger.corp.intel.com [10.249.132.112])
        by irvmail002.ir.intel.com (Postfix) with ESMTP id 6F7C843C23;
        Mon,  2 Oct 2023 17:17:33 +0100 (IST)
Message-ID: <2430f74e-12ee-9c54-722a-ddfabcfe0f84@intel.com>
Date:   Mon, 2 Oct 2023 18:17:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH 1/2] kunit: Add param generator macro for zero terminated
 arrays
Content-Language: en-US
To:     David Gow <davidgow@google.com>
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Rae Moar <rmoar@google.com>
References: <20230926220208.1423-1-michal.wajdeczko@intel.com>
 <CABVgOSkYSCDeNDqkvFR9nsBc+DeWkHZ1rrq4X6=B2ZZGZdN86w@mail.gmail.com>
From:   Michal Wajdeczko <michal.wajdeczko@intel.com>
In-Reply-To: <CABVgOSkYSCDeNDqkvFR9nsBc+DeWkHZ1rrq4X6=B2ZZGZdN86w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 30.09.2023 10:58, David Gow wrote:
> On Wed, 27 Sept 2023 at 06:02, Michal Wajdeczko
> <michal.wajdeczko@intel.com> wrote:
>>
>> The existing macro KUNIT_ARRAY_PARAM can produce parameter
>> generator function but only when we fully know the definition
>> of the array. However, there might be cases where we would like
>> to generate test params based on externaly defined array, which
>> is defined as zero-terminated array, like pci_driver.id_table.
> 
> Hmm... I like the idea of this, but am a little wary of dealing with
> zero-terminated arrays in a generic fashion. Some cases (pointers,
> where we can just != NULL) are obvious,
> but we could hit inconsistencies with things like padding, as things
> like pci_driver.id_table seem to mostly be iterated over with things
> like:
> while (ids->vendor || ids->subvendor || ids->class_mask)
> 
> which not only ignores the padding, but also half of the fields. So
> there may be a consistency issue there.
> 
> Though I suspect it's not likely to cause issues in practice.
> 
> Thoughts?
> -- David
>>
>> Add helper macro KUNIT_ZERO_ARRAY_PARAM that can work with zero
>> terminated arrays and provide example how to use it.
>>
>> $ ./tools/testing/kunit/kunit.py run \
>>         --kunitconfig ./lib/kunit/.kunitconfig *.example_params*
>>
>> [ ] Starting KUnit Kernel (1/1)...
>> [ ] ============================================================
>> [ ] ========================= example  =========================
>> [ ] =================== example_params_test  ===================
>> [ ] [SKIPPED] example value 3
>> [ ] [PASSED] example value 2
>> [ ] [PASSED] example value 1
>> [ ] [SKIPPED] example value 0
>> [ ] =============== [PASSED] example_params_test ===============
>> [ ] =================== example_params_test  ===================
>> [ ] [SKIPPED] example value 3
>> [ ] [PASSED] example value 2
>> [ ] [PASSED] example value 1
>> [ ] =============== [PASSED] example_params_test ===============
>> [ ] ===================== [PASSED] example =====================
>> [ ] ============================================================
>> [ ] Testing complete. Ran 7 tests: passed: 4, skipped: 3
>>
>> Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
>> Cc: David Gow <davidgow@google.com>
>> Cc: Rae Moar <rmoar@google.com>
>> ---
>>  include/kunit/test.h           | 22 ++++++++++++++++++++++
>>  lib/kunit/kunit-example-test.c |  2 ++
>>  2 files changed, 24 insertions(+)
>>
>> diff --git a/include/kunit/test.h b/include/kunit/test.h
>> index 20ed9f9275c9..280113ceb6a6 100644
>> --- a/include/kunit/test.h
>> +++ b/include/kunit/test.h
>> @@ -1514,6 +1514,28 @@ do {                                                                            \
>>                 return NULL;                                                                    \
>>         }
>>
>> +/**
>> + * KUNIT_ZERO_ARRAY_PARAM() - Define test parameter generator from a zero terminated array.
>> + * @name:  prefix for the test parameter generator function.
>> + * @array: zero terminated array of test parameters.
>> + * @get_desc: function to convert param to description; NULL to use default
>> + *
>> + * Define function @name_gen_params which uses zero terminated @array to generate parameters.
>> + */
>> +#define KUNIT_ZERO_ARRAY_PARAM(name, array, get_desc)                                          \
>> +       static const void *name##_gen_params(const void *prev, char *desc)                      \
>> +       {                                                                                       \
>> +               typeof((array)[0]) *__prev = prev;                                              \
>> +               typeof(__prev) __next = __prev ? __prev + 1 : (array);                          \
>> +               void (*__get_desc)(typeof(__next), char *) = get_desc;                          \
>> +               for (; memchr_inv(__next, 0, sizeof(*__next)); __prev = __next++) {             \
> 
> Are there any places where this might interact awkwardly with padding?
> I _think_ it should be okay (variables with static lifetimes should
> have padding initialised to zero), but there could be a case I'm
> missing.

It looks that most of the existing code is relying on empty
initialization with = { 0 } or = { }, the latter known to be zero
initialized, including padding, in C23, so if we want to be pedantic we
may allow to provide a pointer to a table specific "is_end()" function,
that will detect end of the parameters array, which we could still
default to memchr_inv if custom solution is not needed:

#define KUNIT_ZERO_ARRAY_PARAM(name, array, get_desc, is_end)	\
...
	bool (*__is_end)(typeof(__next)) = is_end;		\
	for (; __is_end ? __is_end(__next) : 			\
	     !!memchr_inv(__next, 0, sizeof(*__next));		\
	     __prev = __next++) {       			\


KUNIT_ZERO_ARRAY_PARAM(example_zero, example_params_array,
			example_param_get_desc, NULL);
or

static bool example_param_valid(const struct example_param *next)
{
	return next->value;
}

KUNIT_ZERO_ARRAY_PARAM(example_zero, example_params_array,
			example_param_get_desc, example_param_valid);

then we shouldn't miss any case

Michal

> 
> 
>> +                       if (__get_desc)                                                         \
>> +                               __get_desc(__next, desc);                                       \
>> +                       return __next;                                                          \
>> +               }                                                                               \
>> +               return NULL;                                                                    \
>> +       }
>> +
>>  // TODO(dlatypov@google.com): consider eventually migrating users to explicitly
>>  // include resource.h themselves if they need it.
>>  #include <kunit/resource.h>
>> diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-test.c
>> index 6bb5c2ef6696..ad9ebcfd513e 100644
>> --- a/lib/kunit/kunit-example-test.c
>> +++ b/lib/kunit/kunit-example-test.c
>> @@ -202,6 +202,7 @@ static void example_param_get_desc(const struct example_param *p, char *desc)
>>  }
>>
>>  KUNIT_ARRAY_PARAM(example, example_params_array, example_param_get_desc);
>> +KUNIT_ZERO_ARRAY_PARAM(example_zero, example_params_array, example_param_get_desc);
>>
>>  /*
>>   * This test shows the use of params.
>> @@ -246,6 +247,7 @@ static struct kunit_case example_test_cases[] = {
>>         KUNIT_CASE(example_all_expect_macros_test),
>>         KUNIT_CASE(example_static_stub_test),
>>         KUNIT_CASE_PARAM(example_params_test, example_gen_params),
>> +       KUNIT_CASE_PARAM(example_params_test, example_zero_gen_params),
>>         KUNIT_CASE_SLOW(example_slow_test),
>>         {}
>>  };
>> --
>> 2.25.1
>>
