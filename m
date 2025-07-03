Return-Path: <linux-kselftest+bounces-36485-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D579AAF82BA
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 23:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84884487667
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 21:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7289D2BEC52;
	Thu,  3 Jul 2025 21:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FcnmSzi8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01B42BE62C;
	Thu,  3 Jul 2025 21:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751578722; cv=none; b=jFlC3DTZAtI3Mvw+f/z/whhJRKb4BApwjxsXd2s/rVvTrnwIgGSxVwpUEpVna2JWyF7XTVfGfbYT10lqG4gLVBtcnAIYGqJCshZermbYzAx9+A5Pa5hkjcVIZk1wUY16qxEh/H9P6vF6eYwsa4q8LCEJzaaiVX6Xse6SHkWewfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751578722; c=relaxed/simple;
	bh=pHNodlGoraqosvL2in94YD46DI6OCuusa8x3ST+BCu8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YSzbT4SNIeEZmSlAiDs+sAid1kdstNJBP5y3r/uUGKTQ/HmYCYlb1RLCRs6j9htceKpzPJyqmsVF9vQHoN9N6P628sJ7rNiA7gx9QWv8nRUW1DnUCBPBAfpgRNzE/wkdrss4PwocRQ80W6KeYZBQZf6Tmhzic1zEvFGc4xqv4jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FcnmSzi8; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-234d3103237so807595ad.0;
        Thu, 03 Jul 2025 14:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751578720; x=1752183520; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pHNodlGoraqosvL2in94YD46DI6OCuusa8x3ST+BCu8=;
        b=FcnmSzi84dDk2lm76LMKwizrQ+eGwTY5zrUJVXvtbii13HCQK8i0XfjYz+B/vTl+/M
         nQsIFk3c4MydDh2VdMx8Kz703OxLsGIuKQuz0gktpESi3PdNzCszrAzbQdhzWcNOpDBt
         nuyIjcgaqmfOeWt9zwfrResJA+FrYwd+TapyhI55t2Rz17GSdEBm3Glomv8PESEh96H2
         4tKxnpHWRVp8iZ4EOLZrGks8bXorirRW1LY4cWqu5o+Jx6Y9SzxLrGJts6+LEct+Qbcp
         irV0O8dM8vl4yFUJo81cwDWL15/3RhaN7OI7hiGDZipWZPxpPyaQr4+yKPb1Nzm5GY2k
         WcOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751578720; x=1752183520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pHNodlGoraqosvL2in94YD46DI6OCuusa8x3ST+BCu8=;
        b=XgInk6G7S1X1jmy1ozBVcBXMF1bjI2qeQKP+BV6P1CBWdhEjxlj4w6cNJI/OMVBLVg
         6TiZTesn/lU9iNIuLBI0UxbcfeJLRQo+/PZa6p+XcE555qI95/6RdHcRbMlTEKloJtVB
         hTn6XpH9J0OP8Hr5BtRP8pXJTyq/X27cyVGOfR57fFVOiOtBB+Gh3A3Fwcm3Fy4ADaVo
         iKj88cUByWIDHf/OtsUfCGZO7md3YVR3T9HZrDnBW5tpyrSCloCpmLeoebqru1s/LUaT
         q7tFp1v2vemQ2wlU+eWAxVwFUaYCZyeGWhcC0f/+TYGl3wWKcMGcesX9/0iTShJlylMe
         qWCg==
