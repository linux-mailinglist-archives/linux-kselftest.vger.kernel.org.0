Return-Path: <linux-kselftest+bounces-30912-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB35A8ABBD
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 01:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90BB817E628
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 23:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B012D86AF;
	Tue, 15 Apr 2025 23:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hqEzR59W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03A529DB90;
	Tue, 15 Apr 2025 23:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744758188; cv=none; b=Uxj2CdNy7OBLBSVbFxGjWFg81pKk0vWoeSxzHa22v1XXqcuwQiSOhC3X2fPnI6DfoJFu7pKNgd3/TytoVVbU0rzTSwVMAi4YxD5PS/2tVqi+amPBWq7S97Qq6K5FFsp0xJl3SzmI2Jd2+srUUiWEu8If+C7Ysj/ktf70w96twEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744758188; c=relaxed/simple;
	bh=JZRovcjiwQ33A3xUCMsFycF3ql2BDyl9qeX4yMmp6bA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iKRSftGgBYL2CMwfWhz9pFK4Ebk0wqaTNX0NzIJfTNoNsd1rFxhbF52wq8ixlzS6g6Sct8YgdBRvVyiO841Y51yFubDQ+t7wVfuqegLa0x5QsgPo3r1mK19PaCHaVVqwGfMcT0/GasJa/8LcvQ9s+Kfx2LFxBU86oL91aB3liAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hqEzR59W; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c54b651310so816908785a.0;
        Tue, 15 Apr 2025 16:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744758186; x=1745362986; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q21DKRIHxJEvdt+r1VLoxzAfD1ZQ4fXtiMyb7UHuaZI=;
        b=hqEzR59W4HhSxePeWOTGxNpwgJPYr/WM4A62sqbNmUn1QQi5g1OHicjbKDu4+i0Pd4
         RbXKvJLmezjtTZFBgvcZBxS27uuzmbIfkwA1iQsbiFJteBc/G1UorqUF5BfImvV7v74I
         vApbt1ha5+Q3GexZp/b+gVWwo9vCm9/QN3h0RqNe6Lp7eqv2gtd1/9B0OgNbE/YLvy5l
         j1LRvjKj51QHZ5r6nfF8GUeu8D37w4jsOj4pl6Ks88Qx29s80a7g17cu5i7BTswtaV7E
         rlw4REa8iIf/Pi1jgwR5JE/+WY72fXW5FJrV+aOS6PCmiZXQVuIjT38qGaWXyIpEUyWa
         Brqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744758186; x=1745362986;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q21DKRIHxJEvdt+r1VLoxzAfD1ZQ4fXtiMyb7UHuaZI=;
        b=mUrwMpiecvYnYgEkm2uyRDqwqCSEeSOrGEhO3LE4icQw0SeVDicrfpgGch5Rq169x+
         IHSTf9UUAWA5H1UGrHRTgiZKkEBA9Uq5C7q4QR0hQkisMxRyodJWlbkyFCCtQHjoSpjV
         ei5yOdhtBi56GdQyAamSqiHzkI+coeBvNGnJ9tu+P61fAU8fBSVurYUfUOMyvddfl1Of
         xY5C2a/KDP7vyUtVJ6DGeMWJjVzX9usEg1PDqNrYDo5v3kirG7BQI6sx7APpB3XYO7EM
         BFCYXocmpkN6hJCEBwqI079O5iM8ZQAwoy1n3SxpkQqJYC/9XnBAlgej2RH0joDMNqAN
         Ywhw==
