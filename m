Return-Path: <linux-kselftest+bounces-34006-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CADD1AC809E
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 May 2025 18:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94B2A4E6767
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 May 2025 16:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E639E1D61AA;
	Thu, 29 May 2025 16:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZXGAhOo5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEEE4315C;
	Thu, 29 May 2025 16:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748534422; cv=none; b=ITqyvLiKi3V4TcbrF0M5cDizcUQF1B+AiWJvDrJt0E5cD+pIyRnW4EoBfcsxrkinCvGBWgOtQ+8UqMVQUK96UHLEkKQ9Mrd+EwB4PFNxgHP3ZyY9Afnxv7wmQGvR09A+O/unXz0v4qBZEorr2+VwcaOcZIHHq6r/OQuuADu9QNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748534422; c=relaxed/simple;
	bh=DrVCUnq3QujVdp+ZI4IYRZ0uWpZ0M71qAGKmOEhl1BE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MWV1oGd4uKSPP2okP3J5sOXEEpLZS5b2AGspOZgv4zZQTeAfq61148bKwj2PL28KxNf/VN8C6JS+8tS7iF7tNw8eI9l15i5vEuE7p8uwVuzgf1IYy15+aAnHsftA3qGCGrVsBtXJCbK4xEvV/bCDma+7CfjcsmbHpelkZdGquCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZXGAhOo5; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-30eccc61f96so164924a91.2;
        Thu, 29 May 2025 09:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748534421; x=1749139221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DrVCUnq3QujVdp+ZI4IYRZ0uWpZ0M71qAGKmOEhl1BE=;
        b=ZXGAhOo5G18+/yR6lTYG1vYazv93Re4h4tdJ4bk6JAY+rlJfUNJI4JhNYgNmwsvXnW
         rBda5c88JAkCBv/XtrbWdDensOm18TeIjKiVMXTWdUO6IgxjWxhn8MC5n6EVEQwfPrcl
         j+ZACraO9hEZX3F7MiSr1hVSSM338WoZZi7HHug8SqdkDuqwTGyKrf+OK5pDnWNbxISl
         n1wiWmBZPcDPy6nD6tW5KC2dLrq47I7EQMXVvb1dCKwIYec3beHstaUBlpPSJzt2MPP5
         VPKV72xtckXlPanDs+pSG7/wVMYAeGJHrQdiDoA0cQT2BOYobTueqTR/ZLMjPUN8aScF
         cGEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748534421; x=1749139221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DrVCUnq3QujVdp+ZI4IYRZ0uWpZ0M71qAGKmOEhl1BE=;
        b=MZMgoHsxXWw5ei5QpZVEmH2bP83Uut74nkPntHv5i62yArUJnHqCDh0FruNnhhtt4m
         6cbCy296FaJcnGwIDgHsqoXFm7HWK54ZTuL2VRR+OAQ9SNGWrcDBVIigY0cjRZl5taa4
         nxC21/afCYrflUKuhKtu/aKDh1aXVr3N3seUp8O/LebEDsV1eyG7cRQfYqWoNHapOt7t
         9VWyfeW9OA7CSkh8sQVd1lAMu5SbtotNxqh7IfVg7Q1+y/Iw3aFTY6Wj3STm8HkgsP53
         LT7S6b/WO1HMGpNQEb9KpJOoYFKnCB5zGHoOtN83LXrWSAke0UhPjSRxhODXAAEhyQm7
         bsAw==
X-Forwarded-Encrypted: i=1; AJvYcCV0ho/btJUnWLdQGX+rTQ76qdeEOai3qC0p0mnt/UfSkGEaK0p0IFtiRLS1ctXl3sFaawLSdpGoFBAcwYfoehNY@vger.kernel.org, AJvYcCVR5rmArBTmb0FyPXwUOL/LENZAqYM0zUzfjsd66+U31VcswatwZ6r3mVO0GLrp6OrwCGqBUGKVI75SleyHZfc=@vger.kernel.org, AJvYcCWE+8l8aSgEeSkDPJdTlNl3i524B/mDgEiyPnuIffwB11XJ1vgmGq+64lvIhwpzjuqthvfFDhLZPW8atJo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz28L8paVCcQ03214QDRR2p3EzI8B+uKUC/UDFo3K1kcLFcJvXa
	tR9ggg02oktI6nkl6V99eJXbE+OLeUgrg54AnixMgPIAReiWe/4963vxdgC0F6O2qjidN6zv33i
	94Cb8WXOFGRsMmdwwv9c5G1PNd/mVSL4=
X-Gm-Gg: ASbGncvDr6ygDf3JfAjJT9IZogWCZrMW3AZRH8c97PzhuMRegnaCWgvrr4tUEy5xvQn
	2XhifC+6ZyeTNkPoGRxPqau0Mgc3JEjNT1JQ1wW12KFwc2vZnC7GGE87KlEgAq1VFeNxMA5BUkw
	TkpX4ZoTEaEQ6qn7G7yrtwbAiq2IwXrRwF
X-Google-Smtp-Source: AGHT+IEwQIOIj0gYCdOkRajsEjDegRu/ZzvA/N2iiPs88drjPSztKbY8RaFJEwJpGzSL8UenTgTtGscbJYPT//mwLbw=
X-Received: by 2002:a17:90b:1d8a:b0:311:488:f506 with SMTP id
 98e67ed59e1d1-3124187d033mr70095a91.6.1748534420471; Thu, 29 May 2025
 09:00:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250529-idiomatic-match-slice-v2-0-4925ca2f1550@gmail.com>
 <20250529-idiomatic-match-slice-v2-2-4925ca2f1550@gmail.com>
 <CANiq72nigDV2R_9PNOv98nGBxDZ=46WcRM7V05nQWni5VQRw6w@mail.gmail.com> <CAJ-ks9=L6zYyr=jsGBbMvL+rwtnPN0MsgZg-Uvz1WeMDyeZXEA@mail.gmail.com>
In-Reply-To: <CAJ-ks9=L6zYyr=jsGBbMvL+rwtnPN0MsgZg-Uvz1WeMDyeZXEA@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 29 May 2025 18:00:07 +0200
X-Gm-Features: AX0GCFscMFjVC3EaZKesYNFElArtKpwiRQiisuK1bsFFQDXbiPNyY3bmr2rWe3w
Message-ID: <CANiq72=HNC6yk7gZphGSPH4LiHkBo8Zjc+aca41YYYrt_xqpLw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] rust: emit path candidates in panic message
To: Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 29, 2025 at 4:38=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> Sure, that would be:
>
> Include all information in the panic message rather than emit fragments
> to stderr to avoid possible interleaving with other output.
>
> Let me know if I should send another spin for this, or if this is ok
> to do on apply.

Thanks! No worries, I can do that on apply.

Cheers,
Miguel

