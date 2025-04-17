Return-Path: <linux-kselftest+bounces-31083-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D74B4A92C11
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 22:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 522DF1B65D7D
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 20:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D702208978;
	Thu, 17 Apr 2025 20:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i7QZKYap"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989E92AD0C;
	Thu, 17 Apr 2025 20:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744920764; cv=none; b=VJE8RNQSFmBycsMLYGLtbJLezeFgX4Pel/pZW6Rr2vOdfnw7txx/U4WHpqAWVzlZRFhoUmGbr0tpYzR4Wd1NXBYUY8WP3+6QDJnn0mn4vIdBXjaHcB+ixCqn/fCB1RCwOU2F3xRKmyOT1wRFVUtkLImeE6nZgYDqg3e0YXxxVbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744920764; c=relaxed/simple;
	bh=CLyXGMhrb0Kgq9U+IzhlLk/eIiDAUBijHXHBld/8DVA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lG+eS88+0FeU4nemmUDJkeplnXk5TDtyYvWC96aBiMMa34/uVNwB3zk8JEWHqGKXaYO+pFOyeyzG8gpUQlE9r3WU+ex/vkjg4JIqBmOGtMEWIj9H7pEWVeKxsx1NQz341NnTp+hMh+aBhhuseMYC9ncdM/9qRgJOOGfRQQ6l8HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i7QZKYap; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c54f67db99so219676785a.1;
        Thu, 17 Apr 2025 13:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744920761; x=1745525561; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zoi0ff5wiEnF5NrgHmtLQdqka427yqT8GxfdnoW/sbk=;
        b=i7QZKYap/xPf1dWVlzwLzYwhRIyTWU9oMYj7gAn3dVQznHPiGjJldvgtAnFOvLDWQP
         m3BD/IGBargEnTs9OzjlPlPMHbzElvlKmleTTyrCMcLszmShJClK7Qixxdui/0SfZIOF
         mnlIbaAYjNydul7B9Hnu6/FilI/s660+Rxnvk90s2TdQy/tcNNRHUioEVLRRHcIA4R7J
         Fy9GFjNa/5AyqkFOkMkrYy9pz52wBoVDOQWSm4Gg1qMd8m0bubKVOh8IicdKfXgD3ne1
         d+dp3Et68+6XgMTKbROGAD8ebdAd6ILaHxFtahCH820yP+lRWYtOkQYjUNRi9x6CYoIY
         RpDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744920761; x=1745525561;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zoi0ff5wiEnF5NrgHmtLQdqka427yqT8GxfdnoW/sbk=;
        b=AW/7ExKgjdyJUVITXfa4CafXx6PFAQ8rZRdF0NPJtWS/F29flgfWZ6idnqUWTqBpKq
         s6R00rOtZv+271f6Y2QHCVvsW1S13bdZiSyFEWjZ3E5iTy0/nX5jr5vcP28SjM0f4QlW
         jFTLOBRbKgxztUm71CDC+gd5l9AiKjh4ciV9+37canKcsIXK8XlycFeYIDxUasXf0EJc
         9bfykvrWLYrg45VHXs8ENhOV6uCYG2g2XBf/0uDuuOttXcvYfWYOCPeU+i8gN+l4NSdg
         9Eqgypq55VKBdCTwBKf7p9QXt9w0mQMOPxB8JCuzMM5Dxbayc5PVkMxcEX34Mf+P51TN
         Tkew==
X-Forwarded-Encrypted: i=1; AJvYcCU0+P0hfhOgyXKZQqec8AfE2w3l6z8rOqImwk7NryL/o7SW+9jR9nhp51U69csY16IhBZk/DypI8+8oYmLC1C8=@vger.kernel.org, AJvYcCUaYwN5K3LU1D1EsdDdt8PVrZWEd39IPF2PNSDRMAvUBpV2S/wBuQBjMxwWJSuJy1zxqu31NyI6Zy/c5WPO@vger.kernel.org, AJvYcCUbekSlB18Qxo9IA2h9p5RZNmyKvi6/nhYfOTE2XiAr4fcn6dnP7FAhe0ynqla9bRqQ2BNWe61gbt8R@vger.kernel.org, AJvYcCUgwttZCtouLKZbXfFZT/Uf180Sk/fE1Hif0XE5IBZ+8PICfLpRpCjkdzuSpayOWDxLfTF1yL3i@vger.kernel.org, AJvYcCUtp0tAIPOC8itHhv3x+cy48PR9bf8Tv9N2p2a+MfJVOy1d6hfafrRuH178pQSjdkh/6dDV5RMQpwSGxy9Y@vger.kernel.org, AJvYcCV2dXeH59wyH4AvBLNC43LzZan33oODg2dGTn4PhJZyWMskxNHsS+pGA6vA1eD+X75mDr2Sd5XB5m6DTKU=@vger.kernel.org, AJvYcCXLikLaOlJQu+VuoBEs7VQq1pqQNcuZny4XvQOb7ydPL9/MV51Qypc66Ppw6pItr97yP1pR7ZlN/icOkC1nN5yr@vger.kernel.org, AJvYcCXuIPR6nC5ltxM3thItLi5NrGeE3dqqLO2RpPAuKCMpR2AoKBCVen6l9i5k2mvt/DCcjExrKgnECGdH@vger.kernel.org
X-Gm-Message-State: AOJu0YxZh3Gjcai5OUdzm3w5WrESn8O8SN99xodPUVOQSaGAdaMjvXVa
	G/pKrcncLGztyML4Kto2c5uNouf9nm9vo3v/PuhwsvbYLQx/sSkX
