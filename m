Return-Path: <linux-kselftest+bounces-34133-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 614C4ACACBC
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 12:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A42727A5AEF
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 10:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3FA20103A;
	Mon,  2 Jun 2025 10:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWC1Lb6F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDE119049A;
	Mon,  2 Jun 2025 10:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748861397; cv=none; b=JGjPZW1nu3dULJc5HVPveCz6b7bMuP9vzLhJ8X85iADwjipphC4RzlIFOQ9eGgZHF0eQ4jhCMYMAOqlEXesMHkLZbaM0Uh5VZmC3GBTxf8JxdJhiHhmJlNgh6hU6vJ1fegA2Jhl2r+wAnRUc4SWtwK6Vzuj8/dkTtoIK9lFrgeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748861397; c=relaxed/simple;
	bh=9WaAM0DFviW3Ug8kMcuL6hIx12rSZL33x0znJQdobt4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f4FAD7mFU7IEHQXQocwlhYBJe3vP0tPMF6tTuAZ+oLQuz8YKJwXAM5GWNbqL818UBvLkUg6tywQdmuSwh0eqSbxW9u07D678c29lBmzKToYTOW8vLAsyk3s+Va6XAZOfWqfQuALKN25l0cDTOEhjo1V5LUGLYesw7Y3j8xsRsJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HWC1Lb6F; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-32a658c4cc4so40283391fa.2;
        Mon, 02 Jun 2025 03:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748861393; x=1749466193; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AsxbXe8qRFrC4RTDRdhQf2KM3tIF4wckI+MuVJmqklg=;
        b=HWC1Lb6FbVRo1lrUqjfo7D4NwWEnu7ph5Vpgx6vGUIpChXxTPfgSqu7aMX49SSi6ED
         tQ+oAXJ1Qgsbopr4kVgFGfwO/98cXEqwp8gUbkfvFEYIHdVXUt2ErOgKcfG/VjfXIlLQ
         cM2K6mGx8VdATihr9bjw4Ht7Z9vg/LyoQGhOAtK31KV+WDh0L2KwJHMTpGMgP6eOwtkZ
         KzZ/OQrqJijzbPRXPscinzUR9ao9Sgi1Qp72fk2AZ6e2CDAUzSLSMcYwhzwcFM2K1C68
         IDrZJKz3xyboHHerICpkb1VJNyrFtWCp/yyXlP9D1rSka1KL8pXMW8VpryqnW6IH7uzC
         CE1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748861393; x=1749466193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AsxbXe8qRFrC4RTDRdhQf2KM3tIF4wckI+MuVJmqklg=;
        b=CYHcVb36eyE22otQr2hXZ+XFzbHFJCCMkwXhGn5CJOSSEWDz9IF05Y6Pkhx460wrC4
         BLA5ObnfNTv5PGHfbn0anVFACY4Ruk1KeRjgLPPc1SghisKKFPdWqMFBfv7TF7DLmlXN
         FAwsAHz2TBcAmuEOO3YSUlahDdwDtZu7tp5NvV444xqgF53AQH55s9YgdyLgNJvsK6mZ
         kbYzVDg8QC8NXhAS8euu/C9s/t0IZTu8lK179CrPyAtmLzTkPKXA6AkLhYoDTvzIZjAP
         2kp+dh5UF/eZGav5lKAWBAQgLlDCz0zcIvmHt/05jDaM2PlRE1t5EJq3VlP5RFdGvKZs
         iEwg==
X-Forwarded-Encrypted: i=1; AJvYcCVBp8G8WTG9do7Zb7Hs8HEwzz0vbBa9TZidOF8JTHV+wrFqU4JA2KtpUfaIt0TPnxEstirEhzf91Cmmqea5EZ0=@vger.kernel.org, AJvYcCVMBXj3dPxlPMlyg+1JWAO5MHM0hrCTABQ9T+kuUmuaW2nFPHbSg6cP/yGvNN1QxbaljVKSUjsrEyajF7WhB5ep@vger.kernel.org, AJvYcCVp88goaywfWZl39BRz+FNqnyNnPVx+H5rFBQYTb4bM1XeBXmjUFE/Wp8sOtspSf3cs5JdQ+mrRJ3RXP/5a@vger.kernel.org, AJvYcCWaC9eJ7bki2yxUI2EdFnCqZPkyyexmN2KDr2HWySkSLD6pp1i7KnHSmJVSbngLGeREYFSoX7pB@vger.kernel.org, AJvYcCWgtJnXWKXAw0d5ygE8cmQ9sJoHK1i5BHOnkzRK96Nc3NLJOCm3myiPENUYZshq/egGtgkuj5lUGE29@vger.kernel.org, AJvYcCXOIBj455Fa0O40s2pImyoEB0myrirCc6qHQUSwzC8ov44EQYvOTdiu9DDEISIozHoHoljIM/dsCYvyr9I=@vger.kernel.org, AJvYcCXwKgWSB1f/zq0HdZp9OI7NhZ6D6FgMzEbHhmvYUfdHBMWlWuOgpLyzJS4tsvJeCH2y3ESsXuGFJkBM@vger.kernel.org
X-Gm-Message-State: AOJu0YzZUQHtDEipPHRXSn5ljDxm4g3lADq3kAOCuEVqb6UCJWvXblon
	r4cka8m2CSrFNU+0KzPHZBF/8CayQlBDJYxVMSX+fGk01QP3N9XXLgIoYglkmK8+4YfiGXZzkQb
	oypzI7j8S3RDDlVw5hjp8ymAR+pEQjQs=
