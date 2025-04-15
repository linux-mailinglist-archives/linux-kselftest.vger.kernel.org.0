Return-Path: <linux-kselftest+bounces-30892-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDCEA8A699
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 20:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 526EB17F000
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 18:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613C32206BE;
	Tue, 15 Apr 2025 18:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSfwFKd6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C1E20C02E;
	Tue, 15 Apr 2025 18:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744741083; cv=none; b=JtbfaH1Apmtp5MfNTazcDR+OG+rERORiL+f7NMxZ3H9TNxoYdKjdbTfHI9GKIGovJHM7hhjd5jmJuhvRCAK2ZdEVLcdWD+Uq2TC9WUKEUuSrkwEkVCuhcIItIrQG3oTu/C7W+KevGX+abL5SMELYDpRsNYh0ammkvxCFpU6gXFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744741083; c=relaxed/simple;
	bh=hBQWsWabfwGfXwS58TZeuoy5jyXcr/PgT5bDAAydwYg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KhbbIbfn3ZUDvzjgkNKPfBo2/sNMI0rqOoNLwYtyidv/MfBIDuqbu8CSlKUXuHJ+i5eubDs1mZh7W7lHyWPpeZNvodPXs1rwUBPWl6ZGonXn/qNLrMJHXsvff4IJUDOc/OxRZGDkV/tDhM4DerJ0viiOM0GRGIBASywU+BJd6U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aSfwFKd6; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c592764e54so696534485a.3;
        Tue, 15 Apr 2025 11:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744741079; x=1745345879; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:feedback-id
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ExhlIGj+yTSPW/bDWyFi4TK2XTBBWSbc3TeamRQDEM0=;
        b=aSfwFKd6meZM2jmxG2i72fr4E8UljvEpwQ/+OFPV3iBr1rhXJXBo+qjHkzyr1x15fu
         QGmjATakcPvfU0mqpCZY4JPYhobeQh1REcmSvjHr59rxYRqZWUdDixIVkJoxj7du8R49
         gvoRcd+bfazrjXroaUOEaz5l5K/p1U/gsfTzuSq4JM+2+3O6mxuU/fsnuv5Ii6mnFIFl
         0eWhJosL8EOBMsJBiB8LlmqU4G0tdhAAnLEk8C7/USbqoYdyVY3PgY2C8QM/mnnpXc/h
         c3hjEdoF0O1V5SaDnCp2mt4gYWOY3gbTUjR5mu0iDZ80erNr1K3IexZ7KgHa4YivzkXy
         lvKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744741079; x=1745345879;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:feedback-id
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ExhlIGj+yTSPW/bDWyFi4TK2XTBBWSbc3TeamRQDEM0=;
        b=TKQ2FQWAvPzj6Y2LWTshy39a6MUCMQTqYSMwxgSnQoJqusOQBV+n1p8H9RpuuyQ8uE
         n6NF/hwAzbIOS9TNdwCcCUBWrxCV+oLQVwoQst91cS4fvYiRoWp+sm51EUHlyRW6685u
         ro3wm2t3HYwS1VkSPQXQbQYzXcYZb79ecpJ/08FbiiDLAQmpZrzQQnbExtl8Be8WL+Tq
         eU5bD9EWR4L74/4dbUQWCLs6B7QgD7LwieWY7RFOiy430IhkT0xROxXRjE2UURX5Lre3
         v0uWOabRK1M/IoNuXTv8ItqXMEcUWMouakCc59Go1HKwosAvtbvFr0INEJBSn/84LDuG
         nKjA==
