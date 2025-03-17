Return-Path: <linux-kselftest+bounces-29283-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2225A66331
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 00:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D534019A01CD
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 23:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB742063C7;
	Mon, 17 Mar 2025 23:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0DiRt24"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1519B205E31;
	Mon, 17 Mar 2025 23:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742255810; cv=none; b=VNR6gv8pKQHEVCDwGvrqA9/Wqttt9bAot5cyeordnCW4VFJwdHbXH5+z1Jw46BLxh6BAYnY3zpo06myNCQBEJXGirgRQhsShS+MHlu+AN/tr2Sy//5nNJHTcbBHBgh21bg4eg3Kh8L4I1mTfjrZ8KH8ceD9xZ12c7C5sew/vhdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742255810; c=relaxed/simple;
	bh=frsxwETiNtlFdIt0NclDqjhHJKVXXDmkYR4WAjsd2ik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sC919qKgYrhjQnjfc4YnnuYcMIFfQ61hNUZmIZZ7mKhUUmKAtHxA5xU+vhbuMFXK81oLJVrHtOoRnWxtPGp/pY6rZM8KoP/eM8TaNy/KMIcONnHrlnwPWtxwI/uv8Zyf/wzr5VlpFWNzafYGhjNtbfignVTOarVbLiUwcnYtkKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m0DiRt24; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30bf3f3539dso50564581fa.1;
        Mon, 17 Mar 2025 16:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742255806; x=1742860606; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bDzwwEX0nzK9nfZWfu0iGOntI/KAAMglHEzciFVP+Uk=;
        b=m0DiRt24srQPx/1HldJj9ZIbf3KkB07k96WCYL72gsg35KVosTow+8cxdgriO65N0s
         3FnTBKSaf2dKGLkIfFbmAcCnoNltz7+PDEiGXA9xim80aNPG1CnY11Qj+OhrJ0AnfF1V
         t7qFUkz6D8DU9y5sY7UPxVQ4PgLD3PLT5uNRdtgFEzI5exYpIWcZGIR4pGFla+Fmw5k+
         AWtg4TU2gvsz1/t82ykpUnLMayLc2pUmE7tnB+r4nKwmHIYh2dpAbrYuUM59mO7YuxDp
         V0rFQkwYFhVsaxmQ0miPA4b1bIw8b2qxrQObcH3jCKJbLVZ0VQgFQHNsXKPHU3I0keAt
         3GWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742255806; x=1742860606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bDzwwEX0nzK9nfZWfu0iGOntI/KAAMglHEzciFVP+Uk=;
        b=KR4eZqgtzIPuLbJ+cJYcPr8qWGLFGKWU4NNMXQf1cGy6dR/LRnD1zX7EKiKHfERVd3
         yDHri91jKlR1YG94DGKevrzGgOrLrNKLpLnJ4fZU8DS8L4UmlhOuN8GV/ZPwqfE2r+Xb
         Z6PcHu4TCBpVTurJ6GVMyl0b+h6QGweyLMAn8xpgZkFLL35GXYTusEJ+b2sQFcWGxhKy
         6KcRxc97YNeIMV3AlTCr41GUdXEOIXS5eoCwbYvbCFls6YfNBNMRDZwFwoSVDFTPOXqS
         0RHLnOoyn19fDBqAs4a71mVT/fPCl6H96yxyIUAlZ9Un/vHROUZY/E8OeeXwnvw5t218
         Firw==
X-Forwarded-Encrypted: i=1; AJvYcCVJw+r5uvpuMD2cmSCseIrfY6KS8978hyBQEwRTYiPkw0d80Z0ZoOd8GthEfop7BLmilIqhV1HLAOj/0PI=@vger.kernel.org, AJvYcCVuC4Jgj5+FKwRXw9AkvZI+FmiBE+aRkZYkImNmTiDpH3cQZkzAGoSYypDcwwLFeESrjS9WUKhzGDPZiHwjC9E=@vger.kernel.org, AJvYcCWOPrV72DcGSGFDM7nITIwYTX/bywYFXNSuQAeExQkhlTAPOifrAtl66r3D2BOfrwdfUXZ7L4rkdG2AaP+o2qEv@vger.kernel.org, AJvYcCWauygLtOewYOzQmLtmxv3Zv/1YpCTkDHddEBligbtmIX+AgLu5ca6WpAT6DGFvscdG2TWOz7J+Wi0pW5F+@vger.kernel.org, AJvYcCWvyiPPEice4nCWhOvm5+cK7lguoh1lKJOZOGpF3FVnTh++iobh7G86P2QPocOXw8+4G32OnKLQByto@vger.kernel.org, AJvYcCWy0c8TxD8Mn7K2Xb2Wo3sZgYBD4aDafK3uyA0z41vwfGW/4WDlqXNXknKGSW6L2OxOO5Mb0lpcYSMWw34P@vger.kernel.org, AJvYcCXJk9oyJD0KBkh7fjSWJMqcpgy/rXlu2U7Pdv71tIado3vPrP1TyS0pzOQZV+NUBpsIjiyDz+dsWjh+@vger.kernel.org
X-Gm-Message-State: AOJu0YyTQqCD5c+hIHr1sXSG7LiN+QCnwrGyWJf5aGpGYsShDYeOtm/m
	rzglB5bJdO81u1UaNZe/KlLWnY376c4N8a0O1YVeUmRco3PZZxHtIhzoUebfmUro3/AO+9f2L00
	iyiE0n/OH1H33YllgEUTlFv5lnXA=
