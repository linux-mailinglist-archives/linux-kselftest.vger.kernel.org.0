Return-Path: <linux-kselftest+bounces-31072-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C1AA922FE
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 18:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A4C93ACDA2
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 16:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6891B2505C7;
	Thu, 17 Apr 2025 16:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8N2Q9Ab"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B3819DF9A;
	Thu, 17 Apr 2025 16:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744908530; cv=none; b=FQf2f4aAWgSw7mBx/lM9YkvWXpz+BuL95+6IuEcWIrnwqKZEVIDWKek67r1qFLZqQb5nFvHZwMe1su5Xf0OOUk41IcavC4Zt+0Q1CQBQdVu+IJ3h/Bz3IwG63Ke6Rv8AZqzHZgh1rP5WpGPUNjK2XT9EntIbPSCanxiGcrxhGU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744908530; c=relaxed/simple;
	bh=Oyf2h/nbUjXzaklEa9162zb07nLF2t9e4pozt3Q1l3M=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GT7AEA+NY2L8pmSy6xJEiAVVTAx3cTSj5UasvyttToGQBgJhPOKvzS60bFyuiWpLk0iPPtZUbDlIojImmtBx85AkiUAfZTn6UWufdMhoXUROXkLfAmNFhfO09DfG7OzrvgkmM06gG5NDNVxBhoN2JRmBhgbcEq5sEu8eNlGcHSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l8N2Q9Ab; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c08fc20194so190262185a.2;
        Thu, 17 Apr 2025 09:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744908527; x=1745513327; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z0pUawgfEW0CPBUqb9LoWc3jadoXhqOKMLKHi6zM6mQ=;
        b=l8N2Q9AbcT4gzSOgq48de2WSYMeOvetteRO7LwCoFozbAdNMIWd4LXtlrKPLxhmzvt
         BjAM46h+KhD+rN/9iHfs7nZ5Qh2+2JeyU7isV0+zAyD0AzRp6D98lVnbYXMa8/0I1k12
         iTW4XzJvKknRVG79Le4KHBg1J+rgIb1D3at1MmHpk444ZRoMeoA2CQujoJXAwNpmVoJN
         fyubTzSKb9OeogTQnivw6C9MK5rSMpXX8nuLsquIG6zMK2kQV+t6fkFwpEuraAcxrX0z
         V9q8EwVYG22EdA8ujlZuQBHFANy3uHK2DW8eOwSPyHzGKuIKhfWObfBz1ObCeSIFJsKk
         LdTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744908527; x=1745513327;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z0pUawgfEW0CPBUqb9LoWc3jadoXhqOKMLKHi6zM6mQ=;
        b=of6tyRnvBZwjnteMw84zd9sT2NoqOnR6a2uol6b+h164FZBNkYFJmeAsPKDZNmnIDb
         +FgU17VW+0SdKtYzb9zmwty5fZZ6tQUx/Zt07J9GPWGiK20H4bqQDybu/u7ea89uzq5e
         PsERrtdFOUdIUV+2PnVhe4ImL/NgXQfN5LvMDT9St/MIyVPuVQNZPh4Tde78RGaehFms
         6K5C6+XoEZQhq+ULFw6Ua4grGOzNM0XeTfmmukKM2GHv5J3sDVONQDhwOQi8HDRu+t7z
         PbISi474Vnu1UfxCE7ftXXnSmNIG7T61Tx6qEZDjGrHVhPhlSTbdH7PIvFcKQJRnjhO5
         Ob2g==
X-Forwarded-Encrypted: i=1; AJvYcCU9KbQNqzh+hnmy12zmJ5XEhegU1TdPrpNWMKr5fSvcZ46t2nzOIbrfrpLcut/o0HjMa9SOsECdh/Mg@vger.kernel.org, AJvYcCUrZW3brYZ9wFKQroVL6f+xzmxAMLVWlUrskgb6JGPHK1M9BtQAjvV+U380N98rjORkAEIAlc2+@vger.kernel.org, AJvYcCV01R+o4a+6sqD3gKUpx2FIS2DfmTc/cKC57rbytlHuih3/Iqx4obTqnoh2m+DvsL1Dw7KgPThRLWwo@vger.kernel.org, AJvYcCVivbcbVG1W+h06dVZp9V71TG1RQ2NRbV+L2Rsg70B85h2ZjCoRznm73NqXpVOh+65X1qPA90Iu3poqXH9b@vger.kernel.org, AJvYcCVrkZfEbLaWOv9Wrr8KSyVgQ6bX2wQNdf114T+z2YNjfxLCr8YDWUhAL5iiIKHjg4onkJ3o602L4w+z/O5E@vger.kernel.org, AJvYcCWewEoI7gT070ExiuOKTQesdYSMPcAWw/j0eeobyJHiLpvOTvsINxTOWML/SZZ4o1pFO0mQvfHodTict71lUaaq@vger.kernel.org, AJvYcCX2d+tvWHKeJ7bOGW++d06aQRzg4HK/OK1uPrcQmF0hpITf1pWwJqubdRJzEen6E0x7r4PPF0TIi8n7htc=@vger.kernel.org, AJvYcCXTKdCGeChCI0MHyXUViuV9Tq96IfqS0PGjAUX2nConaWjaHUYSgJ9duDwftNDpYzaF9qK7CjMcXP5wgRoKOdY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAnJfAOGLwmzmpC1wFYyU0qkZiWfEsAaiiOOqKh/eIppiOwMv0
	FGxg0HAhHIspji4zlJdmWBrzICTlcqBgzZhQg0vFO01k3lSy8hVT
