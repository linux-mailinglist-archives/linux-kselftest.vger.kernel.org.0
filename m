Return-Path: <linux-kselftest+bounces-17238-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD07096DA90
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 15:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96EA1288015
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 13:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B86819D89E;
	Thu,  5 Sep 2024 13:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GEPTlnVV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7108219D885;
	Thu,  5 Sep 2024 13:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725543697; cv=none; b=NdR0v95rCCYC9cwJbIoSzPLtgPZMemrEPJBuc3CAfXqtHe2b4Or5o9twohhxJ+uOBtBibvLASKkxbbfW21DEB37hhO8KKyIQl4a35B6onGuT+Tt8IEk9R+xhJ4WhuU6+sk6WKhAB9rJQTSkwpFeeK7A1o87lA+bUzoNWD4K8UcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725543697; c=relaxed/simple;
	bh=gIqWsC5lxydje2dzXSHp8pbLdj0xu04lUsa/943sB28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lSK6KWFKpqkMqgdLMxOsethaIYVu2+marGhELSuqs29q1dW08r/1xXDhstElA7ixo8bRXlex0tU/pdce/me4vmTCqDRfrDc6Gm1mFA1TgBw/7K3S+WwjDmSir6abbpE5QgdXuGVpXsQhvcvgdH003ng4TII9edzxLLGUd3SAggM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GEPTlnVV; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-39d3cd4fa49so2525855ab.1;
        Thu, 05 Sep 2024 06:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725543694; x=1726148494; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=752IbR2ypUXV31keKCOgDn1D0LRydIL56SC/NZ/9Pb0=;
        b=GEPTlnVVB1PU9g+VylCcKCVfDUb8V9JSxIWoF2+Hmte+El4mDSzV5Z025TBp5lp7TV
         SIwBT6swH7j8ddWKO3TBrAtsQQeLrIkqNP8l/chbc+phC3DUzKsZ53ehJOzGTGU5x6n5
         b4aGIyJuv+iq5mZCYCOIXOq167fZKFeeb8rUtHw6cP0z+c/UmTxWQNLTUCuhNvhAVRww
         I3A7npT2+3ICz3khLxrEqOOT3bks92Wkp/gJ3PzKsY7NSsYea1lMtSNYkS/0nwyeB2yT
         Cjz8VqHw4/UxkI0hHAjNTDRiKLRj0Ntbckh8wXOqnZ7tjIoZSPfCfbzZIQur4twWj6rW
         +56g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725543694; x=1726148494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=752IbR2ypUXV31keKCOgDn1D0LRydIL56SC/NZ/9Pb0=;
        b=ArkXZC7B17vku9Eeospy1wXpIe5ev2bzCY9RJjSxYiyT0eRo/kpXc+Co4VmE1qHU6M
         0rgi5IgNEdBr50cWaAnLGsNqQoz5j56svnKsSOviJetSppNIDmg4OpvJ5+xX3jrtGkj7
         u/eOyU4HRx94Mgz+uz6Rwxr4B9fBvezkJ87wDFj+XbQ/JAYs+5tR4x5IZrylSar5zZEC
         mixc+jyjzPKV0t43UcQ7ATpD30+9gFaxHzrgrt71SbeFfNpW8kwzijyHZQuYnItH/2Ic
         yED8997CeSqKLmutzXhMC1pygO1qxfe3O8Qje8PyNw5Ls0TywPeVUZdYOpj7y6eo9U8Q
         ch3g==
X-Forwarded-Encrypted: i=1; AJvYcCVQsJj9tvPCoaPofNjeA7YvomrU6aRCpPIlkcLhaOwcPLlupwq4fCCxeFiRaFnvmZhyJH1wEjmIbKFcpLg/2e8=@vger.kernel.org, AJvYcCVsIdKvnKzqkPLwScgshD+JrpAVGoiO6nZZMaUtcNPUZv4Vy+ZKXvRfREQJ2ubz1wMezrDNXYFN@vger.kernel.org
X-Gm-Message-State: AOJu0YxYFK+D0v/VpfXtxsiHURcEdQwp7emeugCy8bReQV8DQfS2r70r
	n17A77+6Iq6+o9VpOJWBmcvdyVtujYpJc4AslCAV23YupcHHcUklTc7jIb08wJxTZSG+ne0560F
	svq/XxM6JYizUMkzxF7oHbqIIhnI=
X-Google-Smtp-Source: AGHT+IEpz+X2tWx2xxbGj5Bo7bQhHgwxYztD5yPC/auXGPT9YLlRab1IP8H0+Vk3xBXZHV8hBN++PY2UVLBcmdv205o=
X-Received: by 2002:a05:6e02:1522:b0:39f:5d96:1fd6 with SMTP id
 e9e14a558f8ab-39f797a5aacmr49926955ab.9.1725543694394; Thu, 05 Sep 2024
 06:41:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904144446.41274-1-kerneljasonxing@gmail.com>
 <66d8ce15415ec_163d93294a2@willemb.c.googlers.com.notmuch> <CAL+tcoDko2ijPvnBr1=dy4iBfw9wLEyKX0ye4rFngd_q7Zr7eQ@mail.gmail.com>
