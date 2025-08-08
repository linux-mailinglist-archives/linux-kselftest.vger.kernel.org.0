Return-Path: <linux-kselftest+bounces-38560-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FFFB1E987
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 15:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC3121C21A22
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 13:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30E934CDD;
	Fri,  8 Aug 2025 13:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ccqf9tUZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F892E62C
	for <linux-kselftest@vger.kernel.org>; Fri,  8 Aug 2025 13:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754661081; cv=none; b=OHqEnEi9L/fPeJihSp358qOK1opTU3JVQldU7jhMK7iTKT36ChNhJoDpgeCiCGqyBvhiY3msmnDrvzYnA6l1LUD8KQjQJuiqkwFKrBpzWivzmPgNHjTioHr3Ad1uD0aMQ474vkRAucI2TOKkvAEc0+OC4cbDnEBHujoBQbiFvDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754661081; c=relaxed/simple;
	bh=BAhtq4iyWUS7La1XKDSXOM4qjgi0CnZG9tVABc5gxYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ObuaOQGwfuyEDbde0n0A88hfMSlhY7+px5JXkC89qDq1mug7cMaEVFiBSFXiz3tLnJ/W7qUbr/2hvsIsxC8jyqEg9M/rQkz6REF9pVui/+/lGSG1xxdQzS0cgCrQH6Se2RO8b6vTa0grwJqNa8fwIIlM61gZoJQK4W7CxfyvgtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ccqf9tUZ; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4b062b6d51aso25725481cf.2
        for <linux-kselftest@vger.kernel.org>; Fri, 08 Aug 2025 06:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754661078; x=1755265878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5l9uz2NI1yVWTJt793CCioTUXX+CH+IJmR8YdY9547Q=;
        b=ccqf9tUZyPGhE/h8YOEUK/5Jg5oDj+zjU1XUx6RywMyejOJYYl8on1eWcvlw3I+dvb
         HfNHccTX+IC+R1xu2waoVBxFIBqwM4NCtgCWMoGGfRUQX2owP3zkLPqjoUaOfo4OHJz/
         fJtGs4B+j4EfdYo3VosHfIKS6S+BXVYme9/YaBMazr6lxSQpHQaNie6hbCZ9Fey3oGPq
         Kp9L1S9fXue/mCfNHAf6K3RtfWqZj7Bj32quU5wnFCB/VcCqFgxTL2xF5/rFBTNIPYQc
         CndpiTusdXE05UsS5VaztzaO0cQtgJ1lX5zN8J9+7Usal6Byc7viUFbb0+y59gP5Fxc4
         ehDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754661078; x=1755265878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5l9uz2NI1yVWTJt793CCioTUXX+CH+IJmR8YdY9547Q=;
        b=mUCuQCVI+ZRskeTZAEJ7IbgWXmiQovvHwyFPmIgLQP4IAFlliLPhXR5XiranKJO7LR
         yzQss5fBdBIaOnB+o3sed52ACw7j3C33uWnjbp/Oc4uPykHk4733eWLMFvcPGfhg1oMa
         AuRnma6TCS1HevRMiKcIqEaWU9U36BuLi6b8ULR7t0Pjgyay8wkmVOT9MCRcEpVJMy0N
         Ad7OXwYKe8V8bzmw832sVG0Galyx7fWi4283Mte4XIUr3zfK3X6H+8sxfoVOWbDSI24U
         0EL/B+LGwVVCYB34dM7RnurHhIauOXtl6dl6wDhTs/nLOGWYKoljdGGGuBTAUOaGTGwl
         e28A==
X-Forwarded-Encrypted: i=1; AJvYcCX8ah/1FvxHuh6QEN9BFqKgc/Wf9JP2y4gCjDECjOt27z3mnbc6pJCT1veRDA91L+wYK3nTVV/JbjxZB4BcyRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4PKCS4u8MeK+JiQAsZf622F43piZ09rs02/zxmKJw6skM1+vC
	zGf5YMK96CSvWue9NuWtAxzysM21RC4WRHhSQBisuJDe/JMTW5E+eVW4pMK+mlj/BjqR43Y6xTk
	e4RVMANBSkNcdqZ1bBjpwo5rd2vV1JbzXSJahMAhP
