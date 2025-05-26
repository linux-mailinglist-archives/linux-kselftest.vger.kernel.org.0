Return-Path: <linux-kselftest+bounces-33822-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4DCAC4533
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 00:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17C9618986AF
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 22:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B731E9B1A;
	Mon, 26 May 2025 22:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jAf/5M8z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BD1176AC5;
	Mon, 26 May 2025 22:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748298626; cv=none; b=PYOnu9GAvjx4lRys2MICAdgB0KZXZu5z4Eo0Rxth4rOJJhLzuqvp9eo4+akRZR5cC9tzw1x8vSRrz4m/ARGiSjv7Y8T4RfxkXxe5xNAe2jpjCSqPeVWr5kPVh9+/Y2/3xk2CZB3WLcXJJpnw8GbRWciR3yQpr9EvaG/wIbt3Gy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748298626; c=relaxed/simple;
	bh=P7IpezzEQW0J+xvr79pZ7xwPmXCfC2utnBP44H5MHuU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CNeYaYPDbveNfjoS72xn5ElAZH5jMYNRWoAXpJS6BrFrVtAomR8JhOXhG/qVgnNnMMW1At7Bf9VF70kMswyJAREV6LygdHBOtbCSqiYErO7L5+vXvlqw8/8OY4NwKsl1YBALS6vsQcmZjBnE+udp8LXqDgF+quFpOABfRpi6LHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jAf/5M8z; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-31062172698so26343841fa.0;
        Mon, 26 May 2025 15:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748298623; x=1748903423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DeRtQfopGgqdSMrju5Mssh4B08QuGYql7A9ITbZgjgA=;
        b=jAf/5M8zh17bXmaacVOKZIFT2fXRvYs2eZb26p4rNyUwjTLlLYCSETyt0h/zLsLjDq
         leOmR34YGdIdP2QSxS8x9wFY6SmAiHIQuo0M1Q0B2PU91p1DpHkw5qHXSEN2j/i86OIe
         Q5/BJ+gbstOpk7aayfBzD4vR7wr1U4ltZIaS0pgaIF92FQq66qhdnmGkr7l5XHe1mVdR
         tQ1FQl4/50JfOUUm9842cjiZZ1SlwNiLkpSDvu3WQ/LuQNP70vNVhclfMomYcZK4Frb5
         8CIV5L5I2W5pTHyww8p/UgCQsDzuwB9P3DcrRF09V3jr6lwFljXCX3ytJ2lW6DfiuDQ2
         5mKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748298623; x=1748903423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DeRtQfopGgqdSMrju5Mssh4B08QuGYql7A9ITbZgjgA=;
        b=NJoBKlHXId6hh2nD/cir3JEkd8vZuLc5gAY8QIJuvtZECjQ2woKxuUgQ6ryv5XcjyJ
         3p908Whw2TgE7kYgXdXRQiH0OJ+5TqTRS4wkmrgRax3tMqZy7Uy9yYpbHC7aFZGMa8sJ
         Ys2CQUKPFY32Z8VrgxeExXKKKVFFr/UNq1UAdMvGbe9ujejFXgjwa4h1qYnUjtsbYZxN
         8RwnBCm5ikTyDqcoAiaJMh/8iFXnaTq5AWDFmzj2cJod8QuuGYHjjXKfGU9R31ccAQPV
         Qog+ZymUhtCwOP7qxnKiK7Gi6qWK9BS6jURgiNdQPWuXYmEsM07SA8XBoO86fAw8TZ4G
         PPhA==
X-Forwarded-Encrypted: i=1; AJvYcCUG9K0kbfrCun3hLZPSfmooZPhFIJjjZJxlxJYyIf0PGfbMqLg3WUvo7TAbuxX3ZBi0cmDgF7g6dCJC@vger.kernel.org, AJvYcCVBy3LuJMQpswdcFUFso5hp8eRb9eIge3VQTzutCaMpPdbhOpQ7jrKCLqaErmkkg9o2kE7K+sP+zXcN318dq7Dz@vger.kernel.org, AJvYcCVorkrf9LP3GbK7a/ddpvlofNkyvUhRuQr6ebTcFD1Vbfg5ZQ5pIp23mwRYmAR4ZOEYIGc+f+zXcHmi2ZFX96Y=@vger.kernel.org, AJvYcCWcHnlMf79jZqNWqkFQp/ZYUFNWkSqiXSVzoxLGAysJu1fy5015X/hWwYG/3WN20Z9P5apM3Mpc@vger.kernel.org, AJvYcCWea1Vi5Q73DkjKkP5FDj6hieFc5j+N2skAWHz8dyMVVf5fJs/S4xRLPEIF/bmm4gSsv0MK9NmmKuYq@vger.kernel.org, AJvYcCXNCFiBswBo5rNXhqO34XMtYrX/VJCJcNsJzi2GcjWKZKquaLB8VvY7Tu6er1Sdru4v+KhqoMBzW7Y7RA8e@vger.kernel.org, AJvYcCXahuKkJJ6cRR05FEgi9J4WtKInkgUAIHlTFKZc94lDF2HoxP3qGCIeRcuBhkEsHSNsteEpbNNRf/v7FQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgQIwtTRGkuQV1EjiIl/CQDUa0Ccn+pfxMn0X95VjGOl875gV1
	HmCMwBQ3Ig4yMuaxNW/L98ADzAPYWrkSRQw+YIx6hqnLDSTd3tMPmEU1g5oEx0fWrFkNoDvfsh7
	FaX7zKx9LaRLM8cboLJsI4RkAUXJGmoQ=
