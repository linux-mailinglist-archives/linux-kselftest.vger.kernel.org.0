Return-Path: <linux-kselftest+bounces-29281-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B79A65FC1
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 21:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBB153A7533
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 20:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6E21F5847;
	Mon, 17 Mar 2025 20:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ufn9d1OB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7267B1FAA;
	Mon, 17 Mar 2025 20:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742244839; cv=none; b=slVTJJGiyRembXW4ukZFdiZPee94i8BfeAzS+J4zLwws02rtLCiTW0F1I/PmtQHFxVgZpGdCQQj1i68N8s4JYUWKyDV8xU8iD86y+V88DKaBCW2qFLmiWh3lYD70OxXSXCKa0chY0xF71ZxCyHju57bt3/AFq0CLX/agFDjKHYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742244839; c=relaxed/simple;
	bh=KlI3weZmMb7UBcc+vTrqmuuAvlDYDnoUkXYCOoZl4aM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bmSQCQng7uJRO72Rfxo1trpO8Q2BeZsKMWn0+mi+OdCNRzXDzQtIRRERigxYvVpustP8JpbJfGcNL33ToeOxQHV/sqXfhIljEN6/unIi1BcgY40GQVbfAdDly1+9RI3ZSY4ZiQkJsjljRRCLBK4FDOcwKLm4Hk3iYDqC0jD6nf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ufn9d1OB; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30c416cdcc0so48430781fa.2;
        Mon, 17 Mar 2025 13:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742244835; x=1742849635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KlI3weZmMb7UBcc+vTrqmuuAvlDYDnoUkXYCOoZl4aM=;
        b=Ufn9d1OByJqsR1K4V+L+nFS08Q1v2SIqNfMtPOoAcI3ZOb0AbWiLcjbBC4JFGpD7dS
         hrc+Vn/6LVVottLFX5tTz3ihU00mVcFu7uMBvtXvDrRvmiAEe3D7mEPbRAtD0JsFJDly
         aJDFlYWaboGmB5kNOOKggeWjpJ8UXgfauWuFGIuRokT1FZzmKjNGnoWk/sVnT98RkcpV
         HcLFI3T1ezS8sNAiN5IhFcN2HYU8JbIdUTZhvKlKgHtlUBPZY2krSlBVOnDoe5eMbogz
         n2uWL8UuULDkA10HLMCsrv5pUCwrYijLERGi6IJYPD7aac8xoa7ZakkFvKgAkRqq9Pt6
         EqxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742244835; x=1742849635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KlI3weZmMb7UBcc+vTrqmuuAvlDYDnoUkXYCOoZl4aM=;
        b=Hiv8U+UqNppmYP5Q9cyqab2KoySmhgtf5FRFMKu9UbA978QrOzqKhtsh/veHjhMAOD
         UWquH5ZrFJO45zr/LjVMH6BIwzvfIBPGfP8IWKdS2oK8AFDIXjQMhqBBT9GTH3sZqlxW
         KS53OgLHBhoKSthVyVuQs0ELDunl4UCZ4CepoFdNRS4GGintv3EgxWbQs54naxeMNoo4
         f/itD58BysHPFoDlERrkYe6ZDvdAkPSmAC3Aj9t8wor48m85KGEiUjkBJCxaxImdTgb5
         uebLvR7XB6Y2xmOhsVfn02/3M5p5xIRVy2rPKV9nt8+xEdQ34GuXhI7oZmDLMp5CWd9i
         6V5A==
