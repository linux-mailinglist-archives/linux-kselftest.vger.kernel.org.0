Return-Path: <linux-kselftest+bounces-36481-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC7BAF8110
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 21:03:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2CF41CA34AE
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 19:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653212F2C6E;
	Thu,  3 Jul 2025 18:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BmKyDudC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873732F2C4B;
	Thu,  3 Jul 2025 18:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751569075; cv=none; b=IM55df1BE8lXwnECQJ6kRdtUrVR3hBHelpRt35xFrXYQ54otm8pEzE3ySWo5N0UkbXOdL193LOrHgY/L6KUCjp/gJomGvQ2Rt1ML9cn/DpNKgBTkFus7ttfxQkzDqp0X1Xiv96wM2V0Zhcggn9rM5K9AHfof+8zNahrMmJ6I7n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751569075; c=relaxed/simple;
	bh=FiAe0ywj3ALVyYeVpMIymC5Jme4Ulve8NgwE7MU7/y0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PA27fL4i9MPHVY/rLBns83/Cp624qvIrcseazZwYllkE4kqzpjTFVroyce2DMYWLNu9U+eTFd5pr1qFPps/w8o7MrIhiSQICcXCW4E5u/vzRmZ5ewarrnpaUrJMtLSoT6dpsZ5FVmT/Iw3aXiAgiDefAwLVGXir03ulspBpAx1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BmKyDudC; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-555024588b1so250437e87.1;
        Thu, 03 Jul 2025 11:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751569072; x=1752173872; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FiAe0ywj3ALVyYeVpMIymC5Jme4Ulve8NgwE7MU7/y0=;
        b=BmKyDudCGzS21Rhmaf4F2bTPWP/6bGVxn7EBMxda9ufLacXD+o9EppxeyxTM70AEXH
         hYfKbOA0UehVwb8vL7rekRIlNCfuZn4rii9WYbM/cCOT+ZmQ87Uk+YOEpf+ZqVLYKagJ
         WdRiIMK7E+lO0VJkZ+RXl87opcAQrSprAPF3IoJIZUSZVwKvZybnZHPNBSDqxjXEEVH1
         DQImR91kv4G/HIO45x2uyUhCHQB8XTZAL4WNPY76y4iaYXUb/6XZ+v1Me7LnT2f3cb0s
         pCnSJu44dAn6RtEnD8BONpRAZ21giR7cj1OlCNbQAuP3SnFS5oH3NaTkEAbWKDmc2qo5
         Hycw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751569072; x=1752173872;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FiAe0ywj3ALVyYeVpMIymC5Jme4Ulve8NgwE7MU7/y0=;
        b=WWcFil0UC6PWN27rOn4CMH8MXPZcbPEbWjKTFzftw81kNt/G+VaXB2FTmLGANOmbXc
         uWC3MQlUI3Umm0wxfaRlVF3SJ6HjDv0REq6NZ2clIsq3D5fzEBEQDXX1fLt/TULDJWjU
         PDZ8Tmm6S0CllPJxxBlCQfTnmx/KjBvzhXEfiX06nu7OJt5u24E5pGtQUnFLVUp7EjSi
         5xkzMZ1U35tPccKyLX6UgikMg9zO2bE4512iHXIW5Qye00I/tqLE4ngB1QEXaNvpt3kb
         JBPe8SOJ16a68/bAOYMy3UYBePhmlN1uULIxbG7W84Tu+vAN+KiIudFPFhh6fLsMGTxv
         G5Qw==
