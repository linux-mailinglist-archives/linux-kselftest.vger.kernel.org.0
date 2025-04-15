Return-Path: <linux-kselftest+bounces-30888-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C0DA8A5CD
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 19:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03A31188503F
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 17:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C1B21D3D4;
	Tue, 15 Apr 2025 17:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VethYs+n"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBD82260C;
	Tue, 15 Apr 2025 17:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744738680; cv=none; b=hVwY2+t+4C7paNPUV/psejhdP3r9W5NIAuG2kgjtsYqKBPU8V/gIqI4zdNyOFixnvk5NKExo72EjL557+hXoLWnmH95U9HoG9kpsyjChglZCZnmVyG9sim2XB+4oN4OZYOJxc/nfzRl/IIr3ID54GhGdS1iBZ4x4jq/Z+HWzPCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744738680; c=relaxed/simple;
	bh=EBeQYN1OF+DyF4pYIIBvE7N5Zbe5MAjDz3As9Rga+To=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W+LuqyWk7SzCKFRSh5+Y1klDDvfCd33Aa0uDkL88Wc3dp5lGNs9hS6TUi0G5/ahrQt2kRXZziEs5Zz+PnD7OQj3MX2UkMvGRk0crTmjBM8s3fO478Pm+hMshgn5XQ3OXfGejYGbnPDjxF4yBWrD0gR7o6bYWceARhImw6WHf2yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VethYs+n; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4774193fdffso83069791cf.1;
        Tue, 15 Apr 2025 10:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744738678; x=1745343478; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5I/lbzcnm7y9bOrI6tkPsLfvdAUJfIdrSK0G3vlKUTk=;
        b=VethYs+nVrZLv1TN4UIaZJuNqbkGDaLJJeRaS+BIhFk1wB0KV4zcOJh4jQoppZwQ6p
         /ga7IAENt40btC5cf4G3nmY98zU+0bSCorGMWI8pHOR74P1WKfxmJWDlQDa8L0zAhZYQ
         rA8i10FKL1qtP5Ls/5DwFexR+f2Pd/WLVTw4sKVzzJ4XBavlbQ7QbAYoqy2h8HYJjTuy
         iZaPZo+ttxTgJwWfgDBL6aoXsPyhjcuglT3A9EieEDVcHoJmMjBln2t5jC98uB/T7pEj
         6lLZJjFuZhnZYyKBSyy4x2E85RTFmrepzIEwTrHWFwavvo4oALq1p+2PjxF5j6ceEGJw
         ZoCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744738678; x=1745343478;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5I/lbzcnm7y9bOrI6tkPsLfvdAUJfIdrSK0G3vlKUTk=;
        b=IEdviS6Hb8f7ttJC45Fo57ZV1wQ4K//VFtgdCjX9ZP6ybJJRD+4D5tgiQje86mF1Qh
         3Ppr9mq9tBmkQHsUHJO3PbftuEuY9p7LT+O8/9SffotWry/qnUCYW3sMxJJlMFS9lzUf
         h1yZgLe0iCHhbrZ8ejrGjXT9siokCL21N6rtjnd5fs4uRoTw4kxBgnNZ1Z31vdwSbq3Y
         Azuz+PK5ZxFqIzRtKR8WaIqPj0S4YY+DKoNIt69g0JZJgaRd8LQhY92ZQAJ7XgjckESZ
         Nyh5y6tSCORhyFb3exG1MdalB6tUNs6T/QyKZDkkSrX+WU9DJ7+qGFUIXsHCK4+eXi0d
         CXTA==
X-Forwarded-Encrypted: i=1; AJvYcCUbimKxaI/OmER4/5hCkupsKGabJbtnfRSXlqPsRoDLod2ndYfoUvAkf62cSjEZjZqmYVB2i+XCCNBGg/HX@vger.kernel.org, AJvYcCV1+ghlopsa2X7ocn0q3XVtNN+nF+wHxpsP5p5yt081tQKx13RmKaHjSS9bvEyZ1opanuGRZOWjAhd9IdJx@vger.kernel.org, AJvYcCVHfcTlrjbUFY4jgp69DPBZxOwb+8Hda9oyjyKrDEkA9iTcy4MQTS0E/Y3ZhKUAqJElRiegRkXQ@vger.kernel.org, AJvYcCVg21cyB0zT6FCKYIhhPZl8b4oLjnJ0HnPBPEAlb4lU+s3wDbdsIjaqAZ/DCJqNu6+yUeLZOiEtLSct@vger.kernel.org, AJvYcCVq5KtCsFyRSZSJUS2nzQwZXrzrcIFem2Dqcek+ol512Lvkw9C4BcnrueMnDzrVG7Tfpkz+9jBYc3cs@vger.kernel.org, AJvYcCX4QcAktIAGHUpcMU8DNT2WWFvcZsx7XuWR1zKgQKCH+dGtBBfiM682LPmO8qqh4gkxFTjTU3gQTSQiU0c=@vger.kernel.org, AJvYcCXF/8UV1Oo+2qyRzbUEKIHcl4bE3fV845Zqpz85KsR+Zr1/0NhWjciKxsC+xsL/9WELrA4Mis9BH4udhloEpSc=@vger.kernel.org, AJvYcCXTHD9NTHN48hBQmfPKjyuDQ1J9LkkY+he8mUDhnmcKMZTN+HoR7JjzRI5jVK0hUoa1rI4bd8EZMnTKsjMxZ031@vger.kernel.org
X-Gm-Message-State: AOJu0YzoCi0rNDEoPt3YD4IyD1h9ZosfUQyoBllvO4TI9rnCLffaf7/7
	qvCEIpFT6pPvGmPxJiUypkJ99Hxc3lpSgZBdc754lLYXX5sFWLzb
