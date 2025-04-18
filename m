Return-Path: <linux-kselftest+bounces-31151-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6426DA93B48
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 18:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E042D19E7C8D
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 16:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E28321506D;
	Fri, 18 Apr 2025 16:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lrrrf0MS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D982CCC0;
	Fri, 18 Apr 2025 16:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744995005; cv=none; b=AMebPMYyOQpvol+QKsgjI5TquNyyjO8a52Rp2jWXCrlvy3CAqmrUITMksVqmT2kPuBQ7MlBIJoTWA6pgf1rpi70+cb7igu33SMjWwadkWh9gRdMDdNqGwQXTnOgLR869cEdDkHXICNmZYhPgyn+yjxLAO9tqj7HWzgpmU56oFnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744995005; c=relaxed/simple;
	bh=4SPvBV/MDlxiR5aX8tf3sSjbLn91cuUdLEqO9PVmDQk=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KGR59Nl5nJCmndkJT8jLFhj0bZGIUxJFxpfEznU0gkQ4hFAapOb6tkMbQPeXovQm1k9pkNlo+CK+yW6H046uI64pBz/E6pE+ILrcm+OsehbMKtQs55yDFRc6dAmQLNlCnQMKGgHw428FZoPQPKpHANF+6ewD7ZOk5oqRVDB5/Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lrrrf0MS; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c5e39d1db2so106419285a.3;
        Fri, 18 Apr 2025 09:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744995002; x=1745599802; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wqsq8yPJja9MfMcD3tAjoUAZlgKfMc3FNlCDKzyz/mQ=;
        b=lrrrf0MSCUXxj/r/YYaM1WogRuDOimZmPrWclmn8ZFQJvmeyewiIfT7eHJ9zgO7Hmq
         ZHN28gufvNIPoESOKuvJCgb4TjFHsdOhk9MJAdNPSM2HrNCpjhEdu0KsYdDtG7Wgvrkf
         4jOA/eE9J2D5FiTVYl6P27rJfdhYW7h0GZzsKhe5mYL8eEsULn+h0luMu61sPKUttKcO
         tegNKf63mP80s4RRiyB1SBb56kBYC2IpmGxv8134vjRCVLVc3bNNZ3p/7eAWTMqkNQEP
         xZ7qxaXLcEKdwXi6GruI7lTDKPG0OIQelCtA2xJoEhDk0pLmDigBVqTfGZsSBvetm5f1
         KqRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744995002; x=1745599802;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wqsq8yPJja9MfMcD3tAjoUAZlgKfMc3FNlCDKzyz/mQ=;
        b=K7N4+5Vt4wRCfmSPtFkoNPs63xxQY0YkS71Tdr9PhaIyEZ0OlXgLI5T9RxUk4pF4Xc
         C07SEYuHT4x/glucZoWVswVFon80iIZatlyZupVHr1sOKWCvfoQdgIWCwVVaaWZ7HPA/
         WOGkGX0Zhiusbfad6NIULHtyAxvqB88NES7IzRNjEiLCv+kfD2TXUQRAW5kY9YbvT4RS
         wu/ad4b2G4eVpiccRrVqAzu86vLdFL1aIB2bLkMMxZVm7qCh25I3SYnHsBHqIa3yHa7n
         12NAvAUnlTfLWEZ4BuBEa0So26IM1YD8YkYl1V+KuvKsHEr/L1BXG7BBpi8tCsUimJfX
         Adkw==
