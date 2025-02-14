Return-Path: <linux-kselftest+bounces-26648-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2FDA35DC1
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 13:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9973188E476
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 12:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26F0263F26;
	Fri, 14 Feb 2025 12:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVrA8CdI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8B7263F32;
	Fri, 14 Feb 2025 12:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739536707; cv=none; b=ct1AK68yutGrV1OLv0Z8KsfB+HIqT8ReASdLH7jXLQKtrUjKUQf2Iys3VU77OoWzwdZRWZHqzBxGsanv56YnuW2hL4prwr8cf41bVbLk8Lwp+TUUjscq4QYE3fOkFlX2v6KcEGqOa+ZNiiVcPAUnvjm5B729Y13xU+OTkwl0Iy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739536707; c=relaxed/simple;
	bh=gSPu3zaINtQ2hE5QQA984vUerqIGwHUTIQ2qvK166l4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XY+3sYE+r3EzjUuA2cYPF+jI20QNTvyy26+nJbWtAxThTPsMe33NgSKLj4tsumUwjkC1Ck7T1mIFt1910HNIxdzss9VvA4U8Xq0b+2UAD7i4qxSBs7uGnh6riHiIRnyeA4k/rmpPOSQ7UPak5TX9PCgIH2QlI6SGPGpZTmPIcx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YVrA8CdI; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3076262bfc6so21300431fa.3;
        Fri, 14 Feb 2025 04:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739536704; x=1740141504; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gSPu3zaINtQ2hE5QQA984vUerqIGwHUTIQ2qvK166l4=;
        b=YVrA8CdI701eOG0ongXtvXEYyVRRWq/ncnCKyqXp7pKDmVFtWs75aWeEBdDT6FIaNM
         srywv9fVelag5Z5EVHqf5kHZYTGawAtfwt42T49gy87zc/5ZZB7y71wUk3qIvo4cQrdE
         c8VwVho915rYphI2ILxhB+Kjt6r/kZedvHdaAM3fIN6Mu6jVO5CbqTXj/qPYNSnUla0W
         vJ4R1Jav6y9VnfNBkPGW9WLOPZmrqNnhlh//sRfazS+7EvKrq9bc8s6PMMrZsqTcK3wA
         XMDMXNcqr93EFGWVOShoxLCu9gm29mOPexPfIl2Nt18DWqIB47YJ03pBkCj/6qsxRLEz
         SsjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739536704; x=1740141504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gSPu3zaINtQ2hE5QQA984vUerqIGwHUTIQ2qvK166l4=;
        b=Lgh+ZtM0ONIOzAz3dptwAE2+u9A/1dU7gnx/laTnjT/aySJGCsGDbwgVwVTvxCorE+
         ZKm9EDCNyrFIzlBJZTDXW5ciragkEzX9qng1JSSmTgxznt+7oEQrdfa53BYpGLUlHAFF
         QPOJubnVs29u3W1XuFpeCeVFJAKI7fkE57/VqsoCKd7HIWFmW3dsk80TvCqxX09iMnOe
         84L7sc+Q5KNL79er2+u2obYVD4OQFI0nAv2kF4ZW9VlANc5gmVjXif3lSSjjHCy2VoM2
         NmZTs/LWvPX43qU8hWJbm/zjJKqoJkrzh8tKLrqbmnfc+86Qi5Xr20JOagiP1p0sGOHA
         9gaA==
X-Forwarded-Encrypted: i=1; AJvYcCV38cjz/02QKacomiAZQ3ITDwgqAYidn617k9wHSTQKR4eVYeDIcy2CO4xYq1dE+QE+DafrlmNLPioD6hQ=@vger.kernel.org, AJvYcCVD27vhpLomxlVPVX++ziZbQt7rV+56FR1m4iDoYQbGdm6knHtAUmixPxTKif/SurvTHRWBSM/jX/zGnLayo8O6@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2CZ/Omy6Z2GFrvvtKsvXujNN9BTcYB0S0yMRLnV/s5DzuQ9D+
	yA+HphLP3f21axvllEYvX0548YIDsDQcXPVdA/+krL/rV30DAjZBPOsZwpuZgQYSm4+ZKcIYXTT
	VMEEL/Ej8jksCkiiQc29OimqZ0Uw=