X-Forwarded-Encrypted: i=1; AJvYcCU4/kUZct4UaCXp+L/M2sNbrjYXZhQtP2VlbKX3KLXr4ZzIUR2zvGVAf6T7wPV6WUNsDZdY1eigtmTw8cfnL9BA@vger.kernel.org, AJvYcCV6yNb9hOD/ZhWr5Xdzkl7UHlvcqFY4Za20AmHPIBEg3zNsEm5XnW34TWULq/lZVQzloM25Z0oTPwW4Eb8=@vger.kernel.org, AJvYcCVF4iSEFS8KIM7q+tMmcqDLlO4SoQHEN8RnkW0dMvkX7mzdZu3YduUMuaq9hulKzEzj7K6F+/w09qQT@vger.kernel.org, AJvYcCW63aASKSF1kXpv6xU+9XtgPkZabsM7OuMWeb1qy7sQC1tGwgqf7EFuRv7VhTvSQpwE/kXx0wIG7r9/NUKW@vger.kernel.org, AJvYcCW69W5CJxlSTG20ZD1b8Ss7+1I8IwCaAMDksCzsdC2edlnkOUS+XWOR21nZFocRmUvv+BhT8mtnFtObpvwq8mY=@vger.kernel.org, AJvYcCXOo95WiPci5LNjLC804n7TBh575HDWYLBfFuM3J75+2CnYbEUfzIpPd9C/coRZ67jRkLUoa7i+Ub8Mdcdu@vger.kernel.org, AJvYcCXP4J+X4ihHgYbDW71wYKeqTNeekbsfagyM3AkyP+I0ooqojCwWemsVqqAHNLSthpVEgCd4owDstWCK@vger.kernel.org
X-Gm-Message-State: AOJu0YyBoMQSmsvqBW2Z4ri/8K43rkTVA2wVvhSmZwEx20JhaBgCxIz5
	JSu+wYbVXH1f+nbfbYsN5MLWysIdUGy0MlGOvdITn9AVRMAtNVXKu8m6zgzBor6W983DQW4dnAs
	n7YXKA7gzgv2Ahm4klQFrkvknx5A=
X-Gm-Gg: ASbGncs+Zl4MPDbGyC2cghmsd/DSoVQBg54cNiH6lxSo3sGd1hqvP3gEFJtBbSxC60g
	Nt6WK+GEUaZ89aPmwLgCoUE/wXNIQql/X3BqXGyNhkmkxu9pFjqTZl4D2C6zomZKbDx8PesEBCX
	Mu7xLDStIIreCtrmKpZNS5oqn5TZOffoVXLTkwS7a6tifMejov6pyGTOc6rz/17H2c31Ve+w==
X-Google-Smtp-Source: AGHT+IFPg2CilyC/yRn0FqNWWjlhR/i+eybYliH+QEy5P4t2b2uIP11qVzrcsdZpGtSt6sSQUzlmAvaXay9DTPUjtbQ=
X-Received: by 2002:a2e:a542:0:b0:30b:9813:b00e with SMTP id
 38308e7fff4ca-30c4a8d8bbfmr98452891fa.24.1742244835176; Mon, 17 Mar 2025
 13:53:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317-ptr-as-ptr-v5-6-5b5f21fa230a@gmail.com>
 <67d85e51.050a0220.2a36b.58b3@mx.google.com> <CAJ-ks9kBp8zPfaQuZRb0Unms1b13hDb5cRypceO8TWFR0Ty5Ww@mail.gmail.com>
 <67d864b2.0c0a0220.39fb6f.4df4@mx.google.com> <CAJ-ks9n8mwt5q9unqfkfSHj9=ELJHtqsXM-xQ8jsbXeJX6Uyfg@mail.gmail.com>
 <67d8671d.050a0220.3305ab.6372@mx.google.com> <CAJ-ks9=uHjJrzM0ruvm4v4wr8LygRMP-1orWBy_9OiNNeQr0ow@mail.gmail.com>
 <CAJ-ks9=Qcmvbm=YGJ=jrX_+YdMsftk=FAimszYZB1OUuV4diZw@mail.gmail.com>
 <67d885ff.0c0a0220.111215.5644@mx.google.com> <CAJ-ks9kYB1b4XsQcFb=NScPq+R+13U+Sv-6opi-yp6=ZjuLD_g@mail.gmail.com>
 <67d88a1d.050a0220.2cdacf.4adf@mx.google.com>
In-Reply-To: <67d88a1d.050a0220.2cdacf.4adf@mx.google.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 17 Mar 2025 16:53:18 -0400
X-Gm-Features: AQ5f1JrMBr2j1yxvBGKk80_vMPrae0IAXWwy2F6-hv3iWV_T28Ww6wllNGvSvf8
Message-ID: <CAJ-ks9kg4Br=56HT7T5sWpoMKhRqT_2x+cpQAWoyrEG3qyqQ6Q@mail.gmail.com>
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

