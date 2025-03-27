Return-Path: <linux-kselftest+bounces-29866-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E4EA73422
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Mar 2025 15:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52D153BEAA5
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Mar 2025 14:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B96E21770B;
	Thu, 27 Mar 2025 14:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5Q8h+WB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58ADE1ADFE3;
	Thu, 27 Mar 2025 14:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743084979; cv=none; b=brJxQZl2lCAzto3UZ70op87v5FPEZP7V83tZ11IeuENUrMGMkHWYiheJY1o/xF8i2XpDWxA62fp8lAvW59rMbsHu0FNDgR5PaeZ5cMN8H8C1gkkhWBMQYoCT5PvjWMGV/WHNpsx4wUCwv/m0QTkNb5hmx0myTnor/n4fO11stYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743084979; c=relaxed/simple;
	bh=qmMBMM3UrIcbtHB3q5A5wIgeJbIGmGRCXOZxBsmVs9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X61ZLOhzcRsCQwRU9N4BFWooocA0OFD0DJSdh2i5yTahy3qhJ4Bo1LpgAIenN7qhf3nOj7GG/ecgMdqFg0A57EuZmEfPPicVAVW9O+kp9H2h3r8g4aIlbYuef7MnFFiNfhrjArOPUrk6+hbkeYafnRy5cxfHNMLQbq/WlovauFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i5Q8h+WB; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30bf1d48843so9798081fa.2;
        Thu, 27 Mar 2025 07:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743084974; x=1743689774; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i9M6C9E5diSoPsICencuKBeyAWQFDJEzmaVuf3K9CWQ=;
        b=i5Q8h+WBi2CrTBt9UoyOI7KsCe5qbQzRRWq7WgFLzIGVyuSe1zpJiEIm5rfI5nyBHK
         l5w9F2fLN82srXPQryp2cVyOXeUFPHl9FBvhQkEV7/gHrdpjzP6gAn0kB/84xB59JPBh
         qiSS6F7MjSQ2TnJigNH3dqjMCm79LTCWNI9+biQKkxrsSIBWoU/iVu+XPf0dNsATA2e1
         kfoa22ZHWw2pWzp6/o/rA5oXtXheE4vkhNaTBdlgg/9e9QGVokyLuDFVj5C2UZA9TSHI
         TCkySEeVwFS+dd0Q+R74XYxTwynhG++tU4ThlexVjETx8eBQeMfiBp8oJ7lUwCBUWUrr
         o3+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743084974; x=1743689774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i9M6C9E5diSoPsICencuKBeyAWQFDJEzmaVuf3K9CWQ=;
        b=lRJ2Tksdu5Mc0QktnmO2P2Lvuutv3+R86ont49YkG41slyk7l96bm0EG6cYkadqlhH
         w3QJWmCaiNFU7NfcP5pdwqyylY575jzvIg6SJbc+fZiaTZxMQJP+xm4h9NHTd0VAnoBk
         S0+Pnpr9zdzKYMeeV+bXpn+HI7IQesQd6g+Ihnyp9HIyPu+zao/qFWGbDe2ue96RuH3a
         DwdtWpI8BoVlqmOcthGDNWJ0GuYhOazsyw4Gpko98z8XNytB2OmQNtsX/cXyuh3/HkU+
         wP2fjcTDB3/Fq2bgRXXWjcsOwHqK59BLX4U7RyYx+HfQ77HO815pkLaM/a4LbvhVdQoD
         3Ymw==
X-Forwarded-Encrypted: i=1; AJvYcCUX12dXbZfxJJiDb0V2m3NyvNg79FJ5GSkyiiOfR25mtpSr9/9kvURtveQoZVbdCJ22wXwPd4PX+oVlyRBv@vger.kernel.org, AJvYcCUzzeJVTQJqtzGjK53OnRciNd21I7Uy/N7eW43dP1bHBx4+qGjhxWAzYrEFxIsYyuqtWNN5wV4Dh4cm@vger.kernel.org, AJvYcCViRl7gDISVFpVgAbJDgVg8aRqevAnx73BchE6VIjVMdNr2Y5nlCMkROcGH5tRDQT4KgdMwj7iD3y4+n/E=@vger.kernel.org, AJvYcCW26vhnp3IF7uV3PtsNPw+0gP+6ZneU4038tJ7A+Z8fb6xAdk8LwaEJZ4axTKz4+mCENt6M1SVn@vger.kernel.org, AJvYcCWG0iTbARWXbPtfbFIwYqwEjDPS4nmldNlmDuu2/sX+NfTWfOMDeQjxISm2+YbFF7vhGDToOoNciycbxX+s@vger.kernel.org, AJvYcCXGQL2UAWYEvTEhke6Pd6/1/tJy0wxF4P32G9zVJIxoKGd0vwr4EuBBtg03XqPXK3QKXkgtCjcPE3Ug@vger.kernel.org, AJvYcCXMrdEO9+Z9YG7WUuCpGXvNBI0SLVeRL045AppyyNlABWQ8TNsPmdWVDnzWKm29qIwjR//ulFuHhKBp7I8jtZIt@vger.kernel.org, AJvYcCXURuzVKYLHdsmNYUhcVNwf6wGZEIGI9zt97i1JFot/UAUCZdmHgfF2KHRRi9DQ7pO+bm232nrbNRW6/GfQAOo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgQd5D1q5x0dA2Nii+oePVw4aF+84Yx6NJDybvyAbb0vCFYy3X
	eYCzln9bQZNWcBcHESPruzwouBK+W3FX13IImMysyDt2uoiZuGd99ceRzIE1l/IsWt0lOngVIqx
	NKf4rK9IxRnduzPOIVsyxK1BePqE=
