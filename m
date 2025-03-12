Return-Path: <linux-kselftest+bounces-28838-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9568A5E505
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 21:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55BF31897D36
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Mar 2025 20:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1032C1EBA0C;
	Wed, 12 Mar 2025 20:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NdvYePad"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3814E1ADC6C;
	Wed, 12 Mar 2025 20:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741810111; cv=none; b=qaDZn6H35dKdbV4Kk1NvYMxsFCm/lb7UjL4NiqIHxbsd/NjkcUFPgrfuo8JzHqfjJQGKZUeqZtALqczpnpM6ZVD91XejhYBIKSaOIWzZJfWOpehYM1SlCw9+wh/j3IlTcYeOSmnX9IHwOFxBaBWKpomNg6sLiYXct2SZbsMPg40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741810111; c=relaxed/simple;
	bh=lsSBdLdQ4s0iCWd7bcBOXIm07tS0egm9zlqlZry3PRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IDw63KxLrS0hTzFBQczgIX5mR5qRicQmrkF1HUW2RI6oIUuMxzm0ocFoP5rvX9n3HV0+StvxQQTX79cB9Ei/MUg49JZZVgfdzgOTKBNf3ScDYqtJUxH34KRIsF0hAWVqPlmTWVnMSZmZK4Yr/CWdL2mkcrojMONlLLP2WeoINBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NdvYePad; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-307d1ab59c6so2252531fa.1;
        Wed, 12 Mar 2025 13:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741810108; x=1742414908; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WvWdxAReWH9rJxfH10m5q08BJW+spweZYCe1Q8vBq2o=;
        b=NdvYePadAx7nACoq9+DTtrzkJALJKuKwsIwjYIEjTguMkJq/pwM/igKOw/GpG8lk69
         G77Usu8ruXa0Tzkdn3QT2nmS2w4JJabGyzpEGy/RSKB81j5A/gbQAbEGSjh+1zKKdctE
         L3GslfMieoznRgNkaoFXE5m1/GkiDBgUnEhvykF7uuHHGVmtwjbw/NQ3u8RCZHtnRC7k
         7k3eEp+Plz/ISWzCJi5G58pY1Mk/9w5t8MwLAfVe2foQ6eKm3E9892AyTisxX4xyWr42
         7BHfWM3QuwzfIfdorynUtvilpp0ojWrUIBr/RVIYy7WQGcYwQ2PJ9oYaORDQCDR/Lwbk
         H+kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741810108; x=1742414908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WvWdxAReWH9rJxfH10m5q08BJW+spweZYCe1Q8vBq2o=;
        b=SfOwuwp8NQj3d9qG6T99WxGjYBQA/lX9KDSY3UQVmGEyBo7p2VGSx5+H1znKkQXKf1
         wGt+fVLmn96Qp0hqjbYUyQAH04QwiCCBLrVkkn5vW1sMlyRZvY75QtNFpFKXp5+BLlyu
         0GnAY5m4nZehdRRmoX+mQdGq28HcTCkCZm0B+7NZaNoSGXSqGmlTbXVg6S6gfj2ecxER
         W5m89eoQeLLlJXZJJp0aNUb7NSDKtQ2oR+/CDlHuAHqeObzBJLwE4yPFwbbrqzD9ee/+
         iEboJ7OztMQHlBpgb3kuK6TJSS0ThuaqBLv56BgU2gHTkp7ZFpkbXWDo25+7nBbTeN3E
         26AQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQYX9dTLzSX3+iCJK17IdDFw84haSZbGlL7wyENXg653DdRLO3EMz1uUi0T9n4NbjSMkPd0YFNN+S6@vger.kernel.org, AJvYcCW+ElhV827NgFsZ0JTiv4Zbs2fMYjGqmeEZYAnr14ikx/aJsET4VxMuGZMdbR7uRLFmP4tEN8WECXya@vger.kernel.org, AJvYcCWCzxeiKcQlQHpYI8YNCbjZ7Klf9hTlV+1Oy7HHhp/bKO3vSJB5Ir2LNFGCZSeOqV6kERx+uIs3qtEDv7Ya@vger.kernel.org, AJvYcCX+RmaL852E9Q/J3WRwP1qIc4TYN8YBdFhOGOXsza2TdmTHnCAiSZQTwnSdjWBqOL1O9lVjhOrVOwgjxIk=@vger.kernel.org, AJvYcCXMkzVEV9oXfxyPvY10yb7EZaFVVqHgOSErf2o8l1kT4ttHjo84KkzKIPLnDr5tfkOzkbU805fbMVCqx/AlexM=@vger.kernel.org, AJvYcCXYvfBsrlxCwo50P6i+ENlLcRrNhKJe0l9RecwgAvRoPehOrqw9nKYJbBwNYBEhjiOhkjPtUZz/XYZU8uqu@vger.kernel.org, AJvYcCXi9KHhqjSmiA7FzPWMHMV94Vuo2L2Y3NW8Mn7XdevSyobAveCjaixjAYtGgZEdUwfDymVwyWa7NR2SwJtNdOON@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbfxa5za/Ygu/wD+A1kMG/S/EMqWcM6Mfkif2t0bqx3fAANWA5
	NeRZAfpQ3HCQD6mh1UIlLdlBbZzKnbISjDwpihC+qZtoHyNemqZ0yRjQ9QUeuXMSy/b7b6IV8e1
	EJbqXgdMussi0j3wzNNXlnTjrVwc=
