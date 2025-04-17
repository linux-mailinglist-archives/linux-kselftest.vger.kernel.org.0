Return-Path: <linux-kselftest+bounces-31076-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53FD4A9238D
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 19:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6430D4641DC
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 17:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A29254AEC;
	Thu, 17 Apr 2025 17:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPkwScwO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928EB186E2E;
	Thu, 17 Apr 2025 17:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744909983; cv=none; b=S/x3kPBccJi8d/lKAr6RHT6JaDRE4zC/ok5nC/rNVnCTg8gXPJOC18nbWf2BROl2g4dSZJtXj/EcVQN+ctj+5e+rSP142OninT7zzgsq+H7pjhMJCKyNfCFwUfYma/8euvDqg9fvNwAqHIovvdJ5CXhxfC5mTZoOUMR3eNi+C9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744909983; c=relaxed/simple;
	bh=ze9golB+JCYX8yboRtMyVbur9ZOh65QOaNLGoUZZC00=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F5XDOEqyKA9zZjtByn6eYcjGTdwRJL2Hbo9bUGz1LafAgIW4XF8WAnvvX5WSIyI+wrcBHCbn0lbrmEafxumueDyIjbR7wSbTBWJatUDvAO/9Qe+2MhPX3XIcf2mHfXlFDTgbNHSkxNL8WT7IZCrDaIb6H8PDnxa6CUqvezjCT1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hPkwScwO; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c55b53a459so94881885a.3;
        Thu, 17 Apr 2025 10:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744909979; x=1745514779; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MalP9T0FOVBPSQ7hdLh//NHSp0ARkV8JPukt1uR1PUg=;
        b=hPkwScwO/l1zPn+l0S5MZSdQqT+CKPECSQxw0HBAXCUSYfsKuBjHP9sTDSZNWFOZQD
         8ATfafQYy4XOsvODr2ItrLRLSGcqZ3pUFZjUbwynFyqhTX4XyhwoJlxJ3G516Ei6ZkjA
         GmBwi5kPtME5SktnT2/Qmoa7ZuWUZ1kQX9EBxbn20uiuYgZ8aENZ6C3zcZmGVqpcwGQv
         0BCfxb+1sgsLsr59dOMEcDisVK2JAXoUA4H1P2CRdalW1t7RVb3yOqmP5252aSA/ZKvo
         +eG0nqqVhDbJ949UbvqWlPj1fr1MfLv16ycmiaj/90xW7KbzOsry3xa6Hw7BIchfAzl3
         v5yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744909979; x=1745514779;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MalP9T0FOVBPSQ7hdLh//NHSp0ARkV8JPukt1uR1PUg=;
        b=dYbDfiz6IEzkFj4dFkTulqIbnzpe2rP/bVKzPmncvkyDIIUO5sLWyeeZRux26Zgaf8
         2xS4O1k6ubdEAhx5DYXAMpgOcvtSheQwgqTWRzp5cZPoGgQG7ots/gVmkU16C+0h8hTJ
         BWV9rSvrWg/08YHDYDGQfZ6BWwOINKw/7vzZz4GoZQbatBGGs9PkuXykf/A4w9cp8tRl
         A/Jz19xnevRj4yg1qk2mPVOBcr69eJD4a8RDfVJM1VJTBWCNtN8DwKvxSAh0v+cJnU3a
         txCgWJE1bJ+B5L3lf/S2sg6YSwUdbuPiTdq+aQDMxAOcOam15TTIJ/YVCoconTPZRebO
         3RNQ==
X-Forwarded-Encrypted: i=1; AJvYcCURlaUQ1iHJ3FZ7bN170DG18aTmLjoP+Ujrla2KblC9iPSxxBOE8cmu6yyCTL7J973cOsj5VKn4rdcX@vger.kernel.org, AJvYcCWLhzHHxSqfmEMQ1QMNsMiBNGtcJyG5KVldIKV4dbguYl3SU1wqi1vfyG2qlF36gjENJj8ODMX7XdI+Q9If@vger.kernel.org, AJvYcCWcjy+Cv3ALCdc/WnIQp9I/t7sjut+JHUwWpSQ7rgntpUqaZAxeSiQC0g/hH0iZSRQfrFVSyevS@vger.kernel.org, AJvYcCWv3Hfo9qDJz1sQk6JJ/bPchFbmkF+sF9g5HOXuqw6y2ziw8DkJijWAkJ5ebIFF68VwS3BilDEG/My+@vger.kernel.org, AJvYcCX10oApNiTaOsJd+RfTUIRJmuAqUV/eWheCsKXKzm5wHDl5gkP+YLuA4BDBvfiROiGTCXdRFNmq/smR6eg39Ig=@vger.kernel.org, AJvYcCXQ+ua4vuO3NQzKLYh8wKosgnKh0GcVI9mpTXINDoYzEwRMCpZkI00bQtzlJPewURciqsvg/st1ofPohAs=@vger.kernel.org, AJvYcCXp8RHT26cYx9smXODFYnWivF99Kjz7Do/PnyDyYfe5Yw3FQ/ZmklEQWLTlKNqRnyAcDei9nYjjL4iqYlWAQo0J@vger.kernel.org, AJvYcCXzr2IE5vuUiHGoYnXqqeEpd34f4RD8kNjdHuL2b1N4gBpCIrDp5+K7P3ZeKGlLM63DHAGp+NPOD6miow7+@vger.kernel.org
X-Gm-Message-State: AOJu0YzqsDSu3w7gBNY9AFpqid1L3ChXPEpKiK08TNgV6v/Tju6raMJ/
	AhBZ+C/jesuN9y0FtT1hGsf/P0CepqyrelaUtLuei8rjcZMfgN3A
