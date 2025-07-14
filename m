Return-Path: <linux-kselftest+bounces-37232-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45776B03CF4
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 13:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83EEF17E236
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 11:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45A9246327;
	Mon, 14 Jul 2025 11:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A/NN8tQT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752A91FE461;
	Mon, 14 Jul 2025 11:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752491389; cv=none; b=mAVUPq9PgYK6V/hOH0MCtOWG72ywR3gQxYtZqhUqe5sIt5rkZYI00WKkpLkhua/Kvkas/9PhxRPkLZKYeEsHJZ7hDKS/QxeKETFxyD7+C96MbQYG3mHz9p89ZccXnjDaFFq5bnO5tBo2nCoIx4zRRhnhAcEabOQB0ZUg7eaojMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752491389; c=relaxed/simple;
	bh=RpiEzxCKkkEachf+ZeEwRHRoaG1XxJFVTXSqrmNVzLM=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=oXPEQnLypMXWcPzMh18dJ8jDeghQqvjWvVXOW1pX9hhrspPeVeMiDW81NNc/SiqulK5keTVOXbEioKXF3hrXaRcGD5Z1jNQx2MU59q8h5GQB20sRtvR/mwpkV3wOaRkPV60L/Pcu3Ca24g12zzQ4ngN78X02uKA7/mOv74HcdMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A/NN8tQT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7B04C4CEED;
	Mon, 14 Jul 2025 11:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752491388;
	bh=RpiEzxCKkkEachf+ZeEwRHRoaG1XxJFVTXSqrmNVzLM=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=A/NN8tQT88eMzpyi9QVo5FopZDYNFWMiZau8tGoF66U4JSIfIX2CKajUNXaNepUcH
	 eYFQfQmFpbhsabtEazM3xEe6oFK0ex6S6Cn+T1pWTMjOqbO+mzrjte62VIOqcXglse
	 /r0bTJ84RmPuOo4LU3Q9T/BCAIaPb7eirWu+pO3Gj8nnpvzQQIwcQX5055n+7kIz/k
	 A3WIuPRFj9SVJh6uEr3U+pLQRTXbsbwI7tyMDKmxH/ejSIrniqJ4YY1F85yvU8F9bV
	 AC8NmGAynyYd7UlXt4N9iE4nQkbXMivv2fB8Xkx4pcJfAU2i+JjWLn/08Ccpp9fV8w
	 MTdtClgm4LeVg==
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 14 Jul 2025 13:09:39 +0200
Message-Id: <DBBQCHNN1N7F.3O470V9YDXE70@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 05/10] rust: drm: use `core::ffi::CStr` method names
Cc: "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun
 Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Dave Ertman"
 <david.m.ertman@intel.com>, "Ira Weiny" <ira.weiny@intel.com>, "Leon
 Romanovsky" <leon@kernel.org>, "Breno Leitao" <leitao@debian.org>, "Rafael
 J. Wysocki" <rafael@kernel.org>, "Viresh Kumar" <viresh.kumar@linaro.org>,
 "Luis Chamberlain" <mcgrof@kernel.org>, "Russ Weight"
 <russ.weight@linux.dev>, "Brendan Higgins" <brendan.higgins@linux.dev>,
 "David Gow" <davidgow@google.com>, "Rae Moar" <rmoar@google.com>, "FUJITA
 Tomonori" <fujita.tomonori@gmail.com>, "Rob Herring" <robh@kernel.org>,
 "Saravana Kannan" <saravanak@google.com>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
 <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>
To: "Tamir Duberstein" <tamird@gmail.com>
References: <20250709-core-cstr-fanout-1-v1-0-fd793b3e58a2@gmail.com>
 <20250709-core-cstr-fanout-1-v1-5-fd793b3e58a2@gmail.com>
In-Reply-To: <20250709-core-cstr-fanout-1-v1-5-fd793b3e58a2@gmail.com>

On Wed Jul 9, 2025 at 9:58 PM CEST, Tamir Duberstein wrote:
> Prepare for `core::ffi::CStr` taking the place of `kernel::str::CStr` by
> avoid methods that only exist on the latter.
>
> Link: https://github.com/Rust-for-Linux/linux/issues/1075
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
>  rust/kernel/drm/device.rs | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
> index b7ee3c464a12..998b942b6dd8 100644
> --- a/rust/kernel/drm/device.rs
> +++ b/rust/kernel/drm/device.rs
> @@ -83,8 +83,8 @@ impl<T: drm::Driver> Device<T> {
>          major: T::INFO.major,
>          minor: T::INFO.minor,
>          patchlevel: T::INFO.patchlevel,
> -        name: T::INFO.name.as_char_ptr().cast_mut(),
> -        desc: T::INFO.desc.as_char_ptr().cast_mut(),
> +        name: crate::str::as_char_ptr_in_const_context(T::INFO.name).cas=
t_mut(),
> +        desc: crate::str::as_char_ptr_in_const_context(T::INFO.desc).cas=
t_mut(),

Maybe looks slightly cleaner to import this function, not a blocker though.

