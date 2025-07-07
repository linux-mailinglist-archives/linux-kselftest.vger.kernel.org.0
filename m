Return-Path: <linux-kselftest+bounces-36686-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2332AFB3DB
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 15:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 409E34A376D
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Jul 2025 13:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE21C29ACDD;
	Mon,  7 Jul 2025 13:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6s1W45f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0A7FBF0;
	Mon,  7 Jul 2025 13:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751893366; cv=none; b=slG0uQubLNAEqN4xCrbYQPpSwO/sE0P9vzy+mZd6CP8e3wFsGzRfovBbrydmLBmDJhhk0dYiAGbgZdiFgv/6WgiNxKKhUxZIsjaI9GnoTEbDGepjJTL0a4MI8wBD1fiJNabt5pak67SVGtgIFEGrlYuC7Ujz9RaLQpQD/iEd8cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751893366; c=relaxed/simple;
	bh=ttL61mw3WsTuOB+52D4aBiD7MkcauxnxYjRPVNV3xMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KcP2S0jVv/IIexGvbZ3/UQFttVRtsFadLV0LGEUSjozI+or0JgyhCBiSyZnCh6hVwhBBGxWTTp50TSWZj4aG3U4qKavgxT6pSIE4vAt9kY+iZppze59jnFJN7JnciVfiMkqzApZpzvBU2myeBLWfWn/g2XmY+maGAJ/uqbSSuvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K6s1W45f; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-312a806f002so600122a91.3;
        Mon, 07 Jul 2025 06:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751893364; x=1752498164; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ttL61mw3WsTuOB+52D4aBiD7MkcauxnxYjRPVNV3xMM=;
        b=K6s1W45fzTEMo8S2KfoTZ+4EUF728wz1ymB+bMHZtdtZ17/tUtwl2L9cHlev/exWqe
         gFPnwOi76rMErdLsDnmfCej5wE2wEwcuNQw62aPmlkWp287BAhS50p6bPq+gm9oLVjXn
         PwWipp2q8QdAh2LTcOTNN0+Sjp77oBxM5nuXt2etzYl77uvBLVWBWhFGoR7JHPVZsjnh
         vNDBHe1nPLfqZkUS0I6b63XHO8HP4oIt9gAraUG0DSkqYQ2zQE5olTCL9+Ue8l2DdxFk
         AU6dJv7APnI7Tq6Le+QrA25JqidItqJl5tTHdyqBKcHA3kRM/eccQvsYijue9G7d3oiS
         1FBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751893364; x=1752498164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ttL61mw3WsTuOB+52D4aBiD7MkcauxnxYjRPVNV3xMM=;
        b=uR7WblMqD7zsfs7BWWJzgtJdh6xTiZeHpkd1KnL/BvFxg7ZapFBCeXnrJS5kGXDhlv
         L2bkOWtheXSDwjrR/W0WGZIBPDkv7s1sYdYllBzH4WMB+iuPdnF2anGZPTBskROh6yen
         XjVipeY/JIfvoPCoCbgySDL3SFL234kmuwU4aJ7DLTv3cc9m6Nv1KRVsgMBG5km3y5Js
         Ad7ASNXzJ/QWunA/gWIVAzleVuDloRshaZC3du/Y4rKvLkrbBlifjUXTZkNQ0x6bq0uq
         d9ZSMI3KaZm2q0gXhEWR70vhlXC4wdwG7aEefh2cmLgJEvkctISzevmCoMyplmShifHi
         GjOw==
X-Forwarded-Encrypted: i=1; AJvYcCVr+OxIBEiiqkX4b0k2ITLJBURI5AuOSuOGIOiS/9TDQ7axCV3nAgtNYlvrN4o6vZVuAnRmz6HcNZ7KOoI=@vger.kernel.org, AJvYcCVuJk6f5xO7rmkBA7s8H1SljpMftNuuEFudvYjw6zuKvFYP8i+c0sxYRNEUVvErvNoOLTnrWbxYIaChFiJ0VuSk@vger.kernel.org, AJvYcCW+g1PBua5/GNB8aIUKCMj89CA2afU3syCP7bZtnZIxVuIR79eWSaYmeZiKaEL7c/4t/n8rRt1uq3c=@vger.kernel.org, AJvYcCXzIZhiYZNjkWbP7xyxDJjVHusickFTW35tmxSulleveqAc7+9bOfIv8n2tEANbzulzBuPNNLutK/1Cv51QUwM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrGmad2wL8SqMPW5fxbDoQed8LkweRCmHE1udlYxi9GDIN9ggg
	ml2KFqbjIORXB1W058raX8spnY+S0thkiXzhNU71Bj0YDxZobHku1QkeJptlXtqONJHoV1unmky
	L+MK9oFmELrbhY/HUWOuBUNT+MLd06kw=
X-Gm-Gg: ASbGncudf5rTpG03qTvQnDEdpXT7DqBZirOmeVFe4+VP/odQ3jxZuMXSSFbcs2O69aA
	jcEZz6iQDSoCPYz/IMvzFw6vNRZ+4F0MiOkreFybrQ0OlYRatNjTz8DB8VSwP0UpWwGrfYZQArr
	d/V5dwYUw48lOSBl4qvRvw96VMBv2eI3hBTuLO1EdDudK5
X-Google-Smtp-Source: AGHT+IGcUdtG7c49dzljrZOU2A0R/aJ3fgIUFsQWVqWZVGDk1Wg8hZ7rWGNL6MsTbu2LKGo5ScJO7pQZtAaRQ+gn0wY=
X-Received: by 2002:a17:90b:588d:b0:312:25dd:1c8b with SMTP id
 98e67ed59e1d1-31aacbe7a10mr7192318a91.2.1751893364216; Mon, 07 Jul 2025
 06:02:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701053557.20859-1-work@onurozkan.dev> <20250701053557.20859-3-work@onurozkan.dev>
 <DB1SKFOR9W3I.1MBT3C6FGBWH7@kernel.org>
In-Reply-To: <DB1SKFOR9W3I.1MBT3C6FGBWH7@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 7 Jul 2025 15:02:31 +0200
X-Gm-Features: Ac12FXyVqiuEWGZohsK5hoFoVgSKg9BuDl65kJZHFLhTe8UZs9aNiJP_eFyQW7s
Message-ID: <CANiq72kqmMTLQaE03WEFzi2UN=Sk31TLDPi3S5UuuA5bHj3O9g@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] rust: switch to `#[expect(...)]` in init and kunit
To: Benno Lossin <lossin@kernel.org>
Cc: =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, airlied@gmail.com, simona@ffwll.ch, 
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org, 
	aliceryhl@google.com, tmgross@umich.edu, rafael@kernel.org, 
	viresh.kumar@linaro.org, gregkh@linuxfoundation.org, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	davidgow@google.com, nm@ti.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 2, 2025 at 8:47=E2=80=AFPM Benno Lossin <lossin@kernel.org> wro=
te:
>
> @Miguel are you going to pick this eventually, or do you think it should
> have a new version with the right splitting?

I guess I could take it since the series can only introduce build
failures at worst.

However, I thought we were going to do the proper split (as
independent patches, too) and then let each maintainer pick each on
their own pace.

Cheers,
Miguel