X-Forwarded-Encrypted: i=1; AJvYcCW2og31Z+WeCdSo8wfv3D5vgJ83JOxt8cwP4kJPknMIsbD4RkZngXdD+Eje38/cU3+FCF79lj3wkJe/IF+ygjQI@vger.kernel.org, AJvYcCW3y2XAb0ivOt7Uqgmu/+fHIhm7iYd6rdUMmD7V5FCJAOKBRdGteZvgoNY42fcWhKIFj/NInU5SeY/gnEes@vger.kernel.org, AJvYcCWDJZI4EZyJLAj473r0JLjitMAr6oihTMUyqWndGMwPr22J3eRUitNgI/+IjehofMDmRfrLJnbu2mJK7y8gR7c=@vger.kernel.org, AJvYcCWLgF/OAO37VKGEyB3dQDYXLZuDbgRZVVvDtdqmsbUbZEqxL99ZEMENvWFEXBPq9sOHnLA1LQEBInWqrtei@vger.kernel.org, AJvYcCWNr1q5lbQj75hg2WkpZewcoU9fkILDCcEsDSVOZi/L8q8X8ll6pqmuiSBvcppaa8yl0gPgEM8GPfKU@vger.kernel.org, AJvYcCXOBnvcn67falgpbTxxH7KDvacVAc3L+qJcP60NodFIiBg9dwVUKg882cwgIMQt5onqmbV2POzq9Qz7df8=@vger.kernel.org, AJvYcCXQbeL0QffPNJ+Inpel/2qRIIZHpaozwD8iSprQE0NdcsS0rYz6tLEPUpQi18wHbeABKUXw31w/@vger.kernel.org, AJvYcCXRoASaZD/WPF7wEjZvDLSHhzlUBwEwkx4wNJ5T5NiSA2hjZmj1pcVfe9V0VQtD3f/B+VMjJAsIilJE@vger.kernel.org
X-Gm-Message-State: AOJu0Yy02AA3biaQOt3ajCn3eXkdhSK1D79qeNRR61vK98Sm6ndSPea+
	lsw968H3Y9HU1naP6VsI020AI8Ap6JVud0ekCgBtoxgN6kH9Mmne
X-Gm-Gg: ASbGncvejsFRtG7wuaE1/WrnJswWacjnAwgXLmAIx9zf8bS726ppbk2bt9bGT59K41m
	XTmRGGi+4t2l91gCD0/BVLB4zRLra3jyXv4o/c1Syc0sWVMV55ZOmVd02UY3sQFVOrAgDodPQ1e
	dAGXQQUv8yVMFsUZxwYm8vZm93ISjvHtiiw5Baw9rfXh5nPmJ/IOUja2Bh9wT843nvPionC9ot4
	oZqOMqrrIARgCCHCMUK4KKqlolaN6Q1zrFpS/KhTMnLHQalYaUOU4Tyl+oRp+fx3ZYgZE54G4bP
	wk6E8cy9sCz+S8H7dZOUAAWiSIKQiorDwDiyy1Jtcls1Qz82dC5LeQPGYP21/2owvi2yfyZaXMS
	mNNfgjyetk66qCq6fLedGb7t0xUBJCsAuAffSPI/jyw==
X-Google-Smtp-Source: AGHT+IGjqTF4f9smmVkb3wgWaIXUFVJ5bhyDcAmk4QFxgPcVtKxPUq6oNVaI94PfU1W5J6bp6Dym2A==
X-Received: by 2002:a05:620a:4112:b0:7c5:9b93:8f64 with SMTP id af79cd13be357-7c92800f4ccmr542294585a.37.1744995001792;
        Fri, 18 Apr 2025 09:50:01 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c925ac5018sm124259085a.52.2025.04.18.09.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 09:50:01 -0700 (PDT)
Message-ID: <680282b9.050a0220.3b746a.5cf9@mx.google.com>
X-Google-Original-Message-ID: <aAKCtQe8o73FA8db@winterfell.>
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 0E13C1200043;
	Fri, 18 Apr 2025 12:50:00 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 18 Apr 2025 12:50:00 -0400
X-ME-Sender: <xms:t4ICaPrgLkWEbH6GWhTGPaFLVQbWrWOHlfTfkbUonj_YAvDMD-KU1Q>
    <xme:t4ICaJqChA3dlMw71yhy8csoqqK5Y4iLQ0Z62MWQRL5LWGE5fFQMMMJHqxl4-Vp_7
    SP1XzVYBXxDcpDtJg>
