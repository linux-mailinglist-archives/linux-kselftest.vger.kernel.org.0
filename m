Return-Path: <linux-kselftest+bounces-37269-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A35B04417
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 17:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E7BA1654E1
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 15:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C575C264F9B;
	Mon, 14 Jul 2025 15:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKINuZM5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1402620E5;
	Mon, 14 Jul 2025 15:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752506890; cv=none; b=ExBGu8Jw07dqioKQgYyBVx16X008PH30dZ6NoTRhlU14gfHjpZ4pzDDWSOsE5iH+uhgabDEJeVy+vVKm7FVfum2isCZvKpY1VHjSrRjPhjPgYeVQkdCBPLI/wjUwJWPM1ptbhoD9D1w+xrmuxmbqONNbqOCiE07EVIEYidMaTBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752506890; c=relaxed/simple;
	bh=oc+GlE+Ii/Y1/zyiLxV403jXwmHI4Vq7Wn9/5LCARxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nhNdVm8wlw8xtb0cM+LtFp3e7PctdykE8OGA8st38V3ktAyETPZ8/iXyHzojVdT4YmsG02xMwj/1LH2cntfRiM3P2PXR6S/X4ex0qdaXsuwsHMsWeMgnlUOAo0jTSWZE9P0mhXFxkasg4RDVWscD1I2gY6j361vCE37VR1D/y2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MKINuZM5; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-32b50f357ecso38289711fa.2;
        Mon, 14 Jul 2025 08:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752506887; x=1753111687; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oc+GlE+Ii/Y1/zyiLxV403jXwmHI4Vq7Wn9/5LCARxQ=;
        b=MKINuZM5XBC02FZi9X8B2BpUiYUbZe3b/+InaAbCUxH7f2XJLrJFuVtpiIngGvntjJ
         hvRMo7pvkLmp2D7jLb+NHuaO0d2cgX7DfwFtWniHOdM8gW8U3uhGPvv6JeYWdIYCngiT
         IlS3nbV8swHJ8bFQ/ZoEUZohkCydAi3DgZnMCy+o3h+AQkdcGKZ/6hgXZNEaKCyUDtOm
         5ZhFS7Pppnph7dQoW+Vp/uW+y3cAIAMVvW19aIf8wVvCgnkW0TfMQSmm2L2Ekk1/v8pi
         zSPlAoAGYI/uwxH/jcKdXWRsTQKNhzZVbs2XfXTEKEt3TJMT3/gRZ7chnNuWZIg9iIaq
         aS8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752506887; x=1753111687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oc+GlE+Ii/Y1/zyiLxV403jXwmHI4Vq7Wn9/5LCARxQ=;
        b=sZOJIZx5TXYVCTG/Jbctn8PMKbJVRyudeityIP8h25OpnKr95L6n7gjF5cfZsADoi2
         TJyolL8jVC9n7JbWC42Y1F1A36F0KwxrYx2sYW0XA5nB5yL2qBa7hrXxeoLEBhQmsB1J
         jBNhfTYv0C/yjT27tgwJN0ZU7TcbZ6y7Qq41/fLYMafzhdtckFUjAj2LKkYbqKxQJU/+
         SCTJag9qJuzJgPtpiVqr+e9G9jyWiJ6CGODw7c9TUEFZ0KTggO5aN9g1Ki9YOx8QwGSb
         cYYUKiP1ElpcyrTxGYbFgxOIgiu0xYgt1Z4K6z4iCjcnOh4q5qxmESqrur45OUa9n3tY
         CYfA==
