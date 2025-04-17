Return-Path: <linux-kselftest+bounces-31080-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ABE6A924D3
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 19:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE1887A93D3
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 17:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C81B2580F6;
	Thu, 17 Apr 2025 17:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0b5J5j9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559372566D7;
	Thu, 17 Apr 2025 17:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744912520; cv=none; b=TKyIoZu3So2xLkOJpfw+Qi/iSmEkwt+JIpRjp+9uFps3KnGz6l9W+401Od/073E5xz7bSaHAdyfwHS5P+fa3WA9XwPXjd/8odw6FCp7FJxwYbRVzC4cTcd3Z7BUxwkFpJ2ypoOt1swndllDJCH1xeqXKBxpIUzAvrXYI0vIFY6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744912520; c=relaxed/simple;
	bh=vZZPLIRZjLTF8DCsEfQ5zp295QmxSVBoEfRxLdbjD7s=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FnbtZABTzJCv0aA6YpHEo8I95jjm7D1gxwSfzHtUFuUaAB84d4gv33z5bRv9gjOWTgPDmm2IN0ylabjk+x1ebbnAntB22I9cwrDstbtMAk1vwfa9/+a0TJYYTH+op29XJabZc/wmtYwTgTElTPhNEsLZJQngXiNnhqWRouW+C/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j0b5J5j9; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c081915cf3so134043685a.1;
        Thu, 17 Apr 2025 10:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744912517; x=1745517317; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qDTyGaLtYvMzXIgfoaj4Rbqx4NtWqG+lF7urmkywNu8=;
        b=j0b5J5j92co+ipS5b7D79JYNFfijrGyK47sNkOch4cCL2qKhclfR4ad6GR1OHps2ch
         kDxeaaUUC/4Cq+2rmEVrwIDOSRtie577hHaDPXInKyoESFOKSQnfkTk9htkufcYeyfmH
         fhmd2+hpOf+Y5cfcV6RBB/N90TELi1GW0Bu7qAJURRFjyeNa9k0mdX81tfKcKEJGg/cu
         FJkMnyXdGZruUbnA7JBGbYo0hjmuhIc/u0JP674rYFCFM+3KShPXAPMq8qbhk595MT5m
         ZmYPLLIjsLFBgM2+Zz0mPt1J9K/qKeQ435TL4qTtSJXfdjgJPRt2S+2l0TqaRAGMy9fx
         YVPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744912517; x=1745517317;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qDTyGaLtYvMzXIgfoaj4Rbqx4NtWqG+lF7urmkywNu8=;
        b=KFtgUpJvH+zoOkVLA9BjfWHrPfphZWp2eCX47Yha8DmD4MMOYdzBNX+STlsLqXHkRE
         ZKYtdUFccnIhprt8aJEe0X0yFrfk5UbavkKthmTzIgTwyI8gmuSBW29bL3qj/3aUODeM
         X4Pdpt7/foyQtnXBufY5YI70jCi3t/9+3lmIV+P1LU+us8lTSTOAoaiV4RBRkhU/VC55
         5aKyiEctEPDfx3bhuPSic9pjxG+M6jSTXx5nwbotXzYUCAiQVIZ5we9OTFbXcWoGotO6
         NpFQez/vkKb+kefFNEeD560coSylIVdtLqypwrh3OQNXMMMocM+Jfn6dWVDEHySh3fFP
         TBQw==
X-Forwarded-Encrypted: i=1; AJvYcCUaP/TczVDAovpOZuR2JgK/tycprWV5kfRbexzUZcF1i6SOT+iiy7oCL//x/NO4DMunB/3hbnkfRt66n6PNOgI=@vger.kernel.org, AJvYcCUyssu9d1lPziYhzYoej8Pzok/DpYS5HmyGNE7AoT5Khr9yad62RAr1l2vQGTX/S8ReaccziymYL16j6B/9DlD5@vger.kernel.org, AJvYcCVQCVK/4n+BjB8XOv7Mvl6j0NudwsFcSwLmCsjE0teBZcjWlbXK2lMvkgNa6iGu++WONm8KQBv7tjvz@vger.kernel.org, AJvYcCW2WcUBH/1Qn4rI82lr1xrysE71Mtu6jbquQAdNWK5xI69yWpCbGUj7iRaAotUCQRJgujA/ldEpWOV8jR73@vger.kernel.org, AJvYcCWieIJU+JXq1N1cIru27WUbCyDm2pgCzLvNM//dLAUWBMlO1hJN4WNbHbuD4IqtVAoLDYm19MgHWjYbq1Mj@vger.kernel.org, AJvYcCX2KAQcw38IqmAn6s27/ZucZaHUrbn3/fqzkwV7x+AFGp5jIQuFGIzslv2jfoUcnsZAVDDgtzViMr3G@vger.kernel.org, AJvYcCXe3kYw9GyNYgq4OaCOdpab4lRPo5yiiaQq/ic8TxQNrnfp/SjwQe29yd8XgB1oY95rLjww22bGI7PyrGo=@vger.kernel.org, AJvYcCXl861dLVw6ogtvc15Pyddb4oBGu8jL5imWb1ZLEkZFWCzgt+j5UgmX07Z1Jf7RIG1TOuXCNIXM@vger.kernel.org
X-Gm-Message-State: AOJu0YwT/JHyngZpDX/+em41fxy8wgskmSv69vxpP2+svDZIl8sEpmz3
	PabnM14AghJ7pvhSRiIW3ntBRKfTrtrZj508llgNcByOe6lG6YSH
