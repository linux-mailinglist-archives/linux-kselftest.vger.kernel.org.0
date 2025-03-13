Return-Path: <linux-kselftest+bounces-28977-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9F7A5FE8E
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 18:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF6941763FF
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 17:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5E51EB9E2;
	Thu, 13 Mar 2025 17:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bOLJq327"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAC61E51EE;
	Thu, 13 Mar 2025 17:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741888249; cv=none; b=YwYMAFGjqkH0RMb62XFDe+U2DMqdwD4f68rtOt6bd1PfYu1DEyZ3Jo7RFwAX50/xp0gtrhPOmfpck1wrSUwPCgURics+0OnxvVA+kW1CNSh/koG2x8rdyRuF5jmzKQa7M1M+z5LFFDE/ACKmJHEirYlpjTVvRnxHM5wI5al9SYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741888249; c=relaxed/simple;
	bh=Sn4jBdPuMSBTZTRkdxMXVnCXjlwAwsRkCucu9R2NrfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZEyvHXnPmlE/OGIdI8MGugdR6NuiSxTWpvRj985DQxYLGjo40Zb/EGR5Gg2i1w+4hYzhZI6NS4LUDEJLEO87cj5qMcCskgvVsFE8j0O1c1aneGBUz/syI6YM4vJPt2Ho0/svbqZAEsf/dJWmmPi4tuWi6jFZvWS84VEFg/2mmkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bOLJq327; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-30bfca745c7so11602671fa.0;
        Thu, 13 Mar 2025 10:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741888246; x=1742493046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zKFpAn86ZKK0Tcm/VY5RgvZM4eSEDC/dgaX7ueRRzeU=;
        b=bOLJq327yzjcYNOH5rYbTnM6xssHxMlX51y1wzcyDViRxxnAjnaxGN27dPuzdNtHif
         Eyz3Dt7ABAiqqf5ZpIlF5ybf2bzwX4zm/pQ9oUStiuEwFerRKS9X5KYjmrCHa+0xGb8J
         A2Qmwibv5NIu9ox82qTcrovoTlxhe9tcuwAhDfy4WdkgniTTSEzZPah2lY0qhdkXIDXZ
         iJVQcGSXr0Gj+3Q1r22sBkBrnzEmBELUnFJ8o8WQ43zNQTQLZz3Yc+np7uohBUK2q4v1
         ubw4X1USd1HSyE+2iWxnfs91B4roRKv+1oegj6aP77Mhg4ZFmJjJnUZ0JyzNXjNBNnIx
         /chQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741888246; x=1742493046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zKFpAn86ZKK0Tcm/VY5RgvZM4eSEDC/dgaX7ueRRzeU=;
        b=ubVsLtrcytDOKc6zI5kbExYAEoWjhb6nFW07DMnKMd0U8s9iDpz4h3Fs9h70P7xxYh
         sYk4LqyTH1nBQK11ZV56D5M0FOsGEjEJVTtLdZDwoiX6Zio85fDqGklOhmpzzlIrA8jB
         /yOIuJwK+XzJahRx7+bFAgWM8eI+zwMz0+ND8SIEwDNu28ZcWbG8S5EFUme7Vk3N2zrx
         2r/a39rKL3ihgIZqtJ3F+mfP7b35TTAyYTOk8nCg9XVICxSicM7vAb9CKZRWvHIcNE60
         /wrg2Go0L645NVLj67cY+P9yN0XAsS4iElM3Pp4M3JpKK1HfvOzRWbg5NvFbCafFQisl
         jDbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUObPY/oUYiqG898qWCujH6hotAupTrU4LD6q6cRKeW2Lq10LITqDJdlAWcnVMqzvBxmdAWw/3hOZ7k@vger.kernel.org, AJvYcCVGZna7sZANdlgPDT9Th8Wy77zcQ9B7mMudlUWdDMwNZjE6oExoJ9W+1MzgJfcPya34OPyfMs+UN9OXOTMh@vger.kernel.org, AJvYcCVKbHfmD3n/5OK6J0knWLTcsfl6BaLqR9wxI2S9aVFMUAKesf6bJ847ES5+VfexrZm3VIrTPWtT1QHW@vger.kernel.org, AJvYcCVeJ7X2nHdvZSxFw5uRt9TxJgNKU4QwDuLwMNoArVyvqYF5D8xQNdvDM2YX0gSfDLSERSU98/CNr7RmcTTTaus=@vger.kernel.org, AJvYcCWIUxGvsnNwWL3KWFPam9M9uLYUrhNLljdtXSEl8DYinmAA67fI5xs/BXp+yNWVy/K1mlGlANsMxFCgMKDIcu3D@vger.kernel.org, AJvYcCX1GB0OpE2cvWR7rME/odIrvFYCtzZN2C+TT0U1P3LJkLbZ+ecOOP03Hn0xfhNsdh4QIaZnnAVNvPP70a4=@vger.kernel.org, AJvYcCXP8Z7pWpEZBLa3XuqdnkinmhBjWVHENXBgcmkxw7VlN7+zCQR2J0Pck2BvtN7mFs88Af//KE4wqy+dE6pV@vger.kernel.org
