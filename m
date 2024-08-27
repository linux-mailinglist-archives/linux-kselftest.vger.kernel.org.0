Return-Path: <linux-kselftest+bounces-16465-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF97961887
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 22:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F1BF1C23339
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 20:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86AC1D2F6E;
	Tue, 27 Aug 2024 20:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L8o3WdnS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723A11CC8A3
	for <linux-kselftest@vger.kernel.org>; Tue, 27 Aug 2024 20:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724790636; cv=none; b=AuXCiwrWsQYg2oHFsxZyKA2j8i8J15XX5XDpIzOTYfRSgVIrSTQAPmO9LNcJ9vRqdsRXdh7cHcjuys7YSJ5BYgd2r7axc/Dj+efsy98KMLg+E7PL/IN8ZnSJbX2oIBWcPH1r1CBJSBJyawFP+E/JMNZEXJiWxirLJngahdmWfDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724790636; c=relaxed/simple;
	bh=Qp0rtklYpGhyoJOtAZLO5JjUXLeIp5JGwB53UfgZUBI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sslj8SdOLrKAWqO9Kcqb7VkTKPyUng6YWsIeg/VTxDTKuRpHO459Ofp8PEaTHg6MIu8pEHHFV2LwWTly1V/uYHdBBWqehih3b3hPJNYk/zJB77LvfMc/xQmfpluyf1+O9ttDFkJ7n8FB//y7Ujywc4oDQg3w1FpPl/dQ6n8ZSOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L8o3WdnS; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724790635; x=1756326635;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Qp0rtklYpGhyoJOtAZLO5JjUXLeIp5JGwB53UfgZUBI=;
  b=L8o3WdnSdnxt2ikwHZHK/1YrYhXIHxl/4by7/ZWkL6wGFAfPfcVlhhMN
   KUBLoiNzBLuYIcOfrzMfwjHwgTv/aiWh6yArDDaZJxBndb4Uuqn+pmRH6
   lESDmKmh98JViea+u/Pqmmd/H621AUkihHhcKKaayoxCYxR9qHKc8DemD
   dVx3oHndAAkFv4IsTiLNFczzLRo6I38VAI30EI3N8ILypw6EfqtaXHzkq
   3nFwapjuJNQDBPWpo3pvyJqG7ZCv96ob4HJWlwqt3J9tOUVX9d7aEQ3Bj
   6BxmqfVqcLrEgJfUNKbU0Px8mpObP+wQrHmXxKXpmvs31VpRFtpBK5U72
   A==;
X-CSE-ConnectionGUID: /osu+QO4SZqoZnOus7kb7w==
X-CSE-MsgGUID: 94Os3KvlSKOW6LBGcf7CRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="34703803"
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="34703803"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 13:30:25 -0700
X-CSE-ConnectionGUID: JCz7RiCZRuqxByA87qsYtw==
X-CSE-MsgGUID: KRD/BJsoTVicxU8G4cPsuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="63708529"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa008.jf.intel.com with ESMTP; 27 Aug 2024 13:30:23 -0700
Received: from [10.246.1.253] (mwajdecz-MOBL.ger.corp.intel.com [10.246.1.253])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id ED192312C7;
	Tue, 27 Aug 2024 21:30:21 +0100 (IST)
Message-ID: <3661b911-b01d-4230-a786-eaaa0e130a35@intel.com>
Date: Tue, 27 Aug 2024 22:30:21 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] kunit: Allow function redirection outside of the
 KUnit thread
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 Rae Moar <rmoar@google.com>, David Gow <davidgow@google.com>,
 Daniel Latypov <dlatypov@google.com>
References: <20240826222015.1484-1-michal.wajdeczko@intel.com>
 <20240826222015.1484-5-michal.wajdeczko@intel.com>
 <xhciaodcnfjqe633zly2zkijzbi3ltfozewkyvkanpycclccte@ifoydlvgdnui>
