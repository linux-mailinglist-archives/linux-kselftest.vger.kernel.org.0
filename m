Return-Path: <linux-kselftest+bounces-29270-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56488A65C35
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 19:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F4DD19A10AF
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 18:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2581C07DA;
	Mon, 17 Mar 2025 18:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XuoWCvjW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D751A5B95;
	Mon, 17 Mar 2025 18:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742235424; cv=none; b=ThhxBfXMjEZrb//3Se0EsFjMYEDQPMhFy+j4o+Vs6t5+NCz17uPkBtXMqnc+zDAdM/wCNFpkPuc+zb1kC9KhZxEHoEFHAiGCWpw04GHt7V0G8UiU+Lz2vsxqe4OJNp/xPH9w8Y9TEPSPna71rCQnBh0Thc3HormNEoW1c+wYmLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742235424; c=relaxed/simple;
	bh=EYQCXNR1fnl1wWPPKs9b1TEod9XljzCnx9/BpeczPEI=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OY+4xMDPH44Y0aUpw726fIWxGdIwDuQu8mBpi5TtTWgiwMFgR2V5FJ6wHLepzGIK1RKtdW11WASwStFzqWQ8vtyOMqk4aXXhFHbOMY0cuyK+YrwDgX0+j3gjUSxZx851vjCeEd989u3pukAJVLIcpi2wzT4mmFIwRFpP+ucMg3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XuoWCvjW; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7be6fdeee35so846869185a.1;
        Mon, 17 Mar 2025 11:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742235421; x=1742840221; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:feedback-id
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cGBnGtUMV4N26BP3QlQ12S9pan6nDACT7i7KUsJv6yY=;
        b=XuoWCvjWEDIlvLa20nmqHHoxUL+PERBimyAzL5lN7VE8Kw+V8BSxdzD+xiIPd589bX
         Ztv5kTHD10Abei5R34BcWsL+AooHVPx+al7bjPm7/mfVh03y3iqsctnVQiff8SevaPQU
         SlA0gmFVy3Rt5yIHpLZDVsHwojAkaD+N9ltiYc8SMdTZ3Tq4DtHL5ahUJGKK44sJ9brR
         AsMoXxxhY7mpYcL0/RO3SOkvEV4B4CK0VJjRN/sGNGZrcc129tB3/QrGUdAjkJvpJ1sQ
         hvwyuKXJZzcFklDZ5mWLj+1ELEoy7dRdXsNDxr8AWL+6mknW37w00abzAtU5w0uixi4V
         hyJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742235421; x=1742840221;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:feedback-id
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cGBnGtUMV4N26BP3QlQ12S9pan6nDACT7i7KUsJv6yY=;
        b=uNr6KrmcA8/RbvZBqzihpXx7c4qU4y3L2xBl1k1vXiEbEpyoAur+O9hrhqdjukhYJ7
         +X+SakxTLJVxFG2G3VDeGKuPqorV4qWUSN1XVwspwc7j/SCl4/uAG/kLq7C2R9pKDC2t
         OHCkYFAFvjpXSU42GVB5JtnfnkfCuefnFzqlrCFWs/rema9OFTOjCF92g9QBFzh3MXg+
         KL0Acn1kTqst/1Jo9lpsjR8RWvle4xaRfUuFaxfrkaD7qiwohhldwMQdAoR+9guRJqrI
         J9Zm1+6gjjPOSFhPGzVvK1ZTKhndvT+f04QHnRNNecLpsYsFtdJdlDvwGFZURt43JjB4
         oBmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUFBwBITPIWXFneGM68n8s0wqAtGS41vvd/lIl8k7sokfiYcuEmLXrxNE1N+s63qN3ABqO81WQXrUR+densNiE=@vger.kernel.org, AJvYcCUTyrDnHKdsrAYMYfHsbGz/O6Dmew27Ij25qf+zXFHp64yaZo9VfKSt/eKwKwLORL7URuttrlFVa0nw@vger.kernel.org, AJvYcCUnw/dA9uGJGxi3BOeoexnEAb1AK2ZHpS5YYprTbR4yXNfAxmh1cr/p5NJ211VeBi6n+qCDrTvr0gwVgyqO@vger.kernel.org, AJvYcCVqAoou+Z71nz+uZA4YwxqOOe0MQFsGewWAhj80n+XRZ5dLOLsxLpdd9Y6DSPdukWseoX0kwSXdsUR+lPs=@vger.kernel.org, AJvYcCVrlPBZtf1+CtRa08dWMwOV1QGDRmqB38n9ig+sLYbZHJE/ttYOJtwC5Q1N/thlXlHwhi5opuXroYFJ1Rg9@vger.kernel.org, AJvYcCXdjrYsXrWV9KL9WY9sJ9AA0qu4757FgtYvjDwM02LCxutgljf+xeLLi6S4MEMjoiEKfyHhkrtx+9g1@vger.kernel.org, AJvYcCXs/xt3693nnpitzZEAHmqm8R2TY0uuQ0fBv+SzGWyexWC6u0vQ9i/pO7d+AmABnV4UHmGlK1gyHgsHfimK0Sgr@vger.kernel.org
