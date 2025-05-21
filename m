Return-Path: <linux-kselftest+bounces-33481-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB9AABFD29
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 21:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 155144E79AB
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 19:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB8A28F934;
	Wed, 21 May 2025 19:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pc/3Wx9i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E6028ECD4
	for <linux-kselftest@vger.kernel.org>; Wed, 21 May 2025 19:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747854545; cv=none; b=hMoGvKzjelVB4ypY1XyW7PGPS8JRJUPY4tAAgj8//AL7wYzM8Y9IBxcwj/WIbLsQ2+cnpnXYwFEXXWXIa6HAmxRLI2M3whMvLnYFwssmHajJzVlYDCvZIVSQqtgo6t3pJdzLdW5VmxRHOwGOpWbfTs57ANEJTbkv+dJfMzeOh7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747854545; c=relaxed/simple;
	bh=SJqs4V4Z4NrLdoa5NnRiq4ZO4scndXvarNLEsCzRCLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dzDTR6nvwcyw1ABlslt5PPO/QEoacVaglGIFlFkOierXpnCnOcf2ox2j/lZX8UwBI+DhmV6OougzAYA+Nt7AyVY9lNb8xa25ADQ8wnnpT7qI8T3XJZCYI0DEB9i2iy9siyklLDrGvMVaosmv89MOhmtE97G1NENImVsWhyknyB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pc/3Wx9i; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-231f6c0b692so824405ad.0
        for <linux-kselftest@vger.kernel.org>; Wed, 21 May 2025 12:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747854543; x=1748459343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rNrLNL//c/djngHHBKOCT2qv2jkA1BIgT8d0hjVFiq4=;
        b=pc/3Wx9iI1WFNA5zAipg6GqNp/CN26P5hRzmkbobNjblYRtKPyuV8kqChGvSpnGsqc
         Jw8P/MIhi3LybNjbkfvIhgiOSOlPwjfSpLFIQDzws9GEhGSSzS17zcPKl7/q/tEql5zp
         oC7LCD+FSSFRhbv3j4O5kQmdyqzxOmngnXVDEQoX5La9pjvVdzOALlxkxEGBIyEuxG/i
         UkJVyDxOCgxDcFhSmIzCeddnRTLrmDGNcYogw6h07eA0Mbv1LTDlUNOPI0Wr+TxZDewc
         g1Lx6EwRV5rTz0fnHFnXJnpkRxAJgM5VGohfWCPyz6w8omvoDm/ixWUiQNXKe38XvrHg
         AAMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747854543; x=1748459343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rNrLNL//c/djngHHBKOCT2qv2jkA1BIgT8d0hjVFiq4=;
        b=WHK7fohdQAT5ROQh5ohCvG7SPBE//ABAhBPVEeAghsoH+oTe21ebBQMcd9ug9oce3t
         8eoIvrfLwAw31r3DSKcO2ymfIcGPLD4CMU3CRU3HD/CtSEUVuLTDyX46ynSiRpvDulzH
         C1bGi6bhqhEHxCsiMGSb61ZbfuFfXCtACFztWleUQBYC19RV2uuQOeJI+nQBzGKzLU+8
         CgjXDCdQlHHHHwQ6q0Ju8xUdKMJS9aeVL/oODI+DBQbvEyPZYCvGWvo8b/vAtmHWGcET
         gQlk8PsPybY0CEv0sy+7Bpc7S1k45sImsS01JTP+WWqQT8zkeT7dAP0L7TtsEoVSFYwM
         wxag==
X-Forwarded-Encrypted: i=1; AJvYcCUUaRvgLrc6FohOJ9BkVqQ8XcBuVXd73yivli4Oqtia6Z6fYDQSRB4edUtfmYgXxwhRsvLZo8hKOuQby0VHYGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrZaQ9Nr5pKDp9PyX4r/Z3fokTPZnXPsLSWp2024buFjhVEF8z
	EDaIjbIwYBc7vsmdO6QNcjOOz223xQZHG69hjpqvIv2cnocmxv5/jt5hoVfIRKyrAKn54dhU8Zw
	dj01SO6+a/ZmDNAB2UpJrQqWlKt0lsdHShzG3CNhR
X-Gm-Gg: ASbGncugbYhEKMuSQmH51f6vk+Vg0n9lF9woYbulUp3Xu7Q9KPGb1VHdMjUGVGmPE9g
	BjAeIkUDq1gP0dm0F8xflPi8kXBvnYu4Wg1E2qqU8mcQOKETUh8XGq31NdqlW4I32mUw87CoKFs
	8HgNaf21TUzScr0DvebXxiicvWE90ihDlq1hviNWoPZ3EGLtTwTvQkzdG9zBTVb8Hm4gwcb8H29
	g==
