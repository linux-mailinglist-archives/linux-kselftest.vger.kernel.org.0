Return-Path: <linux-kselftest+bounces-28916-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D32A5F183
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 11:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F14327ACB96
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Mar 2025 10:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8E4267B89;
	Thu, 13 Mar 2025 10:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4B8bsFU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D230E13C689;
	Thu, 13 Mar 2025 10:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741862905; cv=none; b=Lr3ZisLECGo7wdK14ptl/VDG7brBqcpPh7S08vnVOO0BAYs8l3Wj9AC0J4aQa7TLdSlDIlDSIBkTJtWKQgbK8ZRE9+uQgR7Qj7FifMR1Si1wVwNRcXN22GgxtmHjq7jbgSjmlyun4NkkCNW5PQ+20BlnDuL6Uf22/GH75oJSvwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741862905; c=relaxed/simple;
	bh=NTvv7eK4pWA0tU7itqQwNc79CFE8kY/nvAPtwxhpCN8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aZp/RaZL4ELDFD5FiIgPskolbzhvF0gQN5upzD8DtalijM4kgNesaTbByggA7Up14JNS2RJ1nQQYqEdT+ERsz5441Cn1181xcsvICysg4bBUcTE3rKRiWPMAlj6A3spDth6XX/hQfqtjGuJKh7W15MRR5l98/IVrNiVX0l5GeOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h4B8bsFU; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30bf1d48843so7199451fa.2;
        Thu, 13 Mar 2025 03:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741862901; x=1742467701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IU4PHlrJ+sa0If2/fuT4pY69xSIqLjUfkdogKvImc9o=;
        b=h4B8bsFUH1HdLVPKmLXUfYkJEjpFHpsaGPQ+33ZhIJNnLo4eDtkqFSkLVPEz8b9EoL
         qNOAJb4pxcf87xlLgyEG+ygIThQi6ogQS2ksGD3l2k40csaGV5xlnYbUgNldAz0PROuB
         ngmPFbt4bM/sJXWfDm/+YrNhM42oUuWN4MqHa0EYIyykhnuXyHzAgpskQG/8PBabqMWD
         NtrsNubPvd6FhJNVXADyCnlIE4tVCDxrpnZudFotlyCnxQJUGpWwgtyHoDoJigdYrWcY
         Dh5mp4DIccZrxwZEP2VXamE8vQYgOH+6vqAUce8h+uAsJchZJknvvjzmsGixBEsh172q
         z/NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741862901; x=1742467701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IU4PHlrJ+sa0If2/fuT4pY69xSIqLjUfkdogKvImc9o=;
        b=g2J3zzt+9RgO5hxHNKklt2vXpelt4/53h6BhwVTtqZyB/xWVWjrHoMg2Z9W8O3fs+g
         TVNBvzzeSuw5bpfiwl5M3Y+2Dw3Ba77hH9C3P++/bID1QzfxyUbBp7XcO70oFwkW/cX1
         UVvssiQEoabYoYhVw3fmqxAj0UsoDKSA3moVa7BtlCBE57vJM2WGvTN3V/S8Sxtvr7VG
         Oq8XiZ3yAsQyzNhe0Ax3EQLpXIk9gSzWbY2+Qls7MmoFBXc1c4npeAN+wp7nMzsPD8X+
         yVmhHiEPIEQH8/edHUSLLQz3NkTbXHJ0LSuVPIIS4tmvfH+1ROOp1x+1C+UvL8PuxbEo
         il1w==
