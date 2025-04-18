Return-Path: <linux-kselftest+bounces-31152-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 200A6A93B5B
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 18:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E8A67B0868
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 16:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F58B217651;
	Fri, 18 Apr 2025 16:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SX1xB9Zg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D923C1A8F68;
	Fri, 18 Apr 2025 16:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744995182; cv=none; b=WMR5Z0vDXkdXT4PsGxBnsyEcM88uO6xI8W85tMoaTaWtyI2Inlt4bMaUFjukAmiidM/qa3JrBIwstx0P1mVB/q8AsEMF8A0NYakZRDpxj4n7vIQ3JY2HciFfPuoyPqGFnksAg6y4GVWUg92LASSLqFgQp7FOds5i5L4vcpKak34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744995182; c=relaxed/simple;
	bh=7ha/e0G3a8sbA2/WeW5mYHCAMwN/zvWodNX479770bE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IsWbx9Khtw1Ubl3XGvs78GejPKy39imAofCMC6kYXfLpvZflWB9lHfHJyaMYQSDhB+HNxhleqrXYdCM2iWlll8QUCBR0jToqB3xa9V/9ShC+Vp8gvD5IKfiECwjW/o6f5lhLPfpzvzHi/vo+RrOQQqP3goK7c2DfgOXN61moGSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SX1xB9Zg; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c55500cf80so157236785a.1;
        Fri, 18 Apr 2025 09:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744995180; x=1745599980; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oNw7DSuc1b1b/tQR7WjbohbZojv201rKGbihKbhU4NY=;
        b=SX1xB9Zg1c7fBqMNIaOqtkStfZQXqminhiSbd8+gPLQOdreNQm/6hGN8Bir3pBTPaO
         Df0id00b8kfDrUbQeWMSxiFepSlr2qzMZPAkxm8i6AMscwmZBc62mt2ejm2/Xjb1eTvd
         nHX2eRPpNYsswNCtIW8ul1X/O/MV6htBQSjH+yP/68thKQ9wiSNgjZIdmdvVLyfhmGqG
         15TmIDo/wA7O43gsLgJ4SSMylo4lSckg0AP+3dICmCqaNN0OH1WG7cexx3uXy6I/+eqn
         t5L/O0oKzpg6Dcy0CaalqB5VC4WySmqTtadnSxKTzs/uzO0nrIxwSqfyPs6gI+NiivFz
         mXfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744995180; x=1745599980;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oNw7DSuc1b1b/tQR7WjbohbZojv201rKGbihKbhU4NY=;
        b=ReJEnXgdVrTcTL5tTwissCpo187GG4K6TqJOo5KIqrkzMfZVA7FWeScus7UzEsZQYE
         E3yb0ADiHad0B0skLi7++PTmbaFcudDJb2HUEkS8Yx7Hyr9V1aSJfp4zLfElAFMYMt6d
         RiTlw2BrNLjdhaC1bZkK9JHxrg3deMgWFIARKCiX0Hl3ePrSHL5q/tKObQzFj8LtB+MU
         1dCvomiQFHH0gQmwgAmgdVTEgrBIQPr4aZYiTyai8uLA3jJwxPhpA8QomuTc/lbSBeay
         tbl9ngq8d4Mth/RQj+1q1uU48cQIUXCN3ODBgShpDMbcVAlzEdr8nivOSmOOeXc9UjOV
         kh3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUlRA1Zxx63EeynA7uH7DsGWoU4BgCYoq+Q6og2dGzytS0g6nGYBRMq7fZzLZIVldDOLUdZ99npDp5p@vger.kernel.org, AJvYcCV3JlAhnpFRy0mBTU9kWagkpcYUToZrqpg5vTT9f7TeuuRXlWVLkJknM4Yg+nHOG8Y7L2NvUQK9+A1nv6uspDk=@vger.kernel.org, AJvYcCV9bj4MFi+Y5Mqihwc4S+KZ2OUB/AjT6/3THTtTckdimxKtjai9+grbIwl5l7MNFDMMTmvj04Uk@vger.kernel.org, AJvYcCWG7UCnxjcauMajlA5UYSZlaLhn9R8nabyScAIuvip/LrJV0SrjPYufPlZLyJkk7hlSumzr8tK9i5IeQrt4u5HD@vger.kernel.org, AJvYcCX2xp7QMzYw/7KE46c+y4oxRDriD6Gzqf5T+taJaVq5NggsgSKUmibpvS8xcPWmREaxMT7N4Q/W3j1eX22k@vger.kernel.org, AJvYcCX5SgGWVIijXnyz9KrfY3XtMZpbRz9doW/eoSo2PN/09BDuD2vCDH271uw/eVEJKNbybRWvGKbkKn0a@vger.kernel.org, AJvYcCXApVKTssWHDs+agRT7drR3Zef+qK+OFsakDXXpJ1ZbEMGfDXeTzS/66avBDUSToLxt1/LLwfG1fMeFcTWW@vger.kernel.org, AJvYcCXJ9Dt8R/Df48q9AIDUHH+G+iDjA5ur6VCAoyvsk6n85FdX18dRNe9Kh7EMtlk1pTctkACqc63JtWSdRJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU42sHoI+XxNmH9sxxOuPBe0GC51D7bhXMoppGN0GZK8U1vIQF
	YGRWa1stm84CeXNEne4WwHVJ/598p8Iu+D918XlV8HYbKqt8wloD
