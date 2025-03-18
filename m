Return-Path: <linux-kselftest+bounces-29355-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F02A67628
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 15:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9F511888756
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 14:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656D720E03A;
	Tue, 18 Mar 2025 14:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NsXGJRTZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C1920DD5C;
	Tue, 18 Mar 2025 14:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742306958; cv=none; b=QIaLGfggaD/iwpJOB5I0/hwtyi6/08d5ewoSxMCNbkInOYZIVB3+A3AQsbvSleas1B3Ga8/JfkWh5J/mreW/nflxOFtN779klEI5UYk5KSWKXN5toAtwlMa9RXp3zycrOk2QvGmgdr9GbVRz2vv4vI1B8fYbX0xFOeYkIn5B2wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742306958; c=relaxed/simple;
	bh=FPLOeGmswPNA6gj/GxUZMLB4rXeT/EXYqMBZlMgddeM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SabyosLE6mcybPemIlFbzzW8sT3rFILodadHfqlOnktcTVawSlcR7Zg6Wvm5o5DiEWIiSrZAt+dTtAUgUzVVj+kp7SNzMPVCX1k82v277DsWFhi/4uTs0m13u0Rw8FhF377wsS2djYhxzphvY0kmtwMl/0fMLZjhEymXsZn/4/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NsXGJRTZ; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30beedb99c9so51477071fa.3;
        Tue, 18 Mar 2025 07:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742306954; x=1742911754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XR3QmdTlX82CLNbiCjBnydKIXsFQoeJ3c+u1awJ7NeY=;
        b=NsXGJRTZGEg2AC/EzaTj9CA8WlTV1eDmbGE4dObHLPTKxcLmR7NAcy8pzuW2KE2xjv
         GPdyEvHMKHFVrqYgFT2wMbjQyIeMC3+jeImh37NY16KDEUdYslnCEv3EYPHcBBrUZ5G8
         X9L2OQCIjK6Blyov+YnutOuOjUjoZGGe1FVg2U6QcLEVe8peDBidLNq0lO9CVQ75iU6x
         zjz4iYokGP6MrPxeSIUvo4YYNVlDqV1BXkwHz+6Fq+8NF+2t4J5tCczFUEV8V/2GgRQT
         25q86K9ad6zhumVpZOaKZe5ePxyHgANHPHvyEDnbbHO76pxjq9CmmQvV3fkQAtCPnX7e
         NQ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742306954; x=1742911754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XR3QmdTlX82CLNbiCjBnydKIXsFQoeJ3c+u1awJ7NeY=;
        b=hLScdTO7YEuJ0TjEdd84CQpOVuPJvObG9g1IDhrMVml2PElwcBClEeHB/31rGZaB9l
         czh5WuSxTk5yVYbRH5LJtqNMf7TgDMa9zReIMVa8R/zHXcY79lFvDvcqW/d/gjp5lwni
         JoRs5w8vDrM9tTC+fJg64T4LoIreC9ZN7bAztjtBF0KXKtZCxy1QU8erPGqdFu2yfJtO
         8ofKXn7OBobWtBxG2HAb81N8dhrOje3yjenfKfgz+KVN+P1Gz/dQtPQoI7qW7RRD2UQS
         z1S+11r0uHnTLUw8sdHZQ856r7tRFImADAkfjINOBsy91WF+VeGJxsyfHQptOpqC5dYr
         AGGA==
X-Forwarded-Encrypted: i=1; AJvYcCUB9LvThrVVfn4mPoVmvnOLeIPqDxKGPB/2pZesJwnckost+PGovH8CxJZaHRNWrN8G3d1bpBXM7Xh/QWJD@vger.kernel.org, AJvYcCUKQ+VMiNOltvB0v58jU8x0ZD+Bk7VR4lBQkgG6wRGmxtzuRD7moPyyAKsjiYbnkSOJiP7NtI/t/PuvbW8MJ1en@vger.kernel.org, AJvYcCUPpVKEjIIcl8+791LucEBdnVSPScZnGCd6y+H9rstFwUFrpvu7QzHhBHqhiZXBPpPqgnOeLeq3Ax6Y@vger.kernel.org, AJvYcCUXzSEaGpE7dsBHRlmDLvBMtIdNGOv5GuYyV21oOtju/tA49ppqGSlgUgUXdSFy1snZqiOcJ81EXdTP8oo=@vger.kernel.org, AJvYcCWz4g0l/YRc9QogetayS3RMaAB1xW3gfhG2FgxgYpXjlhD+i/K85pI5pYkHHOhy5nY/TbSox8zN7wxZoyIP@vger.kernel.org, AJvYcCX07O0yWFsq//bgpA1DezHsZLIWrq02qYIsH+gMCiWdGuQiEuRLD34lvzNa5Mh35BI+eUW8RelGkobL@vger.kernel.org, AJvYcCX6kD+rK23Gl4WOLRUsmvp5eyuO1Dh0SDOyHf1HcnkbmDfdNZbxa6yAzod4weKF1dXjDD/4GQkLo12Xye2Hfsk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC9ldYRsW83v3Y7OQAJyjPCqjeJL/yi0iiTxLkn3rJhOikWo2l
	3BdaBpiOkcWUl15y3XWxCpARL5FQ2gMyk3CInlbFWE2afiNVrMprd07KkC+LLOyYUpNQRmVIlwg
	8mGwWD3nuXe1Ql01ueTsYKlmZwW8=
