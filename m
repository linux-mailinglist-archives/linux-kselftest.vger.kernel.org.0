Return-Path: <linux-kselftest+bounces-18643-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D9698A34F
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 14:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1206281E24
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 12:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91FA18E74D;
	Mon, 30 Sep 2024 12:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PrAiO2Hs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5AA18990E;
	Mon, 30 Sep 2024 12:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727700186; cv=none; b=tr+B2R/pUXsqb/ytJvWd+poBTtoSu90fc4ezbSAHB+xBOdxy3eb0WhKUhekgjQ8k8LEsi0VMWLUz7lL6VCRwCQXbiaGokM5QBlIl0jgIN+75jqWm5q8tmoDbfmLMCUoEtr+R3HpMb4ECo6InsENyj2BzrcT/eLU7mzVqCRa7flo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727700186; c=relaxed/simple;
	bh=gEzfPaK0TpvnVynQ506A9D0uyk+SyDbxtCqzyu9DbDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HFA+GcwA6a9fGK/eyRTsG7waT4qq7g6oWdVFvK/1EM6kv1DauztgbJwiXGJ4s6Iwu6oS56Sv1oDq7mec3sZKh+POR93RtVLRbX6z5Si+GpXMTBehldmEmtvR2U/7tU9Vn7mCtMCMSp9uzESLq7dI5zSt8RzL/8vu9MaWt0VbeLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PrAiO2Hs; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a34ccc6a9aso5835055ab.1;
        Mon, 30 Sep 2024 05:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727700184; x=1728304984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=38/U6EdWtSaSJAwey3tZ/dl54aPcoLZSVUhkiWNOg6M=;
        b=PrAiO2HsNfQyFOn4di3hkZqUjIWT4bgdv9ePvtyqpwmiyVasySe/y9NGn7rZ83nfUL
         APIqv/h1/tmhrLfqD4m6RhfJuZyZ+ngH4ub++LQSDVguMD2iRpo6cTAyL/YC3AjA+HLR
         ePt7jkpcKQNRy91TjyEOq/7fZYvuhHWo9Jw/OXGnbOUAQ0k3LWIKYg0oJA8A2HNfJV5K
         p2VMuZ559AciKthM3vp1XhkR3i2fslgzetp9UZl0H+Kiiiq/HBaah/jr3LVEe5ZuWnrx
         tcXsZkqcYR1kAa+TH8l9Q/7eXK9iyWsbwqf+fxa1H3vB8oeitGceItI+XC4IC3ZJ67hu
         0fEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727700184; x=1728304984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=38/U6EdWtSaSJAwey3tZ/dl54aPcoLZSVUhkiWNOg6M=;
        b=HFlIn8hhxjaxtWkk9fyFHZBuXa2spO71+xEHKDeJCRulGq1cXhbIDt1u6BjRtqJq2e
         3n0qIN/itH+KqSqKqTqcETby3cpDK3rPNgsaHzxz3S3EIqGUypRh8pzL9uutKdcNgqRE
         LP/CMo9f00xbWtve8EHofK+IlnzMhppP8Jha94BeLvioszXVoyPLU3HnApeJqT2Bx0dL
         Fs85x1dR1HVri2e0Z6YYY0GDtgo5ppmeEqDZeVJB+lY2LjMgUtJsK42suyY1YdsUlUpT
         QW5Z4703hdbwtRgXdw6huR/+4y+wHRMb0V2kBuFXUXgtEzZQw1pqDwOg2Ad9t4e8te9R
         wzMA==
X-Forwarded-Encrypted: i=1; AJvYcCV5GT9dyI2BpszhwTHsKdDFuwMtiLHT/ag86mAJiuBnLP7ftf3IibE9YTUiebAHdx/wLe9mUtwtzXTS7VJ1kxQ=@vger.kernel.org, AJvYcCVTawuz1NCVi+iiLR5fK6dJDlj9LIJ/S2fZI3JpchXBfeewDQRsWdyM2BmPad2/vbsRUQIx9q1x@vger.kernel.org
X-Gm-Message-State: AOJu0YwgvzOEM0MqN+3bi72Td6Uq8vFsCKCqNbev/atztLSxUNUgH8FE
	mb+J97N9xVUae9SO6DyXLhIVASt1i+lbZjhHlY/84HjzemzenMHdRNnlE/+/9BWQfXeaDrZ2Knc
	o4zzEAZUTbRqLRouO/cIqal9DZac=
