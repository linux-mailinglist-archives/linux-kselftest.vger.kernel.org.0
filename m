Return-Path: <linux-kselftest+bounces-33940-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE608AC6B71
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 16:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB76318829F4
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 14:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12A12882A7;
	Wed, 28 May 2025 14:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ncskE/1q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D5F2797B5;
	Wed, 28 May 2025 14:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748441449; cv=none; b=u/dtwD78+NXLsbKH2PbvMMdN5e0U/nXj8goxpjFSho1n3NloQD5jBKplKB/s/gCGvdFgEbILJu5e7yNOUJw8zlMoBZhJZenKEJerUJpnJEVkocCNeiL5He1I2jB/InLnB/GbUq9BRpNcmUD244jyaDb5tpKX3SXD+3YZiCcxtLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748441449; c=relaxed/simple;
	bh=SH5cP+3YWmXs8/zc7fXq9BP075bBVMwRnqEHsDoMzq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SYF43egu2qr9kEwlc55+Wij9uDd6wJJbH3DI8IcFEj1NJ25jOPkm+xbASfXCCytTyYROyQVwaB4OJgTbsZy9Ow7IUfImE/dgFxDdaRXrUEO7LN6dl02nUYhdyoSL7VjrcUNaqR7jJeQIG8xe+hNV8lptqPMY7GEnBr4gtodTIgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ncskE/1q; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-54b0d638e86so7496540e87.1;
        Wed, 28 May 2025 07:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748441446; x=1749046246; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SH5cP+3YWmXs8/zc7fXq9BP075bBVMwRnqEHsDoMzq4=;
        b=ncskE/1qpE5GIB0tRRJI0OpXtkQeUZl/GfBepqdstOKB06Zuixq7BFZCRt5fEKykrl
         ak7SuuutO7XkXpxb3+78XexF74Pcc30lPd4IuKAZwmN5n3FGpTi6ZI/OOdsUk6Kw2aHs
         8maw20gFpwp7R787w4oO3M8PPIYhO0JA7LUsKzrFVk2m2G6BimP4RWuu84SVCJxAc7GW
         QKm3OSYT/7a+icMaH8RI/hLxSj5dvxv1WgWptksm10yMsXOriFpdnMnjGDccUKcithfw
         /zkl2OjuPUU9+egrpiqfHjU70w7SNYgYJe8LQZ8Bm9RviJve1EaKsA+XWYonumTZS5i9
         Fshg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748441446; x=1749046246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SH5cP+3YWmXs8/zc7fXq9BP075bBVMwRnqEHsDoMzq4=;
        b=Svu1dNYN1ykfCyzMDej2Kk81tE1WHNpq/5Tv1fM7iIfcXP1mTG1Mj3g3RhFf2IQ3D2
         Z6kn8FkE4OJaP2VTqGWl7jyH5/J7Tzw3pVf++ybIyVO/VLU9B6tEzPTeC3wIrgPJwgLz
         udWzIPW7s6gI0PyYYEPin80WSTEkwNGD+/JNmHIWqxyQ/Jpbt/k0UsiuqtyHLg4VemDy
         mKAfihjTDVjtkJT2Kn1oIxl0UrKi5P7NwaqmlX3I0kkhxQBWK921UBw36b9Ngidh3R9T
         RGrtz6KyBIi2iVj5qLFDzMHitcmBR4oZWlinrGM8UjH2pVwoaosfMrgdp5XYgAjD3Vga
         5Kjw==
