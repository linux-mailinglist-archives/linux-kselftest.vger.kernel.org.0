Return-Path: <linux-kselftest+bounces-34275-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1A9ACD690
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 05:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BB8A16DE28
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 03:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5AF1531C8;
	Wed,  4 Jun 2025 03:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u1zifknf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9357472601
	for <linux-kselftest@vger.kernel.org>; Wed,  4 Jun 2025 03:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749007853; cv=none; b=FmAoz+jU2upN3p2fu76hbdc7M3Vl2i1iSQZhH3bh9o1ieMJeq+dAoRdKedYSd8YQ7y14grX2R598iz34oYFZbaNzWVDFNMCTbLAxoWN4ZuFUx+eg/9G7TpSmgFKscNum8+DJgtdyLv5M1WXvXVj80uYCc282ggxHKAoWS9isHz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749007853; c=relaxed/simple;
	bh=RjbcDYu1YtPRkYoseSOkPO3tTHTmQiLWaXOKSPCvdkg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jt54vORTsALvKh80oEu2ci+1lxCtj53FAWEcfDViuJUkg9f1V6Y+7LVhLUTogu5cODR4hSBVYp9IOzkjFHsG0Mtbd3W4X4NdKDVKlgcW4zGcsNaWTS0OBzq4MwmMOkQWAgGhOw6zElUV0qujaC8AebtpD0tpUHV0dMtFQ3kZ4x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u1zifknf; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-51eb1a714bfso4304621e0c.3
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Jun 2025 20:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749007850; x=1749612650; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fOC+m4zOJ34UxxPz/TiQmD5iaJADylPzttows/BWe1k=;
        b=u1zifknfr6t5nmdCp5Weiv9v9NFrIhppaj4mCQomDKnMXHkSLkIjuRMYlSIh0qPxOO
         2t6Vzv+ARTyl/MmhTAqXxOMzp4O1hDPvjXKUcsn1+JSQK+a4fPO1TQqC/yxkh18L6mp5
         li0oP5H7KsbE9OxuHWeMHxaeQpjb2f3JQGtQtjpMbbwk/HGhTiFIdK5MbwL7JEwYJ/1j
         h3SbhNWL9DMBbHFoyLQrURyMl9xo3hPMta+x4pW8B+eZLQ4ovaopiP8oR9voN74sRV7w
         E6tbsAdnAlR0fQbUHWknR9juHrfmDRMmcQGUeQYN/1oCPw9L8O7ipLkJ8Ty8tXPfXQBD
         v59g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749007850; x=1749612650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fOC+m4zOJ34UxxPz/TiQmD5iaJADylPzttows/BWe1k=;
        b=wO6U2f5TojLdsl5IFRQEvIPhEEAVADlX+v89AYWytooNeJsfEW6GcUHsbBezuPFp2i
         PosuT4BRKQlj6w0103h/YsRM9m7I815zWJUtbaUvlzfPxd6+YnNHWsNtl83CocFRZYTe
         X7EMPjeM7tnouCudCvKh/3Yth41gpvzc90UOESqvMGgC0TTIBDz3bZWL90pbQWX4CBZ1
         yg03VlVBks9cJXi3m2wxAEHnLtSPXAlhcXfAlarLHQCBxBuMgx0WNVrCpAZHPHSP7X/X
         Zl7Sv1rZ78EgIGcqKBhZ76n3zWOah9kvEShGBTlHOroLPCDWc/U3jCWv1t7tocTzvdgc
         Cwpw==
X-Forwarded-Encrypted: i=1; AJvYcCX72S2tNyhsMvDPza2GE2PlqbUm2ZJxGo2PM9KSskZHFL1uMpMQxKtxF30/WKe1/VF4VCO2FxURnaBMHisys5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCT7wf6NH3dcvZQeaLPpuV2m6cYKhKQIJkDBtMgQsw4MoNw26d
	W9tEGdgRNJnVlO9OuFiL31cuhDYhgwOOkMQIgYTG9EeeTqEquJaq378evf+SvYybPNKisRZkbkA
	bafBBuutCYYRrjCLpD0CBHhj5UfyXYOni3S45POs4
X-Gm-Gg: ASbGncsXsBXebk6yYftHFg0r6DWbrla+ZK2Hh72YgqrSVdZ2smvT79pfGV8iymT9qNG
	XUJr8RwEynWwC0mQh+Ply6bzNWcjnkKjD4sIWMb2ImLm1p/FEr+nNaheFS4dRkm5aoWB2ADkHXz
	AhZbehzyby0sk+gVdUWCE2raxk7dbY2mpXUDLb/KtFW1Wz+O18RmjbiCqwYlldcHCTN38nd7QCG
	A==
X-Google-Smtp-Source: AGHT+IG5bw78Odqgpd3EBpVfqxdEd4THXeUjYORslhfe3Gche7FcK086w9JV/cR2nIVnS6RTWNlPCnRW0vrV7HVy6qs=
X-Received: by 2002:a05:6102:b0b:b0:4e2:82c3:661c with SMTP id
 ada2fe7eead31-4e746d8c858mr770783137.11.1749007850171; Tue, 03 Jun 2025
 20:30:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250526132755.166150-1-acarmina@redhat.com> <20250526132755.166150-2-acarmina@redhat.com>
 <20250529090129.GZ24938@noisy.programming.kicks-ass.net> <CAGegRW76X8Fk_5qqOBw_aqBwAkQTsc8kXKHEuu9ECeXzdJwMSw@mail.gmail.com>
 <20250530140140.GE21197@noisy.programming.kicks-ass.net> <202505301037.D816A49@keescook>
 <20250531102304.GF21197@noisy.programming.kicks-ass.net> <20250602-phenomenal-turkey-of-hurricane-aadcde@houat>
 <20250603122603.GK21197@noisy.programming.kicks-ass.net>