X-Forwarded-Encrypted: i=1; AJvYcCURfAwDLehj0CXNB+Zk4vpnbcGTlXijz8ZwlJqrpHV4ei9mEkkPzKiyivtTxG9pJMPBceCTjav7/UdD@vger.kernel.org, AJvYcCUbuoyDgEl5iBNcT3yCkbCCRF8ft7mlNGbiaV1yREFY9HTH6S31ockINFkfnY7Sbef8KJfEV85YeqlDAI4=@vger.kernel.org, AJvYcCUslkPs/gKM/lboKd6jmVol2OIGHG68c5yaPaHxp84in3x+q+ii3vs8S/sglhQXXvp3Z1+8OlPYdLzt7LDSUT0z@vger.kernel.org, AJvYcCVZkuIrA3lecUbvxzqFSWDj+32+ghV7OnWv7j+eUukvHGHwUUHWyc3ygVGeyZFIW25XhAjEf1ap3O+HX3+Ao2M=@vger.kernel.org, AJvYcCVxo5hb1numaXp/a9SldgHcAHGH4OOq+clHfTUj9LRwN0cOci/hohIkdDIbyI3ZYe3rAa5tIwWZxpQ1Ktx5@vger.kernel.org, AJvYcCWLVxTqLYxL/kylYzcHuuTIEoi8P3rB1i+dsTo5DfCiaHr+XEpVM73CCQyoeiUBdc44378h/css/7ORs/Dg@vger.kernel.org, AJvYcCWb2IQ9c7cSMsvg0rK6RG++H2pigxJm1q6OMkuO50gTr8uWtD9TabAiVXiSiUhtH9Y/LRtrs/woWmP3@vger.kernel.org
X-Gm-Message-State: AOJu0YzUdroeewBK+lzWBPjGLZQtvoze05GwIWimAbE3KE+BvPp/JfGi
	aCPNvu0RVMQcx6HO5+z1WX5FbTsLg8DgTby4qsRo1usmf+GEHakMdtH5sOH0vrEe2wtccUHnYpx
	hYod0Wx6ls+EKZlbUUcJhUZqecrQ=
X-Gm-Gg: ASbGnct4I8y7HS1/oxIfuAA0xCIBpRhC5wDDE05SSykOxbQhPxGDIcx0fT+H9i1BB1u
	lhreQ0mikg1ani2kMSYeAFyJ8Ui/O5XHmUnEoluNgQfXuZtXOHoqERNvYkNICuooYIhtc2zCmvB
	6nSI77SQg2wuK6se+EMrgXHkXruziHV+Ba25FidL2/z4ES4TpkGpRwCaj2y4yl
X-Google-Smtp-Source: AGHT+IGowr6w1dXmTWQTcCHSJ8F0Lzgjpfr6l5SxosTwGeAYfAxqaTTaJIQl2YIbjX0BGAMKbRP0NSO2ddhYR2C1llk=
X-Received: by 2002:a2e:3517:0:b0:30b:edd8:886 with SMTP id
 38308e7fff4ca-30bf451713dmr84066751fa.9.1741862900515; Thu, 13 Mar 2025
 03:48:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250309-ptr-as-ptr-v2-0-25d60ad922b7@gmail.com>
 <D8EJM4CJ4HAN.1PB2YV8DB77V7@proton.me> <CAJ-ks9mo-H46Wwcu_LOvDy0ncwMR9ii74Fyf3OX-aWNnrZ397g@mail.gmail.com>
 <CAJ-ks9kCgATKDE2qAuO3XpQfjVO2jGyq3D4sbUcVKyW6G1vuuQ@mail.gmail.com>
 <D8EL9QFS1XNT.JBSMRXD4D7GT@proton.me> <CAJ-ks9=TRDg3g=NG7k97P_5jXpZ4K4v0DxrmJFR+uF0-3zJkXw@mail.gmail.com>
 <CAJ-ks9=hAwOGtVv0zh9CcH7XOxjGnizvK1QOMAi8nKStocKr2Q@mail.gmail.com>
 <D8ELW7X9796K.2ZGJS34LDTHOP@proton.me> <CAJ-ks9k1gZ=tLSe6OjuKFgg6=QE5R_Ajo0ZJwZJp08_1LMiODw@mail.gmail.com>
 <D8ENBWTC8UPH.LLEGZ2D4U7KQ@proton.me>
