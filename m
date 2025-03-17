Return-Path: <linux-kselftest+bounces-29279-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F05A65F3E
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 21:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 315367A6A06
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 20:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E401EB5C2;
	Mon, 17 Mar 2025 20:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQP/3j1Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614E6146588;
	Mon, 17 Mar 2025 20:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742243783; cv=none; b=VsuXiEf3to548FHKhjzo8VEM9qTgTdEMj+lDRXbr2YwdUEekZRXk2Cc3Or33v+6/uLQ97doUusdDGDKRexWkw9W3yaj8owqkwUwGNYe9fRXpOk+ezj6xGf5x74HO7YFsrxolFnFJ6uNkTAYkOkXaaPpI1/cLU3ygRfw4tSWNB1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742243783; c=relaxed/simple;
	bh=qM2+6w4f6b/JlSZe8vL4wEJF46txPHCxK1AdfBHc6YU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lNhKKxtq6cm32tNzDBU/DTSMqgzb6MKx/vokC6012QvuS4CQWqOTAWGkO2EzX4nOSoRqdiH2bV7BRgiP26gr2DauaDAMaNZo8r4dN3VanKpx28Q4RgW30i3m73JrGMka4JUqsJD8F51/hAbYDjiBqEOy0rUaooGI/KeQud54An4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dQP/3j1Q; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30bfed67e08so54251831fa.2;
        Mon, 17 Mar 2025 13:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742243779; x=1742848579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qM2+6w4f6b/JlSZe8vL4wEJF46txPHCxK1AdfBHc6YU=;
        b=dQP/3j1QLPCmH/w+WCTSqiTHJbey+5DNXB+g6ZfM/GsDPU4u5ytOLIUS4LKZOXpc2R
         e7EyJksTNgF6pOsb5/c4MCiDJTavUSBrawE5q4Cpob//YXg6C92RfTfUIhl1RgBEihVE
         JwPNrWhUxnFWyt8T34Uq9r5nkZkZP2QhHOiuf3klTZSE9tReeVE/cONJyPMY81ietRGE
         zqypbx7jvP4X9Uj0C+mtl4l6DkhbHJU9DN10A9opW6HNJAak+UrofOoUXFNLBF8DZm2U
         jp2hVn5tnRgsFzsk/GUHWGTLjf/Gw1TEMSIFVCHsKpPnralZpXV/fonC7yyRbnMucPtJ
         O47Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742243779; x=1742848579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qM2+6w4f6b/JlSZe8vL4wEJF46txPHCxK1AdfBHc6YU=;
        b=hGoiJZsBlg2oPyNgbMRR4Y7NVehALdrRFnyCtjvTH3zwWN9RniWczlQg8PQmXwZp8F
         L76csH3yjh8Sam6u6AlSHEVrfwlXiITf3L96I4J+Rwsn536HL0/vDRD6b5WspI52oxOT
         EhEX7CzApNqJuFPYuRKDNaByrGnG93U4NXiwvam1uqoriNmz+9k5DW7onG6ScWs/Morj
         e2G5RBEAqSew7qxwSVc8f1tw/m8RissZftfja5t4aOT8WpWNNlvgnW28nro0SNZ3a59R
         SDm/E+Rw/Oa6iN27c6FtUzM86UArWkriqVRRe9Ads7zhsh25sv4GHYiGweptepvePb6H
         8JCA==
X-Forwarded-Encrypted: i=1; AJvYcCUmHG46IIbrW3u/d67EVZl8MbH4YopvHI6mZmpzWjiG00F2V5Xs/SZAyG454Wn5ZugZcGCig8EmVEG6@vger.kernel.org, AJvYcCVBdrz5YFNc235rpybMd8GOwxQsbxIguMEkg4SVuKVdTHiyXZ3At88qOMWpLMr53/n3zom8fCsUhcakpuzt@vger.kernel.org, AJvYcCVhHWNQJJPIwVUlnl03ZBfgRqm0aDj1b0JxZj+xUiMiXGtCqegSKsKcN5kAXvhF9jTxKGcHs37s762HmxkK@vger.kernel.org, AJvYcCW26KF/2St4AY1yugQ/9T8uRkAumRtjpnUGaanXpMSiaV7w5yKBarD4aV+LyfbYXkJvujZ/tWQpCVRl57Q=@vger.kernel.org, AJvYcCW5oRU0uZmY7obkbj71aIuXoGKUAGQueZINNyBB+qR1wFSkGOhLtxzyVrVtkLCF41MFoHwuZIuF7O4+T9fyrTM=@vger.kernel.org, AJvYcCWsS5pPCZnGf9ZgvDS46bkiJWGOK51NFUmK1N0V+YthJFYsoltWvHJj6wb42jzJ9RTeRSwzHEFYLABd@vger.kernel.org, AJvYcCXtXNDW+93GGABR5RNjnxw55+dDA5CftNFSiHeo5lJSHzlkWiCcdBXmPbL7YKvsuhOKY5jNi2ENKGFluEkClxmE@vger.kernel.org
X-Gm-Message-State: AOJu0YypM8J1jNV36LLcHkOt73/WS3DxU6iZS4fhgj1peaRUaCWbzmU0
	v2AQA9WIpPOj7ZRiXVoPZWYtV+K5cNMttWlSSN4qyB3xE+7aCZb+XjMeP4Ux9fEf/a1if2FLE6n
	CB180IujDzKZC/sVOPfbT04MDqqE=
