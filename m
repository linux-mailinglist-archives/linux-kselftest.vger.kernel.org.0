Return-Path: <linux-kselftest+bounces-19551-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C19C99A8E0
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 18:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5580F1C211F2
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Oct 2024 16:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3A4199231;
	Fri, 11 Oct 2024 16:29:56 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D76198E7F;
	Fri, 11 Oct 2024 16:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728664196; cv=none; b=NR+auKQyjdsXfWBdX56W5UXcP7TaYBylknQKsr4Ndbt7VQEA1uUdps0GkI1iA/jV9VSOg48evwOWvTq2UAp0UzFOnkXInCv6QzuC0/fAaihuCocAEvfEqmEhUJmL+3J3DuNuVSDoLXbz164v7/kMWigIy+fke9d2vlSEy4GNX/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728664196; c=relaxed/simple;
	bh=OHfpANVKIkXv9Qk/1cy7qsMazgVUChxy23FTwYhATI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TxDZ1t712xgD8JzZXW0Zd9m221xpJvJ6E9eKRqAmxiV9G0EVHRv/b73u7sNxcB4f/rukG/5PsKMf+Md6gJ6ICHOReFO8WeLZctAnKInfNztFpLLkgUg3O/MBnMLR/dOP84lOQcb7lHwRE+mhlbK3iFtRgMssSkAb+vZCKkzJG2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4XQBt84GpQz9sPd;
	Fri, 11 Oct 2024 18:29:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4qjGBmMA-A0S; Fri, 11 Oct 2024 18:29:52 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4XQBt831N1z9rvV;
	Fri, 11 Oct 2024 18:29:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 4E3668B7AD;
	Fri, 11 Oct 2024 18:29:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id heUADXsmncDT; Fri, 11 Oct 2024 18:29:52 +0200 (CEST)
Received: from [192.168.232.203] (unknown [192.168.232.203])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id AF6E68B79E;
	Fri, 11 Oct 2024 18:29:50 +0200 (CEST)
Message-ID: <600a11af-cf42-45d9-9be8-b7066d90c89f@csgroup.eu>
Date: Fri, 11 Oct 2024 18:29:49 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] lib: Move KUnit tests into tests/ subdirectory
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andy Shevchenko <andy@kernel.org>, David Gow <davidgow@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Brendan Higgins <brendanhiggins@google.com>, Rae Moar <rmoar@google.com>,
 Kees Cook <kees@kernel.org>, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
 Stephen Rothwell <sfr@canb.auug.org.au>, Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 "Jason A . Donenfeld" <Jason@zx2c4.com>,
 "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
 Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
 "David S . Miller" <davem@davemloft.net>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Brown <broonie@kernel.org>,
 linux-hardening@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Palmer Dabbelt <palmer@rivosinc.com>, Charlie Jenkins
 <charlie@rivosinc.com>, Simon Horman <horms@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Daniel Latypov <dlatypov@google.com>, Guenter Roeck <linux@roeck-us.net>,
 David Howells <dhowells@redhat.com>, =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?=
 <mic@digikod.net>, Marco Elver <elver@google.com>,
 Mark Rutland <mark.rutland@arm.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Vlastimil Babka <vbabka@suse.cz>, Nathan Chancellor <nathan@kernel.org>,
 Fangrui Song <maskray@google.com>,
 "Steven Rostedt (Google)" <rostedt@goodmis.org>
References: <20241011072509.3068328-2-davidgow@google.com>
 <20241011072509.3068328-5-davidgow@google.com>
 <ZwkBgkthcQM7rLl7@smile.fi.intel.com>
 <CAMuHMdW=MF0H8YVuY6moLomTaxFEeCHgut1fruRGEkn79sbuTA@mail.gmail.com>
 <ZwkuvKogPuik90fN@smile.fi.intel.com>
 <CAMuHMdU_1oZEeJ5Onrbtx-iZjrK_bQ6YWNMdRYp-E1_5E7rMSQ@mail.gmail.com>
 <CAHp75Vecwe_LaSKSprwfrdpDhoJbXgajQUVY23L+VyGoxtGH7A@mail.gmail.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <CAHp75Vecwe_LaSKSprwfrdpDhoJbXgajQUVY23L+VyGoxtGH7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 11/10/2024 à 17:21, Andy Shevchenko a écrit :
