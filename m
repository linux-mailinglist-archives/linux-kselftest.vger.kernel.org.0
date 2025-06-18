Return-Path: <linux-kselftest+bounces-35319-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B7BADF564
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 20:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3374C405728
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 17:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DA62EE99E;
	Wed, 18 Jun 2025 17:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vto60moL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2133085A6;
	Wed, 18 Jun 2025 17:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750269529; cv=none; b=pydl5UcEKjxaw7xsEBR0qP6fe5k94XL0ReP63VObUW/OTNcXK0MzaLGB8buwP+aNJ2sHveJ9KMcMEB4uuKFpOgLoropHNOmPTidSzKgyKHq4ao5JiEMEyLB/imIh15il/2zokhfH0sFLrdOMYLHD/PX1yKOpfxwL6WCP6xI37FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750269529; c=relaxed/simple;
	bh=FkPigFeNGfIgRpgDFtGW/mxVfhQYOSm7TXujD5qRUiQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e63KoK8kRZ1ZCBz4xLEhK0QpsORa6N1/waTx7Gnofv3aBMYhzba9oHE0+JStpcT5EsbY43+9FgjoeTnljSy9AUjotuW1eQXUz9svqMbIRymNzuqr3ftrQ9ECkM63t9GevA0xhVzHwM7+ud1Mn1D1T7BFFTpmmJQuvjVDe8ZM4v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vto60moL; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-313dc7be67aso961995a91.0;
        Wed, 18 Jun 2025 10:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750269527; x=1750874327; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FkPigFeNGfIgRpgDFtGW/mxVfhQYOSm7TXujD5qRUiQ=;
        b=Vto60moLlnn/zs6BMbeqILB9ZNBikcpH5c+AaRXyAZfhOfLLgpkYNHr1eCTfHmdb4W
         1qWewAlkKBVmXMB83eZa1avjnSkM9ed12I4EW8A3qasLZ7XfcKxiPWvhcjhahMKtrgUC
         WaLWXWbFPKpCB0b8dmm+wZ84sd6KyL9p9OFWU+zA9dzSkCa3OmhFPGj4EM+kFHnr42uN
         lbuA2UwmPuI/H9FIGmbRoYI2h0hw+rKsNOpwVLmiC/Ap7Skwig7svOU31Trx3/Gd51rC
         BhLzho8dJioqMemtMyNPGu3fuloknLiyadAOhrTZltNtt7uI6pt7OsMzDIvZE4nCas5c
         9YpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750269527; x=1750874327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FkPigFeNGfIgRpgDFtGW/mxVfhQYOSm7TXujD5qRUiQ=;
        b=oVTAP4qSI0PDy33kfakHUo+NlEvYvCQ8wvm+i5BrDYeqvxEIgwIVeBtrU5Xgcru55E
         reJhX21lG7PTkjv7f8siFGyn4yNwQNnN5MQPdPBO4SQoFo3W3L510Khu4/mZyXTS7cCL
         RldWs9L2obd+B75XDKsRKOli1DJc1R8i+6g4DQIyHxGKZEghPEHmY6qCYvDeomEjeXTg
         OQDRBLJFhWoRkL4qX5EfL2VMbGfDAJ4WkbDWuPWDwxP3pOej3gi2jfKr/TCE/Bs8dylS
         XpesMe0aF37811lqYzjlZGBYSmLVIgKJDua8cF4+wKK9AMtzlvdgO19Xj2GtZUW+LyQU
         pspg==