X-Gm-Gg: ASbGncvHcjhftHMMJQbeFe05UVIzyuVqhx0+D72EjtNywqWFRWqcANMjfCp+7awnWsL
	wLNusFz5sifMZ/1SUj3bgH1YB8lccWVWgvr6vKjoGStQhOTZWVf8rajI7ClaIaNqqpGecSi2dnz
	QPUegPuHB7kFP1BJ+SJONGs/y2gI9TGF0Kn0h3EtepRn7F45ywt/47KORf8Al+IaoZHQ4rWw==
X-Google-Smtp-Source: AGHT+IH8zVr++NSNNLXeK1LLEAL53MfIwsN2fQKGrVb8hyKgIXGiHkTS2l6AtuLI3BuMwtJPdkeMKucB/6Pcq+U8mXA=
X-Received: by 2002:a2e:a4c4:0:b0:30c:50ff:1a4e with SMTP id
 38308e7fff4ca-30c50ff1acdmr75805741fa.18.1742243779142; Mon, 17 Mar 2025
 13:36:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317-ptr-as-ptr-v5-0-5b5f21fa230a@gmail.com>
 <20250317-ptr-as-ptr-v5-6-5b5f21fa230a@gmail.com> <67d85e51.050a0220.2a36b.58b3@mx.google.com>
 <CAJ-ks9kBp8zPfaQuZRb0Unms1b13hDb5cRypceO8TWFR0Ty5Ww@mail.gmail.com>
 <67d864b2.0c0a0220.39fb6f.4df4@mx.google.com> <CAJ-ks9n8mwt5q9unqfkfSHj9=ELJHtqsXM-xQ8jsbXeJX6Uyfg@mail.gmail.com>
 <67d8671d.050a0220.3305ab.6372@mx.google.com> <CAJ-ks9=uHjJrzM0ruvm4v4wr8LygRMP-1orWBy_9OiNNeQr0ow@mail.gmail.com>
 <CAJ-ks9=Qcmvbm=YGJ=jrX_+YdMsftk=FAimszYZB1OUuV4diZw@mail.gmail.com> <67d885ff.0c0a0220.111215.5644@mx.google.com>
In-Reply-To: <67d885ff.0c0a0220.111215.5644@mx.google.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 17 Mar 2025 16:35:42 -0400
X-Gm-Features: AQ5f1Jom6vkSdbmn6oaBiraATarxSi5flyvequP1N2vSDIIJ5c82kRxp43mFlwM
Message-ID: <CAJ-ks9kYB1b4XsQcFb=NScPq+R+13U+Sv-6opi-yp6=ZjuLD_g@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] rust: use strict provenance APIs
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-pci@vger.kernel.org, linux-block@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 4:28=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> On Mon, Mar 17, 2025 at 03:05:45PM -0400, Tamir Duberstein wrote:
> > On Mon, Mar 17, 2025 at 2:50=E2=80=AFPM Tamir Duberstein <tamird@gmail.=
com> wrote:
> > >
> > > On Mon, Mar 17, 2025 at 2:17=E2=80=AFPM Boqun Feng <boqun.feng@gmail.=
com> wrote:
> > > >
> > > > Then we should fix clippy or how we set msrv rather adding the stub=
.
> > > > @Miguel?
> > >
> > > I filed https://github.com/rust-lang/rust-clippy/issues/14425.
> >
> > I don't think we can wait for that to be fixed, though. Usually clippy
> > is distributed with rustc via rustup, so even if this is eventually
> > fixed, all versions between 1.84.0 and the fix will need this
> > workaround until MSRV is >=3D 1.84.0.
>
> We need to take one step back to evalute this "workaround".
>
> First, expose_provenance() and with_exposed_provenance{,_mut}() API are
> clearly defined as equavilent to `as` operation [1]. Therefore, the
> changes in this patch doing the conversion with expose_provenance() and
> with_exposed_provenance{,_mut}() don't change anything related to
> provenance in practice.
>
> I do agree we want to use the explicit provenance API, but I don't think
> we want to introduce some API that we know we will change them latter
> when we bump the rustc minimal version. So the question is: are these
> stubs what we want even though in the future our minimal rustc version
> stablizes provenance API? If not, then the cost of this patch cannot
> justify its benefits IMO.
>
> Now let's also look into why we choose a msrv for clippy, I would guess
> it's because we need to support all the versions of rustc starting at
> 1.78 and we want clippy to report a problem based on 1.78 even though
> we're using a higher version of rustc. But for this particular case, we
> use a feature that has already been stablized in a higher version of
> rustc, which means the problem reported by clippy doesn't help us, nor
> does it provide better code. Frankly speaking, I think we have other
> ways to ensure the support of all rustc versions without a msrv for
> clippy. If I was to choose, I would simply drop the msrv. But maybe I'm
> missing something.
>
> The point is tools should help us to write good and maintainable code,
> we shouldn't introduce complicated structure of code just because some
> tools fail to do its job.
>
> [1]: https://doc.rust-lang.org/std/ptr/fn.with_exposed_provenance_mut.htm=
l

Even if we globally disable this clippy lint, we still need stubs
because exposed_provenance was added in 1.79.0. Did your suggestion
address this? Perhaps I missed it.

