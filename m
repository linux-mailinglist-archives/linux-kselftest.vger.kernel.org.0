Return-Path: <linux-kselftest+bounces-29134-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA73DA62CC4
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Mar 2025 13:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DB2B7A3C63
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Mar 2025 12:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAAF1F582A;
	Sat, 15 Mar 2025 12:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PiIJ/ddM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8829415C140;
	Sat, 15 Mar 2025 12:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742042260; cv=none; b=ma+TJpx26W9xtWVzNOpRrerFoqe3QwMAkYltjuWHswVkPCDjMlLyZX27mHJjxkKdtLV/gNL4n04FkQ6OiSOTx43+1VKXz/ocoYoZDMs+izxM/qxMsX8mJjbv1ZGVJkF/kiqoQABrfO6us4vl+ydWEYuTgfnUsT2BsVMvfY+2UpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742042260; c=relaxed/simple;
	bh=Bb7VlkyygXF5g1VrKqpu3fW/suye61d8Am6Vj8qafU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DLtwkK4ZGd5d5cQP9hhIeFZi9b8Iowl7neoT6e/lR59yfJSuUm+0Y/RXK81Gp1Mq55zJ1yOzmAN7KSe4rzlF4/l0SkzCoO8/fZSqL6zw8MtCHetB2GcT+U0B4QcCxbBVYTEURUVF6RtH2DDY8kqCdUf5+3z8uqzqB2N9u1ZBvtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PiIJ/ddM; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c5568355ffso246228385a.0;
        Sat, 15 Mar 2025 05:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742042257; x=1742647057; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U+DO5FyyiquBQbc33C3jrFW1S4Iqqwx0eL3kzm5tHYQ=;
        b=PiIJ/ddMF1R7xlHSySNt7qx2p9bhQCPi2iUZcIr8gYLjuM4w4XrDNJ3WCaz3bJ7KnT
         5tT/cZ7CHOs8tavTWW/b3nhPUj0ka+OinWIpKGZce1P/wcDqpQWyfG/3kEJgsMruEV3w
         A1Na/oi3VOP3jBSDIRHyt0YJ4KsUe9X36qBXLgI4NMHBpck2rL+bfO+39uPZBoXgf7Sf
         9o8zYUT3xmL+5tpOc0ueZ+zefFBZnkG/oIIbAeEG4FhN3J9MVWCj8NL7TptkVYUnHtqf
         2B4BrCW5AS9JTNveR+ncoBgRD9FUNXzv+HKQdaEGOqQADWLi8tclWJRZzdsjVB1QNTJZ
         lwZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742042257; x=1742647057;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U+DO5FyyiquBQbc33C3jrFW1S4Iqqwx0eL3kzm5tHYQ=;
        b=k3ox4Rp3FvBMCxw1krY5HjGh1wcgd+vVEJAyQjtdyNLHTHOuAi9SWcTWiMBoNdg2dg
         Tminphy+I9WgoowI9bGqZAIL8EsVjV3KqSojVIfL6Bv3JpX76NZGIkSOBmA7Q33VV2BS
         H09e1NaywfXgQx0ALq5gDblRmr8W9kw8QaEV/cp6osgU5BjY3syjYKJoaAM9wQVGLTpx
         cZsd84XTik7ppdtQnoy7iOW4iUYexIMHKjbVshz0z0666x5k92T98W3iwm6G60e9AZ4f
         sIp3kLpWczQUHVbqcTPPtCwK+ZHps8txk/VVxjn9+m5siSmmX172dvyrUnAUeCgvTXfh
         09FA==
X-Forwarded-Encrypted: i=1; AJvYcCU7+FzEV1SUS8KTa8blZT9BdTxdz+/ASzXy5n4yRM36gbSSbWk3OHXa5s38q9W5akCpcW17jJfnazaQ@vger.kernel.org, AJvYcCUJZwDs/8izKuvlJaxewMRRl0JvTCC3mFckS0JxvYbOFSIV4XMhVCDwh9lMNJUv0lHkDqOL+4i/H3ZQ@vger.kernel.org, AJvYcCVAGPhyrxiQQCKG58KoKzDO/6jhrCfYMJsreNBAvuQUrp1SLsTsvw3X//wm2MkYEocES3Vgqsm+oHASNCta@vger.kernel.org, AJvYcCVDaJ5XlvWmi2cdQeugsTWDLFaiqpCkz0YjyWBC7iGr5nW7ccBmMQobz94VGFjf1IJtdJ3EESBsg5l8+I6q@vger.kernel.org, AJvYcCW7O30G4+Q70JIOs+6I0QGqF3XEAdtgGdEir4bapwsU0QC9O4S2KCO7hYN0FSuHpflV1hFq6Hg4S1+92Cg=@vger.kernel.org, AJvYcCX+92GBs3whLvMDelZYFsoqmEhcNRsTgEXTFiq+Ncv1b3CVFF6lajh2HpV1RYn22Va943/6NjNJc2gFcFykEzM=@vger.kernel.org, AJvYcCXuLPGVlzBRpgjnRFGws08f5yb6ufM9JzIkNS2xiJpgATuf0b56hXlhuV2vYwr8gvmYZpQZV9UG9vfpaqG+Q3gq@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt+J1rZKTue8NA0uOMPAuMr9uBjaeJrv1DG8t4snEsaQDutGAE
	pkV9OKdYv0Pc+9VouqLdxZ4Q9Kg95yygACpSELw/c8/sNS8RSqai