X-Gm-Gg: ASbGncuguwcPm1+esC4278371B4zd3mVyQNq/YXmADsdAedhENOS3l9ZoFpyqZgJb3H
	LGE4nLeRNBEln/W7z3BigjTsYxSFg/nA9QuTi4H2Jv7mwU2Y0oyTlWiyV9cs5M1tj7hBEaUjMJW
	2sOM4+cnYKqPcSoRex7JKfLZbScbv0hRBY/YGqF68jvtZjtDndZTFXe9ZZsbUsjtyWwj1TU3mm2
	xdReHEgOb196sqfdHFAK3MRBXvBkt1psZkiguH44DR1x4Fc0yyOr+Ykk4mAFV+WGQDLsmkgqGsa
	aEId5HR1EcYiaxmH7IkXa8SWF8gZgVIRRzD0hGVYNzlDyTAK/zXvV6cd5SxeYpu0tTbqpvJC/qf
	lGZYHqDXyPaQyQLaMRr5hLNwpuG59kCJVI6uhiTc10Q==
X-Google-Smtp-Source: AGHT+IGqYa4lJedN6y7Ve4i8uviWQPhLL4HlO4vwMswf+TVFKp5dheFZBpp1BDdZyASOOil8szBySw==
X-Received: by 2002:a05:620a:4316:b0:7c7:a59a:7d28 with SMTP id af79cd13be357-7c9282a2120mr24247985a.14.1744920761318;
        Thu, 17 Apr 2025 13:12:41 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c925a90d0csm28737285a.41.2025.04.17.13.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 13:12:40 -0700 (PDT)
Message-ID: <680160b8.050a0220.223d09.180f@mx.google.com>
X-Google-Original-Message-ID: <aAFgtdIF0u-rLNfH@winterfell.>
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 8AC19120006A;
	Thu, 17 Apr 2025 16:12:39 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 17 Apr 2025 16:12:39 -0400
X-ME-Sender: <xms:t2ABaEluN5DT2UN3ewEMRhb1e4ZFilXnxFCWA7iJ8UpRCPkkn6Y1RA>
    <xme:t2ABaD2n8XURyzhrY3rIUR7ig_him5JCzTcFyOeEci1ORrsiOA-WHOhmrzMDqxRc6
    tC9qwR9bdW60FBjUw>
X-ME-Received: <xmr:t2ABaCpbwV02LCykqDAfsudF-KwQLdGqtzjr7uf4AQwxBv-SobXhHjRBGqjkXA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfedtudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpefftdeihfeigedtvdeuueffieetvedtgeej
    uefhhffgudfgfeeggfeftdeigeehvdenucffohhmrghinhepghhithhhuhgsrdgtohhmne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhu
    nhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqdduje
    ejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdr
    nhgrmhgvpdhnsggprhgtphhtthhopeegjedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepthgrmhhirhgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrshgrhhhirhho
    hieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgrthhhrghnsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegr
    lhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgrrhihsehgrg
    hrhihguhhordhnvghtpdhrtghpthhtohepsghjohhrnhefpghghhesphhrohhtohhnmhgr
    ihhlrdgtohhmpdhrtghpthhtohepsggvnhhnohdrlhhoshhsihhnsehprhhothhonhdrmh
    gvpdhrtghpthhtoheprgdrhhhinhgusghorhhgsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:t2ABaAn51l6h8kcSU9WHdQj5kJvan993M2LqrkdAjhKXJHuO4a1KtQ>
    <xmx:t2ABaC3j1SO3jyP-mSxmb3cfyHYwW3fYXf8DfvVvnlncH2Sh-LEtMg>
    <xmx:t2ABaHvEjmDAFlKCngtXS7SBllGdUriEzbfRdTcGDxhlYd9Shva_iQ>
    <xmx:t2ABaOW7UZ99I_VYCGFNTtdAlRH4ZGv_7Y9Say0vGmDNZbSINMa53A>
    <xmx:t2ABaF2LaRqardld_ypulw1i-c2D8p68PU-VfbVkCLJsGfqirUaCmpRD>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Apr 2025 16:12:38 -0400 (EDT)
Date: Thu, 17 Apr 2025 13:12:37 -0700
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
Subject: Re: [PATCH v9 4/6] rust: enable `clippy::as_underscore` lint
References: <20250416-ptr-as-ptr-v9-0-18ec29b1b1f3@gmail.com>
 <20250416-ptr-as-ptr-v9-4-18ec29b1b1f3@gmail.com>
 <68014084.0c0a0220.394e75.122c@mx.google.com>
 <CAJ-ks9muaNU9v2LZ5=cmfXV6R5AO+joNOoPP=+hs-GJN=APfKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ-ks9muaNU9v2LZ5=cmfXV6R5AO+joNOoPP=+hs-GJN=APfKQ@mail.gmail.com>