X-Gm-Message-State: AOJu0YzamTYQrKkSnC8eNF50ZWTG5KUwKK/OOEd0rYFK5hneE2IybszZ
	H1uVdQeYlWci5x07trv1LshX3rEqp3IuZ8dzjL5lOoa/JhVMFSx7x116s/w0c2rwAIY0fi/Jhsr
	Mu4//njcR3Fdf8c7rvhMUxA3c668=
X-Gm-Gg: ASbGncvjjma85h5eD1gv0iTUikQ0gMIfCgI2N+QhGwlU/eXtgI0rZ/w+lwoxEaPocqY
	wWCdM97cmealdxIihWJ0OxAnn9BzXaDF3nIxq/EqNKbqv++WX1/J0D/3JIifSaPvjkkpBkMtJah
	n5i1IvxdHiiGk3CSiMNi/XQuKjcq0ux4i2Aw5ZwS4h2Q==
X-Google-Smtp-Source: AGHT+IFSCHPEFcd03p5HDh9sP6FYCsfZFC/DkMEfdC+Yt81z67oc/lXycRAIL+nUauhtNQVUeMxDtmcjr2PbVMhFYso=
X-Received: by 2002:a2e:bc08:0:b0:30b:b987:b6a7 with SMTP id
 38308e7fff4ca-30c46a49b18mr3205021fa.0.1741888245386; Thu, 13 Mar 2025
 10:50:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250309-ptr-as-ptr-v2-0-25d60ad922b7@gmail.com>
 <CAJ-ks9kCgATKDE2qAuO3XpQfjVO2jGyq3D4sbUcVKyW6G1vuuQ@mail.gmail.com>
 <D8EL9QFS1XNT.JBSMRXD4D7GT@proton.me> <CAJ-ks9=TRDg3g=NG7k97P_5jXpZ4K4v0DxrmJFR+uF0-3zJkXw@mail.gmail.com>
 <CAJ-ks9=hAwOGtVv0zh9CcH7XOxjGnizvK1QOMAi8nKStocKr2Q@mail.gmail.com>
 <D8ELW7X9796K.2ZGJS34LDTHOP@proton.me> <CAJ-ks9k1gZ=tLSe6OjuKFgg6=QE5R_Ajo0ZJwZJp08_1LMiODw@mail.gmail.com>
 <D8ENBWTC8UPH.LLEGZ2D4U7KQ@proton.me> <CAJ-ks9mJ=2hFxfWEkq+9b=atE89sHXa5NBcdVNRd3az6MSv0pA@mail.gmail.com>
 <D8F76A4JSEXO.2OKKJLAU5OZN@proton.me>
