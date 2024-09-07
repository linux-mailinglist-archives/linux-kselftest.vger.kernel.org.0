Return-Path: <linux-kselftest+bounces-17438-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A4096FEF0
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Sep 2024 03:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DADBBB22B75
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Sep 2024 01:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9798F70;
	Sat,  7 Sep 2024 01:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BCU2nf1q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17ED1862;
	Sat,  7 Sep 2024 01:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725672254; cv=none; b=jfkQGbKerHMEyNzDbC+H9TOZtz1cSeU5tKGoB/WYLV1J/3Ea58vxilRVqeyeqrx4OZzOLtQG6+B3/fplcVtbRpeGEKvadz3V8h+j6Am47LaOF4k6tg6kLrexL9cWeAfBrDD4nJBRerREAKAH/qhjwCxwCuEFLmYTkk6Gjvtd1ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725672254; c=relaxed/simple;
	bh=rmc5UpQSW54bbp3qy4jsEVrgmMyC5hKoXPma0Rl8vgs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XTytshiHa8JrXjqxTl2Kz4caf10jID6wpr3Q+84k+cRFhEQ1M0Rf3Ri7dDrIzEY5piA2SX1Uu+cjgvIJ3vikAaWDeuehHl5jL124192Uq/TBJh4loa+wlD62oL+bvplmBpQGW6ovrB84pX3vP3dKFYLvczjYPJ6z/ELQjYi/Nxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BCU2nf1q; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-82a151a65b8so108374839f.2;
        Fri, 06 Sep 2024 18:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725672252; x=1726277052; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=udk9c3nLcltORNsDbI8hzoyKXo/Iba0ubtpd5F0VTJs=;
        b=BCU2nf1qMIpXN0ua2l9xAf/A68Jyh314PS7dMoSrMxcgRHjH3JZbLEWigb6gr91+Ri
         OOi2v5zOrGWGg8sadMV+OQas2kcUgfTIC+z9Fp7rpstyxfAQHbVHecHcE0yJhbx3cVbn
         JhsHdjdcmexewqoZaHPgM5X60jDug87rqE6GmSfXK4hAo33TJCAatSQZwTjzrgaLqC/H
         uM486cIFbuK3AlgknuvYH5Yt+1uKHomCPZUfapMCInckwC7JCKVdRHYU5q65z0vYwhWR
         Uer/I8YddS2NDhk+Hymco3DOOzqnXwN8h3DbTuE1V9CwI4fKmFNrMAQnQrX8sISz/jLy
         QJVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725672252; x=1726277052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=udk9c3nLcltORNsDbI8hzoyKXo/Iba0ubtpd5F0VTJs=;
        b=F9twYs0rLWS3HoyozT5ewG1snk8HF3WbsU2QkV43CuRxz1hnl/Qf+CqvZb2hc0eVLo
         BYFWr2RlNqkoj2lqc4JR8znNvkDLOhc2GMNod1p15jIk/LgoZB9pSXQrdzsSBs42GIbb
         IzH0p2Mz1WVMLhx+Q86Z9WS+T4RyEZTODe/qMFXsmdaNQ0fOqeWT//KFSfG5EFwCMFXN
         Xx/bhlME2/87T4dKcv1TVoxqKZSI0+Lwa8jJwjXk4cEMzECjWaIQOZXSvJq+9q1jGbM4
         QUVicS64y65LfCVWaZTOfHoRMdH+u/8cmXY4fyL4KTDqShmaLZQWdo/UbOHjZy6B4ErJ
         GxRw==
X-Forwarded-Encrypted: i=1; AJvYcCUqNk/hcmavLQi5+6iDMywoSBlV4acPy/LT53T7rv8lP6DHRMe6mWm8IC9I04XNif+nnGET/WtCpCmtaiWRNUU=@vger.kernel.org, AJvYcCWFzIwpBoenYMfIDZtndajcZZ2EDyK0G7T3Oas56fsV8vesy2MaewtON7uKJ6w78FCmjHeiSCKP@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt0uvDt5HsRi1P492iZz67tp1MqclUXk9I+rOnV9sQFzzAaHE+
	pWKsW7ZWhtfrftl5uA/hlOlUYexsj4kdfgnhYZCELUf1z0ahHUMAkUCbq/aiGX7pDV/VQd8D9yi
	eR9QoCnzTz/OMM26ycvOpPZmfJvc=
X-Google-Smtp-Source: AGHT+IEFRPSfvE9i/cLODaWPHphE4bWP0hjd9Z2ed0zmBKBxOcgh0O06SFshpk748ERNPmuljh4GwSd3BXW6CqXleus=
X-Received: by 2002:a05:6e02:1a4d:b0:39f:60d7:813b with SMTP id
 e9e14a558f8ab-3a04f0f131bmr60105045ab.22.1725672251834; Fri, 06 Sep 2024
 18:24:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906095640.77533-1-kerneljasonxing@gmail.com>
 <20240906095640.77533-2-kerneljasonxing@gmail.com> <66db8f293dbd1_2a33ef294b3@willemb.c.googlers.com.notmuch>
