Return-Path: <linux-kselftest+bounces-18679-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0471798ABC4
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 20:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 285031C21825
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 18:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302A214A627;
	Mon, 30 Sep 2024 18:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TMvIGyMc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAFCCA62;
	Mon, 30 Sep 2024 18:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727720146; cv=none; b=ZeDJJIBDtkNWAQZtoUeShpGPGZ/iQ/0BGqo38tl85utYpZv8pX3juQsQEoq2e+5zgVA1DXFl/YcZw8194NonM5jMNxpzf/ptOLVjadobhQTd/etoV93cv3Py4NruQKKLTJP7CZajgbNAkLPwxhQ1AdxwFLUVUcmy6kizQGwAvdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727720146; c=relaxed/simple;
	bh=sQCJdYvkkKvAxZHOQLFayOqS8eo8Wu4VT6Qx5YvuF5M=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=UXkfX1mnbwIwj6hXoe2JP1jAiycP34h3vVKni3J/dxsvNIHK39Q+B9eAXmtVY0SSqaNEno4f5XK0f/Hkt3n5oNpBTCr1MfZkW1GlcsjkEnIcuq0AMyxtUGIrr4cs9hzdWuI8F+KecAAySEQMHwCosxlL+09E8OVJxfJz4UuSbLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TMvIGyMc; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-27c90f1e968so2559184fac.2;
        Mon, 30 Sep 2024 11:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727720143; x=1728324943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nFvG+aKaWW6dA88h7DRmvjry4mr8SpSc6m60BDv5vFs=;
        b=TMvIGyMc4/75aEIjn8a185a0leYV35Fc/OpCxLrIZcMvVyX4Ddy+mIf23/3HrCdQNZ
         4mQ1v0HcUs/ETEph29ZgfpP24zWn1Vv0cBr8b+9ZArUJYUasxE5PxnuFcnS6nLiP9ATO
         vh08BVSGsCA1fZX9UkIP0TZjaxb75obw74HuG9Fm9P8RE22O50HxlZpZEB9I3UzFVki4
         JGNua9E+O8ikNz0FFiTc2ByycHCzkX8VQSnDwnI42qOjnPmcUWYMygOajCrgoKJiS0vR
         QGBEwbeb85iPjO/IcSQKBOeveeipx/s++hVhJnZLGWi+UfpHkaZ3PxWLBXj1cUb1MDRZ
         FzyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727720143; x=1728324943;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nFvG+aKaWW6dA88h7DRmvjry4mr8SpSc6m60BDv5vFs=;
        b=UEdNoQGMbrkC8rE+6UJWiqIBHUImlv37KLmx4vsdzXNtpT6qPrjW90u2uJerNUQi5s
         eaR7oiK8LCGo4DlgPcx2kym0bgzcEckT2HhXFTi5vbmUgQIn/SJ4eiBYCEbUCTgAtBik
         lrh7yjUt7v1RrRdSv64BxzQXHmNzwsp08ayvyNp4mHQ0DA9PgmUuJZVHLNK1cbWUJ3U7
         G2IpKoJeGKFWAClfqfnifTzmZ0URo8hIqWw+SzugVBH1synAdcJb8fYW6G+qSS+ekyeb
         37t3GlgbIs3e6zdDPLE9rTIRtNFQymD1qyx70xE9vC2c1xPW03c+PicHxt1Xl5o7Z3Gc
         Tt0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUmenhe63oeNcGFoj/wQXLZwP/bqO+wHRPTKJkwFavavq4xrJp0vg0yzzHiBUrRVb7n2g0ivnOf@vger.kernel.org, AJvYcCW6yyZeGa0HMFLvqQP/k0J/Z0QQV0QTxmwDI+AoV18uJp1rR3ji1UYNoe7Rn2zLqqBuO3nZBreggvCVEcMxjDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNfCQXhfUpwH+aQ8fVcsnbdB1s3mc38jCzoMWCfjeBopr2TZza
	vgo3/M+LMfI6ROidryJqCPDsM+aWzDojDYsmyLChPrhC5vdxRqXh
X-Google-Smtp-Source: AGHT+IFKXUDBUQxZ40OwGVi06FZAmEO9CEOgoW+t4m0RBu1F8SqIRKTcokPfOMoecqEwlnovI9zdpw==
X-Received: by 2002:a05:6870:c4d:b0:27b:8902:5ac9 with SMTP id 586e51a60fabf-28710c1ed9fmr9432409fac.40.1727720143412;
        Mon, 30 Sep 2024 11:15:43 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae377d786asm432444385a.53.2024.09.30.11.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 11:15:42 -0700 (PDT)
Date: Mon, 30 Sep 2024 14:15:42 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 shuah@kernel.org, 
 willemb@google.com, 
 linux-kselftest@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>
