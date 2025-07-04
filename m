Return-Path: <linux-kselftest+bounces-36602-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA8DAF9B29
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 21:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFFD11C87332
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 19:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99002147EF;
	Fri,  4 Jul 2025 19:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PcwR5aNk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C8429A2;
	Fri,  4 Jul 2025 19:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751657931; cv=none; b=VIRiLcW3YAFzcZyLKTa1gONt2YJIYa1Jm2cforGRYTojnMNW0yxRt/11qu4FJ8oOxKtjlgPUykChX1IBamED11v4sx1aCHqBCxFG4XxSjrM5/YBG6+y9I6vgAnsabOh1xoe22ySw90NFcAqb1wt4EvdFrChAaQWl5kc3pECMsQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751657931; c=relaxed/simple;
	bh=+1vlZgumgifEwNecl68EJAlB8Sprq//BvrO4WzNYsMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O4UqPNW32Rh1SCOTZO87PQX/GFrZveNMutozpUdxltB7vkbg4pawbxJTabQpAbUuJTzhFZgBK/20OtDieb1w/cKWeD4NdF3wkf/Y+TAikX82d5QGEFufleSQIcfyUb2CpHujiUVagml3YgBOy03jNHVd85+hmSbx1gKxgPwIfXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PcwR5aNk; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-32b2f5d91c8so11076721fa.0;
        Fri, 04 Jul 2025 12:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751657928; x=1752262728; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+1vlZgumgifEwNecl68EJAlB8Sprq//BvrO4WzNYsMM=;
        b=PcwR5aNkrf7IHfPVH1MG1RCWor6BX4Vv1JxMCP4wh6qtC1hIjk8HRYHvCW5XAVOHpc
         RbHgNf3wXsnM2dSCiIYrIMyND6cQe0MmRUn45QpS47CTIkv7Xqh1RbZpxRT0ClH2SyPA
         X9rDu9fiUdpwlcY6okwUgaVr1AOlWCam1lCf58vMahsBAFfLICRU+I/yGr+3fKlKTj2Z
         Rw2gnW5O3r7YhCjdCTwFFoBbL9jYvx15vSLlR0p2E7p0R/0bqfM84x1Jrv43kEn95G1d
         04a0c4ra8k5+E9PsZVARYx8TviIMsplG6B2+rrLKyMPwCpnf4hxPJKikH2uXWZJNNFIC
         0DPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751657928; x=1752262728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+1vlZgumgifEwNecl68EJAlB8Sprq//BvrO4WzNYsMM=;
        b=raxSgSuaVgX7fQ+wX9K+s0u+GvO5Aw6t2ncC/2HO8KYUhjMV0CyIPHtQENFJ6Q862Q
         t4d959zdiVr4Ydl6FDdNSAiymlT/MIIfncSDWam7q5MkBqjqn9VkQyv2xnJRl3Qf+tQZ
         EUxtIuG49RDbkxlLFwtDcs1Vbe62eyqVcgMVNGUjQNjxAY1JewNSYkWSM9O2Q8QGXfy2
         LT+A7pzga2purScOBDAEzvxDSgVhKWdtF0kSn6NH7cRtLifoKUK6i9th1sHPP63GPGjI
         rI9nmzuvvNYDCHwVNNN/cvRCQkDVmJe/0+sSXYa7hHQQQWXWqNNVpxlbk0t7qiKZVKkO
         wRGg==
X-Forwarded-Encrypted: i=1; AJvYcCUHCy55bSmZk4jpp621J/soN5QPIdagC/ixqvPqUrR/Apr8Df66TWcvbwGp1nLFGZkT2Lslc32EhQE=@vger.kernel.org, AJvYcCVM673+sBvzHRJgAcngzCBUOpx1nSAzLlBstq9wPZsz8PHyE3B4TporMsSQIvWjUA6oXLNb8I+ydWwcDllI@vger.kernel.org, AJvYcCVoTwxWo0g1NuaV+qLTapK1TnYDJsieAVQZ3jG8456dsX4p3jtbDQgFL13sGBAQUoI+kOQrP95M@vger.kernel.org, AJvYcCWZrSlRoogZfOjFNalN9ML9VEgZjNcEpYHyvSLBEbLoacw9QdxEXcZy5Kdr3jbYlI0QrCjtDCBzzsITcgWR4iYn@vger.kernel.org, AJvYcCWxgf+UiP5R/W7etgzKzjZezrJDN6xD7YVEm9Hm06YLh+neCAe3GW/JwCBnrqSCLD/gUR8Cjx8GFBIb@vger.kernel.org, AJvYcCWy1a/VkwRrMIHGtDp+auByY0+u29V6b38yAJTzv4uimbnOQI8RMbn1iiV0j7+uBPcOcOBsSHiyTOxY@vger.kernel.org, AJvYcCWzAcGvs1dy/a4s2L1Qhho0ytI/m/rQUbgkIr32GKDaeYYrmPDDnHhZp47MDG/cDJC296+pgJU0yfuB@vger.kernel.org, AJvYcCX2wnjAeztcciqCgRk+FnFOf+uNTcxRyqwkR96ZwcaUxfC5GyOySeDYJ1+pssc+sNBwmlsY0+o/a8Umxdg=@vger.kernel.org, AJvYcCXpbVRtNAkIGAhMIDg7g2ZFXvuMH6JTgZTDpvsTyB+mzrTcN1NuOcMFXmwYKCtJIieNpAFagHVURbCtdNS1Pps=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0NRdHaXHF0yfak5KDlnhLKA/0kfeyrb1Mh+7VzZJPdzKZha0j
	+nd4wTMkZfpASgA/yMXIgBGzAX9+hLROad+i4lqYAqRNHxCQ6lAt4iL1ys8SVm1N+i/lLUnT8tr
	nxXVfju7d60fgl04REwi+466IsObtq+0=