X-Forwarded-Encrypted: i=1; AJvYcCU2QHXolY4XjJ7t89g3iqcFma7TpMicYnyS4Jh+7uybDCFQYib2bL4RQDre6CyYREq5BRnNVlVi2zLb@vger.kernel.org, AJvYcCUQNaTbuixnYMb0k4j5NyET9IEtP40MHavZgJy8zBytIreyHMsRsea2F2eSmRHEx0WZ2W7ddef7iWar@vger.kernel.org, AJvYcCUZvuyOSEB+clTw2H49kKw6DGwJTFj5ONXo59Oij3bD3SjAF6taF/BOkxf31EDgL8EBkjR2nqb3VvfqMgNvPbY=@vger.kernel.org, AJvYcCUcK9Cu9kCOfGT6qOI15mSlRxaE0BI6wcSDhmvgIK7I4hF/Y8qRZ0LFD4XKOdStQuOil9VfdC2UpYQkPZkQ+HV9@vger.kernel.org, AJvYcCVhJ7SiVoGYbbO+bEocPC2WF0S0B+X5m21EU6XY12C+Kqb9V7GGZLgHGOJ5fXfJemXAij37AlITDKA=@vger.kernel.org, AJvYcCVlWgkosT3wMsrUGZ1qgNRbL1UEgusCSkMvSqnlRb2h5KjXtgBjz1wyYi2pmLJlWF55Fl6XQZgsGJk7dTU=@vger.kernel.org, AJvYcCWcQLtTdK1qlw+wDAqpAiSnpnC9YKhob4/lsX6iBJUKgJo/gmUDC5uYacECW34Uat3n1YbZgztuDdvt@vger.kernel.org, AJvYcCXlqkd/tNPaLHePeKwXdE+4UAtcqxjbSAUS5GIGGwvllYLlJytGLzn40EcKKKHRb573x4+y1Fjv@vger.kernel.org, AJvYcCXstNJwUgubTKXrqnjvPxxFIotS6uWl6E/dz/nrd9sbcIo3BUdaGAAwJzY4vH4s1C6f5X/KYlCxEdsiJlB7@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0faTRB1KTYiMpCoYWg6uYiCRCAb0+I5Cd+7UkDRY+a3aeEkfA
	/pfJ38h3n/w1korh6K5xWmxXknsrAsKEjDp8qArp2M+yNzZfKgVzntSymAhEtxXa/CaB/f8pD9D
	6q1YAqYNX0CAUaaFv9Ev2aID0HOdZm6I=
X-Gm-Gg: ASbGncshFcuPe2Oz+0tR+mm8DnVt0lMWnPAzLI1dRawceSV/nJhaxZjylwZb6Q60R1w
	6YiFDfkZ5Ov1yq0+vk4rXi+uhxgmcp0lzz5734NUsM15RvOmwcWiJcqJRuz4JhuVG0RTvVcnUL8
	Edyu3G1Uf9Bz9ceN5NJgM4c1ooNDIb1zMW3rC/KkkiNRg=
X-Google-Smtp-Source: AGHT+IELtB5XgtVh1TIl503YSOBpKDzFFV0lUuu4UGNcygnKkLkVRq6ABgmlhe/GC2s+Ns1XtRhxYcb0/TcFag3V8H0=
X-Received: by 2002:a17:902:c404:b0:234:f4a3:f73e with SMTP id
 d9443c01a7336-23c85ec795bmr1697845ad.9.1751578720047; Thu, 03 Jul 2025
 14:38:40 -0700 (PDT)
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
 <34c00dfa-8302-45ee-8d80-58b97a08e52e@lunn.ch>
In-Reply-To: <34c00dfa-8302-45ee-8d80-58b97a08e52e@lunn.ch>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 3 Jul 2025 23:38:27 +0200
X-Gm-Features: Ac12FXwdXJJ0hQiiGaabkdHfelYANMQVK7rSTVhFAhKXDapeaUgG2_fvXL2LwP0
Message-ID: <CANiq72ksOG10vc36UDdBytsM-LT7PdgjcZ9B0dkqSETH6a0ezA@mail.gmail.com>
Subject: Re: [PATCH v13 2/5] rust: support formatting of foreign types
To: Andrew Lunn <andrew@lunn.ch>
Cc: Tamir Duberstein <tamird@gmail.com>, Benno Lossin <lossin@kernel.org>, 
	Michal Rostecki <vadorovsky@protonmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
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
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
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

On Thu, Jul 3, 2025 at 11:28=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> A small patch tends to be more obviously correct than a big patch. The
> commit message is more focused and helpful because it refers to a
> small chunk of code. Because the commit message is more focused, it
> can answer questions reviewers might ask, before they ask them. If i

Yeah, also better for smaller reverts, as well as typically easier to
backport if needed, etc.

Cheers,
Miguel

