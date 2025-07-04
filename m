Return-Path: <linux-kselftest+bounces-36548-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A6FAF9252
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 14:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EFF47B8206
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 12:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9682D5C9A;
	Fri,  4 Jul 2025 12:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FkL/oiQn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA1B2857EE;
	Fri,  4 Jul 2025 12:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751631342; cv=none; b=lXo6/qjiySAJMz0aXg5PwvL0m0/hVxcNfT8Gg44o8pEnP0STrHHGBWMonpbF038zfvG8NPLXSPO1+gc9qTK/nD5Lp88c/y+wGgdG6aTNc4mIu8QwUAH8Z6IW95SNiY3rFnrIcgke7jGFaazYMmHhCikxm/PYWXWy/1FzSegXkyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751631342; c=relaxed/simple;
	bh=JTF27XEasyApS1nP/vyqUwBctBYmx+jAOL8SGdjCGlg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NL7l+yFVRQb1BgGZMsHp3uVnwSiD5n9SrHdGay1ZhpI/CgRdgbMBBHlE8HlLHPviBx8Dptf+UfJ9Yz67PCzQtAAFqzusmrnZ/e3/RvI/moigWE8pvyO5IpnO5GtzYpNs3ldhQ9OzYHkstpxdvtHnOQ5aI8J9A83zcOZ5TCivKDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FkL/oiQn; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-31384c8ba66so182827a91.1;
        Fri, 04 Jul 2025 05:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751631340; x=1752236140; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JTF27XEasyApS1nP/vyqUwBctBYmx+jAOL8SGdjCGlg=;
        b=FkL/oiQn8+kDzCgydhCMh5sbMGoAsteUYk0dlyafVM7AHP9G9qtvyNA+b5ZmYPhuYG
         btN0M8+zOmqF9cPCrU9a1ac3jvrmlw6EFNAb3eyT3r2dyEV2Vjy2wAOOmvIJ6GT2aSUE
         HUH0gxOZ6Gf6qt8/PbMPZec5hIaLtPEmW1Asz77y1GlguvaoCO7LQfqdi8vIDv9i49W9
         6tS2tB8y658AYEyL2hD+AMIKmnGT+hHua06VDa1CCaIJjL2V1iB9pcTVm0ENqZem1YSt
         AiD4AYqdEtmXEjEiPI0gpIjaPKoBSx7y/UOYwAr702Z9eIQfEw413Eh5y5ix5DQcTF48
         YXpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751631340; x=1752236140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JTF27XEasyApS1nP/vyqUwBctBYmx+jAOL8SGdjCGlg=;
        b=YWUqONY+M4kOA+9r50ACx58YgRTlRinicAHf8X0f4KGsQjIDIgvk7tKVfRq+/PcOdH
         pt44pNcWGu97lpEJkrfup6ix1kq+Qf7eWn91kVf2RMwB0mg1SbzC6HlmrMYGpvdvi7oh
         x+1l7UJp6uxkAy/5LhLYSO7rHWF35CswHIVhSigVx2POm1SlNM9B5StyQVAvUuP8kkza
         Oab5FVwwvLAY7jbRLc7Ce5MuovN29zX1CFxpVvVdHkjsTQPcpPqjc4NCYPuEeWBZEE05
         lhr3HI96paYXAos6IZcSI+O7FLtdcWPho0z1yD7+Qc9k0kyYST78NQPkOcpxci6pkN6k
         G28Q==