X-Gm-Gg: ASbGncsgMx60BHrgxdaaFOfF3y2ojASARNlBqfb2XRNN6qwY0E4Lncm00jwDAAocBg5
	zldUG3O1ehLMHHw71EbTpVy9fCoCEto3I1G+7IENn8DyrhHpkJCDcilE+PijcJtV9PJ/UwFrp87
	qjk3RGuCF5+QY63Zp0FI2I0iIF4j1heUANmEr/T4/+szvK+4PDkzyCSHV1+Vri
X-Google-Smtp-Source: AGHT+IH42/4wrylLmfpOp50lcSYK/BDvlEhWGNv8TfafZeMnLoyPlmyjVCpJCsJYwJn1byhH6egKoQrrVlMd9fomBg4=
X-Received: by 2002:a2e:9495:0:b0:30b:fc16:d482 with SMTP id
 38308e7fff4ca-30cd95874bemr14031351fa.3.1742255805779; Mon, 17 Mar 2025
 16:56:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJ-ks9kBp8zPfaQuZRb0Unms1b13hDb5cRypceO8TWFR0Ty5Ww@mail.gmail.com>
 <67d864b2.0c0a0220.39fb6f.4df4@mx.google.com> <CAJ-ks9n8mwt5q9unqfkfSHj9=ELJHtqsXM-xQ8jsbXeJX6Uyfg@mail.gmail.com>
 <67d8671d.050a0220.3305ab.6372@mx.google.com> <CAJ-ks9=uHjJrzM0ruvm4v4wr8LygRMP-1orWBy_9OiNNeQr0ow@mail.gmail.com>
 <CAJ-ks9=Qcmvbm=YGJ=jrX_+YdMsftk=FAimszYZB1OUuV4diZw@mail.gmail.com>
 <67d885ff.0c0a0220.111215.5644@mx.google.com> <CAJ-ks9kYB1b4XsQcFb=NScPq+R+13U+Sv-6opi-yp6=ZjuLD_g@mail.gmail.com>
 <67d88a1d.050a0220.2cdacf.4adf@mx.google.com> <CAJ-ks9kg4Br=56HT7T5sWpoMKhRqT_2x+cpQAWoyrEG3qyqQ6Q@mail.gmail.com>
 <67d895cc.050a0220.99d33.5adc@mx.google.com>
In-Reply-To: <67d895cc.050a0220.99d33.5adc@mx.google.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 17 Mar 2025 19:56:09 -0400
X-Gm-Features: AQ5f1JrrvoV8Sf5x8icfXFWf8pyoMC94sCpioNeEDsUgPhb1ePC4caPuoCMuMpU
Message-ID: <CAJ-ks9ko3FGtpCnTwhuAb+KHwGczN_H8tM1=SQjRc3M-LgZrqA@mail.gmail.com>
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

On Mon, Mar 17, 2025 at 5:36=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> On Mon, Mar 17, 2025 at 04:53:18PM -0400, Tamir Duberstein wrote:
> > On Mon, Mar 17, 2025 at 4:46=E2=80=AFPM Boqun Feng <boqun.feng@gmail.co=
m> wrote:
> > >
> > > On Mon, Mar 17, 2025 at 04:35:42PM -0400, Tamir Duberstein wrote:
> > > > On Mon, Mar 17, 2025 at 4:28=E2=80=AFPM Boqun Feng <boqun.feng@gmai=
l.com> wrote:
> > > > >
> > > > > On Mon, Mar 17, 2025 at 03:05:45PM -0400, Tamir Duberstein wrote:
> > > > > > On Mon, Mar 17, 2025 at 2:50=E2=80=AFPM Tamir Duberstein <tamir=
d@gmail.com> wrote:
> > > > > > >
> > > > > > > On Mon, Mar 17, 2025 at 2:17=E2=80=AFPM Boqun Feng <boqun.fen=
g@gmail.com> wrote:
> > > > > > > >
> > > > > > > > Then we should fix clippy or how we set msrv rather adding =
the stub.
> > > > > > > > @Miguel?
> > > > > > >
> > > > > > > I filed https://github.com/rust-lang/rust-clippy/issues/14425=
.
> > > > > >
> > > > > > I don't think we can wait for that to be fixed, though. Usually=
 clippy
