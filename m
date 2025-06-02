Return-Path: <linux-kselftest+bounces-34138-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD710ACAFD6
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 15:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E07FD7A813E
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 13:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5449D221739;
	Mon,  2 Jun 2025 13:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4ShsCKN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBF722156B;
	Mon,  2 Jun 2025 13:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748872526; cv=none; b=AKzFvFpOvrJiQofyoHkopmXbOtQTrMM/VOOeCBXHW0QL5jiy/7uZfJ+VsoV+dd3juXUteUE0jiyxbixjK+L/joCWzkjZxwSA6d4Yqci9L6386g013EQrx8SBp4gFpvkCWrfEt099achl7KiwHOkrut5ohL6dxzl8V39/kyyy0NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748872526; c=relaxed/simple;
	bh=CE13FvVd/oZWld/RcBibj9PFe0iI8IjGbKlr0iRzhJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jeG/ffpwN/aiMw+4y1Wmr7PdhuMYScSE47WoIA/1vfWQmf4oQ23/sVxlgLSqZ0jPSgp2xHFDlTmAdj118NPHX47x0f1heyRWo6InbMneuuXsQ+ArW+7ii7lE9sXd20cQ6DgqCRcTGkhcKELcYBMESqHpFtNJcOxxIiD/L6D7ij0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l4ShsCKN; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30f30200b51so43862661fa.3;
        Mon, 02 Jun 2025 06:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748872522; x=1749477322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CE13FvVd/oZWld/RcBibj9PFe0iI8IjGbKlr0iRzhJk=;
        b=l4ShsCKNg7+k7oI0iYW2iMqd72zFVCCjLncJcLa3gBoZCwCTQgArZuB9GI5XzqEW7h
         Rl8yI7b7sIGmPtiDsi0xEwqMJy72tDRNVERDetHGsdGE+jyZuRdICLp4s0V2uiSd3Ti0
         0SCWDbV/RWCgdBhxT9N2wdwUoWiqxeH47Wvn9j1riZEeLm7BikagkvaYAIwgsn4RgKT2
         nLk9revPzlRqsasOj0fKlQ9PjbtUZu84b8SawtANqGSBh/mpTzxaKXjMgKpW45+bihIN
         MsfajiqRavsgxnjKgafDZNsRx3IbjJ2el6YCgAwieJsgOhhz0kwS2fAwOaQw+z7R3p05
         OFaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748872522; x=1749477322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CE13FvVd/oZWld/RcBibj9PFe0iI8IjGbKlr0iRzhJk=;
        b=RPPBw67INP2GAuXWJFINTV4u/8xQMjXAL1gm4QqjE8O9ivPiUHQfY0XIgXcQm3qPyL
         8hliFKGvXMaW5jBDIZh5kM2EhOJBpk4gSDoaW5ssyvlAhXlVTL6YvS9Q1In7ttRRKFW5
         qpIE7c16TuCAvulz2qIX944vA5lkHKtcLxHX2Y3yHcydp8ijv53h3Jnppqhr8bAk5Qe0
         YioEYDyHMfZoNNbUp9fuVKbyZW2qyEBIdrfx43DB1hWQ9kIbJyNfBc62WdvwXDfZHps3
         xoyNFodRJFiRwLn+YMaoGy5MjJS2VMwIc0on+JMPm7gMESJvKCW4R3/2mcX6hiYPmFMN
         QK0A==
