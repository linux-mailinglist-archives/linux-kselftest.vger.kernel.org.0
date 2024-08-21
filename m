Return-Path: <linux-kselftest+bounces-15937-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3680495A7DA
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 00:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E232A284B4B
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 22:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F60D17A58F;
	Wed, 21 Aug 2024 22:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lwS1lcaW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1EE14B96A
	for <linux-kselftest@vger.kernel.org>; Wed, 21 Aug 2024 22:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724279654; cv=none; b=XovkDHAPu4aGDH+JEpPH9cqj3/nCKLuPVzcYzGC1C6CybNc44AcSg2AebwQ+YOjgqBlBzAQYjcPOTeM/2A8wVhquSvnO3nImzXC1VykObcUYgKqwAiADJM+PLMDT55ELet7nu/hQNEjLEmRKfU1p4XPCGRHU5drRKiEgT9L5C4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724279654; c=relaxed/simple;
	bh=ahyduyQj2Qdxh01GAgiq4m3ZjfwJiLwcrHPlIHV05KM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dzsjG2RAcUyb8dBZOmwMBW4o5L652ABt8DBN2pi7V3Nr+NToYt+ZiYtDtScqE0olHp9ySihhodM/73vz2SzCqN3EbxafHuijynRi+MKYMm2rMfUsx0r+aWacyjW0/TpkDJN8P891pBznq6jgNT0e5XZF+eMkBpYS3VntfNYy1yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lwS1lcaW; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724279652; x=1755815652;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ahyduyQj2Qdxh01GAgiq4m3ZjfwJiLwcrHPlIHV05KM=;
  b=lwS1lcaW0+HB2ugTy+VxuxyNTRoLfZX1md2mWE4Bz7ml1a3RSp1+OJbx
   BYL1n61l2H8kpCPsb/v9yg4Iqf4cevsUC0gFB2HXr4juan6ZBGy4Unv4p
   qs72dcMdiA0+5LLOnkPscCtAv7Ay1HFKKSl4PQ5ay+mSwxuNHZlOw927k
   2USvjNE+AdP7y8bzL13NUpb9hqg0k1ZxqYZ9XqDHbHloSB2cUfnFbdugi
   C+TkP2Wg72wHnSabfmYM6PrPn/xuhboVT/6ygjoOd5h3LDN0rvKfvw1Wh
   0AiWb1G3OxBm5nuloVqfe+AoGK9vkmo8+112sovGnlciNOsWvWV24kifa
   A==;
X-CSE-ConnectionGUID: c+ixJN4zSQWhYAiVnexkJw==
X-CSE-MsgGUID: BhFulm4uT7yLVAe8DeY5Fw==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="33282934"
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="33282934"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 15:34:11 -0700
X-CSE-ConnectionGUID: MhYBcERjSNeT5SN0c6yCFw==
X-CSE-MsgGUID: osGHF2QZQOmzKuHs1yMooA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="65932483"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa004.fm.intel.com with ESMTP; 21 Aug 2024 15:34:09 -0700
Received: from [10.246.19.248] (mwajdecz-MOBL.ger.corp.intel.com [10.246.19.248])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id E10212FC66;
	Wed, 21 Aug 2024 23:34:07 +0100 (IST)
Message-ID: <2f1ffc59-61fa-4b81-a9a5-e9bd826af22e@intel.com>
Date: Thu, 22 Aug 2024 00:34:07 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] kunit: Allow function redirection outside of the
 KUnit thread
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 David Gow <davidgow@google.com>, Daniel Latypov <dlatypov@google.com>
References: <20240821144305.1958-1-michal.wajdeczko@intel.com>
 <20240821144305.1958-4-michal.wajdeczko@intel.com>
 <v2fowtjqftsv25tnbtaooi72chhjo3rsw575vc5wkag5wpw35w@fnz3td42tb3s>
