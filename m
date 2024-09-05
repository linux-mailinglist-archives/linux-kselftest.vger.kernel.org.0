Return-Path: <linux-kselftest+bounces-17214-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA3796D6AE
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 13:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 703B31C238E9
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 11:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287AC19923C;
	Thu,  5 Sep 2024 11:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1ASrBYN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA19199231;
	Thu,  5 Sep 2024 11:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725534283; cv=none; b=P0O0ns8KP9Py+UfqN4puB6NRmm+gPAejyo5IMdLJE3dRSPjt+sEhDkGMqe6kpVq/2CL3Si0zBLWJtpMPQVL1DVx/7kIuKKi8HlaObcHdJpVoRY7OAqbOfrQQEFBFoCiha76KI92VLIlNB38YVeGIMp8Qs0f2GoxaSIAQSIYVRTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725534283; c=relaxed/simple;
	bh=kOCiF8nsosBKqznyU+eG3n+wt+yb6o2N4Y5rEsqvqWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I25f+5OFcF/KfreP7BmcrlajQPElxdMLcj7DSZNBsmDeNURk34kV7iWAexukmDgCvJPhgUVxoeIa2uyz5LT+wJrXoVwTv1vLJeW81NiC8L5sgk4QE7SxknutF68wxwMsVK3r90riyXGGFOm6bRyrCfMaHkfAq6Rayp23+I5uJXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D1ASrBYN; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3a043496fdeso2081735ab.3;
        Thu, 05 Sep 2024 04:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725534280; x=1726139080; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mizWkFU32/oNF8sGJhFD1hiaSJOb8XN9+QqQonvqlLs=;
        b=D1ASrBYNZTcfEgQ2zOeE3IieueYdhgx3zsnGRr4d3W1nOybw6qMeJtmeHt7G1C5nHa
         99ndNrT84kEhaHOmsx92hgO444lgekxsAhJwgeVFF9oNu1CkyrHHemUH7HaPg83HuE0A
         EIUU1ZV/40ul0/U/dVL5xbJGa67c7eAZmHuczR3LN9Kg7FEs5D2ZGiKKIdgpHUmLbELP
         +2uLsAZjLFcCYGjOfWSE+4Jfze/T9gYrzGaQJMSNfWZwC1SjtdXSj82Zo31kZJ4hKpis
         +FX3BjV7eqHoxUINtzynlo2HAJZY8Ts3ylo4AZJ0Y8PRXJcgmfgoji/Mb+b9Frye+E+7
         yRCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725534280; x=1726139080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mizWkFU32/oNF8sGJhFD1hiaSJOb8XN9+QqQonvqlLs=;
        b=NpY/QdH2Y48HuyuO2bz04O0aBW0DMxydSD+7DkmkhQ4StPJCJu0tWvqrAzFbAV8h7O
         iaLR4KxUzcYWHMfol9nffOqOs58XIdeGT+alBSfdYJUbO3axvtRb75kNEkvkP3hfB7kr
         Ptq28ojwR25KNpwGy8jm2bJUS1h8FuS2UOrDzXsLTmRj+8PH6/XkmAG4R6hVMV4xM5T/
         SgHEPDwXVGXZHi9X97kFpiWKYvVyBYwnpu9eTgdqLwtieMQS09SY/FokRW2l04bvnfdH
         OQUn6sy+nfUhCsml2ZmQq3lsInSQJDUI8+lPGh+J3oEqjO7qPmzhCyw2nG3ZJruC5Zje
         XteQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDznUzoC+8dnqo5lpMqyng9uBjAVKYpZYuduJe+9/u7RbGq2kBRzo4pNeU1xEWTC6UQuxSxr0P@vger.kernel.org, AJvYcCWcLKWjze5E7XxP39WGqqjqYmFPP0zI/EsQT6voaUZJV2+vsSL1mcRTmKvZDZ0OJ1FCyU1XU5o8v++un0OBXzI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCm16eGI3JifAdAugcVnUN04fXtOIIVZe2zN6b4ia3nACuZ9oL
	sdIabidd6BmXPOAm0xj0rZKMuXpNoip5mKogcM8C+Q9u/NF/Ww5CVunT/XfcTDIiRTjktqanRQE
	zK+GSYlYrBQKrQZOt260KaoqXRRU=
X-Google-Smtp-Source: AGHT+IGcychPtnWKEZ7vp+NFPEjIKSRF7cOH85iWFf1X3owut3zhBZ0nYAlt+RQMmvJ32iYHodhff0IThlYFLM7BJpE=
X-Received: by 2002:a05:6e02:1fc5:b0:39e:6e47:814d with SMTP id
 e9e14a558f8ab-39f378ed22emr261736125ab.2.1725534280587; Thu, 05 Sep 2024
 04:04:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904144446.41274-1-kerneljasonxing@gmail.com> <66d8ce15415ec_163d93294a2@willemb.c.googlers.com.notmuch>