X-Gm-Message-State: AOJu0YzbzMb/eeybl5M6GEvhk6OvgEqz1NYyga4YjxmSmFZY6SxKm3+x
	aw3Icn8VPSQCFa6Ufpe/AG8P0Xa+wKwNfOza7cmb40PFciicbkwp
X-Gm-Gg: ASbGnctxUQ/hsS9pQ9pXCqBWAtmwx8/rZ7vgbsCzOJHmkTlptrMBTecc00S/Mv4h+jq
	9UJ4tFmNEgYb8wePucr0Hfk5EjuU+XXMLawKWSoOaKHSUWsE8Tf7GRE5Ineg8y3YVA9POd1PPw6
	kZdTvIohGysm8sPKQ+hZGZ/pwSrKdeViiqBjivFPWG0YxdyaY0kBN1hSEzMKkvi3hkraXVtAzto
	hVc6WtwB8Mci0EQFs1e05Y4aIkkoRZ75lGYHbeLFTHI3qozpE++QwCR1XT42D/Y+I3HEXabDmDB
	B+78SdUWp0DHm4HckR3Wz/8QJVtReK7vHhXCJzxQmHeUTvPIEf1tDobQQ/Mfk9vhdbMC4631ma8
	g49Icz/LPenTRSxJqfYL9kLkopIr1NliPOXk=
X-Google-Smtp-Source: AGHT+IHZ19Mtd+P5elXN8MUUqT70x0aWcnKbrNuywFbsTL1ou8fnOUqUq8bDmmEjEHpoomslrhv8qQ==
X-Received: by 2002:a05:620a:2887:b0:7c5:99a6:7883 with SMTP id af79cd13be357-7c599a67960mr259055485a.54.1742235421536;
        Mon, 17 Mar 2025 11:17:01 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573d72b94sm619175685a.77.2025.03.17.11.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 11:17:01 -0700 (PDT)
Message-ID: <67d8671d.050a0220.3305ab.6372@mx.google.com>
X-Google-Original-Message-ID: <Z9hnGprWodQ2Pbup@winterfell.>
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 63D291200043;
	Mon, 17 Mar 2025 14:17:00 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 17 Mar 2025 14:17:00 -0400
X-ME-Sender: <xms:HGfYZwJmp9VRvX_XyrW2qHZfusbGxOojCkf4ouObKayviNjmwTiNdw>
    <xme:HGfYZwJXumttfwvQ0Sr2IHfNV0sSzTct-YE9qDx5WPTU_lkLmomZLlZ1j8MrtbsZB
    VQjkM8b7wwIm60dAw>
X-ME-Received: <xmr:HGfYZwswuzHhqYuhH0TMeV0WnfNLGC2IWgMV7lGKmyWiW4H0mIJnzBPdgaY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugedtvdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrg
    hilhdrtghomheqnecuggftrfgrthhtvghrnhepieehfeekgfdvfeetjeejudekhfeiveel
    feefveehheeffffhkefhteevffevhffgnecuffhomhgrihhnpehruhhsthdqlhgrnhhgrd
    horhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    sghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtie
    egqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhi
    gihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopeefvddpmhhouggvpehsmhhtphhouhhtpd
    hrtghpthhtohepthgrmhhirhgusehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrshgr
    hhhirhhohieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgrthhhrghnsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehnihgtohhlrghssehfjhgrshhlvgdrvghupdhrtghp
    thhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrg
    ihnhhorhesghhmrghilhdrtghomhdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdr
    nhgvthdprhgtphhtthhopegsjhhorhhnfegpghhhsehprhhothhonhhmrghilhdrtghomh
    dprhgtphhtthhopegsvghnnhhordhlohhsshhinhesphhrohhtohhnrdhmvg
X-ME-Proxy: <xmx:HGfYZ9bC5HJI2gjlDJ8Cr2TlyJ_LMerRt1wcGwogHVxrmpKYzZ_oQQ>
    <xmx:HGfYZ3b9_t_FXuY_AcAItbW6GVpsmF9Oo4xxGj19Y0sLmTSyFlcEnw>
    <xmx:HGfYZ5CL-PTmQx4JvirZcvRjt1ksvGpB4jqVFsoEoLHm_h8TQXSU7w>
    <xmx:HGfYZ9ZdlJbXrL3uWiFTQIOlRQflsbAnaT5qWy5f8SqmdIQ1kKFtQw>
    <xmx:HGfYZ_oEc4ckfcRaCiG2Y6kvXBTBNF5ajW_GVUxaTddTgkFfbabVdnZZ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Mar 2025 14:16:59 -0400 (EDT)
