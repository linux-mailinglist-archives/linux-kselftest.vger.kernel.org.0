Return-Path: <linux-kselftest+bounces-18675-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0716698AB78
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 19:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8267A1F237C3
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 17:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66960198E84;
	Mon, 30 Sep 2024 17:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jOQ5pVF2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B211B192D82;
	Mon, 30 Sep 2024 17:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727719043; cv=none; b=dYktlFEQgO+g5F/UALi2ehyVTysA3tuBUIwzco6VOxfULPLba+GC9++3cBrcI5pHFnpMXql0utacS6iyzTQIFOg5hppxPsFTlBDVcsGeAG+ARnSVxF/R4UJXnaFHwWcjq5lg7XKzj/b0iSWCwtgoQUqfQIE4hHXEgS0L+4EB/V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727719043; c=relaxed/simple;
	bh=8GKW4Nfaj8ElJ2qX2LqoSjGmFLifYOim+YlwMDmZ504=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GQgTJ6l6bIGtOOvPJ/kFHkbFDsvWLvC9greEcC4V1p/czw/AxIr6cOOSsarq9bnv4/NmCZN1WlMOccOiJPN8xKL9FuZppHnSKPnwicfxulxmEQZ179O2AnwEZVgRsUhE5bZTFz9ZwHtoRy0+lfa9zcRIn9BidJ3KmfV4ZRbyXR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jOQ5pVF2; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a1a3090f93so15543935ab.1;
        Mon, 30 Sep 2024 10:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727719041; x=1728323841; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RkuHB9W+Ul6catLgePR5NySmMtYg4kqu/HJkidxVyGU=;
        b=jOQ5pVF2pOh65yPGFAcwn54cWRcTSxvrNRzZ1aioLT05dU0YolscLjgQeqe9QijXBN
         FvUpUMVk5aEkxITMu/r5dXA9f6udeswGdZkI8hCpB/c7n/sH/mwgKxagrePF/SjAU0CV
         CnIsty0V8abzCyTKYZ4RJZNEeqV/Ve2LEd6okQeii5B0vMDkZuTpDhXBy/L+pVmM1UTW
         WgAHSh0OcNvYXMMO6Rxk5BvN6yehfHxIUwynyy5aYM0sNsVMhs1rN6m3SKp7OpYjb2gS
         oZnxwKgRgUJTmjiuFEuKhC8Pg4ZPSKf84ywqBCJCkFgnMa7suFb3DiAmA/cDvStOuwPs
         Qk+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727719041; x=1728323841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RkuHB9W+Ul6catLgePR5NySmMtYg4kqu/HJkidxVyGU=;
        b=VMDHqIzFZnIEaJgswDIjMqW+PpxL3Kj/c642DK8hk9FrAgVCoMyXNyr/u8X/Sn+NM9
         QknzyJKRB3jORQwGfAVe9DObzC3NjmghcEPJs6NTcU0OjAjEpyqppvZFiEjqMv7MdmjU
         c3izIleWSjh07OnEdVd+kmVTO5CJFacZSF34QRR8ZQ973Pp7NyZdk1MhbSDB3jOPEkAh
         HzEoxetv5S5bw1XZZyMcESj+jAqwcIkB4EJHwws5W0GA76Fwe03/3lnie3LNGltclCuO
         cfcx+pVE5YbGDOMwhpZtjiIKGOpSJPzr+9EAhkeN7GBZiXP6HJU5X8cL7Pim4CwBHQe/
         avnA==
X-Forwarded-Encrypted: i=1; AJvYcCUVk/fIInAVBPRJObJUgbdxR6P8PHNlCY91bsq6XYbBs+Dk6lPS0Pr7u53R9PNydLRLrmaQ6TXO@vger.kernel.org, AJvYcCXe8rgv5gq0Ca0qfyQNH+VU5X+6hdOmTXx3BUddV7ZUnl0hxFNyY/fsC5zOLgBwh+ieth3TkFwhoEfU6DkrT+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlXTymufDTbsLmjfDk+A5CjLd+sWBsaZZ8IquynzGMhQH6i8o6
	Eyr4qC6/I9zwTJ2VWE03jVs5Mo5ZkB+9A2dPAVQ/iy5LpDjsScEz5e5hpvrCTQLZTlwSYOJOoVa
	uXPzkPEeZeyS9zMQ3mzvyI0wvSiw=
