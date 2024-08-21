Return-Path: <linux-kselftest+bounces-15932-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 743EB95A77A
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 00:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BAEC2814B9
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 22:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E829414E2E9;
	Wed, 21 Aug 2024 22:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ggTsYesS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C262B9AF
	for <linux-kselftest@vger.kernel.org>; Wed, 21 Aug 2024 22:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724277625; cv=none; b=gTrCPfj0kvp9IaezKCl0M97Vw2SSXldGV+SpmUHmX8B346uM+VhLxbCGuv2B/aJ8H4TezY0zYgD6nsjCOGj+rMzauptnaH8Qo/bJZDj5gTeGqKFgQQERfkCAnQcZPwTHiDwviuADb9wBCetdaIp2QrwwdVK8djczURhyEl97ASA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724277625; c=relaxed/simple;
	bh=KddeyswZeIDj2bDxqA5z521UXmcCk/dVgRcMZDrH9NA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nqj/8Ql5Hb1RKh7q6M0zmCCc9jw0n1+1Fh+fhc8P8wxCMQ9+9V4r0nmcEoWhjHx4quNjX6D8XNkuOB7oNQMD5iHQmKjUnG1ncRVQzYiMkPRAlNieI4AvlrK7ZIY0FwJaxL0wNC0zKpOGNBRvImXX9nljjTqlpQCkyzi5U5mkATo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ggTsYesS; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724277624; x=1755813624;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KddeyswZeIDj2bDxqA5z521UXmcCk/dVgRcMZDrH9NA=;
  b=ggTsYesSrtNPRMBujPoRDZs84jyCrYCk7s46QrFvqCyXNGwkiOMvZnZt
   sQJdP6+d4dVzlUmndFhCOBiiOfCAI7HvC2CSV/CddlFZuKzRsqEXzJ9Cx
   dKGPz7N3wVsQ1qg2Qd6tFRe73u4/Kai5SC17vzXzsSGKPl95YYPwxmLW+
   VWsrahBHp1SQq5t+G2ZiWfOhJcV2Zer9KiDImwZBXrNY3mKihpx4XR0j5
   PYQ9sfVq/7A76KyhpZw7Y7XAxCbf3MuRUR058mPy/iX6k92b+rVaruU+3
   vp24ljESvwfNzj84eSgtRYYqBVIyQo1XpW/UnWd20tepNXC+MzhoWXlWT
   A==;
X-CSE-ConnectionGUID: AWc+ISb6TH+Qlhl7HrUnKg==
X-CSE-MsgGUID: cMbEVvVVT12Tch80JfXl4A==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="22817743"
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="22817743"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 15:00:24 -0700
X-CSE-ConnectionGUID: Yv4VA+NsTWm6dj7HrVmt/A==
X-CSE-MsgGUID: 23pJ5Q+uSNWWUJDNrb9X+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="61088079"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa010.jf.intel.com with ESMTP; 21 Aug 2024 15:00:21 -0700
Received: from [10.246.19.248] (mwajdecz-MOBL.ger.corp.intel.com [10.246.19.248])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 3BD2432C80;
	Wed, 21 Aug 2024 23:00:19 +0100 (IST)
Message-ID: <94774c66-fa6e-4e07-87c1-baed1c2caae9@intel.com>
Date: Thu, 22 Aug 2024 00:00:18 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] kunit: Add example with alternate function
 redirection method
To: Rae Moar <rmoar@google.com>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 David Gow <davidgow@google.com>, Daniel Latypov <dlatypov@google.com>,
 Lucas De Marchi <lucas.demarchi@intel.com>
References: <20240821144305.1958-1-michal.wajdeczko@intel.com>
 <20240821144305.1958-5-michal.wajdeczko@intel.com>
 <CA+GJov7ezEK1qmVJ0xteYxfHMmTp+p2sciBvRc4noLDmV2GDXQ@mail.gmail.com>
