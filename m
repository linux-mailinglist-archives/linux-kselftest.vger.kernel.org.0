Return-Path: <linux-kselftest+bounces-29749-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B98E5A70287
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 14:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B41397ABAE7
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 13:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CEF225A349;
	Tue, 25 Mar 2025 13:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="af2z7Gyx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9250A25A63D;
	Tue, 25 Mar 2025 13:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742909734; cv=none; b=qlij7+YNW4GzyTlcmGXbpRe3ALI3XKF9jC3dUXlGlWgyzcTKMfLAbWGaGW1j3244bG9rBfU6QOjl8VEiF0d3fTCdUrFSwoLSBi9JOo6v9GYevK6lpEP8jpdX1F6iT8pfQbTmf0m0jo3XaJRiuJt5m81LrhgmUmbGwD/tjI8EO3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742909734; c=relaxed/simple;
	bh=Jtg89UmefE0wWanYzwMP6U6AO+7GLC3NTqvTljYcaMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eyAiVNxFQpBn15g45J/EorNxhS49KfNzamVRoJ3POkEAiMb+4cX36AUDFfH80Qil1u73+iKPZjVIdyESUnOkryrrnTTokmWCGJ7/UF3ijVESfZftxM4pMUrWZClS6Xj92Jd3Fg3JDvNLDZ5PgCvTjunnAKTejpyqNSscJxucxB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=af2z7Gyx; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30c44a87b9cso48747981fa.3;
        Tue, 25 Mar 2025 06:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742909731; x=1743514531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ALfQyNQQvFgRQBUL1jyOJUKyoIc+aRMgFQDSk9Ni8HU=;
        b=af2z7GyxE3T67vJtSyDctk5Se9D/ILNHkUUR4hxgNNWHbzIuHna6HVwVRelJid3NTN
         u8jch5QRCQBsAf43ZVEaSHSoOf/mV2BDpc32vvyu3Eqp7jku1IpLvbH7osksgsa5l3E6
         tEgW1xyMLm94E0xQVS3+Y2UwKc+2j9E9ZvsMJl6s58BX2zONGKtY0Zm/J3YVO3jAD9LN
         EuLcAfrg3YcLeT+p/qk66Wz9iVyNKwyXK+CJA2ae77FWtBbORNFlcDQReoC+G8iQDKiE
         UMUGwthv9GwCXxQiTVTsuE3SMbSyLOofX7YVjdncO+GObYku9s0jnWqF3h9kLBJ8cLu2
         aeNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742909731; x=1743514531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ALfQyNQQvFgRQBUL1jyOJUKyoIc+aRMgFQDSk9Ni8HU=;
        b=C4vlwm5U7/3KNk16sbIiLf2rHwVxIXjeaW3FXDJJAUa5C4r9kl+a2HJnqHL6qq9VcA
         OF4jSXdXUM4InUnuDJAC2xBs2lT70U304gtq/VDBhYwHi5M732FBCylqn2K3kEcCzzF0
         jh53vk/2yHd9zt1Upoi1ANZj1pD+er6MDVTp7Aj6EfaD1WFkzQKaso/oZrzEDIUFKIrw
         0LazGdQrcA4cismv57wnkoROaELYS53H/3yMQi/tya60mM0GG7l9tfwRJ3DQKu46LYCq
         0QdDp5i85m5dka5PFduHBO2QJcJOSiBxV/mgs3kW/RlTxhvTSeiO98KOFrV0R69aYPil
         T16Q==
X-Forwarded-Encrypted: i=1; AJvYcCU4GIihZ+SF2d3Mw7sf9EP7Hs4PldNRn/KJTMQlZWk9YjHDGjyT36lFBhtl3vbTv26T9u2lcToGkGj4@vger.kernel.org, AJvYcCUkQit1KbCLNQ4aUPC+PDLhk8aYAn17q9D29e5Cp97Cz9vnU4sYV4BKH4hAI0sOhiJYeefIe2c+tLOeyDaDhtcS@vger.kernel.org, AJvYcCV2LjxP4qr802MlRpYpj61brQnU3o/0y1Zxhok9ljK3qvcunaAMW5y/HNaGEF+7DPj44hZ+tGXd1ai47DlL@vger.kernel.org, AJvYcCWn2A2oiAOJyIXJQ32b7BWusr7/Vw/LvxGcUBP4OfQTPU3i1fldJEELHk++WdUjub548KA8GEFjc1AAgxE=@vger.kernel.org, AJvYcCWys1Fr/JPPXwH3fvmmgDai/+pExtN295j0B6Psnl/yDuXRiXXsMKx7sIiyKByx7znQqSD/oqsPrpEe5WSX@vger.kernel.org, AJvYcCXEcWXMGYxZ7EiGWe4iwn5zXkacTUKOVfqcN3QtAgSoeGp+ivuUDiwm4Xolg+HyQtkRFT94l6p5Q0Fo@vger.kernel.org, AJvYcCXpO5IIfsytvEBYRYkfIbV3IUAFN5BRXHdnoaliNX2oo57efYDrpRzqgqejmwbsV3sTOuvS4C9eBv18uu7v4Fc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUVLzllI8j9/hOcr5GOrcRVNbLYPQlTJfJ3MSDMeTf19na1Ei7
	QreYeLylq1XPE+ikSGCCjwiOecfbYiecaUIJ0HrnUUVWHy/Nn7cnB2FaqfSrFvzDTx1p8JzReqQ
	bOwLhj0PE8wj8nDS/ohboNpl7PSQ=
