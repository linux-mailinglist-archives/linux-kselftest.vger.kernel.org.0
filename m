Return-Path: <linux-kselftest+bounces-29578-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C457A6C0DB
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Mar 2025 18:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A05373B38AA
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Mar 2025 17:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F351822D7AD;
	Fri, 21 Mar 2025 17:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMubXPWP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A0222D7A8;
	Fri, 21 Mar 2025 17:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742576768; cv=none; b=d755aRS4Z6Khtb0eqFh46znYcgbg4MRNUDrGJpFDdemlVN5R6bxyijSgR4CumGikWyy7G+VYWCPLB95GOO73aMd4DROnFN3B+V80+/44NqnOyY2GL2VVppNvGd4U9JEVXKxEGMuSaRcN69o5n1eiQWVYJsDeCHEYFn74W8PMr30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742576768; c=relaxed/simple;
	bh=mgV8k0Oxx3F+ikXn6ERzJAL9d56hgfJtFn8PHNDCI18=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CJSV/Kup8RHMgrDFnU5JdeROfGw7r9X7xxZs63NuFTuhR/gkO/1n/TYkvDv3gCGryLtaA45YhP79eq7wejRRTC7fmayhWA07CQYHkCEBcrb7j8lrJX8kH6Auq/Maz2FedEmE2HS2ht54fIIE24S/Gft4jXACdGY0drv9b0zDEPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GMubXPWP; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-476b4c9faa2so28046611cf.3;
        Fri, 21 Mar 2025 10:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742576766; x=1743181566; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XhKCMtiZR/R9YQr/fdgBU9b7n0aYMUGFJYVmb0eprj0=;
        b=GMubXPWPd+UXuQ6Sow202JLWnWGaM33xtEAjmkHNIrnzckZmCQVrS1Qx3BepRN40/g
         PrN9i0RDn6koI9I4+rrNkXDGVwiZzuUSgl4krEzisQRe/GPUdpYJcABbjNAYCYWVPG7r
         J/uE3c2W+SRBo79sBcWJqP6+/DzGqo50lPOwlwZvdWEnojbVNaEZc6krNVfDTIuRJ+pE
         Goiz4AGwBybdWZOO14XU1J2u4FPHFVeu0FCFmWvQvvFV8GBKC9oQkSWMJOgEJof4BVyS
         I3E2P2uD0KQQO/6B7IzcXlEZOR8AaabfCsDeFMD5VGdWchm1U8S/OMUkgVRvEYjWpZBn
         rf8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742576766; x=1743181566;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XhKCMtiZR/R9YQr/fdgBU9b7n0aYMUGFJYVmb0eprj0=;
        b=GixKOBNAoqDn/7fkcJkx+PeGoU5IqbIuRtasCBiuGZ+R5/9a4turrCGMAzLnV0GYLP
         K+jRfaIf1jSsXUmf3GUSa+qxelW5FbLj3mgghW6evZy795mUvttxyu5JU/9QZpC8Bjhz
         KWPV+1kzGdWETfFxJSszHyzDG8Q9spYIXJl4ByKYeDHTC3u0pLl6z6W4LyZAF1oo2pAc
         Ko39icNP15DiEgK7oTaUL1ojP1K9FXv/seAu+qmiYMQDs4/bbued8ZNI461MtOb7Zw5s
         NuHdClQC/As9RJatORDuvO2aFTwN8nkc+x8F3fSRTOeTwowCB6MA8YH2Aa5hJh1VPWRx
         STGw==
X-Forwarded-Encrypted: i=1; AJvYcCUf1g2qXm+68HkMMleqrMCRjeXbZFUPxAHPjxawtRzBVbI8+TRQM5vSzaOyL/jbUmq2mvMVg5sOajILG55SIkcG@vger.kernel.org, AJvYcCUfDH9/xj43srWyRH4dOX1C8HpavY1DRAb2nDQks3XCWldUWQaM2KauVwFNqKq6AGUs+/CHuJ1gliXkQPP75zo=@vger.kernel.org, AJvYcCWj45vo8lg0wO0SLoRj79svE79a6DMweiv9BWXbxxg2PwH3pTnJgwlA9r/MFj6nd8Ho+mFBq2wJuUvZojI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ1l2f6bIeiQJ+eMeLs12o6nXc6ExwP5j0xkd75pUanoHEodFW
	nW0QqBhT2jo3WLnRE75BSnrjnDKkOPchA7U84ClscMnfWx9Fm2Fr
X-Gm-Gg: ASbGnctcMaaRuf6mVV+wQyLS80j0/PGgOIh1jbvwH2NrmglMox7rZoaBOOarslVjS8r
	CUVI47GpnVjZgGsm3kgSy9kkrtBMFskniNK/uljFrvrFkXGCfcTqTGBn39OFGTuxvcMKN2PDBxf
	JHeaoIqYIaMHEV9sBmFAGmGMu0qAjoNR9gNZhXIq8LD0Qp7qq4P8+wjERGSOtzmUnDSz5QjQYAr
	GIyogACg8OxNQ47S2MNEysrFOn8st8Zgf12/4JpVYKa94P0bLsE0pNSvel8/EsHcGs1OeppD522
	CwB24wgo5W4IzwdGt/UFEI9qDXwlNjQOxog6yZOc6ahwfqi6YX6vvWU7wBzz+y3X9bjgq/76VqH
	sdcaq+mNHqli8AAUh4XitsL14Fhc6qDmQguzCj2CzAaHD6w==
