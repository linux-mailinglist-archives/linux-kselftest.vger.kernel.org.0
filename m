Return-Path: <linux-kselftest+bounces-18708-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9669598B188
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 02:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10D4F1F22A94
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 00:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEC9A5F;
	Tue,  1 Oct 2024 00:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FoUH0bFl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2FB10E3;
	Tue,  1 Oct 2024 00:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727743417; cv=none; b=FDYF2iOf84VClmPzN63QC/gpV4x9RRLgD+1+ydM00Td4KQieWlbL3mDfgxmI9lEuthii0urJyZreXDddSjJ3CnF4pNDY/ifsgR0TI8EJd/VWVDvnqSB1TbcLQ8ky53p1xh4drnKgggil8EnhDyO9nPakQq4UvXLEzmo8jkH0Bm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727743417; c=relaxed/simple;
	bh=2+TqwH40Pr+d098a74cikV4rlBUje1N0T+g5Ihhi3Qk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ScOgWbHAg4xzxbqmEVKgwYbkKOM4RjehE6VqWOoRQ91rzzVG15A8HC7EgSS0Gtsb8kcVQGyUttAg3bjTyH0+hOC7Tw4iFnOLBfJjt21skxKcEyfLvQ4orIcF7auOR8nd6MC5oSnBu3uqzLV1kIecy48QOn2jTRn/QHzr1Yc24qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FoUH0bFl; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3a1a4870713so17247785ab.0;
        Mon, 30 Sep 2024 17:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727743415; x=1728348215; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z4cEAQ8XfQmGc9dWv3Tgp48ZlusK1MH+qneB48Y1AN0=;
        b=FoUH0bFlZpfgoC1apXIozRIL93P2/fdMnCb5kib/ydi6PDJ5z28/Pno9LHs3h6JAf1
         WuKxOF3FHthFxDrOdFsSbmpmAxP+4RvEkKtSE5C+yVYGHpobSXFkkazsUdQdeDpDa+Km
         Ksp5NpyPf+2drq7pDX4pRj7R8NGnOqODyd/6Vozzupa+WgX7h8c6d1Yh/wdzhpmD16Fc
         dumuWJfyOogQnKw5k99FAKlu7r2gjCRca/V87iuQyhs4Cdjc4zCTabvqfZh/0O+F3/Qx
         RuFzwM1WcpUSZ63SLyb+H344FVJ/xG1xE/H5OSFAjWZNfBqGi7qHkgNepjUvnITRphax
         u8Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727743415; x=1728348215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z4cEAQ8XfQmGc9dWv3Tgp48ZlusK1MH+qneB48Y1AN0=;
        b=bGyZ9oHcEME5ficP87CpVpo/Am5qu73lMxlr7w6mJ2nCBDs5BTGTAGq7jBF89r9JlQ
         RKame0O2nP04pkSFapuA6+/pgz6ePMRC0MiMn/ijBVuONLJfnNrbcNcx0Sf3vXsIULfw
         ljxn79OVlwcFfScA/febJiKZR6KnuE3rTbXoNdUtUQgWW/WxBH+4bGJntlg80AoDDC4C
         Srvuh+BfzV3QCfaADr/w2yumsVVoKfwR7AdQtNANYZHaANbST7LE5JrGtlWI+Qr/CtPR
         7FtxoqT6XAG8o+bheORiKuL3dLG28zMNRQY+R3A8IFmVlKWSJGKdlpaLKbVtG8VM6kUj
         1RmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZCyfdnUqOgcq5pLtsqLmwZJlFR6n6xXJ31JvN1xCHlLotlQMdcWw/POJk2zzpd8vVmdBqzJRN@vger.kernel.org, AJvYcCX0NrI9hQzlrKhrFSBUQnc6XQ+wkMi1Pr3/uCy/3RXjCkL6UAnS/lpa+hICsaE98bXI+hDRAasq+bq2g6RrHSU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+5ANatlUb+O69erCWaAxXGthBNw23FNGUIpBOKbqR+Y6z/K30
	jvD+Srtybg6HZRlUxCV/Q+Gn5YwxaFxZd15LkiM5Y+GknB9nid+hdPJYY4d6lqwtIy01ZedIYcA
	adK5hxHWAkLAq+gPFkjaoKyUIEdk=
