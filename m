Return-Path: <linux-kselftest+bounces-28781-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 830AAA5D0E8
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 21:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 193C13B1A24
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Mar 2025 20:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7372F264A99;
	Tue, 11 Mar 2025 20:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMS6SPfj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D07A264A87;
	Tue, 11 Mar 2025 20:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741725891; cv=none; b=U37ixX+125PrXaDpBlLpY/5xmU4L+dqED2B/jDs5YbA8Alr1DoBP9UDE840WrxI2gGxMN25pbwKSzKKZfBT4w89obKsnSZLPK/jM37j43+IFNXmYQdtbNjdB0a9jnBt9g2Ua8Kf/yDRB8D1vY3K26LHpuHmmDoDsKK991opebt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741725891; c=relaxed/simple;
	bh=5L8IANelHOxBjXBUu5dZfDsUSMGYSsqPKkO9bJkFzr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qCS8iCyku0YWT6kxQWAofvvlQ1oaAiCi0+KXeuasagAYXSIXs3EN3/yIlEf0EgStKC0M6T2rEaDCqhiW8sr6sngk7Zhthcs3OBIIp3Bog7AmrpxDju7qLd7Q3tNAk9CyI3aM9xcfgltsFENMEb42JO5LeBlEOpVo2gSrcdDo6qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cMS6SPfj; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30c2d427194so5683591fa.0;
        Tue, 11 Mar 2025 13:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741725888; x=1742330688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=duEJ7EHRSllGfBF79uawWV3Uy3v+U7kXTNnhgt38XQo=;
        b=cMS6SPfjoUR38JgDMJ0mS9Qxo/56jkZiDRRvdll9jVI3T9wvqsL2fc0kJAsfsnl1/T
         Q5lhbRrvatBj1NTno8p3NPXgBTH8ZQ5f08Zz8XIfozlUYA1A0manhu24iGTsMFepJwsW
         KEQAe4x6Yf0CFe+vFFHs5j+1oI7q9b8kF2oLY2I3Rpq6dS6hfFXviqlc/82wOFITViki
         J9VZmUNkPM64CV7yHdYYKn9xVsvWRyEDz5kWVykMMFL39qq6MxlpasJH+WkWLwUZgXg5
         R5uWF+4qzXqYooBnHHwdKDbTmu8Dw8UJj4YfosVu7AkGnvoPAIOz1QfBVqhMvznGihH1
         iDlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741725888; x=1742330688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=duEJ7EHRSllGfBF79uawWV3Uy3v+U7kXTNnhgt38XQo=;
        b=ku1UAiWGDF60YwIr491Al1LIIRZ67GANACDI477G+edvNpN5hWQamOi6Wl69VCdt/x
         odV1DXuiwgSg+UtXMa3KrdMAonR8vd/zRhJYG/Gl21dETkngnso+McUwqCoiEJRUZPEi
         p+GMlMGvW6ZCMrDw6FaFlKd3zfTaexBSIr8fxOhCf9MJCsqTWa7qzVSiBEqMOyk/q7CH
         gtVaA2r/1qjFEkHKxTRjCyETXwL8jNWLpFkwFQyDrmZh36VmTa4MExOkvO/Hn+A+wzj9
         pxcTv0X96mxG1SmsTifQaCWNtpj1hE2/mSkKgrkCa2eqI43x5Xjzu2TVkSeoIcDwQLLN
         +iJQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7+LohHNDG+QrVUV1/uKl3fWiHsztEZzkBoom9oYKZT8lWupwRWNr+/Zma0UKve6ekf/I0DOvnyeFgZ+g=@vger.kernel.org, AJvYcCWAcxUQGgypgzKn/KDWsyn1SUCkOWyuErWCGZXOTtrQTNXTT9mSnVXL3RcF3rg17nbyLUsiaaijGzDVeJtr@vger.kernel.org, AJvYcCWk3AhSB69arKHr7XzmR/BiGIYT0BNfVSEkr1dB7ZidywodNe/nfrLccLs9pPIXaF/sBB3SiXmu+g5z@vger.kernel.org, AJvYcCX2fyPls5/6eqIQxhtenZPF6xgu51IBmYoX1luByMeZ+U9qbO1uofZwGCxKYxF/Xg3ZzC2OE5SWndA250n/1d0=@vger.kernel.org, AJvYcCXLGB7ZlV9ippezhYYaDhQcXK4HnDWkEHjM44uwUcs2durRqPqL8jpKeAaG+OH9RgRNSZXazY1g5RkcfBGjrtk9@vger.kernel.org
X-Gm-Message-State: AOJu0YwqWRN5PCAKlY41NoYTejbWpt0qkhbKK87HaL5gVkiD0KQLzbXM
	XjA3aRKQzqyrgfgfRrlzwgoZPCKGp6UBYQCOnvRslhNSEel+fbGZaT0BX1rL9m7V3T0UngI7/pc
	p1C+Kt9uR3yQQVyQRcuqkTROqSfI=
