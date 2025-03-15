Return-Path: <linux-kselftest+bounces-29115-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C2FA6230A
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Mar 2025 01:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AE6F162075
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Mar 2025 00:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688374C8E;
	Sat, 15 Mar 2025 00:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VqdMJYfg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA4BC8E0;
	Sat, 15 Mar 2025 00:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741998220; cv=none; b=uP2k8+kPHdOnyaOUpTuLSs6TUHgr3CciN9T+TcO8QEGqmJw2xQEcR9tzBMUYL3gZKlpVIiyI7JuZMg8WU1m4L/yag0X+z2A79PBspDYZBQT+Tbc1wNuW+U1vtQRS+2t3w9bIccJJ4uHBWW8tVsobC0V7Me2CFG5LZux/6snyigw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741998220; c=relaxed/simple;
	bh=4ikv9eyptdMwfYJR5gqj/ftAkhzmPPbyPxILpYgCsx8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aaoBkEDB7xWTnT6iYlvw1H9mH4/p27/LWRaei1iunvfkj1t3E2mUu5q4dTg0UaUgdMEEZwO/EIWz2RXGTUWwio1TCBmXstFDqpKJo0LSdJxLK0k7KjCya4N16V483ES75RjI3RKD77Mg03xyHrmdjNo9H/44uZQuGp5T2IqJFvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VqdMJYfg; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c2303a56d6so295392485a.3;
        Fri, 14 Mar 2025 17:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741998217; x=1742603017; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KtGUbifaWdCRrexkDNtRNiLhnpL1kbPY2Ei7szaObU8=;
        b=VqdMJYfgyoNWlaAptxKhuZaU1dzYmL0M5mPgJ0IhPEiTVCqLno/qu/PUaTgVf8ch/c
         I0lehjQ2/pDhRISVCoKUen05uH7naDN5700IRsszLkfgdxdzp0rw4u3DTDSDcawTCkvm
         OiblGuCBssmppJ1PJd3w3GnVEEOvQxA31AJMJTh6SF3L3MHMvzLnmvnk6fSWey/7rcut
         lhUBKtpJYgRZu+9GslxpjZ7hdBsuV2PmVYvJv9oPhqBz4TRO8O/a8q+H7Hv6ANCdmzgn
         vv6FI2hrcGzzVkLSgjGndvJNagXQdWec0w6RiJH2UPY7h6e4oQC0M2Qk3i7/YMz2Mjug
         AP9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741998217; x=1742603017;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KtGUbifaWdCRrexkDNtRNiLhnpL1kbPY2Ei7szaObU8=;
        b=wU+3Iy77RORf0seBnMkZ3OHeK8RCBxF60za2D9hCpAhqF6oX/QYRdeDhx99yEaagWQ
         bQosbxcy0VEm1VxbhNKqtBnpp5P1RsWSqUTX1WX4qm95U6AaaAE96xh/tSOF0B8/NdNf
         7BSdMq9rRU6yQV1ATbDb6b2YyZb7zOIcFeD9MfhV3/LbGBtfbLvozEFpWTYtoiGN2B0k
         MUX/HDGAnBXaV8fIO4Tm+ZKZ5rNnZopFhpRmDwXBXqBkqUS0DNuWhY/GSXlNT3t7Py0D
         CgbAESajRUT0odpRZYW1stAUZcWnziK87SOlHhdYnzVYMQRuMJARTPzDYNUQX3JQ7GXP
         M2cA==
X-Forwarded-Encrypted: i=1; AJvYcCVc2cJf2/zG09BqdGDY+AIG8el4D8doi2HBHWY4yKGDWc63PAXZ6B6gUreRqWHRenIDQGZrY+psvwAIu+Yj1erl@vger.kernel.org, AJvYcCVdxXIuIpiSxw/Rp5xD61JhvykSQH2tqxeMQPVEmmP7yJMa/K2eluvZEysuiYlhEB4eS5cn7O0P@vger.kernel.org, AJvYcCWBpPCu8zbwZVVh9sFRyXA1CQfku82JB+UNKroXW4MjTero92k7Il3qeY3YDuNEY+jzX4ma7y3IU0W0mu7fS/0=@vger.kernel.org, AJvYcCWg0TiIPz2p7SWnMZIRR7AIcPADRG+ZzQj4S446h3V1dhmA1W13x3Bhj+crQbvUS/O1HPauBeqs70D2@vger.kernel.org, AJvYcCX/WrpPfPTEC/gi1cs9K7+K8xweMJjy/FbztkyUF/dCi+lexV334zWkhUooRZ1lfZvVa/sXbqP+1ANDIX0n@vger.kernel.org, AJvYcCXjVoR+VZMhSu5kkI/qsrU8b27pQCu/q5Xnpmt2IoXgnVJYuvnBqbSdnl2KV0aZFmOvQ25aIXPnGy4Ulw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz+Uki2BKgOwkxs6PXx2WsQk7Cj48Tu5lUlj3r1i07mNAGI/me
	eVQw0XRKvByQ/YeaONmg7EDANYypxanEvro5Olqay8Z0hTpmGfWv
