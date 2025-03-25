Return-Path: <linux-kselftest+bounces-29789-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E20BEA70CAE
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 23:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9D77189FFA8
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 22:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D9E269CF5;
	Tue, 25 Mar 2025 22:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Znt9efbO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8F9269AF8;
	Tue, 25 Mar 2025 22:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742940705; cv=none; b=q2hHuVG97OnxOA2y/6FIknlUkGPpH6bGv14vnqg5OrQMc2aeHBysbO2Y1yv6/dikm9wBu1vuiCvNNBK5g6gNaACSSS78r/9NE6WypkhJvB4WM+GY5idmx7ky+sE44d+GC5j0YXSMCaVy3zR2seNtELzLVyu0Q1PKfGeR6RHODkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742940705; c=relaxed/simple;
	bh=INtxnLlua0m5+riRrCQCNfpZkOBwhMZMhtFEG3oNA9M=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VM7eXcZqT7qh+1jACOhm2M39hm2pdSkciC+yU+OmSbohTxPmDyQ6E5VsMVIKk543hIvLMPJfR28q7ljPUEBsqS02h4epRFpFskyzETtbSK3bwWbwk6rjX+RbECEzeTCnddtV2PMEVg4a2g1Upd/H1qpSBygruVrBYuUmTsATVic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Znt9efbO; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742940696; x=1743199896;
	bh=jMMA8zQorl8Tfb7BH49RE8xPD4Fjn3HXBR627pProcA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=Znt9efbO5eyaROb7dMqTfzYXCP0EPddfjrbSr5TYhf67lh7PlD+HzDFoAgW3FCWcl
	 UhMt7ieP8Xng5o1UHsVJ15IHrfRCnuHKni5ksbFlJULfyJMGfMs/ujvgnj3w6ITxV8
	 e5HUtJhaWhST3TDk1ezjmyXBqQ7ZQIgx24Z/cHcCRgom7LTbPtoVPD4MMqPjQvWTUY
	 ftXO/4TJo02vKzm907Kg6RhBarJ9GRjlbuVc3uVixaZQAEY940aUNBZzKIfNa1TPNc
	 cQhXavsmny6cEvvvZTkvIuHqr937iMeNh1QGMuR9SFnZH7b4NeL/BTQb5buXFtbIG0
	 NwpD4q2IYg9cA==
Date: Tue, 25 Mar 2025 22:11:27 +0000
To: Tamir Duberstein <tamird@gmail.com>, Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Bjorn Helgaas <bhelgaas@google.com>, Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, Abdiel Janulgue <abdiel.janulgue@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>, Robin Murphy
	<robin.murphy@arm.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, FUJITA Tomonori <fujita.tomonori@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, linux-pci@vger.kernel.org, linux-block@vger.kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, netdev@vger.kernel.org
Subject: Re: [PATCH v7 7/7] rust: enable `clippy::ref_as_ptr` lint
Message-ID: <D8POWLFKWABG.37BVXN2QCL8MP@proton.me>
In-Reply-To: <20250325-ptr-as-ptr-v7-7-87ab452147b9@gmail.com>
References: <20250325-ptr-as-ptr-v7-0-87ab452147b9@gmail.com> <20250325-ptr-as-ptr-v7-7-87ab452147b9@gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 193ea9b5afc3597accae5dbd9f02f4fdde8ca624
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue Mar 25, 2025 at 9:07 PM CET, Tamir Duberstein wrote:
> diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> index 40034f77fc2f..6233af50bab7 100644
> --- a/rust/kernel/str.rs
> +++ b/rust/kernel/str.rs
> @@ -29,7 +29,7 @@ pub const fn is_empty(&self) -> bool {
>      #[inline]
>      pub const fn from_bytes(bytes: &[u8]) -> &Self {
>          // SAFETY: `BStr` is transparent to `[u8]`.
> -        unsafe { &*(bytes as *const [u8] as *const BStr) }
> +        unsafe { &*(core::mem::transmute::<*const [u8], *const Self>(byt=
es)) }

Hmm I'm not sure about using `transmute` here. Yes the types are
transparent, but I don't think that we should use it here.

>      }
> =20
>      /// Strip a prefix from `self`. Delegates to [`slice::strip_prefix`]=
.
> @@ -290,7 +290,7 @@ pub const fn from_bytes_with_nul(bytes: &[u8]) -> Res=
ult<&Self, CStrConvertError
>      #[inline]
>      pub unsafe fn from_bytes_with_nul_unchecked_mut(bytes: &mut [u8]) ->=
 &mut CStr {
>          // SAFETY: Properties of `bytes` guaranteed by the safety precon=
dition.
> -        unsafe { &mut *(bytes as *mut [u8] as *mut CStr) }
> +        unsafe { &mut *(core::mem::transmute::<*mut [u8], *mut Self>(byt=
es)) }
>      }
> =20
>      /// Returns a C pointer to the string.
> diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
> index 80a9782b1c6e..c042b1fe499e 100644
> --- a/rust/kernel/uaccess.rs
> +++ b/rust/kernel/uaccess.rs
> @@ -242,7 +242,7 @@ pub fn read_raw(&mut self, out: &mut [MaybeUninit<u8>=
]) -> Result {
>      pub fn read_slice(&mut self, out: &mut [u8]) -> Result {
>          // SAFETY: The types are compatible and `read_raw` doesn't write=
 uninitialized bytes to
>          // `out`.
> -        let out =3D unsafe { &mut *(out as *mut [u8] as *mut [MaybeUnini=
t<u8>]) };
> +        let out =3D unsafe { &mut *(core::mem::transmute::<*mut [u8], *m=
ut [MaybeUninit<u8>]>(out)) };

I have a patch that adds a `cast_slice_mut` method that could be used
here, so I can fix it in that series. But let's not use `transmute` here
either.

---
Cheers,
Benno

>          self.read_raw(out)
>      }
> =20