In-Reply-To: <66d8ce15415ec_163d93294a2@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 5 Sep 2024 19:04:04 +0800
Message-ID: <CAL+tcoDko2ijPvnBr1=dy4iBfw9wLEyKX0ye4rFngd_q7Zr7eQ@mail.gmail.com>
Subject: Re: [PATCH net-next] selftests: return failure when timestamps can't
 be parsed
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 5:16=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > When I was trying to modify the tx timestamping feature, I found that
> > running "./txtimestamp -4 -C -L 127.0.0.1" didn't reflect the fact
> > properly.
>
> Did not reflect what fact? Sorry, I don't entirely follow the issue
> you raise.
>
> > In this selftest file, we respectively test three tx generation flags.
> > With the generation and report flag enabled, we expect that the timesta=
mp
> > must be returned to the userspace unless 1) generating the timestamp
> > fails, 2) reporting the timestamp fails. So we should test if the
> > timestamps can be read and parsed succuessfuly in txtimestamp.c, or
>
> typo: successfully
>
> > else there is a bug in the kernel.
> >
> > After adding the check so that running ./txtimestamp will reflect the
> > result correctly like this if there is an error in kernel:
> > protocol:     TCP
> > payload:      10
> > server port:  9000
> >
> > family:       INET
> > test SND
> >     USR: 1725458477 s 667997 us (seq=3D0, len=3D0)
> > Failed to parse timestamps
> >     USR: 1725458477 s 718128 us (seq=3D0, len=3D0)
> > Failed to parse timestamps
> >     USR: 1725458477 s 768273 us (seq=3D0, len=3D0)
> > Failed to parse timestamps
> >     USR: 1725458477 s 818416 us (seq=3D0, len=3D0)
> > Failed to parse timestamps
> > ...
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > ---
> > I'm not sure if I should also check if the cur->tv_sec or cur->tv_nsec
> > is zero in __print_timestamp(). Could it be valid when either of
> > them is zero?
>
> tv_nsec can be zero. tv_sec cannot.
>
> > ---
> >  tools/testing/selftests/net/txtimestamp.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/tools/testing/selftests/net/txtimestamp.c b/tools/testing/=
selftests/net/txtimestamp.c
> > index ec60a16c9307..b69aae840a67 100644
> > --- a/tools/testing/selftests/net/txtimestamp.c
> > +++ b/tools/testing/selftests/net/txtimestamp.c
> > @@ -358,6 +358,10 @@ static void __recv_errmsg_cmsg(struct msghdr *msg,=
 int payload_len)
> >
> >       if (batch > 1)
> >               fprintf(stderr, "batched %d timestamps\n", batch);
> > +     else if (!batch) {
> > +             fprintf(stderr, "Failed to parse timestamps\n");
> > +             test_failed =3D true;
> > +     }
>
> nit: if adding braces around one side of a branch, then add to both (all)=
.
>
> This is not so much a parsing failure as that no timestamps arrived.
>
> More importantly, this function gets called also if
> recvmsg(fd, .., MSG_ERRQUEUE) returned 0:
>
>         if (ret >=3D 0) {
>                 __recv_errmsg_cmsg(&msg, ret);
>
> That seems counterintuitive, as there is no data. But this was
> introduced with cfg_loop_nodata (SOF_TIMESTAMPING_OPT_TSONLY). When
> there may be packets looped, just 0B packets. In those cases we also
> expect timestamps.
>
> But, can __recv_errmsg_cmsg now also be called when there truly is
> nothing on the error queue? It is a non-blocking read, after all.

Today I re-read this paragraph. I think we were just past each other.

I would like to check that if the reporting timestamp with someone's
patch applied someday wouldn't work, the txtimestamp should return
failure to warn the submitter. That is to say, we succeed to generate
the skb with timestamp but failed to report it like this:

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 8a5680b4e786..65f7947322cd 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2274,7 +2274,7 @@ void tcp_recv_timestamp(struct msghdr *msg,
const struct sock *sk,
                        }
                }

-               if (READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_SOFTWARE)
+               if (!(READ_ONCE(sk->sk_tsflags) & SOF_TIMESTAMPING_SOFTWARE=
))
                        has_timestamping =3D true;
                else
                        tss->ts[0] =3D (struct timespec64) {0};

which I intentionally wrote is used to show one stupid bug as an
example. The txtimestamp test should spot it :)

Thanks,
Jason

