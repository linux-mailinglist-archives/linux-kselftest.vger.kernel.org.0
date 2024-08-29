Return-Path: <linux-kselftest+bounces-16696-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3420B964AC1
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 17:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1114281A76
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 15:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812151B3B17;
	Thu, 29 Aug 2024 15:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ms3emRJ3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636F81B3B23
	for <linux-kselftest@vger.kernel.org>; Thu, 29 Aug 2024 15:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724947021; cv=none; b=FjJo4hLHyiNTPX/Fkj7a4yxZ/rR/iY1IhnAW+Tz3rYfIxwDOKrT7NxojpViwAEn/1cIyxOVxqFpa/5f3mu0QrK+OxYu6vyEcN1In+WtecOOU9RWUxzxaYtIB1ZOmpdV1kWE7oacRNiKnMcJUakDmjrgwTh2vrQhqkbW/Wcx6jsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724947021; c=relaxed/simple;
	bh=ug0PT6KAJ8ZEKoqNYB2FXBhMJvqepKT/4nch1GZZWKw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=XrSyEKOPYKpFbkHrDi5RXRyiNe7xzyWzoyHlgUihmpj+sHPMR+mli0IeilZXRfCSr3jDt+stVH4rygNgPHvq/3xmqnibjkeHsy4I59uGS5vYz8WweSGl74qX8MYwV5JskE09vUJCKfIyJ22Tsf0VrAzlJ74hfFKDV5XPSrYVQfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ms3emRJ3; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724947019; x=1756483019;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=ug0PT6KAJ8ZEKoqNYB2FXBhMJvqepKT/4nch1GZZWKw=;
  b=Ms3emRJ3XGtSitmv4K5Ty7rhhlBrtH5QNUKaqqji+fL+2wKtGPDzglog
   3f+hWz22ICU0D6hJYj/GP2GFkAz72bU6iLM7LL3vI+VADVtQ2liHa52FC
   qZSqGSCtigTJ7TJg2HSfkPf9BTTC9wQAmXzmaUIpLaSiVz1u6CMKDwi9Z
   tB6iLLSpD5NxIArxpmS89fptqo5IC4Z7tfoB9pAs71Sr9cdnm2eL1ODdS
   x4vIMPYCwF8O/ZXuSrGtsMysxnUWf18Z7FbAUWLBWvHZYJr6LRGAt1Lki
   x4NtoA5QQE2AuFFIurxXM7sgaRHQ2CavvM9zk7GT6kYzBGIrtyfgfU9jF
   A==;
X-CSE-ConnectionGUID: qGjWd9A6TVCE5IyYBbJ7bw==
X-CSE-MsgGUID: birZYqJgTe2jVlmbiuZR4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="34215005"
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="34215005"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 08:56:58 -0700
X-CSE-ConnectionGUID: mDQgWTPdQqyvYFVecHKHHQ==
X-CSE-MsgGUID: oybNgkLGTuC8pEyX9gJkRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="63245586"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa006.fm.intel.com with ESMTP; 29 Aug 2024 08:56:56 -0700
Received: from [10.245.120.199] (unknown [10.245.120.199])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id A3C8328789;
	Thu, 29 Aug 2024 16:56:54 +0100 (IST)
Message-ID: <537213da-b537-4cbf-91f1-15d84e16bd1e@intel.com>
Date: Thu, 29 Aug 2024 17:56:54 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] kunit: Allow function redirection outside of the
 KUnit thread
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 Rae Moar <rmoar@google.com>, David Gow <davidgow@google.com>,
 Daniel Latypov <dlatypov@google.com>
References: <20240826222015.1484-1-michal.wajdeczko@intel.com>
 <20240826222015.1484-5-michal.wajdeczko@intel.com>
 <xhciaodcnfjqe633zly2zkijzbi3ltfozewkyvkanpycclccte@ifoydlvgdnui>
 <3661b911-b01d-4230-a786-eaaa0e130a35@intel.com>
