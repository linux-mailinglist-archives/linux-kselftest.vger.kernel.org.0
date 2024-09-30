Return-Path: <linux-kselftest+bounces-18617-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D708098A0BB
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 13:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CEF128823C
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 11:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D359019046E;
	Mon, 30 Sep 2024 11:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ao0Ylds3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD3218E052;
	Mon, 30 Sep 2024 11:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727695789; cv=none; b=MqSw0VHo4x0wsAb7gpcFRrBuuhJYtKmJ3gFkwyA21tO1/Qg4uwf1utn+k+5oHbEnfmQjNqiu42Svc2KwbD14k2e6SOvYJuWWfLYOosFR7J3zRexZ8YcMB4dPjLWm6Ld7sc0Ry+sn3jUEPjPTtoc5EzgkzcX+6Wi+3NpoESFK4jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727695789; c=relaxed/simple;
	bh=utqDL7Y/wVG3C4rpWaZR4J+1IbCUbUTx+5K/AV51mPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HWpqUtnmyLTKSSrs3OekdbIfmkpgZsmk7kcF3e71Cekh+rqBk0wN2kTXaN1LlnR8VQby125VRqt3k164Lp1ITiWTIpM2NR4S0gYQ9OIc/u+OwtmQgFQN30K4ySSB0DO/zrnufh1TdrwWELC7OhSp74JsLdQGrc9yl0iyfC7jjL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ao0Ylds3; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3a0c8c40560so21531365ab.2;
        Mon, 30 Sep 2024 04:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727695787; x=1728300587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2+gzVHI4KzQpTjBommbkEIBS00y97lKKQjvFZ06DgfM=;
        b=Ao0Ylds3qO9aaNYuA2hgYJYDaW7jYVG89wWVVlxVVwCtThBY4eaU8fj8j/B9fZRmsX
         +KHIcxsEouyR+dQYw7rP+NEbK80qptCZJ6qc8Ny7GHUBkoMmSMvYUg/gW4umTDlXvF4B
         Yw1I15+ktUVspl+n4518b1X+qYCcqLuRBuV6DmBpwDpKMuKadtZgDNMqo/1unt+Xjxo2
         d+ZPX4IqA0i/fNJzmcmbEdDnjtJmG5FgQkNTHF/ceYxzrs2PdUd0xqts21yhMnbkj2d2
         LkDkpE1wtgIW+y29h6YNWlKsnt4Ydz9gZ6th/H3gqphFjfVYjoXOeHIkUQp7w+p9zpTX
         7JTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727695787; x=1728300587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2+gzVHI4KzQpTjBommbkEIBS00y97lKKQjvFZ06DgfM=;
        b=c/0T1IIbp86N6hROx5al/C42kG+QpNBzdLBZnIfb4hlMDz4IF0z/1pwVGR1ZWACbS5
         Iwb6IP3+00BOV7OynLbWps7ThONJ/8hX1n/viXqRRzmA/qYSGvl3dbJ7GYBN4nhYMWfX
         nfqeLFji1phO8bnoYoMPJa0MO9y4SOPe4TbF41ZxA0qBF6tUGYMzqSna6ReXTbRZCOGJ
         b0gvwmz/g81gf9k6GrE5OvDV1tatZfW14ONcGsCylPQuK3IF1t+GrDcVRC+nOCUoG7wV
         gkcIPpiMwBfkQRCoXt6rRGyandx9rEbBvIVWcHAJUjHRuzAgt4XA9yryYYJ9xPdOj0IC
         Ud1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWJWNmWHpSqnnhMJrAoAqXe7EVM275atU82N1lEIqLLQrEQNi10tEx/lk9gIAF0lG0oeoLzsntg@vger.kernel.org, AJvYcCXeJVZQoIFGMMDmE+zSXX0vo8pSRXoWTyiEFr8+T/dCbMc7u6NRhqf09CQuibbPFVU7M3bpqE+qx49jID4tJI8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyse1zhAUVqVmUtChZkUOhgjEzKX5cel20AWP6pDPjAdzPihlca
	ihiDhI4pTI4rNArzMdrCXghjQLWJ+6ouAGsbkiUXLL3BOtA4HXlWZQZGciCYb4dukBYN/qYtptr
	xs1JkBs77wInyErJDn0AbTLt8Ecg=
X-Google-Smtp-Source: AGHT+IHcAO/3kWGn5feXdeBmcqoLi25BSyh6H7VesdbXn9XlBqKpEETy3UrZF1+ApZgsryjPo2s2vUWmFWHXLIOaE2U=
X-Received: by 2002:a05:6e02:164b:b0:3a0:9ea3:8d79 with SMTP id
 e9e14a558f8ab-3a3451bbd54mr104446745ab.16.1727695787380; Mon, 30 Sep 2024
 04:29:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930092416.80830-1-kerneljasonxing@gmail.com>
 <20240930092416.80830-2-kerneljasonxing@gmail.com> <66fa7fe46392e_17948d294bb@willemb.c.googlers.com.notmuch>
In-Reply-To: <66fa7fe46392e_17948d294bb@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 30 Sep 2024 19:29:11 +0800
Message-ID: <CAL+tcoC+VEs1UusEKKVhutw+e=uyEqoaBhRTUV1G4HakM3JVYQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] net-timestamp: add strict check when setting
 tx flags
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, shuah@kernel.org, willemb@google.com, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 6:39=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Even though this case is unlikely to happen, we have to avoid such
> > a case occurring at an earlier point: the sk_rmem_alloc could get
> > increased because of inserting more and more skbs into the errqueue
> > when calling __skb_complete_tx_timestamp(). This bad case would stop
> > the socket transmitting soon.
>
> It is up to the application to read from the error queue frequently
> enough and/or increase SO_RCVBUF.

Sure thing. If we test it without setting SOF_TIMESTAMPING_SOFTWARE on
the loopback, it will soon stop. That's the reason why I tried to add
the restriction just in case.

>
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> >  net/core/sock.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/net/core/sock.c b/net/core/sock.c
> > index fe87f9bd8f16..4bddd6f62e4f 100644
> > --- a/net/core/sock.c
> > +++ b/net/core/sock.c
> > @@ -905,6 +905,10 @@ int sock_set_timestamping(struct sock *sk, int opt=
name,
> >       if (val & ~SOF_TIMESTAMPING_MASK)
> >               return -EINVAL;
> >
> > +     if (val & SOF_TIMESTAMPING_TX_RECORD_MASK &&
> > +         !(val & SOF_TIMESTAMPING_SOFTWARE))
> > +             return -EINVAL;
> > +
>
> This breaks hardware timestamping

Yes, and sorry about that. I'll fix this.

>
> >       if (val & SOF_TIMESTAMPING_OPT_ID_TCP &&
> >           !(val & SOF_TIMESTAMPING_OPT_ID))
> >               return -EINVAL;
> > --
> > 2.37.3
> >
>
>

