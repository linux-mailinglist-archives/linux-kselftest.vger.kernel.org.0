Return-Path: <linux-kselftest+bounces-25987-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C26A2C176
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 12:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C8241885599
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 11:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407B71DD0D5;
	Fri,  7 Feb 2025 11:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTwTNHuf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE9E63D;
	Fri,  7 Feb 2025 11:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738927718; cv=none; b=WcqYTFRIuoUwZmwKgsQ3/hL9+PRw/V84tfHuNW7GO6gbgrrlhSQgpb0JFBdLkZZRjzfHg7IC1seR6/CEfp743x5ZTYEYqhq16AKN9UGUZoNNscsIql1/9LJEMopvd88aAGf51aTpREFnNeiKO0vWOYpf8AHA13Z0X6F8kVa4UVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738927718; c=relaxed/simple;
	bh=CCZWa//gwdWtWgJNyXo15ebnvf4IYQUw2JPsdrxDlcM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uuolMMo7wt5j24LY3OMekaV1LgwlONhBxqASdIYC0jkKw/p/kRQHafhEVIawJvQgofEfiBOqUq5uoV4Ud5Z11WIeO2WhwMx8BucUMBn0tjB1xdC/7ui0mophmAYR58Go/v1UaRuvmuzEzYlhRbhTAIcmoGfl5+zq+t7RPYt4QAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GTwTNHuf; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-308a559bdf7so4177311fa.1;
        Fri, 07 Feb 2025 03:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738927714; x=1739532514; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K3I8jfNTSvLswouinc+w/1LyqpX8XBDD13CLbIziqAE=;
        b=GTwTNHufqPOakhasMiewz/MlVNeofLu74V58gY98PZ/VQwaZFzmpjZ+52yTdlF2Olr
         iITTz4I1WTeXjOGfcvXpqMVjXx81gTn0DAagrz1i45cyWYpYm4tc6vl3wHc9efscqg+a
         QA4TEXIKecOEbPBLzwLPURWn7v9vK4IZF2kSDTj3NijO9Oo6ucmsyyfzyF0oR0BH2pAb
         Q6keYEuQzWmLrVkx9NRsElgnoeiMk+yFoSYhKIJh+jE9Seefrh2vSiemdPPhREDsf7FW
         ZVhJBNRViGTsuGHTnaEMmD340FSikLGYU5SOvug+wmsIT3G+4PMrbbQ/sb2AtU2eSzkr
         Oe+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738927714; x=1739532514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K3I8jfNTSvLswouinc+w/1LyqpX8XBDD13CLbIziqAE=;
        b=aOHCoAQkAObBGAYLwi2qMGJ9VpCNuK28103XCcKFIGwGjtsyNKNlfrdGDd7UGIBgEP
         eJqFjgm9RYBU18Vdg2jfwlQxC37gmPGglBorZehPr/nbgGRrWXDvtQnJXFCtOL/Td7Or
         elL1VKRFdEDKB7mIsQLd5ADRsvPzZMBmDFkyCvGz3ZfZl+TywiGVK8wtOhvwlN0G5x5q
         7FqitsnkmVdyUITBEkYLbnR28R5F4TTD/8e6QxoMmMShyxo9EmexuANCYChoQ5KD8dvG
         wwNUsS2tbMo83xo2FbjBCEEYjAUFDKUVHlWEtT8xCIqnT4FtJkZ5y9jITWzHiQWMk2Je
         rLvw==
X-Forwarded-Encrypted: i=1; AJvYcCUl5VLUARtD3suda51frIFLGusYqiJwcu3YoL3TXOZVZD6QkWU3xTTVV/LPawzeCo7D+a7yrYy57WwEByuOAf4D@vger.kernel.org, AJvYcCVbb/zc7XE4hc83S5S3szjrZ1i0y+4zpKw50vQaN916JKDT4Q1NWUT/lFCXCMcsD66uvj7bFDNGYjFT+Ls=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfu82OsobjdZ3vz0hQvUTwcEd8wHEjrdnWtf4mCb+h4YuJI3+K
	j6zNnCuwH2XaRBM4hNa5HYtaI+C/A7sqKH04SggJJOt8ZxXggwiqTKLrRKPVPM1SeMTqJAQC+1P
	Uhb31/kgds0N3cgI9WhLizQD6vhM=