> [Vous ne recevez pas souvent de courriers de andy.shevchenko@gmail.com. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
> 
> On Fri, Oct 11, 2024 at 5:20 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> On Fri, Oct 11, 2024 at 3:57 PM Andy Shevchenko <andy@kernel.org> wrote:
>>> On Fri, Oct 11, 2024 at 03:38:00PM +0200, Geert Uytterhoeven wrote:
>>>> On Fri, Oct 11, 2024 at 12:44 PM Andy Shevchenko <andy@kernel.org> wrote:
>>>>> On Fri, Oct 11, 2024 at 03:25:07PM +0800, David Gow wrote:
> 
> ...
> 
>>>>>>   rename lib/{ => tests}/bitfield_kunit.c (100%)
>>>>>>   rename lib/{ => tests}/checksum_kunit.c (100%)
>>>>>>   rename lib/{ => tests}/cmdline_kunit.c (100%)
>>>>>>   rename lib/{ => tests}/cpumask_kunit.c (100%)
>>>>>>   rename lib/{ => tests}/fortify_kunit.c (100%)
>>>>>>   rename lib/{ => tests}/hashtable_test.c (100%)
>>>>>>   rename lib/{ => tests}/is_signed_type_kunit.c (100%)
>>>>>>   rename lib/{ => tests}/kunit_iov_iter.c (100%)
>>>>>>   rename lib/{ => tests}/list-test.c (100%)
>>>>>>   rename lib/{ => tests}/memcpy_kunit.c (100%)
>>>>>>   rename lib/{ => tests}/overflow_kunit.c (100%)
>>>>>>   rename lib/{ => tests}/siphash_kunit.c (100%)
>>>>>>   rename lib/{ => tests}/slub_kunit.c (100%)
>>>>>>   rename lib/{ => tests}/stackinit_kunit.c (100%)
>>>>>>   rename lib/{ => tests}/string_helpers_kunit.c (100%)
>>>>>>   rename lib/{ => tests}/string_kunit.c (100%)
>>>>>>   rename lib/{ => tests}/test_bits.c (100%)
>>>>>>   rename lib/{ => tests}/test_fprobe.c (100%)
>>>>>>   rename lib/{ => tests}/test_hash.c (100%)
>>>>>>   rename lib/{ => tests}/test_kprobes.c (100%)
>>>>>>   rename lib/{ => tests}/test_linear_ranges.c (100%)
>>>>>>   rename lib/{ => tests}/test_list_sort.c (100%)
>>>>>>   rename lib/{ => tests}/test_sort.c (100%)
>>>>>>   rename lib/{ => tests}/usercopy_kunit.c (100%)
>>>>>
>>>>> While I support the idea, I think this adds an additional churn in creating a
>>>>> duplicate 'test' in the filenames. Why they all can't be cut while removing?
>>>>> (at least this question is not answered in the commit message)
>>>>
>>>> To avoid duplicate *.ko file names?
>>>
>>> With what? Sorry, but I don't see how it's a problem. These are test cases.
>>> Do they use kernel command line parameters? If so, shouldn't KUnit take care
>>> about it in a more proper way?
>>
>> If .e.g. lib/list_sort.o could be modular, its module would be called
>> "list_sort.ko", conflicting with the "list_sort.ko" test module.

But as it is now in lib/tests/, the module will also be installed in 
tests/ subdir, so it shouldn't clash anymore ?

You'd have:

/lib/modules/lib/list_sort.ko and
/lib/modules/lib/tests/list_sort.ko

Or did I miss something ?
> 
> Can't this be solved by automatically adding a prefix in Makefile for
> kunit tests, for example?
> 
> --
> With Best Regards,
> Andy Shevchenko

