Return-Path: <linux-kselftest+bounces-26158-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1181A2EC08
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 12:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F70C167678
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 11:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DFC1F8904;
	Mon, 10 Feb 2025 11:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="F7+2ktOD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102741F560B
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2025 11:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739188651; cv=none; b=Px853CVs01C62/OXBt34klocPlRGj24NAKpJY4Ly86gScTsCSn01N84PRMiOJWkGc6dwNYnsbA+sVRKoAkEMLud1WiDvwVZ85O3JaVDwCTN2WIf9j5Dvv3F+/9JwHNSqf3yOsYCqfBAcgsS+m2BIJH6ONAN49LfyyhOAr47TUkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739188651; c=relaxed/simple;
	bh=oMySDRJ1QcW10QlgKdMX24iySk7iQTg/ty46AMQU2Vw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PwFA/3CyMaR89I/bP/E6DpiUDuzGTyDNyvM5jp7Nf9TuQUL2okyLecbTZccucMSIKPQacXB2mSX7E7t8fEtW+j1ugM8UBQvFfqoJtXi6GU8gTOoceGgfVGUlvHOMXgYPUyYUwlVhO8HL4uGNpmFU3OZy/VYnon/DtA3BGjOgZ2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk; spf=pass smtp.mailfrom=rasmusvillemoes.dk; dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b=F7+2ktOD; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rasmusvillemoes.dk
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5450abbdce0so1078758e87.3
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2025 03:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1739188647; x=1739793447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LgAZGxaGXXHdg9p2e7i/rWupwIQDPEMecy8bcT/VaIY=;
        b=F7+2ktODYWh+9rzrBmcQt5K0moRT9dyLhFQmboE7g5EIo5CMtQld6lzPMZjN9SJw+n
         d/V4PYyY2hpzl8Btjs+9anZA/cfSy1VoOx5vCsU0D2ht0xyogP5gD6qMmfJ5rTjSNeZK
         cqA044HgAfXZcN6MH7+RlFGu/OaZFyM7tPwek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739188647; x=1739793447;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LgAZGxaGXXHdg9p2e7i/rWupwIQDPEMecy8bcT/VaIY=;
        b=D+FmuRDGozOJAVV97kxiEk7i3CyOeRrsfeYA9dDdtQ5ANPe6C+oGpnCzZpUW67S7A7
         gjz4gue71NqqdqQs0NhV5zTsDmST6nZf+P2w/IRA/eTOTOUZunTaUi01KE6rASmvX34O
         2HpQW9eka+TiQS8cB8wcdQfnd8NkBN1AvkHndjPHyewNAuQ/4PevuGHnEMTIIxzEH1HV
         6X3hv+uxMPJTnCHY5YUKu1wRR2h5QgE3Ao+Nm8HLeX2sW1TQ9jmKkxgDFyBrYU8fZzTY
         /XmzT9jRCLgvUWjznrUB19pvJpGQVXz/pI0jIUgq7g7j1tIZoZV5VE9mQ3mGSIr7ZNZY
         FQPg==
X-Forwarded-Encrypted: i=1; AJvYcCXy+tOUSxOph96GbIMbGWbFb/q8Adm9GsoMBs/8AmykFxG7B7nFrNP/uWUMZhCBX/UVE1d+L0nXdWQS5YDQpN0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/TebK8WB5bk9KJBuFBmbJbSjjm2lUqMln9Y5Ox4tR4VZByxkt
	gwAtNPlIpRbkjuhtsaFTSFbI8EN52JO5nuJd2redv6EDFezQ4UfDJtyzd2a5VP+evZGpFiuAJ7B
	7VrY=
X-Gm-Gg: ASbGncuXHeOUWygR2DsdIFGFwDhXwzNGgSIa28NvvVOOiczDtXsIDqpSRs0oo+ImvNu
	ZLGIzyunhxzEcAkOFY0oh+2rXerVkbbgmkKqZX1n4m1gGx/u/X7/B8M2roUAtA8YCXr3anTjkY1
	me2F1yaL/8Uma9EqVbvW6gbLb1SUXx6dhHslydd9s6BfEagodDej96BPX4Y/NXdkUQvWj41wh8c
	QjdNQcb2DyOgkauv5XlJRZbcnOTS5nohslq6Z1G/Y4onw9uWfk6eBpMclYGaZCl7wPMrY0/Vi0R
	WWcnM/p/LwaIe8WP
X-Google-Smtp-Source: AGHT+IH+7FONk/VJFEpkU60nbg63IQFPnZ85ky0jleZfgFgfCz78Hw77TLpcoEYvC1YKyflH95Q44w==
X-Received: by 2002:ac2:4a7a:0:b0:545:441:52d2 with SMTP id 2adb3069b0e04-5450441541fmr2265850e87.23.1739188646839;
        Mon, 10 Feb 2025 03:57:26 -0800 (PST)
Received: from localhost ([81.216.59.226])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-54410555884sm1228761e87.102.2025.02.10.03.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 03:57:26 -0800 (PST)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Tamir Duberstein <tamird@gmail.com>
Cc: David Gow <davidgow@google.com>,  Petr Mladek <pmladek@suse.com>,
  Steven Rostedt <rostedt@goodmis.org>,  Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>,  Sergey Senozhatsky
 <senozhatsky@chromium.org>,  Andrew Morton <akpm@linux-foundation.org>,
  Shuah Khan <shuah@kernel.org>,  linux-kernel@vger.kernel.org,
  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 0/2] printf: convert self-test to KUnit
