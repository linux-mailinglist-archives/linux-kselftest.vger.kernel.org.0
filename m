Return-Path: <linux-kselftest+bounces-29263-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07026A65B00
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 18:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10AE718946C3
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 17:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B197D1B042C;
	Mon, 17 Mar 2025 17:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nVH5Gc3a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCBA1AF0B5;
	Mon, 17 Mar 2025 17:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742233172; cv=none; b=Ossko/Z9a+yXYvjrwLsuBAJWxw39iFQ93AJZ1kKixnWZRL4+6xd6cc4wjiMviO6gQSrqs00L0UFAaoFfvyGi0Y05onR4PHylXW+xiW366bxk8SJcnvpUr0pKttBXjHR01yMWmzBMmjvs3ZWeNEk1MroCsd5ZvaaawDMpWo6beqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742233172; c=relaxed/simple;
	bh=NGQq5K83/vPzD/uS9HGlHsWeJ4HkaFS7L8ALsCyyG0s=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V4NJZXtsEYb05ZTbOvH9AQBVCnl3zDjD4wDsFt/ewJEwrNI5Gg8cAhYccBSSB3MOs8JZg9enrdzCo7ZhfENBwjcoVvvk9hHyFjpFTrTZCKZ7XJwLN+QdAXgMgP5kQcj1spKxYEpGRA9pY7tT1/S/MvHt7r8s98AT1h6wEfiJSkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nVH5Gc3a; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7be8f28172dso316643685a.3;
        Mon, 17 Mar 2025 10:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742233170; x=1742837970; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mhEvtcNZELERrAtkDWtVTp7aSo57zSoSR74u4wwr3wY=;
        b=nVH5Gc3adHqnZIzztNQhweZMbnb/kWdw5C2YBXt6n+DNA00Wpd0YcZUYqJ1vdig8j0
         icCmAxAHMgQmV5qs6H2126mNIpj0u5HiKwYu62yvRPryv2OBhC1TGNTBn7r4bUc7sZG0
         Eec43HOuD/o3sGHGBZRo339+LI0bBUTqsYLolgBdYLl3Qfxcfjl4Ss2uX06iIrmn8uM5
         M/DSUX4XWpl7wX4jqoKNxLAcE0YMuurbsZ70ORSU7oqC3TqbBLsucZ1DoeKDvCZencqe
         BiFLWFigUC4UkKdG41RO2EV+QT51meD4SZQBoND7debhj94a/kCXFqL2SF8XaGmlOiNB
         ZZZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742233170; x=1742837970;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mhEvtcNZELERrAtkDWtVTp7aSo57zSoSR74u4wwr3wY=;
        b=W6As4hK0IboNOOHJ46jN8VfmXLtSmZ+rn0E+Atf2qQ23hgy211ggQ+2F2D9cdCigLY
         sIJFgNHlX0cXs1md3wXx0fPyLxQUXd6Skd/3PGcmE5OYnQ6+QmuijZsdHv/HGuZnBfnE
         J11/ToCcnUjgzujyTljRd+ihXVLbzaPZxn2nsnFpjEIxIuM6aoUZwGrvEg8dwQ+l08vc
         6dGXpLNFBfrTcaqIPaOYdz8Vc4QFz/244zDUXWIPEjiSW5mJLlPxhUKCRiJMdizPsQBq
         HhNfzBBBL3jMzpjh1LmFezlVojgsQbQGBLXlHSOuCu987LwTskfLLBV2L4yVH5pRiM6r
         n1bg==
