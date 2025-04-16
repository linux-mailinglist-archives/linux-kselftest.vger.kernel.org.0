Return-Path: <linux-kselftest+bounces-30971-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C19A90A73
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 19:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9405447707
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 17:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D32B217671;
	Wed, 16 Apr 2025 17:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3gje7Fp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF7B1DDC3E;
	Wed, 16 Apr 2025 17:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744825881; cv=none; b=rkCd3LiWomg1vNSJAtKnIPEgFcZfGRd4hI6I72mngLcuR6UznM0P5L7QximXBiA9+o5C+nuX/ecwbLSVfFuaijtB7g8hcgCcHgMCrhpU64JlhZsyZYhhPF6XujThAdbeAZdDYvI0sZCK4ofZSuIicG4d4aJfpMq8zsGU3SwI0qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744825881; c=relaxed/simple;
	bh=S2b5vXlOR/jV2s/DYvLwHzBugj+8ymNEw/ohqZoIpYw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XtFbmWjuklzAk6f3w9/L1IVoWF2QrqQridV+k2p/gd7f3Tc+1B4l6BrDqxSOrx4dRwZSNz03Mfpq5vqCLv6MjdZlQReLK8c4VTdCAeFD4wrmRoWnNKzBSGF/24FwWpNzOB+Ms6NCLtVO+aVZPqpkDvod/TnirS8umtt+GTEvjU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S3gje7Fp; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c5b2472969so689870985a.1;
        Wed, 16 Apr 2025 10:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744825878; x=1745430678; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pxmabfoSz1UC2/iusFbiOKQsFJLtRsKidKPRh/82Z6c=;
        b=S3gje7Fp45X5nbryVJS+mN4S/w8nkuPQWdkI3TB7ddzXIOSVetq+1o6r4POGd6abBA
         nhkiICLNOhB7jUQcBDXojfws7MjcqG2VZQa3CldDWI3QlapGHaWbbxFV/uPThRYdXIAN
         WoSvTBP+iK8qkccfpvRhj2dQ3PJU4uD96hMphL2p2T0D9hDRKxQtZY/S3tXn60m4vs5I
         mXjcOf/NaM2RdMhy52QXHqDQMz8OWccdf5UFn4zNzAqqf06Vorjuy6U3KEYTH0SgwmU0
         X+rsg/V4FekED/slDjTBzi5yAdh0g1DfOlBqAcPtDxP2oae5Iz9tqeeZx/ZaTE4MkvOO
         snOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744825878; x=1745430678;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:feedback-id:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pxmabfoSz1UC2/iusFbiOKQsFJLtRsKidKPRh/82Z6c=;
        b=p28kB7uvMQVexOD5QCrxZUENgX5Wo0XvotZVF168yQagnhdy2WKmPAmD0JUiRDdGxv
         UYoZR+0UfHZmA8Gas4A0yAO0LT8YRubw+TsDh+yEmJxL4U4hlHxpCbdKAy3GQhjUIvPr
         Hu8BrthkGJsxP/SbWX/i+pWK5e3BAgSLaF5gjE/EY4swDZnHxBUIxL809V/dtIRPVg59
         fiHxd+PwiYCZAFhv3ix7axb11B69Iw0OOHq+o4hEBasofP/zfhNO56Yp67RjsTyWU+vC
         cpzs7qIDEz/zkFuxEDKxubudvoFLEfMSxw7/Ku3ug1UvcaJAgoIM0VHJvSxWzAZnvjv0
         VqeA==
X-Forwarded-Encrypted: i=1; AJvYcCU6FxHTEw+2mCrcuMVkFAT/14za/oUVxQw/KU2ZbMR+ZUSGwPnq1cUR4OULqpfeMzie4OUERFJ4Xhyl@vger.kernel.org, AJvYcCVFGx1Jwp+jlIRsIrJhT8HxTeXB7Uk8apaE9Nn635y2wE2ayviqOQ/H4uuZxb/aSKV/lHj9VuvlgmLlogMOz8E=@vger.kernel.org, AJvYcCVQTQSOr7CaotKgxNdWZgl6XUuMJcKnnRShBzvh5eXcowkWGULbxMw48BY90gFpNDzXvEzhwInauAJj1OMFokAB@vger.kernel.org, AJvYcCVTUgDb0GSxMTtTvhtemPan+Acw7X2iudH9q8Qp7BwlWrtmfV+l54NoNNLk3LP7VFfe9i766mULCKQn@vger.kernel.org, AJvYcCVXx/krzIou8gpmFwBBk24l9qRy1MVuLk5UGeN29GdwPlNxV6ZLS4ZIcLYNgbn4ybvZdf6pw595@vger.kernel.org, AJvYcCVayQ6zFKDohx3FnUob1y25lVNlV9LSWee+8aAVtDC/N7BY/Hm2niM+8PBxUVie8+tHRlo8yfrZZoXg95vi@vger.kernel.org, AJvYcCW6NgLamgYvR2qFXOeQqzeCQV8qSHaxsCO0tRHV2c9M3qo3oI1EI+PmCBUJb4Bp8a5cM/ElRdXDml11A7sr@vger.kernel.org, AJvYcCWwIB1yfKTwyt5FxLLX10u6eKpA6LwmtMBsyyjaBOhPoV81U1BJqFB8Bni+3QqjxN0fStPBerFL3GAb/4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZNXEuvsR2cWd+V+Ofgr/QXBBbSmc5sFzjopk1/cQYHjdqtZRV
	TJPmc8hna3wrfMp6oyjv94ytZ3qoMOBqtATnNcl5+HPE6V+tJV50
