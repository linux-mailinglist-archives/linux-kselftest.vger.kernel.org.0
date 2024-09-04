Return-Path: <linux-kselftest+bounces-17184-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B5E96C9C1
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 23:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCB04285363
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 21:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E29F1547FF;
	Wed,  4 Sep 2024 21:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W5eaWPf0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C155782863;
	Wed,  4 Sep 2024 21:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725486611; cv=none; b=qu89tvCO8tUrlGYP86DHIMuJ6avmnUo2shU4V4oi5g8II67jggoLMCukpcYpBJwRympSBAkDC3b3kV59oxEu1861yGjQ4s13/pGX/tk7AjLbHe13weBh1g+VHcrRemxtVe2+7KChcgwWVkEQH5V3czIOxkE9K9ykTs3n63FL6yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725486611; c=relaxed/simple;
	bh=nTKZwNgZLuYfLAFgdYx75PBxVZtcptYHc3t2vvOSSMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i38Ln9DM1cfLn2mGYy1h8fNfnvQHJxWMm2bgbkDTdEoJg16N4h2XafuI37uR/leoZQZjNQBme5dE06ThHCyGVqB9OtlYv4HxXOLmIAnK5hLAjpnTMy9LrYYhVhaoWU640BT806GQQwqvJ5Zi4+jmAwEgOtMS0mAmpHleoXAi5z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W5eaWPf0; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-82a3022be9eso997539f.3;
        Wed, 04 Sep 2024 14:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725486609; x=1726091409; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zTvcTMjpvCrY5JhOpSVXGMnHho/+pmbr2tNU1xzqisE=;
        b=W5eaWPf0gRCmYn8KDrU1fanTHq69fYDrgtsn8EbNzRzkttl9FdqwAnX5oaXf1SGQe2
         nz+dhQMavg2QqCcLWvfwEVwKPiR6weiu6rXMin3VoCL3UWkdqMDb4S8AmERErpbfm3gp
         bBZrypAT63YbeDQ5p6gj/qoSuUcmFYuBCzH188yDacw6DBhwowK31JQtD2FNG909Gh98
         1BZUR7nub75g2VBsu4SguMSQfvrLj1C7eG9o9V2EQ+zrIPRb3Q2IdDNlxp7OJEMxqObF
         Ig7AiOKvtz45Kcvp3HKojTXPi+ujgsOAy0ffU2YH/O93E5A0Cw1gsPrinc3oPoVhc2Ai
         7Pvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725486609; x=1726091409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zTvcTMjpvCrY5JhOpSVXGMnHho/+pmbr2tNU1xzqisE=;
        b=F3qMEio1UpModeA8utId9Zfk8LrOvj8uocSOXsUF1aivGQWRkkWP3FyQkLSOWY7cF1
         21XqrUdo7b4szsTasDxmHZIhrhMs+rO6OF5AU/cNt+GXQDBkuGFX7GAcvDJMTJjLVLn7
         gYRfvdi1JXFjkYhNgacQjrQwkcWlM1ua0z2ieqTBH3WK+eJ54wDm1+h33++10CtOjlI/
         olZSsFuPyfEmZf2Nit38ISqh9AcZRWOKb81/DcvqZuzAti4RTAfHs5L1CNnbMucJ+Wm9
         SD5qXHkK5sRXUBkCotWitOCOEDL+oOKg1W4k9yJrtlpjUz85unmdsG+4eqeNBAe/wrUF
         6ZZA==
X-Forwarded-Encrypted: i=1; AJvYcCVP8369uZ0ltgvw9TcSWKFVbU8wcTgQNp1yeX9GgAVafDvXFlETgOYJ9TgNxAj6+cZIAXg3ydNF@vger.kernel.org, AJvYcCVrgcOFLPhkW4ZweRye8eadYQmQ77lXm3hcZbvM5ZGsov0doJKPTS+UWH9FkBTeNJt7vjnFNpdnNJOB1/vNa8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRJlxq+xWXKWyE76O/hJCtnwnSDs1CjyKlgqpjRAwJJi5RxWop
	4T0Rq/0pGciUT05Novd1hxkF/MqUj7Usxx+OtkyWgCRDNgohv5PeTDbekAjFdde+EJCoiGT5QEX
	zs0Qqh6mWekGiJWKCtuBDEH75pDs=
X-Google-Smtp-Source: AGHT+IFM5n0PERKWyPDs5mBVGTLCdLeRABYj/A8byzK/i/sdWa3ZqvDxWNsVchjvo++qo+bDhiiMqmoBoxPPPSV7EkY=
X-Received: by 2002:a05:6e02:1a05:b0:39d:637f:97bc with SMTP id
 e9e14a558f8ab-39f4993f80emr195125145ab.0.1725486608552; Wed, 04 Sep 2024
 14:50:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904144446.41274-1-kerneljasonxing@gmail.com> <66d8ce15415ec_163d93294a2@willemb.c.googlers.com.notmuch>
In-Reply-To: <66d8ce15415ec_163d93294a2@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 5 Sep 2024 05:49:32 +0800
Message-ID: <CAL+tcoBhPiqSv1kZmyQRBi5KyNh5qyC7x2KENg+mHpY2D_wYYw@mail.gmail.com>
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

I was trying to say if someone writes a bug in the timestamping
feature, the selftest probably returns pass value instead of failure.

I will explicitly report the case I met.

>
> > In this selftest file, we respectively test three tx generation flags.
> > With the generation and report flag enabled, we expect that the timesta=
mp
> > must be returned to the userspace unless 1) generating the timestamp
> > fails, 2) reporting the timestamp fails. So we should test if the
> > timestamps can be read and parsed succuessfuly in txtimestamp.c, or
>
> typo: successfully

Will update it.

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

Thanks. Now I am learning :)

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

I see.

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

Right, It does make sense.

>
> But, can __recv_errmsg_cmsg now also be called when there truly is
> nothing on the error queue? It is a non-blocking read, after all.
>
> Judging from
>
>                 while (!recv_errmsg(fd)) {}
>
> The caller can. But if there is nothing waiting it returns -1 with
> EAGAIN:
>
>         ret =3D recvmsg(fd, &msg, MSG_ERRQUEUE);
>         if (ret =3D=3D -1 && errno !=3D EAGAIN)
>                 error(1, errno, "recvmsg");
>
> So long story short, subject to a few nits your patch sounds okay to
> me (but it's not entirely trivial that that is so: sharing so that you
> also double check, thanks).

Thanks for pointing out this one. I will rewrite this patch/patch
series tomorrow with your questions resolved.

Thanks,
Jason

