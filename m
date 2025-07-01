Return-Path: <linux-kselftest+bounces-36197-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 470F0AF00D6
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 18:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5D1118823AD
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Jul 2025 16:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464E127E07B;
	Tue,  1 Jul 2025 16:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZFC/jGu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F0D2798FA;
	Tue,  1 Jul 2025 16:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751388438; cv=none; b=fpYzDT7R+Ymw6OrGv05jqTohCIePFrepWX02h6uadsNyIRmgBHcO6ncIJU6MESHQNpln5GHo2WdeIMF24r7WEQp7Q6cGX6ebraDD3NwatLc3Wei8H/ZIhLMs3Sx5P135sFwYUsc2SbwEL+40F2Lqf6IjsQsIe4CbAHDhaaB5z4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751388438; c=relaxed/simple;
	bh=ymyz98G6WAIWhgot7OyS3l+nPaHFTvJsU8EnPPnV3hw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jmYlgSW7XfGHmNWqBy6Tl0YPHjO6d4MlhSz9MDHSRtTmq2tZZ6YMhiqHIxYNIlOt80Tv6T02gBxmNxwgSDGhlFePvajGANFpaxPmJpLDbgfVAk3EcJPRIrxkEGYcpB/JhfwHTIwxm8+eYwG96hkhYsMcwZFM0FecioILuuMZBxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RZFC/jGu; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-32cdc9544ceso30043591fa.0;
        Tue, 01 Jul 2025 09:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751388434; x=1751993234; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ymyz98G6WAIWhgot7OyS3l+nPaHFTvJsU8EnPPnV3hw=;
        b=RZFC/jGuvOhElYbJdSKVKR+vOQ4+ZCR5TVwAlqWpR2svkdoOXBQ9obkYcTh6Drma3q
         qLSzWR+QgCL6X4MWR1DN9tEqLnHXcxUTYcilIKS/atsW/RvgLB+upBteOGFIl9fTbF1l
         4xE41/q1EtjI88Xt+knbYXFoZQvkX0TfO5HWKJbTbO/tsj0HSJFFddPM0xDtEMvmHftH
         ReNeMxfA9FV0sNqcwUY1qjSEvKibnZn7G/3SNk+bUp160VwTk10+1Zk7WRplNsYWrxm0
         KGpjqcsiMGd7kkJ2RBrAAWPPqrZTxwD080I+AfFINLots+G9BGUVVu9JQzuXwAapYdFW
         uzlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751388434; x=1751993234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ymyz98G6WAIWhgot7OyS3l+nPaHFTvJsU8EnPPnV3hw=;
        b=UL5BwIdbe57vfJQs9UWHMO1QN/CxnfkmdxDXtLijDyBsFi2K9eWXEmM9PS65Y1mmlr
         an+yC6PGZ5xKy3ulYXRv4x7uYwQe46tw1G8UBTgm9bdB2WdN6qnDipmJMkBSM+b+Xp7f
         7cNrA/0d220r0dC/Kt8rqnubn78ayw6CdqzFt7YSHgTbbHmNt0sIhmOcxrxwp2dueWLw
         Imlr4puauuiwmlGfvvSJhTl0ZW1Tt83AWfQJWmZ4XExb1/Zjlicc5bOuTGJWxb1y4s00
         r9qlq7aeJ0LKbRM7AKZchFyjQC/ngRTZmEQFV9lMuIt+fPxGJsLNT6FTIFlPZ+H4bXiZ
         7FyA==