X-Forwarded-Encrypted: i=1; AJvYcCU3Ijq2ErJCo3hETPn3rVmSttq4vXKMCL9sWYf+ZREC/Mjdb0cUvbVnhJ2nJfkIe0I8g1GIBtVm7NV5egg=@vger.kernel.org, AJvYcCU8GEY4P1jVp0TtmilVzbzJA07UGRo7izGNcCm+/+G9VmYzZbO4RhQVtv90A2Nj9lG4yFHc44b42KwS@vger.kernel.org, AJvYcCUUtGH8qh/J5DM2zPkM67X0tnqowLGkaJJE1zHPlaKmkkZF285hLSsIBUThNYAD7vawuzqR7M0MjInwmj8Zntdr@vger.kernel.org, AJvYcCV9SwtRrS53UjNZvz4WSWrrcYia6tPrPjBoFChGHW1HnVVyc4s8lvZo6uFVtDLPLi9IUdazlPay7L3ShTNw@vger.kernel.org, AJvYcCWPBjMqqu76ifmHVYufb8A8ndS3NAr+kNZmk4sxiQ1dVPW/HLmTHp8PrQBiJdwsjuqdA1oVy2beyCzR@vger.kernel.org, AJvYcCWyfFwA2Hg/NtHFkMIpvcAjfYEfwEEyIFoRvk+cujRPRMxeMe6y/j0mHTjFDLNOHm4ehQ76vLt9FiQ7PjfZG5U=@vger.kernel.org, AJvYcCWzlaNeGQc9TDqP8v2lPZpubzry4eAnn0ibyqxKS1B3vNfU7pul8oe7KZ5SRLQI9vnkcob0ZiY63HDcFFMF@vger.kernel.org, AJvYcCXHcL9ZikTZFzIoWTKhVshXHQ2VXRKOozsEP+CayaxkcG/gB6FM0E5aqW2Hw7nB3PuLXqA4OghN@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe5047ksgl1xC6hXsQqhjwSlnq1oW1P4JaE53yomeaHUQruZVR
	UZj6ytotYT/rQWl6KG6J/sCQMPd53YCEKkZG0JF+9khhAW0VDD1m
X-Gm-Gg: ASbGnctxY7Ie9ks5Lwcuz7daJSGS0eTIzHSyLZbkW2nWYzBcDCPYhG4w2j4MaGXbkRW
	jDT9dOibMajY+SgXTwbON45ex1mYuu5NOrhF9fCyZmC46uoxKrm0ARcXGmTixUnwhZuhqwNDPWL
	jq5qfGchLRmiS3TJ2vfoLHSgPGXrqEbghloO4LYTqplctoIFHLds3jzPb1wCN8zGaNFaXhlNd8U
	SUZQd/U1LrYC31cXzFvaXIKz/Ms/0xFDUacTcc7c7RU8wlJ6+n/DBrWliOyick3qUR+/MI4ZrDW
	8596+y2a3lEo4DCk8HjxxLcNggA+/dz+9w83u/tlpPys+5MvXlWB9w6fFoUy01FzywxcX8MeW7z
	8yvF+bobI4+ThwQoojlL0Rpn5N2LPfQI=
X-Google-Smtp-Source: AGHT+IFD/29vIxMjxOFxQ8BkiE/LEbZtqORNAZrDSp4aJ594XboCIC4xgBiV7FVPqr3EbX3zcQVpqw==
X-Received: by 2002:a05:620a:459f:b0:7c5:4c6d:7fa5 with SMTP id af79cd13be357-7c91428098amr221292185a.48.1744758185614;
        Tue, 15 Apr 2025 16:03:05 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c7a896a708sm969451385a.58.2025.04.15.16.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 16:03:05 -0700 (PDT)
Message-ID: <67fee5a9.050a0220.25fe78.76d2@mx.google.com>
X-Google-Original-Message-ID: <Z_7lpfy3H74dI1Ad@winterfell.>
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id C4F0F1200043;
	Tue, 15 Apr 2025 19:03:03 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 15 Apr 2025 19:03:03 -0400
X-ME-Sender: <xms:p-X-Zz3WUcQHo5SPerJTk_Pdw6EezJuTH-lYjWN5uKuxBZn4sbkqSQ>
    <xme:p-X-ZyEihct8Y5-jYRn-hwKhJNfUEQet1OPd2N-am8r60UUrmWLlmSgr1LcjP_tKs
    b9VG5Lbohie4BDeIg>