X-Gm-Gg: ASbGncuT2qydQBW6FQ/mIKZul/Qtf25zW+LbSVVOZnnpuQTcnQZsHtg5GShtb9QEFPx
	YnQ+A6uZj3+qQECcuJpLCvaTpCyLph4TX3GoPZNfwv7RthN22zj5Izr4mVk0JaFZF+FxszfyKMj
	jxOp6bzpmtw0bs493394U1niOGD5oAQ1lNb5IlbyTcsgkUTb4WHlgiunyj3GaTERX6OrSei5EMa
	tXEthhABW9c/g9plM+RwMcCytocAb9XYW2tkrjONvVGni64vgyhgDUiO4HKUHCb9gAU3TPiBsJA
	zFeM+/AV3sOwliuRtxywT/4iG4ft/Y2J029Yn4G5Aqp9SDmhnMtq5d0N7FlKtwiBNHXNTZ3Qrf0
	gVES9/H8+og1qMb3JhP8t8iJ5368MGycsmjO0AmyVDw==
X-Google-Smtp-Source: AGHT+IGGLUHlF/ro+tSRAKgK3O23q3SFcRGg8/CGpAj8dDvCRn/QTQvePZZIchd3r3e5NNm1hwoSig==
X-Received: by 2002:a05:620a:1909:b0:7c7:ba67:38a with SMTP id af79cd13be357-7c918fcb37emr391552185a.6.1744825878397;
        Wed, 16 Apr 2025 10:51:18 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4796eb2cb57sm113073921cf.46.2025.04.16.10.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 10:51:18 -0700 (PDT)
Message-ID: <67ffee16.c80a0220.1dbd15.c3ad@mx.google.com>
X-Google-Original-Message-ID: <Z__uE6MgkgJrp-tE@winterfell.>
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id DA6A2120006E;
	Wed, 16 Apr 2025 13:51:16 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 16 Apr 2025 13:51:16 -0400
X-ME-Sender: <xms:FO7_Z2XYN9IYDeB3mtJRUBFSCjtvzgikZeHj79Rfca0h0fKJvYi8hg>
    <xme:FO7_Zyn9QwmorqiltjQibB4rzoRNVlNEUwbnC4RLGfBgkrYjt26xay1t5HvFE99hg
    6B2vcQPz8oWdYKV4g>
X-ME-Received: <xmr:FO7_Z6b4ke6cEb6Jg3ryde6BT_S0ioKeYkl0-Wd_SJ7q9VpzJGit3FAmZ4RDsQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdejtdduucetufdoteggodetrf
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
X-ME-Proxy: <xmx:FO7_Z9VudysmBmTWm3hZGP8vY_QV8lOGnO5Q5MODAfwanmptAH_Nzg>
    <xmx:FO7_ZwlTDe7WY4QyGQVNPLRex3wgLMTD8vp4toob_epM24Hpl4dWHQ>
    <xmx:FO7_ZycNeS8mHtUr_Ks6My7SIQgHoRidkBnKqmlON6b6gjqRiFP8_w>
    <xmx:FO7_ZyE17Vy68KpuCMbTEzBrE3PONeD4UOz36xOjwG5JsPYJJpZOCQ>
    <xmx:FO7_Z-kR2E_GNlwbZ7igmOLLH3hmWihg4c6wxEbUWsnvqi55tXRhmC8D>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Apr 2025 13:51:16 -0400 (EDT)
Date: Wed, 16 Apr 2025 10:51:15 -0700
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
Subject: Re: [PATCH v9 6/6] rust: enable `clippy::ref_as_ptr` lint
References: <20250416-ptr-as-ptr-v9-0-18ec29b1b1f3@gmail.com>
 <20250416-ptr-as-ptr-v9-6-18ec29b1b1f3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416-ptr-as-ptr-v9-6-18ec29b1b1f3@gmail.com>