X-Gm-Gg: ASbGnctSUUgTsPVAHYbI9e4taoHJ+mcdmhXXyvan56QLoFSRfOC2b2By1CnUgy4lIzg
	8ERfJyo5yILymC0qBx6wyqBe6eWJ5SN0y+Gqq4WwUyQXK+dxNb/7ClN4KinO5TH9l5SgVf/9RF/
	U09ZS4AUl1ww19cCFBpw9vUTmT0g/N
X-Google-Smtp-Source: AGHT+IEbJ1TXApipqmFCnNeTyCbZo+ClIG1v6IURN2hPR/XEhzJkpZlE93XuDEPNmz0NSjQARLGmRWj1Sr1MbsVJu4M=
X-Received: by 2002:a2e:bd81:0:b0:307:e498:1269 with SMTP id
 38308e7fff4ca-307e5a8dee7mr8816221fa.37.1738927713988; Fri, 07 Feb 2025
 03:28:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204-printf-kunit-convert-v1-0-ecf1b846a4de@gmail.com>
 <CAKwiHFi6SUCT7UjUTdKmLJ8kiAEqVg=d6ND60R05MJB85Eoj9w@mail.gmail.com>
 <CAJ-ks9kLmArqqPati8n0dwzhjccLmTuTHtkaSyf_F_1QXzCoRw@mail.gmail.com> <87bjvers3u.fsf@prevas.dk>
In-Reply-To: <87bjvers3u.fsf@prevas.dk>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 7 Feb 2025 06:27:57 -0500
X-Gm-Features: AWEUYZm9MWuOjwS9lX6soP6HvGCb-hsrwH8EL3ZvEi3BRJZNc9R9maj_Z4tQnjM
Message-ID: <CAJ-ks9=0+fk22Dx-65a+CSYhy0dnjTJuot9PtgOCi5Th1_wARA@mail.gmail.com>
Subject: Re: [PATCH 0/2] printf: convert self-test to KUnit
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: David Gow <davidgow@google.com>, Petr Mladek <pmladek@suse.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 5:01=E2=80=AFAM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> On Thu, Feb 06 2025, Tamir Duberstein <tamird@gmail.com> wrote:
>
> > On Thu, Feb 6, 2025 at 4:27=E2=80=AFAM Rasmus Villemoes
> > <linux@rasmusvillemoes.dk> wrote:
> >>
> >> On Tue, 4 Feb 2025 at 20:36, Tamir Duberstein <tamird@gmail.com> wrote=
:
> >> >
> >> > This is one of just 3 remaining "Test Module" kselftests (the others
> >> > being bitmap and scanf), the rest having been converted to KUnit.
> >> >
> >> > I tested this using:
> >> >
> >> > $ tools/testing/kunit/kunit.py run --arch arm64 --make_options LLVM=
=3D1 printf
> >> >
> >> > I have also sent out a series converting scanf[0].
> >> >
> >> > Link: https://lore.kernel.org/all/20250204-scanf-kunit-convert-v3-0-=
386d7c3ee714@gmail.com/T/#u [0]
> >> >
> >>
> >> Sorry, but NAK, not in this form.
> >>
> >> Please read the previous threads to understand what is wrong with this
> >> mechanical approach. Not only is it wrong, it also actively makes the
> >> test suite much less useful.
> >>
> >> https://lore.kernel.org/lkml/f408efbd-10f7-f1dd-9baa-0f1233cafffc@rasm=
usvillemoes.dk/
> >> https://lore.kernel.org/lkml/876cc862-56f1-7330-f988-0248bec2fbad@rasm=
usvillemoes.dk/
> >> https://lore.kernel.org/lkml/0ab618c7-8c5c-00ae-8e08-0c1b99f3bf5c@rasm=
usvillemoes.dk/
> >>
> >> I think the previous attempt was close to something acceptable (around
> >> https://lore.kernel.org/lkml/57976ff4-7845-d721-ced1-1fe439000a9b@rasm=
usvillemoes.dk/),
> >> but I don't know what happened to it.
> >>
> >> Rasmus
> >
> > Thanks Rasmus, I wasn't aware of that prior effort. I've gone through
> > and adopted your comments - the result is a first patch that is much
> > smaller (104 insertions(+), 104 deletions(-)) and failure messages
> > that are quite close to what is emitted now. I've taken care to keep
> > all the control flow the same, as you requested. The previous
> > discussion concluded with a promise to send another patch which didn't
> > happen. May I send a v2 with these changes, or are there more
> > fundamental objections? I'll also cc Arpitha and Brendan. The new
> > failure output:
> >
> >     # ip4: EXPECTATION FAILED at lib/printf_kunit.c:95
> > vsnprintf(buf, 256, "%piS|%pIS", ...) wrote
> > '127.000.000.001|127.0.0.1', expected '127-000.000.001|127.0.0.1'
> >     # ip4: EXPECTATION FAILED at lib/printf_kunit.c:95
> > vsnprintf(buf, 19, "%piS|%pIS", ...) wrote '127.000.000.001|12',
> > expected '127-000.000.001|12'
> >     # ip4: EXPECTATION FAILED at lib/printf_kunit.c:131
> > kvasprintf(..., "%piS|%pIS", ...) returned
> > '127.000.000.001|127.0.0.1', expected '127-000.000.001|127.0.0.1'
>
> That certainly addresses one of my main objections; I really don't want t=
o see
> "memcmp(..., ...) =3D=3D 1, expected memcmp(..., ...) =3D=3D 0". And you =
said
> you've kept the control flow/early returns the same, so that should also
> be ok.
>
> I'll have to see the actual code, of course. In general, I find reading
> code using those KUNIT macros quite hard, because I'm not familiar with
> those macros and when I try to look up what they do they turn out to be
> defined in terms of other KUNIT macros 10 levels deep.
>
> But that still leaves a few points. First, I really like that "388 test
> cases passed" tally or some other free-form summary (so that I can see
> that I properly hooked up, compiled, and ran a new testcase inside
> test_number(), so any kind of aggregation on those top-level test_* is
> too coarse).

