Return-Path: <linux-kselftest+bounces-30915-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3724A8ABDF
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 01:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22D84190256C
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 23:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4022D86B5;
	Tue, 15 Apr 2025 23:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M67aAWP0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB4A274FF2;
	Tue, 15 Apr 2025 23:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744758688; cv=none; b=oPllU1EbGTPKyNeDjFmOXwGeXNv5v++FwtXXPKwBW1/d4aPhiN6zsivQ3K+ePtnl74EESo2pJNtyT8jI3lFN9JEA9VKKa9QEX938nvJR4Q4CHnHnCraUsZPdfoERJGemNGyKDeAeqjkjUTT3gK75o2MDBqmo1VPoVw7sFYBbgl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744758688; c=relaxed/simple;
	bh=Lk6bLD/uUB1GQOvxBGV+GT88MUe5nWXud/y2daU5ocY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wz1M7ZycJ6xwwiEE6JBB9m04zSVWvjVh3nUzeRL8LN8vt3neBpH4BqG4uYUMgGC1V0cENHaE9pH9bL40/DCgsXgo/aysE0NXzPK3OFYUDqvkn6o+g8+Qn5s3b/SUjij8WDs9LqCJpwsPcgQTh0gfaSsoTHXuIFrzKU+1ujjFfxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M67aAWP0; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6eaf1b6ce9aso66404506d6.2;
        Tue, 15 Apr 2025 16:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744758686; x=1745363486; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dKLRk0brjDNifaxxsd7Y9Fb9L/syicRgQ50i2EOVxk4=;
        b=M67aAWP0RVV1VueoJ0kDQL7W0vKdEZEwxZwaphlkuL6e5MFLbVdPHyAyTD5TDuaBmO
         RVIZjMGI7/RPvsMewc1N/SiWsp2LZBadblSp/nNpPB0r3AS0xHApyLQy7dg7EOmcc48B
         4bp3QzWwr+LQ+kHwJN+FtsfIY1Bx6+K2a/CExsrF6xvU7kQNpcLwBjZILw0xjeh1lrvj
         HZOzqI7y9RlH8xh/JAu5qyM6ZX6SIbadjzKalbaReYVPC7d9iOBhzdCP3qOVeo4yOi4+
         vLNUzCGfR1ZrjDy58e0jx6UafsQJ3t7yTur4ZPoBkQrTxj2YAsPZJYoLpDuxRB6gDDLj
         UJTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744758686; x=1745363486;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dKLRk0brjDNifaxxsd7Y9Fb9L/syicRgQ50i2EOVxk4=;
        b=Gf7E0WboPv7f5lC2T9e1Cz5aSthUpVyHgNEY22lGKLXFatDdPLHklbvJBiUV86POlD
         FqVL4K63BdLs6CRuv8teNNn5+I2jeDVXiYCUCXQDB2n9Pjp7wBy2CKPv8JbEMF8cIXKU
         G/q1787EKfZXz/kiZ2MyHxUcpuQxBzJz5SKVKMjnBbJIr3wGbB9PDbHfX94uUqfQfdNA
         Pndu2xcJKa/1hjqc4yK/3iufi8paAdTYuPTM/owJfrGZt4NRSuJbQBIQ8swUgLwTrmw2
         dp2eki/UGLKdH+oC3I2jMPcw0EIfgGRxn5lbgTQj+HGWMKqVjxFuxGDE6pay54nOidqH
         8YkQ==
X-Forwarded-Encrypted: i=1; AJvYcCURRgCIH08o1KVdP3AG42SI2jaKMJosz0s2FPQac8maqEECWwoWmuzqQ7FBdJoruknzMfukVuabPADHbiGo@vger.kernel.org, AJvYcCUY+ybpAlM4j8hDKnklIddh2O5ZdLfb3lvLmLJIyClYutfaJFdi3jnMJndSuLNMpONzf/wr0mhUv5GY+q0=@vger.kernel.org, AJvYcCUrF7XFPrAwHAVdrSjz0XwrGjXYTTRT8gQodjjjs2RikmxIEzKorZAsspUyL7wikGA5jDT+Lapqd6E8@vger.kernel.org, AJvYcCUrbtbvTze3FXtPZqIFvvrE9dqGJuXiKifc+5hBfTlmPS66JUCAKzJ7u5v5Thie434o221sxWW+@vger.kernel.org, AJvYcCUyMGhDuFg6abdhX3vr2Ou5ejdLo38d0qJ5zjuwyE4CPnGKA5hNY7PAx7NkbtxURlG2nIQe42qBWWKH3VbUYTMw@vger.kernel.org, AJvYcCVL0ljXERnLru5lFcLgnr6tW0nnWAan4VyASGGvHgiVBDlh4W4Ol8I3Ib60Gqb8dQdUXPt3jba6u6sP@vger.kernel.org, AJvYcCWxQ5LMPqcCh1LHJ96sJqvcV9oF9am2j6KqJGVE2sEGJdMmqaEmUi+zZcsdW1ej49md+7WtSE4nY/oNm3Xpyfw=@vger.kernel.org, AJvYcCXMpIFoogFs9Hx0hoZ+BmXC1d7vxsVQNw8VRjZswTHh28n0xe56/A0kkHdHpZfcW9qRPTQ9DGViFf0x7h7Q@vger.kernel.org
X-Gm-Message-State: AOJu0YzY95ZiylPxt8SzLVpz74QHDctT1ZYcidjNZC61POmjualviacs
	ghqJqM31kKX4aSDJPWsW0wgbEn8JZQGQ6nngQVCCfxyrOin19pAE
