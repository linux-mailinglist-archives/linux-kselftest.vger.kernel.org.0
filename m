Return-Path: <linux-kselftest+bounces-27223-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A802A4011F
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 21:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA25A169700
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 20:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06BB11FBEB9;
	Fri, 21 Feb 2025 20:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HjjyM2rr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC6D1D8A14;
	Fri, 21 Feb 2025 20:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740170196; cv=none; b=G0Mt1Fq8+xkF7IQ6IzXjEZaV3Wxebuf+gbvRgJnlWCXQLc0dBmGzYQuzYbSZTO6GznBo3+iWOn4ryGLHilc4otqh1uaS/AxSUqbdUW428CH7H9QNR1xKonge3WKnjCw66RIxGBCXh9dooBcL20zKOZWIXmCxzou9A55Xu1d95Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740170196; c=relaxed/simple;
	bh=IWMvonBG+KnGNLyuoaKqjMosPNOq8YfwaQsVw0V4EEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lZxk8PYTKP60fKqCpnXOY/4Gysy5j1KLjVMQI7bJ4Y+F995CYeF3zBYuLl+SXiVVKie6Ot5sEXPV2SsfaRoNpanYqK6nJ2jxMwrlascAc/pV18yhieb2LAllUkdEHUgcHOduwDYQ9bRQAEf6NvBiJfJVqUgekM6q9g3/gClYKyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HjjyM2rr; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e095d47a25so4853007a12.0;
        Fri, 21 Feb 2025 12:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740170193; x=1740774993; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IWMvonBG+KnGNLyuoaKqjMosPNOq8YfwaQsVw0V4EEI=;
        b=HjjyM2rrXBoSm00Kz3GNgUxMo2PFfn3mLK1bARjQvu5+xgX1M9DmDlSjViolN4pfBp
         Iale+dvjzL8qO7Ky4oUK5smWoNNV7+nf/vvtfvfk7m+XCkTUd2riLofGSLd2NCEPaIF8
         cb3expB5u8GHbTfsTsOPWvN3aKFbUQy9pSZiXq8mzyeMX2S+k3/cNiK04cDbaIVw2VdA
         3JKlNG7LoiC1c2YVUP71gdtS5rHTYutR3cgxkMhTDmuZUnSXmHvCltKdK5YToeJICiGq
         SaFAsCvt83Fx9X17WUJ+PGzen1Cl53DGB9DsjOFdtBa3g+WkmY+Cq5zK/KHbCGZuQLmg
         cXVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740170193; x=1740774993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IWMvonBG+KnGNLyuoaKqjMosPNOq8YfwaQsVw0V4EEI=;
        b=L9zMW8Gr7Q7reaGbPkfe0Kpr6P0sWYpmFMT9A55CA5g0tC//3A/eTQlm8ik4xCZ66D
         zOUC9N98hDB7bDF9TQym3jAKhWCbz0VHfDH3Xno2sFjlq4UB0dyL1lKpDrScsH1W9AEQ
         6JEguBzdkhcIH/nd0Eh0lmgYNI6DoT2szcrSekDrrD9ky1CHJvNvCLkn4+6a982j3iPC
         HT0gPFF2ZaeOaR+8FV467PRJJLICg7QsJS7fUWedvZv8KVv1MwzdG1gIe+2kcGOTTzim
         kVJ3RsjiX+R0q795MXKpea83NQUCCH+k8AaHcHcPD37rnY5BuvYZPpENZsuPdLS8305L
         04wg==
X-Forwarded-Encrypted: i=1; AJvYcCVegnpTTeyaxxUfaTjMzwDUG7qKLJt+U59iXZ/MKqfpVG7G1fmY4eCQ8mn4GjYmus6o+uFC9JwxdpQEVmE=@vger.kernel.org, AJvYcCWhiyNyubAFiV6+a1fkKq937V0ECYqM1RYf25OhahrrtO/UuZ/HT3n08ZPQnV1wTP43IDymtsZPwLEyYWz/bUjz@vger.kernel.org
X-Gm-Message-State: AOJu0YwUWtrHY+bvbHD7Ys8PzpXOsbJrJqDCZLkn0GYKvjBG8+TNBQL9
	3mcgTbqcYrHNNr1ilTWl/oTa3TB2tG0wqeCxQVzCWA8yHI8lCYfv+awJXLZNlOkVH+5TN22qgj3
	ZZs4oRoaWljWuvzf9/zJbw2xYRypkOYmpX4w=
