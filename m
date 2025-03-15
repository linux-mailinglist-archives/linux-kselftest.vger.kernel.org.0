Return-Path: <linux-kselftest+bounces-29137-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABFDA62D14
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Mar 2025 13:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 781BD18943C3
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Mar 2025 12:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E331F9A9C;
	Sat, 15 Mar 2025 12:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2D/3uEs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB301E7C20;
	Sat, 15 Mar 2025 12:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742043575; cv=none; b=fBqAybqY0Ek+yyZZ2U3qJc3EtUP0ZVurEZeLOAxuXZKNpadfxUkzvLy+pNA4NWUNEM1Dq1+pjPMIn9UoVugxVgs0Y9i5Gafidlyo+2jh2wE6bvxgT9gWAVx3WCKPx8HXNZcQ5qs5/WQ2wWDuLWm/2m6wVRae51xquvIaWmer2MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742043575; c=relaxed/simple;
	bh=Ecv+iNkGFfi9tUIlY/rwyQCIyEj65xXadpmlroL1C4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bgslsZelC7xjRSMYG6hvosC2QlvDZhjGWZLpS1xlKrwRALJQrLgG7BqeYGe9xndYcc5OdpKUeaNhOALpTeKLjrrW6e8Z3sGWHHJWPPsCwpF4SMH5JHTEV7Aiy8r5cPyfd+/T51VA18tWxHmtFCEwVEu5SHun09lW3f14xopzZgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D2D/3uEs; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c3c4ff7d31so378266485a.1;
        Sat, 15 Mar 2025 05:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742043573; x=1742648373; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3sz3C7TI4DPvSlkchso2NNuBOnisGdY3eDfJJKlUEcw=;
        b=D2D/3uEsHIf3XX5YuMp9i/yQyYhQ/7r4gpEp/Qk1f5dNkWC1DNsWpc66U2TOwKkQO4
         BwtMJt9nWmvkrpPsUZdhhJr6lchNFfE4K4ce7XX/oarvMISVYAPJWzlTEWlBW0vuoSjF
         BipqvF5Uy+GPZf8iKlLsRopBSnAa1SzzD2nxAkVyZ02isCQdv3S4AOCtjcGdKytYFm4a
         4rO4ZoXotO3gwO8LmC6bnacDTdw5tVUs7ZtM2iiNv3iqT9jYVg5HRAcxg3QC8tiqP3zZ
         meoPBQynHP/QIhL9VXrCDaGgR6Ebzm8JO8gFsS/eTQm/25ib8GX1NYOrQXR81Yfxvwrf
         Lwnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742043573; x=1742648373;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3sz3C7TI4DPvSlkchso2NNuBOnisGdY3eDfJJKlUEcw=;
        b=EpbNAPOluy9HL2U1L+L5oZc9fzxO07ot5kCH10ES8RHzkcTFWYj6XPfscRm7dipVC/
         dAq6F+JMLEVH+OmiTRa+S8YBDDyi7O+MoM7EV/XrVJwagVSW5T7awOb83oetbbKkZ4aL
         q8KX4MvtfIUNx7fc1til/EmZYBjZY5k6NRVYZvDRQ8qq/XyNLX/7bcJrUMnnKRwzIN2k
         p9GBSfvvHtABfE+wQFWLo/dn7yDkl1Yw/kTIiG3cG4dVck7NuuMqngCqc4xQF0N5fEyp
         plN4+tlS/WhZYUBju0txF2vHi7o2aDeD0xclqsXNWziHgXhE1xr2Nn+I6rBl7FxAf2IV
         zFrg==