X-Gm-Gg: ASbGnctXMEoB841mzhX3k7VeeO59JVb6D/liq0XFxZ0IyHhC+LIltkBF3nU3gz43Zye
	eUNnISuK8yoCPi6hgBuZiD/YmSlTgah/zCCiOPvd/1ZQUCDfXJovSBSmDBrd3+Dw/1kfUEXbHo3
	cln8FNIZMfOglhZA0mQnTLJgK48/LIJMKQDygmXWWFCiMseeCBVHjLMFcNalaO
X-Google-Smtp-Source: AGHT+IG+EedxjC46NaiJ6woC0q3jeU1QYfuO+EC67MspCOQYOYTyXma/NtrOrk8P1gqUOUHGpPUfHHEJRfzzFrm3JYU=
X-Received: by 2002:a2e:7a0a:0:b0:30b:f52d:148f with SMTP id
 38308e7fff4ca-30c20696d86mr19501461fa.18.1741725887429; Tue, 11 Mar 2025
 13:44:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307-ptr-as-ptr-v1-1-582d06514c98@gmail.com> <202503120332.YTCpFEvv-lkp@intel.com>
In-Reply-To: <202503120332.YTCpFEvv-lkp@intel.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 11 Mar 2025 16:44:11 -0400
X-Gm-Features: AQ5f1Jrp6VrC5oCAzv7mIYSclKLK180WdY1BUpfSs2ZfWgyDm-P9M5sBgjdaKuA
Message-ID: <CAJ-ks9mkbs9KG5D5yETvOJfeqyzTts1gVZyNAogbxjXbwOreZg@mail.gmail.com>
Subject: Re: [PATCH] rust: enable `clippy::ptr_as_ptr` lint
To: kernel test robot <lkp@intel.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
	Bjorn Helgaas <helgaas@kernel.org>, oe-kbuild-all@lists.linux.dev, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 3:22=E2=80=AFPM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Tamir,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on ff64846bee0e7e3e7bc9363ebad3bab42dd27e24]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Tamir-Duberstein/r=
ust-enable-clippy-ptr_as_ptr-lint/20250308-004557
> base:   ff64846bee0e7e3e7bc9363ebad3bab42dd27e24
> patch link:    https://lore.kernel.org/r/20250307-ptr-as-ptr-v1-1-582d065=
14c98%40gmail.com
> patch subject: [PATCH] rust: enable `clippy::ptr_as_ptr` lint
> config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/202=
50312/202503120332.YTCpFEvv-lkp@intel.com/config)
> compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b=
5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20250312/202503120332.YTCpFEvv-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202503120332.YTCpFEvv-lkp=
@intel.com/
>
> All warnings (new ones prefixed by >>):
>
> >> warning: `as` casting between raw pointers without changing its mutabi=
lity
>    --> rust/kernel/firmware.rs:64:35
>    |
>    64 |         let ret =3D unsafe { func.0(pfw as _, name.as_char_ptr(),=
 dev.as_raw()) };
>    |                                   ^^^^^^^^ help: try `pointer::cast`=
, a safer alternative: `pfw.cast()`
>    |
>    =3D help: for further information visit https://rust-lang.github.io/ru=
st-clippy/master/index.html#ptr_as_ptr
>    =3D note: requested on the command line with `-W clippy::ptr-as-ptr`
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

Indeed missed this one because I wasn't building with
CONFIG_RUST_FW_LOADER_ABSTRACTIONS. Fixed in v3 by:

diff --git a/rust/kernel/firmware.rs b/rust/kernel/firmware.rs
index c5162fdc95ff..74df815d2f4e 100644
--- a/rust/kernel/firmware.rs
+++ b/rust/kernel/firmware.rs
@@ -58,10 +58,11 @@ impl Firmware {
     fn request_internal(name: &CStr, dev: &Device, func: FwFunc) ->
Result<Self> {
         let mut fw: *mut bindings::firmware =3D core::ptr::null_mut();
         let pfw: *mut *mut bindings::firmware =3D &mut fw;
+        let pfw: *mut *const bindings::firmware =3D pfw.cast();

         // SAFETY: `pfw` is a valid pointer to a NULL initialized
`bindings::firmware` pointer.
         // `name` and `dev` are valid as by their type invariants.
-        let ret =3D unsafe { func.0(pfw as _, name.as_char_ptr(),
dev.as_raw()) };
+        let ret =3D unsafe { func.0(pfw, name.as_char_ptr(), dev.as_raw())=
 };
         if ret !=3D 0 {
             return Err(Error::from_errno(ret));
         }

By the way, it would be great if the email also included the rustc version =
used.