X-ME-Received: <xmr:p-X-Zz6GJVAyNj9lTiZEOMLtdkuSmnFOQWBwbEVDi79-oJdfu-HslPmbdD8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdegjeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeehudejhfekieevvddvgeehhfdutdeggfel
    gedugfejhffggeelkeeuffdthfetgeenucffohhmrghinhepihgushdrrghspdhkvghrnh
    gvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvge
    ehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhm
    sehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepgeejpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehtrghmihhrugesghhmrghilhdrtghomhdprhgtphhtthhopehm
    rghsrghhihhrohihsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnrghthhgrnheskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghilhdrtghomhdprhgtphhtthhope
    hgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhopegsjhhorhhnfegpghhhsehp
    rhhothhonhhmrghilhdrtghomhdprhgtphhtthhopegsvghnnhhordhlohhsshhinhesph
    hrohhtohhnrdhmvgdprhgtphhtthhopegrrdhhihhnuggsohhrgheskhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:p-X-Z41IoaAkSc3EBgjWc6FXL709swaRQ4uUE1JmJ7uwRMFyWIM8qw>
    <xmx:p-X-Z2FWGrBqGBVjFOLFXxauA-nSn0cOk80DjxXcxIfFi4pNOTsFBw>
    <xmx:p-X-Z5-JJOXIKKn2Ask5SGKUS8sj6aH_plq-OmVqa5Dc4Y2gCsioRQ>
    <xmx:p-X-ZzkEZZfroB1PnsAsuNes8k_rpPpUslzDA-16Zho9eYd0LiRujQ>
    <xmx:p-X-ZyHPCpMV7Nst1ncTZ1st-JDeh20IBOZOttD2KMdbEi0SFLxqXbnu>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Apr 2025 19:03:02 -0400 (EDT)
Date: Tue, 15 Apr 2025 16:03:01 -0700
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
 <67fea2d6.050a0220.8fa7f.6690@mx.google.com>
 <CAJ-ks9=G1ajyT8gwLHyvHW09Z2gG=Geg7LDS6iyRyqx_wyp5Sg@mail.gmail.com>
 <67fec6c1.0c0a0220.f907e.c6dd@mx.google.com>
 <CAJ-ks9mZ4qqRwQTWyGYgPy9kf3=od=zbvX67ELVgctU0t6qHuQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ-ks9mZ4qqRwQTWyGYgPy9kf3=od=zbvX67ELVgctU0t6qHuQ@mail.gmail.com>