X-Forwarded-Encrypted: i=1; AJvYcCUS76uIXmHwAnBQid60bKclvnzhAQqlegk9aNIfL1iBDIVb3pbO66HXjICt+IZMwOm3yLlPxayxlww=@vger.kernel.org, AJvYcCVD3/mHQb5H8cx83aJwa3S7QBtFntLHd4JG3+Bps6xZlzb+cDQt8SRAzxuPGmDDVymcoUYudQAVG7ihttBG@vger.kernel.org, AJvYcCVNb2IZwYHMCLUUhXlCUx6l5ApZ4TVEDz+B3lT4+edBucbC9WMXd8PfJVi3ZNHuwRHwDVjriDqDAN6e@vger.kernel.org, AJvYcCVV3TUkHMFEKNvlyuDbX08QwS3Jr6UrRDqnVo1yS7gEUe/nqOK9bv7sbYCBhXBPYuMKEVOuAuEJJt49y4tF@vger.kernel.org, AJvYcCVWHqjLxO5jYihPJ8e2ceNVtMrIimQLpNxeFh+gb13aqS7qh9vQLmGcPxgYUWUTor4qLv5Kwo1c@vger.kernel.org, AJvYcCW17TbONPYAVDUWCDsGpzHT7Rxanii1AQA5YGAA0uAHHdOmlNMZt98a/4+HnpAfiXbB+LUcXcc3u1ma2ulKxT/+@vger.kernel.org, AJvYcCW6XIxDnclduBDt3FQwf3d6P3DqNB5RMy9b2CR9mmk7dRsfiSnrVfZNXxV4KP22o7dEddu7qJnN4gnu@vger.kernel.org, AJvYcCWVOvGcVpCg4OXjVpqLGzhf4MF27YJvhHJibLfHSHLiXe4LnsdJPzCNty0fNh1CJOKGB/btsioGXkVI7pg=@vger.kernel.org, AJvYcCWxy+eqU0cLX9IAveOWm+SCfCHssEOVZntwPHj3rRlB5gcc3cXh+FLsLwWoPHKMQtIjbTk9IOEaVEGT4NyRg8o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4i29aunI4mGEujP4+v5WnMBnEkM7Y8h6pSL6FX+WLBqAQ6f2G
	xx668rvJ6Ge1AenwFslne5pkdFhuDOW1m3rykzgKJm4F6AcKIZWC6QU4B2i99GpMPiPN5BlesRU
	EgMTb9CpyqwYUyKEculKi4aTZWj44YNM=
X-Gm-Gg: ASbGncuutzGXcqzRmRG1wea7rztNz2eGmXaFbzpVGD29Vyx755z0T7PLnYXgGZb9xRk
	bxbLsW1P2UP37pbT2QP6goPGBWVSNxnhE99hw+9Yp1juDuP+I+RxvujX0T8M8Zzb6OGd0+jSd2I
	cSh5aYZcPZDAkFk+elSq4fjDCtO4ZO3lJJ77rXINlmSGY=
X-Google-Smtp-Source: AGHT+IHQA2vB+4lILhLPisOadhxH9fnkiGb8fP5PoJh3YCmrD5jDUJpuN04m9Eq8KLRXTUak2OObg3c6xBn/ciPLwLY=
X-Received: by 2002:a17:90b:2889:b0:312:db8:dbd3 with SMTP id
 98e67ed59e1d1-3158bfeae60mr147244a91.6.1750269527292; Wed, 18 Jun 2025
 10:58:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250615-ptr-as-ptr-v12-0-f43b024581e8@gmail.com>
 <20250615-ptr-as-ptr-v12-4-f43b024581e8@gmail.com> <de30bc80-3dc9-4fac-afe8-bf6b0df42ea9@kernel.org>
 <CANiq72mOHbxt3xOJw8f=j184TRYs9y3wvcopH-h6P2SLe4jVNQ@mail.gmail.com> <CAJ-ks9nnNjBfzCasOtFZGXBj=UKqZxuyh3-Emj3yFrz=9f8tmg@mail.gmail.com>
In-Reply-To: <CAJ-ks9nnNjBfzCasOtFZGXBj=UKqZxuyh3-Emj3yFrz=9f8tmg@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 18 Jun 2025 19:58:35 +0200
X-Gm-Features: Ac12FXyGUkldbEIksi1ogTddUr_YiD6acvLXBSTJ1-Ey0i-LXdAiD6xde1bhgwA
Message-ID: <CANiq72=9VyakSh_bXJjPPeXJP80OtB7iqKBM-p3bEMX3TYF5WQ@mail.gmail.com>
Subject: Re: [PATCH v12 4/6] rust: enable `clippy::as_underscore` lint
To: Tamir Duberstein <tamird@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
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

On Wed, Jun 18, 2025 at 7:56=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> Miguel, would you mind taking care of this on apply? Quite a big
> series to send again.

Yeah, of course.

Cheers,
Miguel

