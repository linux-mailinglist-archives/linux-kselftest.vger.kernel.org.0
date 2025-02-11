Return-Path: <linux-kselftest+bounces-26337-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6062A304E7
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 08:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88C4F3A4BBD
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 07:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FF41EE00E;
	Tue, 11 Feb 2025 07:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0pO6/GHp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4DD1EDA35
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Feb 2025 07:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739260330; cv=none; b=WtP02E7Iu7lBUAyQ1cmSbDMXN2v5QngVmH++Mgqau1micLQCSiyYSEiP233eGAvXK8SSb1xziIRb9vBJLxtfTnwm0mqBtiQnCQemBpQieWc4G6uit4ZOasAUNbZusW7VXUhk4q6dqkNhCYypylWywA60WYv1HdaeKyBdYAaWfEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739260330; c=relaxed/simple;
	bh=IfXNB6uWV0hdA8hswijf+VMKa/9ob7rFSJJkcz0StNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GYshTrxEPd7gjj2am9nlI+lKuQqKryzoBTLNhUWU8q4BaWNOBar/GA0dvOlp+5wHerkstD5qooyMuxwVdbErK2FTAz+SJFN+3nX6DuCAWjIxKYS+fWWgvb7S3yir/YQsjfZ6JqN6ZyC6DbS4T7f8Igit3HxNtguoglloO0H8Qdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0pO6/GHp; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6e44af3dacbso46593096d6.2
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2025 23:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739260327; x=1739865127; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GGlY+bkOqi5PuH8Y5QlLfcyvBOm3ntepb1OfPBLEDLQ=;
        b=0pO6/GHp4ElP3WYWgVfsLPJsSotG98kw3nCtnjPALNImA5UiBj4wOAIQs/ZduzlV7z
         EEMcVUX7jmSmuQWEZmdWuD16fATEBViXj4laBikvuEpdZ6v5AfnOkw+RBPyqlxYJUIS1
         PgRfwQyjQEt/RgFq71vvaj71+bMLQTnB6b/CjFQNzxWLyJfeDt9TJZUhoYnk6DURw5DX
         3gELJwJnydJXijYSMBKhMgTDc3QRq8zTQjui8o08W2cRt+pRAZhvawRX+Zd/MF3Sr4ZC
         Gz9hIHQLPfLTuLoPvJ1tDZuuwAcHE8m1ySTXwivu8u3vHy5nGY31dsOojXxPnr9F54/g
         gyxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739260327; x=1739865127;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GGlY+bkOqi5PuH8Y5QlLfcyvBOm3ntepb1OfPBLEDLQ=;
        b=WtOKaXeSv1SVO5c7x5KJJNAjsCq28t0SBVxMczhWhE9CNE9R5eloiJqhKMD/OKVhaj
         SCParonnemqw64xLdL2kmoQ0Nf/1ajwA2TcHk8wLckL6Cn5JRMcjOm9yXBvw7s+smxrO
         QH08ROlVHt6UQZB4WUMkFQhAhoJS9aNuM3fy7rDpk+Kr3Klv124oF7Ye8JYCP4KfHal9
         vbpMoGte56exGAcy6arkKpF3f1yX+ZYZXk733TNORobTX2qAOe7mLhGdZuq9TsiamvbE
         y8YhS6uGydGiOPcL93tMpld9uC3X5t/oDLMMxRuN6DDPXbs4eRWgtqs3unBN5J5NLly0
         laDg==
X-Forwarded-Encrypted: i=1; AJvYcCUTNH7GhoEeuls4DgdAHDkm9z5KrR4/ImV12Phg26OoTYBiwRdpVuaNNdEhnX/CMGBDfMXvXtLG6Wp74sQTmxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YydKqhCPl69adgSbRyCtX44Nm6TqYEO7Eqy9Cr85Fbj+mj8Zu99
	Khwgv7YC+NLqEOFu7mO69WavDnkUoBwIvC2eJ+dEDxPvPAu7q01Cfw1ZpnEJsdEdMAvbPrWIWlx
	ZJcj7EwclWvxj2lNeftu0UL+WzMeDsYqApJJq