X-Gm-Gg: ASbGncuqcxThAsGXM5Xoo+4Nk4oqcFq7mVrS6aXpEhy9sRsC8sK+N6Ac+8ZvhWTMC4M
	ZvgOZXbK/8X9qaoly7s2RTsZyEvTYFUwvUPyJIoNQl06KEI6BnT88ltPjeD+H//pcjUGFb3uL4C
	1bVlS+kOkczBe8CmV9wT6VExBJp9GK0a7KWIhiMtD/NR4hY1/9kufJ2d5rV2pwQiYkh9yFA50Jm
	si9EkD4hBMehkV7VRFD4tX5qDk9ljpVfewMMxtXuZneexnqgmjSZxSAMN4APHS/3d+mZXBAShoQ
	v2R8c9uhTxO8Wu/0LN5MdAM0o4rz91aVWwhZl/kPo4cN5LUrVD0FQhiqU5j+pHv7jGVU9GHRJUZ
	sexl0Zfd38b6PShuoG6Ik1QYyzZrTVYg=
X-Google-Smtp-Source: AGHT+IEb3fceJw+dZWVtEoGjTerF7JyoRkbAClnyB6MVaGC4XY7lcq4tKGDfYC7mQk5UEncSaslEvw==
X-Received: by 2002:a05:620a:3902:b0:7c7:766d:9b00 with SMTP id af79cd13be357-7c928038e23mr627309985a.36.1744995179616;
        Fri, 18 Apr 2025 09:52:59 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c925ac2f27sm124748885a.54.2025.04.18.09.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 09:52:59 -0700 (PDT)
Message-ID: <6802836b.050a0220.8ee39.6127@mx.google.com>
X-Google-Original-Message-ID: <aAKDZ5kSMjxy9QnW@winterfell.>
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfauth.phl.internal (Postfix) with ESMTP id 186311200043;
	Fri, 18 Apr 2025 12:52:58 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Fri, 18 Apr 2025 12:52:58 -0400
X-ME-Sender: <xms:aYMCaGiBRtaR8iknc_xskLJOB8VTs9S1W9JyC1JU5TD15hae7tojww>
    <xme:aYMCaHClHlgvfEQkHBvmPT2XfNzxJ7wQjwiOGyoT5xa_fr2CiCyhLN2A9Sq8HQb6V
    A0NEQ-pZuPxMzSkXg>
X-ME-Received: <xmr:aYMCaOFoT6jyQnGwjLer67uY_MehMXt3Kbe1St3HwspL8N-0cmqDyy0S7euXPg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfedvieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnegoufhushhpvggtthffohhmrghinhculdegledmnecujfgu
    rhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcuhf
    gvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtthgv
    rhhnpeekjefgudefhfeigffghfdtheeggfdtuddvkeejleffheeufeffteetvefgfeeuje
    enucffohhmrghinhepghhithhhuhgsrdhiohenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrsh
    honhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghn
    gheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepge
    ejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtrghmihhrugesghhmrghilhdr
    tghomhdprhgtphhtthhopehmrghsrghhihhrohihsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehnrghthhgrnheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhjvggurges
    khgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghilh
    drtghomhdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthho
    pegsjhhorhhnfegpghhhsehprhhothhonhhmrghilhdrtghomhdprhgtphhtthhopegsvg
    hnnhhordhlohhsshhinhesphhrohhtohhnrdhmvgdprhgtphhtthhopegrrdhhihhnuggs
    ohhrgheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:aYMCaPQ5WRQi4ezG9Qk-AFmdDJ__dW_PwpYgl2ZGnixoi8EAPax18A>
    <xmx:aoMCaDypQhXfoYJdrJ0ZnhgWHOI7v4f6mVFK3ihH5qz7ixHDOWvp3Q>
    <xmx:aoMCaN6SpH1uY9ZEyhvuonCLQxvKZcFOF3PzFrbkvJY_DtPrWwpkWQ>
    <xmx:aoMCaAyOS7aoe6ja6OTwTIyHlmPV5JvenWFRBpp2TkM5RdSUgjVhCA>
    <xmx:aoMCaPgPi-PlrwmNI9mBfcB5Aez3ipK3r0ILVf4aeJraWrdbLNrGh0KC>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Apr 2025 12:52:57 -0400 (EDT)
Date: Fri, 18 Apr 2025 09:52:55 -0700
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
Subject: Re: [PATCH v10 4/6] rust: enable `clippy::as_underscore` lint
References: <20250418-ptr-as-ptr-v10-0-3d63d27907aa@gmail.com>
 <20250418-ptr-as-ptr-v10-4-3d63d27907aa@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250418-ptr-as-ptr-v10-4-3d63d27907aa@gmail.com>

On Fri, Apr 18, 2025 at 11:37:20AM -0400, Tamir Duberstein wrote:
> In Rust 1.63.0, Clippy introduced the `as_underscore` lint [1]:
> 
> > The conversion might include lossy conversion or a dangerous cast that
> > might go undetected due to the type being inferred.
> >
> > The lint is allowed by default as using `_` is less wordy than always
> > specifying the type.
> 
> Always specifying the type is especially helpful in function call
> contexts where the inferred type may change at a distance. Specifying
> the type also allows Clippy to spot more cases of `useless_conversion`.
> 
> The primary downside is the need to specify the type in trivial getters.
> There are 4 such functions: 3 have become slightly less ergonomic, 1 was
> revealed to be a `useless_conversion`.
> 
> While this doesn't eliminate unchecked `as` conversions, it makes such
> conversions easier to scrutinize.  It also has the slight benefit of
> removing a degree of freedom on which to bikeshed. Thus apply the
> changes and enable the lint -- no functional change intended.
> 
> Link: https://rust-lang.github.io/rust-clippy/master/index.html#as_underscore [1]
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
[...]

