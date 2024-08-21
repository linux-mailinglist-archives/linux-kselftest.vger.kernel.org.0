Return-Path: <linux-kselftest+bounces-15930-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFAA795A6F9
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 23:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFE1E1C21C2C
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 21:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9FA16EBF2;
	Wed, 21 Aug 2024 21:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LK1VnecK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6AD1531C3
	for <linux-kselftest@vger.kernel.org>; Wed, 21 Aug 2024 21:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724276857; cv=none; b=O5LMl0yuDRnDDCWLeNSUdCRsuWfRaS+BcPT8FtRodtd+RkQKaJbLngLe8ZA+1A6hf5q+zglLhBYrul2duNru3MAHqWgXKka0dpI1R63aM+dMPkf7QzTEBa6pVHWTGRknDW+eetn8jIbkjJwzpmiU5HzvwygyWCwM9dsB98MfW+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724276857; c=relaxed/simple;
	bh=znLoTWYvmBhEeLfxmGulwIZ7sX7rAAs/iyyPy0VVyDs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mfdmW6/1tOHEHzKQ57JSb2ad+dm2TUer77BoqHIPGrZwXLJqUjwkUYyccL/HbWRbGIZcUvyabIzUmhgqHPUxw9zpYFXvSCcluoJXQGjIvjTPOcwzAclVcm/i4B/M9OJ9e+V6Mbc/x/wmAhiEhJv+U6T6IYVRZSj71B1ZRNDngaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LK1VnecK; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724276856; x=1755812856;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=znLoTWYvmBhEeLfxmGulwIZ7sX7rAAs/iyyPy0VVyDs=;
  b=LK1VnecKg/+G8iCY/qu9sGDcVUsKZCOiKN1hpE/Kkgdm6YnNR8YfPkNb
   t958kjMmiO4QC1U3N40QlZYOgZNSxbyIrCebZHgn8weh1e+WccUF+jyfm
   O44Q5k1Ur5mvtmGHNsZUbGTAP01hEvVTb1ntltzlMhA/YuZGEakPUBFkS
   Hz/oIeeRYiIW31UbZ6Km8BsSc34YtNCAPGb93s3TeNL00kn9iOLy3ia0Z
   Zx2MeWaamVGsAGOVEpNh8Kzu8EkvoBegofS1BicKd4AW/8kdkxyM49iVU
   0hOWPCriYfR9pP6njTY7rCwVuVcpiZjB7HtCPS+dL1bpHBT5miz/9vO5m
   w==;
X-CSE-ConnectionGUID: NHWuMfmoSg23EgMlLRxKzQ==
X-CSE-MsgGUID: a4wSiIkRTLKO3w/oVQ2GlA==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="22190048"
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="22190048"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 14:47:35 -0700
X-CSE-ConnectionGUID: y5Gvtbc3TX6UjH5KpRrBmQ==
X-CSE-MsgGUID: gDlbFRJkRH6UNSTF25Hwxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,165,1719903600"; 
   d="scan'208";a="61219573"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa008.fm.intel.com with ESMTP; 21 Aug 2024 14:47:34 -0700
Received: from [10.246.19.248] (mwajdecz-MOBL.ger.corp.intel.com [10.246.19.248])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 11B67312E9;
	Wed, 21 Aug 2024 22:47:31 +0100 (IST)
Message-ID: <ef08991e-5914-4e85-966e-1a2b43cb7728@intel.com>
Date: Wed, 21 Aug 2024 23:47:31 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] kunit: Allow function redirection outside of the
 KUnit thread
To: Rae Moar <rmoar@google.com>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 David Gow <davidgow@google.com>, Daniel Latypov <dlatypov@google.com>,
 Lucas De Marchi <lucas.demarchi@intel.com>
References: <20240821144305.1958-1-michal.wajdeczko@intel.com>
 <20240821144305.1958-4-michal.wajdeczko@intel.com>
 <CA+GJov5yfiQJhcCKUfSX0+-z1w=gZ-LPMUyq3tcNUrSuKDTgeQ@mail.gmail.com>
Content-Language: en-US
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
In-Reply-To: <CA+GJov5yfiQJhcCKUfSX0+-z1w=gZ-LPMUyq3tcNUrSuKDTgeQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 21.08.2024 23:32, Rae Moar wrote:
> On Wed, Aug 21, 2024 at 10:43 AM Michal Wajdeczko
> <michal.wajdeczko@intel.com> wrote:
>>
> Hello!
> 
> This is looking good and seems to be working well. I just had some
> questions below.
> 
> Thanks!
> -Rae
> 
>> Currently, the 'static stub' API only allows function redirection
>> for calls made from the kthread of the current test, which prevents
>> the use of this functionalty when the tested code is also used by
> 
> A slight typo here: functionality
> 
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
> 
> I think we should model activating the stub here in the example to
> make it a bit clearer.

oops, this DOC was taken almost as-is from my Xe series mentioned in the
cover letter, where I didn't have any "activate_fixed_stub" code yet

will fix

> 
>> + *     }
>> + */
>> +#define KUNIT_FIXED_STUB_REDIRECT(stub, args...) do {                                  \
>> +       typeof(stub) replacement = (stub);                                              \
>> +       if (kunit_is_running()) {                                                       \
>> +               if (unlikely(replacement)) {                                            \
>> +                       pr_info(KUNIT_SUBTEST_INDENT "# %s: calling stub %ps\n",        \
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
> 
> Should we check here if the replacement_func is null and if so
> deactivate the stub similar to the static stubbing?

I had KUNIT_ASSERT_NOT_NULL(test, replacement_func) but decided to drop
that to also allow using 'activate_stub(NULL)' to deactivate the stub -
but that was before I introduced a separate 'deactivate_stub()'

will bring that back

> 
>> +       *stub = replacement_func;
> 
> I do really appreciate this simplicity. But I wonder if David has any
> thoughts on the security of direct replacement rather than using the
> resource API?

note that at redirection point we will not be able to use resource API
since that could be run in a non-kunit context

> 
>> +       KUNIT_ASSERT_EQ(test, 0, kunit_add_action_or_reset(test, nullify_stub_ptr, stub_ptr));
>> +}
>> +EXPORT_SYMBOL_GPL(__kunit_activate_fixed_stub);
>> --
>> 2.43.0
>>
>> --
>> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
>> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
>> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20240821144305.1958-4-michal.wajdeczko%40intel.com.

