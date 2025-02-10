Return-Path: <linux-kselftest+bounces-26262-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6039A2FC92
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 23:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29AE07A20EA
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 22:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD40C24C666;
	Mon, 10 Feb 2025 22:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LiRjGkxF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA0D264604;
	Mon, 10 Feb 2025 22:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739224950; cv=none; b=V2LlCHxUnHlEonDpd3p4sK0ZNxHiYxwvKphifr26992fwsQfCUr7xOi8wDqKpz4X5MsOPDBok0NL0awhOdsAeam4RWBwMrNhkB+xUdE6Sa2EQB4xlqytPChq7LF7xfFTc+gVkYObGaf8U/f3HMpzHJQ2D4kuDKYe2x4GCatxy/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739224950; c=relaxed/simple;
	bh=IvwKPNJpJVwbUYvgwowiE2ATlTHTfHicL75MLIgFv14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B+N1h3zEQLGI42AETc3/xXEYjRgQ4dpbiWWmsx92/1iOH9Nq9VHJqMB8FmQCNw5yi6IqOGd7LX0NUCCMXmhhZkOS9qvTGOqJ5WeHGzs/gNwtQ852n5qaoayZEBX3yNo3ina7IfCYni0mNDM8cif/EcCz0D7wfZCrruAD870w0+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LiRjGkxF; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5450abbdce0so1667238e87.3;
        Mon, 10 Feb 2025 14:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739224947; x=1739829747; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gKBtxPY73vUN0je5NCWLQ8BOv+4GXPrXFhu2CsOugcw=;
        b=LiRjGkxFD0TiFAZVXED2O6bezaasv0+o1hNOs2o9yJIw6y1BFVwU+vc9VqONjYzNRc
         BeYL3UXOK4hTbC1/UkDW688WXHs7ZQLeJjqdy6Bc5pfKS+x0uCcmn3EqQeBdKBIZZmFd
         GOOQZCx8TzHxvNQsNm32ZDWNFR5yWoA9IaZAlwYUQGfeZ6GmKfU1Jdq7INmcK98sDiYf
         RyzQHuJESuBaNBWtiUE7wOcsG6JdTtEIx+ygFSt9xeCinaQXOq/EcSqjfVWwgFy9f0q5
         0waEpibFe+NuMmsDqMPrHUPkepCRPmsEFAfcdWj5aR4d7Yntmjcd+18HdxuNFFqDhJbz
         dQpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739224947; x=1739829747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gKBtxPY73vUN0je5NCWLQ8BOv+4GXPrXFhu2CsOugcw=;
        b=W8ouMTdq5mwP7ISa/WLO8+LGLwh2ACKPdGltW5p4u4BD0UdxP55lGTPxxaURgl8uSx
         wyI4wpwtnOttVgyMxPulynxsva33Kv+LsqeQXSYR/Rd5ShopKMmughEzccM79OV/T9tm
         RoBBS2XI6PDGHOf/FkQTD6L6vj1lAgWiXZtx86kZL/p/x6PsqYp9JmB+MFpF+J62kwpQ
         qYAb9pnEU5Rnz/QJJaEGOhnWK9miOBFUAzvUplN3TEZlq+xO0WE87qoK0k0FlVKS77fu
         AkIUm9ZH3t8QUZsNxR1X6omTPnBenTK08CNQrhWT5WEHwFuoGd9fXiGOR9MfVCo1mCqm
         i7kQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQm317RA5IPHlC0M0njt0CNuXn8TENCUk2CvElKSjbCEN2k54M8hZe3FSfyMZoZufliHlRUe8J3grHEZSuI8Nk@vger.kernel.org, AJvYcCWRa2lwn83ISSN8JH7TB4HK5l9evqiaba8g7DwYo5dQNUdXIFAxCnm1epOSkc+UCiLgJwKNlfe3iPn1FxY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3a28VXq5wDp6Wpg271rT9v24Rtq0mytWYkuJLZLt3jQ7rH2En
	PCRT4OPWzdkUmwacr6oO+upB05NSh2Pz++3wY69uKbNXtUkmXaJ/i+mKbO6xUsg0mYTJFnDt8m9
	RwH+278aXrfFErW1RHe1MhRu4UqE=
X-Gm-Gg: ASbGncsy64Tl6T7PuE5C4i650FsKhTT1N0dPIiyIpSLJd2f805Gf1VhfPmLP2rU24Jv
	9VRhf2vhfMCba3ck8hhnqy9d0byl/AL2oYkofLLxum9pz9ZTO7lj11WEG9usi5bMNxU+ApM7K3l
	/q72aAntqbmlV8
X-Google-Smtp-Source: AGHT+IFXntGT+FjS//GtLsBee13n1feXxAcsDFdmGK/9Zc8xT57kBWrr/KSN97XqSWCXZ4WJpptogalCw+FV21qYtDM=
X-Received: by 2002:a2e:a5c8:0:b0:307:e498:1269 with SMTP id
 38308e7fff4ca-308f83eafa5mr5428921fa.37.1739224946736; Mon, 10 Feb 2025
 14:02:26 -0800 (PST)
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
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 10 Feb 2025 17:01:50 -0500
X-Gm-Features: AWEUYZkKe8CssbPTeBnqdSPds-hBj-nYrF2armsMtC2A_9bwIn2Ly57bR0J6s5k
Message-ID: <CAJ-ks9nCsCfuayotpqgNytHAZ758w2oSU58dEDMXwQRU7vqisQ@mail.gmail.com>
Subject: Re: distro support for CONFIG_KUNIT: [PATCH 0/3] bitmap: convert
 self-test to KUnit
