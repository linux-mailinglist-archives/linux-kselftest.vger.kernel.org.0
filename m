Return-Path: <linux-kselftest+bounces-31079-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E521A92405
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 19:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F33A916BE6E
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 17:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1BE255243;
	Thu, 17 Apr 2025 17:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wfo4xO5m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023F425335A;
	Thu, 17 Apr 2025 17:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744910954; cv=none; b=fxnNZv931rbcB9xclkeCf6Xhu3kVvx0WKsnJ9M9yWv8JhyG+Yi8OdJC4cDKZatbrQkgU/UyTKaNkOOWgsQrWwh3bMzBydnamz3d2I6DNnkJHb+UJweAJDW9SIdFlXDuq0UridxpVhql2B0U2mcZHEEy7fOQRkvHsSmZWyy+GlI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744910954; c=relaxed/simple;
	bh=cvY1ls80gICbfPsPMyWc6VX6eeAhPRGV7kiDANTbk5k=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AKD25sF4NwjnijiiNSBYkGnciv6BchJAJ5n4woWEGy48p6M9sfvNoFgXgGKL9n/+o5HeUpCpx4zyzjhb/zICDNRfucT9WLtd8KhiDkpUY0ckE37Kd8QfGbltMOOk2fjB0Q+2FEio/YWK2Ahf/Q6lo3ZB0APJTeSBYd84/aTSzo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wfo4xO5m; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6ecf0e07947so10828406d6.0;
        Thu, 17 Apr 2025 10:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744910952; x=1745515752; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:feedback-id
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pSQ1spRHIDXyTBieqdfcsIAEuIswLKlLRhvaKNh6hmQ=;
        b=Wfo4xO5mBXM5O2LVEYvJzFh9uErse2wEyPKe4T/vw/evXWZu7ujo00+/1tjw4MS4ZQ
         W6oyoD1eT+xz309tQrnwoYZDcmmvXd/oeXukNaPLrexQJXyIprLjd5evpFko1PLUk6QB
         ZjrW1uQIEpzleeyxIIRyihu3QZb1MsFWaFV2gS9q3J0TcccWyyBLxiOyVuKQMCvcESG5
         EX9jbGRLKEGcsVjJenEDpKLdGRXy1QaSvy/oF7vL9xzC6Z9Z6PazgMG+LK/JbcsFD3NY
         jfueeqRkRt1PvXFYs7toIl6qLC0RQS5H5h6JGJ2zcX6XtNvnhySfrJdcczPzgoDQ5WRf
         IaEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744910952; x=1745515752;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:feedback-id
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pSQ1spRHIDXyTBieqdfcsIAEuIswLKlLRhvaKNh6hmQ=;
        b=N7WDSIPlzNibWlZ0iU5eQTGB8BN/G9yJ+N2nQxC99gRYUA0s/j7BNXOH/M3ZDTf1Av
         fWk7FcyX8/K/Usl4irLyvnxILPhotMLmCwkTdnX0682IES68op0TxT9voDFfo2/y34fJ
         Ggd/3tAy3IqklJYHnK9tvUeypQGEb/IHyZgxbnJWv4zdxZoCclxUPCNsmD6DP4ZoJr78
         4urcJdgQ9TjxrpZQ5TZ6atsRVYLyodyRratLZgDPiDU6fOl+q1UldcGE4B7hmDibLTBA
         wCPuL/9dX6u1kDQZzcfzgJo7KXl9pOzOAEd85zzNU7P1PxXTDBAMacj5lwp8vtlqSG+d
         rxCg==