X-Google-Smtp-Source: AGHT+IGfexrHaFyM8G9XhXgDK4mlZUkIecyggBMH+fkHhs02+8BcuGo1D9RFk4jua/Ld+Bidj4H4JV59URqK7PflULQ=
X-Received: by 2002:a92:c568:0:b0:3a0:9aef:4d0 with SMTP id
 e9e14a558f8ab-3a34514bbb7mr98472595ab.5.1727743415203; Mon, 30 Sep 2024
 17:43:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930092416.80830-1-kerneljasonxing@gmail.com>
 <20240930092416.80830-2-kerneljasonxing@gmail.com> <66fa7fe46392e_17948d294bb@willemb.c.googlers.com.notmuch>
 <CAL+tcoC+VEs1UusEKKVhutw+e=uyEqoaBhRTUV1G4HakM3JVYQ@mail.gmail.com>
 <66fa904185c3_17cd892948a@willemb.c.googlers.com.notmuch> <CAL+tcoBMXtQ_TbjKmO5CazL5zu1dDBBB+enckkM9+0ojF3qutQ@mail.gmail.com>
 <66fadc698746d_187400294a5@willemb.c.googlers.com.notmuch>
 <CAL+tcoBm6YmDr_=WaaWDspE_LN2N6-WdT76Yp6U6fn9pDx-aCQ@mail.gmail.com> <66faeace749e3_18b995294db@willemb.c.googlers.com.notmuch>
