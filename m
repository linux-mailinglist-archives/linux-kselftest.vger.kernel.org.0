Return-Path: <linux-kselftest+bounces-21330-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE699B9B5F
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Nov 2024 01:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2834EB21825
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Nov 2024 00:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA397F6;
	Sat,  2 Nov 2024 00:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQ4GQD4Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD72BA29;
	Sat,  2 Nov 2024 00:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730506103; cv=none; b=CAxoihWw7bTLtVawSLC91MggyrWqRORssNdDzvZKc67poIQtnSb/3o5LUK3XWw9vHiQ6JvcfnZIwd8asjw54FGx8RrLHUK3REsVz83kbo9FRVvMa57qtuTgX6crGktM7NuRUMOY/At5JI+AOBdV2I2NBdndvT5UnTt/ILQ5oca0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730506103; c=relaxed/simple;
	bh=afPAMKZ2DnTwk0azcAYXvdBIeZjZBunotGqGepy6/5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WNphF+TlFCICrJU/s7fe3te2tQMV3gxBZDBGv4GMezowAT/AgNvXHuCT1++8pECru/b0cI8kGmWStM3VeMpon43rRJ8cbUawQDunPnhheh80QBiTicaMfTSDEhVwTG9mN+bWGdigvEnMSi6YtR9HdgIqnVUGCoTKSkk5fY2EvMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bQ4GQD4Y; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6cbd005d0f9so15312626d6.3;
        Fri, 01 Nov 2024 17:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730506100; x=1731110900; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7+GPtCqy3A/lMC5UWG+y4iuiDKVjBBMN8qrfWjcuYE4=;
        b=bQ4GQD4YGmiaDFIfmoNAHngSIa+QVZKlEqtOS+w/PUa6l223GrGIycz+uPiHeN33/i
         HKK4+MG0oJlZDX2GbhQqc+Q7n1QLd15s9JiXMGoMO9C2Rgqz8ExQREX+z5tfV0fqmbgl
         4+yS9H65xxMUNfqli/fWe1shIYo16U47eKnmApwUBrce0qm7wqGyfCfFUR1Wu26lmcx9
         Z2warSYqsvQcUWMmGORwSvCZadcBKHfAvrm0uTsxItVIJqpT/INMyRET/273EiwapvjV
         dIoZODj5WgcoT6fJ1c0pX+Cbnjq6T29kENHgtMd87/6QrvpCivmzDXb6xNU52aQrrs9t
         HUiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730506100; x=1731110900;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7+GPtCqy3A/lMC5UWG+y4iuiDKVjBBMN8qrfWjcuYE4=;
        b=emVThrzA0p+9x+eku8PR3Ce9Ifgp7wMrdvyyT/onWcnq4h5q9XAuY1mS8B+u1HqAgI
         +4QZEu01mKE3I+o2lNtTwteCYVEvc85XIEYJEnzUUu0qok3TFYKcixzOlo18zNJyQrrc
         IruFNUcJ7p3C9+2SXOrd9LBd+uExHWkD5hMvayvYo+uWVWoNRzaXgHvCLrmo0VZhYfUQ
         CgobabevZb46J8nW7GlTJ6LI4peH5P9+9JXdskYv6tUMhIgbPWp5hLktI8zFHvf3bvT5
         KA4qc4z6v7abILXNdaP99mUGJjB8EQ7UZ5sRKeFLnpDoWq4YI8aal3Mc5CJ69fNLNANy
         0f3w==
X-Forwarded-Encrypted: i=1; AJvYcCUWgq/5Qm0jB22v+rhVAWOnc6uCf8OdxMYgAucfk9SQ10gfPxMK26mSdhXcUcRSPBmRWVI/uUFoR4oXUk8=@vger.kernel.org, AJvYcCWOuiLIDqDUzBObyKgLEJ9Oqv/yDZXkobyK/0v952ovjldNB/+0vyHIAoj5U8NLkbkh941hSIYhGk7aN2Y6t4Fr@vger.kernel.org, AJvYcCWZcysoLWb2iy2WWDBN7dPg6UZune6HtkSoL5FNrw7rUU9PVD/+Bei2/iTnwIBu6VPzZqpZDnaluHt28EqbkmU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsULuQcefiNi1IuAm00uBsScOOUOi4BqQUWQHm30GE7I7v0KBz
	OBik+2ixRKNVeQIq58Ws36N0Y6TuQqX99kUnb8pV7gGa5SQz5UPs
