Return-Path: <linux-kselftest+bounces-31153-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0DCA93B64
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 18:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADD011B62E47
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 16:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4AD1DED51;
	Fri, 18 Apr 2025 16:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+LMRDGB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBA621A43B;
	Fri, 18 Apr 2025 16:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744995228; cv=none; b=MnB26BJKBn/Ui9s0E6JEQJpd54N9DLPboRx+8D7ITPBhBSLBSdIetxGOTXcDz7mYQNJTXDR0wuELAv5ULO7BEfd+ZFRgqAnQfh5DWEMzK41myjprikyjYT2zTl9ErskUm0j8586am87zLJSMuV2xqR21+SxG+XbU3BqrUDY/aoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744995228; c=relaxed/simple;
	bh=tZYYONwzDkApmp/34Q7EaXBholg+tMiIkIlNEDsexvg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t/WJ2gfqTJh4JTwFruzqZpIVkjMN6N06VyudifVLbc8gQjOoM3oeWRjBIbylhLUIt4vQu8mHdQTdPlnH1T3V6fk9Y4g9EXivl/jo6nuT/4B7hd41Cic787MwVYAUIuuo0lBfI8BhYidZQqGSKVb8H2BYPzibXiKGZj7u4uuOPJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j+LMRDGB; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6e8ec399427so16345876d6.2;
        Fri, 18 Apr 2025 09:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744995226; x=1745600026; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:feedback-id
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3t/WaZrLOk89oF+EDQCe/b1X08N9WTsCNvmuCONFWag=;
        b=j+LMRDGB0RNfCBFu3APD/ADBdWP2yGo3HeB2kYiJH3BPx8xnrhsnofsceuQonW6lCi
         GXeAPl09qTocEpxQDsKS6fRg/dR0lMRDYA8X/meXr/ZVbrIEJYIsAfWDDZYYQFcexvi9
         fUSR1TJEKvFkQYd7aHXEAVUILic2aTvc8MolyQ7H/7J90yOQ3Er6yvaY7C1afDoAiryu
         ReQGPK2JYNYc1urNodWKW+EfXrVnnmy1CnHk4Ov8XRN+rFbr7/MgfmISwDWm8q5B8XHK
         Io2Vu7KHED0RimZWTIKwIWKjC1b3ZrucMtIoUzBqlHtWaATL0FK0uYHP0CKKLRxKhtc5
         cDKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744995226; x=1745600026;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:feedback-id
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3t/WaZrLOk89oF+EDQCe/b1X08N9WTsCNvmuCONFWag=;
        b=mlP3mzrpt46SPfX1kLokiPsQE/b+Vi0SPDGCNwdVtM9nIeg7p3yRLd8nHadvHXAY0K
         TsWdOCmsQPS8iPGf0u5EC+UPz2abUodEFvGeI/MfBrn2DI96+q7lLonh+2kAZDBrTdPg
         eDXd7zL69EeBDXv+KQVF7prAzu674Ps0gEI8rEk5651d1s6OH/D7T4YuPpF3vUjBQTLs
         wfTixHzyqBk9+5iCzAASSpjEto89WSHgozSfXtgKXEHV7KeCxGvylPNReBFw549LBg1v
         vJvyxC642JuZP4zjo+zaSRmex6V5Dh5fw1Kfkm1QYUp5rlPXDaRmPCQzQGD12XIGzkPd
         Su4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUBE9oRQ/5V7XpC9Uqzs7EYWPxNwXOqc5ETip11M0SyD72BkJLl2suYg/ULkkNB6L6WId/xEnz4un8ZS1Ml@vger.kernel.org, AJvYcCUg9TlaW61hVdd8zQeQbnXDTnKgt3P9qN+TBh/Cva/mRMCKExizPbSW8vQL2ko140x1FKOPufV6C5EqLM2o0Eo=@vger.kernel.org, AJvYcCUnFsiTdzk9fMp5WkAz+ijRCHJj6YjPT3EOuMf1Q+X+/0qAv/bQLr14H6yL2uuufi+R80ZeZMUfSwR/@vger.kernel.org, AJvYcCVmJ5DruueRyRDgAFTxbD8U5XfCByrfgPrcYOzwzPy8yGPoWdtipm6Vlsrzh1ouIpkhDULXaQISJFkO@vger.kernel.org, AJvYcCWKJKFAyMsM//5kd8nKyRSexgm/3MiQwMOXg7MZID0um801q7Gau5SpW0O1WFRESomNrNG6yBSNvcp+Ajw=@vger.kernel.org, AJvYcCWXbrtg/SRQq6HA7oYojQ+fUmQ83zsC+BwRoG8MMr0anmVGrjI2wpC+qj+WHa1bJAzE4HEJ6v79lObf0v26fY8d@vger.kernel.org, AJvYcCWdeHJC4ySQx4Uhe6Lsrn8yq4FQ9VGrKeLSJtGaQvGedNoKD+1y9RM8y2hPWvwvFHn/k0TobzEk@vger.kernel.org, AJvYcCXkLbhSUggWgFML2i+pVusc/Gkw1Ovmy19Q4m8QjCi2247rsgxW+DFvTfexj/QxdWATjF2od/vBu6ZT1wXU@vger.kernel.org
X-Gm-Message-State: AOJu0YwyNH3ysd8YlIFxiW1fXvdlUhGx3V+ws9B9hLOMJptpczWTmP14
	P6zG2WOQi4BuSNGFqcB6cScdTc9o0f/nFUCjYnCzZXB1k0QFLJ4m
