Return-Path: <linux-kselftest+bounces-28818-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20AEBA5E02D
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 16:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82EEB1888BB1
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 15:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F43A2571BF;
	Wed, 12 Mar 2025 15:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f2L9vETx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40269250BE9;
	Wed, 12 Mar 2025 15:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741792775; cv=none; b=Hoez01aeJc+3pUCW7lNIDrYAnlGBE3sLtQERbT8+OWrReS9FxgWUwyniH5wTSkxMJeRxRgcrLog2zDRyboHKqhbOzmjKJ7C1Dha90iG03JT3Xk9Yq3Wwshi1P79g6SP+my3UIZlz0w6z/VuxNNtmWg5FbyezZnu3MOgsEeiU07I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741792775; c=relaxed/simple;
	bh=DZ1Y+gpCWCY9gKqjbGx1YlA81MAHDVWvWbEPAiVSvzM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rbLAovF3ZJMAnIH1WqmLgLGZyknFXqeLYWCIyGXcyFvCH1pQQhDp2SOiqMLYl5D1ZJiB1PZXN0altxFQ1QbuZ+Ompf0Wmz1yfvqeTpRSQWp0H4tAPO4LOSaEgjlHcrK14EXqyli8Dm6HdCpJ3V65VUUwyPEHa/9wM9RGcYFD4bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f2L9vETx; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ac2963dc379so523031266b.2;
        Wed, 12 Mar 2025 08:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741792772; x=1742397572; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w/pXIDpOp6BNiWBUcqQ2AhAHmg0GVGeLpFmyRHgc3pE=;
        b=f2L9vETxOjhFHt4qjMoo/4c6jNtezvdUw2WVDcef1/yoL+aPsbmgquk+srAlmv7/ZQ
         cR0rIf3NW7Z0y5N68ie1/75rUlE32YOBMPtmGehqq0Rqf9LcewBjIiRsst3rHIRa9FSH
         T9YOtBdD1ynGWwEzSGLxdLzFQklhTsZOZZ9rvZoA0jbiZVv/9Cynx39sW1UkgP5gGVEs
         dw3N5b/Ienxumf3aDSrU6d6Ko4h5AS86emhXSJ8SAG4vPx1xW1Q68VwXWmzN3pCtBPop
         aU5ElsnjHqaZGt5zyrTNWxkiI7IOOh6a44XvgXG4nNKmSoC3z4D2vNsrPwucMVPNiaGO
         kcBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741792772; x=1742397572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w/pXIDpOp6BNiWBUcqQ2AhAHmg0GVGeLpFmyRHgc3pE=;
        b=OmaacCNcRnmAt8N8aB0RVCWBs/leC2+Yu+YYAJyWmVJe/ssR4xBnyzQ4NfPqKqvuEP
         ukR0HvvwFR8985p4TmX2sJ8z+e+ixGdE6pjeiO9MqpMkXAeKg1cF6cfBkilMPflo0Vr9
         91OZ3xlyT8ATuNMvXpxTejAzOGLgkWiestO9R1hWacCUuk30Smk6zUcYXxsz2DsEwWIY
         VwAZg3MI9Lu51DLmg63GzT2PcnLgkATOqPXUIn29JrIQn58NOlHpR8e430qD9pWi4AhH
         kKJ4OibXvI+HPtvLPjEydICfoOOKvwPG8/uDD9bFSXX9Z8mu5SMatahdG818RMy2/2EG
         sT8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUm+7KUixVkU6+hAwFDxAzdMhVrmLgNzdpmAfQqwJbbGF5qTjyv9s+4kKOWrVBhuiwsAofuvM4hq6X/hbap@vger.kernel.org, AJvYcCVIKZ0PPOBeiLAJc6KJMEdzzA7wdylnjz6hS0iLZ6fZT+F8YUDbN5QRCuRJHTBZU2kaJMtVaZUCXXbgg/zA@vger.kernel.org, AJvYcCVksydJ1ssi9biopRUq0Mzb9R1YEkPmhJ887nkicdLSK5nTCmaQCrQfOur1oPIgmB7j2ZgYED/ICDb44Sg3AkY=@vger.kernel.org, AJvYcCW2JUvT4JN+uCsDXJfbnygoUA6bGxPY/9/kNnIUDeTx8PVl5x151Zu93knE//QY2t/xCre3LG2OBfcY@vger.kernel.org, AJvYcCX65ech20LkzcNCUdpdGJJTBGeot/jz6aTr3ks4y3I7vCk5QB3XiJpuv3PtcBK65ylsWlp22YrxDYt2@vger.kernel.org, AJvYcCXIVHBM/j9zIb0ul9jEpMu0J4TrB7hKv5LwkXLpOz00jP/z6pUrIi3j/vYHYFMYfgPk8Otq1rDdNOYJq6Y=@vger.kernel.org, AJvYcCXKVJd42IjmWhL1DSBp0i4eXJ5JdlMGSnRzM/YgrI9PPJGArxGfTnYH2gAqAcZa5Tn3nZu/DC0eCGWLS9z07z85@vger.kernel.org