X-Gm-Gg: ASbGncsReSlgbpoE8UVPIhQUI7qc6inC4n3L+o0qDUwRzYlB9uc7LL7hTa7Sum3/8Gq
	o2TsT+Qqky4B/MyvcscO532ey9j8LPFTM8m9NInGWm6minzJ1Umv4VSxmBZvBhNls121m2xtQlM
	WGbc12w64Srw6Zdx952kxWN9jBYW8nZMn9Nq2Q+yhZIEoBiauyTJxulo3FbcQnEr9kkp64ld8we
	JQX8E3ILbu861RnSzT+v2gGD51nEkuYRrs7mwwgBf+koGe4mk5Qxsqc0p4HqUoLQYYJ+yxXh29F
	wgLeOdNJvLDik6fke56gi/VGZv6RDEGuoQaQH8OtpCSbOU2Ggr7DXoasfjMmmxr3WnwG3Tvpyx9
	tmbMYDppgRzoXRYYhfmgE+I+CWhc7VP/tFhA=
X-Google-Smtp-Source: AGHT+IG3v7rqL2pG7zBwxsd3NLlJGEM4ZDuPlTK/XaWjcUCUQDNunf+02Mx6bi3VMaiA8usKyoGqPw==
X-Received: by 2002:a05:620a:244b:b0:7c3:bc90:a46b with SMTP id af79cd13be357-7c57c79be78mr764336985a.1.1742042257352;
        Sat, 15 Mar 2025 05:37:37 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573d6fbbasm375120585a.78.2025.03.15.05.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 05:37:36 -0700 (PDT)
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id DC6261200043;
	Sat, 15 Mar 2025 08:37:35 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Sat, 15 Mar 2025 08:37:35 -0400
X-ME-Sender: <xms:j3TVZ54l6Sf8ZjFUyVHH-_wd-24d3OpMr1Abcy3Prk9ta33JxGygxQ>
    <xme:j3TVZ24Ur2-lgaQOoXaIFV6G1ggunHB7PU9u0N6_5gVG7O9Rm8RNG_cvKgJABLK-i
    k1OPTRGCdcN6Au-ZA>
X-ME-Received: <xmr:j3TVZwffrgoEJ0FPDuhLOpiYz9tnKDtemEQjkmTsxaDTnnFrKsEWoSW2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufeefjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeehudfgudffffetuedtvdehueevledvhfel
    leeivedtgeeuhfegueevieduffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgr
    lhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppe
    hgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepfedvpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopegsvghnnhhordhlohhsshhinhesphhroh
    htohhnrdhmvgdprhgtphhtthhopehtrghmihhrugesghhmrghilhdrtghomhdprhgtphht
    thhopehmrghsrghhihhrohihsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnrghthh
    grnheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhhitgholhgrshesfhhjrghslhgv
    rdgvuhdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    grlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgrrhihsehg
    rghrhihguhhordhnvghtpdhrtghpthhtohepsghjohhrnhefpghghhesphhrohhtohhnmh
    grihhlrdgtohhm
X-ME-Proxy: <xmx:j3TVZyKsLJqPlqSasbng3TMa4e4CZCSX4vL0uZQGzLgExXADcoXEvg>
    <xmx:j3TVZ9KaRy8odCH6NYLOS9mQkFCMP2a05peE66IKgN2pGNXb3nKV5A>
    <xmx:j3TVZ7wzFM37plEyWwf0I3IxQ3E1f1k222GwNcS0mO2cdoLeXKj5Aw>
    <xmx:j3TVZ5KAAqSrRWKiyc0kc6rrhpF7GwPyYdZRbOc-SwYUkvTqlfQQ3g>
    <xmx:j3TVZwa33D_Pg4eF7BsMDOqrnXDpHZ_IzRj2S3VFFwcuS-8VQw-j4xbP>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 15 Mar 2025 08:37:35 -0400 (EDT)
Date: Sat, 15 Mar 2025 05:37:33 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Tamir Duberstein <tamird@gmail.com>,
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
Message-ID: <Z9V0jSfuhqWi_t52@Mac.home>
References: <20250314-ptr-as-ptr-v3-0-e7ba61048f4a@gmail.com>
 <20250314-ptr-as-ptr-v3-6-e7ba61048f4a@gmail.com>
 <67d4a57f.c80a0220.16ff45.9cf1@mx.google.com>
 <D8GQJQFGKB8C.DZBUZT4IJIM0@proton.me>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D8GQJQFGKB8C.DZBUZT4IJIM0@proton.me>

On Sat, Mar 15, 2025 at 09:34:42AM +0000, Benno Lossin wrote:
[...]
> > The rest Rust code changes look good to me. Although I would suggest you
> > to split this patch into several patches: you can do the conversion from
> > "as" pattern to provenance API one file by one file, and this make it
> > easier for people to review. And after the conversions are done, you can
> > introduce the Makefile changes.
> 
> I think it's fine to do several of the `as` conversions in a single

Well, "fine" != "recommended", right? ;-) If the patch was split,
reviewers would be able to give Reviewed-by to individual patches that
looks fine trivially. Then it's easier to make progress every iteration,
and also allows partially applying the changes. Of course it doesn't
have to be file-by-file.

Regards,
Boqun

> patch, but splitting off the makefile changes is a good idea.
> 
> ---
> Cheers,
> Benno
> 