X-Forwarded-Encrypted: i=1; AJvYcCU9maMFDC46Y5ToPXIlKFCpDTwrjDMsjk3p3dtJuYOzOV0xi4+c7pUddubHS+SmeKX7bRGrZXvqU6AW6mLy@vger.kernel.org, AJvYcCUHpLd+kfoZyB20niGchOlOc74fYQ/xjcy+qx12Nta4xKEQwA3b6VPE7ToRAFPvyrLFD524kjuwll87sJ0ayr8=@vger.kernel.org, AJvYcCVD9g56bCXpTnYQegweqjsJ7fJs3NTKQaPAzrsXylMvE3xcBTcUVTXGhWbjXLRj5E/HKZZWF/LtZLIK@vger.kernel.org, AJvYcCVtH0ohIjCK3XWyw7lMSp1/fimD+hTqNXnvi0MgK4Q0vLCWacrCDFIQ0IcGufZdDoPWZH4gWy2yuH38@vger.kernel.org, AJvYcCWW/zpJd/WnPTkYOUG4+x6EDLTazEczdk1JH19q07CHM5xGNSrZVEKY8sNuPoyOOeAfvyWIlEFzOCeVIJFq@vger.kernel.org, AJvYcCWgF/YWCVUIpi2J6YJZYlzW365jnh8O7Bj3p9vgfUYKBYJAFhpCFD21/HDhlTXALnHTG5uDDsrBXM4gaWD2UCwl@vger.kernel.org, AJvYcCXcYmgAOOCLt8ijHsHZvASFTlehXRl9U3KuRvK8oNHPat1WWmyD2qFCuGw3k/XDmYD5DpHZYj6nsAjp45o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQUYf4m+cXK8Gdg5B1KCDlJBG09EuRSi8It1vY68vLrxjmBysN
	I6IpTlaAvw0FP09nswqMQ1GenxTzfe+n4byYF/b7Fk7QlSUHvUUz
X-Gm-Gg: ASbGncvpg/Qo25CiiC3E2apKAZSPXy40Ci1q6/sLWtacaSA1AOMlYQqdmgLqcAiTepr
	0ixp8CYlu1ukYKE+4nSoYWSpFu07yoaXhPatMrWIL4sEeTdwvHaGApGP05JZB16Omqw17w4FvxM
	pGw8DG3tOaMZcTi88wZi3WGBYsLSB5QJIhQslPu9Qm+q+4j82+EBDch5uaVZtICra1hxVpNmOoT
	A8fzToRIWm53dhkVIb47VP/eZnS2iS6PUoOtEVMSdmPoDCbEDhYhFrTHcLBpM20w+lvBYXmRV9z
	+VMJBrmi4P5F/lfyCFXUKktm01eGN1jmRM2Jwp59fpaoAA1mqiCkiRpZ1TcNN1acDBa+xfVEJDa
	OLIEYaaaZLA8LQk75C8zx1j1RavSbgGtf/jM=
X-Google-Smtp-Source: AGHT+IEpbbxMYi7EBT1EpTmd88snq+U0V3yFRIPptelZUz7jiwwoiDRCLnSaptxPR29bV7X4h0Mpwg==
X-Received: by 2002:a05:620a:444d:b0:7c5:58b0:42c1 with SMTP id af79cd13be357-7c57c810e96mr650223585a.34.1742043572800;
        Sat, 15 Mar 2025 05:59:32 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573c9ddacsm374895885a.54.2025.03.15.05.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 05:59:32 -0700 (PDT)
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id A10EC120007C;
	Sat, 15 Mar 2025 08:59:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Sat, 15 Mar 2025 08:59:31 -0400
X-ME-Sender: <xms:s3nVZ8TdeqsmhV7UVIaGrrgzTLRzzVaVHK404GklawqDuqmLzeWN_g>
    <xme:s3nVZ5ygNBeWaTrB25Kh6mbqtrGaDWmNhx9EW6GezrBDHJUHfQJdttYPggPyelQ0e
    S_DHs85hIZIZkE64Q>