X-Forwarded-Encrypted: i=1; AJvYcCU87L2M7n42vA5/SG8CS5ZwI9K3d5LMBWJz/osFyFdH7En96lu41Yc8D03B9Ci+OPMQ90mVs7OuUzPl@vger.kernel.org, AJvYcCUpkr5ry1iQfpgHvKChPBnuwrYBfBWGUN6mYenRAhDmwr/XOvvw8LdhWYJ6C/U+1utPvs8hdmvvImMgC+A=@vger.kernel.org, AJvYcCVLRu25OYdCSSZBQZKAFdBwokVQDCJi5lWd+ppYHQ5NrWEzcfY19tmwqiLUQa/taejRbJU0f0hVRacohP3L@vger.kernel.org, AJvYcCWWrKmJvshohWo4xnniKKDXdio7m9PjREs1gcfIo72LVnCELaRKYmUKThV+Ew91uYGIdBxf8Avz5KmihARFVzA=@vger.kernel.org, AJvYcCWcSVKarrOr47JCMbSAAZ50S+5K4DIO/oNuht+AvSQOQrBhbQE7ofDz9zlEJy9msqOU5ISI8xDUOx+7u/6JNjtV@vger.kernel.org, AJvYcCXEUnIE1efEM936bzs4jIbxfGQ+FHEBnWkzGxpdYkUYf30tPKBZuCKrCPXUKAt8kxR2JeGojKZvwJs+@vger.kernel.org, AJvYcCXHHOuIYT8xMBeBxv3f1IX8l+uU3gv6/Jj50ozBBIY+q5QbnJuzm+L7dfVm3hQh+woG7u55GYb/@vger.kernel.org
X-Gm-Message-State: AOJu0YwWLRHXw262es9Or2NgQ1WXcNnCJ6fw24YJe7XrMwq5WbPButOj
	4l/USUbmtMi5qeYDWB7Wk3dWC5WXLhivt9t0qx6oZcb8mDCGaQFOO/E9HnEPmbBTWJUeMbE4p2x
	qCkzM6wDOlRX9Pmu6+tq0CyenUCTFb9I=
X-Gm-Gg: ASbGncscClWaQg69lVFecrPgKEPkr10wuO25UXRabc01e75p5XnOtpTptyCBKRZts6o
	hC96Eg7eOT7Xk+qnU7MWgiHU5dhEB1kNCUA4I3FKoLj13nanXsNAFGzk022fsg7zyaHitpRh2Gi
	8cLnqmjjDpzj6gwhSCCeC79lDRmpDeibbyYzKsrXJfKzu/fg9B
X-Google-Smtp-Source: AGHT+IG3dTRzhOJeaA21sQ8Cl6CUs5QffL1O5Hi46hlWsg6xnHSKewHgYxirdmC8QSEO4fDwgYnRgzhaJUbQ8K+6RKc=
X-Received: by 2002:a05:651c:1469:b0:32a:7122:58cc with SMTP id
 38308e7fff4ca-32a71225a60mr20885251fa.6.1748441445644; Wed, 28 May 2025
 07:10:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250524-cstr-core-v10-0-6412a94d9d75@gmail.com> <aDbniZzL1ZOSnfVi@google.com>
In-Reply-To: <aDbniZzL1ZOSnfVi@google.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 28 May 2025 10:10:09 -0400
X-Gm-Features: AX0GCFtCzkUkdNofO07GNzu_PibpIwzD2C0rC3Syu4m48_lWgFYSC9rhS2sdGcs
Message-ID: <CAJ-ks9mcPd+-tFRuhxVGrYRPFEtJa3nQTdkvTtzLppqitVfaLg@mail.gmail.com>
Subject: Re: [PATCH v10 0/5] rust: replace kernel::str::CStr w/ core::ffi::CStr
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

On Wed, May 28, 2025 at 6:38=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> On Sat, May 24, 2025 at 04:33:00PM -0400, Tamir Duberstein wrote:
> > This picks up from Michal Rostecki's work[0]. Per Michal's guidance I
> > have omitted Co-authored tags, as the end result is quite different.
> >
> > Link: https://lore.kernel.org/rust-for-linux/20240819153656.28807-2-vad=
orovsky@protonmail.com/t/#u [0]
> > Closes: https://github.com/Rust-for-Linux/linux/issues/1075
> >
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
>
> Overall LGTM, thanks! Left a few comments on individual patches, but I
> can probably give a RB when those a fixed. :)

Thanks for looking! You say a few comments, but I only saw one. Did
some get lost?