In-Reply-To: <CAL+tcoDko2ijPvnBr1=dy4iBfw9wLEyKX0ye4rFngd_q7Zr7eQ@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 5 Sep 2024 21:40:57 +0800
Message-ID: <CAL+tcoBhdFS5wjE7v7G_Hf9SsTkqiaGqWTE8Zp-NyJA7F6pspw@mail.gmail.com>
Subject: Re: [PATCH net-next] selftests: return failure when timestamps can't
 be parsed
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 7:04=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.co=
m> wrote:
>
> On Thu, Sep 5, 2024 at 5:16=E2=80=AFAM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Jason Xing wrote:
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > When I was trying to modify the tx timestamping feature, I found that
> > > running "./txtimestamp -4 -C -L 127.0.0.1" didn't reflect the fact
> > > properly.
> >
> > Did not reflect what fact? Sorry, I don't entirely follow the issue
> > you raise.
> >
> > > In this selftest file, we respectively test three tx generation flags=
.
> > > With the generation and report flag enabled, we expect that the times=
tamp
> > > must be returned to the userspace unless 1) generating the timestamp
> > > fails, 2) reporting the timestamp fails. So we should test if the
> > > timestamps can be read and parsed succuessfuly in txtimestamp.c, or
> >
> > typo: successfully
> >
> > > else there is a bug in the kernel.
> > >
> > > After adding the check so that running ./txtimestamp will reflect the
> > > result correctly like this if there is an error in kernel:
> > > protocol:     TCP
> > > payload:      10
> > > server port:  9000
> > >
> > > family:       INET
> > > test SND
> > >     USR: 1725458477 s 667997 us (seq=3D0, len=3D0)
> > > Failed to parse timestamps
> > >     USR: 1725458477 s 718128 us (seq=3D0, len=3D0)
> > > Failed to parse timestamps
> > >     USR: 1725458477 s 768273 us (seq=3D0, len=3D0)
> > > Failed to parse timestamps
> > >     USR: 1725458477 s 818416 us (seq=3D0, len=3D0)
> > > Failed to parse timestamps
> > > ...
> > >
> > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > ---
> > > I'm not sure if I should also check if the cur->tv_sec or cur->tv_nse=
c
> > > is zero in __print_timestamp(). Could it be valid when either of
> > > them is zero?
> >
> > tv_nsec can be zero. tv_sec cannot.
> >
> > > ---
> > >  tools/testing/selftests/net/txtimestamp.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/tools/testing/selftests/net/txtimestamp.c b/tools/testin=
g/selftests/net/txtimestamp.c
> > > index ec60a16c9307..b69aae840a67 100644
> > > --- a/tools/testing/selftests/net/txtimestamp.c
> > > +++ b/tools/testing/selftests/net/txtimestamp.c
> > > @@ -358,6 +358,10 @@ static void __recv_errmsg_cmsg(struct msghdr *ms=
g, int payload_len)
> > >
> > >       if (batch > 1)
> > >               fprintf(stderr, "batched %d timestamps\n", batch);
> > > +     else if (!batch) {
> > > +             fprintf(stderr, "Failed to parse timestamps\n");
> > > +             test_failed =3D true;
> > > +     }
> >
> > nit: if adding braces around one side of a branch, then add to both (al=
l).
> >
> > This is not so much a parsing failure as that no timestamps arrived.
> >
> > More importantly, this function gets called also if
> > recvmsg(fd, .., MSG_ERRQUEUE) returned 0:
> >
> >         if (ret >=3D 0) {
> >                 __recv_errmsg_cmsg(&msg, ret);
> >
> > That seems counterintuitive, as there is no data. But this was
> > introduced with cfg_loop_nodata (SOF_TIMESTAMPING_OPT_TSONLY). When
> > there may be packets looped, just 0B packets. In those cases we also
> > expect timestamps.
> >
> > But, can __recv_errmsg_cmsg now also be called when there truly is
> > nothing on the error queue? It is a non-blocking read, after all.
>
> Today I re-read this paragraph. I think we were just past each other.
>
> I would like to check that if the reporting timestamp with someone's
> patch applied someday wouldn't work, the txtimestamp should return
> failure to warn the submitter. That is to say, we succeed to generate
> the skb with timestamp but failed to report it like this:
>
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 8a5680b4e786..65f7947322cd 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -2274,7 +2274,7 @@ void tcp_recv_timestamp(struct msghdr *msg,
> const struct sock *sk,
>                         }
>                 }
>
> -               if (READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_SOFTWARE=
)
> +               if (!(READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_SOFTWA=
RE))
>                         has_timestamping =3D true;
>                 else
>                         tss->ts[0] =3D (struct timespec64) {0};

If so, rxtimestamp test will fail. Let me correct myself here.

>
> which I intentionally wrote is used to show one stupid bug as an
> example. The txtimestamp test should spot it :)

Sorry, not in tcp_recv_timestamp, but like in __sock_recv_timestamp:

j@@ -946,7 +946,7 @@ void __sock_recv_timestamp(struct msghdr *msg,
struct sock *sk,

        memset(&tss, 0, sizeof(tss));
        tsflags =3D READ_ONCE(sk->sk_tsflags);
-       if ((tsflags & SOF_TIMESTAMPING_SOFTWARE) &&
+       if (!(tsflags & SOF_TIMESTAMPING_SOFTWARE) &&
            ktime_to_timespec64_cond(skb->tstamp, tss.ts + 0))
                empty =3D 0;
        if (shhwtstamps &&

This error/bug cannot be noticed by txtimestamp before this patch.

It's just an example which helps me clarify my thoughts.

>
> Thanks,
> Jason