X-Forwarded-Encrypted: i=1; AJvYcCUzBeZQxklLeKAq4y+uzCfQwzN7WuMExCjD5uVD6kORHuj1dCVm133/YfgHPLig7AuBMZv4qJoeGRlPuJIF@vger.kernel.org, AJvYcCVy2ls+cf0OLce2VxMX4yaYZuxMqpC+OzEhrdEpscYHVTqDPMPY9uby/HEYIfnFvKOGEPhSPAMh7FBgI7ng@vger.kernel.org, AJvYcCW2SGDSKdyqZojUfnEUfduZTtUajVyfaw5suMBpbaTMgJodqyswta1cJyGzLqMrAwGZ657Wd7z5vbqFJDU=@vger.kernel.org, AJvYcCWV/QA4lrAGVoGLA4XG0axPIspRQ5Oa/hg7w3fXsXtHuuFhfIvx6/h2gtnGSD9URwUwmQsVggHXTPJd@vger.kernel.org, AJvYcCWw6aMbCV5rpNFKT4c1AyIXVYGkRZOifTA9mINgys9cTzA0i80FQFc14uhg6woBPAdYXCnGjUufc/JuEEu5WHWF@vger.kernel.org, AJvYcCXAcKQmSwZyZw7JaoBmIMGtwakZ4Oc+Mz5Hs4HN6Y6JqSyaMzusLLGkYLmvr+pCrDuXjxqmssTelinj@vger.kernel.org, AJvYcCXIp6OHoO6nxqhZEttmTyUL60ArY6AomhgYpzDXeN36FiGKFY2toZ4shUDcR30rQA2sZE94xMXa@vger.kernel.org, AJvYcCXvxBrAKFuGxfvlsl8YAybO05bNiaAND+WEviklAbGao+taoGSlRKkR78AHra07PdrvZaT5RfVYvcDFqyQCS/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkK+7d5eNog90KBC6Ibe61lfes5QZd7jjrn/47kY1L5V5rMxj1
	5cj2gLuRGaDDYzSZPN9v+VVmz6dtvWqm1zyXBkReRLMLEjo5TDLp
X-Gm-Gg: ASbGncsjGMymrcL4qCGFRoeN1xeGw8XvNpmn0IbixpQaSsSPXr277Yx0LWARri2lB3Q
	KbZwvA57cxS/bi3G+n1LR+WsDbeoM3JZPadI+f5mVmvH23VBN084BfkROZK0TOJmXIoFRUoktgm
	NjTrWuCpq53hE/17JAvE4MU5eOLu7pBxUL3hY1MrXmhQ8zZHt5PZBMriMj6ys3/yfNLPCjT03+0
	AY35HOuIKST4uM0KVyl18Csl7TzVu4B7gnuEMp6vU+yBqgNNrVIHDeCbo8WegkzvOb+rpVRhhR1
	1OiU6YvuXJBGXBc2GF97xfw8qQiDlFsWwE/i3qUjGa/UMW+gt02N7oJXm71Uize1xrVyk77sqOU
	mVyLYyZYjhbkDM7yIbsSnObKj0KB961I=
X-Google-Smtp-Source: AGHT+IGBADq9qPvv1GmF3HVY3rBXqSEWoPoSmke4fv07LljyRbGPQ0FVYp1KghRKdl4sqaPo7U3Nqw==
X-Received: by 2002:a05:6214:1316:b0:6e8:ec18:a1be with SMTP id 6a1803df08f44-6f2c26c409cmr12409486d6.7.1744910951815;
        Thu, 17 Apr 2025 10:29:11 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f2c2af5595sm1459996d6.9.2025.04.17.10.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 10:29:11 -0700 (PDT)
Message-ID: <68013a67.050a0220.8a966.0ee4@mx.google.com>
X-Google-Original-Message-ID: <aAE6ZG6D2M6DGr2d@winterfell.>
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 2B7B31200043;
	Thu, 17 Apr 2025 13:29:10 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 17 Apr 2025 13:29:10 -0400
X-ME-Sender: <xms:ZjoBaGiPBApOT3KF_cFKmqlP0bbriY55u7x8VYpRa0qowU7KQZinpA>
    <xme:ZjoBaHCbngiXNmyQlXWezOZ5Bc_fDItA-xjSijhF5X27mIsBYx5vLNmq-g4RjAf3q
    HIBZ8uGb1KPn3BNKw>