> > > > > > is distributed with rustc via rustup, so even if this is eventu=
ally
> > > > > > fixed, all versions between 1.84.0 and the fix will need this
> > > > > > workaround until MSRV is >=3D 1.84.0.
> > > > >
> > > > > We need to take one step back to evalute this "workaround".
> > > > >
> > > > > First, expose_provenance() and with_exposed_provenance{,_mut}() A=
PI are
> > > > > clearly defined as equavilent to `as` operation [1]. Therefore, t=
he
> > > > > changes in this patch doing the conversion with expose_provenance=
() and
> > > > > with_exposed_provenance{,_mut}() don't change anything related to
> > > > > provenance in practice.
> > > > >
> > > > > I do agree we want to use the explicit provenance API, but I don'=
t think
> > > > > we want to introduce some API that we know we will change them la=
tter
> > > > > when we bump the rustc minimal version. So the question is: are t=
hese
> > > > > stubs what we want even though in the future our minimal rustc ve=
rsion
> > > > > stablizes provenance API? If not, then the cost of this patch can=
not
> > > > > justify its benefits IMO.
> > > > >
> > > > > Now let's also look into why we choose a msrv for clippy, I would=
 guess
> > > > > it's because we need to support all the versions of rustc startin=
g at
> > > > > 1.78 and we want clippy to report a problem based on 1.78 even th=
ough
> > > > > we're using a higher version of rustc. But for this particular ca=
se, we
> > > > > use a feature that has already been stablized in a higher version=
 of
> > > > > rustc, which means the problem reported by clippy doesn't help us=
, nor
> > > > > does it provide better code. Frankly speaking, I think we have ot=
her
> > > > > ways to ensure the support of all rustc versions without a msrv f=
or
> > > > > clippy. If I was to choose, I would simply drop the msrv. But may=
be I'm
> > > > > missing something.
> > > > >
> > > > > The point is tools should help us to write good and maintainable =
code,
> > > > > we shouldn't introduce complicated structure of code just because=
 some
> > > > > tools fail to do its job.
> > > > >
> > > > > [1]: https://doc.rust-lang.org/std/ptr/fn.with_exposed_provenance=
_mut.html
> > > >
> > > > Even if we globally disable this clippy lint, we still need stubs
> > > > because exposed_provenance was added in 1.79.0. Did your suggestion
> > > > address this? Perhaps I missed it.
> > >
> > > No, I didn't.
> > >
> > > That's a separate topic though, because I can see the argument that:
> > > because with_exposed_provenance() is a function rather than a method,=
 it
> > > won't be very benefical to use ptr::with_exposed_provenance() instead=
 of
> > > kernel::with_exposed_provenance(), therefor these stubs of
> > > exposed_provenance make sense to exist. But I don't think the same
> > > argument works for ptr::{with_,map_,}addr().
> >
> > What about `pointer::expose_provenance`? It's a method that was added i=
n 1.79.0.
> >
>
> We have a few options:
>
> 1) we can decide to use funtion-version of expose_provenance() (i.e. the
>    stub), if we feel the symmetry with with_exposed_provenance() is
>    a strong rationale. This also means we won't likely use
>    pointer::expose_provenance() in the future. That is, although kernel
>    doesn't have stable internal API, but in the foreseeable future, we
>    decide to use funtion-version of expose_provenance().

I don't think we want these stubs forever.

> 2) we can introduce a PtrExt trait for <1.79
>
>    pub trait PtrExt<T> {
>        fn expose_provenance(self) -> usize;
>    }
>
>    and
>
>    impl<T> PtrExt<T> for *const T {
>         ...
>    }
>
>    and `PtrExt` in kernel::prelude.
>
>    (we need to #[allow(unstable_name_collisions)] to make that work)

I like this idea, but I can't get it to work. When both inherent and
trait methods are available, the compiler seems to prefer the inherent
method.

>    We can also make with_exposed_provenance() use the same *Ext trick,
>    and remove it when we bump the minimal rustc version.

This part I don't understand. What would we impl the Ext on, given
that `with_exposed_provenance` is a free function?

Option 3) take this series without the last commit, and revisit when
MSRV >=3D 1.79.0 or >=3D 1.84.0?

