Return-Path: <linux-kselftest+bounces-29266-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E98A65BDC
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 19:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCC0A178FD3
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 18:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735FF1ACEDE;
	Mon, 17 Mar 2025 18:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i0oftvuO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9123FA47;
	Mon, 17 Mar 2025 18:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742234714; cv=none; b=o/Fd+KIjmg6WQpILIHukk9dDeL9AGLGwE7dpsm2zbPCWq0r28lUvb4Y56LRbhcptjXjSnOonIVpFgk2xawFGooZ1wi8qznhQ7/tS5Nrch83aMQS0UvjAvcO02iBuFeVKN4bZ7VaCqY3wbHPohzRrko8p6eUlUXNrSkNrvbbpDsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742234714; c=relaxed/simple;
	bh=yS19w8s2BxyjV6yv9nuygjxyYafL7takTriDGTwkTb0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DtBjBNEYWnOCEwRyQuHLqI8Sgrqhg/VHJqo758EPEcftTsSE7Pz0jzWXrpF01cnQl/8VmOBMlC2GPdWot4OIr/EvJ82jsJzWCEUplp/CBfft1XZatdWycncT7zvl/SplhXwCCwaidMbW0poBylSBwyE5RLTSFAd5wr+Yvo4ayaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i0oftvuO; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30bf8632052so50771761fa.0;
        Mon, 17 Mar 2025 11:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742234711; x=1742839511; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=frfHgQ+gFACrESJvw7LnNR39jC1AwPkl0OXU4bE+ZmE=;
        b=i0oftvuO4eu0T62J1dW50/iMfanB5G7Cwm1GcbfC4HzL9OifdyBX1LD3dYrxElsCEo
         ucgog4bH2bYNLXPduZ2/Kee/eogk7hyJ/3s0BysGpy0aFKvW3QaTr+CbcDWBVetTCORI
         Ael8tPodEw+/1wvRgUdOVz6npAbxMmgcPqmz1HkGNzIufPCFXEdSai/PFk5NjMSzIWFI
         HI5CAQEOpW9S9nmFI8G4bxiGBy45QToNxgHduC+Em9HF/qQdYbPE3GPEArBvnOTxHjE6
         0IL7iIPjogfCBafbjaEcQqFetanDFSPHRYvACM8IcVI8EY5H+MwIpIxodk91/waQv+8r
         tgqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742234711; x=1742839511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=frfHgQ+gFACrESJvw7LnNR39jC1AwPkl0OXU4bE+ZmE=;
        b=Cy9Ay73zm5KAYYdua0OMBP+j4BbAU9Mg/gX/vq0yy5y44nT2PNsNyU9wvwNRCBBdw4
         rSPv8rm5keD6EyG8QEH4gx1QMBt0HuBhjVtsQYOxb3/fDehfIjv9v1NMA25e2QvkURHC
         raiBU0Ccs7RtU8vGzQnm6YDqylWKbC5LwwwN+k5I9AWYkMFyq75ed7esriJw48iT1OJg
         yCDwSiLQO74HK5wrz0BJx8wKwPCTUCTmDM1pkjHb0U/L1wdGvbcnGlXRr2fAd3WDyYu4
         AtGpctg7e35z1k5OG/LtVqJILJKaEoXz7+zLvgBxKU+BvL2hWhd211VB2GFrlTROGfjX
         b4TQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7HwF+I1/0wx7pGNtpUsgwHeW/NlxtjJe5QdWOyOyhkiXW1nzGvdpME/0tzphqpdWUWaW97zHIN69qK8M=@vger.kernel.org, AJvYcCU8WiBR0AMU5foWY1OzMg0QMUE2pBRHjA5I8LCwwtMm58IN5vbnSf5qx7n2QDBBem6+IMi4UhUEulJQMlTkQccP@vger.kernel.org, AJvYcCUVJDor9zakiJQ7TizEqcR/SKWqpYm8UphnXbvmtQK9snF6bdwWuamUmY90gWvxhBO9PxpTXMmagC/nrtV9@vger.kernel.org, AJvYcCUY8rp2QVFNBGggPLpJJ7KHURrJsF/JGLyDjJgAmFXs2J7Q2igObZz+vUUks6gRA678+yo7G5GABlMx@vger.kernel.org, AJvYcCW8TRbQN0/SZMZHFG1CoahvOU0KcRPVMZjNd0slw7QEIK/0pD790Tjwvmy4y79PeVJDspoOcM6tIc9SIfs3SYo=@vger.kernel.org, AJvYcCXYy9PfxO1IVs3r88eLvtwe1IJmK9eIXZS5G47Gpt5rlym27I4DXoBiv8CWHH9kV9IepzcgC5pG9yrCmVUm@vger.kernel.org, AJvYcCXbTWObobo+/k6f0MVpMQoImzOIxzGa62uLzYPC4KhPORPALb4kwhvBElTTsnGcgN55AaiMpXxOj8l4@vger.kernel.org