X-Forwarded-Encrypted: i=1; AJvYcCUU7Lfd+LMJ9xqv3QyYXKZ8PkyYPoap69a4rYO97ZfEMYRqZ7XyDbtWwtxMlWOBDffNgtYRK6i0nkYz@vger.kernel.org, AJvYcCUqwJlSjqfmjV4XZv0g0V1Msbm8s/hk8vwOtEz4VC+iPyT6MDeXI8HM4LnYu3DK8EDOry2NT2SUWogn9d+Yv8Q=@vger.kernel.org, AJvYcCVDFz5p90dIj8ZVwhWUIQBzNxApNsCAlQac9deFeL+05m3mXMSp3GG6OSJBqUdDTPIYoBwr7XShXnj6@vger.kernel.org, AJvYcCVT5J/LmWXLaPq6/k7EDIxtB58P7vHVCGVxmlQ/WcNhp5Y8M9AYm5Z3ujHEcyfNEw6L7dDAlkZnCpbx9ITN@vger.kernel.org, AJvYcCVri6KjmZ/6IbRwSbCv1m+bXouvVK48kWnD/7gHggObEmJoN1QBEu3uq6AmjD28DjYfhTXNJvcvH8Nb9ps=@vger.kernel.org, AJvYcCW5BTW3GbwJ+lme+7pf8+2h3v0dRZeNyXlFc6NDL9wieEQWHBRBrmSQqH1Q8cqNRFJzUxesV5OznsD7EEgd@vger.kernel.org, AJvYcCWlnL+pxEN8R9+75UaWUwUHMn53g7f2dPD7iGaDNj4on5C3eN3HDm4VAHoaYABON+gHhzmajqfo@vger.kernel.org, AJvYcCXBTk1ilBiP40l0yXl5nIJZoA9EyVsVHIbATcSRKRy0wFYZqcsQdPcv8/TrgDiAf7nV1FIeDj+zDT2LmoyUKVdU@vger.kernel.org
X-Gm-Message-State: AOJu0YwEbuhrYp1T0DGFDl2B4cOBqams4SuTaBiyrnYLQx6bDTF7TkL1
	52EVDmlaM4qZvuE6wgKyivUYcQ5w1JdBLOcvoiHlVhjoQeYrLTRK
X-Gm-Gg: ASbGnctOacj02QTN7KeQuisExaEHRyrbupB1lpW+LTfF9pfbU9aJHKbtBDRLdx/J23j
	ilY8t/Shn1Ty7xZqpwvuqTcNyQ3SAOWHuasGOVXvyH7cS7dcNOb6nvrTUhpMrbS1N6GQ0g/GxUg
	Nrs0A5K+90OzcSGXck+G534PrO5P5EIrtHc7XI3KcVXE5OW9qA4zO+gnZk6LKIxsprzovAT6Rjp
	n3TC3cg48kBaAEX/f0lQbmAcbKdDJEjQVdFdc2O3EJsSoVKc3edMyI9/YAD5hHJeoC6Qkr+jwXR
	wwib9tq+ys03V7zgES2EkoM58x4XbpDaoH+9rnSwvjb4f81sgkSmNnEj4ykogvg9+q9s2yAB+Xg
	jD4yQVQSjFGoFLKl+zFakCwZBC9h5Uns=
X-Google-Smtp-Source: AGHT+IFVhSC6OL+aHzP4UlljX/heiemumch2r3K6vBxStW09sbsikfEhG8+kvEM3mf7eRSQiqbICcQ==
X-Received: by 2002:a05:620a:bcc:b0:7c5:3ca5:58fb with SMTP id af79cd13be357-7c91415d59emr74272085a.4.1744741079462;
        Tue, 15 Apr 2025 11:17:59 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c7a8951562sm936825785a.35.2025.04.15.11.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 11:17:58 -0700 (PDT)
Message-ID: <67fea2d6.050a0220.8fa7f.6690@mx.google.com>
X-Google-Original-Message-ID: <Z_6i0yjysPAaySGW@winterfell.>
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id D1ACA1200069;
	Tue, 15 Apr 2025 14:17:57 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 15 Apr 2025 14:17:57 -0400
X-ME-Sender: <xms:1aL-ZzOZ7kkx6oxN54FGRf3pqCp4eRIaxCOhh4pwFwYV8BSAoE68sA>
    <xme:1aL-Z98oNZWbcy7I7imgoURM7wrGUlGwt87cF0JY67yzZVOJoKUl4idcScql3_NDK
    8hqw7iHfzt-5ux_uw>
