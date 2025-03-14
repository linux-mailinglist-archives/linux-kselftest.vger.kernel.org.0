Return-Path: <linux-kselftest+bounces-29104-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 673B1A61F6C
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 22:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D3183A8C2E
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Mar 2025 21:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2763D1C84DB;
	Fri, 14 Mar 2025 21:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ArEqmN43"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED882E339D;
	Fri, 14 Mar 2025 21:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741989251; cv=none; b=Se8OazMi31paHPCDYhkNA6kTU29BdFvweoP82K1p47yxdGC5GBCo9haZXjO+WcoCQFMvJsVAqMMpaUfP4uriPfzaObVifzzrxXHFAu+W7OZNwJByrxB+JdutwXmcAn536tzutHt/a9hRnuueoHSw0P1j87sP8mebEGCmW5kzHO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741989251; c=relaxed/simple;
	bh=3ySRYi/Sd40PDjn4ZkfWBFvzSvh7Zl86cTJFo//IHwA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JQvhemMjuNNV/4HHszs/74GgqY5/hFCP2OZ/DS4cbqwAYsiUIqnV3j7tsj5TWqniTX1n50AxTcgnabgtEViq7x76jfTpXQmxAX4NeA4f721fSODBr1ORsQ/QEROuXxACO+VNeRvyQz8Xa5S3TR8jJwZP/KQFzs/rciY7kBuRJKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ArEqmN43; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6e8fd49b85eso37804316d6.0;
        Fri, 14 Mar 2025 14:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741989248; x=1742594048; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1INgftpU8//6utpwPix0dkvaDMfAovl6O8aDIwybLag=;
        b=ArEqmN43tGER4Npj+iDRhedwn2LZdZkXy+VB1y2M4mi4uN5eunDDU7HpQp7aJidCES
         BwYwm0PiaoihwCVWE+y2eeJfHZjAyY4/Sr++H847Otmp1wBbp74vShqeP5xayksvi4c5
         rZ6bVQP77+QIstpLIhNnXDuLPnYaRdxl1EIRuXtey5XWpY+2/L/jUdDRnQRQM/osBmUM
         Na4mz7Oau9rIWlv1qBmCfekD7f0IfU2qVVQX4yynl3pfNvrRypkLZVYAl2FHbPGRd3i2
         u8tiq2PuU2TMpC0eWUXecI0o09zg7Ch7QC4+MptWGqex6Ku2KRwrUu5BwRJY2i5dN6Xw
         97nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741989248; x=1742594048;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1INgftpU8//6utpwPix0dkvaDMfAovl6O8aDIwybLag=;
        b=e3PE2gcqmGKYoo8GkgXD9O6zoykzKMWEyZhjvZIW5BiXUqsjUiNAjd2aEjhmO2DBie
         7xtQnVwLL8TsRY13rp5/oiehafQ1/ZZ2kXLRv4z8pLRubdRrIRZ20IBlPNwRhk4FtiJT
         6wTGgw+YKWRtzM/kkswsuYLZPlyU/+2wFl+/nz80O60H7Tq92HjustmCNqOG0hsi4hJe
         gjIzNJfpDdykbz8jDVP/4Wyc1evCbqNMASgFQRhnVAozORt3RsrNJgXdHXHVqbkwLfBj
         iJDWKR90EtolQKB7Yim7czXA1EyvB53Q5QDmFgV5dmkumP6JxnPTdA/P5M7z//ol8JKP
         fdaw==
X-Forwarded-Encrypted: i=1; AJvYcCULGs++vtUohPtI7kwH2ErPSUNCZ8ygtIswUdrKZWHFgfdZ8EvSz5o5Z2Rrk+jwzLsanqGnJ3CoYcvx@vger.kernel.org, AJvYcCUrBPRKx8AY5MhB8FhAepMy4m43ix6RARMMQ1CBP3NpTdXktgvOghd6DA4vzC+QirU/cpMe2z0MOlfI+FAGwh5T@vger.kernel.org, AJvYcCW7sir0rMapy+IP+M5onkhLCFP4iV4OYwxdq1bMXYrLManOkPkOyjz7ZJCfrRZXwjgLDenHorPIXIr9soQ=@vger.kernel.org, AJvYcCW8zMXvb5yf4n2dZ66IpozvxQAitvEmh2lHQxw2vs9HNsv38P/jYh6qhEkVivlsYkAeFFBqyFC4O4KJ7WuA@vger.kernel.org, AJvYcCX9s4N4gs4MEBFrkRrNjwIHboHyxHQdNR7VzTHItr0M5ymPwXgi98Ie8ioZQpgOgrqNkt5ST4mitHsf@vger.kernel.org, AJvYcCXIoVJgQ32gKfCRU9eOfQp1e19K6Vuiad9WzR5osbyH4jA4z6oUEegnKP+Y9iPXKizlSeMnbw9k3sZWbKZ0cCE=@vger.kernel.org, AJvYcCXaqDA045IPpAMHhcIqH+MrastMnH3ZqCm7v0s/aFvvzKaZKBNctQR5DO1w84Tf/2AnfBBbkkWfBi09UBws@vger.kernel.org
X-Gm-Message-State: AOJu0YwGA6soMDIHPO1jOAwEnSJTcapEJLiSdvhGGstZcmv3/737sWG3
	LcwuNE5PepH82OIuVP/qHjWfVtKHHfCPDL7w/XojkfYPG3avRdZP
