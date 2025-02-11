Return-Path: <linux-kselftest+bounces-26334-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26395A30442
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 08:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8F573A468E
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 07:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496D01E5B99;
	Tue, 11 Feb 2025 07:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TKr+Wf2D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C51D1D63F7
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Feb 2025 07:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739258150; cv=none; b=Z7QoFUqs++kmN9scfgWA3y3Czh4gEssfY8KT3t+IrOJ2c+roSNiO1QGiluxVqOvt4oTAD3bKcEEVvBwIqYrhEOxlkHuy/6bpFT++qbMCyW3joqvy3HNwxBTRIfxpVaCR+KcVC92+UI7lhpics1WeH5xaRLU5Ea2BJ89JiWum3s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739258150; c=relaxed/simple;
	bh=SSilTBShatx+gqn7S53dXX+DQxFqAw0WL38O4+9ZG3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TPcWsHKQsjDO1LjpBO1Z8BbrJhUvfd1stUU6tcWPhcHWruQ11uZHJgLrq9+zEWowrdMckOPED+gArvb4WOhoDIITrWVd2jUEZUeHEZKSb5eKDCznBRX3lI+T2+AhDsaxrApGNE2Zji5GE6xkzpcs6HDfcEIVi734w5+EAiD5OpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TKr+Wf2D; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6e4562aa221so24147526d6.0
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2025 23:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739258147; x=1739862947; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A6+NLKUHjhWKcCKiOYwjTp0H4EPbaiT0+frTtiH+oDE=;
        b=TKr+Wf2DSvvEbIFqJHYce7g+l32SRMG7ywXYU1kFRHICAbiZp388kpSlzK6UWtUaPX
         kBTe7/NxuA7uKW6Ah21UXCiwopYe1T4kw+l5SmpUoDcljPjhvgAhs9Xrb/iEmRNAclJH
         EP6a8hAMXTXsS22bvhskunozWAWM05LT+NE7MKNNgkNEuV13Gp/8IX+otMsXlH58NBLM
         mz4ayTlDGbKmR3LF2XPHwwGifvFFfUQdOyoO+kTGh7aLejeTeOWT3rtTEgNAy6Fi5TX7
         2xw0i6PN6zb/I4D59HsjQTR3RZomEahgw8TxAQCZRYpc1xrEbxTZAFjWwg+3yDeiEiIE
         flxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739258147; x=1739862947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A6+NLKUHjhWKcCKiOYwjTp0H4EPbaiT0+frTtiH+oDE=;
        b=CcwxWZGvhTM5ZZ0I568Q3tWe+Cfwh7hpmwuEtRDJdLMzT154ldq7EwbQyNVS++0FIS
         wnjN+HiBOIbyxu7XOMD+XrTm3dVzAILUivyxy6HHYTy90efUzvSAqoVNP4qrmQiwfjLY
         tbaT26XAlvOBHbUS5CS/iSmpNki9TOIXIef7fxSVrG9bp9v/RyGI9L+0jSRFRLojrpsr
         V4uj4lQZOfpe537iwnFj92HzLBzQrd2btoJEPcaDKeaIo7C3o50QuiOsy/+J1rDq04xX
         rr8smwC7Dy/Njr6RmMqqt13O1QxpbmX++o8tApzdxXWrZDsXXaD2ERFKqmwXW2O4oED6
         hlQw==
X-Forwarded-Encrypted: i=1; AJvYcCUD7BnHG5DQoKrVm4HkP300mpDueQv3ZWiEeTTZyQySEuJG0psz8mk1JTy4xtzMF6Bk10AfCRb21LGqx7IrGSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQxsa+2vsCkdNhQJpsLP8rW5JAinJ2GT/knAcxFPXYI9cEdclS
	m4PxYw2h8iYjvv1vhBQbjZte/70HnC0KPfWdEYQRRF5ipgVkG3IQf4dsCw8/3xV0l/bgHBiw6fR
	t4lXSGArVXdnKZw7cs+dr5VS5N948vEV5Ywyb