X-Forwarded-Encrypted: i=1; AJvYcCVYdDE4e/JZwz0s2VYg7E3XeFLCgJBe4k8yPI1kI1bp+NjHSCiwDsDCrGLV2m0P8l9yhWfy/4swLPR04FNslWU=@vger.kernel.org, AJvYcCVhMjFDZ2thAjd0esYBdiogLwI/93ks3VOudz9tQuVUDUz/f9qrsQRz614gCwRwIwKeeUrRZwplpmsa@vger.kernel.org, AJvYcCVwX84X3gbuqomAT81pr0W56yf7A3irraveYlwa7p26LuUBRtZpZ2wz7TNVYo5IdelKfcWeClvUG7NvodG4uITn@vger.kernel.org, AJvYcCWcT3ylMRjt2ZFpxevrWv7SOh7V12Zc8lfKcg3tH+yHluF6yFvXViFyW+LPcUiQ605rDJNaVlz/xYI=@vger.kernel.org, AJvYcCXDVMTKhLkUZRM/pc23a91woiS0qHllT7uWxWUVsEfCodEQIv0aTg9nzx4e4WPrjjpnp0WS06egfAQ5aQQu@vger.kernel.org, AJvYcCXayz3cgG1LDPsCJdPmkdYZYHMrMBjiZI8CIi1L7oPhIC25VMIjDKRBR3kMmQB73rVHCDn1VHmO@vger.kernel.org
X-Gm-Message-State: AOJu0YyP2+pNtfFQaKy8GGfyPGJBS95zN09fgliC4f24CthcKLen8NXZ
	LUCcPmN2nJiu9NHRvwLBrqlDUDndUr78MCuCZR/Bf2ljuHAGCgPHvtCJ/68JFhjqJK0klBZE5gE
	0WhuoQKMxfRu6F6ZXIgg/5V8ZYvgZbdk=
X-Gm-Gg: ASbGnctbidaRkLNybqmHGhxv0LGqB2zfnh71s4llVdikH5UtDNebnrMKSP5pno4HDJ8
	3envqA5/2Y5aR2vlaDQoxZlEF/XAEyOqS1BdNXGgb9Ak+y5q6WSlN7uoRDtVk6bTK4J00/eg4ZL
	Uc5er305CRHXLszkHccPQVOcf+vVkUIJ/t2sVqHautxn/pzMCuLKvwhrz9KTF6NokXi/VpTXYhk
	Hmqh68GoEge/297he1WA8MRW5+UUC4lU2+U3/wX9g==
X-Google-Smtp-Source: AGHT+IH+F8scuE37tUd3Pg2ae8pcuxAEv4ojDDepRKjbKvYeGMh+F2C6iR06+KNOVOtz/FNk6yomF9YDFaXHlblFUCU=
X-Received: by 2002:a05:651c:1108:10b0:32a:77a3:8781 with SMTP id
 38308e7fff4ca-3305344519fmr27998491fa.30.1752506886586; Mon, 14 Jul 2025
 08:28:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709-core-cstr-fanout-1-v1-0-fd793b3e58a2@gmail.com>
 <20250709-core-cstr-fanout-1-v1-1-fd793b3e58a2@gmail.com> <DBBQE3GJ0CHT.5PEF7RLS6C33@kernel.org>
 <CAJ-ks9=ZHtzeyyFSZaVuA1t-3C8-hc40n6r8qFWxn628qT-OeA@mail.gmail.com> <CANiq72kyQQMutGDkHH=McRQens+V+wkHLpiSfivmnAwwgXE62w@mail.gmail.com>
In-Reply-To: <CANiq72kyQQMutGDkHH=McRQens+V+wkHLpiSfivmnAwwgXE62w@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 14 Jul 2025 11:27:30 -0400
X-Gm-Features: Ac12FXy_EgfuBW5UCKV_g6NQQc-Ao21V9VhJ3CJtjS90O4a7j1zHA01rM8fcK4c
Message-ID: <CAJ-ks9kzrihJ7Jb8kAp0LpbPCfdouDQdFK06AHN3xi9pXNWZ9w@mail.gmail.com>
Subject: Re: [PATCH 01/10] gpu: nova-core: use `core::ffi::CStr` method names
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dave Ertman <david.m.ertman@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>, Breno Leitao <leitao@debian.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, Javier Martinez Canillas <javierm@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 11:18=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Mon, Jul 14, 2025 at 2:35=E2=80=AFPM Tamir Duberstein <tamird@gmail.co=
m> wrote:
> >
> > How should I respin this one? the subject should be drm/panic, I think.
>
> I would mimic what the previous commits did, i.e. drm/panic indeed.
>
> (If I happen to pick it up before a resend, I could fix it on my side)

Yep, that's what I was going to do - but do I resend the whole series,
or somehow just this patch?

