Return-Path: <linux-kselftest+bounces-30972-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B74DBA90A88
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 19:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA79A444F33
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 17:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF069217723;
	Wed, 16 Apr 2025 17:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3ZwGJfJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BE914B950;
	Wed, 16 Apr 2025 17:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744826054; cv=none; b=YIkNNsOH45rklUE1xKTCiv9UNvj0BhQeBD+XMc5cuRxEZS9g7Rbg8bftEFDAWkykhJzd2zoGbFbsjQj79c4pr+XpnX7xN77iFbF8lqiE/1JxM1YZGD9H1CNTnOiYiMlI7x07xW0IbI5lhxIn4rZSMsaCsweq8EYrSUU+o2/+rO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744826054; c=relaxed/simple;
	bh=nKxl5bmdwZ5tuRiu8ZS60/CQ5k3vguUWcj6RiGe38WQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=goXdGVekb07KLtOE70y9hQz/nza48hoJ45rK9Ac7B5fvbZea8oiM+L6DZ59mtpMNWyTaAhMrGfg+s+CMJTd9gIPGNg4ow3bEhSkbKLvvWLvDwJFayAuBfPFgoPcqZIfCvjZnGUjKOW8IymRVixEnRQLBGx3cyPQsfmrx8QMcHKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G3ZwGJfJ; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30bfc79ad97so11470271fa.1;
        Wed, 16 Apr 2025 10:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744826051; x=1745430851; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hlh2fjr1p5zOr1jLNmoVy5ueVHw8TQ5D92sVTob9JxA=;
        b=G3ZwGJfJdHZP1rGv9HDcz85mphqppAXvUAvQBv4QlUjvReSqj9KLrQK1LwpN5DPRND
         KndTVGjbw4TYB+068T4tADHpv6MFLwzoNNebDSqfVxHTYw7+m3TmzWezrV+/PM2qNdey
         72zAV1hM6XJVFq4S02J5O+TXHtMFnMb52y4OyRypme1dGMaUx8CCawABgdmu4YoTNBTm
         pnCDGQbierQaxObtHTdX982F5nlhIdqjGAixds9aXB7JQZ7/8+xhzHSpe2NhIJmLmp2N
         kLCvich0xVrafmBnR0OnC/P6yEC8EPaRZaVi4dZ1Uc2TiIVSCjbz4g515LQEVa6dwr65
         plSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744826051; x=1745430851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hlh2fjr1p5zOr1jLNmoVy5ueVHw8TQ5D92sVTob9JxA=;
        b=DZPrJN0tFIeJf0SjqkRg0Jk85Di9cQOwoyr4G9lXVZO8f8MyVoquCxJAZlBSjmiB85
         dXCiRIgTniSMxkD5joS8f858cqfLZjxM0D6jua4l4c72UNj+8p1hpS92aKX4enzxglQ4
         TrlgvgmmOLAxDPA1SnL8MgGmUVJy49LO22QCHsbzNRPfJzpEvE65PSsX9mbiB79bhDNJ
         eefDsU4+QTre/OqKanpFob1Dk9sx35BL3Gz+hIm3S8/FaGlPf0imJdmpR5KtgpA5QCHI
         N50T1HM6bngL7FJ7PA1hKj8kEkO13DpVJwyGfjoojXoDTB83oi6SIaEKBZwNL6VDYbsz
         NjSQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+sLSi3TDrUxYQvykAxPJ03lwlwtnac60PNFT7hV+XDD0e9dy67A+RVa3iR5wdqgkmvIHPpMkfcqE/@vger.kernel.org, AJvYcCUZG3PXbDU/a14y7hsTaQqfljAAzCCTMACU//i/PEv4FAMjBkVNfFBTA90tfEjXObFPMgGiKOr1aYLsSvLmpuY=@vger.kernel.org, AJvYcCUeMT/7mV2PDOQOCqSErdQ3DWC6OQWeIdQ7Nqgf92GihA6Daq/O3l3geoVsuq6XefrwfTitssY+80lS@vger.kernel.org, AJvYcCUoHWvP4c7aA9MlZTJ9vTUgnmuJ53BS/AgBxWX81satJNMhBCjP4qNiXphlIX5jZdEfdKQAM3IyMC1lwqlN@vger.kernel.org, AJvYcCVf8NS/ceimTBrYsUuitnVNbKCXslvUuKuAdrl2zsePMnSJySKuo6mTmsfkX0648CmVcx4zGQAMT2JXt8hM@vger.kernel.org, AJvYcCW5MjgD6dmLRHw6D2Z1MeW/tvc5nuZfpdLXthGctMr+fbGEknfRF3//ToR5pctEskl4Jjoa5Sz0@vger.kernel.org, AJvYcCWZ5NSqNZHj2gxFmGUcUXJveYA7F2LMpfIGAkhuzE4FYJReWplgn7NwuAfcgHL2EjDhClUabZhya+WqdXw=@vger.kernel.org, AJvYcCXeWdTwwOGB6ImdvDUAyoU90YQ1yxCa7sFtGIIBAIqA/3/MfQ4g4q6+HQiQSLGqA4Cr0JTaDFpvlkjW0S5tKIqL@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd3DaiHOv2kamiqFV9p9F6OH0n2rwD2iqSjmzzqL0uPlxo9Gkt
	CXp8Cu+HFhycz/JhqMRIThM4Ixsg+VHtUg+jjKMUkdFyVExQKDLohDMwgBOLNkzsslj1Zie7bwM
	z10FE3WZ5Vo82d8KAzHCuv4xVQP4=