On Tue, Apr 15, 2025 at 04:59:01PM -0400, Tamir Duberstein wrote:
[...]
> > > > > > > diff --git a/rust/kernel/device_id.rs b/rust/kernel/device_id.rs
> > > > > > > index 4063f09d76d9..37cc03d1df4c 100644
> > > > > > > --- a/rust/kernel/device_id.rs
> > > > > > > +++ b/rust/kernel/device_id.rs
> > > > > > > @@ -136,7 +136,8 @@ impl<T: RawDeviceId, U, const N: usize> IdTable<T, U> for IdArray<T, U, N> {
> > > > > > >      fn as_ptr(&self) -> *const T::RawType {
> > > > > > >          // This cannot be `self.ids.as_ptr()`, as the return pointer must have correct provenance
> > > > > > >          // to access the sentinel.
> > > > > > > -        (self as *const Self).cast()
> > > > > > > +        let this: *const Self = self;
> > > > > >
> > > > > > Hmm.. so this lint usually just requires to use a let statement instead
> > > > > > of as expression when casting a reference to a pointer? Not 100%
> > > > > > convinced this results into better code TBH..
> > > > >
> > > > > The rationale is in the lint description and quoted in the commit
> > > > > message: "Using `as` casts may result in silently changing mutability
> > > > > or type.".
> > > > >
> > > >
> > > > Could you show me how you can silently change the mutability or type? A
> > > > simple try like below doesn't compile:
> > > >
> > > >         let x = &42;
> > > >         let ptr = x as *mut i32; // <- error
> > > >         let another_ptr = x as *const i64; // <- error
> > >
> > > I think the point is that the meaning of an `as` cast can change when
> > > the type of `x` changes, which can happen at a distance. The example
> >
> > So my example shows that you can only use `as` to convert a `&T` into a
> > `*const T`, no matter how far it happens, and..
> 
> I don't think you're engaging with the point I'm making here. Suppose
> the type is `&mut T` initially and `as _` is being used to convert it
> to `*mut T`; now if the type of `&mut T` changes to `*const T`, you have
> completely different semantics.
> 

You're right, I had some misunderstanding, the "`_`" part of `as _`
seems to be a red herring, the problematic code snippet you meant can be
shown as (without a `as _`):

	f(x as *mut T); // f() takes a `*mut T`.

where it compiles with `x` being either a `&mut T` or `*const T`, and
`as` has different meanings in these cases.

> >
> > > shown in the clippy docs uses `as _`, which is where you get into real
> > > trouble.
> > >
> >
> > ... no matter whether `as _` is used or not. Of course once you have a
> > `*const T`, using `as` can change it to a different type or mutability,
> > but that's a different problem. Your argument still lacks convincing
> > evidences or examples showing this is a real trouble. For example, if
> > you have a `x` of type `&i32`, and do a `x as _` somewhere, you will
> > have a compiler error once compilers infers a type that is not `*const
> > i32` for `_`. If your argument being it's better do the
> > reference-to-pointer conversion explicitly, then that makes some sense,
> > but I still don't think we need to do it globablly.
> 
> Can you help me understand what it is I need to convince you of? There
> was prior discussion in
> https://lore.kernel.org/all/D8PGG7NTWB6U.3SS3A5LN4XWMN@proton.me/,
> where it was suggested to use this lint.
> 
> I suppose in any discussion of a chance, we should also enumerate the
> costs -- you're taking the position that the status quo is preferable,
> yes? Can you help me understand why?
> 

In this case the status quo is not having the lint, which allows users
to convert a raw pointer from a reference with `as`. What you proposed
in patch is to do the conversion with a stand-alone let statement, and
that IMO doesn't suit all the cases: we are dealing with C code a lot,
that means dealing raw pointers a lot, it's handy and logically tight if
we have an expression that converts a Rust location into a raw pointer.
And forcing let statements every time is not really reasonble because of
this.

Also I didn't get the problematic code the lint can prevent as well
until very recent discussion in this thread.

I would not say the status quo is preferable, more like your changes in
this patch complicate some simple patterns which are reasonable to me.
And it's also weird that we use a lint but don't use its suggestion.

So in short, I'm not against this lint, but if we only use let-statement
resolution, I need to understand why and as you said, we need to
evaluate the cost.

> >
> > > > also from the link document you shared, looks like the suggestion is to
> > > > use core::ptr::from_{ref,mut}(), was this ever considered?
> > >
> > > I considered it, but I thought it was ugly. We don't have a linter to
> > > enforce it, so I'd be surprised if people reached for it.
> > >
> >
> > I think avoiding the extra line of `let` is a win, also I don't get why
> > you feel it's *ugly*: having the extra `let` line is ugly to me ;-)
> 
> I admit it's subjective, so I'm happy to change it. But I've never
> seen that syntax used, and we lack enforcement for either one, so I
> don't find much value in arguing over this.
> 

If the original code use "as" for conversion purposes, I think it's good
to be consistent and using from_ref() or from_mut(): they are just
bullet-proof version of conversions, and having a separate let statement
looks like a distraction to me. If for new code, and the author has a
reason for let statement, then it's fine.

Regards,
Boqun