In-Reply-To: <66db8f293dbd1_2a33ef294b3@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 7 Sep 2024 09:23:35 +0800
Message-ID: <CAL+tcoC9NoE3ws3nA-_ANAqD1cWpv9JDzFY11ACryZgg35dQrg@mail.gmail.com>
Subject: Re: [PATCH net-next v5 1/2] net-timestamp: introduce
 SOF_TIMESTAMPING_OPT_RX_FILTER flag
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, shuah@kernel.org, willemb@google.com, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 7, 2024 at 7:24=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > introduce a new flag SOF_TIMESTAMPING_OPT_RX_FILTER in the receive
> > path. User can set it with SOF_TIMESTAMPING_SOFTWARE to filter
> > out rx software timestamp report, especially after a process turns on
> > netstamp_needed_key which can time stamp every incoming skb.
> >
> > Previously, we found out if an application starts first which turns on
> > netstamp_needed_key, then another one only passing SOF_TIMESTAMPING_SOF=
TWARE
> > could also get rx timestamp. Now we handle this case by introducing thi=
s
> > new flag without breaking users.
> >
> > Quoting Willem to explain why we need the flag:
> > "why a process would want to request software timestamp reporting, but
> > not receive software timestamp generation. The only use I see is when
> > the application does request
> > SOF_TIMESTAMPING_SOFTWARE | SOF_TIMESTAMPING_TX_SOFTWARE."
> >
> > Similarly, this new flag could also be used for hardware case where we
> > can set it with SOF_TIMESTAMPING_RAW_HARDWARE, then we won't receive
> > hardware receive timestamp.
> >
> > Another thing about errqueue in this patch I have a few words to say:
> > In this case, we need to handle the egress path carefully, or else
> > reporting the tx timestamp will fail. Egress path and ingress path will
> > finally call sock_recv_timestamp(). We have to distinguish them.
> > Errqueue is a good indicator to reflect the flow direction.
> >
> > Suggested-by: Willem de Bruijn <willemb@google.com>
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
>
> High level: where is the harm in receiving unsolicited timestamps?
> A process can easily ignore them. I do wonder if the only use case is
> an overly strict testcase. Was reminded of this as I tried to write
> a more concise paragraph for the documentation.

You raised a good question.

I think It's more of a design consideration instead of a bugfix
actually. So it is not solving a bug which makes the apps wrong but
gives users a hint that we can explicitly and accurately do what we
want and we expect.

Let's assume: if we remove all the report flags design, what will
happen? It can work of course. I don't believe that people choose to
enable the generation flag but are not willing to report it. Of
course, It's another thing. I'm just saying.

I wonder if it makes sense to you :) ?

>
> Otherwise implementation looks fine, only the tiniest nit.
>
> > @@ -946,11 +946,17 @@ void __sock_recv_timestamp(struct msghdr *msg, st=
ruct sock *sk,
> >
> >       memset(&tss, 0, sizeof(tss));
> >       tsflags =3D READ_ONCE(sk->sk_tsflags);
> > -     if ((tsflags & SOF_TIMESTAMPING_SOFTWARE) &&
> > +     if ((tsflags & SOF_TIMESTAMPING_SOFTWARE &&
> > +          (tsflags & SOF_TIMESTAMPING_RX_SOFTWARE ||
> > +          skb_is_err_queue(skb) ||
> > +          !(tsflags & SOF_TIMESTAMPING_OPT_RX_FILTER))) &&
>
> Nit: these statements should all align on the inner brace, so indent
> by one character.

I'm not that sure about the format, please help me to review here:

@@ -946,11 +946,17 @@ void __sock_recv_timestamp(struct msghdr *msg,
struct sock *sk,

        memset(&tss, 0, sizeof(tss));
        tsflags =3D READ_ONCE(sk->sk_tsflags);
-       if ((tsflags & SOF_TIMESTAMPING_SOFTWARE) &&
+       if ((tsflags & SOF_TIMESTAMPING_SOFTWARE &&
+            (tsflags & SOF_TIMESTAMPING_RX_SOFTWARE ||
+             skb_is_err_queue(skb) ||
+             !(tsflags & SOF_TIMESTAMPING_OPT_RX_FILTER))) &&
            ktime_to_timespec64_cond(skb->tstamp, tss.ts + 0))
                empty =3D 0;
        if (shhwtstamps &&
-           (tsflags & SOF_TIMESTAMPING_RAW_HARDWARE) &&
+           (tsflags & SOF_TIMESTAMPING_RAW_HARDWARE &&
+            (tsflags & SOF_TIMESTAMPING_RX_HARDWARE ||
+             skb_is_err_queue(skb) ||
+             !(tsflags & SOF_TIMESTAMPING_OPT_RX_FILTER))) &&
            !skb_is_swtx_tstamp(skb, false_tstamp)) {
                if_index =3D 0;
                if (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP_NETDEV)

>
> >           ktime_to_timespec64_cond(skb->tstamp, tss.ts + 0))
> >               empty =3D 0;
> >       if (shhwtstamps &&
> > -         (tsflags & SOF_TIMESTAMPING_RAW_HARDWARE) &&
> > +         (tsflags & SOF_TIMESTAMPING_RAW_HARDWARE &&
> > +         (tsflags & SOF_TIMESTAMPING_RX_HARDWARE ||

same here and the following two statements? Should I also indent by
one char by the way?

> > +         skb_is_err_queue(skb) ||
> > +         !(tsflags & SOF_TIMESTAMPING_OPT_RX_FILTER))) &&
> >           !skb_is_swtx_tstamp(skb, false_tstamp)) {
> >               if_index =3D 0;
> >               if (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP_NETDEV)
> > --
> > 2.37.3
> >
>
>