Message-ID: <66faeace749e3_18b995294db@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAL+tcoBm6YmDr_=WaaWDspE_LN2N6-WdT76Yp6U6fn9pDx-aCQ@mail.gmail.com>
References: <20240930092416.80830-1-kerneljasonxing@gmail.com>
 <20240930092416.80830-2-kerneljasonxing@gmail.com>
 <66fa7fe46392e_17948d294bb@willemb.c.googlers.com.notmuch>
 <CAL+tcoC+VEs1UusEKKVhutw+e=uyEqoaBhRTUV1G4HakM3JVYQ@mail.gmail.com>
 <66fa904185c3_17cd892948a@willemb.c.googlers.com.notmuch>
 <CAL+tcoBMXtQ_TbjKmO5CazL5zu1dDBBB+enckkM9+0ojF3qutQ@mail.gmail.com>
 <66fadc698746d_187400294a5@willemb.c.googlers.com.notmuch>
 <CAL+tcoBm6YmDr_=WaaWDspE_LN2N6-WdT76Yp6U6fn9pDx-aCQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] net-timestamp: add strict check when setting
 tx flags
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jason Xing wrote:
> On Tue, Oct 1, 2024 at 1:14=E2=80=AFAM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Jason Xing wrote:
> > > On Mon, Sep 30, 2024 at 7:49=E2=80=AFPM Willem de Bruijn
> > > <willemdebruijn.kernel@gmail.com> wrote:
> > > >
> > > > Jason Xing wrote:
> > > > > On Mon, Sep 30, 2024 at 6:39=E2=80=AFPM Willem de Bruijn
> > > > > <willemdebruijn.kernel@gmail.com> wrote:
> > > > > >
> > > > > > Jason Xing wrote:
> > > > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > > > >
> > > > > > > Even though this case is unlikely to happen, we have to avo=
id such
> > > > > > > a case occurring at an earlier point: the sk_rmem_alloc cou=
ld get
> > > > > > > increased because of inserting more and more skbs into the =
errqueue
> > > > > > > when calling __skb_complete_tx_timestamp(). This bad case w=
ould stop
> > > > > > > the socket transmitting soon.
> > > > > >
> > > > > > It is up to the application to read from the error queue freq=
uently
> > > > > > enough and/or increase SO_RCVBUF.
> > > > >
> > > > > Sure thing. If we test it without setting SOF_TIMESTAMPING_SOFT=
WARE on
> > > > > the loopback, it will soon stop. That's the reason why I tried =
to add
> > > > > the restriction just in case.
> > > >
> > > > I don't follow at all.
> > > >
> > > > That bit does not affect the core issue: that the application is =
not
> > > > clearing its error queue quickly enough.
> > > >
> > > > > >
> > > > > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > > > > ---
> > > > > > >  net/core/sock.c | 4 ++++
> > > > > > >  1 file changed, 4 insertions(+)
> > > > > > >
> > > > > > > diff --git a/net/core/sock.c b/net/core/sock.c
> > > > > > > index fe87f9bd8f16..4bddd6f62e4f 100644
> > > > > > > --- a/net/core/sock.c
> > > > > > > +++ b/net/core/sock.c
> > > > > > > @@ -905,6 +905,10 @@ int sock_set_timestamping(struct sock =
*sk, int optname,
> > > > > > >       if (val & ~SOF_TIMESTAMPING_MASK)
> > > > > > >               return -EINVAL;
> > > > > > >
> > > > > > > +     if (val & SOF_TIMESTAMPING_TX_RECORD_MASK &&
> > > > > > > +         !(val & SOF_TIMESTAMPING_SOFTWARE))
> > > > > > > +             return -EINVAL;
> > > > > > > +
> > > > > >
> > > > > > This breaks hardware timestamping
> > > > >
> > > > > Yes, and sorry about that. I'll fix this.
> > > >
> > > > As is I don't understand the purpose of this patch. Please do not=

> > > > just resubmit with a change, but explain the problem and suggeste=
d
> > > > solution first.
> > > >
> > >
> > > I will drop this patch because I just tested with my program in the=

> > > local machine and found there is one mistake I made about calculati=
ng
> > > the diff between those two . Sorry for the noise.
> > >
> > > Well, I only need to send a V2 patch of patch [3/3] in the next few=
 days.
> > >
> > > BTW, please allow me to ask one question unrelated to this patch
> > > again. I do wonder: if we batch the recv skbs from the errqueue whe=
n
> > > calling tcp_recvmsg() -> inet_recv_error(), it could break users,
> > > right?
> >
> > Analogous to __msg_zerocopy_callback with __msg_zerocopy_callback.
> >
> > Only here we cannot return range-based results and thus cannot just
> > expand the range of the one outstanding notification.
> >
> > This would mean in ip(v6)_recv_error calling sock_dequeue_err_skb,
> > sock_recv_timestamp and put_cmsg IP_RECVERR multiple times. And
> > ip_cmsg_recv if needed.
> >
> > Existing applications do not have to expect multiple results per
> > single recvmsg call. So enabling that unconditionally could break
> > them.
> =

> Thanks for your explanation! I was unsure because I read some use
> cases in github and txtimestamp.c, they can only handle one err skb at
> one time.
> =

> >
> > Adding this will require a new flag. An sk_tsflag is the obvious
> > approach.
> >
> > Interpreting a MSG_* flag passed to recvmsg would be
> > another option. If there is a bit that can be set with MSG_ERRQUEUE
> > and cannot already be set currently. But I don't think that's the
> > case. We allow all bits and ignore any undefined ones.
> =

> Do you feel it is necessary that we can implement this idea to
> optimize it, saving 2 or 3 syscalls at most at one time? IIRC, it's
> you who proposed that we can batch them when applying the tracepoints
> mechanism after I gave a presentation at netconf :) It's really good.
> That inspires me a lot and makes me keep wondering if we can do this
> these days.
> =

> Since I've already finished the bpf for timestamping feature locally
> which bypasses receiving skbs from errqueue,

That's great!

> I believe it could be
> helpful for those applications that still have tendency to use the
> "traditional way" to trace.
> =

> What are your thoughts on this? If you agree, do you want to do this
> on your own or allow me to give it a try?

I'd focus on the workload that you care about most, which is the
administrator driven interface, which will use BPF.

This micro optimization would need some benchmarks that show that it
has a measurable effect.