X-Gm-Gg: ASbGncsKK7ZSA8xlEoyPDq9ObnnjykfSU+PRGLFWTI5pbImtH+gpXGPKM52XlraxIxP
	bWbF6Nvd/SAIlj/jDhWmsMQWXlA+jjEaEypDTwq4p8WcNn4cS8c1z4o/HaJtaNVSHpA+1ST707R
	Q/Lp4Q8RjrRqDMIZ0JFgC7UWK+p9Qv2LmjGtXTxtQmF6bSoG1YJ21x6mZzPvVthruv3c85HK7PA
	wz1+bfcELV18TcbnQnP4XIe6YljBSwp6c5GySVb8cH9vjP0KtbUBLGE/pTIza3omE+JAA1aLTdb
	MDiZJnC/ymd3R6TvKouw968fXiR9EFAiPESL2eVrz5X0Zb/1yBZPYYzqNLBGSAcrSHNX1Kfp2Q5
	FXNcFfIu9fGG4TgImvlmXmheZKDmbhujXzI7ns0QXhbkcJw==
X-Google-Smtp-Source: AGHT+IHMpER/JnbkGNCfSySjFX3UEHCHjaZZWgeAljh7oBmyDf8g26BQmTLLo5enSqswp/8nMLGTfg==
X-Received: by 2002:a05:620a:2b96:b0:7c5:6299:3f4 with SMTP id af79cd13be357-7c57c8f03c6mr831634085a.49.1741998217413;
        Fri, 14 Mar 2025 17:23:37 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573c4dd9fsm321259185a.4.2025.03.14.17.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 17:23:37 -0700 (PDT)
Message-ID: <67d4c889.050a0220.35d7ce.b4b0@mx.google.com>
X-Google-Original-Message-ID: <Z9TIhZlMyLe4eFUJ@winterfell.>
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfauth.phl.internal (Postfix) with ESMTP id 664981200043;
	Fri, 14 Mar 2025 20:23:36 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Fri, 14 Mar 2025 20:23:36 -0400
X-ME-Sender: <xms:h8jUZ74e_UbzhWKyL0vR8GNjvb2XGrNAgk4_VgW40B01hoiXfJ7S3A>
    <xme:h8jUZw7nggYlYki7_RHh6X1sPlXohGpse0pS_gMHYb534N0k0WOpJ1M4NmwnV44mS
    NW7GqxwTS_bSV5lNw>
X-ME-Received: <xmr:h8jUZydNm33FOpPngpMJqlp4sOQc8Bpq5AYx0H28DkOyrsYa1CAjuPPuB7U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufedvvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeehudfgudffffetuedtvdehueevledvhfel
    leeivedtgeeuhfegueevieduffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgr
    lhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppe
    hgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepvdehpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopegtohhnthgrtghtsegrnhhtohhnihhohh
    hitghkvgihrdgtohhmpdhrtghpthhtoheprgdrhhhinhgusghorhhgsehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    grlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgrrhihsehg
    rghrhihguhhordhnvghtpdhrtghpthhtohepsghjohhrnhefpghghhesphhrohhtohhnmh
    grihhlrdgtohhmpdhrtghpthhtohepsggvnhhnohdrlhhoshhsihhnsehprhhothhonhdr
    mhgvpdhrtghpthhtoheprghlihgtvghrhihhlhesghhoohhglhgvrdgtohhmpdhrtghpth
    htohepthhmghhrohhsshesuhhmihgthhdrvgguuh
X-ME-Proxy: <xmx:h8jUZ8JPSDkCkSkVt3RCB0Mk0E6jmS46WfWGUfUJeprU262aCCSJgw>
    <xmx:h8jUZ_IFjlqJkRvidnGpq-HLbqiAU6cTlhXqLYie0rIDx4roP_n9yQ>
    <xmx:h8jUZ1yQzv9jBdBC-yTOo02PuZnhEaLzwYnAKPlnZSUXkevoxOb8Nw>
    <xmx:h8jUZ7KwE9A7UvQLx7IZJeY4skdT-pxzupkpiKa2zZZKJJw8pQCTTw>
    <xmx:iMjUZ6b06pHFrdh8E5BfHZJQdSCferZ5En_EfIQWlF8tW8bvC1g5ZrXX>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Mar 2025 20:23:34 -0400 (EDT)
Date: Fri, 14 Mar 2025 17:23:33 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Antonio Hickey <contact@antoniohickey.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
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
References: <20250314234148.599196-1-contact@antoniohickey.com>
 <0100019597092d67-0da59c6d-9680-413f-bbce-109ef95724cc-000000@email.amazonses.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0100019597092d67-0da59c6d-9680-413f-bbce-109ef95724cc-000000@email.amazonses.com>

On Fri, Mar 14, 2025 at 11:41:55PM +0000, Antonio Hickey wrote:
[...]
> @@ -541,7 +541,7 @@ macro_rules! stack_try_pin_init {
>  ///
>  /// ```rust
>  /// # use kernel::{macros::{Zeroable, pin_data}, pin_init};
> -/// # use core::{ptr::addr_of_mut, marker::PhantomPinned};
> +/// # use core::marker::PhantomPinned;
>  /// #[pin_data]
>  /// #[derive(Zeroable)]
>  /// struct Buf {
> @@ -554,7 +554,7 @@ macro_rules! stack_try_pin_init {
>  /// pin_init!(&this in Buf {
>  ///     buf: [0; 64],
>  ///     // SAFETY: TODO.
> -///     ptr: unsafe { addr_of_mut!((*this.as_ptr()).buf).cast() },
> +///     ptr: unsafe { &raw mut (*this.as_ptr()).buf.cast() },

This should be:


///     ptr: unsafe { &raw mut ((*this.as_ptr()).buf).cast() },

, right?

Regards,
Boqun

>  ///     pin: PhantomPinned,
>  /// });
>  /// pin_init!(Buf {
[...]