X-Gm-Gg: ASbGncuaRjtqDQbZZLaM/b0APvDC+bNUAdyQMCxpodIsEGIKcTcVi8xgRG30srt4XXV
	Y6j8KO6QeNfP4btOI+OouclNITN17u/rKbCWlIrt/O3dIBC48k4TuRttSWQ4zNKJ4W+DEP1imxr
	AotPflEJtdmeLw6n3ksTnRCkXjqZBL5iixXv3t9csu99t2pikkEK5t9iDkY8TP9M6NQvWPcvhW0
	r+d+L50BMwSeN4=
X-Google-Smtp-Source: AGHT+IHGSFa9wyI3cw4nNDYNdZgINkSyownrv5FzJPe+iFwhAGAu5rIrp5XfGSvEtcDPhYFyasTyzrnIYVhwTmvWvcM=
X-Received: by 2002:a05:622a:5cd:b0:4ab:95a7:71d6 with SMTP id
 d75a77b69052e-4b0aee57eb5mr56199141cf.56.1754661077481; Fri, 08 Aug 2025
 06:51:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250806180510.3656677-1-kuba@kernel.org> <CANn89iKvW8jSrktWVd6g4m8qycp32-M=gFxwZRJ3LZi1h2Q80Q@mail.gmail.com>
 <20250806132034.55292365@kernel.org>
In-Reply-To: <20250806132034.55292365@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 8 Aug 2025 06:51:06 -0700
X-Gm-Features: Ac12FXyOEnG-NjwxUGxCSb-NEJLYi-7VAZhBj8UpMv0VU0UfM69ADbTNuFx-SXg
Message-ID: <CANn89iLbDQ2Le-7WU2dWvr3bc4J-Jcra-rX935Or4wRXDGVViw@mail.gmail.com>
Subject: Re: [PATCH net 1/2] tls: handle data disappearing from under the TLS ULP
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, borisp@nvidia.com, 
	john.fastabend@gmail.com, shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	sd@queasysnail.net, will@willsroot.io, savy@syst3mfailure.io
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 6, 2025 at 1:20=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Wed, 6 Aug 2025 11:35:28 -0700 Eric Dumazet wrote:
> > > TLS expects that it owns the receive queue of the TCP socket.
> > > This cannot be guaranteed in case the reader of the TCP socket
> > > entered before the TLS ULP was installed, or uses some non-standard
> > > read API (eg. zerocopy ones). Make sure that the TCP sequence
> > > numbers match between ->data_ready and ->recvmsg, otherwise
> > > don't trust the work that ->data_ready has done.
> > >
> > > Signed-off-by: William Liu <will@willsroot.io>
> > > Signed-off-by: Savino Dicanosa <savy@syst3mfailure.io>
> >
> > I presume you meant Reported-by tags ?
>
> Oops..
>
> > > Link: https://lore.kernel.org/tFjq_kf7sWIG3A7CrCg_egb8CVsT_gsmHAK0_wx=
DPJXfIzxFAMxqmLwp3MlU5EHiet0AwwJldaaFdgyHpeIUCS-3m3llsmRzp9xIOBR4lAI=3D@sys=
t3mfailure.io
> > > Fixes: 84c61fe1a75b ("tls: rx: do not use the standard strparser")
> > > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> > > ---
> > >  include/net/tls.h  |  1 +
> > >  net/tls/tls.h      |  2 +-
> > >  net/tls/tls_strp.c | 17 ++++++++++++++---
> > >  net/tls/tls_sw.c   |  3 ++-
> > >  4 files changed, 18 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/include/net/tls.h b/include/net/tls.h
> > > index 857340338b69..37344a39e4c9 100644
> > > --- a/include/net/tls.h
> > > +++ b/include/net/tls.h
> > > @@ -117,6 +117,7 @@ struct tls_strparser {
> > >         bool msg_ready;
> > >
> > >         struct strp_msg stm;
> > > +       u32 copied_seq;
> >
> > Can a 2^32 wrap occur eventually ?
>
> Hm, good point. Is it good enough if we also check it in data_ready?
> That way we should notice that someone is eating our data before
> the seq had a chance to wrap?

I could not understand what your suggestion was.

Perhaps store both copued_seq and tp->bytes_received and

check if (tp->bytes_received - strp->bytes_received) is smaller than 2^31 .

              if (unlikely(strp->copied_seq !=3D tp->copied_seq ||
                               (tp->bytes_received -
strp->bytes_received >=3D (1ULL < 31)) ||
                            WARN_ON(tcp_inq(strp->sk) < strp->stm.full_len)=
)) {

