Return-Path: <linux-kselftest+bounces-16385-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE769607E6
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 12:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72B6DB209A3
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 10:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40CC19D06D;
	Tue, 27 Aug 2024 10:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hY2bR4nj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DD019753F
	for <linux-kselftest@vger.kernel.org>; Tue, 27 Aug 2024 10:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724756009; cv=none; b=tmPpH5Apx2qEpeluvJazer6GyKVPFtdT5c2MjGs0S5AdBonTX5ez2sq3wX1I429TcJA2/r8lMQZYC3B50XMLfWDORz4Foq+U64rPwMdzxSVoF/Y4C75Ht8cRb8SGAvqQ4rROhfrfF10FZZdoizlrHRqEFZOy8JprerI7hffBU04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724756009; c=relaxed/simple;
	bh=qdQiJsLGkazxhW14WX2w2lredPG3vsKaKqst+HCfNtI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qUwcmwfp6VlqS9vaOkZX1hi9KbXJuQeI97abKeYGh8VSpGSX/FG28kpBRIK6KDtPQno8IBpdu0jFBM+2vFnQhYixUtE6gihjornBwF1CzGN8pjjjactCf8/vGq+74SuXayX+GmlPN+b3N7i8MXV5qLH02fRCQVhRjeElThC6wRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hY2bR4nj; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724756008; x=1756292008;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qdQiJsLGkazxhW14WX2w2lredPG3vsKaKqst+HCfNtI=;
  b=hY2bR4njvy942eC/h7A6in3mXBw+3uqU1KoP2o7r12ebk5DfXXnZHyia
   DjZokXPKhLe2wtoA0hojx6VxE5iMl/AGo7CmuWKlJenrDaKD2eRkY75qj
   l0n597NDps/6V407HClWFOrWJy9c41UZgjzv3thlfS5O/MOaCaswiMcEQ
   CAvQOS8MIqeGZf2PMtRR9iygtSq19rnijVhelc9QGpPmN6XCL/c7yK0jW
   bhzcR2kbluFBpP6bQx3wqtaRvVdvvPeBonKgKxupBlyC0BJPsSS6lFDMk
   AI2wKiN/ZnJgc/eTwf8QXfqVqbyjZnI3WvC05TTkns/jq2tdA/eVJ3LUQ
   g==;
X-CSE-ConnectionGUID: i99O8h24RHiwPiR1Fp5g0w==
X-CSE-MsgGUID: QwwFdxnYRfqiz2m6L+2vIg==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="23192709"
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="23192709"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 03:53:25 -0700
X-CSE-ConnectionGUID: oVuqu9w/RVGbECaxFA6tvg==
X-CSE-MsgGUID: 2Bfd8x1mRWimC+9Ob6qmmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="62812164"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa008.fm.intel.com with ESMTP; 27 Aug 2024 03:53:22 -0700
Received: from [10.246.1.253] (mwajdecz-MOBL.ger.corp.intel.com [10.246.1.253])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 8DDE627BC5;
	Tue, 27 Aug 2024 11:53:20 +0100 (IST)
Message-ID: <1e78c60f-485a-4d6a-adf1-8a7a0b4509db@intel.com>
Date: Tue, 27 Aug 2024 12:53:20 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] kunit: Allow function redirection outside of the
 KUnit thread
To: David Gow <davidgow@google.com>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 Daniel Latypov <dlatypov@google.com>,
 Lucas De Marchi <lucas.demarchi@intel.com>
References: <20240821144305.1958-1-michal.wajdeczko@intel.com>
 <20240821144305.1958-4-michal.wajdeczko@intel.com>
 <CABVgOSkdCh9qXYRyJ1mMBzj_-e5_p-8HM8C7XtcJyhnmcibq=w@mail.gmail.com>