X-Gm-Gg: ASbGnct7oyx95X1sxqezdmhn/HLQMo0/V2lfeyqqAlmjN2vYkupRKo+xRNGEpcG6URu
	Gb6IBgm+41/HPuP7ZJ9c/Is6gaFYg+Gftvlzc/zB+rbuiNtG/uP4ZP/sG3upqsUAduKsom0Ha0g
	==
X-Google-Smtp-Source: AGHT+IFjYoBHrtkat2BCcmUPpGCzIFhn/zTtCmln4y67FtXSVX3nZN4yviR4RarufYoUxGKywmZdB0KhmnJ3dZzCvbY=
X-Received: by 2002:a05:6214:19e7:b0:6d8:9677:fbe4 with SMTP id
 6a1803df08f44-6e4455c1f1cmr264222716d6.9.1739258147163; Mon, 10 Feb 2025
 23:15:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204-printf-kunit-convert-v1-0-ecf1b846a4de@gmail.com>
 <CAKwiHFi6SUCT7UjUTdKmLJ8kiAEqVg=d6ND60R05MJB85Eoj9w@mail.gmail.com>
 <CAJ-ks9kLmArqqPati8n0dwzhjccLmTuTHtkaSyf_F_1QXzCoRw@mail.gmail.com>
 <87bjvers3u.fsf@prevas.dk> <CAJ-ks9=0+fk22Dx-65a+CSYhy0dnjTJuot9PtgOCi5Th1_wARA@mail.gmail.com>
 <87y0yeqafu.fsf@prevas.dk>
In-Reply-To: <87y0yeqafu.fsf@prevas.dk>
From: David Gow <davidgow@google.com>
Date: Tue, 11 Feb 2025 15:15:34 +0800
X-Gm-Features: AWEUYZk57aGzCpg0ncZNMfxynXMpt9j9kKVywVIGZj8TfPmjcfyrHVNQ047Ex_s
Message-ID: <CABVgOS=dfuX+X8=EVHcrCZnbOZj3T+wGD922eoeHb-dcOmmzXw@mail.gmail.com>
Subject: Re: [PATCH 0/2] printf: convert self-test to KUnit
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Tamir Duberstein <tamird@gmail.com>, Petr Mladek <pmladek@suse.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 10 Feb 2025 at 19:57, Rasmus Villemoes <linux@rasmusvillemoes.dk> w=
rote:
>
> On Fri, Feb 07 2025, Tamir Duberstein <tamird@gmail.com> wrote:
>
> > On Fri, Feb 7, 2025 at 5:01=E2=80=AFAM Rasmus Villemoes
> > <linux@rasmusvillemoes.dk> wrote:
> >>
> >> On Thu, Feb 06 2025, Tamir Duberstein <tamird@gmail.com> wrote:
> >>
> >>
> >> I'll have to see the actual code, of course. In general, I find readin=
g
> >> code using those KUNIT macros quite hard, because I'm not familiar wit=
h
> >> those macros and when I try to look up what they do they turn out to b=
e
> >> defined in terms of other KUNIT macros 10 levels deep.
> >>
> >> But that still leaves a few points. First, I really like that "388 tes=
t
> >> cases passed" tally or some other free-form summary (so that I can see
> >> that I properly hooked up, compiled, and ran a new testcase inside
> >> test_number(), so any kind of aggregation on those top-level test_* is
> >> too coarse).
> >
> > This one I'm not sure how to address. What you're calling test cases
> > here would typically be referred to as assertions, and I'm not aware
> > of a way to report a count of assertions.
> >
>
> I'm not sure that's accurate.
>
> The thing is, each of the current test() instances results in four
> different tests being done, which is roughly why we end up at the 4*97
> =3D=3D 388, but each of those tests has several assertions being done -
> depending on which variant of the test we're doing (i.e. the buffer
> length used or if we're passing it through kasprintf), we may do only
> some of those assertions, and we do an early return in case one of those
> assertions fail (because it wouldn't be safe to do the following
> assertions, and the test as such has failed already). So there are far
> more assertions than those 388.
>
> OTOH, that the number reported is 388 is more a consequence of the
> implementation than anything explicitly designed. I can certainly live
> with 388 being replaced by 97, i.e. that each current test() invocation
> would count as one KUNIT case, as that would still allow me to detect a
> PEBKAC when I've added a new test() instance and failed to actually run
> that.

