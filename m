Return-Path: <linux-kselftest+bounces-18665-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B82198AADD
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 19:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 869391F21971
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 17:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FC0195390;
	Mon, 30 Sep 2024 17:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEGQnz8V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7E6192D80;
	Mon, 30 Sep 2024 17:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727716461; cv=none; b=LidkV0RyRaE1TjkLxOEYXyJZhQmwbFoemQcddz+inyhVWARgYkEEkv1frMGYJxAFgOacDJOw5Qw9feo/tmTZGGzhwvYVWuRGJ+ks4ZVcPnaXdJ78HhbA6g2F5XHoqXeuNh+Z5wEEhRpIzIFdgyy4dslno8mro8qNgbgjVGhgj3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727716461; c=relaxed/simple;
	bh=kKghKHlQ0jgd8+BUzd3MdMlGMKLQ01g06pp6LQF6M2Y=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=nVaLFqtqtoJX8aFFylGDGgqyZ7M7Kp3DIknoaQNvJstGuN3QMr38/JQUe7kFYrPpu9UYFyjr2c1/tcO1A79oK+7eeA+Fti5hrZbT4rFcigcTXYRgxZ6jFnbARnBDXpYHSC6gcke67pyrKop21hJQnlcf4A3dKWk5IpvCN1Jkhjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QEGQnz8V; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-45830ff5b70so40049791cf.1;
        Mon, 30 Sep 2024 10:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727716458; x=1728321258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4hPCuBR7nkA6aFhxibE4wqn48mr0N3I8FBJ/geiPyzQ=;
        b=QEGQnz8VrPKl7Z5VkM3Wk3AZ3pEeHkX6IrcvblKoloqD/nX8d174+s9ToKeqTTUugF
         Crb0BI3sE2mbmKGAwV09HXMhBMz6zEpPiQRu0ocWmOzh+Coj9LeVUTngsJROc3qAw5Ti
         vcTH5W/MuZdPUX+9QROBd2VFwR4o0PO3btIQxVBEBqKR5OLkCRpjfHzAG9zmH5FJrjiQ
         3NCrsvDGSHp9CdLJ52ppHbCYilEDIb/yFlkMDMblEseHboDtxK1L+ljKV8WqioasoBcX
         +HJlvvesniJRru8/Ltc8aS0EkPTDaaW22Xo5jNFccMCWY0LmlgVtq0K/TWK5S/Jcu52d
         wfJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727716458; x=1728321258;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4hPCuBR7nkA6aFhxibE4wqn48mr0N3I8FBJ/geiPyzQ=;
        b=M2ul/P3ra/YQfe5Fe+lKsIQ1AY8oKO3vqstVbjXI2W+aRQ+Gj46hFhanl9JdqRUkZP
         9viz6P+gPODTNt7MxvaH+QoQZnICfLp1UxzUfU47NcfMd172jSBrEFkHbhqsL4Di9vHg
         Vt1ZRRghRfWoFCUxK3f0BWxTDV9VJuLiAv3YYoX9EBZZXVcXhYsCjP+A72o2xWqLZ1kS
         DEp5M8SD2GrOtHBryDQH8AH6XDUu8Xq6YpfPgwsPhTvJxMiIDXu7Jckd29F7HBUL5ONN
         wPR7NiGyx21NvTDuMQIXX5kA3XLHT9CxoPusMcNSkJjF4nEyYLbx7AAoOya3HojXLIoa
         tgyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVs8dGwhukKW2ivefht4ubzRWz3+tTHzEbCjD0yfCxErbkWv/dpOOmbZoyy00RQFr4Q45bCanQu@vger.kernel.org, AJvYcCX3THO9AHPLOY1J5WuEsjXBtmf3D13AX57H3o1vnU+K7qNdgUvDuLcu2QLJyB0OXhT67ERlPtSCkt9q+Xxz+fM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9J5Rc88oUc0/YvjvQEba6LJ/c8VP9FSUY/aoW70oPVH8vpK3k
	uYrPaF+aLZeMvIlLDnLUpeDihLvztG8Bja0vIIVFBKv+JTxH4Ivp
X-Google-Smtp-Source: AGHT+IGjULg6OtQyzfskzeIThEkcgll5i26RXGTbk0MyLpENgxMqDTMqPoq9vbb47Y2rEgTMQgHI3w==
X-Received: by 2002:a05:622a:1812:b0:458:3850:c7ad with SMTP id d75a77b69052e-45c9f2470c5mr220961551cf.25.1727716458340;
        Mon, 30 Sep 2024 10:14:18 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45c9f28c844sm37895091cf.10.2024.09.30.10.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 10:14:17 -0700 (PDT)
