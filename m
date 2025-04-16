Return-Path: <linux-kselftest+bounces-30973-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A108A90AA0
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 19:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC86F5A1FF7
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 17:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2403D2192E5;
	Wed, 16 Apr 2025 17:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HztGQ7p2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6FB17A302;
	Wed, 16 Apr 2025 17:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744826335; cv=none; b=usY6Y5mePVLQLahN3Z8U92HsaIy3M7+/nIH0rFBIpZEnfXyf+EaDgHEWHxwPL7oFIZU7SiyWQd/2jO1ESGtIqQ0IJi3nAgD4njXhFIu5omGSsl7i1nrtcmbur0hn1ZRuTPDooow7r2NNzg5nwyhGV4RXNSbmwpb2FnbuH/qom/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744826335; c=relaxed/simple;
	bh=rRCvsVISaYgyOEMdyMHVJ5dpbrk5VpNt9UzpD7TowbY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VVS3EbQpmm8fm1Qxc8w4gMUS+Kmsnj7eCim5gcmg+SWRNIAw5oAXYUf9dRXRGaHjg6zsRckH3TK2gfljharJF8EbEhItiknTBYGdlhn+ZZmK55v+bMTBLZSWbX/X1NdSvNVSUMMnUuVqpDijPOrqffJCKasDmrSH8UAzz/gQ8eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HztGQ7p2; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c55b53a459so743737585a.3;
        Wed, 16 Apr 2025 10:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744826332; x=1745431132; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:feedback-id
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Xw162kgFschDiIV5cGynK2BOAJTwtOVScNTTzDVE1U8=;
        b=HztGQ7p2GsD7D8j12wqZYIXD7CfLEdQ6A2bg0+tMDwuwKPS0QyuFpVjkniei4qD6ur
         8/Z9UuXCCpMq9Guc0Z/KIgRl3ur46kmy5c/WE4BtFAmNd++KwNaWT2kQSs8f+Y/M0mCr
         +U2+wdn+IUpFaphXDCW1Sc+yJD4WG665nFe8m6LV0xGkdInUyIrv3Z4Kcl8BPzFUAhYZ
         bBk/UUld4N4KlEylgiWEMkQ54N047QXGXSz8j+vryixHrHp4/bzMqXzRmC654Sn7zweG
         2hApZXap/+UBgvFR0CQzIuA4G+GWVy8AT1dweTBO2fCQE1iDuKLqtadyYrugfgJpYuYl
         YdXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744826332; x=1745431132;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:feedback-id
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xw162kgFschDiIV5cGynK2BOAJTwtOVScNTTzDVE1U8=;
        b=Jr9VYmX7OqJ/QS4PVkIuIWXRmM72Pcy+YvD0/y0BTP6BFAWbaRiVLXcE4SxL53Jik/
         YKGgonpfsaF9wnHvO7/tr0VGjEa7PH/W6gYyXLGWWcAd5Z4xc/8yZsd3bTwmtEJJ0l2a
         eKZdcKOY/28y7+frUzZ94c8lKM0nX/2AtW7eob9wURDwxviD40e7muRpq3OqziQTqCwk
         WngiQqKOQlisIlm+WN0e/Vsv8c8rlpixdVXMjk4PmjmCmzRARh+YCzACwM2WbTu+x8Mt
         GFR6jbNyoJ4iwIJTcA3zfHy7IRspbpV7M7gjvwMsIx1tUlcB0QT/4/HoXTWNf/XHklLB
         1Elg==
X-Forwarded-Encrypted: i=1; AJvYcCUK/HthZDtU0PMLzESCteKCybmf/u0uxm4G9mvUqatWXgX0KwnF+Pc/RzDZzST0XzNLKabUZsTi@vger.kernel.org, AJvYcCUNwClOhRbJM1a6ASoSx6s7WzohhzFmb4wnoMlVx6vjsDYkAtGDK5ktIbUynGFo8FSH7drE5lI2/um1hFo/Jus=@vger.kernel.org, AJvYcCUhqzikcnEqBqpLOsNjD/QMGWS0iteU91mSutp5kizU1Xa8XbjVq/E3l5WU+AfTFaxLovX8YTetmt32R9A=@vger.kernel.org, AJvYcCV6yvM8oCbg+vAh/+Tf63Qh682qzloWi622EVem5UAuNhsVq4DgySSQQZt5xPRE8be0+K1rmlzrtlH+JqAk@vger.kernel.org, AJvYcCVTUdXNxmvqHePyaLNmHOEoW2Ig3cBJ6CRaOffHjWScutAoDPrIbdaIEcln8cAR86ce+GqihqhQ8KW8f2UG@vger.kernel.org, AJvYcCVrpo8FkXZM0DVo6rSntZuHjsl1Y6Xy9IYiD/S4umPQCpyWH9PAfnkRYqi44YZYrzoFuUc/3IB10Jm3x1JFav/2@vger.kernel.org, AJvYcCW+Yi7BWf6rHVkU5uUU+NKxHE9nX/CdTnpkfDnkNS+4SlwOb2NJRQXYTz8qz63FSRxzNGOAlkZD/5O7@vger.kernel.org, AJvYcCWPhMYXSHK5xCUUIgyonUxM/i7hEvPkwJw6cU1DspZ0p2VZvq03NkeNTARrpARU7EjyyX4Um+1TkFGs@vger.kernel.org
X-Gm-Message-State: AOJu0YxLOaqKJ9l84Gv8oYhTAEr3XVrQGJ5JsQuS3Pa2T/yA3A8r8wkF
	GhyHObIXMxkOSMgMRHpo0OuFJyvYyCBKS0u7WTvyJjAPakOwHN/S
