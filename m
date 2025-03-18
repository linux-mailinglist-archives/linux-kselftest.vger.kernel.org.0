Return-Path: <linux-kselftest+bounces-29285-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F0EA6637C
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 01:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78B49189CCEE
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 00:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC0E46B5;
	Tue, 18 Mar 2025 00:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="POQJI1ob"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A976186A;
	Tue, 18 Mar 2025 00:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742256867; cv=none; b=dlDOzhMRz+tdEBG4W44VicUJuiOQrj0k9Y1M8HKen6fvo1oycQxt5bi1GT2QzAu+znDHprnFsReVIWuN1XnwBcA2fRSc16mZwIyGaTCXp+QLWKO/yxkSzs4bUiC0a98GEMDXCI9M2VW5DGPiu3XNmp2eSHDqCtRSGko3cF0/QqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742256867; c=relaxed/simple;
	bh=iO8WX/FSxwiklj+aF7RVmk26VKYC3ZV3V0SFmiuFANA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kclVhjdRWOCJV5DdHiTBx5IPWp73J2FhONK7grKZt9D8iiaOCsk4WG9Ca2yeef9Ln3e5BVONTAzDMA9TgCv+veBkdjYWqiwiJcV8QYOVQiuALOr6mRiNUtQ4je9yfJpsGiA+OMhLlNhWW+OCv8g9eWA5MG1ZUjuAZ6aLtuQvUqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=POQJI1ob; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c08f9d0ef3so277245585a.2;
        Mon, 17 Mar 2025 17:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742256865; x=1742861665; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gv25mNqKe3qIfo4gLEO0bdztwqjwHhJyCBTIzLng/ww=;
        b=POQJI1ob4CrPbVebT2cnPdKBxbWxfk9GcyB1aYQDBqFJWvuytk033xbftooMpUdsA/
         wf4y1wS8nfdI68lbHtkvSf1Fk4VVij/mhEhapui5LMjmwV2YknEWJ2XewrgEyPC6rP2P
         Rktm9qU8H10hb9dMYMzuak9MEHmHL6jvtbbMEY/gZgnUg4h2XZCSeJL7fyNRxlnBaR+X
         GA0upmGlHGEAUcw5mQiDQ8dSC07e+vwkldzF+/twuTqlvhyfVNjdkPRKuWx9hM9NAfOe
         Wydz1XuVN4thmpoZvshOZbUYArLyi3w6tOiuj07Rk8TpTEk+q5Ua6hIXfdFhhb8pf4Ll
         tzQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742256865; x=1742861665;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gv25mNqKe3qIfo4gLEO0bdztwqjwHhJyCBTIzLng/ww=;
        b=UoL5bm6sNTscua77/gQAaiuqzxNk+C/xfeRqzBV4MydpVzSZqFcamcB9EJP7wJOqzD
         Erc9fCJTZnS+2xPNrAX2GA9h16juHX9vABCFIkzh/ZECB5lhtN4/t0pS4nXShw6feUsV
         xk2SOcJBM5wfZ/qDGzxDb1M3x79mrdVIMQfItq71fFfu2Rle+pc+PV1Ykm1hDZXfKNhN
         RNnMh5Acse2yPYNhxD/ZaZPQdtUFdPsVb4HeGR7a6hxfOHgEsqLlZplMgOjzPFtPRqls
         ciU2vRnADBuPVkNkJtjvYqk/Xjgl5ic2tAd4L6qdJ5FjNieUMjLZSozeyRF2lMwC1UY0
         0gKw==
X-Forwarded-Encrypted: i=1; AJvYcCUlTnEElq36UG1FYxKh2I7BZFpHul8h4m+EQi5fr+MbgF79j0wxJf7UPMIyR63/yy43BpTUNohLDnNtn5ek@vger.kernel.org, AJvYcCVqeuYA8Qiz7/uqo1Fa0ftB1OAakwS4HU+VIomiRf6PYHJvVyw7P6I5jAmZtqSIgBrRrMagSeH43qz+@vger.kernel.org, AJvYcCWThU4cLbMCAzBu/XOK4QOHActq5/sY3Dc6raQXmlGbyGgIzJSzS/iLlow/U0ToXC59OZwLco9y/vL3fWQL@vger.kernel.org, AJvYcCXFL+2gk7Da3py3nhoQNKZAjKZazpbadqqo60lCBbZxgdK68Ti6UhpyWq7YTQ2jyYJkhgTyFumeQ4oK@vger.kernel.org, AJvYcCXPvuCFWO6Vmr6RBqi2M72nS7beaBeUTVYAqTT8UTtk8duWL7gYEpFKUQVwQHTupHh2NP7nnOCDadaSMBirCSA0@vger.kernel.org, AJvYcCXWyY6iDcEgwlL7LGcg8QkOodywcnz+UN4Id7wFS+D+Rhrc6zsqC+kQMHP3gx5b/k2PCjdDzqUYPy4WA2M=@vger.kernel.org, AJvYcCXrjrbhs0qUvFCZJjWpKBwiCdf7/GToOMn21eDxFzqTKNt1U7TzxuwaP34JsbGx+OsQRw7omqBtbRHYiWVFA3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxmiQC7moqxZ6z483686vZTfxOMp8dxnfxikFkIkgX8XR1AAlB
	C73EV3R2msrKKnqDKmw3tnS4LM/6gk/2Iu/uPXztpVzQHsFIhSZo