X-Gm-Gg: ASbGncvs5BzYOsZwuLpICIHv1AqXa3eekxCxSqC5/lMCj9sQQSSjSm/qkwmLeosrvHH
	o5UL7R9T6RxbUKvuFvJtGkRfx6gZH1Fm6xvZsNcJH0RFGCnHaR9+FacG3EYgukkSffKoU2DyELo
	7GU84yieIL8yy/eJO0+QG4NMzU1VvuI9ndwWxKV8mizWxlgcQSeuhanPp9bxkkr21xXOg=
X-Google-Smtp-Source: AGHT+IF5DWduxzl0/XGIjOoG2XZtzGtCfUO0aae++aWVjLV4gjiYEpeAaDYwqvBq64IuoR3CqF43l9YblyYjyY9SlHs=
X-Received: by 2002:a2e:9a0d:0:b0:32a:6a85:f294 with SMTP id
 38308e7fff4ca-32a9ea8fcabmr18219761fa.35.1748861392393; Mon, 02 Jun 2025
 03:49:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250530-cstr-core-v11-0-cd9c0cbcb902@gmail.com>
 <20250530-cstr-core-v11-3-cd9c0cbcb902@gmail.com> <aD1k4rRK8Pt5Tkva@google.com>
In-Reply-To: <aD1k4rRK8Pt5Tkva@google.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 2 Jun 2025 06:49:16 -0400
X-Gm-Features: AX0GCFuWGPYle2xpajsjX9J5Dr7DqqKyrlmViDc69KiPl9rdFF48mQDz9UTJ46o
Message-ID: <CAJ-ks9nx8fbm5J1yKfg4a1OOgBepu0LFFjdtomE=j4Gkszj=fA@mail.gmail.com>
Subject: Re: [PATCH v11 3/5] rust: replace `CStr` with `core::ffi::CStr`
To: Alice Ryhl <aliceryhl@google.com>
Cc: Michal Rostecki <vadorovsky@protonmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, Danilo Krummrich <dakr@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>, Benno Lossin <lossin@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, llvm@lists.linux.dev, linux-pci@vger.kernel.org, 
	nouveau@lists.freedesktop.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 2, 2025 at 4:46=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> wr=
ote:
>
> On Fri, May 30, 2025 at 08:27:44AM -0400, Tamir Duberstein wrote:
> > `kernel::ffi::CStr` was introduced in commit d126d2380131 ("rust: str:
> > add `CStr` type") in November 2022 as an upstreaming of earlier work
> > that was done in May 2021[0]. That earlier work, having predated the
> > inclusion of `CStr` in `core`, largely duplicated the implementation of
> > `std::ffi::CStr`.
> >
> > `std::ffi::CStr` was moved to `core::ffi::CStr` in Rust 1.64 in
> > September 2022. Hence replace `kernel::str::CStr` with `core::ffi::CStr=
`
> > to reduce our custom code footprint, and retain needed custom
> > functionality through an extension trait.
> >
> > C-String literals were added in Rust 1.77, while our MSRV is 1.78. Thus
> > opportunistically replace instances of `kernel::c_str!` with C-String
> > literals where other code changes were already necessary or where
> > existing code triggered clippy lints; the rest will be done in a later
> > commit.
> >
> > Link: https://github.com/Rust-for-Linux/linux/commit/faa3cbcca03d0dec8f=
8e43f1d8d5c0860d98a23f [0]
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
>
> > diff --git a/rust/kernel/firmware.rs b/rust/kernel/firmware.rs
> > index 2494c96e105f..582ab648b14c 100644
> > --- a/rust/kernel/firmware.rs
> > +++ b/rust/kernel/firmware.rs
> > @@ -4,7 +4,14 @@
> >  //!
> >  //! C header: [`include/linux/firmware.h`](srctree/include/linux/firmw=
are.h)
> >
> > -use crate::{bindings, device::Device, error::Error, error::Result, ffi=
, str::CStr};
> > +use crate::{
> > +    bindings,
> > +    device::Device,
> > +    error::Error,
> > +    error::Result,
> > +    ffi,
> > +    str::{CStr, CStrExt as _},
> > +};
>
> Did you not add CStrExt to the prelude?

I did, but I didn't add the prelude to all files I had to update. This
one, like others, doesn't import the prelude.