Content-Language: en-US
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
In-Reply-To: <xhciaodcnfjqe633zly2zkijzbi3ltfozewkyvkanpycclccte@ifoydlvgdnui>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 27.08.2024 16:46, Lucas De Marchi wrote:
> On Tue, Aug 27, 2024 at 12:20:13AM GMT, Michal Wajdeczko wrote:
>> Currently, the 'static stub' API only allows function redirection
>> for calls made from the kthread of the current test, which prevents
>> the use of this functionality when the tested code is also used by
>> other threads, outside of the KUnit test, like from the workqueue.
>>
>> Add another set of macros to allow redirection to the replacement
>> functions, which, unlike the KUNIT_STATIC_STUB_REDIRECT, will
>> affect all calls done during the test execution.
>>
>> These new stubs, named 'global', must be declared using dedicated
>> KUNIT_DECLARE_GLOBAL_STUB() macro and then can be placed either as
>> global static variables or as part of the other structures.
>>
>> To properly maintain stubs lifecycle, they can be activated only
>> from the main KUnit context. Some precaution is taken to avoid
>> changing or deactivating replacement functions if one is still
>> used by other thread.
>>
>> Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
>> ---
>> Cc: Rae Moar <rmoar@google.com>
>> Cc: David Gow <davidgow@google.com>
>> Cc: Daniel Latypov <dlatypov@google.com>
>> Cc: Lucas De Marchi <lucas.demarchi@intel.com>
>> ---
>> v2: s/FIXED_STUB/GLOBAL_STUB (David, Lucas)
>>    make it little more thread safe (Rae, David)
>>    wait until stub call finishes before test end (David)
>>    wait until stub call finishes before changing stub (David)
>>    allow stub deactivation (Rae)
>>    prefer kunit log (David)
>> ---
>> include/kunit/static_stub.h | 158 ++++++++++++++++++++++++++++++++++++
>> lib/kunit/static_stub.c     |  49 +++++++++++
>> 2 files changed, 207 insertions(+)
>>
>> diff --git a/include/kunit/static_stub.h b/include/kunit/static_stub.h
>> index bf940322dfc0..42a70dcefb56 100644
>> --- a/include/kunit/static_stub.h
>> +++ b/include/kunit/static_stub.h
>> @@ -12,12 +12,15 @@
>>
>> /* If CONFIG_KUNIT is not enabled, these stubs quietly disappear. */
>> #define KUNIT_STATIC_STUB_REDIRECT(real_fn_name, args...) do {} while (0)
>> +#define KUNIT_GLOBAL_STUB_REDIRECT(stub_name, args...) do {} while (0)
>> +#define KUNIT_DECLARE_GLOBAL_STUB(stub_name, stub_type)
>>
>> #else
>>
>> #include <kunit/test.h>
>> #include <kunit/test-bug.h>
>>
>> +#include <linux/cleanup.h> /* for CLASS */
>> #include <linux/compiler.h> /* for {un,}likely() */
>> #include <linux/sched.h> /* for task_struct */
>>
>> @@ -109,5 +112,160 @@ void __kunit_activate_static_stub(struct kunit
>> *test,
>>  */
>> void kunit_deactivate_static_stub(struct kunit *test, void
>> *real_fn_addr);
>>
>> +/**
>> + * struct kunit_global_stub - Represents a context of global function
>> stub.
>> + * @replacement: The address of replacement function.
>> + * @owner: The KUnit test that owns the stub, valid only when @busy > 0.
>> + * @busy: The stub busyness counter incremented on entry to the
>> replacement
>> + *        function, decremented on exit, used to signal if the stub
>> is idle.
>> + * @idle: The completion state to indicate when the stub is idle again.
>> + *
>> + * This structure is for KUnit internal use only.
>> + * See KUNIT_DECLARE_GLOBAL_STUB().
>> + */
>> +struct kunit_global_stub {
>> +    void *replacement;
>> +    struct kunit *owner;
>> +    atomic_t busy;
>> +    struct completion idle;
>> +};
>> +
>> +/**
>> + * KUNIT_DECLARE_GLOBAL_STUB() - Declare a global function stub.
>> + * @stub_name: The name of the stub, must be a valid identifier
>> + * @stub_type: The type of the function that this stub will replace
>> + *
>> + * This macro will declare new identifier of an anonymous type that will
>> + * represent global stub function that could be used by KUnit. It can
>> be stored
>> + * outside of the KUnit code. If the CONFIG_KUNIT is not enabled this
>> will
>> + * be evaluated to an empty statement.
>> + *
>> + * The anonymous type introduced by this macro is mostly a wrapper to
>> generic
>> + * struct kunit_global_stub but with additional dummy member, that is
>> never
>> + * used directly, but is needed to maintain the type of the stub
>> function.
>> + */
>> +#define KUNIT_DECLARE_GLOBAL_STUB(stub_name, stub_type)                \
>> +union {                                        \
>> +    struct kunit_global_stub base;                        \
>> +    typeof(stub_type) dummy;                        \
>> +} stub_name
>> +
>> +/* Internal struct to define guard class */
>> +struct kunit_global_stub_guard {
>> +    struct kunit_global_stub *stub;
>> +    void *active_replacement;
>> +};
>> +
>> +/* Internal class used to guard stub calls */
>> +DEFINE_CLASS(kunit_global_stub_guard,
>> +         struct kunit_global_stub_guard,
>> +         ({
>> +        struct kunit_global_stub *stub = _T.stub;
>> +        bool active = !!_T.active_replacement;
> 
> I'd call this `bool active_replacement` as it's not the same thing as
> the active below.

IMO 'active_replacement' would be even more confusing as by that name we
identify the address and here it's a flag

OTOH the 'active' in both places means more/less the same (in init below
it mean stub was 'activated' and in exit here that we used 'activated'
replacement function)

> 
>> +
>> +        if (active && !atomic_dec_return(&stub->busy))
>> +            complete_all(&stub->idle);
>> +         }),
>> +         ({
>> +        class_kunit_global_stub_guard_t guard;
>> +        bool active = !!atomic_inc_not_zero(&stub->busy);
>> +
>> +        guard.stub = stub;
>> +        guard.active_replacement = active ?
>> READ_ONCE(stub->replacement) : NULL;
>> +
>> +        guard;
>> +         }),
>> +         struct kunit_global_stub *stub)
>> +
>> +/**
>> + * KUNIT_GLOBAL_STUB_REDIRECT() - Call a fixed function stub if
>> activated.
>> + * @stub: The function stub declared using KUNIT_DECLARE_GLOBAL_STUB()
>> + * @args: All of the arguments passed to this stub
>> + *
>> + * This is a function prologue which is used to allow calls to the
>> current
>> + * function to be redirected if a KUnit is running. If the KUnit is not
>> + * running or stub is not yet activated the function will continue
>> execution
>> + * as normal.
>> + *
>> + * The function stub must be declared with
>> KUNIT_DECLARE_GLOBAL_STUB() that is
>> + * stored in a place that is accessible from both the test code,
>> which will
>> + * activate this stub using kunit_activate_global_stub(), and from
>> the function,
>> + * where we will do this redirection using KUNIT_GLOBAL_STUB_REDIRECT().
>> + *
>> + * Unlike the KUNIT_STATIC_STUB_REDIRECT(), this redirection will work
>> + * even if the caller is not in a KUnit context (like a worker thread).
>> + *
>> + * Example:
>> + *
>> + * .. code-block:: c
>> + *
>> + *    KUNIT_DECLARE_GLOBAL_STUB(func_stub, int (*)(int n));
>> + *
>> + *    int real_func(int n)
>> + *    {
>> + *        KUNIT_GLOBAL_STUB_REDIRECT(func_stub, n);
>> + *        return n + 1;
>> + *    }
>> + *
>> + *    int replacement_func(int n)
>> + *    {
>> + *        return n + 100;
>> + *    }
>> + *
>> + *    void example_test(struct kunit *test)
>> + *    {
>> + *        KUNIT_EXPECT_EQ(test, real_func(1), 2);
>> + *        kunit_activate_global_stub(test, func_stub, replacement_func);
>> + *        KUNIT_EXPECT_EQ(test, real_func(1), 101);
>> + *    }
>> + */
>> +#define KUNIT_GLOBAL_STUB_REDIRECT(stub, args...) do
>> {                    \
>> +    if (kunit_is_running()) {                            \
>> +        typeof(stub) *__stub = &(stub);                        \
>> +        CLASS(kunit_global_stub_guard,
>> guard)(&__stub->base);            \
>> +        typeof(__stub->dummy) replacement =
>> guard.active_replacement;        \
>> +        if (unlikely(replacement)) {                        \
>> +            kunit_info(__stub->base.owner, "%s: redirecting to
>> %ps\n",    \
>> +                   __func__, replacement);                \
>> +            return replacement(args);                    \
>> +        }                                    \
>> +    }                                        \
>> +} while (0)
>> +
>> +void __kunit_activate_global_stub(struct kunit *test, struct
>> kunit_global_stub *stub,
>> +                  void *replacement_addr);
>> +
>> +/**
>> + * kunit_activate_global_stub() - Setup a fixed function stub.
> 
> s/fixed/global/ here and every where else below

oops

> 
>> + * @test: Test case that wants to activate a fixed function stub
>> + * @stub: The location of the function stub pointer
>> + * @replacement: The replacement function
>> + *
>> + * This helper setups a function stub with the replacement function.
>> + * It will also automatically deactivate the stub at the test end.
>> + *
>> + * The redirection can be disabled with kunit_deactivate_global_stub().
>> + * The stub must be declared using KUNIT_DECLARE_GLOBAL_STUB().
>> + */
>> +#define kunit_activate_global_stub(test, stub, replacement) do
>> {        \
>> +    typeof(stub) *__stub = &(stub);                        \
>> +    typecheck_fn(typeof(__stub->dummy), (replacement));            \
>> +    __kunit_activate_global_stub((test), &__stub->base,
>> (replacement));    \
>> +} while (0)
>> +
>> +void __kunit_deactivate_global_stub(struct kunit *test, struct
>> kunit_global_stub *stub);
>> +
>> +/**
>> + * kunit_deactivate_global_stub() - Disable a fixed function stub.
>> + * @test: Test case that wants to deactivate a fixed function stub
>> + * @stub: The location of the function stub pointer
>> + *
>> + * The stub must be declared using KUNIT_DECLARE_GLOBAL_STUB().
>> + */
>> +#define kunit_deactivate_global_stub(test, stub) do {                \
>> +    typeof(stub) *__stub = &(stub);                        \
>> +    __kunit_deactivate_global_stub((test), &__stub->base);            \
>> +} while (0)
>> +
>> #endif
>> #endif
>> diff --git a/lib/kunit/static_stub.c b/lib/kunit/static_stub.c
>> index 92b2cccd5e76..799a7271dc5b 100644
>> --- a/lib/kunit/static_stub.c
>> +++ b/lib/kunit/static_stub.c
>> @@ -121,3 +121,52 @@ void __kunit_activate_static_stub(struct kunit
>> *test,
>>     }
>> }
>> EXPORT_SYMBOL_GPL(__kunit_activate_static_stub);
>> +
>> +static void sanitize_global_stub(void *data)
>> +{
>> +    struct kunit *test = kunit_get_current_test();
>> +    struct kunit_global_stub *stub =  data;
>> +
>> +    KUNIT_EXPECT_NE(test, 0, atomic_read(&stub->busy));
> 
> shouldn't sanitize_ be unconditional and do nothing in this case?

I just didn't like early return here, but maybe it's more correct

> 
>> +    KUNIT_EXPECT_PTR_EQ(test, test, READ_ONCE(stub->owner));
>> +
>> +    reinit_completion(&stub->idle);
>> +    if (!atomic_dec_and_test(&stub->busy)) {
>> +        kunit_info(test, "waiting for %ps\n", stub->replacement);
>> +        KUNIT_EXPECT_EQ(test, 0,
>> wait_for_completion_interruptible(&stub->idle));
> 
> what's preventing stub->busy going to 1 again after this?

at the redirection point in kunit_global_stub_guard we have

	atomic_inc_not_zero(&stub->busy);

and the activation/deactivation can only be done from the main KUnit
thread (which is here)

> 
> Lucas De Marchi
> 
>> +    }
>> +
>> +    WRITE_ONCE(stub->owner, NULL);
>> +    WRITE_ONCE(stub->replacement, NULL);
>> +}
>> +
>> +/*
>> + * Helper function for kunit_activate_global_stub(). The macro does
>> + * typechecking, so use it instead.
>> + */
>> +void __kunit_activate_global_stub(struct kunit *test,
>> +                  struct kunit_global_stub *stub,
>> +                  void *replacement_addr)
>> +{
>> +    KUNIT_ASSERT_NOT_ERR_OR_NULL(test, stub);
>> +    KUNIT_ASSERT_NOT_ERR_OR_NULL(test, replacement_addr);
>> +    if (atomic_read(&stub->busy))
>> +        kunit_release_action(test, sanitize_global_stub, stub);
>> +    else
>> +        init_completion(&stub->idle);
>> +    WRITE_ONCE(stub->owner, test);
>> +    WRITE_ONCE(stub->replacement, replacement_addr);
>> +    KUNIT_ASSERT_EQ(test, 1, atomic_inc_return(&stub->busy));
>> +    KUNIT_ASSERT_EQ(test, 0, kunit_add_action_or_reset(test,
>> sanitize_global_stub, stub));
>> +}
>> +EXPORT_SYMBOL_GPL(__kunit_activate_global_stub);
>> +
>> +/*
>> + * Helper function for kunit_deactivate_global_stub(). Use it instead.
>> + */
>> +void __kunit_deactivate_global_stub(struct kunit *test, struct
>> kunit_global_stub *stub)
>> +{
>> +    if (atomic_read(&stub->busy))
>> +        kunit_release_action(test, sanitize_global_stub, stub);
>> +}
>> +EXPORT_SYMBOL_GPL(__kunit_deactivate_global_stub);
>> -- 
>> 2.43.0
>>