X-Gm-Gg: ASbGncvMrbMlyQW6Adg3pk19flvinMCs1v7bozrMZbXtX8K7nVShPUXWrcO0T4tMR8E
	agg0EEwGK13L+zeubBvLZMaGNz+zQH3p/xrYvCWtNaa0lJFAYk9YG6tfbc1Ow7YnKWPor5iNW3x
	S7y5w02l/bK69UcnCo61XMpJ+C9/R86lyxkL9CurzJp5hAnz97xM/X17c5o/9BkQBuCDwxrSqBX
	gQJgoaPDQZdkSjz7MbExzsrjO2XowMukIFks6z9866sEa2h17BGg5F/6zO/3qlia660EycKhR36
	lxwQqC0THI/O77A7hQsEqrSYwtvNh2Eeoy32EGYtoaH/mXZPT98on2SJCZwiQE2vWYdLSV9A/4v
	2ovOCFdYyOFGcrLWYN5739sH8gZTy71jS7862xstnKw==
X-Google-Smtp-Source: AGHT+IE3H7mH1nYpCtZAyCv0gNgV400qtjcEh3CsRpVjdOU7C2s1ueMnwNvcesjSj2oJQ2QEcjf+TA==
X-Received: by 2002:ad4:5c65:0:b0:6e8:fb92:dffa with SMTP id 6a1803df08f44-6f2b2f97ff2mr117242546d6.25.1744912516938;
        Thu, 17 Apr 2025 10:55:16 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f2c2b0f0fdsm1708066d6.29.2025.04.17.10.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 10:55:16 -0700 (PDT)
Message-ID: <68014084.0c0a0220.394e75.122c@mx.google.com>
X-Google-Original-Message-ID: <aAFAgcqBweaMzlAE@winterfell.>
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 670A31200043;
	Thu, 17 Apr 2025 13:55:15 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 17 Apr 2025 13:55:15 -0400
X-ME-Sender: <xms:g0ABaKa4EcQUC7fK7BYEjgy2gGAJI13Q2EBEttkW1DIPfPkLwCPFjQ>
    <xme:g0ABaNbebtyF11d8GBpjn5jKGhVH8idOwX3TpiXtReZNPDn67VxvyPU3Dj87vHnRN
    zTQUiQ76o2uCZj22A>
X-ME-Received: <xmr:g0ABaE99EXDad75aTJ2E6BW8TM4x8UeYaddVaOt4TqmECgE8LQ-8NbXzqZf2SQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdelleduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnegoufhushhpvggtthffohhmrghinhculdegledmnecujfgu
    rhepfffhvfevuffkfhggtggujgesthdtrodttddtvdenucfhrhhomhepuehoqhhunhcuhf
    gvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtthgv
    rhhnpefgteetfeekheekleetffdvgfegkeetkeehudfhheegveekleekieeuudeitedvue
    enucffohhmrghinhepghhithhhuhgsrdhiohenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrsh
    honhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghn
    gheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepge
    ejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtrghmihhrugesghhmrghilhdr
    tghomhdprhgtphhtthhopehmrghsrghhihhrohihsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehnrghthhgrnheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhjvggurges
    khgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesghhmrghilh
    drtghomhdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthho
    pegsjhhorhhnfegpghhhsehprhhothhonhhmrghilhdrtghomhdprhgtphhtthhopegsvg
    hnnhhordhlohhsshhinhesphhrohhtohhnrdhmvgdprhgtphhtthhopegrrdhhihhnuggs
    ohhrgheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:g0ABaMrAvrmxf3gdiJO3-ZbxmF7UIMs2PHeSVcsCn51Z8WkUFa-lgg>
    <xmx:g0ABaFpW6Zkb7KQ4fzsYJKoOfk2zeyEiqGixN0bi66xIrdlqUzS51w>
    <xmx:g0ABaKQ8zVN6GqRR5WsaFGM4miuik80rgyuL4NMBiOvmcykxiZ6Llg>
    <xmx:g0ABaFq7q6ScWpkgBnLDstyvt3GXcCW2ZUx7e4xF7jcBtfKiM7gZLg>
    <xmx:g0ABaC5uGjNwNtEanE9knMMkjvbEj0OWv_RcOmcNpy0TzVCHEUS3UHDL>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Apr 2025 13:55:14 -0400 (EDT)