X-Gm-Message-State: AOJu0YwjcP5YzxeNd34fxxnDbNQl/gw4bkmH3sCqWrjyB5a7IEDp30Zd
	cSR8axeXzYoQX3EV8porIvpe5YfbfK5sz686FBO03QnIgmf/bQCQpmwyeXbFl/oFQ7fqH1uWplW
	es82UV1bYHnRvXel9Rl35sL0mbbw=
X-Gm-Gg: ASbGnctNTFk0WpsiUbQC78Z6jjGiVuU4nomliunp1LpF4xlbW+8qBpO0WRV6VIson0x
	gzEeQP9S7tKexweFzBviUDGZQtUpcy9ryW8E4IlvH65xThT8JBIn6Wbhk0te0MPxFQwsXeM0wju
	VhJOY0M+CyVFJK3tt5LvBZsv/tp8jRSCNm2ez0101hWr6r1MemEhkSveNqrMGp
X-Google-Smtp-Source: AGHT+IHEiCRYqo5kdtDzu9DwfXgz8qSQf+aHXpVibcrV/eXTAUt79P6itWOg5iJJ3B8dHvF9R2vfggvwUwXXMy4e4BQ=
X-Received: by 2002:a05:6512:39ca:b0:549:4e78:9ed7 with SMTP id
 2adb3069b0e04-549c39afb93mr8766794e87.49.1742234710429; Mon, 17 Mar 2025
 11:05:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317-ptr-as-ptr-v5-0-5b5f21fa230a@gmail.com>
 <20250317-ptr-as-ptr-v5-6-5b5f21fa230a@gmail.com> <67d85e51.050a0220.2a36b.58b3@mx.google.com>
In-Reply-To: <67d85e51.050a0220.2a36b.58b3@mx.google.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 17 Mar 2025 14:04:34 -0400
X-Gm-Features: AQ5f1Jo97QAJQPWntDNr9WhIHhk1SFsSEUSY6hlNcHKZZ-5cDJZTOBm_FAQM4OI
Message-ID: <CAJ-ks9kBp8zPfaQuZRb0Unms1b13hDb5cRypceO8TWFR0Ty5Ww@mail.gmail.com>
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

On Mon, Mar 17, 2025 at 1:39=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> On Mon, Mar 17, 2025 at 10:23:56AM -0400, Tamir Duberstein wrote:
> [...]
> > diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> > index fc6835cc36a3..c1b274c04a0f 100644
> > --- a/rust/kernel/lib.rs
> > +++ b/rust/kernel/lib.rs
> > @@ -17,6 +17,11 @@
> >  #![cfg_attr(not(CONFIG_RUSTC_HAS_COERCE_POINTEE), feature(coerce_unsiz=
ed))]
> >  #![cfg_attr(not(CONFIG_RUSTC_HAS_COERCE_POINTEE), feature(dispatch_fro=
m_dyn))]
> >  #![cfg_attr(not(CONFIG_RUSTC_HAS_COERCE_POINTEE), feature(unsize))]
> > +#![cfg_attr(
> > +    CONFIG_RUSTC_HAS_STABLE_STRICT_PROVENANCE,
> > +    feature(strict_provenance_lints),
> > +    deny(fuzzy_provenance_casts, lossy_provenance_casts)
> > +)]
> >  #![feature(inline_const)]
> >  #![feature(lint_reasons)]
> >  // Stable in Rust 1.83
> > @@ -25,6 +30,109 @@
> >  #![feature(const_ptr_write)]
> >  #![feature(const_refs_to_cell)]
> >
> > +#[cfg(CONFIG_RUSTC_HAS_STABLE_STRICT_PROVENANCE)]
> > +#[allow(clippy::incompatible_msrv)]
> > +mod strict_provenance {
> > +    /// Gets the "address" portion of the pointer.
> > +    ///
> > +    /// See https://doc.rust-lang.org/stable/core/primitive.pointer.ht=
ml#method.addr.
> > +    #[inline]
> > +    pub fn addr<T>(ptr: *const T) -> usize {
> > +        ptr.addr()
> > +    }
> > +
>
> For addr(), I would just enable feature(strict_provenance) if
> CONFIG_RUSTC_HAS_STABLE_STRICT_PROVENANCE=3Dn, because that feature is
> available for 1.78. Plus we may need with_addr() or map_addr() in the
> future.

We still need these stubs to avoid `clippy::incompatible_msrv`, and
we'll need those until MSRV is above 1.84.

>
> It saves the cost of maintaining our own *addr() and removing it when
> we bump to a strict_provenance stablized version as minimal verision in
> the future. Thoughts?
>

I can do this by making this particular stub unconditional. I'll do that.