X-Gm-Gg: ASbGnct+q7Fn/ym1QR1jthycJfnW6PlhLyckxYrdrc0k69l2EfdE8skaoXnlECArhY3
	Cb/0wzyQEOpAtqqEfGYBmXgdbAJlvXCyRk+xdExZO1ttDmTDnuWb1uCBnFRZ62fYjDsZA58UNp0
	vtAg4n47wsykQPNzl+JI4HmZsuAu9X+9TnBB788l5g0eZiFSMM9BvWTSnBC/Y/3S9u4c+RJO7p0
	htNRsbKSVU060KtD/vGnwvb/NrQ/RCXCcsQtiuYvUZu3NIA39buKeQ9yTsGRLgV/VIGy5xGp75S
	yqfdwW8NraocFdMdzQ5j4SIbCZlj7fmaOpgJjK2CJQQ2kyTxYhy/TwdmIiaPDUYUETXPSPyg4Cd
	3Gx7R4ydkFfWMnpDsteVRzv1UY+Vw1TE=
X-Google-Smtp-Source: AGHT+IE1U46a7zOOtONq+QwBpax7Ahpds1E61gFA8qmT13V9WuNjWi2ccq8I+2TPW5mk2fqOlsESrw==
X-Received: by 2002:a05:620a:2409:b0:7c5:cdb5:271b with SMTP id af79cd13be357-7c918fec2d8mr831126785a.15.1744909979301;
        Thu, 17 Apr 2025 10:12:59 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c925a8d2bfsm12902585a.28.2025.04.17.10.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 10:12:58 -0700 (PDT)
Message-ID: <6801369a.050a0220.2b2efe.0e72@mx.google.com>
X-Google-Original-Message-ID: <aAE2lwwjI9Csr7Kq@winterfell.>
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id A85251200043;
	Thu, 17 Apr 2025 13:12:57 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 17 Apr 2025 13:12:57 -0400
X-ME-Sender: <xms:mTYBaKtPCX7hTJAXfh3Cy_qkehcb4j40eAV_zC-gJRP9srDYf0yGrw>
    <xme:mTYBaPepJAsVpiQG0hAtgDrwnJZtShi6JOXMb13sfHgmD6jaupfXdsj1kd_B06aXE
    UYozOVcM-GE8TOHAQ>
X-ME-Received: <xmr:mTYBaFygZIhapB2yIA8EpcA9kTa7jOq8q2HtCt2e3PYuqyG3bdPJvIMuJB5itw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdelkeefucetufdoteggodetrf
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
X-ME-Proxy: <xmx:mTYBaFNbnly-XmcLgzboyy0blulaxf0g_gvx5OspvUJihMB5uzMr3A>
    <xmx:mTYBaK84QRzrqbAEIeK_fit7VpwxMszuiY6oBiljD6osiizhHtkHhA>
    <xmx:mTYBaNX47CQC2l341GOfs0S74VKiJamzlrjNck9b-e-ERxjmbDuOtw>
    <xmx:mTYBaDfibi2GAvOragNKXULPCEIkgES2H3JOaJeBZwW64PWC01KaMA>
    <xmx:mTYBaEeI2DwRz__Rqild4X0j7hF0LYyp_jEGBEtNDHFCuDTOSLYyo8y9>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Apr 2025 13:12:56 -0400 (EDT)
Date: Thu, 17 Apr 2025 10:12:55 -0700
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
Subject: Re: [PATCH v9 2/6] rust: enable `clippy::ptr_cast_constness` lint
References: <20250416-ptr-as-ptr-v9-0-18ec29b1b1f3@gmail.com>
 <20250416-ptr-as-ptr-v9-2-18ec29b1b1f3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416-ptr-as-ptr-v9-2-18ec29b1b1f3@gmail.com>

On Wed, Apr 16, 2025 at 01:36:06PM -0400, Tamir Duberstein wrote:
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
> ---
>  Makefile                        | 1 +
>  rust/kernel/block/mq/request.rs | 4 ++--
>  rust/kernel/dma.rs              | 2 +-
>  3 files changed, 4 insertions(+), 3 deletions(-)
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
> diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
> index f395d1a6fe48..43ecf3c2e860 100644
> --- a/rust/kernel/dma.rs
> +++ b/rust/kernel/dma.rs
> @@ -186,7 +186,7 @@ pub fn alloc_attrs(
>              dev: dev.into(),
>              dma_handle,
>              count,
> -            cpu_addr: ret.cast(),
> +            cpu_addr: ret.cast::<T>(),

Is this change necessary? The rest looks good to me.

Regards,
Boqun

>              dma_attrs,
>          })
>      }
> 
> -- 
> 2.49.0
> 