X-Gm-Message-State: AOJu0YxP0D0CfMNNuX9mFFDLAtyzW+PNG8PVDQPxcIXxOv9GtjZKSDX/
	Vn9HiggpNZpOiMmMsEfCid4ghgxW3/2+17nH4KO7+GLzxSrUxqtB+ErDOl1nm5+0EPB+GwX/UND
	w3jvj7uRS7/jApOr9Aq7xqlrcSeE=
X-Gm-Gg: ASbGnctHEF+TyHBp1t55DBgnf1+wmOSV0jC9vGndkdMhAV5WCHv/0kCztB54q27Jm14
	QstzVCn+4/vFQ+ymRbUS6ktcxJ02Lf/GQOCwC6Cw3WPYEDxjd6IPfqcA+T6E7ljqMhUzdO7ujTL
	6KHV+pm6ZBfkuf8vqI7XtdT9EL/m7a3I/P1+uW8z1pTg==
X-Google-Smtp-Source: AGHT+IEec6B4lJH1kJ1qHPybkofl06oPx4WtqrcLkOLw+lXdaHEZafbVI/G1oeMNC9lXPgjx3er5Eb5Gd21kfKnMS/g=
X-Received: by 2002:a17:906:f10d:b0:ac1:e332:b1e7 with SMTP id
 a640c23a62f3a-ac2525af682mr518458366b.4.1741792770733; Wed, 12 Mar 2025
 08:19:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250309-ptr-as-ptr-v2-0-25d60ad922b7@gmail.com>
 <20250309-ptr-as-ptr-v2-2-25d60ad922b7@gmail.com> <D8ED5UWKL2N1.2JPWVV0297BJ0@proton.me>
In-Reply-To: <D8ED5UWKL2N1.2JPWVV0297BJ0@proton.me>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 12 Mar 2025 11:18:54 -0400
X-Gm-Features: AQ5f1JryaC9D1lS-G8sJ5tBzfvkxBopn5cTygfhECRK8JmXzAdfXvR_ZyRwcnOw
Message-ID: <CAJ-ks9kOLgXrOHucFXHB+DwZEZpZEKhBNmXKh_hB_agrq=2n6g@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] rust: enable `clippy::ptr_as_ptr` lint
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
	Saravana Kannan <saravanak@google.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-pci@vger.kernel.org, linux-block@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 10:40=E2=80=AFAM Benno Lossin <benno.lossin@proton.=
me> wrote:
>
> On Sun Mar 9, 2025 at 5:00 PM CET, Tamir Duberstein wrote:
> > In Rust 1.51.0, Clippy introduced the `ptr_as_ptr` lint [1]:
> >
> >> Though `as` casts between raw pointers are not terrible,
> >> `pointer::cast` is safer because it cannot accidentally change the
> >> pointer's mutability, nor cast the pointer to other types like `usize`=
.
> >
> > There are a few classes of changes required:
> > - Modules generated by bindgen are marked
> >   `#[allow(clippy::ptr_as_ptr)]`.
> > - Inferred casts (` as _`) are replaced with `.cast()`.
> > - Ascribed casts (` as *... T`) are replaced with `.cast::<T>()`.
> > - Multistep casts from references (` as *const _ as *const T`) are
> >   replaced with `let x: *const _ =3D &x;` and `.cast()` or `.cast::<T>(=
)`
>
> Similarly to the other patch, this could be `let x =3D &raw x;`. (but it'=
s
> fine to leave it as-is for now, we can also make that a
> good-first-issue.)

Yeah, same as the other patch; we can't directly do that here without
introducing some compiler infra or bumping MSRV.

> >   according to the previous rules. The intermediate `let` binding is
> >   required because `(x as *const _).cast::<T>()` results in inference
> >   failure.
> > - Native literal C strings are replaced with `c_str!().as_char_ptr()`.
> >
> > Apply these changes and enable the lint -- no functional change
> > intended.
> >
> > Link: https://rust-lang.github.io/rust-clippy/master/index.html#ptr_as_=
ptr [1]
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>

Thanks!

