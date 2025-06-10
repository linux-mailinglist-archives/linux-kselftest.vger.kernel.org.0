Return-Path: <linux-kselftest+bounces-34607-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6081AD3E54
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 18:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 729C6188412A
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 16:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C71F23C4F9;
	Tue, 10 Jun 2025 16:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XOrwjONn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14359204680;
	Tue, 10 Jun 2025 16:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749571674; cv=none; b=jc6YVCLO3NRXOxr/EYvsKiZxGHIw6RIxtGCJVRzD5dyVXyv2/y1tbs9IwVOHeOSzkAlyshg9Ewrzf5TZillRxdHkqC4yepi7Zo48E1zxUk0nmoQTcd3H0QmAy8o2Wt0sHPQveHnIHEK6L3jHxBWkjy2Mnf5eExScUpuxbwjr+yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749571674; c=relaxed/simple;
	bh=W1BITlzur69yftGlPfm6ex930CZl9IBW3CAWbDhhnEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XkW40XxfP+FtW2sHAlBmbnnQeprCGvbpRR/HR+Ssf6mGP8iBQcqX47VuRWuM0wfkaiB1N0hUboWELokgknotbdQYRUv0RkQ9WM5GVOhXS7FW/OGbAsACBM6R/Osb9VeoW7PUVnZZ6mHT58YkDJPppCM+mVTf5H+rCJmNl0vFtY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XOrwjONn; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-234d3103237so7027925ad.0;
        Tue, 10 Jun 2025 09:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749571672; x=1750176472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W1BITlzur69yftGlPfm6ex930CZl9IBW3CAWbDhhnEo=;
        b=XOrwjONnbrWHAulz4fzMmIqi/sv/GbSLVYLd/dlMGQtUqW4ymPnnRYCMO8OWLDC+iT
         mDXCR2toyk7b7PI5sE2Aj+EnuGRv3PdsIkIPXpUc8deAMURhryUMKTEcq6g9DVd8v+mv
         hZ11UNbc1XCwlp47flEPjyJgQyptG6ozFT1fYcI+wisp37O6d2wwOqQ6D+5Cm4maRCcm
         O90LO7eb/tI3mhxAyC8vQp41ylQ4ToCPZ4Ads3Nc7KxpdmmLZ7wQRuFf6wMpDcsC3Cig
         kgsHiRnA7xXE05V+4awVqI0N0jN/0PLDyCHEKujY6L1z/XgrMKHCrJPzFDjQpE6jphKe
         aIcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749571672; x=1750176472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W1BITlzur69yftGlPfm6ex930CZl9IBW3CAWbDhhnEo=;
        b=uIecb1XyJNpH+WUADx8DQl3Pi72RGdK6za7XqoHO9ugBVmqZ3pXlEhEJieGCZI3x/n
         3Vm7bOtjSlIRdqi8NlkeaJkgcwsKyCG/1KKfYKkxYU7TJCyjUM8j1KY64Xi7O2Kdo65g
         ufSBB6jNrZ9b4wHEecpvhSCpTZRLu+v4cBBuhB1Sfc6M5DJH9hEEXISGy2I/8ejPDmkj
         xMqPr/a3Wf/VGiN9xx5re9Y1GOiInf47CZdJIQgUcus/0Xo4t+6uzDWsmY2y4ZsGC3bd
         Bxn/8IjE6jLrCMlu1iQZr7hGUSfAMj+2k71ryj2ZM6nBIAZYVnxiZJFs4pufnaiAWi0c
         i/ew==
