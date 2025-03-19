Return-Path: <linux-kselftest+bounces-29433-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52810A6933F
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 16:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC5727AE566
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 15:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75711C8602;
	Wed, 19 Mar 2025 15:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A59oNGUP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDA719AD89;
	Wed, 19 Mar 2025 15:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742397955; cv=none; b=oi+F5qY++aJuss2buRyP7XYDyK3US/ZtqVEeBxBJGecV3SL4QGGdvruzl19H2rmOStqv2pTl8xGMG0ruKsSOQWUrjeNfUC7HPIR65Ml7h0XGXmb4vUn3zy1ZKVLwadO1+SPXhWTWChcABBr3zNDFirQhQp+LTSX2DZpDIA19IOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742397955; c=relaxed/simple;
	bh=GSdybhW8AtTRDSjGpokKdRNgMQ8ZN5r7sJW750qRBcQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yr4rjOlAv1ON6P9KwM5OfxP+E33xHLl7xuCW6atEuj8tdoMUAhD9+NSNLpZv+O9LUGth1QDhwC1DZ8n3liRvgHDA28lKivj5YmC2OVp975CNlAkBr/4B2P9UIAOMIK6peAKGRWyOcQIMCaXtat9rcVB4Vdze2v8paL8R4Ykl9Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A59oNGUP; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c54f67db99so74631985a.1;
        Wed, 19 Mar 2025 08:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742397953; x=1743002753; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0dRxLmwmHXHr6GtvCU0orbDWdCCYD/w0yR2cKTu0vRk=;
        b=A59oNGUPXdo3Q5MpvjSjAZu3D42YDyI2QjMuiTnldhcSLSzsCdqZx9wdliT1TIo3kG
         1kjbefbBGMkiPjFnrA0WdorQmRvcxKVFOaVP48fE3tmM0u/44qQIkxBq2lcpLr/uq2sE
         OhVw1b5hhbfkn0iyFrlvZ+pZJtX7jDHWl+WZ4X/HuPPMJaHuwUc94XjqVQUbuUAgHO+k
         pMkcpOOo1rNoqsLKkwmBt3/OIDvmm0EMn3k3DSaIMCx1xI8hqbe8dfPcKlK4vCmbJJKp
         JIRUDADrVX0qblgodR33dI1H0XUELIE4z7W/HewoIfrItlKTpjF85KCUeHVBzvWCMLIt
         NMPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742397953; x=1743002753;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0dRxLmwmHXHr6GtvCU0orbDWdCCYD/w0yR2cKTu0vRk=;
        b=G6lvqjpCots4DEZDCSoBLbBLtT54WoGaXm6F15OiDrQRQTEjX96DNK/h7EUs8+5h15
         H1ineqAO6goWimwrNKanS+3G3ZgJoAETQZexAJvpw3cl6QPDjLpZ/pvsJa+3cecLKfnr
         WiYne0NVVya0ay2SnOwUYtd8QxbpINCj3Gg/vIYSIwT6qTYTaKz76awxqOWy24d5w2AS
         pOwbfK+rlnpWdjww9L4tWIdJc7ukMT0S0HHk/3PsIaHbWIcGb6pw9MczFhOH0sm+kxQv
         bJIrzF3RrYRGZAIH7BwpShxWpIeLYVXp+R/Jjw6veIj/KkPUChmZSc2RZZBgkuavy+gw
         5KHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHu9r5rMYaoYcgsfKAeuFhnngrXsAaCxfu70g2Sjk3hCiQYcN6aYVqqSX5adX8Pcs04bWTBov//3CE@vger.kernel.org, AJvYcCUIypcML+pJllZEkI3+1vg1g6gmSc1dSUUULfiWcmEGiUnadfEFHFzDfcZEPvrLgtAuFb2HvoFuhUwRxU82k9aF@vger.kernel.org, AJvYcCWJDg8LofOr7mSVBZZzICMf6n/XiU4rqhW4+wA5QCrsLAeWG889i5RSxK+P+AYVHNZpVQj2l/wGJ0qroNdl@vger.kernel.org, AJvYcCWkFJeIgcEuSaHvDEfzWPNgiQkAgisy8MW92GGStLHBag9WRyuzCicKblYSQmMAv/NMSxrm9n5negNB@vger.kernel.org, AJvYcCXcilwBelpRS3NaYIGffS5OVflUOxi68FnTgueySR88h09n9/KpKZ8CuU1IN+7TLGRwe7wsxkw3Z6OOqKUatT0=@vger.kernel.org, AJvYcCXekxOF5rb1Eey4cT7gu8/o9pRBGTIHs6eog7nzZsnApyZTR58EOfFglcPcQwXHkV0g1GCyer2bojy3/XQ=@vger.kernel.org, AJvYcCXusO1TTAekihBbicX6ZU/JZVplfIYSrDhjAyktAAA7EwPDs/w1wm4VImTMkG7q0XTLsPWfYUDo3cuopCxk@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7WvmaLxRvNT/c+UZu0nfw42BfNowbfQ2GLkMjsVj6jnFJJ0cC
	U6pfxOfBJnIntSmNN4LKQ878LmoeLIRAPElB/pqmr/ichLZLIElR