X-ME-Received: <xmr:ZjoBaOEmz40_zhoT86dRO0JRh_S1te3xyGwFb7aD8S0P7tlTf0SnsHJhSd5P7Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdelkeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnegoufhushhpvggtthffohhmrghinhculdegledmnecujfgu
    rhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpeeuohhquhhnuc
    fhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthht
    vghrnhepkeekheeuudefgeelfedthfduheehkeellefhleegveeljeduheeufeelkeejie
    egnecuffhomhgrihhnpehgihhthhhusgdrihhopdhkvghrnhgvlhdrohhrghenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvg
    hsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheeh
    hedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
    dpnhgspghrtghpthhtohepgeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeht
    rghmihhrugesghhmrghilhdrtghomhdprhgtphhtthhopehmrghsrghhihhrohihsehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehnrghthhgrnheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrd
    hgrgihnhhorhesghhmrghilhdrtghomhdprhgtphhtthhopehgrghrhiesghgrrhihghhu
    ohdrnhgvthdprhgtphhtthhopegsjhhorhhnfegpghhhsehprhhothhonhhmrghilhdrtg
    homhdprhgtphhtthhopegsvghnnhhordhlohhsshhinhesphhrohhtohhnrdhmvgdprhgt
    phhtthhopegrrdhhihhnuggsohhrgheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ZjoBaPQfcbgUf6Yh8VYFMzyHPR0de0KrtNwsOgI0EoaJwSCpSGcmYQ>
    <xmx:ZjoBaDyXE3R3Pe0e4Lcs8QsUAONUuo-ONw4acJ0XzoE03FenFK-ZWQ>
    <xmx:ZjoBaN7obfouPd4NCLnREA0UyfouapS6Ixg3HFXOj8RTtj7lrb04Fg>
    <xmx:ZjoBaAwsSQO1lRMSgp4ADQSdo85_yXrulLD8K-_wB-TpI4cf9HMiUA>
    <xmx:ZjoBaPhVey_mPsmOnJZOLjB_TA5tgpIB2Y9NYUQT7nBENqG6OlUXuFVS>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Apr 2025 13:29:09 -0400 (EDT)
Date: Thu, 17 Apr 2025 10:29:08 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Frederic Weisbecker <frederic@kernel.org>,	Lyude Paul <lyude@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com, linux-pci@vger.kernel.org,
	linux-block@vger.kernel.org, devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org, netdev@vger.kernel.org
Subject: Re: [PATCH v9 5/6] rust: enable `clippy::cast_lossless` lint
References: <20250416-ptr-as-ptr-v9-0-18ec29b1b1f3@gmail.com>
 <20250416-ptr-as-ptr-v9-5-18ec29b1b1f3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250416-ptr-as-ptr-v9-5-18ec29b1b1f3@gmail.com>

On Wed, Apr 16, 2025 at 01:36:09PM -0400, Tamir Duberstein wrote:
> Before Rust 1.29.0, Clippy introduced the `cast_lossless` lint [1]:
> 
> > Rust’s `as` keyword will perform many kinds of conversions, including
> > silently lossy conversions. Conversion functions such as `i32::from`
> > will only perform lossless conversions. Using the conversion functions
> > prevents conversions from becoming silently lossy if the input types
> > ever change, and makes it clear for people reading the code that the
> > conversion is lossless.
> 
> While this doesn't eliminate unchecked `as` conversions, it makes such
> conversions easier to scrutinize.  It also has the slight benefit of
> removing a degree of freedom on which to bikeshed. Thus apply the
> changes and enable the lint -- no functional change intended.
> 
> Link: https://rust-lang.github.io/rust-clippy/master/index.html#cast_lossless [1]

Hmm.. I agree with the solution mentioned from the lint URL, using
`from()` is better, so..

