Return-Path: <linux-kselftest+bounces-29135-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEA3A62CD3
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Mar 2025 13:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67966189ACB8
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Mar 2025 12:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D841F9428;
	Sat, 15 Mar 2025 12:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YnedmYYF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1BE2E3377;
	Sat, 15 Mar 2025 12:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742042537; cv=none; b=fjWfU7RfszOnkPlz2u+zPNd4b6u6TyT7fuFxMYuzmYDtz/612gpW2FF/fMeLFqZzHd9dPTDHQYWtnfO5g0nYpato49YsjDEEpFfQA1wL5+7JYRQJ3hIWyoeIgmCUpSoBD10AcFMDJpqYpsdglKoQOYHcRY60Cy5BleReod3DwrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742042537; c=relaxed/simple;
	bh=dDcpZjeQNvc0Go0f7qgQr5lRQWwZORh8BOgsleq+U7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o+gjEq30jxgmOe0R9ePEkjKKt8VxRNlNQcONdiiHoWKa5EVOgoRcA2DiX9zZtH+ZQotolpL1VgML24ipBgWHI91Im1KIgZcB7N/WIEru7y4+GVaaxLy9wHI7SBVZGHG1k2cHeBczO9z+LF7SOp2O4cwhNOgyOBLHUqIIh3Or/zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YnedmYYF; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c089b2e239so302052785a.0;
        Sat, 15 Mar 2025 05:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742042534; x=1742647334; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0+igFpMRZEpU3dhBps8/AZlxbaD0E4MZa9MJ4sRcUyk=;
        b=YnedmYYFpYNUNWBd8SspA78eIglfHC45qv/+3Qm12WaGzTH7BSiJ6BqFeDX9XjgIIp
         sBGsj8/pA7h+wKn0KSIGDr76mhsLG60tcPwNmQ3U0Sw0zX8t0PHUWpwx+UgoI2DfZNar
         mKxiGn3nVs2OXrSEsvCiUlVSR4paYnP3gapCdygI3ch6riijq4lKkPTF53+ZvquebVRs
         NeAQs64KuUe7GUCkqvrM91jL8dxQRfu2CF/4gqaPgPkXaUggQ512Jst5m58W0r7ehyT1
         0JNiSBt+V7MWLiehIYVwkECdnBVjQJDioZXHh+FaaF08SyTGg3QRCN2zLVf7HtNMYjwj
         f6Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742042534; x=1742647334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0+igFpMRZEpU3dhBps8/AZlxbaD0E4MZa9MJ4sRcUyk=;
        b=aPoyxSwGj7SNQVjWYv6PJLYSyky4xJiuLnUMctVXuxfQzYFBFZL7WaTxnMK2RCoiOC
         sBCpmejZShpNt4HeoAt8uWsQo5WzJuMNxzw/f4jxKFKviWxlmiS4ygwCgWJ24cP3dvtl
         3T628aKzaolaDZNnr6JCSNIjZxhHak1+pNJa3htCMbxRkwnKfzxU07O8IipKQpP+5hWQ
         uNA0+9DZ8zIyemL2tz5HoPN0i8/LzzcpLHpi/VMNTAk3Bc8xBNm0qT40djK0/dx9zt5g
         VuFUTBi6zAjDWQEk698iufy2CxmshiyGcW7n1uyCyIpWdg5Ci0ylth2xVQHFcIWGopYl
         SLQw==
X-Forwarded-Encrypted: i=1; AJvYcCU6g0Dwf7kgoMbDMMceBMpZcawLg7HEr11NqZ2ZdSpOdvnbdszC9QgEK3ey6tCNcAHSAZUCQWrZ@vger.kernel.org, AJvYcCU9qx+MOYMJD+ohrs9g4Qg2zUJJZqb7CwE6l8rQNYNgDVNWUyzJEnXlFsBlGLCmmKKK3rqWZyepmvTJ9g==@vger.kernel.org, AJvYcCVNoWTgyF0WjwGNEjsAd64OxwqIo9GLB/lhG6OQQ+/OpC5a51WcEytNCGAOii+xMh9zXs+tH0tR+McQYEOBP1g=@vger.kernel.org, AJvYcCVwvOZ1xoW1/t9+dG1aWoRKi8y60osLXLzgfvsRebPACO3PHPCQppQeO0vD89wxmmFvKiFvEx5ODA32@vger.kernel.org, AJvYcCWh8jMLD1K0noncSGajmxzVny7AYifKdO9TSrCmSk9FGTgY6V9Z2Mw+H4f2W4kEckEJyRZ2wAxJRsUMBy9G@vger.kernel.org, AJvYcCWjMtj4uAprBcWZF64kFvGokYQmuCJoCWmhQB5zBkpP/p/leXNkuCa7nS6t+Sg8DPK85N8+DV0HeJs1grN+/qIA@vger.kernel.org
X-Gm-Message-State: AOJu0YxaD1ZdegSO3gZcgXzFDwV3BEUNeM41TaRIY/RiuF/TjhTP637u
	yGWssBbRBlzAvQRCZk0tH/X/XsGRHeJNo8ss9Z732zC7oHfz9eS0
X-Gm-Gg: ASbGncvS/bYopJLoq+Jvag4WHYBeVCHZxrKOGwD6mno8mKwLM3ekGE1pa9HYGVL7c3D
	/I7lkjw1hzZgGJRvRMKNH1RJ3ezDFczUQ/8I6iQujTgWjEFSkbF+62k9TvDrayBZ64ZidBg/IOh
	fRqf3A4nc2GrPLQ4BfE7/Kuvzf47PKYShtKj2lb0cORPgwAjI8kw0qfuUZH28UBzbKKGCoFGQKQ
	HpV07+H2Yjc5LLApETekzJLlk0g6K7pqyMbLJIDeGF/FNTfuHqCD9Z4JLZKnbJDhQQo1yuyNeD3
	g5rxQtqwUDYWRqysmRAI3CUruIW/gQqt5IptunIdcUNnYsVd8UwfpPkLRq2JGhWvMmad765nQqO
	AERvbJxrVf7rEGumjRBjasnv3KklpmAlolec=