X-Gm-Gg: ASbGncuBhtctTPhe5FRN9ituBGCmhbTn+elun5/xtk/AQv3fzmBiZ6r9bCgQ79hf3sF
	7wJFj/TVEh7MFDIZVOmhqEOPA28kbiss223y+GpiOhKNIsgXwZldtc4h9w6/Se4ltznWFk0xpln
	egbL5M3lY3s+Ej8GIdGV3UU8Osn3MxyS7uFJjwZQ2HKA==
X-Google-Smtp-Source: AGHT+IETtMfsp+oxVVvJtgbE795zNbuHaeWF8ofCjtDM153d6TyT0rI+Niqk7EWeS2I9xBqTyLh7p3er1/ZJuxxHIcQ=
X-Received: by 2002:a17:907:1c07:b0:aa6:7a81:3077 with SMTP id
 a640c23a62f3a-abc09e394a1mr453579866b.54.1740170193331; Fri, 21 Feb 2025
 12:36:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213-ww_mutex-kunit-convert-v2-1-4a60be9d5aae@gmail.com>
 <20250213115951.GF28068@noisy.programming.kicks-ass.net> <CAJ-ks9mzYWSvVD=PCvCBohXg77BdFODq4ePMNstkL+70tkU5RA@mail.gmail.com>
 <20250214094856.GD21726@noisy.programming.kicks-ass.net> <CAJ-ks9kG6g8v7ADJkpuwekg_87iDVq-hPcYR+Oobrrjb-a8hfg@mail.gmail.com>
In-Reply-To: <CAJ-ks9kG6g8v7ADJkpuwekg_87iDVq-hPcYR+Oobrrjb-a8hfg@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 21 Feb 2025 15:35:57 -0500
X-Gm-Features: AWEUYZmTNrzRMQDfcvC1uKAS9y2OW_n7SKmU92RpVTg0NimjM8ab7XRa3qA78u8
Message-ID: <CAJ-ks9=BjaQJh0L3K2ywPFhP4XBxZiY9mqJzu1TsmpiH-AG9uA@mail.gmail.com>
Subject: Re: [PATCH v2] ww_mutex: convert self-test to KUnit
To: Peter Zijlstra <peterz@infradead.org>
Cc: David Gow <davidgow@google.com>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 7:37=E2=80=AFAM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> On Fri, Feb 14, 2025 at 4:48=E2=80=AFAM Peter Zijlstra <peterz@infradead.=
org> wrote:
> >
> > On Thu, Feb 13, 2025 at 10:42:24AM -0500, Tamir Duberstein wrote:
> > > On Thu, Feb 13, 2025 at 6:59=E2=80=AFAM Peter Zijlstra <peterz@infrad=
ead.org> wrote:
> > > >
> > > > On Thu, Feb 13, 2025 at 06:40:20AM -0500, Tamir Duberstein wrote:
> > > > > Convert this unit test to a KUnit test. This allows the test to b=
enefit
> > > > > from the KUnit tooling. Note that care is taken to avoid test-end=
ing
> > > > > assertions in worker threads, which is unsafe in KUnit (and wasn'=
t done
> > > > > before this change either).
> > > >
> > > > So this was something simple, and now I need to know how to operate=
 this
> > > > kunit nonsense :-(
> > > >
> > > > How is that an improvement?
> > >
> > > Hi Peter,
> > >
> > > David enumerated some of the benefits of KUnit in another
> > > thread: https://lore.kernel.org/all/CABVgOS=3DKZrM2dWyp1HzVS0zh7vquLx=
mTY2T2Ti53DQADrW+sJg@mail.gmail.com/.
> > >
> > > My personal reason for preferring KUnit is that it's much easier to
> > > run from userspace; the tooling takes care of building, starting the
> > > VM, running the tests, and producing a human-friendly report.
> >
> > Wait what -- you have to run a VM just to use Kunit? That's a hard pass=
.
> >
> > If I can't simply run it natively on my test box, its a no go. And it
> > using python also don't help, you shouldn't be needing that to load a
> > module.
>
> The tooling I mention is all optional. You can still use modprobe to
> run the test as a module or at boot. In this case you'd set:
>
> CONFIG_KUNIT=3Dy
> CONFIG_WW_MUTEX_KUNIT_TEST=3Dm
>
> and then run the test via:
>
> ```
> modprobe ww_mutex_kunit
> ```
>
> or to run at boot:
>
> CONFIG_KUNIT=3Dy
> CONFIG_WW_MUTEX_KUNIT_TEST=3Dy
>
> Link: https://www.kernel.org/doc/html/latest/dev-tools/kunit/running_tips=
.html#running-built-in-tests
> Link: https://www.kernel.org/doc/html/latest/dev-tools/kunit/running_tips=
.html#running-tests-as-modules

Gentle ping. Peter, does the above address your concerns?