X-Gm-Gg: ASbGncvxP1RbcyEVtdnAT2LWrShVFJH5BkDUnyzbJWiZsg8o54xEWpwwVZRCKCDm0MW
	fwPYyD/h4vaAn86bfC527jRvsqJ7Ij19pTZSfqm712ExeiAPTPGEpMOp8Tsq3alMwMGHaGoBu2A
	==
X-Google-Smtp-Source: AGHT+IE+yl3wzsSo4TpLqGm9Gq/Dy5uTEQZDUK/aRLj2hBWjOAdHfNwEQlC5XSZs9d0yBjJfceuKCl3XGV5VgLhlK/8=
X-Received: by 2002:ad4:5c6e:0:b0:6e2:481b:7cd9 with SMTP id
 6a1803df08f44-6e467861abdmr47390546d6.25.1739260326988; Mon, 10 Feb 2025
 23:52:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207-bitmap-kunit-convert-v1-0-c520675343b6@gmail.com>
 <Z6eaDuXnT_rjVSNS@thinkpad> <CAMuHMdUsq_39kgBa8oanXeTzv44HuhS1e5MK7K2jxkVXQ7uWdw@mail.gmail.com>
 <bd71c705-5f57-4067-b200-fd80b98ddbc9@nvidia.com> <Z6pfomw-3LuWoQQo@thinkpad>
In-Reply-To: <Z6pfomw-3LuWoQQo@thinkpad>
From: David Gow <davidgow@google.com>
Date: Tue, 11 Feb 2025 15:51:54 +0800
X-Gm-Features: AWEUYZn44yeG9ZBzJSy3v2t1KbtFDEG3Fr63XU8HKrdi1hGCI11-cYXsuiSVW6Q
Message-ID: <CABVgOS=KZrM2dWyp1HzVS0zh7vquLxmTY2T2Ti53DQADrW+sJg@mail.gmail.com>
Subject: Re: distro support for CONFIG_KUNIT: [PATCH 0/3] bitmap: convert
 self-test to KUnit
To: Yury Norov <yury.norov@gmail.com>
Cc: John Hubbard <jhubbard@nvidia.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Tamir Duberstein <tamird@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Shuah Khan <shuah@kernel.org>, Kees Cook <kees@kernel.org>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, linux-kernel@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org, 
	linux-kselftest@vger.kernel.org, Brad Figg <bfigg@nvidia.com>, 
	David Hildenbrand <david@redhat.com>, Michal Hocko <mhocko@suse.com>, Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 11 Feb 2025 at 04:20, Yury Norov <yury.norov@gmail.com> wrote:
>
> On Mon, Feb 10, 2025 at 11:35:48AM -0800, John Hubbard wrote:
> > On 2/9/25 11:54 PM, Geert Uytterhoeven wrote:
> > > On Sat, 8 Feb 2025 at 18:53, Yury Norov <yury.norov@gmail.com> wrote:
> > > > On Fri, Feb 07, 2025 at 03:14:01PM -0500, Tamir Duberstein wrote:
> > > > > On 7/27/24 12:35 AM, Shuah Khan wrote:
> > ...
> > > > > The crux of the argument seems to be that the config help text is taken
> > > > > to describe the author's intent with the fragment "at boot". I think
> > >
> > > IMO, "at boot" is a misnomer, as most tests can be either builtin
> > > or modular.
> >
> > Right.
> >
> > >
> > > > KUNIT is disabled in defconfig, at least on x86_64. It is also disabled
> > > > on my Ubuntu 24.04 machine. If I take your patches, I'll be unable to
> >
> > OK so I just bought a shiny new test machine, and installed one of the
> > big name distros on it, hoping they've moved ahead and bought into the kunit
> > story...
> >
> > $ grep KUNIT /boot/config-6.8.0-52-generic
> > # CONFIG_KUNIT is not set
> >
> > ...gagghh! No such luck. One more data point, in support of Yuri's complaint. :)
> >
> > >
> > > I think distros should start setting CONFIG_KUNIT=m.
> >
> > Yes they should! kunit really does have important advantages for many use
> > cases, including bitmaps here, and "CONFIG_KUNIT is not set" is the main
> > obstacle.
>
> Hi John, Geert, Tamir,
>
> Can you please explain in details which advantages KUNIT brings to
> the test_bitmap.c, find_bit_benchmark.c and other low-level tests?
>

