Return-Path: <linux-kselftest+bounces-35315-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4E3ADF515
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 19:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA5674A4A01
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 17:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8BB2FC01D;
	Wed, 18 Jun 2025 17:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSt4EJ+g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853012F94B6;
	Wed, 18 Jun 2025 17:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750269022; cv=none; b=le3vWLn4ZVkQKE3eWRRPcGHrxpRnMYEca2bzItPevFYtrIKKfDG3p46Kls2ewMuRibS9KegvJuzhoFxh92m4E7pFWLFH2wlf0cPw026EWOczNyyEqhBz1T+okJjUTkVrf4NMm2pOLR2JJ2fcYlG/609/r8fiQ38Rf1HwQX6Dmyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750269022; c=relaxed/simple;
	bh=y8FicD/fgNk5GmRRD6awNlCWX8z/26EGV8z9+xgODLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tPt+8KigEDKUkf80cRiFD8BzOdWCAKnZDinP6mShDlNxn2WV+3Xhw5F5PijlKaBQ7uULtSGe1RzBNDgooacNGfAcd6b8HtMJOrMZ4S1GUeKRCMUJuEHzG866/40WopB2eaXA3QIjHrzTr1lG5qqnRzgCEvSdZPzpXRNpCHNuBqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DSt4EJ+g; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-313fab41fd5so917741a91.1;
        Wed, 18 Jun 2025 10:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750269020; x=1750873820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y8FicD/fgNk5GmRRD6awNlCWX8z/26EGV8z9+xgODLg=;
        b=DSt4EJ+ghAFb7Ukmvgu46fR/K1p9iqamavCDng+S+o9Ayxf87YFgDxGwhwe+LYVwq9
         eig8p4p3amLvSy7UxAiX+IoRL6wspl6LVtxW+9cur5FaAkQ7lwdRpYdLV9n9n81kJnL5
         ABsN+PSD/CxSv7uAMg2rGkPzD4YQ3ETnuxuGqRHFj8jhirwBc68SyhMtp8piPBufXsdc
         KaPJ6acPJGEqTxHIGO7L6PI9LF0lvM6J/qgNy311z2qcZ7yBFqlwTWIjQziCpjlZQhgu
         Z9apeBp+mNhr9foAm+M7AGJI5iYXiSVZz8K4iyoUWifLkYGBanmOo+XeNke7JcHg6R1j
         Yv2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750269020; x=1750873820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y8FicD/fgNk5GmRRD6awNlCWX8z/26EGV8z9+xgODLg=;
        b=TWCi+YLH4Ph6DaKcLAr5dJua+2i4QTygviHPvSw/ohe992LTUTwEZLqDA9jW7tmGrF
         E6b6KLoUhLRcgqoEtRtqX7fW8d24SToQmR/iFHAuAbTfEI/d+HVrlafaWC/2rcoU5Cgl
         0qvG0Lwc2/3PZ8oEVveKcUWyh1Cese0oLpbWUIoHjUR8L/FW0zJ2ZvArtmUGsihSDWEu
         OQj6mfYT1n8JLrMdDB0ITK79Js7gc43ds1d9CuN/qUtje687T5QHZ1k6qTNhzwcUlAZV
         ocH1nZx08+jyIIqmsDQuOKypRe2ou2jhmQrVZjAvENkkekstCNUuzBOVpDaSMpQZ2o+L
         DfuA==
