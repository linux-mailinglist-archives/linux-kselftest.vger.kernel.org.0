Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 940CC7B5486
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Oct 2023 16:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237627AbjJBNzM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Oct 2023 09:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237599AbjJBNzD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Oct 2023 09:55:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5CEB7
        for <linux-kselftest@vger.kernel.org>; Mon,  2 Oct 2023 06:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696254901; x=1727790901;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zf1ypYA2/B3jiWQg3zRbkZu6eFxK/XkUzWvidHo5sM8=;
  b=nRac3VxYzd9FouK4MIC4RkFCRK81RGRJrtm2i8V+FbMnHfUPx+wte+um
   WR1qelVxNehgrKq5PtLOyahN/w0/mA8HxSJ+2cBzjPDgzfHE/U+Io8KsX
   aUAxOLEjjPTjuHHzopI8e8qTtfguX6RU5NzLTV66khr2wbrGrdF16AJAL
   w19YwPHxMMJXoXFrVGCZPAaRxx7pp4nP6a4CAWzQfhRmT87yjY/kryLOt
   KbP5oTuq7TQwJ4DRs1LYwxjZuYxy4ibLxvbSeqftb+llipY81o0ljP4i3
   IxqnplQCBU4QBFVyldGcUNDLQCmxXDLTmC+wLSt2VMsjUYF+SAX6CHNQ0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="386517270"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="386517270"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 06:55:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="754053919"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="754053919"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmsmga007.fm.intel.com with ESMTP; 02 Oct 2023 06:54:58 -0700
Received: from [10.249.132.112] (mwajdecz-MOBL.ger.corp.intel.com [10.249.132.112])
        by irvmail002.ir.intel.com (Postfix) with ESMTP id CC79E43C23;
        Mon,  2 Oct 2023 14:54:50 +0100 (IST)
Message-ID: <80c0f713-662a-9cdb-e430-88c854ab2192@intel.com>
Date:   Mon, 2 Oct 2023 15:54:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH 4/4] kunit: Prepare test plan for parameterized subtests
Content-Language: en-US
To:     Rae Moar <rmoar@google.com>
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        David Gow <davidgow@google.com>
References: <20230925175733.1379-1-michal.wajdeczko@intel.com>
 <20230925175733.1379-5-michal.wajdeczko@intel.com>
 <CA+GJov4o9ixrbSma-9SABH4n88AXFD=nDG6+C=wfVVMgzLoprA@mail.gmail.com>
From:   Michal Wajdeczko <michal.wajdeczko@intel.com>
In-Reply-To: <CA+GJov4o9ixrbSma-9SABH4n88AXFD=nDG6+C=wfVVMgzLoprA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 28.09.2023 22:54, Rae Moar wrote:
> On Mon, Sep 25, 2023 at 1:58 PM Michal Wajdeczko
> <michal.wajdeczko@intel.com> wrote:
>>
>> In case of parameterized tests we are not providing a test plan
>> so we can't detect if any result is missing.
>>
>> Count available params using the same generator as during a test
>> execution
>>
>> Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
>> Cc: David Gow <davidgow@google.com>
>> Cc: Rae Moar <rmoar@google.com>
>> ---
>>  lib/kunit/test.c | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>
>> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
>> index 43c3efc286e4..55eabb324f39 100644
>> --- a/lib/kunit/test.c
>> +++ b/lib/kunit/test.c
>> @@ -540,6 +540,20 @@ static void kunit_accumulate_stats(struct kunit_result_stats *total,
>>         total->total += add.total;
>>  }
>>
>> +static size_t count_test_case_params(struct kunit_case *test_case)
>> +{
>> +       char param_desc[KUNIT_PARAM_DESC_SIZE];
>> +       const void *param_value = NULL;
>> +       size_t num = 0;
>> +
>> +       if (test_case->generate_params)
>> +               while ((param_value = test_case->generate_params(param_value,
>> +                                                                param_desc)))
>> +                       num++;
>> +
>> +       return num;
>> +}
>> +
> 
> Hello!
> 
> This change largely looks good to me. However, I am not 100 percent
> confident that the function to generate parameters always produces the
> same output (or same number of test cases). I would be interested in
> David's opinion on this.

Right, it's not explicitly specified in KUNIT_CASE_PARAM nor
test_case.generate_params documentation, but I would assume that while
generating different output could be fine (and harmless to this patch),
like based on a random seed, but IMO at the same time it should be
prohibited to generate different number of params, as this would make
harder to compare each execution for regression.

Alternatively we can introduce some flag to indicate whether provided
param generator is stable or not and then provide test plan only for the
former.

Michal

> 
> Otherwise it seems to work well!
> 
> Thanks!
> -Rae
> 
>>  int kunit_run_tests(struct kunit_suite *suite)
>>  {
>>         char param_desc[KUNIT_PARAM_DESC_SIZE];
>> @@ -585,6 +599,8 @@ int kunit_run_tests(struct kunit_suite *suite)
>>                         test_case->status = KUNIT_SKIPPED;
>>                         kunit_log_indent(KERN_INFO, &test, "KTAP version 1\n");
>>                         kunit_log_indent(KERN_INFO, &test, "# Subtest: %s", test_case->name);
>> +                       kunit_log_indent(KERN_INFO, &test, "1..%zd\n",
>> +                                        count_test_case_params(test_case));
>>
>>                         while (test.param_value) {
>>                                 kunit_run_case_catch_errors(suite, test_case, &test);
>> --
>> 2.25.1
>>