Content-Language: en-US
In-Reply-To: <3661b911-b01d-4230-a786-eaaa0e130a35@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 27.08.2024 22:30, Michal Wajdeczko wrote:
> 
> 
> On 27.08.2024 16:46, Lucas De Marchi wrote:
>> On Tue, Aug 27, 2024 at 12:20:13AM GMT, Michal Wajdeczko wrote:
>>> Currently, the 'static stub' API only allows function redirection
>>> for calls made from the kthread of the current test, which prevents
>>> the use of this functionality when the tested code is also used by
>>> other threads, outside of the KUnit test, like from the workqueue.
>>>
>>> Add another set of macros to allow redirection to the replacement
>>> functions, which, unlike the KUNIT_STATIC_STUB_REDIRECT, will
>>> affect all calls done during the test execution.
>>>
>>> These new stubs, named 'global', must be declared using dedicated
>>> KUNIT_DECLARE_GLOBAL_STUB() macro and then can be placed either as
>>> global static variables or as part of the other structures.
>>>
>>> To properly maintain stubs lifecycle, they can be activated only
>>> from the main KUnit context. Some precaution is taken to avoid
>>> changing or deactivating replacement functions if one is still
>>> used by other thread.
>>>
>>> Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
>>> ---
>>> Cc: Rae Moar <rmoar@google.com>
>>> Cc: David Gow <davidgow@google.com>
>>> Cc: Daniel Latypov <dlatypov@google.com>
>>> Cc: Lucas De Marchi <lucas.demarchi@intel.com>
>>> ---
>>> v2: s/FIXED_STUB/GLOBAL_STUB (David, Lucas)
>>>    make it little more thread safe (Rae, David)
>>>    wait until stub call finishes before test end (David)
>>>    wait until stub call finishes before changing stub (David)
>>>    allow stub deactivation (Rae)
>>>    prefer kunit log (David)
>>> ---
>>> include/kunit/static_stub.h | 158 ++++++++++++++++++++++++++++++++++++
>>> lib/kunit/static_stub.c     |  49 +++++++++++
>>> 2 files changed, 207 insertions(+)
>>>
>>> diff --git a/include/kunit/static_stub.h b/include/kunit/static_stub.h
>>> index bf940322dfc0..42a70dcefb56 100644
>>> --- a/include/kunit/static_stub.h
>>> +++ b/include/kunit/static_stub.h
>>> @@ -12,12 +12,15 @@
>>>
>>> /* If CONFIG_KUNIT is not enabled, these stubs quietly disappear. */
>>> #define KUNIT_STATIC_STUB_REDIRECT(real_fn_name, args...) do {} while (0)
>>> +#define KUNIT_GLOBAL_STUB_REDIRECT(stub_name, args...) do {} while (0)
>>> +#define KUNIT_DECLARE_GLOBAL_STUB(stub_name, stub_type)
>>>
>>> #else
>>>
>>> #include <kunit/test.h>
>>> #include <kunit/test-bug.h>
>>>
>>> +#include <linux/cleanup.h> /* for CLASS */
>>> #include <linux/compiler.h> /* for {un,}likely() */
>>> #include <linux/sched.h> /* for task_struct */
>>>
>>> @@ -109,5 +112,160 @@ void __kunit_activate_static_stub(struct kunit
>>> *test,
>>>  */
>>> void kunit_deactivate_static_stub(struct kunit *test, void
>>> *real_fn_addr);
>>>
>>> +/**
>>> + * struct kunit_global_stub - Represents a context of global function
>>> stub.
>>> + * @replacement: The address of replacement function.
>>> + * @owner: The KUnit test that owns the stub, valid only when @busy > 0.
>>> + * @busy: The stub busyness counter incremented on entry to the
>>> replacement
>>> + *        function, decremented on exit, used to signal if the stub
>>> is idle.
>>> + * @idle: The completion state to indicate when the stub is idle again.
>>> + *
>>> + * This structure is for KUnit internal use only.
>>> + * See KUNIT_DECLARE_GLOBAL_STUB().
>>> + */
>>> +struct kunit_global_stub {
>>> +    void *replacement;
>>> +    struct kunit *owner;
>>> +    atomic_t busy;
>>> +    struct completion idle;
>>> +};
>>> +
>>> +/**
>>> + * KUNIT_DECLARE_GLOBAL_STUB() - Declare a global function stub.
>>> + * @stub_name: The name of the stub, must be a valid identifier
>>> + * @stub_type: The type of the function that this stub will replace
>>> + *
>>> + * This macro will declare new identifier of an anonymous type that will
>>> + * represent global stub function that could be used by KUnit. It can
>>> be stored
>>> + * outside of the KUnit code. If the CONFIG_KUNIT is not enabled this
>>> will
>>> + * be evaluated to an empty statement.
>>> + *
>>> + * The anonymous type introduced by this macro is mostly a wrapper to
>>> generic
>>> + * struct kunit_global_stub but with additional dummy member, that is
>>> never
>>> + * used directly, but is needed to maintain the type of the stub
>>> function.
>>> + */
>>> +#define KUNIT_DECLARE_GLOBAL_STUB(stub_name, stub_type)                \
>>> +union {                                        \
>>> +    struct kunit_global_stub base;                        \
>>> +    typeof(stub_type) dummy;                        \
>>> +} stub_name
>>> +
>>> +/* Internal struct to define guard class */
>>> +struct kunit_global_stub_guard {
>>> +    struct kunit_global_stub *stub;
>>> +    void *active_replacement;
>>> +};
>>> +
>>> +/* Internal class used to guard stub calls */
>>> +DEFINE_CLASS(kunit_global_stub_guard,
>>> +         struct kunit_global_stub_guard,
>>> +         ({
>>> +        struct kunit_global_stub *stub = _T.stub;
>>> +        bool active = !!_T.active_replacement;
>>
>> I'd call this `bool active_replacement` as it's not the same thing as
>> the active below.
> 
> IMO 'active_replacement' would be even more confusing as by that name we
> identify the address and here it's a flag
> 
> OTOH the 'active' in both places means more/less the same (in init below
> it mean stub was 'activated' and in exit here that we used 'activated'
> replacement function)
> 
>>
>>> +
>>> +        if (active && !atomic_dec_return(&stub->busy))
>>> +            complete_all(&stub->idle);
>>> +         }),
>>> +         ({
>>> +        class_kunit_global_stub_guard_t guard;
>>> +        bool active = !!atomic_inc_not_zero(&stub->busy);
>>> +
>>> +        guard.stub = stub;
>>> +        guard.active_replacement = active ?
>>> READ_ONCE(stub->replacement) : NULL;
>>> +
>>> +        guard;
>>> +         }),
>>> +         struct kunit_global_stub *stub)
>>> +
>>> +/**
>>> + * KUNIT_GLOBAL_STUB_REDIRECT() - Call a fixed function stub if
>>> activated.
>>> + * @stub: The function stub declared using KUNIT_DECLARE_GLOBAL_STUB()
>>> + * @args: All of the arguments passed to this stub
>>> + *
>>> + * This is a function prologue which is used to allow calls to the
>>> current
>>> + * function to be redirected if a KUnit is running. If the KUnit is not
>>> + * running or stub is not yet activated the function will continue
>>> execution
>>> + * as normal.
>>> + *
>>> + * The function stub must be declared with
>>> KUNIT_DECLARE_GLOBAL_STUB() that is
>>> + * stored in a place that is accessible from both the test code,
>>> which will
>>> + * activate this stub using kunit_activate_global_stub(), and from
>>> the function,
>>> + * where we will do this redirection using KUNIT_GLOBAL_STUB_REDIRECT().
>>> + *
>>> + * Unlike the KUNIT_STATIC_STUB_REDIRECT(), this redirection will work
>>> + * even if the caller is not in a KUnit context (like a worker thread).
>>> + *
>>> + * Example:
>>> + *
>>> + * .. code-block:: c
>>> + *
>>> + *    KUNIT_DECLARE_GLOBAL_STUB(func_stub, int (*)(int n));
>>> + *
>>> + *    int real_func(int n)
>>> + *    {
>>> + *        KUNIT_GLOBAL_STUB_REDIRECT(func_stub, n);
>>> + *        return n + 1;
>>> + *    }
>>> + *
>>> + *    int replacement_func(int n)
>>> + *    {
>>> + *        return n + 100;
>>> + *    }
>>> + *
>>> + *    void example_test(struct kunit *test)
>>> + *    {
>>> + *        KUNIT_EXPECT_EQ(test, real_func(1), 2);
>>> + *        kunit_activate_global_stub(test, func_stub, replacement_func);
>>> + *        KUNIT_EXPECT_EQ(test, real_func(1), 101);
>>> + *    }
>>> + */
>>> +#define KUNIT_GLOBAL_STUB_REDIRECT(stub, args...) do
>>> {                    \
>>> +    if (kunit_is_running()) {                            \
>>> +        typeof(stub) *__stub = &(stub);                        \
>>> +        CLASS(kunit_global_stub_guard,
>>> guard)(&__stub->base);            \
>>> +        typeof(__stub->dummy) replacement =
>>> guard.active_replacement;        \
>>> +        if (unlikely(replacement)) {                        \
>>> +            kunit_info(__stub->base.owner, "%s: redirecting to
>>> %ps\n",    \
>>> +                   __func__, replacement);                \
>>> +            return replacement(args);                    \
>>> +        }                                    \
>>> +    }                                        \
>>> +} while (0)
>>> +
>>> +void __kunit_activate_global_stub(struct kunit *test, struct
>>> kunit_global_stub *stub,
>>> +                  void *replacement_addr);
>>> +
>>> +/**
>>> + * kunit_activate_global_stub() - Setup a fixed function stub.
>>
>> s/fixed/global/ here and every where else below
> 
> oops
> 
>>
>>> + * @test: Test case that wants to activate a fixed function stub
>>> + * @stub: The location of the function stub pointer
>>> + * @replacement: The replacement function
>>> + *
>>> + * This helper setups a function stub with the replacement function.
>>> + * It will also automatically deactivate the stub at the test end.
>>> + *
>>> + * The redirection can be disabled with kunit_deactivate_global_stub().
>>> + * The stub must be declared using KUNIT_DECLARE_GLOBAL_STUB().
>>> + */
>>> +#define kunit_activate_global_stub(test, stub, replacement) do
>>> {        \
>>> +    typeof(stub) *__stub = &(stub);                        \
>>> +    typecheck_fn(typeof(__stub->dummy), (replacement));            \
>>> +    __kunit_activate_global_stub((test), &__stub->base,
>>> (replacement));    \
>>> +} while (0)
>>> +
>>> +void __kunit_deactivate_global_stub(struct kunit *test, struct
>>> kunit_global_stub *stub);
>>> +
>>> +/**
>>> + * kunit_deactivate_global_stub() - Disable a fixed function stub.
>>> + * @test: Test case that wants to deactivate a fixed function stub
>>> + * @stub: The location of the function stub pointer
>>> + *
>>> + * The stub must be declared using KUNIT_DECLARE_GLOBAL_STUB().
>>> + */
>>> +#define kunit_deactivate_global_stub(test, stub) do {                \
>>> +    typeof(stub) *__stub = &(stub);                        \
>>> +    __kunit_deactivate_global_stub((test), &__stub->base);            \
>>> +} while (0)
>>> +
>>> #endif
>>> #endif
>>> diff --git a/lib/kunit/static_stub.c b/lib/kunit/static_stub.c
>>> index 92b2cccd5e76..799a7271dc5b 100644
>>> --- a/lib/kunit/static_stub.c
>>> +++ b/lib/kunit/static_stub.c
>>> @@ -121,3 +121,52 @@ void __kunit_activate_static_stub(struct kunit
>>> *test,
>>>     }
>>> }
>>> EXPORT_SYMBOL_GPL(__kunit_activate_static_stub);
>>> +
>>> +static void sanitize_global_stub(void *data)
>>> +{
>>> +    struct kunit *test = kunit_get_current_test();
>>> +    struct kunit_global_stub *stub =  data;
>>> +
>>> +    KUNIT_EXPECT_NE(test, 0, atomic_read(&stub->busy));
>>
>> shouldn't sanitize_ be unconditional and do nothing in this case?
> 
> I just didn't like early return here, but maybe it's more correct

hmm, in fact we don't need to check stub->busy prior to calling
kunit_release_action() since our goal is to detect whether stub was
activated, but this action will be released/called only if we have added
this action after the stub activation, so we can just rely on the action
management code and just keep the EXPECT_NE here as a guard

> 
>>
>>> +    KUNIT_EXPECT_PTR_EQ(test, test, READ_ONCE(stub->owner));
>>> +
>>> +    reinit_completion(&stub->idle);
>>> +    if (!atomic_dec_and_test(&stub->busy)) {
>>> +        kunit_info(test, "waiting for %ps\n", stub->replacement);
>>> +        KUNIT_EXPECT_EQ(test, 0,
>>> wait_for_completion_interruptible(&stub->idle));
>>
>> what's preventing stub->busy going to 1 again after this?
> 
> at the redirection point in kunit_global_stub_guard we have
> 
> 	atomic_inc_not_zero(&stub->busy);
> 
> and the activation/deactivation can only be done from the main KUnit
> thread (which is here)
> 
>>
>> Lucas De Marchi
>>
>>> +    }
>>> +
>>> +    WRITE_ONCE(stub->owner, NULL);
>>> +    WRITE_ONCE(stub->replacement, NULL);
>>> +}
>>> +
>>> +/*
>>> + * Helper function for kunit_activate_global_stub(). The macro does
>>> + * typechecking, so use it instead.
>>> + */
>>> +void __kunit_activate_global_stub(struct kunit *test,
>>> +                  struct kunit_global_stub *stub,
>>> +                  void *replacement_addr)
>>> +{
>>> +    KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stub);
>>> +    KUNIT_ASSERT_NOT_ERR_OR_NULL(test, replacement_addr);
>>> +    if (atomic_read(&stub->busy))
>>> +        kunit_release_action(test, sanitize_global_stub, stub);
>>> +    else
>>> +        init_completion(&stub->idle);
>>> +    WRITE_ONCE(stub->owner, test);
>>> +    WRITE_ONCE(stub->replacement, replacement_addr);
>>> +    KUNIT_ASSERT_EQ(test, 1, atomic_inc_return(&stub->busy));
>>> +    KUNIT_ASSERT_EQ(test, 0, kunit_add_action_or_reset(test,
>>> sanitize_global_stub, stub));
>>> +}
>>> +EXPORT_SYMBOL_GPL(__kunit_activate_global_stub);
>>> +
>>> +/*
>>> + * Helper function for kunit_deactivate_global_stub(). Use it instead.
>>> + */
>>> +void __kunit_deactivate_global_stub(struct kunit *test, struct
>>> kunit_global_stub *stub)
>>> +{
>>> +    if (atomic_read(&stub->busy))
>>> +        kunit_release_action(test, sanitize_global_stub, stub);
>>> +}
>>> +EXPORT_SYMBOL_GPL(__kunit_deactivate_global_stub);
>>> -- 
>>> 2.43.0
>>>