X-Gm-Gg: ASbGncsNq/4ImL+En6JkouNSlCGoa96PEZCZlPfYHqbpEQTuAaBKJtg9DXo+V0m8Ei8
	NbPCfMLB9vOt2pYhy/x7MHhx/ZQQA5i79kgnJXfGlXBiXc0ViCaV/VOPESuU1sbNhnotQW9t2V1
	hoXA4vJlG4OKIHSPrcImrd6N/e5E0zW+g0BS+c9g9eEkLuo1jY+7e6bSd3B8MEMIPT6GQDoZIB8
	sJt7qCiIhJFmG0EnOc6XoTST7DiDocNAP/BQh8ibhpKHStLHnlDIjwBs94mHy4sRECW4diWsRAS
	qQ9gQR5cJocJ/YkqN3uGqf/9ZdnW+TXcfcbjyNcNgwGk3npdafJns70OX+f8uT1iiAUU9qcikRf
	9GxTbKZ1RgVh/NCosWbfzDFINtTMcDs6UEA0=
X-Google-Smtp-Source: AGHT+IFVrhTLu5tm/SS2KDvo65mSS3MmCZ2qx4V8rtqgqFC7AjZMtIevXLlXnSHHR2ZDCNYdn7QmAQ==
X-Received: by 2002:ad4:4ee5:0:b0:6e4:6a67:2d12 with SMTP id 6a1803df08f44-6eb2962687cmr45220946d6.0.1742397952489;
        Wed, 19 Mar 2025 08:25:52 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eade2097fesm82103376d6.20.2025.03.19.08.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 08:25:51 -0700 (PDT)
Message-ID: <67dae1ff.0c0a0220.1a88e4.f740@mx.google.com>
X-Google-Original-Message-ID: <Z9rh_OE28CHJbviB@winterfell.>
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 134251200078;
	Wed, 19 Mar 2025 11:25:51 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 19 Mar 2025 11:25:51 -0400
X-ME-Sender: <xms:_uHaZ6yZO68x2ZInLmvKXEPYH8wP5kowkKm8KQfXqmthuRTaIacx9A>
    <xme:_uHaZ2QS90LNqN8IVKuWPQkRO2zhaJSgvz6MyeMd5u6v4gM6xlj4nDZLOguC2UHEH
    CYtNHvOhwu43U4qIg>
