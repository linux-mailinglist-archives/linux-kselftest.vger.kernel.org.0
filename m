Return-Path: <linux-kselftest+bounces-26340-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5BCAA30600
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 09:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 933613A1C46
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 08:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1BC1F03DC;
	Tue, 11 Feb 2025 08:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Ha2SiXrw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77BD1F03D1
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Feb 2025 08:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739263261; cv=none; b=n72gM/YRBPrQdO7RajUIH99+rdAsFVGwyqd863WgN74DqjgEgwiW5USez+eW3Vk2VSbzbGrDCZBSAcj2FofGJG0LZY/OexMwVKuu6POsuV1GFExi4lQBlfDyZDSH00i9amMqEzC6Wp7dlN9Od0U1YqZS9SD5TWoOPKuEKoXgd4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739263261; c=relaxed/simple;
	bh=yTNF8m8nxCuxx0EDRShPHz3vJ87Lnbule4bfgDMTId0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JoRnqGUULC6Jl5vEY6+cgnkLtFwcbu7sFl44e9bI94dpyebC10bBA2btdFVLraes+HFQp4heBcTMW8/IrxSrgeBEH04DF6DpyZrduFyA1qxB6nKtSyLzdJvmlBFywRcUelv+txkB0MINCxo1AH0/NcKStt/H8LMWSRm6qpp7RpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk; spf=pass smtp.mailfrom=rasmusvillemoes.dk; dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b=Ha2SiXrw; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rasmusvillemoes.dk
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-308ee953553so19433861fa.0
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Feb 2025 00:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1739263258; x=1739868058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yTNF8m8nxCuxx0EDRShPHz3vJ87Lnbule4bfgDMTId0=;
        b=Ha2SiXrwCKdP9UpWEjOfHcWOjFhy2mbiNqjjBRH1srQUQahhdPi8EMPrg2bMHXs72q
         2srxHPYV0/26AWbs0028Kb7R4w142UIFGYbBpdGF2FEt+VJ3E6Ng594IsDJRvopOm5Ai
         tnEHlDb0duUtjeXyFseaMg6+aAOzOdFjmc+ds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739263258; x=1739868058;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yTNF8m8nxCuxx0EDRShPHz3vJ87Lnbule4bfgDMTId0=;
        b=O3R+qAG/d29xINQulYzkobLok73rPGXutUhp0pk1MuaYmPBFOVPaKcy+eNXRPCQ4kS
         6e+NQUQ71cY7Kp8NKVbZGFG/EH/0jgZEspKSC2z0ACURGmoglUtcpYzMMLtfXaoI+ryB
         hdP8uY2sV9HIPN5NCwzNdC4DgQ65hYtiV+6dHHRm99Qu8nh5lARfIGjwVUKj0+I9cc06
         fduLDLwq8weCJvpILTrvg0gY19QImuACo5BAbrcb3Z2e91ykkUtjgLySqfdkK3G/kfia
         Ed2s8mI4BoCFu5ri7zcK655JEhWrvHRlf3CBPvTeg7i+Yv2uxgPE/aINWOQi1tlVR0wS
         +EJA==
X-Forwarded-Encrypted: i=1; AJvYcCW+Bp6GG5MXHVf9X2HGYLl9EmRBXEeGFkWe+CFIizGsJ+3RozOkfXi3QpCzxwuL64s6V5G2kQBfiowvP20//kI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx374Lh1jyaYoFDB0e7M6vB2RKTmQFlfOG/cvjGKDqVew80H2jM
	bfhZLlAjUHxAvC/ITgYoHdNP7CXHYq52aFZwEHIb8tLLZauYUsKcf/ZRU0T0K4E=
X-Gm-Gg: ASbGncuz37VCCd8djjc+24DHv99kO7Dy7jC9er+/IfsZfn9WGN6Hh/Hy12z74zLkvK4
	HfNCURnrN5Y1oLUdsaK9Y9nBJdcU9Yc7nhhk6uIKqfYlNqFvJoXHaJRpQftopLZCVMq4504GR+Q
	29gAmmisCq3OuAh6+F8+c/K6qNOXMCjt8vL17Tz71FGhF12ExgUaebykNgi0Gxrdyz8fKyeUtsV
	a4IXgz4Ryqfk/tNRcm00LaKA/PqOYDdZDCf+8SNYgTkgZIZN2xqt8T5OgTiG2QUvxFbN1WsuzSi
	DWsGpHsQOzVfHrGV
X-Google-Smtp-Source: AGHT+IFyuHwShqGtWI3e6boWfgOJuS5V2vIC04DXs22kugVv1qWaggSk2GonF+yQmxK+lPWqPHvn5Q==
X-Received: by 2002:a05:651c:220a:b0:308:f455:1f93 with SMTP id 38308e7fff4ca-308f455212amr16700741fa.27.1739263257028;
        Tue, 11 Feb 2025 00:40:57 -0800 (PST)
Received: from localhost ([81.216.59.226])
        by smtp.gmail.com with UTF8SMTPSA id 38308e7fff4ca-308f84c278fsm2009051fa.23.2025.02.11.00.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 00:40:56 -0800 (PST)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: David Gow <davidgow@google.com>