X-Google-Smtp-Source: AGHT+IEx/osSQPvLPz+y5Z4cwFS7CZburXSyteSvLZ+udXqK8kBROCx7zRzKyDnMyXlQYOFHdB8oomWqmt0VDmdb+4M=
X-Received: by 2002:a05:6e02:1a6e:b0:3a0:9ed2:67b8 with SMTP id
 e9e14a558f8ab-3a34514bbd2mr115485485ab.4.1727719040761; Mon, 30 Sep 2024
 10:57:20 -0700 (PDT)
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
In-Reply-To: <66fadc698746d_187400294a5@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 1 Oct 2024 01:56:44 +0800
Message-ID: <CAL+tcoBm6YmDr_=WaaWDspE_LN2N6-WdT76Yp6U6fn9pDx-aCQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] net-timestamp: add strict check when setting
 tx flags
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, shuah@kernel.org, willemb@google.com, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 1:14=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > On Mon, Sep 30, 2024 at 7:49=E2=80=AFPM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > Jason Xing wrote:
> > > > On Mon, Sep 30, 2024 at 6:39=E2=80=AFPM Willem de Bruijn
> > > > <willemdebruijn.kernel@gmail.com> wrote:
> > > > >
> > > > > Jason Xing wrote:
> > > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > > >
> > > > > > Even though this case is unlikely to happen, we have to avoid s=
uch
> > > > > > a case occurring at an earlier point: the sk_rmem_alloc could g=
et
> > > > > > increased because of inserting more and more skbs into the errq=
ueue
> > > > > > when calling __skb_complete_tx_timestamp(). This bad case would=
 stop
> > > > > > the socket transmitting soon.
> > > > >
> > > > > It is up to the application to read from the error queue frequent=
ly
> > > > > enough and/or increase SO_RCVBUF.
> > > >
> > > > Sure thing. If we test it without setting SOF_TIMESTAMPING_SOFTWARE=
 on
> > > > the loopback, it will soon stop. That's the reason why I tried to a=
dd
> > > > the restriction just in case.
> > >
> > > I don't follow at all.
> > >
> > > That bit does not affect the core issue: that the application is not
> > > clearing its error queue quickly enough.
> > >
> > > > >
> > > > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > > > ---
> > > > > >  net/core/sock.c | 4 ++++
> > > > > >  1 file changed, 4 insertions(+)
> > > > > >
> > > > > > diff --git a/net/core/sock.c b/net/core/sock.c
> > > > > > index fe87f9bd8f16..4bddd6f62e4f 100644
> > > > > > --- a/net/core/sock.c
> > > > > > +++ b/net/core/sock.c
> > > > > > @@ -905,6 +905,10 @@ int sock_set_timestamping(struct sock *sk,=
 int optname,
> > > > > >       if (val & ~SOF_TIMESTAMPING_MASK)
> > > > > >               return -EINVAL;
> > > > > >
> > > > > > +     if (val & SOF_TIMESTAMPING_TX_RECORD_MASK &&
> > > > > > +         !(val & SOF_TIMESTAMPING_SOFTWARE))
> > > > > > +             return -EINVAL;
> > > > > > +
> > > > >
> > > > > This breaks hardware timestamping
> > > >
> > > > Yes, and sorry about that. I'll fix this.
> > >
> > > As is I don't understand the purpose of this patch. Please do not
> > > just resubmit with a change, but explain the problem and suggested
> > > solution first.
> > >
> >
> > I will drop this patch because I just tested with my program in the
> > local machine and found there is one mistake I made about calculating
> > the diff between those two . Sorry for the noise.
> >
> > Well, I only need to send a V2 patch of patch [3/3] in the next few day=
s.
> >
> > BTW, please allow me to ask one question unrelated to this patch
> > again. I do wonder: if we batch the recv skbs from the errqueue when
> > calling tcp_recvmsg() -> inet_recv_error(), it could break users,
> > right?
>
> Analogous to __msg_zerocopy_callback with __msg_zerocopy_callback.
>
> Only here we cannot return range-based results and thus cannot just
> expand the range of the one outstanding notification.
>
> This would mean in ip(v6)_recv_error calling sock_dequeue_err_skb,
> sock_recv_timestamp and put_cmsg IP_RECVERR multiple times. And
> ip_cmsg_recv if needed.
>
> Existing applications do not have to expect multiple results per
> single recvmsg call. So enabling that unconditionally could break
> them.

Thanks for your explanation! I was unsure because I read some use
cases in github and txtimestamp.c, they can only handle one err skb at
one time.

>
> Adding this will require a new flag. An sk_tsflag is the obvious
> approach.
>
> Interpreting a MSG_* flag passed to recvmsg would be
> another option. If there is a bit that can be set with MSG_ERRQUEUE
> and cannot already be set currently. But I don't think that's the
> case. We allow all bits and ignore any undefined ones.

Do you feel it is necessary that we can implement this idea to
optimize it, saving 2 or 3 syscalls at most at one time? IIRC, it's
you who proposed that we can batch them when applying the tracepoints
mechanism after I gave a presentation at netconf :) It's really good.
That inspires me a lot and makes me keep wondering if we can do this
these days.

Since I've already finished the bpf for timestamping feature locally
which bypasses receiving skbs from errqueue, I believe it could be
helpful for those applications that still have tendency to use the
"traditional way" to trace.

What are your thoughts on this? If you agree, do you want to do this
on your own or allow me to give it a try?

Thanks,
Jason