On Mon, Mar 17, 2025 at 4:46=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> On Mon, Mar 17, 2025 at 04:35:42PM -0400, Tamir Duberstein wrote:
> > On Mon, Mar 17, 2025 at 4:28=E2=80=AFPM Boqun Feng <boqun.feng@gmail.co=
m> wrote:
> > >
> > > On Mon, Mar 17, 2025 at 03:05:45PM -0400, Tamir Duberstein wrote:
> > > > On Mon, Mar 17, 2025 at 2:50=E2=80=AFPM Tamir Duberstein <tamird@gm=
ail.com> wrote:
> > > > >
> > > > > On Mon, Mar 17, 2025 at 2:17=E2=80=AFPM Boqun Feng <boqun.feng@gm=
ail.com> wrote:
> > > > > >
> > > > > > Then we should fix clippy or how we set msrv rather adding the =
stub.
> > > > > > @Miguel?
> > > > >
> > > > > I filed https://github.com/rust-lang/rust-clippy/issues/14425.
> > > >
> > > > I don't think we can wait for that to be fixed, though. Usually cli=
ppy
> > > > is distributed with rustc via rustup, so even if this is eventually
> > > > fixed, all versions between 1.84.0 and the fix will need this
> > > > workaround until MSRV is >=3D 1.84.0.
> > >
> > > We need to take one step back to evalute this "workaround".
> > >
> > > First, expose_provenance() and with_exposed_provenance{,_mut}() API a=
re
> > > clearly defined as equavilent to `as` operation [1]. Therefore, the
> > > changes in this patch doing the conversion with expose_provenance() a=
nd
> > > with_exposed_provenance{,_mut}() don't change anything related to
> > > provenance in practice.
> > >
> > > I do agree we want to use the explicit provenance API, but I don't th=
ink
> > > we want to introduce some API that we know we will change them latter
> > > when we bump the rustc minimal version. So the question is: are these
> > > stubs what we want even though in the future our minimal rustc versio=
n
> > > stablizes provenance API? If not, then the cost of this patch cannot
> > > justify its benefits IMO.
> > >
> > > Now let's also look into why we choose a msrv for clippy, I would gue=
ss
> > > it's because we need to support all the versions of rustc starting at
> > > 1.78 and we want clippy to report a problem based on 1.78 even though
> > > we're using a higher version of rustc. But for this particular case, =
we
> > > use a feature that has already been stablized in a higher version of
> > > rustc, which means the problem reported by clippy doesn't help us, no=
r
> > > does it provide better code. Frankly speaking, I think we have other
> > > ways to ensure the support of all rustc versions without a msrv for
> > > clippy. If I was to choose, I would simply drop the msrv. But maybe I=
'm
> > > missing something.
> > >
> > > The point is tools should help us to write good and maintainable code=
,
> > > we shouldn't introduce complicated structure of code just because som=
e
> > > tools fail to do its job.
> > >
> > > [1]: https://doc.rust-lang.org/std/ptr/fn.with_exposed_provenance_mut=
.html
> >
> > Even if we globally disable this clippy lint, we still need stubs
> > because exposed_provenance was added in 1.79.0. Did your suggestion
> > address this? Perhaps I missed it.
>
> No, I didn't.
>
> That's a separate topic though, because I can see the argument that:
> because with_exposed_provenance() is a function rather than a method, it
> won't be very benefical to use ptr::with_exposed_provenance() instead of
> kernel::with_exposed_provenance(), therefor these stubs of
> exposed_provenance make sense to exist. But I don't think the same
> argument works for ptr::{with_,map_,}addr().

What about `pointer::expose_provenance`? It's a method that was added in 1.=
79.0.

We can certainly disable the clippy lint rather than add stubs for
`pointer::{with_,map_,}addr`, but it doesn't bring us to a solution
where only free functions require stubs.