In-Reply-To: <20250603122603.GK21197@noisy.programming.kicks-ass.net>
From: Daniel Latypov <dlatypov@google.com>
Date: Wed, 4 Jun 2025 12:30:38 +0900
X-Gm-Features: AX0GCFsGfqrM-mb1TX-evfPNlSjXcsDpFP46rFQa5C7LWSuPpBr8suouJ-eIUyU
Message-ID: <CAGS_qxoxkcDyUDKPYWAV2Sk1Df0kMYaDpSwinxUTyhtWpjkr6g@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] bug/kunit: Core support for suppressing warning backtraces
To: Peter Zijlstra <peterz@infradead.org>
Cc: Maxime Ripard <mripard@kernel.org>, Kees Cook <kees@kernel.org>, 
	Alessandro Carminati <acarmina@redhat.com>, linux-kselftest@vger.kernel.org, 
	Dan Carpenter <dan.carpenter@linaro.org>, Daniel Diaz <daniel.diaz@linaro.org>, 
	David Gow <davidgow@google.com>, Arthur Grillo <arthurgrillo@riseup.net>, 
	Brendan Higgins <brendan.higgins@linux.dev>, Naresh Kamboju <naresh.kamboju@linaro.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Ville Syrjala <ville.syrjala@linux.intel.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Guenter Roeck <linux@roeck-us.net>, 
	Alessandro Carminati <alessandro.carminati@gmail.com>, Jani Nikula <jani.nikula@intel.com>, 
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Shuah Khan <skhan@linuxfoundation.org>, 
	Linux Kernel Functional Testing <lkft@linaro.org>, dri-devel@lists.freedesktop.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 9:26=E2=80=AFPM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Mon, Jun 02, 2025 at 01:13:29PM +0200, Maxime Ripard wrote:
>
> > > I can't operate kunit
> >
> > Why not?
>
> Too complicated. People have even wrecked tools/testing/selftests/ to
> the point that it is now nearly impossible to run the simple selftests
> :-(
>
> And while I don't mind tests -- they're quite useful. Kunit just looks
> to make it all more complicated that it needs to be. Not to mention
> there seems to be snakes involved -- and I never can remember how that
> works.

I've been out of the loop for a while, but I'm curious.
What parts in particular are the most annoying, or is it basically all of t=
hem?

Is it that adding a new test file requires editing at least 3 files
(Makefile, Kconfig, the actual test.c file)?
Is it editing/writing new tests because the C API is hard to use? (Has
too many funcs to know how to do simple things, etc.?)

For me personally, it's the first part about all the additional edits
you have to make.
I _hate_ doing it, but can't think of a good alternative that feels it
makes the right tradeoffs (implementation complexity, requiring users
to learn some new system or not, etc.)

>
> Basically, if the stuff takes more effort to make run, than the time it
> runs for, its a loss. And in that respect much of the kernel testing
> stuff is a fail. Just too damn hard to make work.
>
> I want to: make; ./run.sh or something similarly trivial. But clearly
> that is too much to task these days :-(

Agreed that ultimately, it would be nice if it was as simple as one of thes=
e
$ run_kunit_tests --suite=3Dtest_suite_name
$ run_kunit_tests --in_file=3Dlib/my_test.c
or something similar.

But while I don't see a way to get there, if you've set your new test
config to `default KUNIT_ALL_TESTS` and are fine running on UML, then
it could be as simple as
$ ./tools/testing/kunit/kunit.py run

It should basically do what you want: `make` to regen the .config and
build and then execute the tests.

But I can see these pain points with it,
a) it'll run a bunch of other tests too by default but they shouldn't
be failing, nor should they add too much build or test runtime
overhead.
b) if the new test you're adding doesn't work on UML, you'd have to
fiddle with enabling more kconfig options or switch arches
c) it can be confusing how it has multiple subcommands in addition to
`run` and it's not immediately clear when/why you'd ever use them
d) the fact it's not like kselftest and just part of make, i.e. `make
TARGETS=3D"foo" kselftest`
   * even if kunit.py was dead simple (and it's not, but I don't think
it's _that_ complex), it's another tool to learn and keep in your
head.

Do these cover what you've experienced?
Or are there others?

>
> I spent almost a full day trying to get kvm selftests working a couple
> of weeks ago; that's time I don't have. And it makes me want to go hulk
> and smash things.

Stepping back, I think there'll always be relatively simple things
that take a bit too much effort to do in KUnit.

But I'd like to get to the point where anyone can feel comfortable
doing the very simple things.
And I don't want it to be with the caveat of "after they've read 10
pages of docs", because none of us have the time for that, as you say.

E.g. If someone is introducing a new data structure, it should be easy
to ask them to learn a enough KUnit so that they write _basic_ sanity
tests for it and add it to their patch series.
Maybe it's annoying to cover all edge cases properly and very
difficult to try and test concurrent read/writes, but those are
inherently harder problems.

Cheers,
Daniel