In-Reply-To: <D8ENBWTC8UPH.LLEGZ2D4U7KQ@proton.me>
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 13 Mar 2025 06:47:43 -0400
X-Gm-Features: AQ5f1JpvT0pCHkZRvibXqm2vlfPfrKbPxFhR2eEtWGWUHW0BSrI5KdQ4s_SfHLQ
Message-ID: <CAJ-ks9mJ=2hFxfWEkq+9b=atE89sHXa5NBcdVNRd3az6MSv0pA@mail.gmail.com>
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

On Wed, Mar 12, 2025 at 6:38=E2=80=AFPM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> On Wed Mar 12, 2025 at 11:24 PM CET, Tamir Duberstein wrote:
> > On Wed, Mar 12, 2025 at 5:30=E2=80=AFPM Benno Lossin <benno.lossin@prot=
on.me> wrote:
> >>
> >> On Wed Mar 12, 2025 at 10:10 PM CET, Tamir Duberstein wrote:
> >> > On Wed, Mar 12, 2025 at 5:04=E2=80=AFPM Tamir Duberstein <tamird@gma=
il.com> wrote:
> >> >>
> >> >> On Wed, Mar 12, 2025 at 5:01=E2=80=AFPM Benno Lossin <benno.lossin@=
proton.me> wrote:
> >> >> > Always enable the features, we have `allow(stable_features)` for =
this
> >> >> > reason (then you don't have to do this dance with checking if it'=
s
> >> >> > already stable or not :)
> >> >>
> >> >> It's not so simple. In rustc < 1.84.0 the lints *and* the strict
> >> >> provenance APIs are behind `feature(strict_provenance)`. In rustc >=
=3D
> >> >> 1.84.0 the lints are behind `feature(strict_provenance_lints)`. So =
you
> >> >> need to read the config to learn that you need to enable
> >> >> `feature(strict_provenance_lints)`.
> >>
> >> I see... And `strict_provenance_lints` doesn't exist in <1.84? That's =
a
> >> bit of a bummer...
> >>
> >> But I guess we could have this config option (in `init/Kconfig`):
> >>
> >>     config RUSTC_HAS_STRICT_PROVENANCE
> >>             def_bool RUSTC_VERSION >=3D 108400
> >>
> >> and then do this in `lib.rs`:
> >>
> >>     #![cfg_attr(CONFIG_RUSTC_HAS_STRICT_PROVENANCE, feature(strict_pro=
venance_lints))]
> >
> > Yep! That's exactly what I did, but as I mentioned up-thread, the
> > result is that we only cover the `kernel` crate.
>
> Ah I see, can't we just have the above line in the other crate roots?

The most difficult case is doctests. You'd have to add this to every
example AFAICT.

> >> > Actually this isn't even the only problem. It seems that
> >> > `-Astable_features` doesn't affect features enabled on the command
> >> > line at all:
> >> >
> >> > error[E0725]: the feature `strict_provenance` is not in the list of
> >> > allowed features
> >> >  --> <crate attribute>:1:9
> >> >   |
> >> > 1 | feature(strict_provenance)
> >> >   |         ^^^^^^^^^^^^^^^^^
> >>
> >> That's because you need to append the feature to `rust_allowed_feature=
s`
> >> in `scripts/Makefile.build` (AFAIK).
> >
> > Thanks, that's a helpful pointer, and it solves some problems but not
> > all. The root Makefile contains this bit:
> >
> >> KBUILD_HOSTRUSTFLAGS :=3D $(rust_common_flags) -O -Cstrip=3Ddebuginfo =
\
> >> -Zallow-features=3D $(HOSTRUSTFLAGS)
> >
> > which means we can't use the provenance lints against these host
> > targets (including e.g. `rustdoc_test_gen`). We can't remove this
> > -Zallow-features=3D either because then core fails to compile.
> >
> > I'm at the point where I think I need more involved help. Want to take
> > a look at my attempt? It's here:
> > https://github.com/tamird/linux/tree/b4/ptr-as-ptr.
>
> I'll take a look tomorrow, you're testing my knowledge of the build
> system a lot here :)

We're guaranteed to learn something :)