X-Google-Smtp-Source: AGHT+IHhDO9InTfc3De5cXRHCoGEGMvmN+7jjA6LSkYHPHWPJo3b//y+lD9Yw8s70RUiYyd0YXquGg==
X-Received: by 2002:a05:622a:5807:b0:476:8f21:926f with SMTP id d75a77b69052e-4771ddf06cbmr60829701cf.40.1742576766087;
        Fri, 21 Mar 2025 10:06:06 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4771d177582sm14123781cf.22.2025.03.21.10.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 10:06:05 -0700 (PDT)
Message-ID: <67dd9c7d.c80a0220.2d0437.7969@mx.google.com>
X-Google-Original-Message-ID: <Z92ce1lNu41-5cy5@winterfell.>
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id F3C041200043;
	Fri, 21 Mar 2025 13:06:04 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 21 Mar 2025 13:06:05 -0400
X-ME-Sender: <xms:fJzdZ-7YidEFxkjQuNYzPEbWW5AKmrIDbC-YBfVOoEkRGIsCVH4-kA>
    <xme:fJzdZ35N9bf1LutZeqGJbPDrGE0BnjjyTirQqU9Kjll3uQovHi-el8lu23Daj0R-7
    th0PnBkCPpYdn7UXw>
X-ME-Received: <xmr:fJzdZ9eKmWKFXpJvDRh47OBF26b5PuwzFoMH3iFEZ2YcFNrXnknWS_CBHRw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduheduieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeehudfgudffffetuedtvdehueevledvhfel
    leeivedtgeeuhfegueevieduffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgr
    lhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppe
    hgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepvddtpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopegurghvihgughhofiesghhoohhglhgvrd
    gtohhmpdhrtghpthhtohepmhhighhuvghlrdhojhgvuggrrdhsrghnughonhhishesghhm
    rghilhdrtghomhdprhgtphhtthhopegtohhnthgrtghtsegshihtvgdqfhhorhhgvgdrih
    hopdhrtghpthhtohepsghrvghnuggrnhdrhhhighhgihhnsheslhhinhhugidruggvvhdp
    rhgtphhtthhopehrmhhorghrsehgohhoghhlvgdrtghomhdprhgtphhtthhopehojhgvug
    grsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpth
    htohepsghjohhrnhefpghghhesphhrohhtohhnmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:fJzdZ7KzNKOteFVdO2sKusRXg5EJ5WUQodtQTIpfy_uRsa62zG-hdA>
    <xmx:fJzdZyIzPhfsDpWHIi9WBteGDOEH0mFNVwCPiPJBSznegIKnW1veTg>
    <xmx:fJzdZ8ztqud3IHe7i-bo1iO9SwWgaPxzM4VGpg3vbwtGeRY3-u-uYg>
    <xmx:fJzdZ2IZGsiOwI2cMndQ59XdZqtjI4zOCIalW4WmZOtbiuhzjcX06A>
    <xmx:fJzdZ5an8xBYK5c6-1FYyna4M4MLOgzHj5U4XMy7l03lNlvb1oC-LNRv>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Mar 2025 13:06:04 -0400 (EDT)
Date: Fri, 21 Mar 2025 10:06:03 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: David Gow <davidgow@google.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Antonio Hickey <contact@byte-forge.io>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Rae Moar <rmoar@google.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Antonio Hickey <contact@antoniohickey.com>,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 08/16] rust: kunit: refactor to use `&raw [const|mut]`
References: <20250316061429.817126-1-contact@antoniohickey.com>
 <20250316061429.817126-9-contact@antoniohickey.com>
 <CABVgOSkKD2Z60_+MoP_nu3YCUocvxJaohMBZpXy=_aavUZ99XA@mail.gmail.com>
 <CANiq72=jXTpoPAHhFC=T2SCyz3195=pG5h+-yohCCxdds-2hHg@mail.gmail.com>
 <CABVgOSmhMP4F74GuwRG3bWyumgF19WxmC=ymbehuWVD==OxdnQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABVgOSmhMP4F74GuwRG3bWyumgF19WxmC=ymbehuWVD==OxdnQ@mail.gmail.com>

On Fri, Mar 21, 2025 at 10:28:06AM +0800, David Gow wrote:
[...]
> > Anyway, KUnit `#[test]`s are in -- I was not planning to merge this
> > now anyway, it should be reviewed a bit more.
> 

I agree this whole series should wait a bit, but do we want to merge
patch #1 as early as possible (maybe right after v6.15-rc1), so that new
code can switch to &raw since that's the direction anyway?

Regards,
Boqun

> Excellent! I'll make sure to review the new version of the patch when
> it's rebased.
> 
> Cheers,
> -- David