X-Forwarded-Encrypted: i=1; AJvYcCUnzd5gDhLQjh4pV5j0EEbumhxt5kjDDalh7rtSlxZQgQ4JrDsRRGHCYDw5yvyKwSkYehUgKkAOEeMZBrU=@vger.kernel.org, AJvYcCV44kj7QDZSNLf0f0MCD+h7f7qqs/ginKvvqlsSPjlLjDIANSc4YysdseRrYuBCPSt5gGJ64GWxbQCa@vger.kernel.org, AJvYcCVmqvgFcFUmFqrkuR3vYFfeW0Vs8NaGyY7gz1wiN6TJKPgdT7GkJ/d4T3ZQ09BirPbqTAyujoQ7Z8XU@vger.kernel.org, AJvYcCVxZuOp6BXvW/7wNx51K2ju1Z9oxirPNYPdSb4OnGkpjwiQfUwo8ECXGhq0M3al3yADB7ssyvqsf2KapKNbjc4=@vger.kernel.org, AJvYcCWlag8hCH6T7f0eLSy5JT01s8PglZFgo1960Qj3rA8y2Y73NoiGxaf4y/+nI65yUZ+k3vxkkNoHNwAggoEgbCzK@vger.kernel.org, AJvYcCXIhX3DFPX0dsZ7doOmmlzNR+IGEQogvcOn8LQf/ZrV1tWM1tI4BjJAFBRk8ak0UUMaSTX36fNxpvpGHx1y@vger.kernel.org, AJvYcCXhAsq6PzohomSjUR5VkB/N233Bd4WHomngaqdLcbgHtUt8S4Lah6ABH+eoS7MXG3S84e2B63+I@vger.kernel.org
X-Gm-Message-State: AOJu0YwYbJScFfNUjdAWL6HWUGgwwR8/Zq1HcSz9qfwngaf8gxYrn6A7
	46833FpPNhgOFke8itm0/elxUvHndJJ1yb0fYoCQFH2taFPhpw/h7pU1qZLjTdlHxXakR0k8fg/
	SB18DVquRc95l+TiTWZC8wGl7//NUtuI=
X-Gm-Gg: ASbGncsWdqQjWEuhZavoD/Rfrgu6LkbzZs9XfWRkzrBW0qkzAhWC5+IaQN/Eg3kvCIc
	KXQ/jwrAH5hGhio9Hs3j69cKTawTuozktfYb6khy84JbNmdM+uhI+i376Zz93KOXZhHTkxXkAJt
	vZOEHql/jb4Ti2JAkx704xS/xQkLlyfJ1Q7bUfTlupXNJNWVJV
X-Google-Smtp-Source: AGHT+IHz2uBVrN38mqcMJz16ScrK52REQ3KL0NzpCYQfCXahCS+RixLkxRyOA9nPkDFUugfUGTPzmT74dbDRz5uF7Uw=
X-Received: by 2002:a05:651c:2223:b0:306:10d6:28b0 with SMTP id
 38308e7fff4ca-32a9e99cea5mr28582111fa.1.1748872522258; Mon, 02 Jun 2025
 06:55:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250530-cstr-core-v11-0-cd9c0cbcb902@gmail.com>
 <20250530-cstr-core-v11-4-cd9c0cbcb902@gmail.com> <aD1knOuEFxv6VQy1@google.com>
In-Reply-To: <aD1knOuEFxv6VQy1@google.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 2 Jun 2025 09:54:46 -0400
X-Gm-Features: AX0GCFttP_CQMaSyNKDR25_XJh3x3vRlTYDuJ8CXsXgGcEC-sRFuWZHUykb5COc
Message-ID: <CAJ-ks9mmkpvgbQs+EjPeN5N+TwOHKB2-9NV-FauGnymmxhxUrA@mail.gmail.com>
Subject: Re: [PATCH v11 4/5] rust: replace `kernel::c_str!` with C-Strings
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

On Mon, Jun 2, 2025 at 4:45=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> wr=
ote:
>
> On Fri, May 30, 2025 at 08:27:45AM -0400, Tamir Duberstein wrote:
> > C-String literals were added in Rust 1.77. Replace instances of
> > `kernel::c_str!` with C-String literals where possible and rename
> > `kernel::c_str!` to `str_to_cstr!` to clarify its intended use.
> >
> > Closes: https://github.com/Rust-for-Linux/linux/issues/1075
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
>
> > -/// Creates a new [`CStr`] from a string literal.
> > +/// Creates a static C string wrapper at compile time.
>
> A C string *wrapper*? What do you mean? I would drop the word "wrapper"
> here.

Yeah, I don't remember where this wording came from. I'll change it to
be mostly the same as it was: "Creates a new [`CStr`] at compile
time.".

