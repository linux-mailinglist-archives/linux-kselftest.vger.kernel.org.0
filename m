Return-Path: <linux-kselftest+bounces-37729-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA944B0B8FE
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jul 2025 00:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0A151693DE
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Jul 2025 22:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6562A20010A;
	Sun, 20 Jul 2025 22:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTeB5tYw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3214822EF5;
	Sun, 20 Jul 2025 22:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753052279; cv=none; b=JungB7eZd9kIxfOUlVfJvNhsw3MxEWBzNxUl9RETMmeoqXELGHwqi7vByrMuvdRYqACRtDIOcXy7y503kxj+kUdUnL9GwQORpv/yyK9SosDC3ApRZLvN6EsJHlwD+2QkYvdlP9o8AcVnA0wba4wd4ujnla2xdL3ZOWWoJD3nTX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753052279; c=relaxed/simple;
	bh=AxCsF687F4/wb17w0tv82rQYZUNQc7XCzjNWql30M8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nZi9cfFNucAL0xE7MzS0LYkTZCxY9w/Er26ViXElD6ZSBZvQemYQdCPKJ29Tw4aIOMunCXG9q3KL5qydFU+/ruLn4e9WCGPlhb/2ZxPSLllv2C7uJ6CFuTLSvPwGHJ5JW2BbPTNok46jf7YFE5vxBou7Bd2gkXLa+h7ymaUPQjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fTeB5tYw; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-313067339e9so802210a91.2;
        Sun, 20 Jul 2025 15:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753052273; x=1753657073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t5BuQBQwB7PCzJ5lET6TzcKy7Q0WWKkcHISL12ahYwo=;
        b=fTeB5tYwub1d1fFAcmoPNrbzEKvYw67tr9mivrKr787m+vUmCrtWNaBE70atys/4Ph
         t3Ypd9AQdXsrPwi2gb6IXm4CBkHrdTabo6RQywg7qQc57I+zTkLScGhNPwbMa3fRcyIJ
         DtbPaLppTrTgii1qaCofSOVBXUORBNNLjUK0V/cxfhHn1goivYWqrXrTkWMuSklD61Wo
         WxuPPr091oTiHKUMbFDtnZNLIguNch3wny4IX62ls8NTkoFwXxFniYE7yTP5P8T3C1aw
         tAYtkEC9NmGkgVuJ22oXwjXDGOQlX+pdt+e3XVmkiWIzdJLxT7vYqEDozteu2xWtKUXi
         czzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753052273; x=1753657073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t5BuQBQwB7PCzJ5lET6TzcKy7Q0WWKkcHISL12ahYwo=;
        b=lkWdwkT5NeBECFOnwO3bsgLakBQCjIwpCW1bnOcXP5YFUslSl9wt1ovpvgBBDWAE7C
         OuW3jnsQOS6tC3hPt6BingRpU2xNRVn5DaV/A3FcsEkyVEstDfaTNGq391AP2ff5LYX7
         Gmd34nC88CuAUmbzRrAi6bILnNMLyyavCNm2pvgg+AFK/GGVn81+rTcLWXmtSBz5m1zf
         JoAP2DX3YTVraTe0dODQ7jLTT6H/U5S6D0b8QACdvp+7teVRuGpJEMfEXHvkHHiQetEN
         CBlXLoYW+ZG/8y5tf0/YWViMYHLLcm/0CzDGT5fPqDZ7T3RUbPEQDhw9xRy1sAJq08dH
         PzCw==
X-Forwarded-Encrypted: i=1; AJvYcCUH2UDXc2mu2165m36a634ArE3c1IdFidnVR6Zy8G7Y0pCZ+8a4Hv3zEd4p4tDh+78biS1UFRxvaiX+CulRPes=@vger.kernel.org, AJvYcCUvNTlwPWPosvaTI6bBktng9cdITqKj5N8vrDr/2WxNsO3vk3OAAQXILNofDyqWwT49BVRxUzgUhk3yfgw=@vger.kernel.org, AJvYcCVU2xgV6ToYrf2nbgTb/Tkm5KrNXnH4gxQU0AeTINP73ZmRueumDF/w+7SxL4os1gnw//8ZIGVhiV4EUg2kXwty@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ7kT2iH+/6p730cfpHMwaauuunbOBULvN5+Rn805K+l/VHV57
	nNf8fC/nB798ddVuEQtqC5kqRjx8YlL/lWmf45TUeAOqL5uxEH24hlS6+s5yvnkBhvjNy3WbEis
	/1KqO8SiowmU34vGrvX2OWs2nkamBm20=
X-Gm-Gg: ASbGncuyQDEIpYt7Cl/Ty9rR07m1lsxp/HQ4BZorIeUZLqLWp5n/0CQpxuPsGY0Bpr1
	k7SV+6eurzXEASaGDjfrzey7BxI+iSueZopsHhaddomMgN/J79wnd/U3nawasEjl9E57ciEyrjS
	BPrY8Pdmki8LYst4m087rghtNsZU5zHyUtXvIqk1riEECmuW4ddGssgHTjNYxGNZpiFmFDQaNGJ
	NO3VKw4
X-Google-Smtp-Source: AGHT+IE6N7dpLqKVEgwJNf/OttFeWYui6bjweLrlbRsnxbkRSN7809rT//TdGdXx6su850QOxFujgnZ4fl2YZmdHNxo=
X-Received: by 2002:a17:902:ce81:b0:234:8e54:2d5f with SMTP id
 d9443c01a7336-23e24f64828mr99062925ad.13.1753052273286; Sun, 20 Jul 2025
 15:57:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250529-idiomatic-match-slice-v2-0-4925ca2f1550@gmail.com>
In-Reply-To: <20250529-idiomatic-match-slice-v2-0-4925ca2f1550@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 21 Jul 2025 00:57:40 +0200
X-Gm-Features: Ac12FXyAje6eSbY5jmbstl8V6BZE3skUiGSrmuEfLZE0wqVUJkaLLb7Xj4TfcRM
Message-ID: <CANiq72miukk7Oz-+83FKL1_Gie0=4Uunf24scgFeTPnLmBAdJg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] rust: minor idiomatic fixes to doctest generator
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

On Thu, May 29, 2025 at 3:15=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> Please see individual commit messages.
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Applied to `rust-next` -- thanks everyone!

    [ Reworded title. - Miguel ]

    [ Kept newlines using `writeln!`. Used new message from Tamir. Reworded
      title. - Miguel ]

Cheers,
Miguel