To: Yury Norov <yury.norov@gmail.com>
Cc: John Hubbard <jhubbard@nvidia.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	David Gow <davidgow@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Shuah Khan <shuah@kernel.org>, Kees Cook <kees@kernel.org>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, linux-kernel@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org, 
	linux-kselftest@vger.kernel.org, Brad Figg <bfigg@nvidia.com>, 
	David Hildenbrand <david@redhat.com>, Michal Hocko <mhocko@suse.com>, Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 3:20=E2=80=AFPM Yury Norov <yury.norov@gmail.com> w=
rote:
>
> On Mon, Feb 10, 2025 at 11:35:48AM -0800, John Hubbard wrote:
> > On 2/9/25 11:54 PM, Geert Uytterhoeven wrote:
> > > On Sat, 8 Feb 2025 at 18:53, Yury Norov <yury.norov@gmail.com> wrote:
> > > > On Fri, Feb 07, 2025 at 03:14:01PM -0500, Tamir Duberstein wrote:
> > > > > On 7/27/24 12:35 AM, Shuah Khan wrote:
> > ...
> > > > > The crux of the argument seems to be that the config help text is=
 taken
> > > > > to describe the author's intent with the fragment "at boot". I th=
ink
> > >
> > > IMO, "at boot" is a misnomer, as most tests can be either builtin
> > > or modular.
> >
> > Right.
> >
> > >
> > > > KUNIT is disabled in defconfig, at least on x86_64. It is also disa=
bled
> > > > on my Ubuntu 24.04 machine. If I take your patches, I'll be unable =
to
> >
> > OK so I just bought a shiny new test machine, and installed one of the
> > big name distros on it, hoping they've moved ahead and bought into the =
kunit
> > story...
> >
> > $ grep KUNIT /boot/config-6.8.0-52-generic
> > # CONFIG_KUNIT is not set
> >
> > ...gagghh! No such luck. One more data point, in support of Yuri's comp=
laint. :)
> >
> > >
> > > I think distros should start setting CONFIG_KUNIT=3Dm.
> >
> > Yes they should! kunit really does have important advantages for many u=
se
> > cases, including bitmaps here, and "CONFIG_KUNIT is not set" is the mai=
n
> > obstacle.
>
> Hi John, Geert, Tamir,
>
> Can you please explain in details which advantages KUNIT brings to
> the test_bitmap.c, find_bit_benchmark.c and other low-level tests?

I can try, but I'm not the expert, and David Gow can probably elaborate fur=
ther.

As I understand it the main benefit of KUnit is standardization and
speed (and standardization _is_ speed). KUnit makes it very easy for
me, a person who has not previously contributed to any of the bitmap
code, to run those tests, and it requires zero configuration, it all
just works. It's basically just `tools/testing/kunit/kunit.py run
bitmap`, and I get the test results in a human-readable format. The
same benefit applies on the author side: test facilities are
standardized, so once you get to know the tools, all the tests start
to look the same: you can jump in and contribute without having to
first learn the so-called local "testing framework".

The important part is that this all applies to ~all other tests
written in KUnit. I can even run them *all* trivially:
`tools/testing/kunit/kunit.py run`.

Anecdotally I've also noticed there are bots running those KUnit tests
e.g. see https://lore.kernel.org/all/20250207-blackholedev-kunit-convert-v1=
-1-8ef0dc1ff881@gmail.com/
where a test I converted was immediately flagged by a robot as having
dubious type coercion.

None of these are must-haves, they are just (to me) a nice way to make
the kernel more approachable for new contributors.

As for pure benchmarks like
find_bit_benchmark.c and
test_bitmap.c::`test_bitmap_{read,write}_perf` specifically: I believe
the benefits are super limited or even negative: AFAIK KUnit is
designed to generally suppress output (in the userspace reporter, not
in the kernel) unless a test fails, so I wouldn't hurry to use it for
these.

> I'm not strongly against moving under KUNIT's hat, but I do:
>  - respect commitment of my contributors, so I don't want to wipe git
>    history for no serious reason;
>  - respect time of my testers, so no extra dependencies;
>  - respect time of reviewers.

These are valid concerns. Certainly the testing case is the most
compelling and folks are clearly interested in lowering those
barriers. I don't have any influence in this area, but I am grateful
to John for starting the conversation.

As I mentioned in the previous thread: I think we could keep
`test_bitmap_{read,write}_perf` in test_bitmap.c and get the best of
both worlds. WDYT?

> Tamir,
>
> If it comes to v2, can you please begin your series with an exhaustive
> and clear answer to the following questions:
>  - What do the tests miss now?
>  - What do _you_ need from the tests? Describe your test scenario.
>  - How exactly KUNIT helps you testing bitmaps and friends better?
>  - Is there a way to meet your needs with a less invasive approach,
>    particularly without run-time dependencies?

Hopefully I've answered these above. I can include some of it in a v2,
but perhaps the general pitch for KUnit is better placed in
documentation or slides from a conference?

Cheers.

Tamir

