Return-Path: <linux-kselftest+bounces-34116-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C43ACA04D
	for <lists+linux-kselftest@lfdr.de>; Sun,  1 Jun 2025 21:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CBFD1891F26
	for <lists+linux-kselftest@lfdr.de>; Sun,  1 Jun 2025 19:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891C2239561;
	Sun,  1 Jun 2025 19:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ie0EZrth"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5552238C3A;
	Sun,  1 Jun 2025 19:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748806991; cv=none; b=QyBx692S1Up3QjBEJV8nfuUaDCNIs2QYLAhKzvNKYU5UMcpJUS51r/12f5lUy4r16p0kwyISXW/3cxtsA8X3YuXbGjLbjL3cI2IabL0oGBeATetxT5vhZFcv+cq+4z4xDHcrdvmq7rBwBf+y6+a7qF2684Mo2M31v4gi7GcofZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748806991; c=relaxed/simple;
	bh=zlttJep6rq3I8+o8EQ7DmNCSKFq6mJq8IUZsLPjanpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B2PTK5G1eNNnh0FyOPGL5z5AsfEqH2BeehgVbEB2ICByL8THO4Psirm3c5xMG69WuystQAUN050HFl8dTb+eXeOQPhXtBIpdT+aFYmfDBY77sK1IcZPd60o99/Gps9jzn9DHx20RiXIi3Hd6wl9OFn0MY6LH7Xl/Cj5MfNjOdh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ie0EZrth; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-54998f865b8so3542983e87.3;
        Sun, 01 Jun 2025 12:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748806988; x=1749411788; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zlttJep6rq3I8+o8EQ7DmNCSKFq6mJq8IUZsLPjanpw=;
        b=ie0EZrth6Xrw3SRY3IovDnAxP5/8MKvP/wdwqtNhLD7rmDiMkiE52HyumbdFzKKCJP
         uiUyUJMkpwyTeSsywi0gJZEc0Dx5Tu+JeSNiufvQO0Q82EeGQAfyM5gHU5swleGDyV6j
         uMoPEenULYCL8SzmWizE+J0ysuqiOdF916vmmSP0RH9cC9DYLaye5SBnrQRQrV1ZmGyh
         lkTWGcZ3i28fc09A7yIDXCrKVCRcFHIdRsvQnw+HAzdjnJjxQFh090NI1jJk1rnfRz72
         tICek6z5ngtGQMmeZekfZCXzJUOcniZU83EKlcZxdRJMgMeRsjaiNwBlviP0aH5Zyimv
         bSVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748806988; x=1749411788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zlttJep6rq3I8+o8EQ7DmNCSKFq6mJq8IUZsLPjanpw=;
        b=QzggFh93VWlxDjq0w/bxUAab4t8MRQOvQlJzA++4VOq1fbsEJTQSpa4QGkO75txepF
         0gtWBU8d7ILJE6lX3lmVkD8QTXVzkW/23Uosp432S5pcm0Tm4d7ZVx6J8Wa4qHKM6d0Q
         z5ZdKpNFsW9+muiGef3jkNYR0squ2PDsDphsIs9oHFA0/ylsavdze3rzixoBBB4btlKh
         d3FNYO+bT4487NtrrpQ6nhvyHeVNqd7kJYwNGda/TMHsjvWbiju/r7Y8lS9Kzo+5pSW0
         pR0Fdjm3I+FsOF+x7lB46TAODLxMqzVMoywcmm/ct5vk27iNJZfkm2EZt9JKZpZwoTTC
         ls8w==