X-Gm-Gg: ASbGncs+PUbeScfMj9TaGdTNNcyh8WAQRxwSv/sm+TADjlPYyZP6qHDCp8pxcBE1S7h
	zeUks7CFIh58QfZkHHwLIE8Spn2+xOfutc+KbA4DCJlEu4lgMRxcFW9mhnaynCqtYMLK4cjEOvk
	sGF8hC7BYGOUSaO/A+LQShcfGhSd5qRFrPf/C4Qy5+Vw==
X-Google-Smtp-Source: AGHT+IECfGJfPNX5mp249KVYKi7WWwCgZRCowQMjfUUxWLTD3q612os114yT+G0eH07umrgjJmQ2EnRvgj3jg2xq8Js=
X-Received: by 2002:a2e:a99d:0:b0:309:17:750d with SMTP id 38308e7fff4ca-30d7e2a1829mr60147611fa.27.1742909730314;
 Tue, 25 Mar 2025 06:35:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317-ptr-as-ptr-v5-0-5b5f21fa230a@gmail.com>
 <D8ORTXSUTKGL.1KOJAGBM8F8TN@proton.me> <CAJ-ks9n-z0SETz+zBfJmda6Q_vJDeM2jmDXx48xX9qpMmR-mdQ@mail.gmail.com>
 <D8OTXLDQCOKI.34R1U5R0JSB8H@proton.me> <CAJ-ks9nc0ptzfh+tHj47aTCMqoaKB0SnGpZOLQ06upt7x8EBMQ@mail.gmail.com>
 <D8PAQXHJDVQE.36QKQGBVVL4QU@proton.me>
In-Reply-To: <D8PAQXHJDVQE.36QKQGBVVL4QU@proton.me>
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 25 Mar 2025 09:34:54 -0400
X-Gm-Features: AQ5f1JqRBixAhWSLEtDtEmMqzrYYyJsJMIA4qKRXBi18aYKgJEGRcFDgouTR9-A
Message-ID: <CAJ-ks9kuG8SyybioKQ0+bYwjnCQFMhip+4A1WnMhsdgnNZGiZQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] rust: reduce pointer casts, enable related lints
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

On Tue, Mar 25, 2025 at 7:05=E2=80=AFAM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> On Mon Mar 24, 2025 at 10:59 PM CET, Tamir Duberstein wrote:
> > On Mon, Mar 24, 2025 at 5:55=E2=80=AFPM Benno Lossin <benno.lossin@prot=
on.me> wrote:
> >> On Mon Mar 24, 2025 at 9:55 PM CET, Tamir Duberstein wrote:
> >> > On Mon, Mar 24, 2025 at 4:16=E2=80=AFPM Benno Lossin <benno.lossin@p=
roton.me> wrote:
> >> >> * `cast_lossless` (maybe this catches some of the `num as int_type`
> >> >>   conversions I mentioned above)
> >> >
> >> > Yeah, suggested the same above. I had hoped this would deal with the
> >> > char as u32 pattern but it did not.
> >>
> >> Aw that's a shame. Maybe we should create a clippy issue for that,
> >> thoughts?
> >
> > Yeah, it's not clear to me why it isn't covered by `cast_lossless`.
> > Might just be a bug. Want to file it?
>
> Done: https://github.com/rust-lang/rust-clippy/issues/14469

Nice, looks like there's already a PR out:
https://github.com/rust-lang/rust-clippy/pull/14470.

> >> >> I'll leave it up to you what you want to do with this: add it to th=
is
> >> >> series, make a new one, or let someone else handle it. If you don't=
 want
> >> >> to handle it, let me know, then I'll create a good-first-issue :)
> >> >
> >> > I'll add a patch for `cast_lossless` -- the rest should probably go
> >> > into an issue.
> >>
> >> Do you mind filing the issue? Then you can decide yourself what you wa=
nt
> >> to do yourself vs what you want to leave for others. Feel free to copy
> >> from my mail summary.
> >
> > Well, I don't really know what's left to do. We're pretty close at
> > this point to having enabled everything but the nukes. Then there's
> > the strict provenance thing, which I suppose we can write down.
>
> Yes, but there are also these from my original mail:
> * `shared_ref as *const _` (for example in rust/kernel/uaccess.rs:247,
>   rust/kernel/str.rs:32 and rust/kernel/fs/file.rs:367), these we can
>   replace with `let ptr: *const ... =3D shared_ref;`. Don't know if there
>   is a clippy lint for this.

I don't think we should go fixing things for which we don't have a
clippy lint. That way lies madness, particularly as patches begin to
be carried by other trees.

>
> And the other points (haven't taken a look at the other series you
> submitted, so I don't know to what extend you fixed the other `as` casts
> I mentioned). So I figured you might know which ones we still have after
> applying all your patches :)
>
> ---
> Cheers,
> Benno
>

