Return-Path: <linux-kselftest+bounces-42500-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE99BA4EAF
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 20:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD95F1BC1DE8
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 18:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2567430CD81;
	Fri, 26 Sep 2025 18:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ir8tCqGS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D95518DF8D
	for <linux-kselftest@vger.kernel.org>; Fri, 26 Sep 2025 18:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758912377; cv=none; b=s0C9JfVpIm5/ZREYnD4kI8beHJ+DQriS4lV/BSJlj0vL69jJRsXyR/GX27Kh+dqa2Vdw4MUzPkvbS1CMb0YwPeFqXuzV+mCx5S5tQHTxTEqIVT/1EgQc8UdABWhnf6YNO9fggVfzsPMea2qiYEGDsL+bPvpD1bfk6cZ0okmwWeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758912377; c=relaxed/simple;
	bh=99NoFsVWszwLzL0dGnY2jV/Q+uR4we2DXyveOu+4Occ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eZNfO+Ah41iWuUqWnDBNBtld5r5i6JKKhOZCr+b202yXgLTcAAPa9ADgy97sOfxerSKr/ChD3ES/tjjrPEuBQQWIoGioUjjC8yW6kbCY820Qf+iIo9T4tveBDog+x5/zq8zBEfj8maW3rmJtGYJf1WKaQisbXr1ma863wR4hie4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ir8tCqGS; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b57d676c604so240572a12.0
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Sep 2025 11:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758912375; x=1759517175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=99NoFsVWszwLzL0dGnY2jV/Q+uR4we2DXyveOu+4Occ=;
        b=Ir8tCqGSjY7fG2+bMbC96eCICN3DWieYr8p8kZM26oAb8TrwhFr29tYMG/ONxQzbhI
         puWXlM8u0Q/ag9hzXKOcnG1H1gYk+GWzOmRqMqf7QZRDOhSEBjPgwtjTGkIuxzGNe76m
         senx55Q/JSlzOXZdLQGNP3dWBDTDFPDc9TqBj2LwayJlJSz85XEg6iYkKtAOn6cEcejK
         gZdDrDv4o0ljXNe4ocrYkDiz0lHnPxTft6uGPnUXIJA0bMU3+UDSpSEkJrLr5/ipVEZ2
         k8xjcViUkWhGBy4OvfS093phtP+nnKdokgXmth9qax+zdJJNV6oYPZaGVtL6zKq5gg5o
         Y6NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758912375; x=1759517175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=99NoFsVWszwLzL0dGnY2jV/Q+uR4we2DXyveOu+4Occ=;
        b=EOByxtEP+1Ymm4RHeFM4jfMqY9Na7e7/2Pb2Bj9bT0ixbnGG7o2206alWbgfl6Hg40
         qOj1FQyweL9N3liJNg2xqEBYZvshwmH30sYBZDRRAmNPrwlnKatYf0pYplyC8d1sd70s
         IvOPj1pEq2XTZMXJXAW3529EfmQS4Wkp1DYr0wj5DMJ5oCvBUo4l4zA+5CaATvhcDxq0
         zJWMBRhaLTUF8GXpC/KqyX/oHImQJ1p9njg1UodwWLHZf8VFsjahCGG9o3oj3dcPH0LH
         p+pg8jvGLEd11Acn+CaFWDDhfxKSJM+6Gn3HO9KbHdoRa5lwrv5GaWxmEIQsQ8Svjx+V
         MVbw==
X-Forwarded-Encrypted: i=1; AJvYcCU6lxFCTZRSWMQc/SLDfR0/vL8fgti4KL0AdfbaLMEAtyh3g2VLtB5tWaX/VGTAKFW/cd7B6LBCipiVj1Oif9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGUrwyUQqs0iF+5cBFU2H0FYeoa6O1rmo9vOn5pd5NNelFkD4S
	vsiY06L1FIK1rvGqhA3qSbgg2Jo/IrwqCLePE3g9Bic+za0e/ueqgiHRNDYLTHj0BwhibCZwrgp
	bDr63GUOXHbyAHSAjS1bae2IAolrLfeY=
X-Gm-Gg: ASbGnctGp1Pqe24N/OOPa+qlfjgPlUuZRs0wCRO1yCjJKozFoxpSI/gTj5BtxnrEo3t
	nel0Iz9igySKv+y40Py9SqSrYx0WJ52DeDHUaT0zz3zIVCX8ZmYX9VJoF+4KxJWFXTExmuyyJYw
	vdFWYivnMN6agslonteEGaOKJyb6sWLrERreq7BVXnEEBD16Oi22vdqWn30mSgP6vzVGDhWZxtN
	wOPCZyC/v1IIJmWzUovoiVDwlAe4sMapd/YFv40gey5j02AUCd68WV/J/I15a5F3FOhZT0VdCqU
	Qx+9LPolzTRIEdXjmlyrp7BzRQ==
X-Google-Smtp-Source: AGHT+IGICCMscDDR09yJt5H0iPKTO2HVhFlo2/cy7JDDWeiBMU3GNUjCo5LwRgqW0USPT3MDqhixj3g/rTT4Pi3J0GM=
X-Received: by 2002:a17:902:d508:b0:269:96d2:9c96 with SMTP id
 d9443c01a7336-27ed5b0a538mr51481475ad.0.1758912374667; Fri, 26 Sep 2025
 11:46:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925-core-cstr-cstrings-v2-0-78e0aaace1cd@gmail.com> <111409f1-33cd-4cd1-b3fd-e38402a82c9f@sirena.org.uk>
In-Reply-To: <111409f1-33cd-4cd1-b3fd-e38402a82c9f@sirena.org.uk>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 26 Sep 2025 20:46:02 +0200
X-Gm-Features: AS18NWDpMwmpfdQtAlAM5mfbOpZzjcwdG8Vuf5peZ5dotzDbBFdbC1UDMcnVE7M
Message-ID: <CANiq72kNr32NKHGn=gfH52C5VLr9S0Xk0HNzroPqYhx4GngkXA@mail.gmail.com>
Subject: Re: [PATCH v2 00/19] rust: replace `kernel::c_str!` with C-Strings
To: Mark Brown <broonie@debian.org>
Cc: Tamir Duberstein <tamird@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Breno Leitao <leitao@debian.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, 
	Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Alexandre Courbot <acourbot@nvidia.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Liam Girdwood <lgirdwood@gmail.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, nouveau@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, netdev@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 4:01=E2=80=AFPM Mark Brown <broonie@debian.org> wro=
te:
>
> Given that we're almost at the merge window isn't it likely that these
> will get applied once the current rust tree is in mainline?

Yeah, I am submitting the PR to Linus very soon anyway.

Cheers,
Miguel