Date: Mon, 30 Sep 2024 13:14:17 -0400
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
Message-ID: <66fadc698746d_187400294a5@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAL+tcoBMXtQ_TbjKmO5CazL5zu1dDBBB+enckkM9+0ojF3qutQ@mail.gmail.com>
References: <20240930092416.80830-1-kerneljasonxing@gmail.com>
 <20240930092416.80830-2-kerneljasonxing@gmail.com>
 <66fa7fe46392e_17948d294bb@willemb.c.googlers.com.notmuch>
 <CAL+tcoC+VEs1UusEKKVhutw+e=uyEqoaBhRTUV1G4HakM3JVYQ@mail.gmail.com>
 <66fa904185c3_17cd892948a@willemb.c.googlers.com.notmuch>
 <CAL+tcoBMXtQ_TbjKmO5CazL5zu1dDBBB+enckkM9+0ojF3qutQ@mail.gmail.com>
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
> On Mon, Sep 30, 2024 at 7:49=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Jason Xing wrote:
> > > On Mon, Sep 30, 2024 at 6:39=E2=80=AFPM Willem de Bruijn
> > > <willemdebruijn.kernel@gmail.com> wrote:
> > > >
> > > > Jason Xing wrote:
> > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > >
> > > > > Even though this case is unlikely to happen, we have to avoid s=
uch
> > > > > a case occurring at an earlier point: the sk_rmem_alloc could g=
et
> > > > > increased because of inserting more and more skbs into the errq=
ueue
> > > > > when calling __skb_complete_tx_timestamp(). This bad case would=
 stop
> > > > > the socket transmitting soon.
> > > >
> > > > It is up to the application to read from the error queue frequent=
ly
> > > > enough and/or increase SO_RCVBUF.
> > >
> > > Sure thing. If we test it without setting SOF_TIMESTAMPING_SOFTWARE=
 on
> > > the loopback, it will soon stop. That's the reason why I tried to a=
dd
> > > the restriction just in case.
> >
> > I don't follow at all.
> >
> > That bit does not affect the core issue: that the application is not
> > clearing its error queue quickly enough.
> >
> > > >
> > > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > > ---
> > > > >  net/core/sock.c | 4 ++++
> > > > >  1 file changed, 4 insertions(+)
> > > > >
> > > > > diff --git a/net/core/sock.c b/net/core/sock.c
> > > > > index fe87f9bd8f16..4bddd6f62e4f 100644
> > > > > --- a/net/core/sock.c
> > > > > +++ b/net/core/sock.c
> > > > > @@ -905,6 +905,10 @@ int sock_set_timestamping(struct sock *sk,=
 int optname,
> > > > >       if (val & ~SOF_TIMESTAMPING_MASK)
> > > > >               return -EINVAL;
> > > > >
> > > > > +     if (val & SOF_TIMESTAMPING_TX_RECORD_MASK &&
> > > > > +         !(val & SOF_TIMESTAMPING_SOFTWARE))
> > > > > +             return -EINVAL;
> > > > > +
> > > >
> > > > This breaks hardware timestamping
> > >
> > > Yes, and sorry about that. I'll fix this.
> >
> > As is I don't understand the purpose of this patch. Please do not
> > just resubmit with a change, but explain the problem and suggested
> > solution first.
> >
> =

> I will drop this patch because I just tested with my program in the
> local machine and found there is one mistake I made about calculating
> the diff between those two . Sorry for the noise.
> =

> Well, I only need to send a V2 patch of patch [3/3] in the next few day=
s.
> =

> BTW, please allow me to ask one question unrelated to this patch
> again. I do wonder: if we batch the recv skbs from the errqueue when
> calling tcp_recvmsg() -> inet_recv_error(), it could break users,
> right?

Analogous to __msg_zerocopy_callback with __msg_zerocopy_callback.

Only here we cannot return range-based results and thus cannot just
expand the range of the one outstanding notification.

This would mean in ip(v6)_recv_error calling sock_dequeue_err_skb,
sock_recv_timestamp and put_cmsg IP_RECVERR multiple times. And
ip_cmsg_recv if needed.

Existing applications do not have to expect multiple results per
single recvmsg call. So enabling that unconditionally could break
them.

Adding this will require a new flag. An sk_tsflag is the obvious
approach.

Interpreting a MSG_* flag passed to recvmsg would be
another option. If there is a bit that can be set with MSG_ERRQUEUE
and cannot already be set currently. But I don't think that's the
case. We allow all bits and ignore any undefined ones.=