Cc: Tamir Duberstein <tamird@gmail.com>,  Petr Mladek <pmladek@suse.com>,
  Steven Rostedt <rostedt@goodmis.org>,  Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>,  Sergey Senozhatsky
 <senozhatsky@chromium.org>,  Andrew Morton <akpm@linux-foundation.org>,
  Shuah Khan <shuah@kernel.org>,  linux-kernel@vger.kernel.org,
  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 0/2] printf: convert self-test to KUnit
In-Reply-To: <CABVgOS=dfuX+X8=EVHcrCZnbOZj3T+wGD922eoeHb-dcOmmzXw@mail.gmail.com>
	(David Gow's message of "Tue, 11 Feb 2025 15:15:34 +0800")
References: <20250204-printf-kunit-convert-v1-0-ecf1b846a4de@gmail.com>
	<CAKwiHFi6SUCT7UjUTdKmLJ8kiAEqVg=d6ND60R05MJB85Eoj9w@mail.gmail.com>
	<CAJ-ks9kLmArqqPati8n0dwzhjccLmTuTHtkaSyf_F_1QXzCoRw@mail.gmail.com>
	<87bjvers3u.fsf@prevas.dk>
	<CAJ-ks9=0+fk22Dx-65a+CSYhy0dnjTJuot9PtgOCi5Th1_wARA@mail.gmail.com>
	<87y0yeqafu.fsf@prevas.dk>
	<CABVgOS=dfuX+X8=EVHcrCZnbOZj3T+wGD922eoeHb-dcOmmzXw@mail.gmail.com>
Date: Tue, 11 Feb 2025 09:40:55 +0100
Message-ID: <87h650ri08.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11 2025, David Gow <davidgow@google.com> wrote:

> On Mon, 10 Feb 2025 at 19:57, Rasmus Villemoes <linux@rasmusvillemoes.dk>=
 wrote:
>>
>> On Fri, Feb 07 2025, Tamir Duberstein <tamird@gmail.com> wrote:
>>
>> > On Fri, Feb 7, 2025 at 5:01=E2=80=AFAM Rasmus Villemoes
>> > <linux@rasmusvillemoes.dk> wrote:
>> >>
>> >> On Thu, Feb 06 2025, Tamir Duberstein <tamird@gmail.com> wrote:
>> >>
>> >>
>> >> I'll have to see the actual code, of course. In general, I find readi=
ng
>> >> code using those KUNIT macros quite hard, because I'm not familiar wi=
th
>> >> those macros and when I try to look up what they do they turn out to =
be
>> >> defined in terms of other KUNIT macros 10 levels deep.
>> >>
>> >> But that still leaves a few points. First, I really like that "388 te=
st
>> >> cases passed" tally or some other free-form summary (so that I can see
>> >> that I properly hooked up, compiled, and ran a new testcase inside
>> >> test_number(), so any kind of aggregation on those top-level test_* is
>> >> too coarse).
>> >
>> > This one I'm not sure how to address. What you're calling test cases
>> > here would typically be referred to as assertions, and I'm not aware
>> > of a way to report a count of assertions.
>> >
>>
>> I'm not sure that's accurate.
>>
>> The thing is, each of the current test() instances results in four
>> different tests being done, which is roughly why we end up at the 4*97
>> =3D=3D 388, but each of those tests has several assertions being done -
>> depending on which variant of the test we're doing (i.e. the buffer
>> length used or if we're passing it through kasprintf), we may do only
>> some of those assertions, and we do an early return in case one of those
>> assertions fail (because it wouldn't be safe to do the following
>> assertions, and the test as such has failed already). So there are far
>> more assertions than those 388.
>>
>> OTOH, that the number reported is 388 is more a consequence of the
>> implementation than anything explicitly designed. I can certainly live
>> with 388 being replaced by 97, i.e. that each current test() invocation
>> would count as one KUNIT case, as that would still allow me to detect a
>> PEBKAC when I've added a new test() instance and failed to actually run
>> that.
>
> It'd be possible to split things up further into tests, at the cost of
> it being a more extensive refactoring, if having the more granular
> count tracked by KUnit were desired.

I think the problem is that kunit is simply not a good framework to do
these kinds of tests in, and certainly it's very hard to retrofit kunit
after the fact.

It'd also be possible to make
> these more explicitly data driven via a parameterised test (so each
> input/output pair is listed in an array, and automatically gets
> converted to a KUnit subtest).

So that "array of input/output" very much doesn't work for these
specific tests: We really want the format string/varargs to be checked
by the compiler, and besides, there's no way to store the necessary
varargs and generate a call from those in an array. Moreover, we verify a
lot more than just that the correct string is produced; it's also a
matter of the right return value regardless of the passed buffer size, etc.

That's also why is nigh impossible to simply change __test() into
(another) macro that expands to something that defines an individual
struct kunit_case, because the framework is really built around the
notion that each case can be represented by a void function call and the
name of the test is the stringification of the function name.=20

So I don't mind the conversion to kunit if that really helps other
people, as long as the basic functionality is still present and doesn't
impede future extensions - and certainly I don't want to end up in a
situation where somebody adds a new %p extension but cannot really add a
test for it because kunit makes that hard.

But I hope you all agree that it doesn't make much _sense_ to consider
test_number() and test_string() and so on individual "test cases"; the
atomic units of test being done in the printf suite is each invocation
of the __test() function, with one specific format string/varargs
combination.

Rasmus