X-Gm-Gg: ASbGncv6EdZhcCElBglpreMx8D6ESkEWTUY3/JJjX4Zcc47A5ptVXWLAgZa+fpov5de
	sA1aAkgfD9dH9I4leSyWTFzOr2eKFKQkkHBf92M2nrEBJ1igB97UGkY880nwkZkFe9OwvLVmsEz
	dnoTF0XWvbJTWMFLCSGUsaLECdtnWCXeMlQ1Yxp/uQm/UsEE9vVoUq+DAb9Sk4i4bmT1zat15OK
	EBNeZxp+aOc87ACkBeLlaFsitmR/kagtyJVvUlSDNXCep9KOr/Y5QHcS2bW9LgxH1Bz6yh6dYF3
	YueucE9TKmYwhIkboYVlK1moKklurZYnrNnBkuntI56JQT461x8coePjqkkz+uwDi/K45UpDBkS
	KYc2DqDh6HiBRPVW9exVR9NSzXVPrgOWgaTg=
X-Google-Smtp-Source: AGHT+IGAwnaAynl9Gr+G/DxD2zI2CDyrYhwDggix83306UsT8eqpNyOhXY+jcoxQkv5jp5vlniAvUA==
X-Received: by 2002:a05:6214:d49:b0:6ea:d388:dc09 with SMTP id 6a1803df08f44-6eaea9e8ad0mr74053736d6.8.1741989248192;
        Fri, 14 Mar 2025 14:54:08 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-476bb6082bfsm27676711cf.8.2025.03.14.14.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 14:54:07 -0700 (PDT)
Message-ID: <67d4a57f.c80a0220.16ff45.9cf1@mx.google.com>
X-Google-Original-Message-ID: <Z9Sle_2_JKZyc9bP@winterfell.>
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfauth.phl.internal (Postfix) with ESMTP id E663D1200043;
	Fri, 14 Mar 2025 17:54:06 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Fri, 14 Mar 2025 17:54:06 -0400
X-ME-Sender: <xms:faXUZ1VnJ9QSQgj9k3EGImC4wqa0NucDyDri1GFd0UbzmDXgZQQXgw>
    <xme:faXUZ1l57_s8u58-vaOZT4ST4OkK_uGkPoKpGdTR4KBV5TsK5goknGk7XdwTkYp4c
    _-rrhSxYhzuQ3B63Q>
X-ME-Received: <xmr:faXUZxb5aG_NV8Upn1KOkcVLuigoymCm6pyliIMdF1evFRoyeOL4-liZ4k0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufeduleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeejiefhtdeuvdegvddtudffgfegfeehgfdt
    iedvveevleevhfekhefftdekieehvdenucffohhmrghinheprhhushhtqdhlrghnghdroh
    hrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegs
    ohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeige
    dqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihig
    mhgvrdhnrghmvgdpnhgspghrtghpthhtohepfedvpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehtrghmihhrugesghhmrghilhdrtghomhdprhgtphhtthhopehmrghsrghh
    ihhrohihsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnrghthhgrnheskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepnhhitgholhgrshesfhhjrghslhgvrdgvuhdprhgtphht
    thhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgidrghgrhi
    hnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhn
    vghtpdhrtghpthhtohepsghjohhrnhefpghghhesphhrohhtohhnmhgrihhlrdgtohhmpd
    hrtghpthhtohepsggvnhhnohdrlhhoshhsihhnsehprhhothhonhdrmhgv
X-ME-Proxy: <xmx:faXUZ4U-p7hGc6MxGQeWJJlJAlyJ9aYzcL92BR0G0So3CK_lq1ZcGw>
    <xmx:faXUZ_ngQBbI-JQZyEYJoDSiWxbQtGVp2tymuIXDQIOaXNE3POgCog>
    <xmx:faXUZ1ccMpiBHxQHiL254VrUOfbubOI-JaQWIss-J-F-Q2fFABOcNw>
    <xmx:faXUZ5HMndfmXQb4aSBdVsIv9H4wPU_zVAUWgBSjbLptklCUswXSBA>
    <xmx:fqXUZ5ksV_AGS7-TQ7iwaQGGJHUVPF0w1hgI4z6JGQ8EiVIffVjLkAf_>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Mar 2025 17:54:05 -0400 (EDT)
Date: Fri, 14 Mar 2025 14:54:03 -0700
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
Subject: Re: [PATCH v3 6/6] rust: use strict provenance APIs
References: <20250314-ptr-as-ptr-v3-0-e7ba61048f4a@gmail.com>
 <20250314-ptr-as-ptr-v3-6-e7ba61048f4a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314-ptr-as-ptr-v3-6-e7ba61048f4a@gmail.com>

On Fri, Mar 14, 2025 at 08:28:10AM -0400, Tamir Duberstein wrote:
[...]
> --- a/rust/kernel/alloc.rs
> +++ b/rust/kernel/alloc.rs
> @@ -217,7 +217,7 @@ unsafe fn free(ptr: NonNull<u8>, layout: Layout) {
>  
>  /// Returns a properly aligned dangling pointer from the given `layout`.
>  pub(crate) fn dangling_from_layout(layout: Layout) -> NonNull<u8> {
> -    let ptr = layout.align() as *mut u8;
> +    let ptr = crate::with_exposed_provenance_mut(layout.align());

Dangling pointers don't have provenance, neither has its provenance been
exposed. I think should use `without_provenance_mut()` here:

	https://doc.rust-lang.org/std/ptr/fn.without_provenance_mut.html

see also the source of core::ptr::dangling().

The rest Rust code changes look good to me. Although I would suggest you
to split this patch into several patches: you can do the conversion from
"as" pattern to provenance API one file by one file, and this make it
easier for people to review. And after the conversions are done, you can
introduce the Makefile changes.

Regards,
Boqun

[...]