X-Forwarded-Encrypted: i=1; AJvYcCUFOKxjeo29Pn6fSVdTky5PLDc4G7tOoVX3z9qIF5S3/8GczVo2pxMpfQRS6By94cQoRkVVvLgLxuyqMCrm+RYH@vger.kernel.org, AJvYcCV3XKojz0WvbqNMq5XV4aYv+LNuZP1jc96uayvjuwKrikqZacMcuhgY8VnC1xLZC9o5aFDt+VoHEZnjzTQ=@vger.kernel.org, AJvYcCWE2Xph6VQUc0IxO5jBoAlaWf6ACLJFdlj0iD5FPdL5a8SAK+RdS3+Z42kX33LPmgmUuwtdJKPgPkUxe3oB@vger.kernel.org, AJvYcCWTdSWjo0jxmoMporQwNJBOqueL7QJtxyF0LEV8ELqhanbwEIG3DvSHUUJPRwKwv8j7LOC/+I+tSvdL@vger.kernel.org, AJvYcCX/TPG1h95AQsxoislM3T9KWme5EHJQE6EtGy+mjANEOtrvdGq0Y3bYen4KJE6CbJrt+kLfJITRC2tw3ecb@vger.kernel.org, AJvYcCXK2GpxV510KYtIELP8WoDDGVf34bWXgy0AtRGPZHEUoWV1f3S025iC77hYR+nIWCJGQj0U90F23tI8NXMy3sQ=@vger.kernel.org, AJvYcCXZCKpMupK8cvmE+LkpGeCI4lD9cALKGP7tWwaIb/TOUWWmCOAiOMlRwVbGVFkksxWdCV+wHCDJmzyu@vger.kernel.org
X-Gm-Message-State: AOJu0YymD3ZPA9t9+pjOXeKL3vb4EDKnwLwiL/u/OHv15X7gbUvZiX1k
	kpslzMoU7UeTB4df/N4rW/IJCcDG8MtcTATVF4vJP74uFxT3z2LI
X-Gm-Gg: ASbGnctHED7TTO+rOjVmBCaRcQCpD/ZVFlDdbrND/tiSBJqUhByg3OvPIcgVj8YQ3ig
	bczXzwmSmvm3p+817V1y9O+Twr3WK0MXlwHOuo7AqN8S6pRFDJ7VUaxT55pdgOUWNOgzsLjSv+K
	E37OFp09imG//Tq0uUwu/Q8cFYRLN3AuHwLv0LPIJgqLNsqHvqzPu6OpsovDBjIEswLXaIZdEbK
	gg7umnUbTHom67H4nVMUTZ5twUNSIypncb+Q5sUh+6ulevv3dFmcniSzgRvu8aZkz4HXbt4VZOM
	ZZFzio3zdr5d/9OQtwKZZDmgWtAMfJd0QWLcwLR++DyuQA+U8kHykYtpxsBN21z0ETFJzCfTizv
	SUc4AmlRgRiS37wbMQrh9fxqIOBFjya2WT38=
X-Google-Smtp-Source: AGHT+IF2Jaytx5XgFT/0lkyY5QiRwzZd8QS8b8xIa6ghXSSn7ayaz5CqoWDxdFb0fj1oEpcefK9+pg==
X-Received: by 2002:a05:620a:220d:b0:7c5:9c12:fc8 with SMTP id af79cd13be357-7c59c120fd2mr11555985a.38.1742233169507;
        Mon, 17 Mar 2025 10:39:29 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573c7842fsm611089185a.42.2025.03.17.10.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 10:39:29 -0700 (PDT)
Message-ID: <67d85e51.050a0220.2a36b.58b3@mx.google.com>
X-Google-Original-Message-ID: <Z9heTkH4UaPeD5Vi@winterfell.>
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 54DEF1200068;
	Mon, 17 Mar 2025 13:39:28 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 17 Mar 2025 13:39:28 -0400
X-ME-Sender: <xms:UF7YZ0x69bVjgBhrmZ05idGJbijB8ZY8psgDh5aD372UF0aFWeQXQw>
    <xme:UF7YZ4R2a_MWxMvzAPZqY_zxEDRjXyCWwF9mJWroLHEhS7kNzdB7JpyKIY8LQrH4T
    FtNbRNdJGI_YMu8Fg>