Content-Language: en-US
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
In-Reply-To: <CABVgOSkdCh9qXYRyJ1mMBzj_-e5_p-8HM8C7XtcJyhnmcibq=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 22.08.2024 08:14, David Gow wrote:
> On Wed, 21 Aug 2024 at 22:43, Michal Wajdeczko
> <michal.wajdeczko@intel.com> wrote:
>>
>> Currently, the 'static stub' API only allows function redirection
>> for calls made from the kthread of the current test, which prevents
>> the use of this functionalty when the tested code is also used by
>> other threads, outside of the KUnit test, like from the workqueue.
>>
>> Add another set of macros to allow redirection to the replacement
>> functions, which, unlike the KUNIT_STATIC_STUB_REDIRECT, will
>> affect all calls done during the test execution.
>>
>> Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
>> ---
>> Cc: David Gow <davidgow@google.com>
>> Cc: Daniel Latypov <dlatypov@google.com>
>> Cc: Lucas De Marchi <lucas.demarchi@intel.com>
>> ---
> 
> Thanks for sending this in: we really do need a way to use stubs from
> other threads.
> 
> In general, I think there are two possible ways of implementing that:
> - Make a version of the stubs which don't need a KUnit context (i.e.,
> this patch), or
> - Have a way of extending the KUnit context to other threads.
> 
> Personally, I'd prefer the latter if it were feasible, as it is both
> cleaner from a user point of view (we don't need two variants of the
> same thing), and extends more easily to features beyond stubs.
> However, there are a few downsides:
> - We'd need to find a way of handling the case where the test function
> returns while there's still a background thread happening.
> - In general, KUnit would need to be audited for thread safety for
> those macros (I don't think it's too bad, but worth checking),
> - We'd need a way of passing the KUnit context to the new thread,
> which might be difficult to make pleasant.
> - We'd need to handle cases where a thread is only partly running test
> code, or otherwise doesn't create its threads directly (e.g.,
> workqueues, rcu, etc)
> - What should happen if an assertion fails on another thread — does
> the failing thread quit, does the original thread quit, both?
> 
> In short, it's a complicated enough situation that I doubt we'd solve
> all of those problems cleanly or quickly, so this patch is probably
> the better option. Regardless, we need a story for what the thread
> safety of this is -- can you activate/deactivate stubs while the
> stubbed function is being called. (My gut feeling is "this should be
> possible, but is probably ill-advised" is what we should aim for,
> which probably requires making sure the stub update is done
> atomically.

v2 is trying to wait until all active calls finishes before changing or
deactivating this particular stub, I've also added simple test for it:

KTAP version 1
1..1
    KTAP version 1
    # Subtest: kunit_global_stub
    # module: kunit_test
    1..2
    # kunit_global_stub_test_slow_deactivate: real_func: redirecting to
slow_replacement_func
    # kunit_global_stub_test_slow_deactivate: real_func: redirecting to
slow_replacement_func
    # kunit_global_stub_test_slow_deactivate: waiting for
slow_replacement_func
    # kunit_global_stub_test_slow_deactivate.speed: slow
    ok 1 kunit_global_stub_test_slow_deactivate
    # kunit_global_stub_test_slow_replace: real_func: redirecting to
slow_replacement_func
    # kunit_global_stub_test_slow_replace: real_func: redirecting to
slow_replacement_func
    # kunit_global_stub_test_slow_replace: waiting for slow_replacement_func
    # kunit_global_stub_test_slow_replace: real_func: redirecting to
other_replacement_func
    # kunit_global_stub_test_slow_replace.speed: slow
    ok 2 kunit_global_stub_test_slow_replace
# kunit_global_stub: pass:2 fail:0 skip:0 total:2
# Totals: pass:2 fail:0 skip:0 total:2


> 
> More rambling below, but I think this is probably good once the
> atomic/thread-safety stuff is either sorted out or at least
> documented. As for the name, how about KUNIT_GLOBAL_STUB_REDIRECT()?
> I'm okay with FIXED_STUB if you prefer it, though.

renamed to KUNIT_GLOBAL_STUB_REDIRECT

> 
> Cheers,
> -- David
> 
>>  include/kunit/static_stub.h | 80 +++++++++++++++++++++++++++++++++++++
>>  lib/kunit/static_stub.c     | 21 ++++++++++
>>  2 files changed, 101 insertions(+)
>>
>> diff --git a/include/kunit/static_stub.h b/include/kunit/static_stub.h
>> index bf940322dfc0..3dd98c8f3f1f 100644
>> --- a/include/kunit/static_stub.h
>> +++ b/include/kunit/static_stub.h
>> @@ -12,6 +12,7 @@
>>
>>  /* If CONFIG_KUNIT is not enabled, these stubs quietly disappear. */
>>  #define KUNIT_STATIC_STUB_REDIRECT(real_fn_name, args...) do {} while (0)
>> +#define KUNIT_FIXED_STUB_REDIRECT(stub, args...) do {} while (0)
>>
>>  #else
>>
>> @@ -109,5 +110,84 @@ void __kunit_activate_static_stub(struct kunit *test,
>>   */
>>  void kunit_deactivate_static_stub(struct kunit *test, void *real_fn_addr);
>>
>> +/**
>> + * KUNIT_FIXED_STUB_REDIRECT() - Call a fixed function stub if activated.
>> + * @stub: The location of the function stub pointer
>> + * @args: All of the arguments passed to this stub
>> + *
>> + * This is a function prologue which is used to allow calls to the current
>> + * function to be redirected if a KUnit is running. If the stub is NULL or
>> + * the KUnit is not running the function will continue execution as normal.
>> + *
>> + * The function stub pointer must be stored in a place that is accessible both
>> + * from the test code that will activate this stub and from the function where
>> + * we will do the redirection.
>> + *
>> + * Unlike the KUNIT_STATIC_STUB_REDIRECT(), this redirection will work
>> + * even if the caller is not in a KUnit context (like a worker thread).
>> + *
>> + * Example:
>> + *
>> + * .. code-block:: c
>> + *
>> + *     static int (*func_stub)(int n);
>> + *
>> + *     int real_func(int n)
>> + *     {
>> + *             KUNIT_FIXED_STUB_REDIRECT(func_stub, n);
>> + *             return n + 1;
>> + *     }
>> + *
>> + *     int replacement_func(int n)
>> + *     {
>> + *             return n + 100;
>> + *     }
>> + *
>> + *     void example_test(struct kunit *test)
>> + *     {
>> + *             KUNIT_EXPECT_EQ(test, real_func(1), 2);
>> + *             func_stub = replacement_func;
>> + *             KUNIT_EXPECT_EQ(test, real_func(1), 101);
>> + *     }
>> + */
>> +#define KUNIT_FIXED_STUB_REDIRECT(stub, args...) do {                                  \
>> +       typeof(stub) replacement = (stub);                                              \
>> +       if (kunit_is_running()) {                                                       \
>> +               if (unlikely(replacement)) {                                            \
>> +                       pr_info(KUNIT_SUBTEST_INDENT "# %s: calling stub %ps\n",        \
> 
> I suspect we want to at least make the logging here optional,
> particularly since it doesn't go into the test log.

as in v2 there is a dedicated struct/union to hold the address and the
type of the replacement function, I've also added there a kunit* so is
now everything is logged to the test log

> 
>> +                               __func__, replacement);                                 \
>> +                       return replacement(args);                                       \
>> +               }                                                                       \
>> +       }                                                                               \
>> +} while (0)
>> +
>> +void __kunit_activate_fixed_stub(struct kunit *test, void *stub_ptr, void *replacement_func);
>> +
>> +/**
>> + * kunit_activate_fixed_stub() - Setup a fixed function stub.
>> + * @test: Test case that wants to activate a fixed function stub
>> + * @stub: The location of the function stub pointer
>> + * @replacement: The replacement function
>> + *
>> + * This helper setups a function stub with the replacement function.
>> + * It will also automatically restore stub to NULL at the test end.
>> + */
>> +#define kunit_activate_fixed_stub(test, stub, replacement) do {                                \
> 
> Do we want to actually hook this into the struct kunit here? I suspect

yes, as we want automatic deactivation of the stub to avoid leaving
active stub after the test ends (may be important if using KUnit for
some live testing, like we do in Xe)

> we do, but it does mean that this has to either be called from the
> main thread, or the struct kunit* needs to be passed around.

we usually enable/activate stubs from the test case code, where kunit*
is already there, so this just enforces that redirection could be
controlled only from the main KUnit thread

> 
>> +       typecheck_pointer(stub);                                                        \
>> +       typecheck_fn(typeof(stub), replacement);                                        \
>> +       typeof(stub) *stub_ptr = &(stub);                                               \
>> +       __kunit_activate_fixed_stub((test), stub_ptr, (replacement));                   \
>> +} while (0)
>> +
>> +/**
>> + * kunit_deactivate_fixed_stub() - Disable a fixed function stub.
>> + * @test: Test case that wants to deactivate a fixed function stub (unused for now)
>> + * @stub: The location of the function stub pointer
>> + */
>> +#define kunit_deactivate_fixed_stub(test, stub) do {                                   \
>> +       typecheck(struct kunit *, (test));                                              \
>> +       (stub) = NULL;                                                                  \
>> +} while (0)
>> +
>>  #endif
>>  #endif
>> diff --git a/lib/kunit/static_stub.c b/lib/kunit/static_stub.c
>> index 92b2cccd5e76..1b50cf457e89 100644
>> --- a/lib/kunit/static_stub.c
>> +++ b/lib/kunit/static_stub.c
>> @@ -121,3 +121,24 @@ void __kunit_activate_static_stub(struct kunit *test,
>>         }
>>  }
>>  EXPORT_SYMBOL_GPL(__kunit_activate_static_stub);
>> +
>> +static void nullify_stub_ptr(void *data)
>> +{
>> +       void **ptr = data;
>> +
>> +       *ptr = NULL;
> 
> As below, does this need to be atomic?
> 
>> +}
>> +
>> +/*
>> + * Helper function for kunit_activate_static_stub(). The macro does
>> + * typechecking, so use it instead.
>> + */
>> +void __kunit_activate_fixed_stub(struct kunit *test, void *stub_ptr, void *replacement_func)
>> +{
>> +       void **stub = stub_ptr;
>> +
>> +       KUNIT_ASSERT_NOT_NULL(test, stub_ptr);
>> +       *stub = replacement_func;
> 
> Do we need to do something here to make this atomic? At the very
> least, I think we want to READ_ONCE()/WRITE_ONCE() these, but even
> then we could end up with torn writes, I think.

v2 is using READ_ONCE()/WRITE_ONCE() to update stub pointers and
atomic_t to track whether stub is disabled(0) or activated(1) or in_use(2+)

> 
> In general, though, what's the rule around activating a stub from a
> different thread to it being called?  I thinki we definitely want to
> allow it, but _maybe_ we can get away with saying that the stub can't
> be activated/deactivated concurrently with being used?
> 
>> +       KUNIT_ASSERT_EQ(test, 0, kunit_add_action_or_reset(test, nullify_stub_ptr, stub_ptr));
> 
> Again, we probably need to emphasise that any work done on another
> thread needs to be complete before the test ends on the main thread.
> This isn't specific to this feature, though.

v2 is trying to care of it and waits until any active calls finish

> 
>> +}
>> +EXPORT_SYMBOL_GPL(__kunit_activate_fixed_stub);
> 
>> --
>> 2.43.0
>>

