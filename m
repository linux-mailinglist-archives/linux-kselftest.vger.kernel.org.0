Return-Path: <linux-kselftest+bounces-29796-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A980A70CEF
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 23:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C0353BAB43
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 22:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909E8269CE0;
	Tue, 25 Mar 2025 22:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2CDa+or"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4EB2528FC;
	Tue, 25 Mar 2025 22:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742942039; cv=none; b=PfCHXL7W7u/iOkdx9d4WGrj/8GzXyJlpFF7KxpKPF+acC1xtTvyVMan5JsqR8Y4IHM+jf1sSqgdBT0+8zR4HSxAIOGR2CkhGPDLhdrt1N6TICS0cHgQ+MaUAZ0KPtaS+5tW8oc/sUA/JaBaV19W3krvaUREB3fdlhhuCvj8ANeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742942039; c=relaxed/simple;
	bh=FqsuMD+N2GSkIElGsGJHn4dcw9fvquMPH/SsgRRnoeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h3WXh2guZPZx+fq+rhx/7iN/pR4v5QtBXxJR6n0gyXrSbdXKJfApqyJzMrpAVUoBmiUaE+32vLBIeTL44v/xckoYN56B5ghLpAZ/L6Rie/03ycWe++2ey/ZPha3DiIo/Dvj4sxJKa8I/kTTUQ9DyyfgzmKbx6nQZKngiWy8ROKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I2CDa+or; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-54af20849bbso2252565e87.0;
        Tue, 25 Mar 2025 15:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742942036; x=1743546836; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Rhrkp4C3mtJ8SrlSBMmU8WkZfHfXdyvYKhxaaowYRs=;
        b=I2CDa+orkEaGXixHA/zM9zEtX8bL14l/ix5Lj+0REp/VMGhHVLuJI5v1Jc7jiAtVSd
         kkIoQUWw9eRMTknqKqQgnSHtE4bGXC8GrgDgpCCl8Mapj/BGDDvod7xCf94lV2uJPIiS
         TaOQj/FAOpLQj58jbH+Js85fd3n4XhTrGdJzXfemRqpyOGqiQlfSI1TiMT3Q0SnEUJZc
         kpi1bDOh8b6txk6X17jexDA/Ua4pXbgffa+pgWFtvpDvAuA73+/iLJdLclyPDYzmiKnc
         jpJuDrC+GfABC2tQE/KKTAKQDExLHDlNbx4J86YeziNxrkqzT1e2fZyf+tEbD6Cvh+xO
         skVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742942036; x=1743546836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Rhrkp4C3mtJ8SrlSBMmU8WkZfHfXdyvYKhxaaowYRs=;
        b=oQvJSCZ22OIP4igQlXYzdn/kO2lIv8iaqy1Wyg6HR1M7umR6Gb4j8cJ5yDfsK9s12M
         +wouob3TBSl9dV1ziNo5D/j3/0VlRciKkJIdvSdCvdSK9T5gf+keZ7tf2zgCB2InjSxh
         DBVsqKQiVm4TtO3wUmt2x4og+i8sUsX0pYYPzwCJOPKym8wEdNzGEMI0DX+4NL1+RHZQ
         K2S6Ys+W2d/JhRfQBr+ABPnciTBkaFD/xkEAuFnouKN08DtkNOQHli634XQOW+pXsg+J
         zLvCJtR6Xxx/CvYF8+BeHqijSdw/BbufkyQf+U1T4G/NxiAIH7S77M43g7GtggnKWhpb
         bSPQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+nmPpE9M4EezihvkvxqHUSbwI0o8+NSr4JcDjD6xb9rOh7cKL/+A7n5hH2YOszgWRH9eWMVg9K4l8@vger.kernel.org, AJvYcCUnAHMVDXCDWBxj5YXbCM7LunAEjaO4mUhE8GMInFdmM6+US65tTq4tKB79Dq3P61/5W0Kd5aDAkK+lmzb2@vger.kernel.org, AJvYcCW5h/aGMKGY2AijCdtqRIgQiRNz0XHi5/QfBD+qbebCwm7TtE0CYRpRVBAdZyBIFoYMam+oklO0j/XCCQR9@vger.kernel.org, AJvYcCWA/2vdrxyqc7PshsxLye2bHyxU5+TC9ps3WHS7/jIrGb6NLqT7bFsaXUG05baETmv0fHNui3BJ/Kh53xXEq24=@vger.kernel.org, AJvYcCWVjjqfGUvB2JjCibuM1PUyBPpEjPqDa0eUOAV7wxy8Ru+K0tf1ilLfQPIIZVTOosn6mJum/oB2@vger.kernel.org, AJvYcCX6qA3jLmT/AAbHs72MK/kUnHwXdObF/ynXL4a96pZ5J17YDdDFKEqIWA1n9ci7+juSodEciuG8zk6IE/SMUNxW@vger.kernel.org, AJvYcCX8hXh81PTjZDl07mVaAlRnwx7InitZeEW8+wMewSHKPJHo5oHVb/hl8V8QBghjCMV96vSlhVA2zhwr@vger.kernel.org, AJvYcCXFc6CzwJt0yK/PppsGAQZCcBGf492gWe//PMh+12HGXtInfSR70lxZjxUOiR5yokaCwkwIjHShTqGwCJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAJMj5pyoAXRCoA+gl7w7YZUH/FQBQ/HpZYQw4HJndGJaYOF7S
	TPLtmBxM1ej0NUVfAcHvdCNP4rRQkoidr00yoZHAkzLHBL9CIJ/NLviqK93n8aMGBH3gvEVNIfm
	kT2HCHe38OmHxChbGIi3V+Z0FFMY=
