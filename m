Return-Path: <linux-kselftest+bounces-35318-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A151ADF540
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 19:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F2AF1BC3A49
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 17:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65582F49FF;
	Wed, 18 Jun 2025 17:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QIpUa/PK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0083D3085AC;
	Wed, 18 Jun 2025 17:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750269471; cv=none; b=uIM7+pAfFflFjAbwyV3NCPeYYgmhEKX3YgIoKjewdltY5AA6Pbosj4Oa4To81EF4EWCgkvpTh0wPanUpypPsCElIW/baYi2Kfbmge0P9fqy/4JDbKSwlMSxgiCKfAOkiSMforlqgBhhBqWto007cUNYnlKul6jqeAoJqRmOxmEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750269471; c=relaxed/simple;
	bh=X6XFf8IdJRgq64/sNAX2ri3Q7ZGbdF1/uOpdG54+E2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R5SUbFgNCFoRHp4DCDaFy5EHEEgfJQ5Ayg9cnE1VApsjq5JUEzOuXtIwGym6xvvl+5TUYf80W7lcKZlvXd7RQObHRFG6/6w/7dh2om05f9Pm/pMQN1hWtw2CuaIxprFwLpoKVEWIFO3bORC0/CUk6Tfq3xs7fOc4Gn+ml+paYaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QIpUa/PK; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-234eaea2e4eso6821085ad.0;
        Wed, 18 Jun 2025 10:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750269469; x=1750874269; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X6XFf8IdJRgq64/sNAX2ri3Q7ZGbdF1/uOpdG54+E2M=;
        b=QIpUa/PKaWqIJ1PAmwf1rOYqk9U4VqnIoJZvoSejrdqjYrLP3QO5mGuQ9ejPzZIXqu
         60XpLXJSYLPDUPDNVkWC2FVdVr9PoFV2wM5A8gcidSgUbCogSUVOz5kIru9gy/Sq+EWa
         bjYK93nwdG8Q7u055P/9HxkH5TKtI68KFAeU05MQ/+Isows4NtgwxL6xiF63Z5hoXg6f
         26iTrk4cE+2uzUfBt1jX2rNoDRGHMK+W27PfVdNNfG+esvGqdBpLQVVHdKhMl/loSrZj
         niUTki2ifeCIdU9WEDE+q1c2br2cvkMpa1GeQlTkeQvZUsiw1A5YISTlVsozheJ1n1nG
         AH9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750269469; x=1750874269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X6XFf8IdJRgq64/sNAX2ri3Q7ZGbdF1/uOpdG54+E2M=;
        b=hwbw5KUx1i9EV6gSrwxUrhAHrWe3mVUmtMMBHntpkHbtLoiGlMOLW9Yesd2VdkKr+a
         7ABAtmPd8IPea3fp36uRqDQykKl6itMM0343K+B1EZOTKUwMMucRGxqCkPxXpbp03wEk
         aftrBtRaCMgVkMcoLHJQ5eI2X33wE/AlsWh39ryFs3arW9ZAEG2txPmNdWUaeM1Up3mp
         d0XVZiw1UI3qQkKjEZdp/bOU2LGeGjDwvgFqGOJV1uQ9+ZABQJjbxWhr4I89tqROr0w8
         XBorrCyCp4y86fkUjOyl/PatS9BC7wl/BhwQVo4jGMjUwqU84WjD9uue7Bs0j0DAb5VL
         DG2g==
X-Forwarded-Encrypted: i=1; AJvYcCUTMas0hNRvm6zJl3v1eJyzN26rN8yJurOU/xvW+ApoVO68UwH/hlvrlqWjQHwmy3KQHqxtnz1Q0vDZrj1W5Xas@vger.kernel.org, AJvYcCUTtsYuk8HQpd0W7ejbVrRRUBY5c0azYeNxd2SPEGFYMojUOFolc4cdnlXHJ8y82zpJSjGNZ4vGmeA=@vger.kernel.org, AJvYcCUb736O/kHW3oMVluSejXmi3QgV7XJM9zZ1D7z3+ZYAbv+StWOdbg9IDjC9JX8QDB8SQSfinlaglIljcpHB@vger.kernel.org, AJvYcCVFhPgowQ8vMaGkXmRcHtGMid47yioqGr677mf14je7Yb1oD8HzWChObZNhh1T7J/YmGVYt/QoIIjQjjQs=@vger.kernel.org, AJvYcCVLpzT+tNqcVsQVYD+0AZ8agDwS/xJqwJy12F9EYq29ENLP0NOc7Mww0uigLZ1nb5/Bgl/PxOANIC/osL6g@vger.kernel.org, AJvYcCVxBodqak2xOOGbo9tUIyQ4j6epZ91hIrXFbJKqePN0icOfm2I46iE8yIyGsGjgYvLYFApSJ+SYenn+@vger.kernel.org, AJvYcCW6Wz3tRSk9NQBN8fMT1cKbSfjQTiD+7k/WvgN2014vau3g1Uwii9DYQyQscg1AAE2byaeOT5W8@vger.kernel.org, AJvYcCWffXjwAI/AdmVAm+TOySicM/12EkKTzeBQLU3u0IOcUo+mnIoUZDI5wwnooNpBuUEPewPMDip01VDI@vger.kernel.org, AJvYcCXojTEJsPiYMFaACqTRL8rMc3ZOzhSFJr2eDiPRbNRbR/QS7erfNm6WSmkJBnGrey/9rbpAsgeIfsL1vc33+To=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/kK4pabfM6i/TEoZXaQ145iX/qlzdI+VjKwZoAhN+zpluT+X7
	7fLi1gKfOlQFJy7Ar5tbQy5WdLiMyN43l16ish95bhFkIhcuRYaohskYmE5Uj4VhgqwjkhS2OHx
	q0XKb2oweuu7xOqm9i8PvO7V2mFm7qr0=
