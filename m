Return-Path: <linux-kselftest+bounces-38411-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFCBB1CBFF
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 20:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 767214E37D7
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Aug 2025 18:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6167B29C33C;
	Wed,  6 Aug 2025 18:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rdurdvBJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10E31FF1B5
	for <linux-kselftest@vger.kernel.org>; Wed,  6 Aug 2025 18:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754505344; cv=none; b=QccWIVPWgmiKglbwmzxa1BIGBHL7EdR6f6+MVpq/4dcGvdVFlE/OZYlNtRhHEeFNhKbRGy5IZw33xVAcpNak9LqllHtTyN0nmwS0qp+shhg96UgSZVMY6tkhfsW4em5M1qkiPyQ0CNSKiudEqSLTwwp09s0oGPZbAAm20vFfAQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754505344; c=relaxed/simple;
	bh=TgrtNHfEKGWMcivC2vYOauoxX+koVK4dQWOwxLY3/AU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DvXhl23NLHZtOlIwTsQ2VJyhKvVSsAgQ3r/XWweGTrbqhiGTwGLIgzZIsO1CAQKYzwW5OCn57kTNfWrRW0EKTBIderqx7ICUJzPUVBeFl+/qxdSg7PkhhGe3y0UYLvhwPYC7avNCMgZfYTWauRozn+Nw/bVkumIey0AkNVbUFAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rdurdvBJ; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4b0848b5191so2141411cf.0
        for <linux-kselftest@vger.kernel.org>; Wed, 06 Aug 2025 11:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754505339; x=1755110139; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PLVfa7g9qj0LATfRre2vi5YmjjptK2nX35WVxF2JaUc=;
        b=rdurdvBJrNZ1aiLIokcUX9afav76fttZnMCBUj0LUYNu6u/JLevvfrVKIY/vQnjOuN
         nCvsMmtwIl47cK/04VWFdJbKFApzNz3O6CHmjGoyxn7WTDPyPxVq16aWqM3igyGT0HU8
         VDbcWNXWqJQbwSVHSwsFnlkDhD2PLmxfzcXZMfclyk6wkJT/JjAbD8KJBAUfT+7KLut3
         fZTNAfQlOyA3f9I5qcgYV2ERWR+CHndsaEk2TzldhR0nzEAlutowMIrEAf0naJBtzX9h
         msrBqcPUnvbLTW4ETnYS4HnpSMgVNKK0kfHdrWihwZ3Nr1sulHd36ip/RcYyIrIJcb8g
         z5jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754505339; x=1755110139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PLVfa7g9qj0LATfRre2vi5YmjjptK2nX35WVxF2JaUc=;
        b=ty21HUHjT24z9fJdMckCdfxAP5Kp5iWAQjxXdhvdrj4hGlgtbPbhe4ojiCE2/REf25
         A5h1Vpnw3qgQpWevpdj6XVm1kqFPQgAjnF+CltqNc0TIN5eUacbiVbCR/48KPyGtvl5n
         PHkUOZoLYrPRkw0/qE37Yv8Mn3aDS8lDGFGoT4IDB7DQfWC25FWS5WKotUWTKXuwH92n
         oaLA3xMRfZuHtxHKOzlwD26GdD3V65ENPu4smwjDbiqRHu/ERaGMTedNAwNl4I6S/1Iw
         rSJiVD8lWHnz4MJgrmuW+ruiLS3rBdbBpJVe+9fNcPnzt8MFINCPN12iPhJQ9q74JlU7
         yBMw==
X-Forwarded-Encrypted: i=1; AJvYcCVZJxtW9pY5iHTJruBC8XOgpPnytRn4BoMLTC9c3+yQ2h6DaBnPp7/dnl3qmVeIJUGPSOwGfoYgFeTje+zYgmY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvnsg+4egu/WCO2LGphnmn3Kt56pX5DAoa0HZXmonrqYzxzydG
	IFtKdJBKfqg0c4ReZVp2XuwQWl4YDwCySrFIkAuCmQaICty0TvuUqXUH+muV3klLARolEA7Eoof
	zVqZO/DxD6f6OlYW7yCyTXGQWTVu3hPUlaVnC9PPI