X-ME-Received: <xmr:_uHaZ8UESSHtTFxcRYwioYT87d88QzY4kGfHMaYoSdm6XLrDc5jVtOlwWhQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeehieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeeivedvieefgeelffehfeeuheetuefgueek
    teduieeugfevhfdtkedvuedvhefghfenucffohhmrghinheprhhushhtqdhlrghnghdroh
    hrghdpghhithhhuhgsrdgtohhmpdgtohhnshhtpghpthhrrdhrshenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtph
    gruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgs
    ohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspg
    hrtghpthhtohepfedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsvghnnhho
    rdhlohhsshhinhesphhrohhtohhnrdhmvgdprhgtphhtthhopehtrghmihhrugesghhmrg
    hilhdrtghomhdprhgtphhtthhopehmrghsrghhihhrohihsehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehnrghthhgrnheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhhitg
    holhgrshesfhhjrghslhgvrdgvuhdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpthhtohepsghjohhrnhef
    pghghhesphhrohhtohhnmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:_-HaZwhy30bky-9mi0EQnk_8rCsr43euu_6QuNnM4qizO8zkvJ68VA>
    <xmx:_-HaZ8CBOjkURfhnQyLV-zidKQoiuF7RPkEFu6SJA4Ke9hTgh-m50w>
    <xmx:_-HaZxJbYowySRmz20AKx6ToQpsBsrQiZouaLfooiFXeZhGlR2GquA>
    <xmx:_-HaZzCE6Ca2uG6DNp3F3L4AAyCS1DtHPAwhS7b8NNwzpN4WfBHKTQ>
    <xmx:_-HaZ0w1tPwhStbB5U8cjtzIsehslMlHTqNZTSQ0oSLNNhRv1TfAuOqQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Mar 2025 11:25:50 -0400 (EDT)
Date: Wed, 19 Mar 2025 08:25:48 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Tamir Duberstein <tamird@gmail.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
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
	Saravana Kannan <saravanak@google.com>,	linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org,	rust-for-linux@vger.kernel.org,
 linux-kselftest@vger.kernel.org,	kunit-dev@googlegroups.com,
 linux-pci@vger.kernel.org,	linux-block@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v5 6/6] rust: use strict provenance APIs
References: <67d864b2.0c0a0220.39fb6f.4df4@mx.google.com>
 <CAJ-ks9=uHjJrzM0ruvm4v4wr8LygRMP-1orWBy_9OiNNeQr0ow@mail.gmail.com>
 <CAJ-ks9=Qcmvbm=YGJ=jrX_+YdMsftk=FAimszYZB1OUuV4diZw@mail.gmail.com>
 <67d885ff.0c0a0220.111215.5644@mx.google.com>
 <CAJ-ks9kYB1b4XsQcFb=NScPq+R+13U+Sv-6opi-yp6=ZjuLD_g@mail.gmail.com>
 <67d88a1d.050a0220.2cdacf.4adf@mx.google.com>
 <CAJ-ks9kg4Br=56HT7T5sWpoMKhRqT_2x+cpQAWoyrEG3qyqQ6Q@mail.gmail.com>
 <67d895cc.050a0220.99d33.5adc@mx.google.com>
 <67d8ba3e.050a0220.39b3b5.753c@mx.google.com>
 <D8JA6Z142FKY.4RRGIN0PDDYQ@proton.me>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D8JA6Z142FKY.4RRGIN0PDDYQ@proton.me>