It'd be possible to split things up further into tests, at the cost of
it being a more extensive refactoring, if having the more granular
count tracked by KUnit were desired. It'd also be possible to make
these more explicitly data driven via a parameterised test (so each
input/output pair is listed in an array, and automatically gets
converted to a KUnit subtest).

There are some advantages to having these counts done by the
framework, particularly in that any inconsistencies can be picked up
by the tooling. Ultimately, though, it's up to you as to what is most
useful.

> >> The other thing I want to know is if this would make it harder for me =
to
> >> finish up that "deterministic random testing" thing I wrote [*], but
> >> never got around to actually get it upstream. It seems like something
> >> that a framework like kunit could usefully provide out-of-the-box (whi=
ch
> >> is why I attempted to get it into kselftest), but as long as I'd still
> >> be able to add in something like that, and get a "xxx failed, random
> >> seed used was 0xabcdef" line printed, and run the test again setting t=
he
> >> seed explicitly to that 0xabcdef value, I'm good.
> >>
> >> [*] https://lore.kernel.org/lkml/20201025214842.5924-4-linux@rasmusvil=
lemoes.dk/
> >
> > I can't speak for the framework, but it wouldn't be any harder to do
> > in printf itself. I did it this way:
> >
> > +static struct rnd_state rnd_state;
> > +static u64 seed;
> > +
> >  static int printf_suite_init(struct kunit_suite *suite)
> >  {
> >   alloced_buffer =3D kmalloc(BUF_SIZE + 2*PAD_SIZE, GFP_KERNEL);
> >   if (!alloced_buffer)
> >   return -1;
> >   test_buffer =3D alloced_buffer + PAD_SIZE;
> > +
> > + seed =3D get_random_u64();
> > + prandom_seed_state(&rnd_state, seed);
> >   return 0;
> >  }
> >
> >  static void printf_suite_exit(struct kunit_suite *suite)
> >  {
> >   kfree(alloced_buffer);
> > + if (kunit_suite_has_succeeded(suite) =3D=3D KUNIT_FAILURE) {
> > + pr_info("Seed: %llu\n", seed);
> > + }
> >  }
> >
> > and the result (once I made one of the cases fail):
> >
> > printf_kunit: Seed: 11480747578984087668
> > # printf: pass:27 fail:1 skip:0 total:28
> > # Totals: pass:27 fail:1 skip:0 total:28
> > not ok 1 printf
> >
>
> OK, that's good. I think one of the problems previously was that there
> no longer was such an _init/_exit pair one could hook into to do the
> seed logic and afterwards do something depending on the success/fail of
> the whole thing; that was all hidden away by some KUNIT_ wrapping.

Yeah, KUnit has since added the suite_init/suite_exit functions in
order to do this sort of thing. Previously we had an _init/_exit pair,
but it was run per-test-case, which doesn't work as well here.

>
> Is it still possible to trivially make that seed into a module
> parameter, and do the "modprobe test_printf seed=3D0xabcd", or otherwise
> inject a module parameter when run/loaded via the kunit framework?

It should be just the same as any other module. As mentioned, one day
I'd like to standardise this in KUnit so that we can have this also
change the test execution order and fit in with tooling, but I'd
definitely support doing this via an ad-hoc parameter in the meantime.

Cheers,
-- David