X-Gm-Gg: ASbGnctXMURHwYIsvo2EqmjQ8OJ6C30vW6UXifkxeKkuUQTm3AKnogsHR+SiuX4ahJ0
	vfwre+hTM8gCtykPevGTHePWh/EDkhXm91LLIXWpits1d6x+NrZDYgDa8aYShRVsFfLTgrw7kzY
	bVkau9LFFNcEguMe/16W2t9AHFVNuLEZ+4K1bd8Hgg+UJNHpb5XNdS
X-Google-Smtp-Source: AGHT+IHjppBBD1opK0cTIwYQL2MZ5xpzZ9akB5zDDLt1b7/nuVFx0XppIv3k3NpUnr+TUWw12KrQXCArIl36za09rHE=
X-Received: by 2002:a2e:9997:0:b0:30c:460f:f56 with SMTP id
 38308e7fff4ca-30dc5e5c919mr13153081fa.20.1743084973460; Thu, 27 Mar 2025
 07:16:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325-ptr-as-ptr-v7-0-87ab452147b9@gmail.com>
 <D8Q4MSXXZ7OI.1NC226MO02VSN@proton.me> <CAJ-ks9nHKpQPuSBypXTSATYhbAFkQTJzUq8jN0nu4t=Kw+0xxg@mail.gmail.com>
 <D8QCK3CQES3Y.3LTZ4MVO5B3KT@proton.me> <CAJ-ks9nKT2PUDm6=b4AB1QUWwwvcqPn7Vz60=c0B+uFMZrqPew@mail.gmail.com>
 <D8QDOBUM6NF0.CGJY7ZA5KD9S@proton.me> <CAJ-ks9ntTxBM=c5nUZWGv3MoRt-LveBchn-c1Xy-DGap7fLVRA@mail.gmail.com>
 <D8QI804Q3DAS.2BV4WSL81H52Z@proton.me> <CAJ-ks9mA5QDeZ3EvOD3THayFt4TtDysgm0jp2aiSF2mQCrhWiQ@mail.gmail.com>
 <D8QJMH5UR6VG.2OT5MXJJQU5QT@proton.me>
In-Reply-To: <D8QJMH5UR6VG.2OT5MXJJQU5QT@proton.me>
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 27 Mar 2025 10:15:36 -0400
X-Gm-Features: AQ5f1JplRmZYTNFbnfGLzU2zYeyjxmbSnSHIdkKg-vmw1A2gTwR43LO2IWo4jk0
Message-ID: <CAJ-ks9m96vf_HxttuopuC_UfNGJbHHNdEGS2er6nZZG38pe3HQ@mail.gmail.com>
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

On Wed, Mar 26, 2025 at 6:15=E2=80=AFPM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> On Wed Mar 26, 2025 at 11:09 PM CET, Tamir Duberstein wrote:
> > On Wed, Mar 26, 2025 at 5:09=E2=80=AFPM Benno Lossin <benno.lossin@prot=
on.me> wrote:
> >> On Wed Mar 26, 2025 at 8:06 PM CET, Tamir Duberstein wrote:
> >> > On Wed, Mar 26, 2025 at 1:36=E2=80=AFPM Benno Lossin <benno.lossin@p=
roton.me> wrote:
> >> >> On Wed Mar 26, 2025 at 5:57 PM CET, Tamir Duberstein wrote:
> >> >> >
> >> >> > Yeah, we should do this - but again: not relevant in this discuss=
ion.
> >> >>
> >> >> I think it's pretty relevant.
> >> >
> >> > It's not relevant because we're no longer talking about transmuting
> >> > pointer to pointer. The two options are:
> >> > 1. transmute reference to reference.
> >> > 2. coerce reference to pointer, `as` cast pointer to pointer (trigge=
rs
> >> > `ptr_as_ptr`), reborrow pointer to reference.
> >> >
> >> > If anyone can help me understand why (2) is better than (1), I'd
> >> > certainly appreciate it.
> >>
> >> I am very confident that (2) is correct. With (1) I'm not sure (see
> >> above), so that's why I mentioned it.
> >
> > Can you help me understand why you're confident about (2) but not (1)?
>
> My explanation from above explains why I'm not confident about (1):
>
>     For ptr-to-int transmutes, I know that they will probably remove
>     provenance, hence I am a bit cautious about using them for ptr-to-ptr=
 or
>     ref-to-ref.
>
> The reason I'm confident about (2) is that that is the canonical way to
> cast the type of a reference pointing to an `!Sized` value.

Do you have a citation, other than the transmute doc?