Content-Language: en-US
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
In-Reply-To: <v2fowtjqftsv25tnbtaooi72chhjo3rsw575vc5wkag5wpw35w@fnz3td42tb3s>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 21.08.2024 23:38, Lucas De Marchi wrote:
> On Wed, Aug 21, 2024 at 04:43:04PM GMT, Michal Wajdeczko wrote:
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
>> include/kunit/static_stub.h | 80 +++++++++++++++++++++++++++++++++++++
>> lib/kunit/static_stub.c     | 21 ++++++++++
>> 2 files changed, 101 insertions(+)
>>
>> diff --git a/include/kunit/static_stub.h b/include/kunit/static_stub.h
>> index bf940322dfc0..3dd98c8f3f1f 100644
>> --- a/include/kunit/static_stub.h
>> +++ b/include/kunit/static_stub.h
>> @@ -12,6 +12,7 @@
>>
>> /* If CONFIG_KUNIT is not enabled, these stubs quietly disappear. */
>> #define KUNIT_STATIC_STUB_REDIRECT(real_fn_name, args...) do {} while (0)
>> +#define KUNIT_FIXED_STUB_REDIRECT(stub, args...) do {} while (0)
>>
>> #else
>>
>> @@ -109,5 +110,84 @@ void __kunit_activate_static_stub(struct kunit
>> *test,
>>  */
>> void kunit_deactivate_static_stub(struct kunit *test, void
>> *real_fn_addr);
>>
>> +/**
>> + * KUNIT_FIXED_STUB_REDIRECT() - Call a fixed function stub if
>> activated.
>> + * @stub: The location of the function stub pointer
>> + * @args: All of the arguments passed to this stub
>> + *
>> + * This is a function prologue which is used to allow calls to the
>> current
>> + * function to be redirected if a KUnit is running. If the stub is
>> NULL or
>> + * the KUnit is not running the function will continue execution as
>> normal.
>> + *
>> + * The function stub pointer must be stored in a place that is
>> accessible both
>> + * from the test code that will activate this stub and from the
>> function where
>> + * we will do the redirection.
>> + *
>> + * Unlike the KUNIT_STATIC_STUB_REDIRECT(), this redirection will work
>> + * even if the caller is not in a KUnit context (like a worker thread).
> 
> not sure about the name FIXED vs STATIC. What about

well, I must admit that I also wasn't sure about the name..

> 
> KUNIT_FIXED_STUB_REDIRECT()
> KUNIT_FIXED_STUB_REDIRECT_ALL_CONTEXTS()

since we have

	KUNIT_STATIC_STUB_REDIRECT()

then maybe

	KUNIT_STATIC_STUB_REDIRECT_ALL_CONTEXTS()
	KUNIT_STATIC_STUB_REDIRECT_GLOBAL()

> 
> ?
> 
>> + *
>> + * Example:
>> + *
>> + * .. code-block:: c
>> + *
>> + *    static int (*func_stub)(int n);
>> + *
>> + *    int real_func(int n)
>> + *    {
>> + *        KUNIT_FIXED_STUB_REDIRECT(func_stub, n);
> 
> what I don't like here is that KUNIT_STATIC_STUB_REDIRECT()
> uses the name of **this** function, whiel KUNIT_FIXED_STUB_REDIRECT()
> uses the function pointer. I don't have a better suggestion on how to
> handle it, but this looks error prone.

the KUNIT_STATIC_STUB_REDIRECT() is in a better position as it can do
lookup a resource (which is a stub function pointer) based on the "this
function" as it runs in a kunit context, while FIXED variant must access
stub pointer directly

or do you mean that wrong stub name could provided?
but note that you may also make the same mistake today:

int foo(int n)
{
	KUNIT_STATIC_STUB_REDIRECT(bar, n);
}

hmm, maybe we can try to do this:

KUNIT_STATIC_STUB_REDIRECT_GLOBAL(stubs, func, args...)
@stubs - place where function pointers are kept
@func - we can use it to check types and as member name

	replacement = stubs.func;
	return replacement(args);

kunit_activate_static_stub_global(test, stubs, func, replacement)
@stubs - place where function pointers are kept
@func - we can use it to check types and as member name

	stubs.func = replacement

> 
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
>> + *        func_stub = replacement_func;
>> + *        KUNIT_EXPECT_EQ(test, real_func(1), 101);
>> + *    }
>> + */
>> +#define KUNIT_FIXED_STUB_REDIRECT(stub, args...) do
>> {                    \
>> +    typeof(stub) replacement = (stub);                        \
>> +    if (kunit_is_running()) {                            \
>> +        if (unlikely(replacement)) {                        \
> 
> probably better as `if (unlikely(kunit_is_running() && replacement))`?
> Because we are likely to use one specific replacement in just 1 or few
> tests from an entire testsuite.

kunit_is_running() is already 'unlikely'

> 
> Lucas De Marchi
> 
>> +            pr_info(KUNIT_SUBTEST_INDENT "# %s: calling stub
>> %ps\n",    \
>> +                __func__, replacement);                    \
>> +            return replacement(args);                    \
>> +        }                                    \
>> +    }                                        \
>> +} while (0)
>> +
>> +void __kunit_activate_fixed_stub(struct kunit *test, void *stub_ptr,
>> void *replacement_func);
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
>> +#define kunit_activate_fixed_stub(test, stub, replacement) do
>> {                \
>> +    typecheck_pointer(stub);                            \
>> +    typecheck_fn(typeof(stub), replacement);                    \
>> +    typeof(stub) *stub_ptr = &(stub);                        \
>> +    __kunit_activate_fixed_stub((test), stub_ptr,
>> (replacement));            \
>> +} while (0)
>> +
>> +/**
>> + * kunit_deactivate_fixed_stub() - Disable a fixed function stub.
>> + * @test: Test case that wants to deactivate a fixed function stub
>> (unused for now)
>> + * @stub: The location of the function stub pointer
>> + */
>> +#define kunit_deactivate_fixed_stub(test, stub) do
>> {                    \
>> +    typecheck(struct kunit *, (test));                        \
>> +    (stub) = NULL;                                    \
>> +} while (0)
>> +
>> #endif
>> #endif
>> diff --git a/lib/kunit/static_stub.c b/lib/kunit/static_stub.c
>> index 92b2cccd5e76..1b50cf457e89 100644
>> --- a/lib/kunit/static_stub.c
>> +++ b/lib/kunit/static_stub.c
>> @@ -121,3 +121,24 @@ void __kunit_activate_static_stub(struct kunit
>> *test,
>>     }
>> }
>> EXPORT_SYMBOL_GPL(__kunit_activate_static_stub);
>> +
>> +static void nullify_stub_ptr(void *data)
>> +{
>> +    void **ptr = data;
>> +
>> +    *ptr = NULL;
>> +}
>> +
>> +/*
>> + * Helper function for kunit_activate_static_stub(). The macro does
>> + * typechecking, so use it instead.
>> + */
>> +void __kunit_activate_fixed_stub(struct kunit *test, void *stub_ptr,
>> void *replacement_func)
>> +{
>> +    void **stub = stub_ptr;
>> +
>> +    KUNIT_ASSERT_NOT_NULL(test, stub_ptr);
>> +    *stub = replacement_func;
>> +    KUNIT_ASSERT_EQ(test, 0, kunit_add_action_or_reset(test,
>> nullify_stub_ptr, stub_ptr));
>> +}
>> +EXPORT_SYMBOL_GPL(__kunit_activate_fixed_stub);
>> -- 
>> 2.43.0
>>

