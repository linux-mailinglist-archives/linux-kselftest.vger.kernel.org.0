Return-Path: <linux-kselftest+bounces-31523-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A96A9A4F3
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 09:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC7E03AA047
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 07:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4621F75A9;
	Thu, 24 Apr 2025 07:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="bYoQbH1l"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out.smtpout.orange.fr (out-72.smtpout.orange.fr [193.252.22.72])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0385E1F4188;
	Thu, 24 Apr 2025 07:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745481229; cv=none; b=qzfLx15Lnmasy3k/7JmfpoLNnEoli6dT/9HgsWPrhd99VJn1Zu09fkAm6L3YwV74XoDrf9kALy8jKDxo/o2SmPlseQvejAeWAEFBl9BUkjMBSBfA9MKLTgMVgmqDMZc+4GPs2LRB50iEZ2/0dNrb5dCJZBV82sM8tptoWt9SKSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745481229; c=relaxed/simple;
	bh=3xWxJedTmecmXbJvqY9BfQusNhg8/ufg2pc+yGepvCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s66bm01bWk8gyESoGZdSse0IwMOPEPvknrWJiLN2f0fOLqfu3DILvmJBiEuZCi790Yxp80Xor3jnF2ie4wytp7Wv4046/VA2Bvv/7Hw8zbMpKUpu5BqCRnz1w85i8+aNzUitG6ckq0ieQceNnlBbV5I6rqr3lpmdCmLAyrueP60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=bYoQbH1l; arc=none smtp.client-ip=193.252.22.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from mail-ej1-f42.google.com ([209.85.218.42])
	by smtp.orange.fr with ESMTPSA
	id 7rG9up98WOaHY7rGCuhwO0; Thu, 24 Apr 2025 09:44:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1745480680;
	bh=ZGyUrHEN80lsUNEPYdnlrD7iPYpeUH4sQ5suvUCtFks=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=bYoQbH1lsJKO8JaosIB/QJFyDdralpaL8TALHPD67wNOaIb03ljiYgWWSLhAwilaf
	 S1Si5pZtBbOTdcKy4vqps+1Ac1uKH4JovPXsNETHw8h0B3y9VqCa7nsrxXM/+KLDVM
	 G4nS413RHZCLBDwegRNPxx4fX8dJ3pZu1NQYIvnIb+895fnNnbEln5dle8ufcuGSXS
	 S6gM3zebAWIM4h0PrpYignG6up03NeLBwYXdy9VOLDT15cxQBH6mfTMCzv23ydw9EH
	 0BRvCfH29+gVO803k9nIX3xcKXNxG6IloS/FTGVV/2p7J1Tf7A3gbYqWyIOGHrSA80
	 5k2valhi0bDjg==
X-ME-Helo: mail-ej1-f42.google.com
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Thu, 24 Apr 2025 09:44:40 +0200
X-ME-IP: 209.85.218.42
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac25520a289so113479066b.3;
        Thu, 24 Apr 2025 00:44:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUJkQHuUhVnQyEDdjkLgluXe+D7saNLB0iDYyGlmvgDodNnO0oiChpEuDRgKI1TVaGwR0cdJdeT@vger.kernel.org, AJvYcCVe+fd2ksRw2jRJYMqRPBLk7CU+mWXoVXQPE3d+2sRgBhaQF8rwFSJwPEuOYLBhBhf6B6qOmIzjuo4=@vger.kernel.org, AJvYcCW4GHJdlNH66FNZrAZU621smg7+gU1xYngsCcghzfNBR7q9cBlzTNWnmLu3n+MHJVAvdttCOwTzRNoI7jnWULmK@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz7p209Qi5XtoKj6lW/jUNuBUchOhXouz13cwMXDuUMqqKCf59
	qvOilpM8pijQW9aWjiypMLIhOyaxbZ6N16EWPgkbJtUMmU8dgMq3YJaNkXjQBZ0ZHQIeZE8oOKB
	vJC5sidIYDEMuVpIt/SicIv3ZoGA=