X-Gm-Gg: ASbGncvwwMO2h89HnZZvYxPlZ008+L6+GaDLlHDw621BG7OTqejXFWbEu1G1YqsMpxq
	GBHLw8up0ay6Q/CiQ72HjQsbdqcxyFwzBP0JWNrwTXyA23iMfxPeiCEFZltBk/79gMj3dYjuiPw
	Ui6CvQ407Y04gScJ0jTvowV9JAht0rDUcWIGHX5w==
X-Google-Smtp-Source: AGHT+IHdVZCfT1hHQSRWgqhTI/bFks+re46BrEdji8oUTIIg3UUsqBCnhQautOPIEbcY+jJYHZHUq4U0ygS+69zWTu0=
X-Received: by 2002:a2e:9247:0:b0:30b:eb0a:ed63 with SMTP id
 38308e7fff4ca-3108574e780mr829931fa.18.1744826050903; Wed, 16 Apr 2025
 10:54:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250416-ptr-as-ptr-v9-0-18ec29b1b1f3@gmail.com>
 <20250416-ptr-as-ptr-v9-6-18ec29b1b1f3@gmail.com> <67ffee16.c80a0220.1dbd15.c3ad@mx.google.com>
In-Reply-To: <67ffee16.c80a0220.1dbd15.c3ad@mx.google.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 16 Apr 2025 13:53:34 -0400
X-Gm-Features: ATxdqUHSRnIpPPQBV0jkAOVSIHT_IhSMCpuq3at5fw7oWfF51dZkACZO8GK6lVs
Message-ID: <CAJ-ks9n-5Gkp61ODfBbf3==fYp1AbexANLZaQpsGj_mj1WRfkA@mail.gmail.com>
Subject: Re: [PATCH v9 6/6] rust: enable `clippy::ref_as_ptr` lint
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Robin Murphy <robin.murphy@arm.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Frederic Weisbecker <frederic@kernel.org>, Lyude Paul <lyude@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-pci@vger.kernel.org, 
	linux-block@vger.kernel.org, devicetree@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 1:51=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> On Wed, Apr 16, 2025 at 01:36:10PM -0400, Tamir Duberstein wrote:
> > In Rust 1.78.0, Clippy introduced the `ref_as_ptr` lint [1]:
> >
> > > Using `as` casts may result in silently changing mutability or type.
> >
> > While this doesn't eliminate unchecked `as` conversions, it makes such
> > conversions easier to scrutinize.  It also has the slight benefit of
> > removing a degree of freedom on which to bikeshed. Thus apply the
> > changes and enable the lint -- no functional change intended.
> >
> > Link: https://rust-lang.github.io/rust-clippy/master/index.html#ref_as_=
ptr [1]
> > Suggested-by: Benno Lossin <benno.lossin@proton.me>
> > Link: https://lore.kernel.org/all/D8PGG7NTWB6U.3SS3A5LN4XWMN@proton.me/
> > Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
>
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
>
> Thanks!

Thank you! I updated the earlier patches as well.

