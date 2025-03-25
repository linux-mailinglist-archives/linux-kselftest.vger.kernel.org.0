Return-Path: <linux-kselftest+bounces-29738-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5432EA6EE18
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 11:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBBDA16952F
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Mar 2025 10:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DF71EF09A;
	Tue, 25 Mar 2025 10:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NzpIbKkI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BEAEC4;
	Tue, 25 Mar 2025 10:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742899581; cv=none; b=ivQXGpLHMXX8jNxEZTW/n7E/GqQ+ebLfCYqtxLmlQOv8r3Qt8H5rvdb5zx0TQbfFkt29NdaOSbLYW+4X69CYbn0a9f1DrORZDCxGfJkFl4dKSyzdRAJKZDtOODqG3+lGhghJauJOgIg6imkI78pn7y8nfDlArOb/MQB+bkB6dx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742899581; c=relaxed/simple;
	bh=2FNYeomT71KgMuXHlZVXWtH4XFxIInQK18bvX+WzreA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kOYAV/7HwUfORLsMd4XsDN9gPkANewPv/v4HOXMY0g948EzlaqSuId9Ukqse47DvjrVP0TA7TEJoBrjvH72SjSfZN3xi70MGoOXtJ/WEOYu5UvptughRqRKoplK8HUEJsYddpWqvXzoeD0Lg0WwWQmYcA3MvpGyBsBsV2+NlF8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NzpIbKkI; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30613802a6bso56788941fa.1;
        Tue, 25 Mar 2025 03:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742899576; x=1743504376; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1y03yDy8TIpQcuFAWH67h1VizPaAxuPKN6wBSpHwrrE=;
        b=NzpIbKkIwRSafVFV+gaPJAZygUiBqPdtydf+9CI6WFVHzwd9FZ9eGyOGyCxaje01d0
         sY8K/fV0SU14XII4d3DIi7G9PinzGTzFONG3FvoVawDJ39piU+RxkK7slGJ9mPwgsTcB
         o9+03fchHP2X7ffXePFKP5FA1V0dRNSXRbbggY3hdgJbdBGibk1QqlB6znT0aRJD7YPn
         3bZnjJHNt2fikP7Wa7A5k2yMfhPLgodJjG+gVP3lLt8bczmYJig2r4nn4opMDJnaGe4L
         XdrKYqCZtCvVfkS48iPAaTVAxvcrCIMdcst7WRVvvRcD9CRtlvYSCm9ML3YmU8I94YwJ
         jLhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742899576; x=1743504376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1y03yDy8TIpQcuFAWH67h1VizPaAxuPKN6wBSpHwrrE=;
        b=j5fN+5AWPjSpoOq44BfSlbmMMa6BLfDoELK1TmXq97jVLDAeZEyxbP9Rhbn8PPYdWh
         NUY+1c7YMaKOXndukFVgLXlwsWgE3SgueQNFPkheSGzHxzhpolDlTNHtQPEnpDs5t1nl
         wlWh4jyFcN/5x3tbtZkpUvcQU8cHaU0KAOnT/x3JYRGPQYqtp2irZikSDQHjAX73YByb
         co9kZsCM10F7m3JtjDh0YxGEwEVzHsO114m1e6b07Et5I/egS7f7VrIoie5397f+vcNP
         L9pffr54edzD3wIS/wNErEbN62WYsKj1syNcU1XZssq1zf+z5s8JZ5O/iRWUA85Y+cU2
         E5Hg==
X-Forwarded-Encrypted: i=1; AJvYcCUItc5XQFctFi1vKukySWQj2jCVWSBMDBW5iRGWxVsiXA9Lm5jkI68pfXQ101xGPy1nk5or+XFe4AW0VFsT@vger.kernel.org, AJvYcCUWGfMD39FUm2qScYQhxLlo9hVl483Y2ia7kBSH0ITqkw23caZ7jvw5Fb4JmGjtqtGuwD670H+wicGA1Y8=@vger.kernel.org, AJvYcCVu/YC4iG0AWeCcKfZMaM8aZaLYerMrgoxwANhAxphw64/vRpQi4qw/ahksqRmMmyVL3zjaWTLkKVA9IzjeVe9S@vger.kernel.org, AJvYcCWHJph0BoYTXwXd7QeMqjU4Q42WEyms0klqeDSVisKO5f0+OI4ijWGLyBQcZ+HCRpGCOzJwfg06qQYJ@vger.kernel.org, AJvYcCWfNlM2eDLFe1AX37cl4UrNBCwgqHF2AdrGVpZTf0Uzhok9M4q5sN6LwrhZtC117ObHjtGMdSNy7Aj7S50u@vger.kernel.org, AJvYcCWhx4wTPG9+SGbgLOoiUwft6Sjp1zDuAva5iGiW5nXZh+WyyNFBBij/QTBsk92LzyIAgddKErLA@vger.kernel.org, AJvYcCX7UdQ62+AgpV/IBN4l7gmAEv4PI2vU5dXtxsAtjYbFwxuSjBSMoMDfWl6oOTq/AzUHPbiLSpvk5PXU@vger.kernel.org, AJvYcCXOrTRC0FOMc69UxcTCh3Hyt3DYe6UNXBHWVdKVAzhlWP8IW9HOi6El+DP9sZHAcTiyuEtUQziK9hiBS7SepBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCyt0WH2fKMjrD2OfDEkON/1j3/FoeO+a9sMMDYBEfTsnHsrzt
	cGMjChTgeiVxJZnslzX7WH7fwlbpBogparXQVYSqFos4NYyjsXavZmedwO657cd+OleljGpagNP
	f5R+4vJVMuGW1xNhQtbcLfbbuOMo=