X-ME-Received: <xmr:1aL-ZyQZT1Fnk6K32y51NUIZVCOSEkXr9XkKDLh3Xn-KlNM2K587N9isrYgX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdegudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnegoufhushhpvggtthffohhmrghinhculdegledmnecujfgu
    rhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpeeuohhquhhnuc
    fhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthht
    vghrnhepgfeiffdvheeiheeuudejgeeuffeiledvvdffvdduteehvdfhiedvffdukeevhf
    ehnecuffhomhgrihhnpehgihhthhhusgdrihhopdhkvghrnhgvlhdrohhrghdpihgushdr
    rghspdhgihhthhhusgdrtghomhdpphhtrhgprghspghpthhrrdhrshenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhht
    phgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqd
    gsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgs
    pghrtghpthhtohepgeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtrghmih
    hrugesghhmrghilhdrtghomhdprhgtphhtthhopehmrghsrghhihhrohihsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehnrghthhgrnheskhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgih
    nhhorhesghhmrghilhdrtghomhdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnh
    gvthdprhgtphhtthhopegsjhhorhhnfegpghhhsehprhhothhonhhmrghilhdrtghomhdp
    rhgtphhtthhopegsvghnnhhordhlohhsshhinhesphhrohhtohhnrdhmvgdprhgtphhtth
    hopegrrdhhihhnuggsohhrgheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:1aL-Z3t4V1nrnDRpDe3waAoDcwL-GT2iKdz-e9M1OlfleZb4jENPyA>
    <xmx:1aL-Z7eSJJgAc9FzMJTBxxOc2BlYKIs16ufbEqnCTVnUFBnVzUW3sg>
    <xmx:1aL-Zz1-_Rbwhxszl-I2Fi4Fh-tnnCR2L9c2t2uyyWEL-p59Ujgbaw>
    <xmx:1aL-Z38fM0JFsuSXIKsSdFYK73Z2nyEo2suHLtyJcymmhVEpWDmX0A>
    <xmx:1aL-Z-9P1VFxFc4GoBFdNDkQp0zG9p8sGfilqgSN_7dnXPmKSilVoZy->
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Apr 2025 14:17:57 -0400 (EDT)
Date: Tue, 15 Apr 2025 11:17:55 -0700
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
Subject: Re: [PATCH v8 6/6] rust: enable `clippy::ref_as_ptr` lint
References: <20250409-ptr-as-ptr-v8-0-3738061534ef@gmail.com>
 <20250409-ptr-as-ptr-v8-6-3738061534ef@gmail.com>
 <67fe9975.c80a0220.1b5785.66e7@mx.google.com>
 <CAJ-ks9mzyfvsxkyud_wLXfhLD_zP95bivCQ9i2aC-3ea=Y7+0A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ-ks9mzyfvsxkyud_wLXfhLD_zP95bivCQ9i2aC-3ea=Y7+0A@mail.gmail.com>