On Thu, Apr 17, 2025 at 03:26:14PM -0400, Tamir Duberstein wrote:
[...]
> >
> > >          Ok(())
> > >      }
> > > diff --git a/rust/kernel/device_id.rs b/rust/kernel/device_id.rs
> > > index e5859217a579..4063f09d76d9 100644
> > > --- a/rust/kernel/device_id.rs
> > > +++ b/rust/kernel/device_id.rs
> > > @@ -82,7 +82,7 @@ impl<T: RawDeviceId, U, const N: usize> IdArray<T, U, N> {
> > >              unsafe {
> > >                  raw_ids[i]
> > >                      .as_mut_ptr()
> > > -                    .byte_offset(T::DRIVER_DATA_OFFSET as _)
> > > +                    .byte_add(T::DRIVER_DATA_OFFSET)
> > >                      .cast::<usize>()
> > >                      .write(i);
> > >              }
> > > diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
> > > index f7e8f5f53622..70d12014e476 100644
> > > --- a/rust/kernel/devres.rs
> > > +++ b/rust/kernel/devres.rs
> > > @@ -45,7 +45,7 @@ struct DevresInner<T> {
> > >  /// # Example
> > >  ///
> > >  /// ```no_run
> > > -/// # use kernel::{bindings, c_str, device::Device, devres::Devres, io::{Io, IoRaw}};
> > > +/// # use kernel::{bindings, c_str, device::Device, devres::Devres, ffi::c_void, io::{Io, IoRaw}};
> > >  /// # use core::ops::Deref;
> > >  ///
> > >  /// // See also [`pci::Bar`] for a real example.
> > > @@ -59,19 +59,19 @@ struct DevresInner<T> {
> > >  ///     unsafe fn new(paddr: usize) -> Result<Self>{
> > >  ///         // SAFETY: By the safety requirements of this function [`paddr`, `paddr` + `SIZE`) is
> > >  ///         // valid for `ioremap`.
> > > -///         let addr = unsafe { bindings::ioremap(paddr as _, SIZE as _) };
> > > +///         let addr = unsafe { bindings::ioremap(paddr as bindings::phys_addr_t, SIZE) };
> >
> >
> > ///         let addr = unsafe { bindings::ioremap(bindings::phys_addr_t::from(paddr), SIZE) };
> >
> > better? Or even with .into()
> >
> > ///         let addr = unsafe { bindings::ioremap(paddr.into(), SIZE) };
> 
> This doesn't compile because `paddr` is usize, and
> `bindings::phys_addr_t` is u64 (on my machine, which is aarch64).
> 

Ok, looks like Rust yet doesn't provide From/Into between usize and u64
even if the pointer size is fixed. Latest discussion can be found at:

	https://github.com/rust-lang/rust/issues/41619#issuecomment-2056902943

Lemme see if we can get an issue tracking this. Thanks for taking a
look.

> > >  ///         if addr.is_null() {
> > >  ///             return Err(ENOMEM);
> > >  ///         }
> > >  ///
> > > -///         Ok(IoMem(IoRaw::new(addr as _, SIZE)?))
> > > +///         Ok(IoMem(IoRaw::new(addr as usize, SIZE)?))
> > >  ///     }
> > >  /// }
> > >  ///
> > >  /// impl<const SIZE: usize> Drop for IoMem<SIZE> {
> > >  ///     fn drop(&mut self) {
> > >  ///         // SAFETY: `self.0.addr()` is guaranteed to be properly mapped by `Self::new`.
> > > -///         unsafe { bindings::iounmap(self.0.addr() as _); };
> > > +///         unsafe { bindings::iounmap(self.0.addr() as *mut c_void); };
> > >  ///     }
> > >  /// }
> > >  ///
> > [...]
> > > diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
> > > index 43ecf3c2e860..851a6339aa90 100644
> > > --- a/rust/kernel/dma.rs
> > > +++ b/rust/kernel/dma.rs
> > > @@ -38,7 +38,7 @@
> > >  impl Attrs {
> > >      /// Get the raw representation of this attribute.
> > >      pub(crate) fn as_raw(self) -> crate::ffi::c_ulong {
> > > -        self.0 as _
> > > +        self.0 as crate::ffi::c_ulong
> >
> >         crate::ffi::c_ulong::from(self.0)
> >
> > maybe, a C unsigned long should always be able to hold the whole `Attr`
> > and a lossly casting is what this function does.
> 
> This also doesn't compile: "the trait `core::convert::From<u32>` is
> not implemented for `usize`". Upstream has ambitions of running on
> 16-bit, I guess :)
> 

They do but they also have the target_pointer_width cfg, so they can
totally provide these functions. It's just they want to find a better
way (like the link I post above).

Regards,
Boqun