X-Gm-Gg: ASbGncuiYAQfo1qhYxMcH5yghMNcgh5Z/dfhrQWBQ79+8aBLurhIVUlFle2P9N7S1dF
	VnzeE/3t0WvOW1wMtmJZbp5RAx1PmnEK5uU6vRLL+2Iw+klaZAPUk4xnWo6GPoWYmMHx0e9K9k3
	NR4+nEiJPojTOq26bkQbyzOnZbmDVdzxkAgqNf2DjPNvaC2tUlZJ/MYaVHQbhaWFSvntDZPra28
	ryARO9yS6olDc8y2PN6hWttqEXzOzgz3V0Rg+Hfd6LAuIVOIaBgl19zGxIJyNdG/B/QjDfLfkt7
	FPnGTM2iCcr0c0f9R1v3UEcAx0xO+LUxyCe7T0kVP6eBQ0hFcfezThHg16hzQ4dCtk9gal1sT9C
	Jl+evDM+z4ZE+Q3RsxtFMeiYILb3eL9M=
X-Google-Smtp-Source: AGHT+IG2xgMUSPM66Q42gFKXA+8KAt65yWia1nfFwf2fIYwzoFAy7Rqdy1Qgw0W9zJEn9qMHB/aQBQ==
X-Received: by 2002:a05:620a:318f:b0:7c5:a513:1fd2 with SMTP id af79cd13be357-7c918fce4c8mr432709285a.6.1744826332212;
        Wed, 16 Apr 2025 10:58:52 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c7a8a0dc9fsm1083506885a.96.2025.04.16.10.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 10:58:51 -0700 (PDT)
Message-ID: <67ffefdb.e90a0220.61a9e.ae40@mx.google.com>
X-Google-Original-Message-ID: <Z__v2fIvInI7C5po@winterfell.>
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id C82631200043;
	Wed, 16 Apr 2025 13:58:50 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 16 Apr 2025 13:58:50 -0400
X-ME-Sender: <xms:2u__Z-6e9bwRfBqXn5ZV5KAPHX2Erzyf2g9lCPuzWusdcJVI92JRyQ>
    <xme:2u__Z36bvFCsweDpyolBa0bQ1sjrqLNn_EADA-OlYnY0YPOLBn4A_CbOC0Iu_6BkE
    9dYeox8dGIx2g735w>
X-ME-Received: <xmr:2u__Z9fAiWc4vPjhZzUtI2Of0WLaEHNUYVAgVs94XRZGi9JwR07HuAXTOw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdejtdefucetufdoteggodetrf
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
X-ME-Proxy: <xmx:2u__Z7Kx_1V_DGAuo7rklz4-YXbV9iH6ZLmsAEXvUKvN65NZ_gXY_A>
    <xmx:2u__ZyJZ4L9Rw_LxO7hsWD8QSr-EAsu1YlQLSWQ5wRvqPcAvOWsBPQ>
    <xmx:2u__Z8wb2Wq1I1vj43mGXf3hSkxSiNKUMtFUY0H_8DLETvV3GsyL3Q>
    <xmx:2u__Z2KvF4iMjtFKev_1qUqJlGoO2GUd2iZaEbJY2NRkmC-t818okA>
    <xmx:2u__Z5aFsOy6LALo_VQ9BGXCOVtcyZn2dgILL7wK0bjLLbI-qFf-__Ot>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Apr 2025 13:58:50 -0400 (EDT)
Date: Wed, 16 Apr 2025 10:58:49 -0700
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
Subject: Re: [PATCH v9 6/6] rust: enable `clippy::ref_as_ptr` lint
References: <20250416-ptr-as-ptr-v9-0-18ec29b1b1f3@gmail.com>
 <20250416-ptr-as-ptr-v9-6-18ec29b1b1f3@gmail.com>
 <67ffee16.c80a0220.1dbd15.c3ad@mx.google.com>
 <CAJ-ks9n-5Gkp61ODfBbf3==fYp1AbexANLZaQpsGj_mj1WRfkA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ-ks9n-5Gkp61ODfBbf3==fYp1AbexANLZaQpsGj_mj1WRfkA@mail.gmail.com>

On Wed, Apr 16, 2025 at 01:53:34PM -0400, Tamir Duberstein wrote:
> On Wed, Apr 16, 2025 at 1:51 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > On Wed, Apr 16, 2025 at 01:36:10PM -0400, Tamir Duberstein wrote:
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
> > > Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> > > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> >
> > Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> >
> > Thanks!
> 
> Thank you! I updated the earlier patches as well.

Yeah, those look good to me in a quick look, I do plan to take a deep
look and provide Reviewed-bys later.

Regards,
Boqun