On Tue, Mar 18, 2025 at 09:23:42AM +0000, Benno Lossin wrote:
[..]
> > +#![allow(clippy::incompatible_msrv)]
> >  
> > -#[cfg(not(CONFIG_RUSTC_HAS_STABLE_STRICT_PROVENANCE))]
> > +#[cfg(not(CONFIG_RUSTC_HAS_EXPOSED_PROVENANCE))]
> >  mod strict_provenance {
> 
> Since there is only a single trait and impl in here, I think we don't
> need a module.
> 

We still need to provide stubs for with_exposed_provenance() and its
friends for rustc == 1.78, so there are a few more functions in this
module.

> > -    /// Gets the "address" portion of the pointer.
> > -    ///
> > -    /// See https://doc.rust-lang.org/stable/core/primitive.pointer.html#method.addr.
> > -    #[inline]
> > -    pub fn addr<T>(ptr: *const T) -> usize {
> > -        // This is core's implementation from
> > -        // https://github.com/rust-lang/rust/commit/4291332175d12e79e6061cdc3f5dccac2e28b969 through
> > -        // https://github.com/rust-lang/rust/blob/1.84.0/library/core/src/ptr/const_ptr.rs#L172
> > -        // which is the first version that satisfies `CONFIG_RUSTC_HAS_STABLE_STRICT_PROVENANCE`.
> > -        #[allow(clippy::undocumented_unsafe_blocks)]
> > -        unsafe {
> > -            #[allow(clippy::transmutes_expressible_as_ptr_casts)]
> > -            core::mem::transmute(ptr.cast::<()>())
> > -        }
> > +    #[doc(hidden)]
> > +    pub trait PtrExt<T> {
> 
> The `T` here and in the impl below probably should have a `?Sized`
> bound, since that's also what the stdlib does.
> 

Right, I was missing this.

> > +        /// Exposes the "provenance" part of the pointer for future use in
> > +        /// [`with_exposed_provenance`] and returns the "address" portion.
> > +        ///
> > +        /// See https://doc.rust-lang.org/stable/core/primitive.pointer.html#method.expose_provenance.
> > +        fn expose_provenance(self) -> usize;
> >      }
> >  
> > -    /// Exposes the "provenance" part of the pointer for future use in
> > -    /// [`with_exposed_provenance`] and returns the "address" portion.
> > -    ///
> > -    /// See https://doc.rust-lang.org/stable/core/primitive.pointer.html#method.expose_provenance.
> > -    #[inline]
> > -    pub fn expose_provenance<T>(ptr: *const T) -> usize {
> > -        ptr.cast::<()>() as usize
> > +    impl<T> PtrExt<T> for *const T {
> > +        #[inline]
> > +        fn expose_provenance(self) -> usize {
> > +            self.cast::<()>() as usize
> > +        }
> >      }
> >  
> >      /// Converts an address back to a pointer, picking up some previously 'exposed'
> > @@ -131,8 +80,12 @@ pub fn without_provenance_mut<T>(addr: usize) -> *mut T {
> >      }
> >  }
> >  
> > +#[cfg(not(CONFIG_RUSTC_HAS_EXPOSED_PROVENANCE))]
> >  pub use strict_provenance::*;
> >  
> > +#[cfg(CONFIG_RUSTC_HAS_EXPOSED_PROVENANCE)]
> > +pub use core::ptr::{with_exposed_provenance, with_exposed_provenance_mut, without_provenance_mut};
> 
> We shouldn't need this any longer, right?
> 

We need re-export these for ructc >=1.79, because for rustc == 1.78 we
only have kernel::expose_provenance() and its friends, therefore
user-side can only use them.

Regards,
Boqun

> ---
> Cheers,
> Benno
> 
> > +
> >  // Ensure conditional compilation based on the kernel configuration works;
> >  // otherwise we may silently break things like initcall handling.
> >  #[cfg(not(CONFIG_RUST))]
> > diff --git a/rust/kernel/of.rs b/rust/kernel/of.rs
> > index b70076d16008..3670676071ff 100644
> > --- a/rust/kernel/of.rs
> > +++ b/rust/kernel/of.rs
> > @@ -22,7 +22,7 @@ unsafe impl RawDeviceId for DeviceId {
> >      const DRIVER_DATA_OFFSET: usize = core::mem::offset_of!(bindings::of_device_id, data);
> >  
> >      fn index(&self) -> usize {
> > -        crate::addr(self.0.data)
> > +        self.0.data.addr()
> >      }
> >  }
> >  
> > diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> > index 87c9f67b3f0f..73958abdc522 100644
> > --- a/rust/kernel/pci.rs
> > +++ b/rust/kernel/pci.rs
> > @@ -287,7 +287,7 @@ fn new(pdev: Device, num: u32, name: &CStr) -> Result<Self> {
> >          // `pdev` is valid by the invariants of `Device`.
> >          // `num` is checked for validity by a previous call to `Device::resource_len`.
> >          // `name` is always valid.
> > -        let ioptr = crate::expose_provenance(unsafe { bindings::pci_iomap(pdev.as_raw(), num, 0) });
> > +        let ioptr = unsafe { bindings::pci_iomap(pdev.as_raw(), num, 0) }.expose_provenance();
> >          if ioptr == 0 {
> >              // SAFETY:
> >              // `pdev` valid by the invariants of `Device`.
> > diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
> > index baa774a351ce..3ea6aa9e40e5 100644
> > --- a/rust/kernel/prelude.rs
> > +++ b/rust/kernel/prelude.rs
> > @@ -41,3 +41,6 @@
> >  pub use super::init::InPlaceInit;
> >  
> >  pub use super::current;
> > +
> > +#[cfg(not(CONFIG_RUSTC_HAS_EXPOSED_PROVENANCE))]
> > +pub use super::PtrExt;
> > diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> > index 6bc6357293e4..d8e740267f14 100644
> > --- a/rust/kernel/str.rs
> > +++ b/rust/kernel/str.rs
> > @@ -8,6 +8,9 @@
> >  
> >  use crate::error::{code::*, Error};
> >  
> > +#[cfg(not(CONFIG_RUSTC_HAS_EXPOSED_PROVENANCE))]
> > +use crate::PtrExt;
> > +
> >  /// Byte string without UTF-8 validity guarantee.
> >  #[repr(transparent)]
> >  pub struct BStr([u8]);
> > @@ -692,9 +695,9 @@ fn new() -> Self {
> >      pub(crate) unsafe fn from_ptrs(pos: *mut u8, end: *mut u8) -> Self {
> >          // INVARIANT: The safety requirements guarantee the type invariants.
> >          Self {
> > -            beg: crate::expose_provenance(pos),
> > -            pos: crate::expose_provenance(pos),
> > -            end: crate::expose_provenance(end),
> > +            beg: pos.expose_provenance(),
> > +            pos: pos.expose_provenance(),
> > +            end: end.expose_provenance(),
> >          }
> >      }
> >  
> > @@ -705,7 +708,7 @@ pub(crate) unsafe fn from_ptrs(pos: *mut u8, end: *mut u8) -> Self {
> >      /// The memory region starting at `buf` and extending for `len` bytes must be valid for writes
> >      /// for the lifetime of the returned [`RawFormatter`].
> >      pub(crate) unsafe fn from_buffer(buf: *mut u8, len: usize) -> Self {
> > -        let pos = crate::expose_provenance(buf);
> > +        let pos = buf.expose_provenance();
> >          // INVARIANT: We ensure that `end` is never less then `buf`, and the safety requirements
> >          // guarantees that the memory region is valid for writes.
> >          Self {
> > diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> > index 08b6380933f5..b070da0ea972 100644
> > --- a/scripts/Makefile.build
> > +++ b/scripts/Makefile.build
> > @@ -226,7 +226,7 @@ $(obj)/%.lst: $(obj)/%.c FORCE
> >  # Compile Rust sources (.rs)
> >  # ---------------------------------------------------------------------------
> >  
> > -rust_allowed_features := asm_const,asm_goto,arbitrary_self_types,lint_reasons
> > +rust_allowed_features := asm_const,asm_goto,arbitrary_self_types,lint_reasons,exposed_provenance
> >  
> >  # `--out-dir` is required to avoid temporaries being created by `rustc` in the
> >  # current working directory, which may be not accessible in the out-of-tree
> > diff --git a/scripts/rustdoc_test_gen.rs b/scripts/rustdoc_test_gen.rs
> > index 036635fb1621..331ed32adc35 100644
> > --- a/scripts/rustdoc_test_gen.rs
> > +++ b/scripts/rustdoc_test_gen.rs
> > @@ -224,6 +224,8 @@ macro_rules! assert_eq {{
> >          BufWriter::new(File::create("rust/doctests_kernel_generated.rs").unwrap()),
> >          r#"//! `kernel` crate documentation tests.
> >  
> > +#![allow(clippy::incompatible_msrv)]
> > +
> >  const __LOG_PREFIX: &[u8] = b"rust_doctests_kernel\0";
> >  
> >  {rust_tests}
> 
> 