X-ME-Received: <xmr:UF7YZ2VmTOL-ZOeLOJqMyPx0oG1oVjF6bI51RlWTihPNofax_73jUYKWUBgFLA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugedtudegucetufdoteggodetrf
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
X-ME-Proxy: <xmx:UF7YZyjDhT5qseyBk4F7FOh_7TRTXMV4EXqPSq0FViJsQulUXwJH8Q>
    <xmx:UF7YZ2DMbaGxGcdH-LGEYLV8BJ3-zIKFvPd3wNF4l-GS6o_gmMw3ag>
    <xmx:UF7YZzLhxIqGs78hHdv5aYMq_-iKORe9LYE7NqIvFAOz9N0lcY6u6w>
    <xmx:UF7YZ9Bf3GByh-HG7_VQnQzGZKuAHE0fynqwHUCUwS_96So6HyO-Xw>
    <xmx:UF7YZ2x4Wvh6Z90UVDj4NlR4XmjXHFmH-j8ATyd-GA6hTweqWnY3uGBl>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Mar 2025 13:39:27 -0400 (EDT)
Date: Mon, 17 Mar 2025 10:39:26 -0700
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
References: <20250317-ptr-as-ptr-v5-0-5b5f21fa230a@gmail.com>
 <20250317-ptr-as-ptr-v5-6-5b5f21fa230a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317-ptr-as-ptr-v5-6-5b5f21fa230a@gmail.com>

On Mon, Mar 17, 2025 at 10:23:56AM -0400, Tamir Duberstein wrote:
[...]
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index fc6835cc36a3..c1b274c04a0f 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -17,6 +17,11 @@
>  #![cfg_attr(not(CONFIG_RUSTC_HAS_COERCE_POINTEE), feature(coerce_unsized))]
>  #![cfg_attr(not(CONFIG_RUSTC_HAS_COERCE_POINTEE), feature(dispatch_from_dyn))]
>  #![cfg_attr(not(CONFIG_RUSTC_HAS_COERCE_POINTEE), feature(unsize))]
> +#![cfg_attr(
> +    CONFIG_RUSTC_HAS_STABLE_STRICT_PROVENANCE,
> +    feature(strict_provenance_lints),
> +    deny(fuzzy_provenance_casts, lossy_provenance_casts)
> +)]
>  #![feature(inline_const)]
>  #![feature(lint_reasons)]
>  // Stable in Rust 1.83
> @@ -25,6 +30,109 @@
>  #![feature(const_ptr_write)]
>  #![feature(const_refs_to_cell)]
>  
> +#[cfg(CONFIG_RUSTC_HAS_STABLE_STRICT_PROVENANCE)]
> +#[allow(clippy::incompatible_msrv)]
> +mod strict_provenance {
> +    /// Gets the "address" portion of the pointer.
> +    ///
> +    /// See https://doc.rust-lang.org/stable/core/primitive.pointer.html#method.addr.
> +    #[inline]
> +    pub fn addr<T>(ptr: *const T) -> usize {
> +        ptr.addr()
> +    }
> +

For addr(), I would just enable feature(strict_provenance) if
CONFIG_RUSTC_HAS_STABLE_STRICT_PROVENANCE=n, because that feature is
available for 1.78. Plus we may need with_addr() or map_addr() in the
future.

It saves the cost of maintaining our own *addr() and removing it when
we bump to a strict_provenance stablized version as minimal verision in
the future. Thoughts?

Regards,
Boqun

[...]
>  // Ensure conditional compilation based on the kernel configuration works;
>  // otherwise we may silently break things like initcall handling.
>  #[cfg(not(CONFIG_RUST))]
> diff --git a/rust/kernel/of.rs b/rust/kernel/of.rs
> index 40d1bd13682c..b70076d16008 100644
> --- a/rust/kernel/of.rs
> +++ b/rust/kernel/of.rs
> @@ -22,7 +22,7 @@ unsafe impl RawDeviceId for DeviceId {
>      const DRIVER_DATA_OFFSET: usize = core::mem::offset_of!(bindings::of_device_id, data);
>  
>      fn index(&self) -> usize {
> -        self.0.data as usize
> +        crate::addr(self.0.data)
>      }
>  }
>  
[...]