X-Google-Smtp-Source: AGHT+IHE9roNm/GU1ecC3oih87HtHR/ezayJ8NjLlKTqpuVjFpk3YUrcUNBMyu0ZPHDkuWuY9KPXnxBmD9oaZYRvboQ=
X-Received: by 2002:a17:903:182:b0:231:e321:1230 with SMTP id
 d9443c01a7336-231ffd35651mr12736555ad.16.1747854542525; Wed, 21 May 2025
 12:09:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520203044.2689904-1-stfomichev@gmail.com>
 <20250520203044.2689904-2-stfomichev@gmail.com> <CAHS8izNwpgf3ks1C6SCqDhUPnR=mbo-AdE2kQ3yk4HK-tFUUhg@mail.gmail.com>
 <aC4PtKAt5QF655uZ@mini-arch>
In-Reply-To: <aC4PtKAt5QF655uZ@mini-arch>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 21 May 2025 12:08:49 -0700
X-Gm-Features: AX0GCFvoyRF1S3GC8su89a3s63DdRZ_anIDgkI-bbwVWk8TOV23U5DQe7iZ1qvc
Message-ID: <CAHS8izMUuS95ksQSKUQgTwFU-i5xh4dyGwHRavNRON_rS=9FrA@mail.gmail.com>
Subject: Re: [PATCH net-next 2/3] selftests: ncdevmem: make chunking optional
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, viro@zeniv.linux.org.uk, horms@kernel.org, 
	andrew+netdev@lunn.ch, shuah@kernel.org, sagi@grimberg.me, willemb@google.com, 
	asml.silence@gmail.com, jdamato@fastly.com, kaiyuanz@google.com, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 10:39=E2=80=AFAM Stanislav Fomichev
<stfomichev@gmail.com> wrote:
>
> On 05/21, Mina Almasry wrote:
> > On Tue, May 20, 2025 at 1:30=E2=80=AFPM Stanislav Fomichev <stfomichev@=
gmail.com> wrote:
> > >
> > > Add new -z argument to specify max IOV size. By default, use
> > > single large IOV.
> > >
> > > Signed-off-by: Stanislav Fomichev <stfomichev@gmail.com>
> > > ---
> > >  .../selftests/drivers/net/hw/ncdevmem.c       | 49 +++++++++++------=
--
> > >  1 file changed, 29 insertions(+), 20 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/drivers/net/hw/ncdevmem.c b/tool=
s/testing/selftests/drivers/net/hw/ncdevmem.c
> > > index ca723722a810..fc7ba7d71502 100644
> > > --- a/tools/testing/selftests/drivers/net/hw/ncdevmem.c
> > > +++ b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
> > > @@ -82,6 +82,9 @@
> > >  #define MSG_SOCK_DEVMEM 0x2000000
> > >  #endif
> > >
> > > +#define MAX_IOV 1024
> > > +
> > > +static size_t max_chunk;
> > >  static char *server_ip;
> > >  static char *client_ip;
> > >  static char *port;
> > > @@ -834,10 +837,10 @@ static int do_client(struct memory_buffer *mem)
> > >         struct sockaddr_in6 server_sin;
> > >         struct sockaddr_in6 client_sin;
> > >         struct ynl_sock *ys =3D NULL;
> > > +       struct iovec iov[MAX_IOV];
> > >         struct msghdr msg =3D {};
> > >         ssize_t line_size =3D 0;
> > >         struct cmsghdr *cmsg;
> > > -       struct iovec iov[2];
> > >         char *line =3D NULL;
> > >         unsigned long mid;
> > >         size_t len =3D 0;
> > > @@ -893,27 +896,29 @@ static int do_client(struct memory_buffer *mem)
> > >                 if (line_size < 0)
> > >                         break;
> > >
> > > -               mid =3D (line_size / 2) + 1;
> > > -
> > > -               iov[0].iov_base =3D (void *)1;
> > > -               iov[0].iov_len =3D mid;
> > > -               iov[1].iov_base =3D (void *)(mid + 2);
> > > -               iov[1].iov_len =3D line_size - mid;
> > > +               if (max_chunk) {
> > > +                       msg.msg_iovlen =3D
> > > +                               (line_size + max_chunk - 1) / max_chu=
nk;
> > > +                       if (msg.msg_iovlen > MAX_IOV)
> > > +                               error(1, 0,
> > > +                                     "can't partition %zd bytes into=
 maximum of %d chunks",
> > > +                                     line_size, MAX_IOV);
> > >
> > > -               provider->memcpy_to_device(mem, (size_t)iov[0].iov_ba=
se, line,
> > > -                                          iov[0].iov_len);
> > > -               provider->memcpy_to_device(mem, (size_t)iov[1].iov_ba=
se,
> > > -                                          line + iov[0].iov_len,
> > > -                                          iov[1].iov_len);
> > > +                       for (int i =3D 0; i < msg.msg_iovlen; i++) {
> > > +                               iov[i].iov_base =3D (void *)(i * max_=
chunk);
> > > +                               iov[i].iov_len =3D max_chunk;
> >
> > Isn't the last iov going to be truncated in the case where line_size
> > is not exactly divisible with max_chunk?
>
> I have this for the last iov entry:
>
>    iov[msg.msg_iovlen - 1].iov_len =3D
>            line_size - (msg.msg_iovlen - 1) * max_chunk;
>
> I think that should correctly adjust it to the remaining 1..max_chunk
> len?
>

Thanks, I missed that line.

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