X-Forwarded-Encrypted: i=1; AJvYcCU0SM2JvB4iGsF9Clw3ruCm+9x5wUfi/hNa2u3FCKtRU3MvrKrmYwPST9yCSVvIGXOhr4LXspwS@vger.kernel.org, AJvYcCUAV3ntnXThFcuyK9TsvQtwNc00CNFD2lQOtkIjTqa9bvReFmmUBzC7Mo9yy3+SlN51BMwxlIa8jdnz@vger.kernel.org, AJvYcCUOT2RSARr4sDG3uhWx/cXOw6kT2HWEQW8dglAUXQAEdUvc1ev4SV3h7uKAy7kRFxgQN3Qig9/exSZW@vger.kernel.org, AJvYcCVdZmFCejGzR+OFZeB34mxhacay8Vgn1nHpOjxROQBX4V5FRGPew5N9yPwbPioJV2rb+wg8lCNFF4cAw0M=@vger.kernel.org, AJvYcCWNuEyR8Z1OAU0zrONWuy5ppI9lOZs9gZyZiKGLUG3JX/q2JnLejwwfJPU1JbIiNRlJ0tYeUqjCmsxu5BQVnXBh@vger.kernel.org, AJvYcCXJUvng4M/nu1DkL0Fcd5Ho5+XYbFuOAKxymutPl643W7nhFmDY2odNKBMA8Fp0ga/6DuztjzVJLMtoxKqPINU=@vger.kernel.org, AJvYcCXNfvBvdNUXrZjNN1rATAwxre0B1l1TnCiV5mC7I1hwr6Znb2XoktbF97GRYE/eI0YyqX/0D4rz6F8=@vger.kernel.org, AJvYcCXNidHeJ8aJ+MFw6GJm819YVeye9+o/uyRdaCLxhQq/3+thOanHwwQuEhO+9V3dGs1teUm9nmFpgwBo@vger.kernel.org, AJvYcCXdvVmmsvyxD8mIJImmu11Vduo1vnKiloQpjejeN/L/rdNgTj6LgujluHaoq8/UxqI3i/VMz3NbOZERqjN9@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9zMQT2QIVxflGTxhxOZvNUl9nwB7oAemFLZXTixlkGMZmdxEp
	8T60DAZkh08bkP2/HbsWE2Jp6jq21BoqtubxgKQDZ6F9qTRxTpAOeK4KtK7LjRC9gRZlrkyNMmX
	6KE5DeXhpWLjVwFCIf1keGuXmRK6z2hs=
X-Gm-Gg: ASbGncsMTlYZfmQ1pjcTco7XxsorBKneBS42jcvgGF87IsQuMkELK5Ie4ZgxrQJ+xwX
	1dutaWgHHUgtFB5dci4vV2Gwkj7Qkyo8xQ8Y84kuylMos3ElbsCv+Rph7AxxOJXqkOFtJW8L+pR
	8DGIGwzXTnv7lOLlAFmJdkqKYgXRsbmZlHktUmUuaN9+tYnQ==
X-Google-Smtp-Source: AGHT+IG03u1s/dKr5lqrvPNQ09T92o4JjB8rN5Nj67CbTA0x433vtUSLN5UqSf5eZDmLPvVjVfuvUqvcmHi9wOrWOOw=
X-Received: by 2002:a05:6512:31c6:b0:550:d4f3:8491 with SMTP id
 2adb3069b0e04-556283804d8mr3415342e87.41.1751569071362; Thu, 03 Jul 2025
 11:57:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701-cstr-core-v13-0-29f7d3eb97a6@gmail.com>
 <20250701-cstr-core-v13-2-29f7d3eb97a6@gmail.com> <DB2BDSN1JH51.14ZZPETJORBC6@kernel.org>
 <CAJ-ks9nC=AyBPXRY3nJ0NuZvjFskzMcOkVNrBEfXD2hZ5uRntQ@mail.gmail.com> <CANiq72=61JhEf97JTkineo+FX+JG+Q9x9x86MC_hukSa9YSX3g@mail.gmail.com>
In-Reply-To: <CANiq72=61JhEf97JTkineo+FX+JG+Q9x9x86MC_hukSa9YSX3g@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 3 Jul 2025 14:57:15 -0400
X-Gm-Features: Ac12FXyZZloauRegGbOIuXfH_Sgil7e4CwfUR1COZp9IX8xKJZCjuiY3W9nvJEk
Message-ID: <CAJ-ks9mvLEPLMJS6E_UPc4bkRN1q09zYC_oL_pZ=E_Ff161USA@mail.gmail.com>
Subject: Re: [PATCH v13 2/5] rust: support formatting of foreign types
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Benno Lossin <lossin@kernel.org>, Michal Rostecki <vadorovsky@protonmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
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

On Thu, Jul 3, 2025 at 12:26=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Thu, Jul 3, 2025 at 3:56=E2=80=AFPM Tamir Duberstein <tamird@gmail.com=
> wrote:
> >
> > Can you help me understand why? The changes you ask to be separated
> > would all be in different files, so why would separate commits make it
> > easier to review?
>
> By the way, if we are talking about splitting, it is easier to land
> patches that can go independently into different subsystems and
> avoiding flag day changes (or making those as small as possible), i.e.
> ideally being able to land big changes across more than one kernel
> cycle.

Understood, though in this case I don't see how it's workable. The
formatting macros can either wrap in fmt::Adapter (and thus require
kernel::fmt::Display) or not (and thus require core::fmt::Display),
but I don't see how they can work in a mixed world. We can't have half
the subsystems implement core::fmt::Display and the other half
implement kernel::fmt::Display.