X-Gm-Gg: ASbGnctfMKUOtLy9S4ZOuHnS3GYA9CAirbORI9rnUHBNhgZQ+11Cvv/FdtJI1CxqKNF
	gSVZCBHSy9GpYU2FCRNOlnHio4uvWVLnSLMzG7yUOo2CsGbkn6ty9+cq5WPzqluikFQii4MsZT4
	pIrY7+M285XdLoTR593fkrl3VqqRAQB5Z91cEgAkkAKw==
X-Google-Smtp-Source: AGHT+IGKy6zn5xgfn8CeCs2iWvvIbfhtT8G8n3Qui6VQS2rPHMF6seq5pQ1f4HajsIodpexn4xjqHKMhzcX7k07A68U=
X-Received: by 2002:a2e:3517:0:b0:30b:edd8:886 with SMTP id
 38308e7fff4ca-30bf451713dmr75313571fa.9.1741810108139; Wed, 12 Mar 2025
 13:08:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250309-ptr-as-ptr-v2-0-25d60ad922b7@gmail.com>
 <20250309-ptr-as-ptr-v2-5-25d60ad922b7@gmail.com> <D8EDP4SMQG2M.3HUNZGX8X0IL7@proton.me>
 <CAJ-ks9=K06OT6cutUABj2QDHJHJ70719c-eJ=F3n-_bhkYbZ3w@mail.gmail.com>
 <D8EG9EM9UU0B.2GLHXRU2XROZ3@proton.me> <CAJ-ks9=+3MQb-tp8TAwYvVj=GOFFFVKJxRMprc8YXZHKhqnDrg@mail.gmail.com>
 <D8EIXDMRXMJP.36TFCGWZBRS3Y@proton.me> <CAJ-ks9=zWAuPUM_61EA6i5QkUpwtNtsN8oF_MUerWGn39MRHhw@mail.gmail.com>
 <D8EJM4CJ4HAN.1PB2YV8DB77V7@proton.me>
In-Reply-To: <D8EJM4CJ4HAN.1PB2YV8DB77V7@proton.me>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 12 Mar 2025 16:07:52 -0400
X-Gm-Features: AQ5f1JrUv6wKNk7y3ewcr0wVyePELpSL2pI1z4NH7DNLDz50gsWeKT8qdmo6mKQ
Message-ID: <CAJ-ks9mo-H46Wwcu_LOvDy0ncwMR9ii74Fyf3OX-aWNnrZ397g@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] rust: enable `clippy::as_underscore` lint
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

On Wed, Mar 12, 2025 at 3:43=E2=80=AFPM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> On Wed Mar 12, 2025 at 8:19 PM CET, Tamir Duberstein wrote:
> > I tried using the strict provenance lints locally and I think we can't
> > until we properly bump MSRV due to `clippy::incompatible_msrv`:
> >
> > warning: current MSRV (Minimum Supported Rust Version) is `1.78.0` but
> > this item is stable since `1.84.0`
> >    --> ../rust/kernel/str.rs:696:22
> >     |
> > 696 |             pos: pos.expose_provenance(),
> >     |                      ^^^^^^^^^^^^^^^^^^^
> >     |
> >     =3D help: for further information visit
> > https://rust-lang.github.io/rust-clippy/master/index.html#incompatible_=
msrv
>
> Oh this is annoying...
>
> > This is with `#![feature(strict_provenance)]`. I can file the issue
> > but I think it's blocked on MSRV >=3D 1.84.0. But maybe you know of a
> > path forward :)
>
> I think we should be able to just `allow(clippy::incompatible_msrv)`,
> since Miguel & other maintainers will test with 1.78 (or at least are
> supposed to :).

Alright, you've sniped me. This is coming in v3.