X-Google-Smtp-Source: AGHT+IE6JZnStQn0NOX3DROJSBOB+aN/SdJ2BouU8lIbHqrYP+XlzdQDKIvEdLE3XCz67Rhp52o8tg==
X-Received: by 2002:a05:6214:469c:b0:6c3:5b9e:699d with SMTP id 6a1803df08f44-6d35c0a3e8bmr78045856d6.2.1730506100570;
        Fri, 01 Nov 2024 17:08:20 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d353fa5569sm24580696d6.19.2024.11.01.17.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 17:08:20 -0700 (PDT)
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 66E821200066;
	Fri,  1 Nov 2024 20:08:19 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Fri, 01 Nov 2024 20:08:19 -0400
X-ME-Sender: <xms:c20lZ_VprwE7h36tBEoP8jc1d8A31DCTM722ZwGL9tz0eOEfD1PODA>
    <xme:c20lZ3lXtLzSBuswLUPjb-AWShzj5vElN9DHU9fruWGzPxzySs8VYn5SdThxnHWZf
    oC7fprpcSJQXOFW3A>
X-ME-Received: <xmr:c20lZ7ZMTOgmgVOR1hP6-90l6LsamGwfM8OCw0SL6ok58vE3glfutVXxaHk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeltddgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepgeekgeettdelffekfedtveelueeiudevjeeg
    ieekvdegkedufeetfeeiiedvueelnecuffhomhgrihhnpehgihhthhhusgdrtghomhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhn
    odhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejje
    ekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhn
    rghmvgdpnhgspghrtghpthhtohepudejpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopehmihhguhgvlhdrohhjvggurgdrshgrnhguohhnihhssehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepuggrvhhiughgohifsehgohhoghhlvgdrtghomhdprhgtphhtthhopehojh
    gvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhsvgdrvgigphhoshhithho
    keelsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghrvghnuggrnhdrhhhighhgihhnsh
    eslhhinhhugidruggvvhdprhgtphhtthhopehrmhhorghrsehgohhoghhlvgdrtghomhdp
    rhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpthhtohepsggvnhhnohdrlhhoshhs
    ihhnsehprhhothhonhdrmhgv
X-ME-Proxy: <xmx:c20lZ6WZE0bIWwtaqi96WBBcBk1igBBQGgzIdgf81u_T_wWme2oJnA>
    <xmx:c20lZ5ltwmjo-uqJKw3ps7UIIgQc_jxkdyjetQJEttGP6jVZ3w_IXA>
    <xmx:c20lZ3e8MoErmT4U6-v7UBByK60E4RoVsGFT_OymGc89G-EzeOvE2g>
    <xmx:c20lZzG6PvrTZoSjEFbXuLGTmh4fA34K5ccuF0YXC9QTWYClt82VCw>
    <xmx:c20lZ7kZ2hMEhuAEaAn0KcWBafRawM8rGSs2298BaT_yMuLk2Igkf516>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Nov 2024 20:08:18 -0400 (EDT)
Date: Fri, 1 Nov 2024 17:08:17 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: David Gow <davidgow@google.com>, Miguel Ojeda <ojeda@kernel.org>,
	=?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Rae Moar <rmoar@google.com>, Alex Gaynor <alex.gaynor@gmail.com>,
	Gary Guo <gary@garyguo.net>, Benno Lossin <benno.lossin@proton.me>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Matt Gilbride <mattgilbride@google.com>, kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] rust: macros: add macro to easily run KUnit tests
Message-ID: <ZyVtcXTW99YpUF0o@Boquns-Mac-mini.local>
References: <20241101064505.3820737-1-davidgow@google.com>
 <20241101064505.3820737-3-davidgow@google.com>
 <ZyVKSKUq_bKH5jn_@Boquns-Mac-mini.local>
 <CANiq72=yhH7MEQWxVSVXGa5M5=HXudtS0Xja=w7ViU4Ph1Mpdw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72=yhH7MEQWxVSVXGa5M5=HXudtS0Xja=w7ViU4Ph1Mpdw@mail.gmail.com>

On Fri, Nov 01, 2024 at 11:12:06PM +0100, Miguel Ojeda wrote:
> On Fri, Nov 1, 2024 at 10:38 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > but this lint doesn't make sense to me, I would say we just drop this
> > lint?
> 
> I am not sure if it is intended to fire there (i.e. to resolve
> constants), but seems OK since it is not something one would want
> normally to write except in exceptional cases.
> 

Hmm.. so I think clippy won't warn for a normal Rust #[test] function:

	https://github.com/rust-lang/rust-clippy/pull/7811

but since in this patch #[test] is handled by us instead of by "rustc
--test" (I assume this is how Rust std handle #[cfg(test)] and
#[test]?), clippy doesn't know.

> So we could drop it globally, but if it is just this case that we
> expect, then I think it is better to just `#[expect(...)]` it (or
> perhaps use a different example) and then, if we see in the future
> that we have quite a few "trivial" comparisons like this, then we can
> drop it globally.
> 

It seems to me that clippy agrees not triggering this in test code at
least.

Regards,
Boqun

> Cheers,
> Miguel