X-Google-Smtp-Source: AGHT+IFtRW8AnCxj7ZZK96VH/HRW8rO4PqPmk6v0jzecLO3+wyPYoU7HhLMDl8EA85G9T+iwoNWRRiSYcavReo6MpOY=
X-Received: by 2002:a17:907:6d20:b0:acb:4e0c:23ed with SMTP id
 a640c23a62f3a-ace5731a270mr146829066b.14.1745480677387; Thu, 24 Apr 2025
 00:44:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1745323279.git.fmaurer@redhat.com> <710557cef8fb8472628862d9b65edcf7aeb32bb5.1745323279.git.fmaurer@redhat.com>
In-Reply-To: <710557cef8fb8472628862d9b65edcf7aeb32bb5.1745323279.git.fmaurer@redhat.com>
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Date: Thu, 24 Apr 2025 16:44:26 +0900
X-Gmail-Original-Message-ID: <CAMZ6RqKcp=JNcbZjX6xSGo9Hyw=1nXbpS9Nc36xuDkbGG+=wtA@mail.gmail.com>
X-Gm-Features: ATxdqUEQeMsUFmU2qWO3ZYD-o6q2DSQEzgq_DnwA1JNVZbTdO6MT72QyyX0ZLSc
Message-ID: <CAMZ6RqKcp=JNcbZjX6xSGo9Hyw=1nXbpS9Nc36xuDkbGG+=wtA@mail.gmail.com>
Subject: Re: [PATCH 4/4] selftests: can: Document test_raw_filter test cases
To: Felix Maurer <fmaurer@redhat.com>
Cc: socketcan@hartkopp.net, mkl@pengutronix.de, shuah@kernel.org, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, dcaratti@redhat.com, fstornio@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Tue. 22 Apr. 2025 at 21:03, Felix Maurer <fmaurer@redhat.com> wrote:
> The expected results did not explain very well what was really tested. Make
> the expectations more clear by writing out the flags that should be set in
> the received frames and add a short explanation for each test case. Also,
> document the overall test design.
>
> Signed-off-by: Felix Maurer <fmaurer@redhat.com>
> ---
>  .../selftests/net/can/test_raw_filter.c       | 65 ++++++++++++++-----
>  1 file changed, 49 insertions(+), 16 deletions(-)
>
> diff --git a/tools/testing/selftests/net/can/test_raw_filter.c b/tools/testing/selftests/net/can/test_raw_filter.c
> index 7fe11e020a1c..8d43053824d2 100644
> --- a/tools/testing/selftests/net/can/test_raw_filter.c
> +++ b/tools/testing/selftests/net/can/test_raw_filter.c
> @@ -101,94 +101,113 @@ FIXTURE_VARIANT(can_filters) {
>         int exp_num_rx;
>         int exp_rxbits;
>  };
> +#define T_EFF (CAN_EFF_FLAG >> 28)
> +#define T_RTR (CAN_RTR_FLAG >> 28)

I do not like this

  >> 28

shift. I understand that it is part of the original design, but for
me, this is just obfuscation.

Why just not using CAN_EFF_FLAG and CAN_RTR_FLAG as-is for the
expected values? What benefit does this shift add?

> +/* Receive all frames when filtering for the ID in standard frame format */
>  FIXTURE_VARIANT_ADD(can_filters, base) {
>         .testcase = 1,
>         .id = ID,
>         .mask = CAN_SFF_MASK,
>         .exp_num_rx = 4,
> -       .exp_rxbits = 4369,
> +       .exp_rxbits = (1 | 1 << (T_EFF) | 1 << (T_RTR) | 1 << (T_EFF | T_RTR)),
                        ^                                                      ^
Nitpick: those outermost parentheses are not needed.

This took me time to process. Isn't your expression redundant? What about

  .exp_rxbits = 1 | 1 << (T_EFF | T_RTR),

?

This gives me the same result:

  https://godbolt.org/z/cr3q5vjMr

>  };
> +/* Ignore EFF flag in filter ID if not covered by filter mask */
>  FIXTURE_VARIANT_ADD(can_filters, base_eff) {
>         .testcase = 2,
>         .id = ID | CAN_EFF_FLAG,
>         .mask = CAN_SFF_MASK,
>         .exp_num_rx = 4,
> -       .exp_rxbits = 4369,
> +       .exp_rxbits = (1 | 1 << (T_EFF) | 1 << (T_RTR) | 1 << (T_EFF | T_RTR)),
                         ^
What is the meaning of this 1?

>  };

(...)

Yours sincerely,
Vincent Mailhol