X-Gm-Gg: ASbGncuMDJJrjpQX40Sl5aD0i8pttq1CctJIRLw/lJeuEVHPkM1cjuWE1X3UHS1/8iu
	Eg50sQ7KdawCsHbic4tGloTDPe/u3q1yKVfWiwO0ZAR8arIN87QhLVPGFsRXGVLECadmq/LWCmq
	8J/XX5WvVbK030n/5x175pkUaJnBFiLmJ0Knh2VNM6clNdzsGd+253/Z1iadINMA8S0z8TUjykU
	gP6uK7esChwwRMb
X-Google-Smtp-Source: AGHT+IEtZIZHyQdOcRcbH+zRF5QnKwCn2iKXPxprHvYuNR2jSg6UqBw9KbMdEWrPUWxqoAE0oN54aToeuNsJtUiGyRY=
X-Received: by 2002:a05:651c:542:b0:32c:a097:4198 with SMTP id
 38308e7fff4ca-32f00c63744mr9980551fa.1.1751657927846; Fri, 04 Jul 2025
 12:38:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701-cstr-core-v13-0-29f7d3eb97a6@gmail.com>
 <20250701-cstr-core-v13-2-29f7d3eb97a6@gmail.com> <DB2BDSN1JH51.14ZZPETJORBC6@kernel.org>
 <CAJ-ks9nC=AyBPXRY3nJ0NuZvjFskzMcOkVNrBEfXD2hZ5uRntQ@mail.gmail.com>
 <DB2IJ9HBIM0W.3N0JVGKX558QI@kernel.org> <CAJ-ks9nF5+m+_bn0Pzi9yU0pw0TyN7Fs4x--mQ4ygyHz4A6hzg@mail.gmail.com>
 <DB2PIGAQHCJR.3BF8ZHECYH3KB@kernel.org> <CAJ-ks9=WmuXLJ6KkMEOP2jTvM_YBJO10SNsq0DU2J+_d4jp7qw@mail.gmail.com>
 <CAJ-ks9kNiOgPO7FF3cAbaSNtTWs0_PzQ4k4W0AxjHNFuMJnDcQ@mail.gmail.com>
 <DB36T5JWBL10.2F56EDJ1XKAD0@kernel.org> <CAJ-ks9=Jutg+UAwCVER_X91BGxWzmVq=OdStDgLZjTyMQSEX6Q@mail.gmail.com>
 <CANiq72nZhgpbWOD4Evy-qw2J=G=RY4Hsoq9_rj6HGWMQW=2kTw@mail.gmail.com>
In-Reply-To: <CANiq72nZhgpbWOD4Evy-qw2J=G=RY4Hsoq9_rj6HGWMQW=2kTw@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 4 Jul 2025 15:38:11 -0400
X-Gm-Features: Ac12FXw768F_Lk3HRxkz7eCyR4EleC6ZiRWgAxdQvNU_x7ZQ7VCNlmwZ-Al3Xv8
Message-ID: <CAJ-ks9m4S1jujQvyt9TOvNMewjNSztps8vayGga+MnNU+0YUcQ@mail.gmail.com>
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

On Fri, Jul 4, 2025 at 8:15=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Fri, Jul 4, 2025 at 1:59=E2=80=AFPM Tamir Duberstein <tamird@gmail.com=
> wrote:
> >
> > That would probably work. We will probably see regressions because we
> > can't just replace `core::fmt` imports with `kernel::fmt`, so new code
> > may appear that uses the former.
>
> That is fine -- it happens all the time with this sort of approach.

OK, with all the splitting requested, this comes out to ~54 patches.
I'll send the first bit (which can go in cycle 0) as v14.