> Suggested-by: Benno Lossin <benno.lossin@proton.me>
> Link: https://lore.kernel.org/all/D8ORTXSUTKGL.1KOJAGBM8F8TN@proton.me/
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
>  Makefile                        | 1 +
>  drivers/gpu/drm/drm_panic_qr.rs | 2 +-
>  rust/bindings/lib.rs            | 1 +
>  rust/kernel/net/phy.rs          | 4 ++--
>  rust/uapi/lib.rs                | 1 +
>  5 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 57080a64913f..eb5a942241a2 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -476,6 +476,7 @@ export rust_common_flags := --edition=2021 \
>  			    -Wclippy::all \
>  			    -Wclippy::as_ptr_cast_mut \
>  			    -Wclippy::as_underscore \
> +			    -Wclippy::cast_lossless \
>  			    -Wclippy::ignored_unit_patterns \
>  			    -Wclippy::mut_mut \
>  			    -Wclippy::needless_bitwise_bool \
> diff --git a/drivers/gpu/drm/drm_panic_qr.rs b/drivers/gpu/drm/drm_panic_qr.rs
> index f2a99681b998..d28e8f199d11 100644
> --- a/drivers/gpu/drm/drm_panic_qr.rs
> +++ b/drivers/gpu/drm/drm_panic_qr.rs
> @@ -386,7 +386,7 @@ fn next(&mut self) -> Option<Self::Item> {
>          match self.segment {
>              Segment::Binary(data) => {
>                  if self.offset < data.len() {
> -                    let byte = data[self.offset] as u16;
> +                    let byte = data[self.offset].into();

	let byte = u16::from(data[self.offset]);

otherwise, the code has not local indicator saying what type the byte
is, and given its name is "byte" but it's really a `u16`, I think it's
better we mention the type here.

>                      self.offset += 1;
>                      Some((byte, 8))
>                  } else {
> diff --git a/rust/bindings/lib.rs b/rust/bindings/lib.rs
> index 0486a32ed314..b105a0d899cc 100644
> --- a/rust/bindings/lib.rs
> +++ b/rust/bindings/lib.rs
> @@ -25,6 +25,7 @@
>  )]
>  
>  #[allow(dead_code)]
> +#[allow(clippy::cast_lossless)]
>  #[allow(clippy::ptr_as_ptr)]
>  #[allow(clippy::undocumented_unsafe_blocks)]
>  mod bindings_raw {
> diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
> index a59469c785e3..abc58b4d1bf4 100644
> --- a/rust/kernel/net/phy.rs
> +++ b/rust/kernel/net/phy.rs
> @@ -142,7 +142,7 @@ pub fn is_autoneg_enabled(&self) -> bool {
>          // SAFETY: The struct invariant ensures that we may access
>          // this field without additional synchronization.
>          let bit_field = unsafe { &(*self.0.get())._bitfield_1 };
> -        bit_field.get(13, 1) == bindings::AUTONEG_ENABLE as u64
> +        bit_field.get(13, 1) == bindings::AUTONEG_ENABLE.into()

        bit_field.get(13, 1) == u64::from(bindings::AUTONEG_ENABLE)

>      }
>  
>      /// Gets the current auto-negotiation state.
> @@ -426,7 +426,7 @@ impl<T: Driver> Adapter<T> {
>          // where we hold `phy_device->lock`, so the accessors on
>          // `Device` are okay to call.
>          let dev = unsafe { Device::from_raw(phydev) };
> -        T::match_phy_device(dev) as i32
> +        T::match_phy_device(dev).into()

	i32::from(T::match_phy_device(dev))

Thoughts? Better be explicit in these cases, IMO.

Regards,
Boqun

>      }
>  
>      /// # Safety
> diff --git a/rust/uapi/lib.rs b/rust/uapi/lib.rs
> index f03b7aead35a..d5dab4dfabec 100644
> --- a/rust/uapi/lib.rs
> +++ b/rust/uapi/lib.rs
> @@ -14,6 +14,7 @@
>  #![cfg_attr(test, allow(unsafe_op_in_unsafe_fn))]
>  #![allow(
>      clippy::all,
> +    clippy::cast_lossless,
>      clippy::ptr_as_ptr,
>      clippy::undocumented_unsafe_blocks,
>      dead_code,
> 
> -- 
> 2.49.0
> 