X-Gm-Gg: ASbGnctlVEe+SsAT9uLSLeDZ56OIZRk/+K+7KyGArlGtTCuTk9thvbktylcJOHwks0d
	Mlaq95y1mSDCtb59KZwGeU8bH2PgdX/4RDvTfiCupg5nvxLY31AEuCKB/cbVB9eDZk751NXRGu+
	MrAznYr57f8Ld2RWBVRCXGi8/CQ0ZuhnhhRgJAeKUGbTic7FfCn2tqJBKzXqi7Ju5qwkDVcVs/d
	1TJ14ftH/eCKgCQZBckGcfdQrCtauLnjCTa7PX3bmVmfX4fjKEzbWv1Zzowc2ypvt0k/h7H4Y4W
	3Gf/6hp2waSf173R2IQkEz5YgXDY3BY4BRmHUUND01CGhXfuhlBJHQjvDKfjLz39XmVgyUHF6GW
	AAo4MlQuZc/mfa+eDmQCXH2WABX0xm2qH60CPbIb/0w1uHQ==
X-Google-Smtp-Source: AGHT+IE4aEWQPkqiy5I27QCZZ2S9VN75tNsUpUF1Fqn3A5Fq7wYWYybmnqidSePzd6l94vLcsOAbGw==
X-Received: by 2002:a05:620a:1a88:b0:7c5:464b:6718 with SMTP id af79cd13be357-7c57c8f0a86mr2968787385a.54.1742256865302;
        Mon, 17 Mar 2025 17:14:25 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573c9a74fsm650459285a.51.2025.03.17.17.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 17:14:24 -0700 (PDT)
Message-ID: <67d8bae0.050a0220.433a8.7a6a@mx.google.com>
X-Google-Original-Message-ID: <Z9i63dOYXuABDtz5@winterfell.>
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfauth.phl.internal (Postfix) with ESMTP id 20839120007E;
	Mon, 17 Mar 2025 20:14:24 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 17 Mar 2025 20:14:24 -0400
X-ME-Sender: <xms:4LrYZ5sX5tTovf5gsnBUcaXhr8Zy3ZTWvbaEIC6I1LNHRqmqLljfKA>
    <xme:4LrYZydrB9SFXt-ymauwdSHfFkIvv1oWVSHrL68djwWPCV7TMl134pBOPdKsqEkX8
    u3cCk4_CYD5Vl5_Ng>
X-ME-Received: <xmr:4LrYZ8wBwoKilae0KR-6g4AQSnwlEcEZbQ9jH1-T8j98H-d5_bdvN5LM_hZ5dg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugedtleehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeehudfgudffffetuedtvdehueevledvhfel
    leeivedtgeeuhfegueevieduffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgr
    lhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppe
    hgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepfedvpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehtrghmihhrugesghhmrghilhdrtghomh
    dprhgtphhtthhopehmrghsrghhihhrohihsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehnrghthhgrnheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhhitgholhgrshesfh
    hjrghslhgvrdgvuhdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    grrhihsehgrghrhihguhhordhnvghtpdhrtghpthhtohepsghjohhrnhefpghghhesphhr
    ohhtohhnmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhhnohdrlhhoshhsihhnsehprh
    hothhonhdrmhgv
X-ME-Proxy: <xmx:4LrYZwN4K89AUkvN2__CmZByfqINtNgqx4qfOjyJdOEVY_SKICz8WA>
    <xmx:4LrYZ5-PXLz9fJqRSJg-qVlEM4DzUUPCf61azFp5PHEq3SREvYY8bQ>
    <xmx:4LrYZwWd7CXOZYK2MeXD95stTv6gB5gsvGWZmQvHCjDETIZks4YMEQ>
    <xmx:4LrYZ6fqCkRnuhOFUvP77B6j90V76pGzAVe8VL2Rg4QJC6qcZzkCyA>
    <xmx:4LrYZ_e_HPRsmbpBuLs06PkTlgUjQXcLPnuHvc9BpGy9bR1dOxKbgsLJ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Mar 2025 20:14:23 -0400 (EDT)
Date: Mon, 17 Mar 2025 17:14:21 -0700
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
Subject: Re: [PATCH v5 6/6] rust: use strict provenance APIs
References: <CAJ-ks9n8mwt5q9unqfkfSHj9=ELJHtqsXM-xQ8jsbXeJX6Uyfg@mail.gmail.com>
 <67d8671d.050a0220.3305ab.6372@mx.google.com>
 <CAJ-ks9=uHjJrzM0ruvm4v4wr8LygRMP-1orWBy_9OiNNeQr0ow@mail.gmail.com>
 <CAJ-ks9=Qcmvbm=YGJ=jrX_+YdMsftk=FAimszYZB1OUuV4diZw@mail.gmail.com>
 <67d885ff.0c0a0220.111215.5644@mx.google.com>
 <CAJ-ks9kYB1b4XsQcFb=NScPq+R+13U+Sv-6opi-yp6=ZjuLD_g@mail.gmail.com>
 <67d88a1d.050a0220.2cdacf.4adf@mx.google.com>
 <CAJ-ks9kg4Br=56HT7T5sWpoMKhRqT_2x+cpQAWoyrEG3qyqQ6Q@mail.gmail.com>
 <67d895cc.050a0220.99d33.5adc@mx.google.com>
 <CAJ-ks9ko3FGtpCnTwhuAb+KHwGczN_H8tM1=SQjRc3M-LgZrqA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ-ks9ko3FGtpCnTwhuAb+KHwGczN_H8tM1=SQjRc3M-LgZrqA@mail.gmail.com>

On Mon, Mar 17, 2025 at 07:56:09PM -0400, Tamir Duberstein wrote:
[..]
> 
> Option 3) take this series without the last commit, and revisit when
> MSRV >= 1.79.0 or >= 1.84.0?

Works for me as well.

Regards,
Boqun