X-Gm-Gg: ASbGncssiRyhgbtn7kbD+GN9hnWnkUiUI1OklmukXiuiQi1cJVEGArDh5vwv7W8hUrj
	61kBtXafre9JwyExqKZxDvmlTM1KwtrNl949QV5kHcmjjSLFQOVfHYmjiVeOpKGUBWKQshmfGLR
	+VdvVI5bAW6YYMluEWdPoKNNAHqKP46GEP9WXi9dOr30hzJ9Jx5OTaRutH62tlh1RheKmVjQ==
X-Google-Smtp-Source: AGHT+IF7oNHiA79ygoevBMCH/M8kBbwg6m++h2lH8/S2V9ylq5tEJ7Ga+KdvKmKrJrM61cBMQiYIb8DxAdgeGsC/R6E=
X-Received: by 2002:a05:6512:31c9:b0:545:5a5:b69f with SMTP id
 2adb3069b0e04-54ad64799edmr5883337e87.9.1742942035388; Tue, 25 Mar 2025
 15:33:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325-ptr-as-ptr-v7-0-87ab452147b9@gmail.com>
 <20250325-ptr-as-ptr-v7-7-87ab452147b9@gmail.com> <D8POWLFKWABG.37BVXN2QCL8MP@proton.me>
In-Reply-To: <D8POWLFKWABG.37BVXN2QCL8MP@proton.me>
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 25 Mar 2025 18:33:19 -0400
X-Gm-Features: AQ5f1JosKyWe583mjIwVAHNfBxS6svc8VZc6q_vCfw8uzWZ3UtE-6_9jMFmmSrw
Message-ID: <CAJ-ks9mUYw4FEJQfmDrHHt0oMy256jhp7qZ-CHp6R5c_sOCD4w@mail.gmail.com>
Subject: Re: [PATCH v7 7/7] rust: enable `clippy::ref_as_ptr` lint
To: Benno Lossin <benno.lossin@proton.me>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Robin Murphy <robin.murphy@arm.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-pci@vger.kernel.org, linux-block@vger.kernel.org, 
	devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 6:11=E2=80=AFPM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> On Tue Mar 25, 2025 at 9:07 PM CET, Tamir Duberstein wrote:
> > diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> > index 40034f77fc2f..6233af50bab7 100644
> > --- a/rust/kernel/str.rs
> > +++ b/rust/kernel/str.rs
> > @@ -29,7 +29,7 @@ pub const fn is_empty(&self) -> bool {
> >      #[inline]
> >      pub const fn from_bytes(bytes: &[u8]) -> &Self {
> >          // SAFETY: `BStr` is transparent to `[u8]`.
> > -        unsafe { &*(bytes as *const [u8] as *const BStr) }
> > +        unsafe { &*(core::mem::transmute::<*const [u8], *const Self>(b=
ytes)) }
>
> Hmm I'm not sure about using `transmute` here. Yes the types are
> transparent, but I don't think that we should use it here.

What's your suggestion? I initially tried

let bytes: *const [u8] =3D bytes;
unsafe { &*bytes.cast() }

but that doesn't compile because of the implicit Sized bound on pointer::ca=
st.

>
> >      }
> >
> >      /// Strip a prefix from `self`. Delegates to [`slice::strip_prefix=
`].
> > @@ -290,7 +290,7 @@ pub const fn from_bytes_with_nul(bytes: &[u8]) -> R=
esult<&Self, CStrConvertError
> >      #[inline]
> >      pub unsafe fn from_bytes_with_nul_unchecked_mut(bytes: &mut [u8]) =
-> &mut CStr {
> >          // SAFETY: Properties of `bytes` guaranteed by the safety prec=
ondition.
> > -        unsafe { &mut *(bytes as *mut [u8] as *mut CStr) }
> > +        unsafe { &mut *(core::mem::transmute::<*mut [u8], *mut Self>(b=
ytes)) }
> >      }
> >
> >      /// Returns a C pointer to the string.
> > diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
> > index 80a9782b1c6e..c042b1fe499e 100644
> > --- a/rust/kernel/uaccess.rs
> > +++ b/rust/kernel/uaccess.rs
> > @@ -242,7 +242,7 @@ pub fn read_raw(&mut self, out: &mut [MaybeUninit<u=
8>]) -> Result {
> >      pub fn read_slice(&mut self, out: &mut [u8]) -> Result {
> >          // SAFETY: The types are compatible and `read_raw` doesn't wri=
te uninitialized bytes to
> >          // `out`.
> > -        let out =3D unsafe { &mut *(out as *mut [u8] as *mut [MaybeUni=
nit<u8>]) };
> > +        let out =3D unsafe { &mut *(core::mem::transmute::<*mut [u8], =
*mut [MaybeUninit<u8>]>(out)) };
>
> I have a patch that adds a `cast_slice_mut` method that could be used
> here, so I can fix it in that series. But let's not use `transmute` here
> either.

See above - I don't know what else I could write here.