This one I'm not sure how to address. What you're calling test cases
here would typically be referred to as assertions, and I'm not aware
of a way to report a count of assertions.

> The other thing I want to know is if this would make it harder for me to
> finish up that "deterministic random testing" thing I wrote [*], but
> never got around to actually get it upstream. It seems like something
> that a framework like kunit could usefully provide out-of-the-box (which
> is why I attempted to get it into kselftest), but as long as I'd still
> be able to add in something like that, and get a "xxx failed, random
> seed used was 0xabcdef" line printed, and run the test again setting the
> seed explicitly to that 0xabcdef value, I'm good.
>
> [*] https://lore.kernel.org/lkml/20201025214842.5924-4-linux@rasmusvillem=
oes.dk/

I can't speak for the framework, but it wouldn't be any harder to do
in printf itself. I did it this way:

+static struct rnd_state rnd_state;
+static u64 seed;
+
 static int printf_suite_init(struct kunit_suite *suite)
 {
  alloced_buffer =3D kmalloc(BUF_SIZE + 2*PAD_SIZE, GFP_KERNEL);
  if (!alloced_buffer)
  return -1;
  test_buffer =3D alloced_buffer + PAD_SIZE;
+
+ seed =3D get_random_u64();
+ prandom_seed_state(&rnd_state, seed);
  return 0;
 }

 static void printf_suite_exit(struct kunit_suite *suite)
 {
  kfree(alloced_buffer);
+ if (kunit_suite_has_succeeded(suite) =3D=3D KUNIT_FAILURE) {
+ pr_info("Seed: %llu\n", seed);
+ }
 }

and the result (once I made one of the cases fail):

printf_kunit: Seed: 11480747578984087668
# printf: pass:27 fail:1 skip:0 total:28
# Totals: pass:27 fail:1 skip:0 total:28
not ok 1 printf

Thank you both for engaging with me here. I'll send v2 in a few
minutes and we can continue the discussion there.
Tamir