X-Google-Smtp-Source: AGHT+IEiS/3Riq8VC5l6FYXGqylATidBB/dGhOisYY6pW4fx+4sAp4/L1gyxIgsZ335RIZtW33pvRg==
X-Received: by 2002:a05:620a:269c:b0:7c3:dd2d:c0e2 with SMTP id af79cd13be357-7c573791c1emr1659939985a.13.1742042534087;
        Sat, 15 Mar 2025 05:42:14 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573c4f731sm374989785a.13.2025.03.15.05.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 05:42:13 -0700 (PDT)
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id 0514B1200043;
	Sat, 15 Mar 2025 08:42:13 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Sat, 15 Mar 2025 08:42:13 -0400
X-ME-Sender: <xms:pHXVZyDAtv46f8eGgKM7GGd7wUR8wkuaRNvp0pPxR6yJpRqKRLTsCQ>
    <xme:pHXVZ8ip4smcHIchb_lcq-Ca9slFXa1buIgjWMWItdkV7ta4vdFzZDGvkLiKrhpAo
    R2jCl_aa8riixpfZw>
X-ME-Received: <xmr:pHXVZ1lSzIUfANbl5SS8IDOZAwjEYIjz_0y-pKvhU8U8XtEX5MhGNvQJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufeefjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeehudfgudffffetuedtvdehueevledvhfel
    leeivedtgeeuhfegueevieduffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgr
    lhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppe
    hgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepvdehpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopegsvghnnhhordhlohhsshhinhesphhroh
    htohhnrdhmvgdprhgtphhtthhopegtohhnthgrtghtsegrnhhtohhnihhohhhitghkvgih
    rdgtohhmpdhrtghpthhtoheprgdrhhhinhgusghorhhgsehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgidr
    ghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgrrhihsehgrghrhihguh
    hordhnvghtpdhrtghpthhtohepsghjohhrnhefpghghhesphhrohhtohhnmhgrihhlrdgt
    ohhmpdhrtghpthhtoheprghlihgtvghrhihhlhesghhoohhglhgvrdgtohhmpdhrtghpth
    htohepthhmghhrohhsshesuhhmihgthhdrvgguuh
X-ME-Proxy: <xmx:pHXVZwxy6ua6UJ3EmHXdlXqVV764rGMq7GEj3Y26VNM5D-KS6a1qVQ>
    <xmx:pHXVZ3Qbnbv2OALiF6u86jmFBVpOaSx1hgeT9tCwjkTVOPKAlWRbxA>
    <xmx:pHXVZ7aEZXAE3wk7vUbnlqD-02iAxd4Ht0YascDbK1ot8mJSBsQjiQ>
    <xmx:pHXVZwSX2q4Ri155a0-nR6NneVSutF68movkfWZ4zk98mvXTmiqM7w>
    <xmx:pHXVZ5CxII8VD2kBTRcSzbjX2OeND1Oj5jLQKSetiGkOmcIOjIBXdFYD>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 15 Mar 2025 08:42:12 -0400 (EDT)
Date: Sat, 15 Mar 2025 05:42:11 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Antonio Hickey <contact@antoniohickey.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-block@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	netdev@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 2/3] rust: replace `addr_of[_mut]!` with `&raw [mut]`
Message-ID: <Z9V1o0LQrNWdiWK4@Mac.home>
References: <20250314234148.599196-1-contact@antoniohickey.com>
 <0100019597092d67-0da59c6d-9680-413f-bbce-109ef95724cc-000000@email.amazonses.com>
 <67d4c889.050a0220.35d7ce.b4b0@mx.google.com>
 <D8GQTTOG3YEA.L56HVS2ZWZMK@proton.me>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D8GQTTOG3YEA.L56HVS2ZWZMK@proton.me>

On Sat, Mar 15, 2025 at 09:47:51AM +0000, Benno Lossin wrote:
> On Sat Mar 15, 2025 at 1:23 AM CET, Boqun Feng wrote:
> > On Fri, Mar 14, 2025 at 11:41:55PM +0000, Antonio Hickey wrote:
> > [...]
> >> @@ -541,7 +541,7 @@ macro_rules! stack_try_pin_init {
> >>  ///
> >>  /// ```rust
> >>  /// # use kernel::{macros::{Zeroable, pin_data}, pin_init};
> >> -/// # use core::{ptr::addr_of_mut, marker::PhantomPinned};
> >> +/// # use core::marker::PhantomPinned;
> >>  /// #[pin_data]
> >>  /// #[derive(Zeroable)]
> >>  /// struct Buf {
> >> @@ -554,7 +554,7 @@ macro_rules! stack_try_pin_init {
> >>  /// pin_init!(&this in Buf {
> >>  ///     buf: [0; 64],
> >>  ///     // SAFETY: TODO.
> >> -///     ptr: unsafe { addr_of_mut!((*this.as_ptr()).buf).cast() },
> >> +///     ptr: unsafe { &raw mut (*this.as_ptr()).buf.cast() },
> >
> > This should be:
> >
> >
> > ///     ptr: unsafe { &raw mut ((*this.as_ptr()).buf).cast() },
> >
> > , right?
> 
> I'd say it has to be `ptr: unsafe { (&raw mut ((*this.as_ptr()).buf)).cast() }
> 

Right, I missed a pair of parenthesis ;-) Thanks!

Regards,
Boqun

> ---
> Cheers,
> Benno
> 