X-Gm-Gg: ASbGncuYy9M65FjyriMk1aOKSqFT6pGsHiXc/V0rmeGP/Z0F581GFEj8TNJieoAP64/
	pRq5/8TqobScg9Tw5mI6xooFlQzNMAX9TN+62xtigihUfAAcHlh1HPlfmS6qHruNpjmmgEuKYlz
	qZTDB1rn+98lGAr7jpQPgzDQ2Bk1+sw7U=
X-Google-Smtp-Source: AGHT+IHGTYfsLVh9BXq48a3Ayem0jia6+jW2kw2BEwO0RvsU7V2GFEsuZ34723RE7RdhTAMfDl91vlkNlX5oioY0wFA=
X-Received: by 2002:a2e:be84:0:b0:300:25f6:9b3d with SMTP id
 38308e7fff4ca-3090dca0d0cmr28127421fa.10.1739536703681; Fri, 14 Feb 2025
 04:38:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213-ww_mutex-kunit-convert-v2-1-4a60be9d5aae@gmail.com>
 <20250213115951.GF28068@noisy.programming.kicks-ass.net> <CAJ-ks9mzYWSvVD=PCvCBohXg77BdFODq4ePMNstkL+70tkU5RA@mail.gmail.com>
 <20250214094856.GD21726@noisy.programming.kicks-ass.net>
In-Reply-To: <20250214094856.GD21726@noisy.programming.kicks-ass.net>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 14 Feb 2025 07:37:47 -0500
X-Gm-Features: AWEUYZk-wm4aTyenMdT75V7ZD2MsmSIdQL5n9jNliiKDXZ4mzVb7Lg0L8-G8dY0
Message-ID: <CAJ-ks9kG6g8v7ADJkpuwekg_87iDVq-hPcYR+Oobrrjb-a8hfg@mail.gmail.com>
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

On Fri, Feb 14, 2025 at 4:48=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Thu, Feb 13, 2025 at 10:42:24AM -0500, Tamir Duberstein wrote:
> > On Thu, Feb 13, 2025 at 6:59=E2=80=AFAM Peter Zijlstra <peterz@infradea=
d.org> wrote:
> > >
> > > On Thu, Feb 13, 2025 at 06:40:20AM -0500, Tamir Duberstein wrote:
> > > > Convert this unit test to a KUnit test. This allows the test to ben=
efit
> > > > from the KUnit tooling. Note that care is taken to avoid test-endin=
g
> > > > assertions in worker threads, which is unsafe in KUnit (and wasn't =
done
> > > > before this change either).
> > >
> > > So this was something simple, and now I need to know how to operate t=
his
> > > kunit nonsense :-(
> > >
> > > How is that an improvement?
> >
> > Hi Peter,
> >
> > David enumerated some of the benefits of KUnit in another
> > thread: https://lore.kernel.org/all/CABVgOS=3DKZrM2dWyp1HzVS0zh7vquLxmT=
Y2T2Ti53DQADrW+sJg@mail.gmail.com/.
> >
> > My personal reason for preferring KUnit is that it's much easier to
> > run from userspace; the tooling takes care of building, starting the
> > VM, running the tests, and producing a human-friendly report.
>
> Wait what -- you have to run a VM just to use Kunit? That's a hard pass.
>
> If I can't simply run it natively on my test box, its a no go. And it
> using python also don't help, you shouldn't be needing that to load a
> module.

The tooling I mention is all optional. You can still use modprobe to
run the test as a module or at boot. In this case you'd set:

CONFIG_KUNIT=3Dy
CONFIG_WW_MUTEX_KUNIT_TEST=3Dm

and then run the test via:

```
modprobe ww_mutex_kunit
```

or to run at boot:

CONFIG_KUNIT=3Dy
CONFIG_WW_MUTEX_KUNIT_TEST=3Dy

Link: https://www.kernel.org/doc/html/latest/dev-tools/kunit/running_tips.h=
tml#running-built-in-tests
Link: https://www.kernel.org/doc/html/latest/dev-tools/kunit/running_tips.h=
tml#running-tests-as-modules