On Tue, Apr 15, 2025 at 01:58:41PM -0400, Tamir Duberstein wrote:
> Hi Boqun, thanks for having a look!
> 
> On Tue, Apr 15, 2025 at 1:37 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > On Wed, Apr 09, 2025 at 10:47:23AM -0400, Tamir Duberstein wrote:
> > > In Rust 1.78.0, Clippy introduced the `ref_as_ptr` lint [1]:
> > >
> > > > Using `as` casts may result in silently changing mutability or type.
> > >
> > > While this doesn't eliminate unchecked `as` conversions, it makes such
> > > conversions easier to scrutinize.  It also has the slight benefit of
> > > removing a degree of freedom on which to bikeshed. Thus apply the
> > > changes and enable the lint -- no functional change intended.
> > >
> > > Link: https://rust-lang.github.io/rust-clippy/master/index.html#ref_as_ptr [1]
> > > Suggested-by: Benno Lossin <benno.lossin@proton.me>
> > > Link: https://lore.kernel.org/all/D8PGG7NTWB6U.3SS3A5LN4XWMN@proton.me/
> > > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> > > ---
> > >  Makefile                 |  1 +
> > >  rust/bindings/lib.rs     |  1 +
> > >  rust/kernel/device_id.rs |  3 ++-
> > >  rust/kernel/fs/file.rs   |  3 ++-
> > >  rust/kernel/str.rs       |  6 ++++--
> > >  rust/kernel/uaccess.rs   | 10 ++++------
> > >  rust/uapi/lib.rs         |  1 +
> > >  7 files changed, 15 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/Makefile b/Makefile
> > > index eb5a942241a2..2a16e02f26db 100644
> > > --- a/Makefile
> > > +++ b/Makefile
> > > @@ -485,6 +485,7 @@ export rust_common_flags := --edition=2021 \
> > >                           -Wclippy::no_mangle_with_rust_abi \
> > >                           -Wclippy::ptr_as_ptr \
> > >                           -Wclippy::ptr_cast_constness \
> > > +                         -Wclippy::ref_as_ptr \
> > >                           -Wclippy::undocumented_unsafe_blocks \
> > >                           -Wclippy::unnecessary_safety_comment \
> > >                           -Wclippy::unnecessary_safety_doc \
> > > diff --git a/rust/bindings/lib.rs b/rust/bindings/lib.rs
> > > index b105a0d899cc..2b69016070c6 100644
> > > --- a/rust/bindings/lib.rs
> > > +++ b/rust/bindings/lib.rs
> > > @@ -27,6 +27,7 @@
> > >  #[allow(dead_code)]
> > >  #[allow(clippy::cast_lossless)]
> > >  #[allow(clippy::ptr_as_ptr)]
> > > +#[allow(clippy::ref_as_ptr)]
> > >  #[allow(clippy::undocumented_unsafe_blocks)]
> > >  mod bindings_raw {
> > >      // Manual definition for blocklisted types.
> > > diff --git a/rust/kernel/device_id.rs b/rust/kernel/device_id.rs
> > > index 4063f09d76d9..37cc03d1df4c 100644
> > > --- a/rust/kernel/device_id.rs
> > > +++ b/rust/kernel/device_id.rs
> > > @@ -136,7 +136,8 @@ impl<T: RawDeviceId, U, const N: usize> IdTable<T, U> for IdArray<T, U, N> {
> > >      fn as_ptr(&self) -> *const T::RawType {
> > >          // This cannot be `self.ids.as_ptr()`, as the return pointer must have correct provenance
> > >          // to access the sentinel.
> > > -        (self as *const Self).cast()
> > > +        let this: *const Self = self;
> >
> > Hmm.. so this lint usually just requires to use a let statement instead
> > of as expression when casting a reference to a pointer? Not 100%
> > convinced this results into better code TBH..
> 
> The rationale is in the lint description and quoted in the commit
> message: "Using `as` casts may result in silently changing mutability
> or type.".
> 

Could you show me how you can silently change the mutability or type? A
simple try like below doesn't compile:

	let x = &42;
	let ptr = x as *mut i32; // <- error
	let another_ptr = x as *const i64; // <- error

also from the link document you shared, looks like the suggestion is to
use core::ptr::from_{ref,mut}(), was this ever considered?

> >
> > > +        this.cast()
> > >      }
> > >
> > >      fn id(&self, index: usize) -> &T::RawType {
> > > diff --git a/rust/kernel/fs/file.rs b/rust/kernel/fs/file.rs
> > > index 791f493ada10..559a4bfa123f 100644
> > > --- a/rust/kernel/fs/file.rs
> > > +++ b/rust/kernel/fs/file.rs
> > > @@ -359,12 +359,13 @@ impl core::ops::Deref for File {
> > >      type Target = LocalFile;
> > >      #[inline]
> > >      fn deref(&self) -> &LocalFile {
> > > +        let this: *const Self = self;
> > >          // SAFETY: The caller provides a `&File`, and since it is a reference, it must point at a
> > >          // valid file for the desired duration.
> > >          //
> > >          // By the type invariants, there are no `fdget_pos` calls that did not take the
> > >          // `f_pos_lock` mutex.
> > > -        unsafe { LocalFile::from_raw_file((self as *const Self).cast()) }
> > > +        unsafe { LocalFile::from_raw_file(this.cast()) }
> > >      }
> > >  }
> > >
> > > diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> > > index 40034f77fc2f..75b4a18c67c4 100644
> > > --- a/rust/kernel/str.rs
> > > +++ b/rust/kernel/str.rs
> > > @@ -28,8 +28,9 @@ pub const fn is_empty(&self) -> bool {
> > >      /// Creates a [`BStr`] from a `[u8]`.
> > >      #[inline]
> > >      pub const fn from_bytes(bytes: &[u8]) -> &Self {
> > > +        let bytes: *const [u8] = bytes;
> > >          // SAFETY: `BStr` is transparent to `[u8]`.
> > > -        unsafe { &*(bytes as *const [u8] as *const BStr) }
> > > +        unsafe { &*(bytes as *const BStr) }
> >
> >         unsafe { &*(bytes.cast::<BStr>()) }
> >
> > ? I'm curious why this dodged the other lint (ptr_as_ptr).
> 
> The reason it has to be written this way is that BStr is !Sized, and
> `pointer::cast` has an implicit Sized bound.
> 
> Perhaps the lint is smart enough to avoid the suggestion in that case?
> Seems like yes:
> https://github.com/rust-lang/rust-clippy/blob/d3267e9230940757fde2fcb608605bf8dbfd85e1/clippy_lints/src/casts/ptr_as_ptr.rs#L36.
> 

Oh, I see, so fat pointers get their way from this check? Hmm... however
fat pointers also suffer the same problem that ptr_as_ptr prevents,
right? How should we avoid that?

Regards,
Boqun