X-Gm-Gg: ASbGncsYhUQnCboRlPMN5cRMdg7Cj8p5tRjfny1IwpDUpBDGiO28yETmJ8uXEHhNX06
	JtIeWswZhc9Dm1J3nWFToqLZnoj0ErvZ+ddVcG8rw+bXzpZdBZkYud2N+75AVaUmtOVHyUAeenj
	YMnF8BVBCROFiKNkfdBBwThvsW3W+L/zD0gi2N5EcOZJ1A4qeYGK0GGdMhWkJwb3M1l7JWODdDC
	LKYzrHbtutGiqHhvwHZ4idB2eA/57qtlDmNaslnBGrxzLtuA5Uiwr++pmvys90WEFu6EUWz59FO
	EwUkaK5RBjd7BNp6JkUyJVXSut412JzXFrUuQviwONNUtLk3//gesOJC8d9/v/aNh89+6qCWNlt
	BTTkPcPf/yrCDiD7LB3e1PBBj+k+ccyE=
X-Google-Smtp-Source: AGHT+IFETheEP+xJhRNM1qZxIYPDxwWrcrPYC6B9CbiGQ1KKBk3+QdK0VZBgDiYVn1tco1xRTl5+1w==
X-Received: by 2002:a05:6214:1307:b0:6d8:99cf:d2db with SMTP id 6a1803df08f44-6f2ad9cbc1cmr23831046d6.38.1744758685601;
        Tue, 15 Apr 2025 16:11:25 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f0de95fa03sm107097036d6.8.2025.04.15.16.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 16:11:25 -0700 (PDT)
Message-ID: <67fee79d.050a0220.3c9498.bc23@mx.google.com>
X-Google-Original-Message-ID: <Z_7nmZxgQgdnm4JB@winterfell.>
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 20E271200043;
	Tue, 15 Apr 2025 19:11:24 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 15 Apr 2025 19:11:24 -0400
X-ME-Sender: <xms:nOf-Z6UDAdpnclVKCUfuXlUT7xZJhQHxa1dnwUsoRcSjQm30zBXuLQ>
    <xme:nOf-Z2nnxnX-_Ij-A7N0FCBF0eDRrWbwJvHn6GJuP-MZZEESZzNh9r3ewFNyYeGF6
    afBMgSeaPMenyMolA>
X-ME-Received: <xmr:nOf-Z-Y1xTO27wuhgzWJC5Si6Bp5mYdfOvvM417aDr9nRd13erD5_2O7RSA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdegjeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeehudfgudffffetuedtvdehueevledvhfel
    leeivedtgeeuhfegueevieduffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgr
    lhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppe
    hgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepgeejpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehtrghmihhrugesghhmrghilhdrtghomh
    dprhgtphhtthhopehmrghsrghhihhrohihsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehnrghthhgrnheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhjvggurgeskhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhopegsjh
    horhhnfegpghhhsehprhhothhonhhmrghilhdrtghomhdprhgtphhtthhopegsvghnnhho
    rdhlohhsshhinhesphhrohhtohhnrdhmvgdprhgtphhtthhopegrrdhhihhnuggsohhrgh
    eskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:nOf-ZxUDUKJJw3gmIqhuJ5y6d3EH6fSycZ8K1NDgJuuF1VT5kOWrpg>
    <xmx:nOf-Z0nydUhHJhu79epg3_0X0HbvWM9t8YjqixNvAj3x-HizuhdPyw>
    <xmx:nOf-Z2dbGPx55Mdho92Hf4sfcnBm9fbUszd7OJKLAiOGRx0BRb3SuQ>
    <xmx:nOf-Z2EGD0AdYD-E8v6eUS3p430M-l-WUTowU7PEhhm39z8EOjBi5w>
    <xmx:nOf-ZymqPc77udtVs7tC7u-E90mY3EYFJ-5O06XqK_nFkZnpDiCheWSX>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Apr 2025 19:11:23 -0400 (EDT)
Date: Tue, 15 Apr 2025 16:11:21 -0700
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
 <67fee5a9.050a0220.25fe78.76d2@mx.google.com>
 <CAJ-ks9ni3iVY-PwUVdhxah325ovU5CWw=gfR+dhfPLGwDra8pQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ-ks9ni3iVY-PwUVdhxah325ovU5CWw=gfR+dhfPLGwDra8pQ@mail.gmail.com>

On Tue, Apr 15, 2025 at 07:08:42PM -0400, Tamir Duberstein wrote:
[...]
> > > >
> > > > > > also from the link document you shared, looks like the suggestion is to
> > > > > > use core::ptr::from_{ref,mut}(), was this ever considered?
> > > > >
> > > > > I considered it, but I thought it was ugly. We don't have a linter to
> > > > > enforce it, so I'd be surprised if people reached for it.
> > > > >
> > > >
> > > > I think avoiding the extra line of `let` is a win, also I don't get why
> > > > you feel it's *ugly*: having the extra `let` line is ugly to me ;-)
> > >
> > > I admit it's subjective, so I'm happy to change it. But I've never
> > > seen that syntax used, and we lack enforcement for either one, so I
> > > don't find much value in arguing over this.
> > >
> >
> > If the original code use "as" for conversion purposes, I think it's good
> > to be consistent and using from_ref() or from_mut(): they are just
> > bullet-proof version of conversions, and having a separate let statement
> > looks like a distraction to me. If for new code, and the author has a
> > reason for let statement, then it's fine.
> 
> Fine by me. I'll change the let statements to those methods on the next spin.
> 

Thanks! There are a few instances in the early patches as well,
appreciate it if you can change them as well.

Regards,
Boqun

> Thanks for your feedback.
> Tamir