X-Gm-Gg: ASbGncuWTV/v13dN3wUZ6H4UzJzcG34yzKXLt3lv5Nfw9nJBbwVgvZig0jv1OQUaf4G
	xUrRiXPtWC1igWu/9Lt5ou9RKgF6oR4N83n8ZKvPxvhxlnRnXhkpf49MHErob14A5jSDDTnoKYn
	iVhCbNZ6ClbcfEMJhAPaUl69g1WrNoiA9nCOeca8c1evRWdAUM9DWFnCMtyZyIkoRVW3HRWnKjJ
	tTJRCGd+kgAyJMwhLjrbwdVL7bMOUQzUg2aLKyXlzPTSS0fgzr9fqn7hEsofXY28wBUC6c/QxnN
	+SnpFs9ppgahM+J3MWl1/6MBSj1TSyJbCiOxd3glLDt1Ewiaj+BA2HouY28E76dzKDxUTXS2sIM
	VzvtzigSRDGgp/SuwIaQMDH04F9l+Iqxee6qiVdQRuQ==
X-Google-Smtp-Source: AGHT+IGkR8MSbX5xmugHqgBYEQDFUEijTd9yxoH0ceFRvcd1irCEct2C7eXZLGwLos15lMXOiuq9mw==
X-Received: by 2002:ac8:7d8b:0:b0:476:74de:81e2 with SMTP id d75a77b69052e-47ad3af4b38mr2813661cf.43.1744738677912;
        Tue, 15 Apr 2025 10:37:57 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4796eb0b7f2sm95519271cf.12.2025.04.15.10.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 10:37:57 -0700 (PDT)
Message-ID: <67fe9975.c80a0220.1b5785.66e7@mx.google.com>
X-Google-Original-Message-ID: <Z_6ZcfB0epuBDEL_@winterfell.>
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 0150E1200043;
	Tue, 15 Apr 2025 13:37:56 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 15 Apr 2025 13:37:56 -0400
X-ME-Sender: <xms:c5n-Z9mKgZeE_ojYElwvYM3xxvpeBaIhYxw0RP6QdYoeRumuqXnZaw>
    <xme:c5n-Z40w6VrFakDAW2vGECHF9A_fLFnaSSvqn-Hwf1feWmUNfJVZf0k-dIVgsQqBo
    icLyJQUInpjmyhefQ>
X-ME-Received: <xmr:c5n-ZzqyRDZlfKrBN5iuXlXwfkKB4XNghEqZv3rWH5aQk-Y6jmyNz6Wj2myj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdegudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnegoufhushhpvggtthffohhmrghinhculdegledmnecujfgu
    rhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcuhf
    gvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtthgv
    rhhnpeehiefhkeeivdeuudfgudelgeduheeijeelvdeigfefudekhfehtdfhkeeukefhtd
    enucffohhmrghinhepghhithhhuhgsrdhiohdpkhgvrhhnvghlrdhorhhgpdhiughsrdgr
    shenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvgdpnhgspghrtghpthhtohepgeejpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehtrghmihhrugesghhmrghilhdrtghomhdprhgtphhtthhopehmrghsrghhih
    hrohihsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehnrghthhgrnheskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eprghlvgigrdhgrgihnhhorhesghhmrghilhdrtghomhdprhgtphhtthhopehgrghrhies
    ghgrrhihghhuohdrnhgvthdprhgtphhtthhopegsjhhorhhnfegpghhhsehprhhothhonh
    hmrghilhdrtghomhdprhgtphhtthhopegsvghnnhhordhlohhsshhinhesphhrohhtohhn
    rdhmvgdprhgtphhtthhopegrrdhhihhnuggsohhrgheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:c5n-Z9lqu7HXkmBmjQV8J66e7kuHBLMx_S9deoFCeJIInWPVm_9Jww>
    <xmx:c5n-Z704G_kHJrippeHYtHE3t7nXu0n76dttxp7gn6EcVbkb3481SQ>
    <xmx:c5n-Z8uSszo9xSCC36DLm-KbAlklJGImdUxYbJV7ewgn-wGF_-9yKg>
    <xmx:c5n-Z_VzGST7EmORzHRxIu-QGsRH7tkd4B-9Tcid439OsBqOYhcMoQ>
    <xmx:c5n-Zy1KkaH-nHxBE-qSlCchlhFgCOpOJ9atxzowhjD6zPbJ_9rvNDOV>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Apr 2025 13:37:55 -0400 (EDT)