Date: Thu, 17 Apr 2025 10:55:13 -0700
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
Subject: Re: [PATCH v9 4/6] rust: enable `clippy::as_underscore` lint
References: <20250416-ptr-as-ptr-v9-0-18ec29b1b1f3@gmail.com>
 <20250416-ptr-as-ptr-v9-4-18ec29b1b1f3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416-ptr-as-ptr-v9-4-18ec29b1b1f3@gmail.com>

On Wed, Apr 16, 2025 at 01:36:08PM -0400, Tamir Duberstein wrote:
> In Rust 1.63.0, Clippy introduced the `as_underscore` lint [1]:
> 
> > The conversion might include lossy conversion or a dangerous cast that
> > might go undetected due to the type being inferred.
> >
> > The lint is allowed by default as using `_` is less wordy than always
> > specifying the type.
> 
> Always specifying the type is especially helpful in function call
> contexts where the inferred type may change at a distance. Specifying
> the type also allows Clippy to spot more cases of `useless_conversion`.
> 
> The primary downside is the need to specify the type in trivial getters.
> There are 4 such functions: 3 have become slightly less ergonomic, 1 was
> revealed to be a `useless_conversion`.
> 
> While this doesn't eliminate unchecked `as` conversions, it makes such
> conversions easier to scrutinize.  It also has the slight benefit of
> removing a degree of freedom on which to bikeshed. Thus apply the
> changes and enable the lint -- no functional change intended.
> 
> Link: https://rust-lang.github.io/rust-clippy/master/index.html#as_underscore [1]
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
>  Makefile                           |  1 +
>  rust/kernel/block/mq/operations.rs |  2 +-
>  rust/kernel/block/mq/request.rs    |  2 +-
>  rust/kernel/device_id.rs           |  2 +-
>  rust/kernel/devres.rs              | 15 ++++++++-------
>  rust/kernel/dma.rs                 |  2 +-
>  rust/kernel/error.rs               |  2 +-
>  rust/kernel/io.rs                  | 18 +++++++++---------
>  rust/kernel/miscdevice.rs          |  2 +-
>  rust/kernel/of.rs                  |  6 +++---
>  rust/kernel/pci.rs                 |  9 ++++++---
>  rust/kernel/str.rs                 |  8 ++++----
>  rust/kernel/workqueue.rs           |  2 +-
>  13 files changed, 38 insertions(+), 33 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 04a5246171f9..57080a64913f 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -475,6 +475,7 @@ export rust_common_flags := --edition=2021 \
>  			    -Wunreachable_pub \
>  			    -Wclippy::all \
>  			    -Wclippy::as_ptr_cast_mut \
> +			    -Wclippy::as_underscore \
>  			    -Wclippy::ignored_unit_patterns \
>  			    -Wclippy::mut_mut \
>  			    -Wclippy::needless_bitwise_bool \
> diff --git a/rust/kernel/block/mq/operations.rs b/rust/kernel/block/mq/operations.rs
> index 864ff379dc91..d18ef55490da 100644
> --- a/rust/kernel/block/mq/operations.rs
> +++ b/rust/kernel/block/mq/operations.rs
> @@ -101,7 +101,7 @@ impl<T: Operations> OperationsVTable<T> {
>          if let Err(e) = ret {
>              e.to_blk_status()
>          } else {
> -            bindings::BLK_STS_OK as _
> +            bindings::BLK_STS_OK as u8
>          }
>      }
>  
> diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
> index af5c9ac94f36..22697104bf8c 100644
> --- a/rust/kernel/block/mq/request.rs
> +++ b/rust/kernel/block/mq/request.rs
> @@ -125,7 +125,7 @@ pub fn end_ok(this: ARef<Self>) -> Result<(), ARef<Self>> {
>          // success of the call to `try_set_end` guarantees that there are no
>          // `ARef`s pointing to this request. Therefore it is safe to hand it
>          // back to the block layer.
> -        unsafe { bindings::blk_mq_end_request(request_ptr, bindings::BLK_STS_OK as _) };
> +        unsafe { bindings::blk_mq_end_request(request_ptr, bindings::BLK_STS_OK as u8) };
>  

We could consider defining a const block::mq::BLK_STATUS_OK as:

	const BLK_STATUS_OK: u8 = bindings::BLK_STS_OK as u8;

, because repeating the as pattern is a bit err-prone. But maybe in a
later patch.

>          Ok(())
>      }
> diff --git a/rust/kernel/device_id.rs b/rust/kernel/device_id.rs
> index e5859217a579..4063f09d76d9 100644
> --- a/rust/kernel/device_id.rs
> +++ b/rust/kernel/device_id.rs
> @@ -82,7 +82,7 @@ impl<T: RawDeviceId, U, const N: usize> IdArray<T, U, N> {
>              unsafe {
>                  raw_ids[i]
>                      .as_mut_ptr()
> -                    .byte_offset(T::DRIVER_DATA_OFFSET as _)
> +                    .byte_add(T::DRIVER_DATA_OFFSET)
>                      .cast::<usize>()
>                      .write(i);
>              }
> diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
> index f7e8f5f53622..70d12014e476 100644
> --- a/rust/kernel/devres.rs
> +++ b/rust/kernel/devres.rs
> @@ -45,7 +45,7 @@ struct DevresInner<T> {
>  /// # Example
>  ///
>  /// ```no_run
> -/// # use kernel::{bindings, c_str, device::Device, devres::Devres, io::{Io, IoRaw}};
> +/// # use kernel::{bindings, c_str, device::Device, devres::Devres, ffi::c_void, io::{Io, IoRaw}};
>  /// # use core::ops::Deref;
>  ///
>  /// // See also [`pci::Bar`] for a real example.
> @@ -59,19 +59,19 @@ struct DevresInner<T> {
>  ///     unsafe fn new(paddr: usize) -> Result<Self>{
>  ///         // SAFETY: By the safety requirements of this function [`paddr`, `paddr` + `SIZE`) is
>  ///         // valid for `ioremap`.
> -///         let addr = unsafe { bindings::ioremap(paddr as _, SIZE as _) };
> +///         let addr = unsafe { bindings::ioremap(paddr as bindings::phys_addr_t, SIZE) };


///         let addr = unsafe { bindings::ioremap(bindings::phys_addr_t::from(paddr), SIZE) };

better? Or even with .into()

///         let addr = unsafe { bindings::ioremap(paddr.into(), SIZE) };

>  ///         if addr.is_null() {
>  ///             return Err(ENOMEM);
>  ///         }
>  ///
> -///         Ok(IoMem(IoRaw::new(addr as _, SIZE)?))
> +///         Ok(IoMem(IoRaw::new(addr as usize, SIZE)?))
>  ///     }
>  /// }
>  ///
>  /// impl<const SIZE: usize> Drop for IoMem<SIZE> {
>  ///     fn drop(&mut self) {
>  ///         // SAFETY: `self.0.addr()` is guaranteed to be properly mapped by `Self::new`.
> -///         unsafe { bindings::iounmap(self.0.addr() as _); };
> +///         unsafe { bindings::iounmap(self.0.addr() as *mut c_void); };
>  ///     }
>  /// }
>  ///
[...]
> diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
> index 43ecf3c2e860..851a6339aa90 100644
> --- a/rust/kernel/dma.rs
> +++ b/rust/kernel/dma.rs
> @@ -38,7 +38,7 @@
>  impl Attrs {
>      /// Get the raw representation of this attribute.
>      pub(crate) fn as_raw(self) -> crate::ffi::c_ulong {
> -        self.0 as _
> +        self.0 as crate::ffi::c_ulong

        crate::ffi::c_ulong::from(self.0)

maybe, a C unsigned long should always be able to hold the whole `Attr`
and a lossly casting is what this function does.

>      }
>  
>      /// Check whether `flags` is contained in `self`.
[...]
> @@ -70,19 +70,19 @@ pub fn maxsize(&self) -> usize {
>  ///     unsafe fn new(paddr: usize) -> Result<Self>{
>  ///         // SAFETY: By the safety requirements of this function [`paddr`, `paddr` + `SIZE`) is
>  ///         // valid for `ioremap`.
> -///         let addr = unsafe { bindings::ioremap(paddr as _, SIZE as _) };
> +///         let addr = unsafe { bindings::ioremap(paddr as bindings::phys_addr_t, SIZE) };

Similarly:

///         let addr = unsafe { bindings::ioremap(paddr.into(), SIZE) };

or `from()`.

>  ///         if addr.is_null() {
>  ///             return Err(ENOMEM);
>  ///         }
>  ///
> -///         Ok(IoMem(IoRaw::new(addr as _, SIZE)?))
> +///         Ok(IoMem(IoRaw::new(addr as usize, SIZE)?))
>  ///     }
>  /// }
>  ///
>  /// impl<const SIZE: usize> Drop for IoMem<SIZE> {
>  ///     fn drop(&mut self) {
>  ///         // SAFETY: `self.0.addr()` is guaranteed to be properly mapped by `Self::new`.
> -///         unsafe { bindings::iounmap(self.0.addr() as _); };
> +///         unsafe { bindings::iounmap(self.0.addr() as *mut c_void); };
>  ///     }
>  /// }
>  ///
[...]

The rest looks good to me. Thanks!

Regards,
Boqun