X-Forwarded-Encrypted: i=1; AJvYcCUywly4tTQqR7LpjXl0zMvF7CRkE+Q8d/gjdthgav+ko67dE1wMcfLOwCxuSmkFir6usB968ZbaW1+PZmYr@vger.kernel.org, AJvYcCVkjX9l3RJBkR0n3fG72QybfCIuUqcAsgMsjho0aMAf2VZB5VCoJ08mdUPJxxrWKoDx8hSOeSIk0nPVO2TP@vger.kernel.org, AJvYcCVwx5dxnACFHHg7yysJA7LyFMYtRn+2L9OpijTuvW/27Bs/CWz5unAn1yrfuWy8BMhWdKbqeXfS3cZl@vger.kernel.org, AJvYcCW6Kwmqya5l4yj8QigGNzSLVTtu/ukjGo0E5r8Yz6OIOWSFAY8lnHQVp4NU4wW44kiAHQIqXmP3rSEj@vger.kernel.org, AJvYcCWDIGFGL0njzfxbuSM2NNUyVXtWTZDSuoERxVQzyt4JhSxh8Ha+dhHo/X++PLrjwbIrCim7ytST@vger.kernel.org, AJvYcCX8wh7J3eV1pVTgs9ne2JQD6vKBoV5HGGkbL0ujrh9Gi9BZ96xvO0CqVsAoniZ+bcJPtHAKCgHdQsHEWgeLwe4=@vger.kernel.org, AJvYcCXE5bOZNlDOkKzSL+ZL5FX1XjL4QuEDG3wvm0wrunNihv19nHoy7j4thZwOG4LMfat39+vI7+VkM+09enAI0iY/@vger.kernel.org, AJvYcCXvPktjcXsfhPOh3L6PXAQ6v0nE2DDueSXtUcE7g295/BPEhEYy+iKoJEjoCOwde1hlsqRSAzedewf/sfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN9DHF3QC/5a8kXkCkdPQnUWbAQXWrQ2D06kFwz+x+28gdtvns
	kHnb+gJebS+C8N4WkNkExc3oQy0XZd/kiuMOlhHjzxugngQeXpjbJW9yyDdQNj8YrW9yfKmdcFw
	XizoTZknseMdxKRN2SbYh8xyFck1MEsA=
X-Gm-Gg: ASbGncsCLH8vBHQCWgD/wZrTP3W1cesZK7xczQ4o9vL+WF0/TovVA9VHnyRHS+FUvkP
	qQgxy14f2VJpX2aonOLpQDhSz8Tj14B4EBFEZGpfnbazGPjx4O0e2xeLDUN94IvKrr9UkoyMqaQ
	IyLX4lrx9Vwoq/F5vXAg9KJOGP62aMcW0Eqo79sbvPz0k=
X-Google-Smtp-Source: AGHT+IEkveDPapEYWYF5Lme4xzYT3aU2PAb3RMnK2FhgBqYClnpHcHMaaMDanexVO7MdhtPZZBHJv9udTG6GaKIHKaY=
X-Received: by 2002:a17:903:1a67:b0:234:bfe3:c4a3 with SMTP id
 d9443c01a7336-23603fce7aemr92246085ad.0.1749571672166; Tue, 10 Jun 2025
 09:07:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250418-ptr-as-ptr-v10-0-3d63d27907aa@gmail.com>
 <20250418-ptr-as-ptr-v10-4-3d63d27907aa@gmail.com> <CANiq72kWtEsXDuoXpbTNRLiZ=c==Ne=v4igxCWMwWFj0LOC-Yw@mail.gmail.com>
 <CAJ-ks9ny_VNvKM-w04kkk4Yw=UpYEt82TyFZZuXEFK=DxfwcgQ@mail.gmail.com>
In-Reply-To: <CAJ-ks9ny_VNvKM-w04kkk4Yw=UpYEt82TyFZZuXEFK=DxfwcgQ@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 10 Jun 2025 18:07:38 +0200
X-Gm-Features: AX0GCFt25dqMhp8iaQDA-26WJJC7gjowsiCCK-_ghe8BM57dzBLtofxE1fBcZ34
Message-ID: <CANiq72k6MkVGtdgkSuy392T_xxO-5kTJuN7kh41N=UBc0SeFLw@mail.gmail.com>
Subject: Re: [PATCH v10 4/6] rust: enable `clippy::as_underscore` lint
To: Tamir Duberstein <tamird@gmail.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
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

On Tue, Jun 10, 2025 at 4:14=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> Yeah, I think these are good calls - I'll fix it in v11. When would
> you like me to send it?

Since -rc1 is out, please feel free to send it already if you can. It
would be nice to see if we can apply it all soon in the cycle, but we
will see if everyone is OK with the changes in their files.

Worst case, we can apply as much as possible, and leave the actual
lint enablement for a final round, like we did in other cases for
things like this.

Thanks!

Cheers,
Miguel