In-Reply-To: <D8F76A4JSEXO.2OKKJLAU5OZN@proton.me>
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 13 Mar 2025 13:50:06 -0400
X-Gm-Features: AQ5f1JrNIpV1nyfNQKmWtrjHu1S5LHEkKspW_ObMJhGTNdWLSLayQ_veUoqdoQU
Message-ID: <CAJ-ks9n1oGAGSrXYWjvR+_raw8h+skkdfSYpeSuQZ9jEs5q-6Q@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] rust: enable `clippy::as_underscore` lint
To: Benno Lossin <benno.lossin@proton.me>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-pci@vger.kernel.org, linux-block@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 10:11=E2=80=AFAM Benno Lossin <benno.lossin@proton.=
me> wrote:
>
> On Thu Mar 13, 2025 at 11:47 AM CET, Tamir Duberstein wrote:
> > On Wed, Mar 12, 2025 at 6:38=E2=80=AFPM Benno Lossin <benno.lossin@prot=
on.me> wrote:
> >>
> >> On Wed Mar 12, 2025 at 11:24 PM CET, Tamir Duberstein wrote:
> >> > On Wed, Mar 12, 2025 at 5:30=E2=80=AFPM Benno Lossin <benno.lossin@p=
roton.me> wrote:
> >> >>
> >> >> On Wed Mar 12, 2025 at 10:10 PM CET, Tamir Duberstein wrote:
> >> >> > On Wed, Mar 12, 2025 at 5:04=E2=80=AFPM Tamir Duberstein <tamird@=
gmail.com> wrote:
> >> >> >>
> >> >> >> On Wed, Mar 12, 2025 at 5:01=E2=80=AFPM Benno Lossin <benno.loss=
in@proton.me> wrote:
> >> >> >> > Always enable the features, we have `allow(stable_features)` f=
or this
> >> >> >> > reason (then you don't have to do this dance with checking if =
it's
> >> >> >> > already stable or not :)
> >> >> >>
> >> >> >> It's not so simple. In rustc < 1.84.0 the lints *and* the strict
> >> >> >> provenance APIs are behind `feature(strict_provenance)`. In rust=
c >=3D
> >> >> >> 1.84.0 the lints are behind `feature(strict_provenance_lints)`. =
So you
> >> >> >> need to read the config to learn that you need to enable
> >> >> >> `feature(strict_provenance_lints)`.
> >> >>
> >> >> I see... And `strict_provenance_lints` doesn't exist in <1.84? That=
's a
> >> >> bit of a bummer...
> >> >>
> >> >> But I guess we could have this config option (in `init/Kconfig`):
> >> >>
> >> >>     config RUSTC_HAS_STRICT_PROVENANCE
> >> >>             def_bool RUSTC_VERSION >=3D 108400
> >> >>
> >> >> and then do this in `lib.rs`:
> >> >>
> >> >>     #![cfg_attr(CONFIG_RUSTC_HAS_STRICT_PROVENANCE, feature(strict_=
provenance_lints))]
> >> >
> >> > Yep! That's exactly what I did, but as I mentioned up-thread, the
> >> > result is that we only cover the `kernel` crate.
> >>
> >> Ah I see, can't we just have the above line in the other crate roots?
> >
> > The most difficult case is doctests. You'd have to add this to every
> > example AFAICT.
> >
> >> >> > Actually this isn't even the only problem. It seems that
> >> >> > `-Astable_features` doesn't affect features enabled on the comman=
d
> >> >> > line at all:
> >> >> >
> >> >> > error[E0725]: the feature `strict_provenance` is not in the list =
of
> >> >> > allowed features
> >> >> >  --> <crate attribute>:1:9
> >> >> >   |
> >> >> > 1 | feature(strict_provenance)
> >> >> >   |         ^^^^^^^^^^^^^^^^^
> >> >>
> >> >> That's because you need to append the feature to `rust_allowed_feat=
ures`
> >> >> in `scripts/Makefile.build` (AFAIK).
> >> >
> >> > Thanks, that's a helpful pointer, and it solves some problems but no=
t
> >> > all. The root Makefile contains this bit:
> >> >
> >> >> KBUILD_HOSTRUSTFLAGS :=3D $(rust_common_flags) -O -Cstrip=3Ddebugin=
fo \
> >> >> -Zallow-features=3D $(HOSTRUSTFLAGS)
> >> >
> >> > which means we can't use the provenance lints against these host
> >> > targets (including e.g. `rustdoc_test_gen`). We can't remove this
> >> > -Zallow-features=3D either because then core fails to compile.
> >> >
> >> > I'm at the point where I think I need more involved help. Want to ta=
ke
> >> > a look at my attempt? It's here:
> >> > https://github.com/tamird/linux/tree/b4/ptr-as-ptr.
>
> With doing `allow(clippy::incompatible_msrv)`, I meant doing that
> globally, not having a module to re-export the functions :)

Yeah, but I think that's too big a hammer. It's a useful warning, and
it doesn't accept per-item configuration.

> >> I'll take a look tomorrow, you're testing my knowledge of the build
> >> system a lot here :)
> >
> > We're guaranteed to learn something :)
>
> Yep! I managed to get it working, but it is rather janky and
> experimental. I don't think you should use this in your patch series
> unless Miguel has commented on it.
>
> Notable things in the diff below:
> * the hostrustflags don't get the *provenance_casts lints (which is
>   correct, I think, but probably not the way I did it with filter-out)
> * the crates compiler_builtins, bindings, uapi, build_error, libmacros,
>   ffi, etc do get them, but probably shouldn't?

Why don't we want host programs to have the same warnings applied? Why
don't we want it for all those other crates?

I'd expect we want uniform diagnostics settings throughout which is
why these things are in the Makefile rather than in individual crates
in the first place.

Your patch sidesteps the problems I'm having by not applying these
lints to host crates, but I think we should.