X-Forwarded-Encrypted: i=1; AJvYcCU21LKYdxyaNz5bcG40Jm5kq5iYw5H3OvyF97WJ9rLu703Z/mhFzmACetPQ/gj/BuCluDGFm+bNAhIz@vger.kernel.org, AJvYcCUztbtG+xWWais9hPrbPT0ltjyWxf6YDkjb+FV1de2VpPwQnZ/RMk/6hQqG9WW4SOE+iEVSxMZ0NxgEaBXY@vger.kernel.org, AJvYcCV+vblZI4L/VaVnAzG0KEoVBES/xFUfB/2osGxaCzNK2vQ0REwRPU1LpC18jETAHQraqfcjmd6FjufKLu1StD+9@vger.kernel.org, AJvYcCV7FzuDOV6c98Dn9i4icp8l7rJ5+i8OvdNlJutmwRRJF36qfyi4Le4o15YP1gpZpTXt/6zaFAgwF55W@vger.kernel.org, AJvYcCVSw9VBUGoPoEAqG+3nLJghctFR8zuvz2LjmoYBujS67XGOuSN03VYlnyFinTPiPJGm2u1/GfbYJgNRnTygsv8=@vger.kernel.org, AJvYcCVaHFMPRDTLC1T70WhwK3THcOtFTiS48fkoodwVB2L3C+y5OEmSfbCXIROu1tm7GByTcqTvytwGW68=@vger.kernel.org, AJvYcCVgI7rriAnYtlQlIa4ikiP1eeggmxXxDkogbu+Vvg54aapRPnoSaagHbJCkoMQFUt/do+233MWa@vger.kernel.org, AJvYcCVn1znNjbCRsQhd2+yr1S28yJp7f5kMOVhQSV//cxchWu5vMxVleATp8AQQ4TtNBGTG+0nVD3w7xN2GW+4=@vger.kernel.org, AJvYcCXmTzttFOQArO4v6Yt9c6pay8j8qbnpYO5qIcVfY3/cWgxx6ipJpDUl1Ei2i3B7nKkAD8PzQjsNNLAL621A@vger.kernel.org
X-Gm-Message-State: AOJu0YyP5/jafTSAFxlcgmf7LgBLar1XnBFqSXnxUeME063h5MWUprEJ
	A5v7X1TWol3fGTJzC+WTE/ugtapklj5TQoL+33cTvjpM/7WdqMW2hf7Ze0B565exDFRGtduVxgZ
	+dIZXngKBN3sDb12Fcyq7plVzSXCnNE0=
X-Gm-Gg: ASbGncv9vI2G2WXAfUUVPpTaqbIhf50d6s6UIfickplywlQ06uwpU0435cJEOyni6bg
	h0h/g1paaN/GhyjKGm+w/TTQIkcA7ci1oWy7Jcf2aXddMMlTKDjzaq1cl1jbn+GFw9I1njXdjdE
	9k99QWFwZQazQ6mkg9ifoijsQNirOb5O+pC1DHv3fqPKU=
X-Google-Smtp-Source: AGHT+IGwBEuoz7ZkZcRjBpUqCxdbqSbY0pSB/07XdCAmHEONw2uE7rmOXu2mtjhcBLdh+UgbAYF1+iUixf8L1GxnymM=
X-Received: by 2002:a17:90b:3d82:b0:311:c5d9:2c8b with SMTP id
 98e67ed59e1d1-3158bfee2acmr131081a91.5.1750269019586; Wed, 18 Jun 2025
 10:50:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250615-ptr-as-ptr-v12-0-f43b024581e8@gmail.com>
 <20250615-ptr-as-ptr-v12-4-f43b024581e8@gmail.com> <de30bc80-3dc9-4fac-afe8-bf6b0df42ea9@kernel.org>
In-Reply-To: <de30bc80-3dc9-4fac-afe8-bf6b0df42ea9@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 18 Jun 2025 19:50:06 +0200
X-Gm-Features: Ac12FXzgdlmcKkLec41X9ZU6lwhGyCLefBHdsMy9eFFNw8WZHynLVcdkmU58X90
Message-ID: <CANiq72mOHbxt3xOJw8f=j184TRYs9y3wvcopH-h6P2SLe4jVNQ@mail.gmail.com>
Subject: Re: [PATCH v12 4/6] rust: enable `clippy::as_underscore` lint
To: Danilo Krummrich <dakr@kernel.org>
Cc: Tamir Duberstein <tamird@gmail.com>, Masahiro Yamada <masahiroy@kernel.org>, 
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

On Wed, Jun 18, 2025 at 7:38=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> Shouldn't this be `c_long`?

Yeah, agreed, it is clearer -- I mentioned that for similar ones in a
previous version.

Cheers,
Miguel