Content-Language: en-US
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
In-Reply-To: <CA+GJov7ezEK1qmVJ0xteYxfHMmTp+p2sciBvRc4noLDmV2GDXQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 21.08.2024 23:22, Rae Moar wrote:
> On Wed, Aug 21, 2024 at 10:43 AM Michal Wajdeczko
> <michal.wajdeczko@intel.com> wrote:
>>
>> Add example how to use KUNIT_FIXED_STUB_REDIRECT and compare its
>> usage with the KUNIT_STATIC_STUB_REDIRECT. Also show how the
>> DECLARE_IF_KUNIT macro could be helpful in declaring test data in
>> the non-test data structures.
>>
>> Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
> 
> Hello!
> 
> I really like this test. It provides a great overview of this patch
> series. I just have a couple comments below.
> 
> Otherwise,
> Reviewed-by: Rae Moar <rmoar@google.com>
> 
> Thanks!
> -Rae
> 
>> ---
>> Cc: David Gow <davidgow@google.com>
>> Cc: Daniel Latypov <dlatypov@google.com>
>> Cc: Lucas De Marchi <lucas.demarchi@intel.com>
>> ---
>>  lib/kunit/kunit-example-test.c | 63 ++++++++++++++++++++++++++++++++++
>>  1 file changed, 63 insertions(+)
>>
>> diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-test.c
>> index 3056d6bc705d..120e08d8899b 100644
>> --- a/lib/kunit/kunit-example-test.c
>> +++ b/lib/kunit/kunit-example-test.c
>> @@ -6,8 +6,10 @@
>>   * Author: Brendan Higgins <brendanhiggins@google.com>
>>   */
>>
>> +#include <linux/workqueue.h>
>>  #include <kunit/test.h>
>>  #include <kunit/static_stub.h>
>> +#include <kunit/visibility.h>
>>
>>  /*
>>   * This is the most fundamental element of KUnit, the test case. A test case
>> @@ -221,6 +223,66 @@ static void example_static_stub_using_fn_ptr_test(struct kunit *test)
>>         KUNIT_EXPECT_EQ(test, add_one(1), 2);
>>  }
>>
>> +/* This could be a location of various fixed stub functions. */
>> +static struct {
>> +       DECLARE_IF_KUNIT(int (*add_two)(int i));
> 
> Is the use of DECLARE_IF_KUNIT useful here? KUnit should always be
> enabled if this file is being compiled/run. Is the idea to show an
> example here that could be used outside of kunit test files?

yes, the idea was to show that 'stubs' declarations could be placed
anywhere, without any cost if compiled without KUNIT (I was trying to
mention that in commit message)

> 
> Additionally, would it make sense to call this add_two_stub instead to
> make it clear that this is not a definition of the add_two function?
> Or is it helpful for people to see this as an example of how to handle
> multiple stubs: struct of stubs with exact names? Let me know what you
> think.

the 'add_two' above is just a member name, and IMO we shouldn't repeat
that this is about 'stub' since the whole struct is for 'stubs'

and yes, the idea was also to show that if applicable, other function
stubs declarations could be either placed together

> 
>> +} stubs;
>> +
>> +/* This is a function we'll replace with stubs. */
>> +static int add_two(int i)
>> +{
>> +       /* This will trigger the stub if active. */
>> +       KUNIT_STATIC_STUB_REDIRECT(add_two, i);
>> +       KUNIT_FIXED_STUB_REDIRECT(stubs.add_two, i);
>> +
>> +       return i + 2;
>> +}
>> +
>> +struct add_two_async_work {
>> +       struct work_struct work;
>> +       int param;
>> +       int result;
>> +};
>> +
>> +static void add_two_async_func(struct work_struct *work)
>> +{
>> +       struct add_two_async_work *w = container_of(work, typeof(*w), work);
>> +
>> +       w->result = add_two(w->param);
>> +}
>> +
>> +static int add_two_async(int i)
>> +{
>> +       struct add_two_async_work w = { .param = i };
>> +
>> +       INIT_WORK_ONSTACK(&w.work, add_two_async_func);
>> +       schedule_work(&w.work);
>> +       flush_work(&w.work);
>> +       destroy_work_on_stack(&w.work);
>> +
>> +       return w.result;
>> +}
>> +
>> +/*
>> + */
> 
> It looks like the method description is missing here.
> 

ha, I missed to copy commit message here

> 
> 
> 
>> +static void example_fixed_stub_test(struct kunit *test)
>> +{
>> +       /* static stub redirection works only for KUnit thread */
>> +       kunit_activate_static_stub(test, add_two, subtract_one);
>> +       KUNIT_EXPECT_EQ(test, add_two(1), subtract_one(1));
>> +       KUNIT_EXPECT_NE_MSG(test, add_two_async(1), subtract_one(1),
>> +                           "stub shouldn't be active outside KUnit thread!");
>> +       kunit_deactivate_static_stub(test, add_two);
>> +       KUNIT_EXPECT_EQ(test, add_two(1), add_two(1));
>> +
>> +       /* fixed stub redirection works for KUnit and other threads */
>> +       kunit_activate_fixed_stub(test, stubs.add_two, subtract_one);
>> +       KUNIT_EXPECT_EQ(test, add_two(1), subtract_one(1));
>> +       KUNIT_EXPECT_EQ(test, add_two_async(1), subtract_one(1));
>> +       kunit_deactivate_fixed_stub(test, stubs.add_two);
>> +       KUNIT_EXPECT_EQ(test, add_two(1), add_two(1));
>> +}
>> +
>>  static const struct example_param {
>>         int value;
>>  } example_params_array[] = {
>> @@ -294,6 +356,7 @@ static struct kunit_case example_test_cases[] = {
>>         KUNIT_CASE(example_all_expect_macros_test),
>>         KUNIT_CASE(example_static_stub_test),
>>         KUNIT_CASE(example_static_stub_using_fn_ptr_test),
>> +       KUNIT_CASE(example_fixed_stub_test),
>>         KUNIT_CASE(example_priv_test),
>>         KUNIT_CASE_PARAM(example_params_test, example_gen_params),
>>         KUNIT_CASE_SLOW(example_slow_test),
>> --
>> 2.43.0
>>
>> --
>> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
>> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
>> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20240821144305.1958-5-michal.wajdeczko%40intel.com.