X-Gm-Gg: ASbGncsh1W0f2ZgATRUupKzVSLmP+PF/W2bY8oAESAwLZb4er18hBtlJ/+JweAQipAf
	Fb5pniPIhf6beMgsvkp5hMQ9J441I5j8PnJM/5N3/zYpfiqOGa3DtJMrG3cvn0YRr2OMLLxB3Au
	W4ecQRv5w2ZbpsPg25FTGCL9l9NMnHo8UG9gHOBsNYzJVAFOfnqwfGD6t91nM6vAPcrGkK075Qj
	ikwDx5XXV1z/mzx9YHLSgmdFLdmSc5KBm6aqorHiyjKvxN7s/Y2zkbccawDLVv+WBcHZZaNisZr
	ecfeB0/WJGGF5HxXKuZ4QunwuGAVJZUQj/L+y6TqUHGGXP8xisieq52TX61PF/HrCT16Yz7DR8/
	1lHSsiEURr1bIjsAyx4k4HRIeXgOkHH4=
X-Google-Smtp-Source: AGHT+IFqkF5iMwBpXMvWqqewwowNgnxq9EadSO8ifpl/XPQFt56qdQuYpaKX5BT0fokVGfFcYHT2Ow==
X-Received: by 2002:a05:620a:2989:b0:7c5:9fd3:a90b with SMTP id af79cd13be357-7c91908401fmr1075906385a.47.1744908527121;
        Thu, 17 Apr 2025 09:48:47 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c925b6a3c9sm9483185a.100.2025.04.17.09.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 09:48:46 -0700 (PDT)
Message-ID: <680130ee.050a0220.393a1.0995@mx.google.com>
X-Google-Original-Message-ID: <aAEw60BILp8RZGu3@winterfell.>
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id A9F6C120007A;
	Thu, 17 Apr 2025 12:48:45 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 17 Apr 2025 12:48:45 -0400
X-ME-Sender: <xms:7TABaAH-jdZcQcOxerlipQT_koonBUeu8UgPUZegwdwik1L638QDmQ>
    <xme:7TABaJUojDtbB3jfQ4o-3Q2R_fDNYgrhWuJHAewiRPpTngh362wooPsDcL94zhnT7
    mozpsPXjlyPqLrZIQ>
X-ME-Received: <xmr:7TABaKJ93915T2vT-PypctMLcVw9jjLSz7g1t6AKiBq4H_8bF5IBtddAOIo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdeljeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnegoufhushhpvggtthffohhmrghinhculdegledmnecujfgu
    rhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcuhf
    gvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtthgv
    rhhnpeekjefgudefhfeigffghfdtheeggfdtuddvkeejleffheeufeffteetvefgfeeuje
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
X-ME-Proxy: <xmx:7TABaCF2Q9VAnNaVCci07g_j4WAk86p_F36oOLXLlogh7DgFK1zJSA>
    <xmx:7TABaGW2iiqKclwpLocPWmZdhgRRLKUSFuS0244ZHM2SViDTyRH2EA>
    <xmx:7TABaFMD8fiLH8R9nEaZAjdOOYTIpS6-51h5fwH2eAY6amkB0mci0Q>
    <xmx:7TABaN2NvASHYA-UXVAg1C8la2gbX43EpgPYcnyrOHneqkvOP2yYcQ>
    <xmx:7TABaPXBKeLtxfoZkALq6Jv5FqyuGPj49rlRazoccB9gDtT4jGK3ABXa>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Apr 2025 12:48:44 -0400 (EDT)
Date: Thu, 17 Apr 2025 09:48:43 -0700
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
Subject: Re: [PATCH v9 1/6] rust: enable `clippy::ptr_as_ptr` lint
References: <20250416-ptr-as-ptr-v9-0-18ec29b1b1f3@gmail.com>
 <20250416-ptr-as-ptr-v9-1-18ec29b1b1f3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416-ptr-as-ptr-v9-1-18ec29b1b1f3@gmail.com>