X-Google-Smtp-Source: AGHT+IF0nZM6lTJMpefZD4qIC7brprKUBxnG0KYje/r7g2JEFhUbqi9ibaTSFcqgKSSenlYPLf1qosLveRUqUohqWtY=
X-Received: by 2002:a05:6e02:1a6e:b0:3a0:8c5f:90d8 with SMTP id
 e9e14a558f8ab-3a34515ad44mr90780505ab.6.1727700184285; Mon, 30 Sep 2024
 05:43:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930092416.80830-1-kerneljasonxing@gmail.com>
 <20240930092416.80830-2-kerneljasonxing@gmail.com> <66fa7fe46392e_17948d294bb@willemb.c.googlers.com.notmuch>
 <CAL+tcoC+VEs1UusEKKVhutw+e=uyEqoaBhRTUV1G4HakM3JVYQ@mail.gmail.com> <66fa904185c3_17cd892948a@willemb.c.googlers.com.notmuch>
In-Reply-To: <66fa904185c3_17cd892948a@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 30 Sep 2024 20:42:27 +0800
Message-ID: <CAL+tcoBMXtQ_TbjKmO5CazL5zu1dDBBB+enckkM9+0ojF3qutQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] net-timestamp: add strict check when setting
 tx flags
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, shuah@kernel.org, willemb@google.com, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 7:49=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > On Mon, Sep 30, 2024 at 6:39=E2=80=AFPM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > Jason Xing wrote:
> > > > From: Jason Xing <kernelxing@tencent.com>
> > > >
> > > > Even though this case is unlikely to happen, we have to avoid such
> > > > a case occurring at an earlier point: the sk_rmem_alloc could get
> > > > increased because of inserting more and more skbs into the errqueue
> > > > when calling __skb_complete_tx_timestamp(). This bad case would sto=
p
> > > > the socket transmitting soon.
> > >
> > > It is up to the application to read from the error queue frequently
> > > enough and/or increase SO_RCVBUF.
> >
> > Sure thing. If we test it without setting SOF_TIMESTAMPING_SOFTWARE on
> > the loopback, it will soon stop. That's the reason why I tried to add
> > the restriction just in case.
>
> I don't follow at all.
>
> That bit does not affect the core issue: that the application is not
> clearing its error queue quickly enough.
>
> > >
> > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > ---
> > > >  net/core/sock.c | 4 ++++
> > > >  1 file changed, 4 insertions(+)
> > > >
> > > > diff --git a/net/core/sock.c b/net/core/sock.c
> > > > index fe87f9bd8f16..4bddd6f62e4f 100644
> > > > --- a/net/core/sock.c
> > > > +++ b/net/core/sock.c
> > > > @@ -905,6 +905,10 @@ int sock_set_timestamping(struct sock *sk, int=
 optname,
> > > >       if (val & ~SOF_TIMESTAMPING_MASK)
> > > >               return -EINVAL;
> > > >
> > > > +     if (val & SOF_TIMESTAMPING_TX_RECORD_MASK &&
> > > > +         !(val & SOF_TIMESTAMPING_SOFTWARE))
> > > > +             return -EINVAL;
> > > > +
> > >
> > > This breaks hardware timestamping
> >
> > Yes, and sorry about that. I'll fix this.
>
> As is I don't understand the purpose of this patch. Please do not
> just resubmit with a change, but explain the problem and suggested
> solution first.
>

I will drop this patch because I just tested with my program in the
local machine and found there is one mistake I made about calculating
the diff between those two . Sorry for the noise.

Well, I only need to send a V2 patch of patch [3/3] in the next few days.

BTW, please allow me to ask one question unrelated to this patch
again. I do wonder: if we batch the recv skbs from the errqueue when
calling tcp_recvmsg() -> inet_recv_error(), it could break users,
right?

Thanks,
Jason