In-Reply-To: <66faeace749e3_18b995294db@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 1 Oct 2024 08:42:59 +0800
Message-ID: <CAL+tcoA+rHS_i4yWowK-cefOtjavfZSkifYsTEqB7Bu8i3MusA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] net-timestamp: add strict check when setting
 tx flags
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, shuah@kernel.org, willemb@google.com, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 2:15=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > On Tue, Oct 1, 2024 at 1:14=E2=80=AFAM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > Jason Xing wrote:
> > > > On Mon, Sep 30, 2024 at 7:49=E2=80=AFPM Willem de Bruijn
> > > > <willemdebruijn.kernel@gmail.com> wrote:
> > > > >
> > > > > Jason Xing wrote:
> > > > > > On Mon, Sep 30, 2024 at 6:39=E2=80=AFPM Willem de Bruijn
> > > > > > <willemdebruijn.kernel@gmail.com> wrote:
> > > > > > >
> > > > > > > Jason Xing wrote:
> > > > > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > > > > >
> > > > > > > > Even though this case is unlikely to happen, we have to avo=
id such
> > > > > > > > a case occurring at an earlier point: the sk_rmem_alloc cou=
ld get
> > > > > > > > increased because of inserting more and more skbs into the =
errqueue
> > > > > > > > when calling __skb_complete_tx_timestamp(). This bad case w=
ould stop
> > > > > > > > the socket transmitting soon.
> > > > > > >
> > > > > > > It is up to the application to read from the error queue freq=
uently
> > > > > > > enough and/or increase SO_RCVBUF.
> > > > > >
> > > > > > Sure thing. If we test it without setting SOF_TIMESTAMPING_SOFT=
WARE on
> > > > > > the loopback, it will soon stop. That's the reason why I tried =
to add
> > > > > > the restriction just in case.
> > > > >
> > > > > I don't follow at all.
> > > > >
> > > > > That bit does not affect the core issue: that the application is =
not
> > > > > clearing its error queue quickly enough.
> > > > >
> > > > > > >
> > > > > > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > > > > > ---
> > > > > > > >  net/core/sock.c | 4 ++++
> > > > > > > >  1 file changed, 4 insertions(+)
> > > > > > > >
> > > > > > > > diff --git a/net/core/sock.c b/net/core/sock.c
> > > > > > > > index fe87f9bd8f16..4bddd6f62e4f 100644
> > > > > > > > --- a/net/core/sock.c
> > > > > > > > +++ b/net/core/sock.c
> > > > > > > > @@ -905,6 +905,10 @@ int sock_set_timestamping(struct sock =
*sk, int optname,
> > > > > > > >       if (val & ~SOF_TIMESTAMPING_MASK)
> > > > > > > >               return -EINVAL;
> > > > > > > >
> > > > > > > > +     if (val & SOF_TIMESTAMPING_TX_RECORD_MASK &&
> > > > > > > > +         !(val & SOF_TIMESTAMPING_SOFTWARE))
> > > > > > > > +             return -EINVAL;
> > > > > > > > +
> > > > > > >
> > > > > > > This breaks hardware timestamping
> > > > > >
> > > > > > Yes, and sorry about that. I'll fix this.
> > > > >
> > > > > As is I don't understand the purpose of this patch. Please do not
> > > > > just resubmit with a change, but explain the problem and suggeste=
d
> > > > > solution first.
> > > > >
> > > >
> > > > I will drop this patch because I just tested with my program in the
> > > > local machine and found there is one mistake I made about calculati=
ng
> > > > the diff between those two . Sorry for the noise.
> > > >
> > > > Well, I only need to send a V2 patch of patch [3/3] in the next few=
 days.
> > > >
> > > > BTW, please allow me to ask one question unrelated to this patch
> > > > again. I do wonder: if we batch the recv skbs from the errqueue whe=
n
> > > > calling tcp_recvmsg() -> inet_recv_error(), it could break users,
> > > > right?
> > >
> > > Analogous to __msg_zerocopy_callback with __msg_zerocopy_callback.
> > >
> > > Only here we cannot return range-based results and thus cannot just
> > > expand the range of the one outstanding notification.
> > >
> > > This would mean in ip(v6)_recv_error calling sock_dequeue_err_skb,
> > > sock_recv_timestamp and put_cmsg IP_RECVERR multiple times. And
> > > ip_cmsg_recv if needed.
> > >
> > > Existing applications do not have to expect multiple results per
> > > single recvmsg call. So enabling that unconditionally could break
> > > them.
> >
> > Thanks for your explanation! I was unsure because I read some use
> > cases in github and txtimestamp.c, they can only handle one err skb at
> > one time.
> >
> > >
> > > Adding this will require a new flag. An sk_tsflag is the obvious
> > > approach.
> > >
> > > Interpreting a MSG_* flag passed to recvmsg would be
> > > another option. If there is a bit that can be set with MSG_ERRQUEUE
> > > and cannot already be set currently. But I don't think that's the
> > > case. We allow all bits and ignore any undefined ones.
> >
> > Do you feel it is necessary that we can implement this idea to
> > optimize it, saving 2 or 3 syscalls at most at one time? IIRC, it's
> > you who proposed that we can batch them when applying the tracepoints
> > mechanism after I gave a presentation at netconf :) It's really good.
> > That inspires me a lot and makes me keep wondering if we can do this
> > these days.
> >
> > Since I've already finished the bpf for timestamping feature locally
> > which bypasses receiving skbs from errqueue,
>
> That's great!
>
> > I believe it could be
> > helpful for those applications that still have tendency to use the
> > "traditional way" to trace.
> >
> > What are your thoughts on this? If you agree, do you want to do this
> > on your own or allow me to give it a try?
>
> I'd focus on the workload that you care about most, which is the
> administrator driven interface, which will use BPF.
>
> This micro optimization would need some benchmarks that show that it
> has a measurable effect.

Got it. I will post that series soon.

Thanks,
Jason