X-Gm-Gg: ASbGncsLiG+sCa/xL5Uq2LcLGp38ZWOyl9BVLyhpuBNTLR/DzeeT8CbhK5WDZOizDSR
	Kr8u9rmSjJPirv7kUR08JQnG1/RIutB+YbU576v8h6amF+mThZPczc0oiMtJiiBpmKkxIKzCuOW
	4Hnrr3F7nqVVT3qaUhnH/ManTz4mWKlTc7Qj7aWVF8WHUbRt+q/BsE835NQkowdRWrPnN0QODXP
	pqYKSZmOvbIvFNdzJcQsOkDldgV/+UbvD8ldUEykbjjK1LWw2Cp74ZJecpKu45u7M7A7aHkHL2j
	ZbLJL02Br13SjGpYZL5IurAMvVeubGDYC4VA4auzSTwSU1iZTuXsKIv97QVkg+ge0y13X3ZQCHr
	4Xi1H7Q0WKZdrHIjBL5Lk/9QdmyqtW6k=
X-Google-Smtp-Source: AGHT+IFK5F7pjTh+gDI22NM3J/gMlBfdXSYFP16c7YCh2IMcJ2ycP9QTVW7R2aFWqMe//5+hwErVFQ==
X-Received: by 2002:ad4:5d4a:0:b0:6e6:61f1:458a with SMTP id 6a1803df08f44-6f2c454e561mr61427996d6.14.1744995225599;
        Fri, 18 Apr 2025 09:53:45 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f2c2b0dc58sm12429256d6.30.2025.04.18.09.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 09:53:45 -0700 (PDT)
Message-ID: <68028399.0c0a0220.389db7.61aa@mx.google.com>
X-Google-Original-Message-ID: <aAKDlapFVulZac94@winterfell.>
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 066C51200043;
	Fri, 18 Apr 2025 12:53:44 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 18 Apr 2025 12:53:44 -0400
X-ME-Sender: <xms:l4MCaOS0MZu7VrDm1Ob2LRUYzATn3lvCrSx3mxKtRJynmiJf91vuQw>
    <xme:l4MCaDz51H7htPFXnN1I5J2eYclIkY2hxlzLEpBwVsysaX8a6d4yyVxY1Z2XsvVGA
    osS__YVT1a0RizI-w>
X-ME-Received: <xmr:l4MCaL1eShu7QA0LgrTDuktgHW2xyyXGbxMkMlvWru2HnE6VgzKO-vQd-oIGFw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfedvieekucetufdoteggodetrf
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
X-ME-Proxy: <xmx:l4MCaKCQ5_AOxgrM9RUujgkgseBZnmKKzmalnkhJG6SECBu9lWm2pg>
    <xmx:l4MCaHgYTO7zyl3noT53XHpiSgVpbmcFFmbFQNR8UOf2kvASWVyHpA>
    <xmx:l4MCaGrX6PPw9obSYJcN3qrnBS7WfC_zXPJu5mxchXy92dGdyigYSQ>
    <xmx:l4MCaKiFAgA2HoDBXSctPHo_XFldUBwHaFxEgeDfvkjr87N1ON2s_A>
    <xmx:mIMCaGSluDRYYRt5sBgRuiMWR_Dz1ykK0mZeKIfuwnIwbJoOeQ4WxXkb>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Apr 2025 12:53:43 -0400 (EDT)
Date: Fri, 18 Apr 2025 09:53:41 -0700
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
Subject: Re: [PATCH v10 5/6] rust: enable `clippy::cast_lossless` lint
References: <20250418-ptr-as-ptr-v10-0-3d63d27907aa@gmail.com>
 <20250418-ptr-as-ptr-v10-5-3d63d27907aa@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250418-ptr-as-ptr-v10-5-3d63d27907aa@gmail.com>

On Fri, Apr 18, 2025 at 11:37:21AM -0400, Tamir Duberstein wrote:
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
> Suggested-by: Benno Lossin <benno.lossin@proton.me>
> Link: https://lore.kernel.org/all/D8ORTXSUTKGL.1KOJAGBM8F8TN@proton.me/
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

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
> index f2a99681b998..7555513a4fd8 100644
> --- a/drivers/gpu/drm/drm_panic_qr.rs
> +++ b/drivers/gpu/drm/drm_panic_qr.rs
> @@ -386,7 +386,7 @@ fn next(&mut self) -> Option<Self::Item> {
>          match self.segment {
>              Segment::Binary(data) => {
>                  if self.offset < data.len() {
> -                    let byte = data[self.offset] as u16;
> +                    let byte = u16::from(data[self.offset]);
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
> index a59469c785e3..f821480ad72b 100644
> --- a/rust/kernel/net/phy.rs
> +++ b/rust/kernel/net/phy.rs
> @@ -142,7 +142,7 @@ pub fn is_autoneg_enabled(&self) -> bool {
>          // SAFETY: The struct invariant ensures that we may access
>          // this field without additional synchronization.
>          let bit_field = unsafe { &(*self.0.get())._bitfield_1 };
> -        bit_field.get(13, 1) == bindings::AUTONEG_ENABLE as u64
> +        bit_field.get(13, 1) == u64::from(bindings::AUTONEG_ENABLE)
>      }
>  
>      /// Gets the current auto-negotiation state.
> @@ -426,7 +426,7 @@ impl<T: Driver> Adapter<T> {
>          // where we hold `phy_device->lock`, so the accessors on
>          // `Device` are okay to call.
>          let dev = unsafe { Device::from_raw(phydev) };
> -        T::match_phy_device(dev) as i32
> +        T::match_phy_device(dev).into()
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