In-Reply-To: <CAJ-ks9=0+fk22Dx-65a+CSYhy0dnjTJuot9PtgOCi5Th1_wARA@mail.gmail.com>
	(Tamir Duberstein's message of "Fri, 7 Feb 2025 06:27:57 -0500")
References: <20250204-printf-kunit-convert-v1-0-ecf1b846a4de@gmail.com>
	<CAKwiHFi6SUCT7UjUTdKmLJ8kiAEqVg=d6ND60R05MJB85Eoj9w@mail.gmail.com>
	<CAJ-ks9kLmArqqPati8n0dwzhjccLmTuTHtkaSyf_F_1QXzCoRw@mail.gmail.com>
	<87bjvers3u.fsf@prevas.dk>
	<CAJ-ks9=0+fk22Dx-65a+CSYhy0dnjTJuot9PtgOCi5Th1_wARA@mail.gmail.com>
Date: Mon, 10 Feb 2025 12:57:25 +0100
Message-ID: <87y0yeqafu.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 07 2025, Tamir Duberstein <tamird@gmail.com> wrote:

> On Fri, Feb 7, 2025 at 5:01=E2=80=AFAM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
>>
>> On Thu, Feb 06 2025, Tamir Duberstein <tamird@gmail.com> wrote:
>>
>>
>> I'll have to see the actual code, of course. In general, I find reading
>> code using those KUNIT macros quite hard, because I'm not familiar with
>> those macros and when I try to look up what they do they turn out to be
>> defined in terms of other KUNIT macros 10 levels deep.
>>
>> But that still leaves a few points. First, I really like that "388 test
>> cases passed" tally or some other free-form summary (so that I can see
>> that I properly hooked up, compiled, and ran a new testcase inside
>> test_number(), so any kind of aggregation on those top-level test_* is
>> too coarse).
>
> This one I'm not sure how to address. What you're calling test cases
> here would typically be referred to as assertions, and I'm not aware
> of a way to report a count of assertions.
>

I'm not sure that's accurate.

The thing is, each of the current test() instances results in four
different tests being done, which is roughly why we end up at the 4*97
=3D=3D 388, but each of those tests has several assertions being done -
depending on which variant of the test we're doing (i.e. the buffer
length used or if we're passing it through kasprintf), we may do only
some of those assertions, and we do an early return in case one of those
assertions fail (because it wouldn't be safe to do the following
assertions, and the test as such has failed already). So there are far
more assertions than those 388.

OTOH, that the number reported is 388 is more a consequence of the
implementation than anything explicitly designed. I can certainly live
with 388 being replaced by 97, i.e. that each current test() invocation
would count as one KUNIT case, as that would still allow me to detect a
PEBKAC when I've added a new test() instance and failed to actually run
that.

>> The other thing I want to know is if this would make it harder for me to
>> finish up that "deterministic random testing" thing I wrote [*], but
>> never got around to actually get it upstream. It seems like something
>> that a framework like kunit could usefully provide out-of-the-box (which
>> is why I attempted to get it into kselftest), but as long as I'd still
>> be able to add in something like that, and get a "xxx failed, random
>> seed used was 0xabcdef" line printed, and run the test again setting the
>> seed explicitly to that 0xabcdef value, I'm good.
>>
>> [*] https://lore.kernel.org/lkml/20201025214842.5924-4-linux@rasmusville=
moes.dk/
>
> I can't speak for the framework, but it wouldn't be any harder to do
> in printf itself. I did it this way:
>
> +static struct rnd_state rnd_state;
> +static u64 seed;
> +
>  static int printf_suite_init(struct kunit_suite *suite)
>  {
>   alloced_buffer =3D kmalloc(BUF_SIZE + 2*PAD_SIZE, GFP_KERNEL);
>   if (!alloced_buffer)
>   return -1;
>   test_buffer =3D alloced_buffer + PAD_SIZE;
> +
> + seed =3D get_random_u64();
> + prandom_seed_state(&rnd_state, seed);
>   return 0;
>  }
>
>  static void printf_suite_exit(struct kunit_suite *suite)
>  {
>   kfree(alloced_buffer);
> + if (kunit_suite_has_succeeded(suite) =3D=3D KUNIT_FAILURE) {
> + pr_info("Seed: %llu\n", seed);
> + }
>  }
>
> and the result (once I made one of the cases fail):
>
> printf_kunit: Seed: 11480747578984087668
> # printf: pass:27 fail:1 skip:0 total:28
> # Totals: pass:27 fail:1 skip:0 total:28
> not ok 1 printf
>

OK, that's good. I think one of the problems previously was that there
no longer was such an _init/_exit pair one could hook into to do the
seed logic and afterwards do something depending on the success/fail of
the whole thing; that was all hidden away by some KUNIT_ wrapping.

Is it still possible to trivially make that seed into a module
parameter, and do the "modprobe test_printf seed=3D0xabcd", or otherwise
inject a module parameter when run/loaded via the kunit framework?

Rasmus