X-Forwarded-Encrypted: i=1; AJvYcCUFVscBmsfCU4TGjPmjlBcPpNj0F2suUpRqjVnxqTyBeMZ7Zj+VggBIbDKyzNndN/5WFl2G+EbX5f6/ID3HlwM=@vger.kernel.org, AJvYcCUI/MBiZhDSb/7R/b4n927i3DliqynnFjc1Y3HyWYPdTjQ9zm2tfLEJaNuZXtWUgcs2f6n77GZO/low@vger.kernel.org, AJvYcCUgcV9cURi0e2o/vJjlbtOBNxtNuGGEL1gsN3Gp7LSLDypbKIc+ZbuahKciukEuQ78Cqdudw5y8zKpE2WZCj3zf@vger.kernel.org, AJvYcCUzbFr25PyfIcDR+HfH1ZpJmNyZIIPkROycxeiKpFFtGP8ou/1LCiSeCi0jiMyjw41BxK44RphB@vger.kernel.org, AJvYcCVPp0Fk2zxjUsyHlXnWWersiPvpfzSAwlmbC/AEEausubQwTtAfNXRWkSNsNg1qF7KPSSbX2Qnz4pv5DT+m@vger.kernel.org, AJvYcCVxojdwRqCMVmuGvTDYlENB+vNiQj7rs9F/A9WGOMj09/Fwz/Iczm+lne4Tdkfnw2vmPi0SrvPjyO5jrnk=@vger.kernel.org, AJvYcCXFLVP20TJ2byEqjH5p1zl6sonEy4K3aGYMmtBA3VmeOWniWx49LxEXG4PsfMs5snHYVLKknTVkfvhR@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4KajWt0RL5va2yEg/rt7QWQqGxkubMeno7P8XVpUFXEnZ4lAK
	JsrEUn7HbI285N0T7PWMFUS9SbeEO9VfY1/gwZOZOp9f7nTzEvAm10rNjv9Svqq9XWlKn4IUGnq
	hMtCMD6qOoKA8uXPFwy5JfuhJm/BFHHE=
X-Gm-Gg: ASbGncuMBIrsUMA6fMeqqDTSLBYGAxtJ7F73pHn/aDh/TedNlU6eMBnLm0vlMf0Dn2F
	jm7b8RAhxIeJovalYZI6K+SIe6N295rlNygI+3DxGlk2ZzI3SbS+Ugj+0DTt6rZ+3Dnh72zDQA/
	a5VPGd5JBL4xDx7IhK3Rh7+ehJXvKBBWTyhH7p5Gh8VLs+EOWgZ/spKjEzklw/QRdBVEY=
X-Google-Smtp-Source: AGHT+IHtRgXkoammUnbUpN1dYXGck9bKGEUGn5GT5cV3fPbuB+pGOqAmc7vwPC05DiWkj0JlBHypesZfOXv6vLdnG6Q=
X-Received: by 2002:a05:6512:3d28:b0:553:2c58:f967 with SMTP id
 2adb3069b0e04-5533b93b8f9mr3282822e87.56.1748806987505; Sun, 01 Jun 2025
 12:43:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250530-cstr-core-v11-0-cd9c0cbcb902@gmail.com>
 <20250530-cstr-core-v11-1-cd9c0cbcb902@gmail.com> <DABC3ZAQ01GG.1VT5NL7PIMTEO@kernel.org>
In-Reply-To: <DABC3ZAQ01GG.1VT5NL7PIMTEO@kernel.org>
From: Tamir Duberstein <tamird@gmail.com>
Date: Sun, 1 Jun 2025 15:42:30 -0400
X-Gm-Features: AX0GCFsKjS9hgEwmEsRuHll_MOXzoBWv1p_-8FxpcxZc3tsgxztATvJimliHSmg
Message-ID: <CAJ-ks9=awTggTjr-_dkaWLQRkQVwkBQKiJzdP9dA7_=zFKRY+g@mail.gmail.com>
Subject: Re: [PATCH v11 1/5] rust: macros: reduce collections in `quote!` macro
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

On Sun, Jun 1, 2025 at 12:24=E2=80=AFPM Benno Lossin <lossin@kernel.org> wr=
ote:
>
> On Fri May 30, 2025 at 2:27 PM CEST, Tamir Duberstein wrote:
> > Remove a handful of unncessary intermediate vectors and token streams;
> > mainly the top-level stream can be directly extended with the notable
> > exception of groups.
>
> What's the motivation for this?

I was squinting at the macro to understand how it worked and spotted
these oddities.

> I wouldn't spend much effort on this file, as it'll go away when we add t=
he `quote` crate.

Eh, this seems to be in the "I'll believe it when I see it" category.