X-Gm-Gg: ASbGncv7vzppAyQkBn3HRCDBf71n9N0iiuCj9OHnwFx6w8S4AjZ5k7mdGPiI25uWxzV
	lEe6I9saKwpN6GI7cINgDyqbpef+l6NZLNwyx/QLO8xyKvHyaCAXQkzqgeFZEJJ3KpIhkWIM9Q1
	yt8fdSUW56NOgIlbCUCJJMI4Ks/PNUKalpcJ5Sot/sAwBdFicbFNMtf9NullS17EAVzyOov0E=
X-Google-Smtp-Source: AGHT+IEeSFZcNncq+Hzrd6WJLKO5wQXJ5YPLXL3SpmKlQ5a2soAQyRH0mbHomADrM6Z19b8LkmwZD61xn1jA9K4yWjQ=
X-Received: by 2002:a2e:b888:0:b0:30b:8f84:49c5 with SMTP id
 38308e7fff4ca-30d7e3000ecmr55915601fa.28.1742899576246; Tue, 25 Mar 2025
 03:46:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324-ptr-as-ptr-v6-0-49d1b7fd4290@gmail.com>
 <20250324-ptr-as-ptr-v6-6-49d1b7fd4290@gmail.com> <D8PA773W07SS.3T2SZUIJH4HOH@proton.me>
In-Reply-To: <D8PA773W07SS.3T2SZUIJH4HOH@proton.me>
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 25 Mar 2025 06:45:40 -0400
X-Gm-Features: AQ5f1JoREcOZKZS-EjqFeDZFT-IOtHg2hx9DVULWtMdlFDlEyVW6GfpqQHdJRUU
Message-ID: <CAJ-ks9=1BOsd-edBH-ZsDLzhtX=YfvZPMHebX=br4Wc1K1V-TA@mail.gmail.com>
Subject: Re: [PATCH v6 6/6] rust: enable `clippy::cast_lossless` lint
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

On Tue, Mar 25, 2025 at 6:40=E2=80=AFAM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> On Mon Mar 24, 2025 at 11:01 PM CET, Tamir Duberstein wrote:
> > Before Rust 1.29.0, Clippy introduced the `cast_lossless` lint [1]:
> >
> >> Rust=E2=80=99s `as` keyword will perform many kinds of conversions, in=
cluding
> >> silently lossy conversions. Conversion functions such as `i32::from`
> >> will only perform lossless conversions. Using the conversion functions
> >> prevents conversions from becoming silently lossy if the input types
> >> ever change, and makes it clear for people reading the code that the
> >> conversion is lossless.
> >
> > While this doesn't eliminate unchecked `as` conversions, it makes such
> > conversions easier to scrutinize.  It also has the slight benefit of
> > removing a degree of freedom on which to bikeshed. Thus apply the
> > changes and enable the lint -- no functional change intended.
> >
> > Link: https://rust-lang.github.io/rust-clippy/master/index.html#cast_lo=
ssless [1]
> > Suggested-by: Benno Lossin <benno.lossin@proton.me>
> > Link: https://lore.kernel.org/all/D8ORTXSUTKGL.1KOJAGBM8F8TN@proton.me/
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
>
> One nit below, but you may add:
>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>

Thanks!

>
> > ---
> >  Makefile                        |  1 +
> >  drivers/gpu/drm/drm_panic_qr.rs | 10 +++++-----
> >  rust/bindings/lib.rs            |  2 +-
> >  rust/kernel/net/phy.rs          |  4 ++--
> >  4 files changed, 9 insertions(+), 8 deletions(-)
>
> > diff --git a/rust/bindings/lib.rs b/rust/bindings/lib.rs
> > index 0486a32ed314..591e4ca9bc54 100644
> > --- a/rust/bindings/lib.rs
> > +++ b/rust/bindings/lib.rs
> > @@ -25,7 +25,7 @@
> >  )]
> >
> >  #[allow(dead_code)]
> > -#[allow(clippy::ptr_as_ptr)]
> > +#[allow(clippy::cast_lossless, clippy::ptr_as_ptr)]
>
> Not sure if we instead want this in a separate attribute, ultimately it
> doesn't really matter, but why should `undocumented_unsafe_blocks` be
> special?

No reason. Moved it to a separate line. I won't respin just for this -
hopefully Miguel doesn't mind fixing when he takes it, if there's not
a v7 by then.

Tamir