Date: Tue, 15 Apr 2025 10:37:53 -0700
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
Subject: Re: [PATCH v8 6/6] rust: enable `clippy::ref_as_ptr` lint
References: <20250409-ptr-as-ptr-v8-0-3738061534ef@gmail.com>
 <20250409-ptr-as-ptr-v8-6-3738061534ef@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409-ptr-as-ptr-v8-6-3738061534ef@gmail.com>

On Wed, Apr 09, 2025 at 10:47:23AM -0400, Tamir Duberstein wrote:
> In Rust 1.78.0, Clippy introduced the `ref_as_ptr` lint [1]:
> 
> > Using `as` casts may result in silently changing mutability or type.
> 
> While this doesn't eliminate unchecked `as` conversions, it makes such
> conversions easier to scrutinize.  It also has the slight benefit of
> removing a degree of freedom on which to bikeshed. Thus apply the
> changes and enable the lint -- no functional change intended.
> 
> Link: https://rust-lang.github.io/rust-clippy/master/index.html#ref_as_ptr [1]
> Suggested-by: Benno Lossin <benno.lossin@proton.me>
> Link: https://lore.kernel.org/all/D8PGG7NTWB6U.3SS3A5LN4XWMN@proton.me/
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
>  Makefile                 |  1 +
>  rust/bindings/lib.rs     |  1 +
>  rust/kernel/device_id.rs |  3 ++-
>  rust/kernel/fs/file.rs   |  3 ++-
>  rust/kernel/str.rs       |  6 ++++--
>  rust/kernel/uaccess.rs   | 10 ++++------
>  rust/uapi/lib.rs         |  1 +
>  7 files changed, 15 insertions(+), 10 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index eb5a942241a2..2a16e02f26db 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -485,6 +485,7 @@ export rust_common_flags := --edition=2021 \
>  			    -Wclippy::no_mangle_with_rust_abi \
>  			    -Wclippy::ptr_as_ptr \
>  			    -Wclippy::ptr_cast_constness \
> +			    -Wclippy::ref_as_ptr \
>  			    -Wclippy::undocumented_unsafe_blocks \
>  			    -Wclippy::unnecessary_safety_comment \
>  			    -Wclippy::unnecessary_safety_doc \
> diff --git a/rust/bindings/lib.rs b/rust/bindings/lib.rs
> index b105a0d899cc..2b69016070c6 100644
> --- a/rust/bindings/lib.rs
> +++ b/rust/bindings/lib.rs
> @@ -27,6 +27,7 @@
>  #[allow(dead_code)]
>  #[allow(clippy::cast_lossless)]
>  #[allow(clippy::ptr_as_ptr)]
> +#[allow(clippy::ref_as_ptr)]
>  #[allow(clippy::undocumented_unsafe_blocks)]
>  mod bindings_raw {
>      // Manual definition for blocklisted types.
> diff --git a/rust/kernel/device_id.rs b/rust/kernel/device_id.rs
> index 4063f09d76d9..37cc03d1df4c 100644
> --- a/rust/kernel/device_id.rs
> +++ b/rust/kernel/device_id.rs
> @@ -136,7 +136,8 @@ impl<T: RawDeviceId, U, const N: usize> IdTable<T, U> for IdArray<T, U, N> {
>      fn as_ptr(&self) -> *const T::RawType {
>          // This cannot be `self.ids.as_ptr()`, as the return pointer must have correct provenance
>          // to access the sentinel.
> -        (self as *const Self).cast()
> +        let this: *const Self = self;

Hmm.. so this lint usually just requires to use a let statement instead
of as expression when casting a reference to a pointer? Not 100%
convinced this results into better code TBH..

> +        this.cast()
>      }
>  
>      fn id(&self, index: usize) -> &T::RawType {
> diff --git a/rust/kernel/fs/file.rs b/rust/kernel/fs/file.rs
> index 791f493ada10..559a4bfa123f 100644
> --- a/rust/kernel/fs/file.rs
> +++ b/rust/kernel/fs/file.rs
> @@ -359,12 +359,13 @@ impl core::ops::Deref for File {
>      type Target = LocalFile;
>      #[inline]
>      fn deref(&self) -> &LocalFile {
> +        let this: *const Self = self;
>          // SAFETY: The caller provides a `&File`, and since it is a reference, it must point at a
>          // valid file for the desired duration.
>          //
>          // By the type invariants, there are no `fdget_pos` calls that did not take the
>          // `f_pos_lock` mutex.
> -        unsafe { LocalFile::from_raw_file((self as *const Self).cast()) }
> +        unsafe { LocalFile::from_raw_file(this.cast()) }
>      }
>  }
>  
> diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> index 40034f77fc2f..75b4a18c67c4 100644
> --- a/rust/kernel/str.rs
> +++ b/rust/kernel/str.rs
> @@ -28,8 +28,9 @@ pub const fn is_empty(&self) -> bool {
>      /// Creates a [`BStr`] from a `[u8]`.
>      #[inline]
>      pub const fn from_bytes(bytes: &[u8]) -> &Self {
> +        let bytes: *const [u8] = bytes;
>          // SAFETY: `BStr` is transparent to `[u8]`.
> -        unsafe { &*(bytes as *const [u8] as *const BStr) }
> +        unsafe { &*(bytes as *const BStr) }

	unsafe { &*(bytes.cast::<BStr>()) }

? I'm curious why this dodged the other lint (ptr_as_ptr).

>      }
>  
>      /// Strip a prefix from `self`. Delegates to [`slice::strip_prefix`].
> @@ -289,8 +290,9 @@ pub const fn from_bytes_with_nul(bytes: &[u8]) -> Result<&Self, CStrConvertError
>      /// `NUL` byte (or the string will be truncated).
>      #[inline]
>      pub unsafe fn from_bytes_with_nul_unchecked_mut(bytes: &mut [u8]) -> &mut CStr {
> +        let bytes: *mut [u8] = bytes;
>          // SAFETY: Properties of `bytes` guaranteed by the safety precondition.
> -        unsafe { &mut *(bytes as *mut [u8] as *mut CStr) }
> +        unsafe { &mut *(bytes as *mut CStr) }

Ditto.

>      }
>  
>      /// Returns a C pointer to the string.
> diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
> index 80a9782b1c6e..7a6fc78fc314 100644
> --- a/rust/kernel/uaccess.rs
> +++ b/rust/kernel/uaccess.rs
> @@ -240,9 +240,10 @@ pub fn read_raw(&mut self, out: &mut [MaybeUninit<u8>]) -> Result {
>      /// Fails with [`EFAULT`] if the read happens on a bad address, or if the read goes out of
>      /// bounds of this [`UserSliceReader`]. This call may modify `out` even if it returns an error.
>      pub fn read_slice(&mut self, out: &mut [u8]) -> Result {
> +        let out: *mut [u8] = out;
>          // SAFETY: The types are compatible and `read_raw` doesn't write uninitialized bytes to
>          // `out`.
> -        let out = unsafe { &mut *(out as *mut [u8] as *mut [MaybeUninit<u8>]) };
> +        let out = unsafe { &mut *(out as *mut [MaybeUninit<u8>]) };

Ditto.

Regards,
Boqun

>          self.read_raw(out)
>      }
>  
> @@ -348,6 +349,7 @@ pub fn write<T: AsBytes>(&mut self, value: &T) -> Result {
>          if len > self.length {
>              return Err(EFAULT);
>          }
> +        let value: *const T = value;
>          // SAFETY: The reference points to a value of type `T`, so it is valid for reading
>          // `size_of::<T>()` bytes.
>          //
> @@ -355,11 +357,7 @@ pub fn write<T: AsBytes>(&mut self, value: &T) -> Result {
>          // kernel pointer. This mirrors the logic on the C side that skips the check when the length
>          // is a compile-time constant.
>          let res = unsafe {
> -            bindings::_copy_to_user(
> -                self.ptr as *mut c_void,
> -                (value as *const T).cast::<c_void>(),
> -                len,
> -            )
> +            bindings::_copy_to_user(self.ptr as *mut c_void, value.cast::<c_void>(), len)
>          };
>          if res != 0 {
>              return Err(EFAULT);
> diff --git a/rust/uapi/lib.rs b/rust/uapi/lib.rs
> index d5dab4dfabec..6230ba48201d 100644
> --- a/rust/uapi/lib.rs
> +++ b/rust/uapi/lib.rs
> @@ -16,6 +16,7 @@
>      clippy::all,
>      clippy::cast_lossless,
>      clippy::ptr_as_ptr,
> +    clippy::ref_as_ptr,
>      clippy::undocumented_unsafe_blocks,
>      dead_code,
>      missing_docs,
> 
> -- 
> 2.49.0
> 
> 