First, I'd agree with Tamir and others who've pointed out that KUnit
is not really intended for benchmarks, so I definitely don't want to
oversell it for find_bit_benchmark.c and others (though it has been
used for benchmarks in a few cases, it's not perfect).

The main advantages of KUnit are that:
- it's already used for a bunch of lib/ tests (so quite familiar to a
number of contributors/users),
- tests can be run at boot without needing any userspace at all (if built-in),
- KUnit tests are already being automatically run as regression tests,
and it's relatively easy to run "all tests" associated with a config
- there's a whole bunch of tooling which automates configuring,
building, and running a kernel with these tests, across several
architectures
  (e.g., passing --arch arm64 or --arch m68k to automatically build
and run the tests in QEMU for those architectures)
- there's tooling to nicely print, format, and summarise the results
of any number of suites.
- and, as a result of the above, it's very quick and easy to run a
test (or whole bunch of tests) in an isolated environment.

KUnit also has very few runtime dependencies from a developer
point-of-view (python, optionally QEMU).

It is, however, less focused on the "debug a running system" case,
hence the requirement for CONFIG_KUNIT to be enabled, and the tooling
largely being focused on the "run all of the tests in UML or a VM"
case.

> I'm not strongly against moving under KUNIT's hat, but I do:
>  - respect commitment of my contributors, so I don't want to wipe git
>    history for no serious reason;

It should be possible to preserve the git history during a port,
though it admittedly will have a bunch of porting changes which make
it more difficult to navigate with git blame. But it should at least
be better than a total wipe.

>  - respect time of my testers, so no extra dependencies;

I think KUnit is a bit of a mixed bag here. In many cases, KUnit tests
can be run pretty quickly, either because the tester's environment
already has CONFIG_KUNIT enabled, or possibly under some kind of
virtualization with the tooling (either QEMU, or on x86,
User-Mode-Linux). But, as mentioned above, I'd not consider it ideal
for performance testing.

I am very sympathetic to not wanting to add a dependency here. I think
KUnit is a pretty minimal dependency as far as they go (it selects
CONFIG_GLOB and nothing else, needs no userspace, and even the tooling
only really requires python on top of the basic toolchain), but it's
definitely a further dependency for the
'test-the-currently-running-kernel' use-case.

>  - respect time of reviewers.

This is an area where I think KUnit could be an advantage, as it'd be
easy for reviewers to simply run
./tools/testing/kunit/kunit.py run bitmap
as a spot check on the code. And if they want to test on other
architectures, the --arch option can be used to do so quickly.
(And, of course, it can still be loaded as a module (or even built-in)
on a physical system or other VM, albeit with the requirement for
CONFIG_KUNIT.)



As for distros enabling CONFIG_KUNIT by default, as mentioned, my
understanding is that the Fedora/Red Hat distros are doing it, as are
some branches of Android, but I doubt anyone else is. This makes
sense: enabling CONFIG_KUNIT isn't free (though the overhead should be
very low if no test is running, just a few static branches and an
extra check in the module loader), and there's always been some
reticence (which I've shared) in enabling test features on production
kernels. So it's definitely something I was recommending against a few
years ago.

However, we've definitely made sure that CONFIG_KUNIT is less
invasive, with things like hooks being kept behind static branches,
and made the decision to have _running_ a test taint the kernel, so it
should be relatively safe to just have the framework enabled (and even
safe to have it loaded), and pretty obvious when a test is run. We've
also got a bunch of extra options to disable running tests
automatically when they're built-in/loaded, both at runtime and
compile time.

So I'd definitely be happy with other distros choosing to enable
CONFIG_KUNIT by default now: I think it's much safer than it was, and
you won't be going against the grain. But equally, I'd understand
having it disabled in production: the cost, while very small, is
nonzero.

Cheers,
-- David