X-Gm-Gg: ASbGncslGDQtM3Z1qJkQJR6+L4aalJqFbj1p7ngjGKIIGoKsqQwv1779ygGlLo/vYIG
	z+9suqpCOLkFVougsK/OUkj71I4BWPkrzr7cYUggx2vJ5ToGZWHy72DfysohoX5003ZAKJfLLof
	w9uiItP+fpuxZRbjFia3zgbFE+DYnTeEzRRVLFean/5AI=
X-Google-Smtp-Source: AGHT+IEVtT/3f0vGFFzsBMs3GOlT0P6QvR0Bn0p1lko9fCNW+9HJclQmxYU6vH8Ok8iI/KHslbJ7BSrFR23F0qaUQxU=
X-Received: by 2002:a17:90b:5251:b0:312:e9d:4001 with SMTP id
 98e67ed59e1d1-3158c10362dmr113240a91.8.1750269468961; Wed, 18 Jun 2025
 10:57:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250615-ptr-as-ptr-v12-0-f43b024581e8@gmail.com>
 <20250615-ptr-as-ptr-v12-1-f43b024581e8@gmail.com> <CAJ-ks9=6RSaLmNmDBv-TzJfGF8WzEi9Vd-s=1wyqBcF7_f7qQQ@mail.gmail.com>
 <CANiq72kgnKH2SSp76EdPeysExBWasqhTyf1JyReR65g6FMsidA@mail.gmail.com> <ccbc2a76-20fe-4f70-b69b-9d05b59f24b8@kernel.org>
In-Reply-To: <ccbc2a76-20fe-4f70-b69b-9d05b59f24b8@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 18 Jun 2025 19:57:35 +0200
X-Gm-Features: Ac12FXxqyN47ZI8vqKVbteA5mz5j0mgRRC1KtP63MHI54ZnGo4ZP4CLfw3Of01s
Message-ID: <CANiq72mboC5iz0Z0ZnAAMNr70aQT1vddZ=cXFSO-5_CveVTCng@mail.gmail.com>
Subject: Re: [PATCH v12 1/6] rust: enable `clippy::ptr_as_ptr` lint
To: Danilo Krummrich <dakr@kernel.org>
Cc: Tamir Duberstein <tamird@gmail.com>, Christian Brauner <brauner@kernel.org>, 
	David Gow <davidgow@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Tejun Heo <tj@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Russ Weight <russ.weight@linux.dev>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Robin Murphy <robin.murphy@arm.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Frederic Weisbecker <frederic@kernel.org>, Lyude Paul <lyude@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Benno Lossin <lossin@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Breno Leitao <leitao@debian.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-pci@vger.kernel.org, 
	linux-block@vger.kernel.org, devicetree@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, linux-mm@kvack.org, 
	linux-pm@vger.kernel.org, nouveau@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 7:44=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> Independent from that, won't this potentially leave us with a lot of warn=
ings
> from code that goes through other trees in the upcoming merge window? How=
 do we
> deal with that?

Yeah, good question.

Since they are Clippy ones, it should not be a big deal (e.g. we
already had a case of a lint Clippy lingering for a long time due to
timing of merge window etc. in the QR code).

In this case, I didn't see new ones in -next yet when I looked, so it
should be mostly fine I think. It is also why I asked Tamir to re-send
it at the beginning of the cycle, and then a v12 to include a few
newer parts that were missed that landed lately.

So, worst case, they get fixed during the -rcs.

But, yeah, a while ago I proposed to have -rc1 to -rc2 as "treewide
cleanups time" -- it would make this sort of things (that is not fully
automated, but close) easy.

Cheers,
Miguel