On Wed, Apr 16, 2025 at 01:36:10PM -0400, Tamir Duberstein wrote:
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
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Thanks!

Regards,
Boqun

> ---
>  Makefile                 | 1 +
>  rust/bindings/lib.rs     | 1 +
>  rust/kernel/device_id.rs | 2 +-
>  rust/kernel/fs/file.rs   | 2 +-
>  rust/kernel/str.rs       | 4 ++--
>  rust/kernel/uaccess.rs   | 4 ++--
>  rust/uapi/lib.rs         | 1 +
>  7 files changed, 9 insertions(+), 6 deletions(-)
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
> index 4063f09d76d9..74b5db81231f 100644
> --- a/rust/kernel/device_id.rs
> +++ b/rust/kernel/device_id.rs
> @@ -136,7 +136,7 @@ impl<T: RawDeviceId, U, const N: usize> IdTable<T, U> for IdArray<T, U, N> {
>      fn as_ptr(&self) -> *const T::RawType {
>          // This cannot be `self.ids.as_ptr()`, as the return pointer must have correct provenance
>          // to access the sentinel.
> -        (self as *const Self).cast()
> +        core::ptr::from_ref(self).cast()
>      }
>  
>      fn id(&self, index: usize) -> &T::RawType {
> diff --git a/rust/kernel/fs/file.rs b/rust/kernel/fs/file.rs
> index 791f493ada10..c9a86beacb65 100644
> --- a/rust/kernel/fs/file.rs
> +++ b/rust/kernel/fs/file.rs
> @@ -364,7 +364,7 @@ fn deref(&self) -> &LocalFile {
>          //
>          // By the type invariants, there are no `fdget_pos` calls that did not take the
>          // `f_pos_lock` mutex.
> -        unsafe { LocalFile::from_raw_file((self as *const Self).cast()) }
> +        unsafe { LocalFile::from_raw_file(core::ptr::from_ref(self).cast()) }
>      }
>  }
>  
> diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> index 40034f77fc2f..ca173ae3282d 100644
> --- a/rust/kernel/str.rs
> +++ b/rust/kernel/str.rs
> @@ -29,7 +29,7 @@ pub const fn is_empty(&self) -> bool {
>      #[inline]
>      pub const fn from_bytes(bytes: &[u8]) -> &Self {
>          // SAFETY: `BStr` is transparent to `[u8]`.
> -        unsafe { &*(bytes as *const [u8] as *const BStr) }
> +        unsafe { &*(core::ptr::from_ref(bytes) as *const BStr) }
>      }
>  
>      /// Strip a prefix from `self`. Delegates to [`slice::strip_prefix`].
> @@ -290,7 +290,7 @@ pub const fn from_bytes_with_nul(bytes: &[u8]) -> Result<&Self, CStrConvertError
>      #[inline]
>      pub unsafe fn from_bytes_with_nul_unchecked_mut(bytes: &mut [u8]) -> &mut CStr {
>          // SAFETY: Properties of `bytes` guaranteed by the safety precondition.
> -        unsafe { &mut *(bytes as *mut [u8] as *mut CStr) }
> +        unsafe { &mut *(core::ptr::from_mut(bytes) as *mut CStr) }
>      }
>  
>      /// Returns a C pointer to the string.
> diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
> index 80a9782b1c6e..5f8e1e7babb3 100644
> --- a/rust/kernel/uaccess.rs
> +++ b/rust/kernel/uaccess.rs
> @@ -242,7 +242,7 @@ pub fn read_raw(&mut self, out: &mut [MaybeUninit<u8>]) -> Result {
>      pub fn read_slice(&mut self, out: &mut [u8]) -> Result {
>          // SAFETY: The types are compatible and `read_raw` doesn't write uninitialized bytes to
>          // `out`.
> -        let out = unsafe { &mut *(out as *mut [u8] as *mut [MaybeUninit<u8>]) };
> +        let out = unsafe { &mut *(core::ptr::from_mut(out) as *mut [MaybeUninit<u8>]) };
>          self.read_raw(out)
>      }
>  
> @@ -357,7 +357,7 @@ pub fn write<T: AsBytes>(&mut self, value: &T) -> Result {
>          let res = unsafe {
>              bindings::_copy_to_user(
>                  self.ptr as *mut c_void,
> -                (value as *const T).cast::<c_void>(),
> +                core::ptr::from_ref(value).cast::<c_void>(),
>                  len,
>              )
>          };
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