X-Gm-Gg: ASbGncuyH2GVjFn3REWffQwmFi9ePnnFQRcP3srUm+yH6ey3I90eDhBHzZEwwvgBi3q
	V2vDajoAQCHR3qWDbdeLnvQrjQv7e5ATjjXO+Fu1KL8c8yTa1FBn6dU1BTVRe9JMcMJSr1Z+wjJ
	wx1hDcrSDVLPjOUm7yECIeahEvIj4Qcj2z8b01ThT/GWTwYc0+3yuUhnlsP3EZQhIgG+0=
X-Google-Smtp-Source: AGHT+IHobXPM6nV57q0LkxjWMI5y+a9fqFFRAaaAVdT/IiyU5kBtoHLbzkKYgFh6GOZFHTnYbitctcnCYMHIu3rZzy0=
X-Received: by 2002:a05:651c:1b11:b0:32a:6bef:7587 with SMTP id
 38308e7fff4ca-32a6bef7741mr3018881fa.20.1748298622556; Mon, 26 May 2025
 15:30:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250524-cstr-core-v10-0-6412a94d9d75@gmail.com>
 <20250524-cstr-core-v10-4-6412a94d9d75@gmail.com> <DA66NJXU86M4.1HU12P6E79JLO@kernel.org>
In-Reply-To: <DA66NJXU86M4.1HU12P6E79JLO@kernel.org>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 26 May 2025 18:29:46 -0400
X-Gm-Features: AX0GCFuvvdq9fWPFcsB31U1UA0LVEWVFnDG5B-zpmEiF_aWL5P9UrGYE0gqlG8U
Message-ID: <CAJ-ks9nd6_iGK+ie-f+F0x4kwpyEGJ-kQiQGt-ffdbVN5S6kOg@mail.gmail.com>
Subject: Re: [PATCH v10 4/5] rust: replace `kernel::c_str!` with C-Strings
To: Benno Lossin <lossin@kernel.org>
Cc: Michal Rostecki <vadorovsky@protonmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
	Danilo Krummrich <dakr@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
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
	Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, llvm@lists.linux.dev, linux-pci@vger.kernel.org, 
	nouveau@lists.freedesktop.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 26, 2025 at 11:04=E2=80=AFAM Benno Lossin <lossin@kernel.org> w=
rote:
>
> On Sat May 24, 2025 at 10:33 PM CEST, Tamir Duberstein wrote:
> > +macro_rules! c_str_avoid_literals {
>
> I don't like this name, how about `concat_to_c_str` or
> `concat_with_nul`?
>
> This macro also is useful from macros that have a normal string literal,
> but can't turn it into a `c""` one.

Uh, can you give an example? I'm not attached to the name.

>
> > +    // NB: we could write `($str:lit) =3D> compile_error!("use a C str=
ing literal instead");` here but
> > +    // that would trigger when the literal is at the top of several ma=
cro expansions. That would be
> > +    // too limiting to macro authors, so we rely on the name as a hint=
 instead.
> >      ($str:expr) =3D> {{
> > -        const S: &str =3D concat!($str, "\0");
> > -        const C: &$crate::str::CStr =3D match $crate::str::CStr::from_=
bytes_with_nul(S.as_bytes()) {
> > -            Ok(v) =3D> v,
> > -            Err(_) =3D> panic!("string contains interior NUL"),
> > -        };
> > +        const S: &'static str =3D concat!($str, "\0");
> > +        const C: &'static $crate::str::CStr =3D
> > +            match $crate::str::CStr::from_bytes_with_nul(S.as_bytes())=
 {
>
> Why is this still our CStr?

Good question. I'll just revert all the changes here, I don't need to
touch this.

>
> > +                Ok(v) =3D> v,
> > +                Err(err) =3D> {
> > +                    let _: core::ffi::FromBytesWithNulError =3D err;
>
> Is this really necessary?

No. Reverted in v11.