On Wed, Apr 16, 2025 at 01:36:05PM -0400, Tamir Duberstein wrote:
> In Rust 1.51.0, Clippy introduced the `ptr_as_ptr` lint [1]:
> 
> > Though `as` casts between raw pointers are not terrible,
> > `pointer::cast` is safer because it cannot accidentally change the
> > pointer's mutability, nor cast the pointer to other types like `usize`.
> 
> There are a few classes of changes required:
> - Modules generated by bindgen are marked
>   `#[allow(clippy::ptr_as_ptr)]`.
> - Inferred casts (` as _`) are replaced with `.cast()`.
> - Ascribed casts (` as *... T`) are replaced with `.cast::<T>()`.
> - Multistep casts from references (` as *const _ as *const T`) are
>   replaced with `core::ptr::from_ref(&x).cast()` with or without `::<T>`
>   according to the previous rules. The `core::ptr::from_ref` call is
>   required because `(x as *const _).cast::<T>()` results in inference
>   failure.
> - Native literal C strings are replaced with `c_str!().as_char_ptr()`.
> - `*mut *mut T as _` is replaced with `let *mut *const T = (*mut *mut
>   T)`.cast();` since pointer to pointer can be confusing.
> 
> Apply these changes and enable the lint -- no functional change
> intended.
> 
> Link: https://rust-lang.github.io/rust-clippy/master/index.html#ptr_as_ptr [1]
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

A few nits below though...

> ---
>  Makefile                               |  1 +
>  rust/bindings/lib.rs                   |  1 +
>  rust/kernel/alloc/allocator_test.rs    |  2 +-
>  rust/kernel/alloc/kvec.rs              |  4 ++--
>  rust/kernel/device.rs                  |  4 ++--
>  rust/kernel/devres.rs                  |  2 +-
>  rust/kernel/dma.rs                     |  4 ++--
>  rust/kernel/error.rs                   |  2 +-
>  rust/kernel/firmware.rs                |  3 ++-
>  rust/kernel/fs/file.rs                 |  2 +-
>  rust/kernel/kunit.rs                   | 11 +++++++----
>  rust/kernel/list/impl_list_item_mod.rs |  2 +-
>  rust/kernel/pci.rs                     |  2 +-
>  rust/kernel/platform.rs                |  4 +++-
>  rust/kernel/print.rs                   |  6 +++---
>  rust/kernel/seq_file.rs                |  2 +-
>  rust/kernel/str.rs                     |  2 +-
>  rust/kernel/sync/poll.rs               |  2 +-
>  rust/kernel/time/hrtimer/pin.rs        |  2 +-
>  rust/kernel/time/hrtimer/pin_mut.rs    |  2 +-
>  rust/kernel/workqueue.rs               | 10 +++++-----
>  rust/uapi/lib.rs                       |  1 +
>  22 files changed, 40 insertions(+), 31 deletions(-)
> 
[...]
> diff --git a/rust/kernel/list/impl_list_item_mod.rs b/rust/kernel/list/impl_list_item_mod.rs
> index a0438537cee1..1f9498c1458f 100644
> --- a/rust/kernel/list/impl_list_item_mod.rs
> +++ b/rust/kernel/list/impl_list_item_mod.rs
> @@ -34,7 +34,7 @@ pub unsafe trait HasListLinks<const ID: u64 = 0> {
>      unsafe fn raw_get_list_links(ptr: *mut Self) -> *mut ListLinks<ID> {
>          // SAFETY: The caller promises that the pointer is valid. The implementer promises that the
>          // `OFFSET` constant is correct.
> -        unsafe { (ptr as *mut u8).add(Self::OFFSET) as *mut ListLinks<ID> }
> +        unsafe { ptr.cast::<u8>().add(Self::OFFSET).cast() }

I think we better do:

	unsafe { ptr.byte_add(Self::OFFSET).cast() }

here, similar for a few instances below. Maybe in a follow-up patch?
byte_add() is way more clear about what is done here.

Regards,
Boqun

>      }
>  }
>  
[...]
> @@ -457,7 +457,7 @@ fn get_work_offset(&self) -> usize {
>      #[inline]
>      unsafe fn raw_get_work(ptr: *mut Self) -> *mut Work<T, ID> {
>          // SAFETY: The caller promises that the pointer is valid.
> -        unsafe { (ptr as *mut u8).add(Self::OFFSET) as *mut Work<T, ID> }
> +        unsafe { ptr.cast::<u8>().add(Self::OFFSET).cast::<Work<T, ID>>() }
>      }
>  
>      /// Returns a pointer to the struct containing the [`Work<T, ID>`] field.
> @@ -472,7 +472,7 @@ unsafe fn work_container_of(ptr: *mut Work<T, ID>) -> *mut Self
>      {
>          // SAFETY: The caller promises that the pointer points at a field of the right type in the
>          // right kind of struct.
> -        unsafe { (ptr as *mut u8).sub(Self::OFFSET) as *mut Self }
> +        unsafe { ptr.cast::<u8>().sub(Self::OFFSET).cast::<Self>() }
>      }
>  }
>  
[...]