Date: Mon, 17 Mar 2025 11:16:58 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>,
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
	Saravana Kannan <saravanak@google.com>,	linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org,	rust-for-linux@vger.kernel.org,
 linux-kselftest@vger.kernel.org,	kunit-dev@googlegroups.com,
 linux-pci@vger.kernel.org,	linux-block@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v5 6/6] rust: use strict provenance APIs
References: <20250317-ptr-as-ptr-v5-0-5b5f21fa230a@gmail.com>
 <20250317-ptr-as-ptr-v5-6-5b5f21fa230a@gmail.com>
 <67d85e51.050a0220.2a36b.58b3@mx.google.com>
 <CAJ-ks9kBp8zPfaQuZRb0Unms1b13hDb5cRypceO8TWFR0Ty5Ww@mail.gmail.com>
 <67d864b2.0c0a0220.39fb6f.4df4@mx.google.com>
 <CAJ-ks9n8mwt5q9unqfkfSHj9=ELJHtqsXM-xQ8jsbXeJX6Uyfg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ-ks9n8mwt5q9unqfkfSHj9=ELJHtqsXM-xQ8jsbXeJX6Uyfg@mail.gmail.com>

On Mon, Mar 17, 2025 at 02:10:42PM -0400, Tamir Duberstein wrote:
> On Mon, Mar 17, 2025 at 2:06 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > On Mon, Mar 17, 2025 at 02:04:34PM -0400, Tamir Duberstein wrote:
> > > On Mon, Mar 17, 2025 at 1:39 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> > > >
> > > > On Mon, Mar 17, 2025 at 10:23:56AM -0400, Tamir Duberstein wrote:
> > > > [...]
> > > > > diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> > > > > index fc6835cc36a3..c1b274c04a0f 100644
> > > > > --- a/rust/kernel/lib.rs
> > > > > +++ b/rust/kernel/lib.rs
> > > > > @@ -17,6 +17,11 @@
> > > > >  #![cfg_attr(not(CONFIG_RUSTC_HAS_COERCE_POINTEE), feature(coerce_unsized))]
> > > > >  #![cfg_attr(not(CONFIG_RUSTC_HAS_COERCE_POINTEE), feature(dispatch_from_dyn))]
> > > > >  #![cfg_attr(not(CONFIG_RUSTC_HAS_COERCE_POINTEE), feature(unsize))]
> > > > > +#![cfg_attr(
> > > > > +    CONFIG_RUSTC_HAS_STABLE_STRICT_PROVENANCE,
> > > > > +    feature(strict_provenance_lints),
> > > > > +    deny(fuzzy_provenance_casts, lossy_provenance_casts)
> > > > > +)]
> > > > >  #![feature(inline_const)]
> > > > >  #![feature(lint_reasons)]
> > > > >  // Stable in Rust 1.83
> > > > > @@ -25,6 +30,109 @@
> > > > >  #![feature(const_ptr_write)]
> > > > >  #![feature(const_refs_to_cell)]
> > > > >
> > > > > +#[cfg(CONFIG_RUSTC_HAS_STABLE_STRICT_PROVENANCE)]
> > > > > +#[allow(clippy::incompatible_msrv)]
> > > > > +mod strict_provenance {
> > > > > +    /// Gets the "address" portion of the pointer.
> > > > > +    ///
> > > > > +    /// See https://doc.rust-lang.org/stable/core/primitive.pointer.html#method.addr.
> > > > > +    #[inline]
> > > > > +    pub fn addr<T>(ptr: *const T) -> usize {
> > > > > +        ptr.addr()
> > > > > +    }
> > > > > +
> > > >
> > > > For addr(), I would just enable feature(strict_provenance) if
> > > > CONFIG_RUSTC_HAS_STABLE_STRICT_PROVENANCE=n, because that feature is
> > > > available for 1.78. Plus we may need with_addr() or map_addr() in the
> > > > future.
> > >
> > > We still need these stubs to avoid `clippy::incompatible_msrv`, and
> > > we'll need those until MSRV is above 1.84.
> > >
> >
> > Hmm.. why? Clippy cannot work with unstable features?
> 
> Yes, `clippy::incompatible_msrv` doesn't pay attention to enabled
> unstable features.

Then we should fix clippy or how we set msrv rather adding the stub.
@Miguel?

Regards,
Boqun