X-ME-Received: <xmr:s3nVZ53i5Hi3M9gJghxNbkTSCqGS3BQTkAJLssJdEL0mDX_fr46ponHE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufeefjeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrg
    hilhdrtghomheqnecuggftrfgrthhtvghrnhepvefghfeuveekudetgfevudeuudejfeel
    tdfhgfehgeekkeeigfdukefhgfegleefnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhn
    rghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpe
    epghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopeefvddp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthgrmhhirhgusehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepsggvnhhnohdrlhhoshhsihhnsehprhhothhonhdrmhgvpdhrtghp
    thhtohepmhgrshgrhhhirhhohieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgrth
    hhrghnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnihgtohhlrghssehfjhgrshhl
    vgdrvghupdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eprghlvgigrdhgrgihnhhorhesghhmrghilhdrtghomhdprhgtphhtthhopehgrghrhies
    ghgrrhihghhuohdrnhgvthdprhgtphhtthhopegsjhhorhhnfegpghhhsehprhhothhonh
    hmrghilhdrtghomh
X-ME-Proxy: <xmx:s3nVZwD3rHARBzffMwEo8y5Gj0UgqGvgIWncmE4VxNcjL1f7aKoavw>
    <xmx:s3nVZ1jv0k-EA8DcHnDKPwNvS4HCVAvWdleIUGgEgTRphYprSMukYg>
    <xmx:s3nVZ8qU3_V62dVihs6JImUnjbPjbz7RDz0qCLJDX8zlCOiBOnyYzw>
    <xmx:s3nVZ4hntVgpm3x2UQaRwfixWs2bfmTblOP8Fqrs1jVnmDrzvoF_vA>
    <xmx:s3nVZ8QRUioK8FjOwuLJwK7CW6U3LykcFm8XcERBRFGe79knaO8nrmOw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 15 Mar 2025 08:59:31 -0400 (EDT)
Date: Sat, 15 Mar 2025 05:59:30 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Benno Lossin <benno.lossin@proton.me>,
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
Subject: Re: [PATCH v3 6/6] rust: use strict provenance APIs
Message-ID: <Z9V5srg9h73ufu3G@Mac.home>
References: <20250314-ptr-as-ptr-v3-0-e7ba61048f4a@gmail.com>
 <20250314-ptr-as-ptr-v3-6-e7ba61048f4a@gmail.com>
 <67d4a57f.c80a0220.16ff45.9cf1@mx.google.com>
 <D8GQJQFGKB8C.DZBUZT4IJIM0@proton.me>
 <Z9V0jSfuhqWi_t52@Mac.home>
 <CAJ-ks9k+5c-MYNaxv412Ri1LDAxvkdSQQfKEgQtTu6aEsS-XFA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ-ks9k+5c-MYNaxv412Ri1LDAxvkdSQQfKEgQtTu6aEsS-XFA@mail.gmail.com>

On Sat, Mar 15, 2025 at 08:41:49AM -0400, Tamir Duberstein wrote:
> On Sat, Mar 15, 2025 at 8:37 AM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > On Sat, Mar 15, 2025 at 09:34:42AM +0000, Benno Lossin wrote:
> > [...]
> > > > The rest Rust code changes look good to me. Although I would suggest you
> > > > to split this patch into several patches: you can do the conversion from
> > > > "as" pattern to provenance API one file by one file, and this make it
> > > > easier for people to review. And after the conversions are done, you can
> > > > introduce the Makefile changes.
> > >
> > > I think it's fine to do several of the `as` conversions in a single
> >
> > Well, "fine" != "recommended", right? ;-) If the patch was split,
> > reviewers would be able to give Reviewed-by to individual patches that
> > looks fine trivially. Then it's easier to make progress every iteration,
> > and also allows partially applying the changes. Of course it doesn't
> > have to be file-by-file.
> 
> I sent v4 a little while ago, hopefully the resulting complexity is
> manageable now that the build system is untouched.
> 

I have fun plans today (skiing!), so won't be able to take another
detailed look. What I was trying to say is that: should you split the
patches, I would have already given some Reviewed-bys ;-) But as Benno
said, it's fine, so don't worry, I will take another look later. Thanks!

Regards,
Boqun

> Cheers.
> 
> Tamir