X-Forwarded-Encrypted: i=1; AJvYcCUCOQd8i4kOBLmqHPjJ7RU9Xt7JcxESpHk2lH73uHcfRsh3aQzMrCTqB8rDkCiidHcKxbCLwSqUP65qKBD6xVk=@vger.kernel.org, AJvYcCUaCbzxPxuDts8/ImtrFbDERuCI+i3tuGeCIVG05mUba4eNYZuKGmS3U8MGPs67eCCfMw7TCB4lirM=@vger.kernel.org, AJvYcCUwcQi0sai9VUZeb3fDcwuxtPuj2Tnk8L5rdHz+TI84/qQcMEIndGEq5aR+5EUTvvwNIiPfdLaBpHTrYF1XBAk8@vger.kernel.org, AJvYcCW9EaHS62g1Hp0LNcXCoJgABJKv99UbzF1FM9DKFTy6EDjWNJw1dHEd9+/BlNcz+6AKs3DejxIbCtT1@vger.kernel.org, AJvYcCWZilvt5uJ0QLlxhaZqtU75xC85cG5kQULsrJ1JwBA9DXIGEnR/sBTTnq34vUlQnJBfRkuH7zS2@vger.kernel.org, AJvYcCWk/npMOtG8kAP4cMk/j2zje4SoYmXE9n+f3VsCFVa+Yq+RSx260W8YdLx+kf4n/XZXGpSu79mTBerPvpM=@vger.kernel.org, AJvYcCXVWhtUytKw40WInDMflfrQNGrugDPSDo08xE0uCjY/5eXSsWmuvnTLA8PfYtzvRpxkraUCuPD3Ap2GtN2U@vger.kernel.org, AJvYcCXZ1FkRVTHPbHwRvUt1GSQkOGOy51TsZaVZEtGpR/7xn/kzXxi+RipI7GbV8TUNc2sl53VfhURzM2UX@vger.kernel.org, AJvYcCXegcSZlhgS2mPJoagurMt9GAlI+I7x37E1NDSxFSJy78Dp/DFiq2c2q6AabknG5QDfubkySY0uT2An@vger.kernel.org
X-Gm-Message-State: AOJu0YwP+mYa/dIb+AvWsYjOwL4xbmeQ/6zqedOf3Th66C1KGDCWjonT
	uiqwwOt/OJsDmT99Nkk/gp9mbSxxyukREEeEIA0qKtFPe4QrP+h27ogMBQP7uPCAyK3aPda6MEm
	CX2yLE5sLGK/Xe3t1F9ZWl1Ipbs8/Hd0=
X-Gm-Gg: ASbGncvIdJreVaPaH7bakggtW/bhmClPzk720Z47WTO5BhHBaqdQjD2wUYCIURKr/5f
	VFY4OFPTjy7fCVC/qTMTp5L/4MS9MzeDK2leoId1Y2xmkCmtzqwRkjo9ujlBMNx1a6VCpBSx+Py
	T2z0H6CYwj5yp5huePfRMX1dv8uZyTlofJ3Kj9HSMF1bvtR4uTTLr038I1epeayeKDSF+zJwVnz
	Fu21g==
X-Google-Smtp-Source: AGHT+IFASHXyh6nKAuBWNflJbwzC1dxAvHKvYXKVWM4leUPhMKpN6FRK5U0/hoCDkOtFemkDVZIaXGSG2DOrBLCq8Rk=
X-Received: by 2002:a2e:7c08:0:b0:32c:a907:491f with SMTP id
 38308e7fff4ca-32cdc464463mr36198291fa.15.1751388434129; Tue, 01 Jul 2025
 09:47:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619-cstr-core-v12-0-80c9c7b45900@gmail.com> <aGO7-SQUUgg6kSVU@google.com>
In-Reply-To: <aGO7-SQUUgg6kSVU@google.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 1 Jul 2025 12:46:37 -0400
X-Gm-Features: Ac12FXw8AGP83JXgR8yzKwPiapZfBBkrNyDazktnve1kCOVkl79eviuMomA9o84
Message-ID: <CAJ-ks9kbsTRrRN4yP7GmphozPyZHgbaAGJmLXR42NVgJ1ie_SQ@mail.gmail.com>
Subject: Re: [PATCH v12 0/5] rust: replace kernel::str::CStr w/ core::ffi::CStr
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
	Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Leon Romanovsky <leon@kernel.org>, Breno Leitao <leitao@debian.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, dri-devel@lists.freedesktop.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, llvm@lists.linux.dev, 
	linux-pci@vger.kernel.org, nouveau@lists.freedesktop.org, 
	linux-block@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 1, 2025 at 6:44=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> wr=
ote:
>
> On Thu, Jun 19, 2025 at 11:06:24AM -0400, Tamir Duberstein wrote:
> > This picks up from Michal Rostecki's work[0]. Per Michal's guidance I
> > have omitted Co-authored tags, as the end result is quite different.
> >
> > Link: https://lore.kernel.org/rust-for-linux/20240819153656.28807-2-vad=
orovsky@protonmail.com/t/#u [0]
> > Closes: https://github.com/Rust-for-Linux/linux/issues/1075
> >
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
>
> Overall LGTM. Only question is whether we should re-export
> core::ffi::CStr from kernel::ffi. Reason being that right now we are
> telling people to never use core::ffi as the integer types are wrong,
> and I think it would be nice if we can continue to tell people "never
> use core::ffi".

I agree that'd be nice. There are existing references to items in
`core::ffi` scattered around (e.g. in rust/kernel/drm/file.rs); it
would be good to clean all those up together with CStr provided we
have some ability to lint against new occurrences.

I'll leave this as-is for now since this series has already churned
quite a lot, and the cleanup can be a reasonable first task for
someone.

>
> Either way, for the whole series:
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Thanks! I'll send the rebase on rc3 momentarily.
Tamir