X-Gm-Gg: ASbGnctFV/jwijM7RM158Lit/ZX4wEn+1R5oN65cc0uzmXHm1PqKaYPRpjQR5cssEhe
	SJg0Y24LMqgSTmrOCE0cwRiYI+5Aiw47464Z81XEMCr3BeH2WE2Ef6J0XoJlVw720VBeBCQbvt0
	fgL5IttFxQdEaCw79F07+12vaU3oNQ01P1Acgm3u8EhA==
X-Google-Smtp-Source: AGHT+IFxpjLk/MoadRODdmp6sMkrXqEk5zu/R6whmoxUeanggxj1j1wQ9JCQLIxNBupqBoSdrmyU8Q9aU/YaFrU7328=
X-Received: by 2002:a2e:bd09:0:b0:30c:160b:c76c with SMTP id
 38308e7fff4ca-30c9755de18mr33340731fa.17.1742306953725; Tue, 18 Mar 2025
 07:09:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317-ptr-as-ptr-v5-0-5b5f21fa230a@gmail.com>
 <20250317-ptr-as-ptr-v5-6-5b5f21fa230a@gmail.com> <Z9lnIJCcVSza6UVo@google.com>
In-Reply-To: <Z9lnIJCcVSza6UVo@google.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 18 Mar 2025 10:08:37 -0400
X-Gm-Features: AQ5f1JqOYVk7nD9z0cLpiPEdxTeWINnN4TjRzqE0nN_LBkIs9bu7CUDTA0sD4FE
Message-ID: <CAJ-ks9k5XZUN_vuH648rr6-e+v0my_dR2zo+986rzx+A5ZLxng@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] rust: use strict provenance APIs
To: Alice Ryhl <aliceryhl@google.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-pci@vger.kernel.org, linux-block@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 8:29=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> On Mon, Mar 17, 2025 at 10:23:56AM -0400, Tamir Duberstein wrote:
> > Throughout the tree, use the strict provenance APIs stabilized in Rust
> > 1.84.0[1]. Retain backwards-compatibility by introducing forwarding
> > functions at the `kernel` crate root along with polyfills for rustc <
> > 1.84.0.
> >
> > Use `#[allow(clippy::incompatible_msrv)]` to avoid warnings on rustc <
> > 1.84.0 as our MSRV is 1.78.0.
> >
> > In the `kernel` crate, enable the strict provenance lints on rustc >=3D
> > 1.84.0; do this in `lib.rs` rather than `Makefile` to avoid introducing
> > compiler flags that are dependent on the rustc version in use.
> >
> > Link: https://blog.rust-lang.org/2025/01/09/Rust-1.84.0.html#strict-pro=
venance-apis [1]
> > Suggested-by: Benno Lossin <benno.lossin@proton.me>
> > Link: https://lore.kernel.org/all/D8EIXDMRXMJP.36TFCGWZBRS3Y@proton.me/
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
>
> I'm not convinced that the pros of this change outweigh the cons. I
> think this is going to be too confusing for the C developers who look at
> this code.
>
> > diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
> > index 719b0a48ff55..96393bcf6bd7 100644
> > --- a/rust/kernel/uaccess.rs
> > +++ b/rust/kernel/uaccess.rs
> > @@ -226,7 +226,9 @@ pub fn read_raw(&mut self, out: &mut [MaybeUninit<u=
8>]) -> Result {
> >          }
> >          // SAFETY: `out_ptr` points into a mutable slice of length `le=
n`, so we may write
> >          // that many bytes to it.
> > -        let res =3D unsafe { bindings::copy_from_user(out_ptr, self.pt=
r as *const c_void, len) };
> > +        let res =3D unsafe {
> > +            bindings::copy_from_user(out_ptr, crate::with_exposed_prov=
enance(self.ptr), len)
> > +        };
> >          if res !=3D 0 {
> >              return Err(EFAULT);
> >          }
> > @@ -264,7 +266,7 @@ pub fn read<T: FromBytes>(&mut self) -> Result<T> {
> >          let res =3D unsafe {
> >              bindings::_copy_from_user(
> >                  out.as_mut_ptr().cast::<c_void>(),
> > -                self.ptr as *const c_void,
> > +                crate::with_exposed_provenance(self.ptr),
> >                  len,
> >              )
> >          };
>
> That's especially true for cases like this. These are userspace pointers
> that are never dereferenced. It's not useful to care about provenance
> here.
>
> Alice

Let's just drop this last patch. It can be revisited later or not at
all. Perhaps in the future I need to be more willing to say no to
scope creep.