X-Forwarded-Encrypted: i=1; AJvYcCUA5w0bp25swTMAFZAqa/uWiBK2n3SG+SMfu9a9EEXAW3vFUkuJEBxTAcO9Z+sxmRzW4gkJe4F1PakCfveUu/t4@vger.kernel.org, AJvYcCULTCGDRt/g9EJpzcCocZSpwrVzr2qyjAaIORtvq2aJfDqVHWPkiSr6ev9Oe1u4q3D7UEqcnTIndblR@vger.kernel.org, AJvYcCUVYUxGDzu3pydous8AWgd/Yz7tUWbLovRP5yIlxGacscbuEXM5i2Kc+1NFetlYPyhFjYNz+NKzWxTtPnhmDLU=@vger.kernel.org, AJvYcCV5rfhRSK+7tZ5uEa7GllVDRRNqMpwBhUq5QpX+tG/cOb5fDFUhL0hdJktGfZ7xRfPP3Vwe8BluBZJPg5/z@vger.kernel.org, AJvYcCVVX7SksVdlWxNBWf8Pe2Xedp4gX4Jm1yHfE7yT9Akkv+LsF4ArtrOvVUAVjGzBXrwiylLKWdVgte0lWuE=@vger.kernel.org, AJvYcCVm0PakMMXiIEh0J/5cCkr2UBGCA+oKRIFkYtWeoQGliwWNTsdWYD2qDfHwc2UfRbcOffXD4Rhp0Hrn@vger.kernel.org, AJvYcCWBkTTxzoWvSb0mcTIQWCKtMEmUPy8bEWv6tmSHpQZ6za0ZPGyqCWbBIeaxYGwWcahJ+lNJHAVt@vger.kernel.org, AJvYcCWDZIZPVYMRSfwTd1+BBCJ9dVrORSOAoBSUqr6kM6wRf7fseXVtn4kd+o1+KRQZZHDzoKUOxY6LozDB@vger.kernel.org, AJvYcCXU9tsEYqJf49QNExAc1cixFf7Jl4Gv+viM3YGx2xHIw6nwBGzXOSbQ3vTSjVrsmocu1VLlH/hcasw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx3zZNgIxKQeRJhPDlbzog2V22j+I9G3ITwE9Z97eeIjLbYleB
	3v7qgSHH9mMA57X4vWQTmQqEf6TYPUwzKSfo54m+IeUfE41o9Y9mAu1WM/CsvfTjBz1Bp+8UIHt
	H+KZ32lTGsguApOsZnLbkZHmPxSLhuqA=
X-Gm-Gg: ASbGnctWCCOJRA/sRvPxlzm1wtu+hxwSfqBtOSJsSIIygEYHpKQVJnzFaBvi41c3a+3
	yKi/+EozAhwOGcsc3/EJD+1BF21hi0l/O4g5IVFiJdutgcSjgebo+f/lkO4ZX+kuMX3EnOqx+CA
	yh9ynqZdAYg6iGNhALsoZTkbVq1oDqZmCp4v5ftwKpiaY=
X-Google-Smtp-Source: AGHT+IGMzjCKsb3QoFjzETIEVKGlrEiZLPHE+Z9w68l6rNpjdGz0kB0KwvlouvJt/ly+yLKAz3cW4FDCb2lbzAAjjzI=
X-Received: by 2002:a17:90b:3fc3:b0:311:a314:c2c9 with SMTP id
 98e67ed59e1d1-31aac44a149mr1478613a91.1.1751631340480; Fri, 04 Jul 2025
 05:15:40 -0700 (PDT)
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
In-Reply-To: <CAJ-ks9=Jutg+UAwCVER_X91BGxWzmVq=OdStDgLZjTyMQSEX6Q@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 4 Jul 2025 14:15:26 +0200
X-Gm-Features: Ac12FXzPtonKP26H72mazeNQheIxGcJYasTsJs3cNwtUf90Sdk9qUBYY8YzvhN4
Message-ID: <CANiq72nZhgpbWOD4Evy-qw2J=G=RY4Hsoq9_rj6HGWMQW=2kTw@mail.gmail.com>
Subject: Re: [PATCH v13 2/5] rust: support formatting of foreign types
To: Tamir Duberstein <tamird@gmail.com>
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

On Fri, Jul 4, 2025 at 1:59=E2=80=AFPM Tamir Duberstein <tamird@gmail.com> =
wrote:
>
> That would probably work. We will probably see regressions because we
> can't just replace `core::fmt` imports with `kernel::fmt`, so new code
> may appear that uses the former.

That is fine -- it happens all the time with this sort of approach.

Cheers,
Miguel