X-Gm-Gg: ASbGnctFbS2aFJSpwsxNeW7QGNRo1vor+iLBVMNEW7D41T3P47+D+bHLOGy59OtgdUg
	VcTfpxsEWQkr1Unni4B6vVR6NqIZ9UkDQaQ5Y2humBCgF1b0M9nQWYlk1K1hPmkaKER+ItzU58k
	JSKS4l9+oUwUBgOnRbmJ234v2SojDbKnIPzbuM7blYhODOnpo4hC/lB8Dfpr4MrXJUZ639R+iTW
	cWstNzNKsw0eNt0Yxs=
X-Google-Smtp-Source: AGHT+IHG/34/fTyIPQKhgcLoz15W/sNxgHYlRwI6JCsBvkZ3p61Hn2tzr3UNF8Rq6YtI+vlJXPKClu4DHzWKlFqJzeQ=
X-Received: by 2002:a05:622a:1f0c:b0:4af:890f:ff8f with SMTP id
 d75a77b69052e-4b0912c42a5mr55715411cf.6.1754505339222; Wed, 06 Aug 2025
 11:35:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806180510.3656677-1-kuba@kernel.org>
In-Reply-To: <20250806180510.3656677-1-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 6 Aug 2025 11:35:28 -0700
X-Gm-Features: Ac12FXxwAXt8ppz1WbG4syp66E9ompnViGt1pcP_8fwDRQaf3WP7T-rL0g2vo7I
Message-ID: <CANn89iKvW8jSrktWVd6g4m8qycp32-M=gFxwZRJ3LZi1h2Q80Q@mail.gmail.com>
Subject: Re: [PATCH net 1/2] tls: handle data disappearing from under the TLS ULP
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, borisp@nvidia.com, 
	john.fastabend@gmail.com, shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	sd@queasysnail.net, will@willsroot.io, savy@syst3mfailure.io
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 6, 2025 at 11:05=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> TLS expects that it owns the receive queue of the TCP socket.
> This cannot be guaranteed in case the reader of the TCP socket
> entered before the TLS ULP was installed, or uses some non-standard
> read API (eg. zerocopy ones). Make sure that the TCP sequence
> numbers match between ->data_ready and ->recvmsg, otherwise
> don't trust the work that ->data_ready has done.
>
> Signed-off-by: William Liu <will@willsroot.io>
> Signed-off-by: Savino Dicanosa <savy@syst3mfailure.io>

I presume you meant Reported-by tags ?

> Link: https://lore.kernel.org/tFjq_kf7sWIG3A7CrCg_egb8CVsT_gsmHAK0_wxDPJX=
fIzxFAMxqmLwp3MlU5EHiet0AwwJldaaFdgyHpeIUCS-3m3llsmRzp9xIOBR4lAI=3D@syst3mf=
ailure.io
> Fixes: 84c61fe1a75b ("tls: rx: do not use the standard strparser")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  include/net/tls.h  |  1 +
>  net/tls/tls.h      |  2 +-
>  net/tls/tls_strp.c | 17 ++++++++++++++---
>  net/tls/tls_sw.c   |  3 ++-
>  4 files changed, 18 insertions(+), 5 deletions(-)
>
> diff --git a/include/net/tls.h b/include/net/tls.h
> index 857340338b69..37344a39e4c9 100644
> --- a/include/net/tls.h
> +++ b/include/net/tls.h
> @@ -117,6 +117,7 @@ struct tls_strparser {
>         bool msg_ready;
>
>         struct strp_msg stm;
> +       u32 copied_seq;

Can a 2^32 wrap occur eventually ?