X-ME-Received: <xmr:t4ICaMNPGrgxWdPMVCQLF2Mu2gBYuu6YOb47AYWzWqRWmLPK1aR1dgLJ-C0K0Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfedvieejucetufdoteggodetrf
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
X-ME-Proxy: <xmx:t4ICaC6UhO1CZnKjR6Ik-hzIl3GtGbvNVc1I-IDE4qls3LYxm5xgUQ>
    <xmx:t4ICaO4vQPmAJgA9EQ9e4E1UXeaGRebhXTNU3grxc_kkgAjUxFqXfg>
    <xmx:t4ICaKjYst-8W_IjfguRa7uGthyObF8qia3gL-YVcCE_LCjZovMezA>
    <xmx:t4ICaA7BSsupuce3_SqR3OsmGrEA4G9TNiV4jY5WZn2qvcS_4fm5JQ>
    <xmx:uIICaNKT393DPp0R4GPwnosQuFP000EMpmjxlybcE0RtxwLUKggyEoYo>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Apr 2025 12:49:59 -0400 (EDT)
Date: Fri, 18 Apr 2025 09:49:57 -0700
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
Subject: Re: [PATCH v10 2/6] rust: enable `clippy::ptr_cast_constness` lint
References: <20250418-ptr-as-ptr-v10-0-3d63d27907aa@gmail.com>
 <20250418-ptr-as-ptr-v10-2-3d63d27907aa@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250418-ptr-as-ptr-v10-2-3d63d27907aa@gmail.com>

On Fri, Apr 18, 2025 at 11:37:18AM -0400, Tamir Duberstein wrote:
> In Rust 1.72.0, Clippy introduced the `ptr_cast_constness` lint [1]:
> 
> > Though `as` casts between raw pointers are not terrible,
> > `pointer::cast_mut` and `pointer::cast_const` are safer because they
> > cannot accidentally cast the pointer to another type.
> 
> There are only 2 affected sites:
> - `*mut T as *const U as *mut U` becomes `(*mut T).cast()`
> - `&self as *const Self as *mut Self` becomes
>   `core::ptr::from_ref(self).cast_mut()`.
> 
> Apply these changes and enable the lint -- no functional change
> intended.
> 
> Link: https://rust-lang.github.io/rust-clippy/master/index.html#ptr_cast_constness [1]
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> ---
>  Makefile                        | 1 +
>  rust/kernel/block/mq/request.rs | 4 ++--
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 5d2931344490..7b85b2a8d371 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -481,6 +481,7 @@ export rust_common_flags := --edition=2021 \
>  			    -Aclippy::needless_lifetimes \
>  			    -Wclippy::no_mangle_with_rust_abi \
>  			    -Wclippy::ptr_as_ptr \
> +			    -Wclippy::ptr_cast_constness \
>  			    -Wclippy::undocumented_unsafe_blocks \
>  			    -Wclippy::unnecessary_safety_comment \
>  			    -Wclippy::unnecessary_safety_doc \
> diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/request.rs
> index 4a5b7ec914ef..af5c9ac94f36 100644
> --- a/rust/kernel/block/mq/request.rs
> +++ b/rust/kernel/block/mq/request.rs
> @@ -69,7 +69,7 @@ pub(crate) unsafe fn aref_from_raw(ptr: *mut bindings::request) -> ARef<Self> {
>          // INVARIANT: By the safety requirements of this function, invariants are upheld.
>          // SAFETY: By the safety requirement of this function, we own a
>          // reference count that we can pass to `ARef`.
> -        unsafe { ARef::from_raw(NonNull::new_unchecked(ptr as *const Self as *mut Self)) }
> +        unsafe { ARef::from_raw(NonNull::new_unchecked(ptr.cast())) }
>      }
>  
>      /// Notify the block layer that a request is going to be processed now.
> @@ -155,7 +155,7 @@ pub(crate) fn wrapper_ref(&self) -> &RequestDataWrapper {
>          // the private data associated with this request is initialized and
>          // valid. The existence of `&self` guarantees that the private data is
>          // valid as a shared reference.
> -        unsafe { Self::wrapper_ptr(self as *const Self as *mut Self).as_ref() }
> +        unsafe { Self::wrapper_ptr(core::ptr::from_ref(self).cast_mut()).as_ref() }
>      }
>  }
>  
> 
> -- 
> 2.49.0
> 

