Return-Path: <linux-kselftest+bounces-18621-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF54198A228
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 14:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8148A1F2382F
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 12:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC03618E03B;
	Mon, 30 Sep 2024 12:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hc+PwfI0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477C7126C07;
	Mon, 30 Sep 2024 12:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727698685; cv=none; b=oeNupfRvXHoxYFzqZI8jIuurxSeCBvvTD6TV+BcLc8Pxy+gEpQ6hwR+u3MglpqkQBAt8J8pJWnvuUZDy6/ODFbVnWOdlBTpzpfpVmxIOVCsa//mpX9BzcWktOM6UUwP5V082zii1DqbmOlgkq0V0Vasiep8yfad0y1kB1vcOc/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727698685; c=relaxed/simple;
	bh=nARtyQ3hnnf2/6HQgnQE4fXFmRnW83fu2o6KdmjKjRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jvW0OSKrTOE6VgSSNtk21DQFCkVpmjf5QGfV3cMicGtnQwUdrDmG29OqdGaUbmrwtA/5VKR3LxOGTNESrps+iJWKNg8mw4pNlmSqWQSqIEuXFFzmNJFxCrlXuVtK9Dx4KexVZPJkrMuIedtHPzaJgILLRzRd2RVPD28XC9yoNEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hc+PwfI0; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a1a412638fso18242915ab.1;
        Mon, 30 Sep 2024 05:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727698683; x=1728303483; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nARtyQ3hnnf2/6HQgnQE4fXFmRnW83fu2o6KdmjKjRE=;
        b=hc+PwfI05FjiJcbgDBdTYFrgSgOQEUEQZhSgxamcd4a9gHjD7CO/O+b7E1rrlY1eCK
         hQmDLFVgF8ICFDI0KfpP/vz4uS1gdO8O2vKf/idIW+Ii4ooHVVvSUhbWVw6PBdvyUp4Z
         yMhZf7pJjXloQ4ad5oXwAf9/GmEjK4YbuJzk6EPrFOKk0087E9WLIaWygdIYVqtJtC86
         IgL6iK1be72rSu+TVPoEuESAPdM8VmjcpTXf2xBhGKjTLx9E6BWw2+zG70VBlrmcc+xl
         JmceDYxm6zNS7YJ5ZqYzoaDk+TNtuDpbLdLfIqE9/G0Piu/ddbdVRdZ2PfK62BktPg1V
         yzVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727698683; x=1728303483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nARtyQ3hnnf2/6HQgnQE4fXFmRnW83fu2o6KdmjKjRE=;
        b=I4Cw99Wq8qTuQDbZ04vZR4j0oRV2whBlvvhLaAs8hiMY+iV1VQx8S1TYThMmYb3PHM
         Zk5JSTVLZW1RHsc0yB0SqQKgtqmKLLjG/hJ8MthP8IWpGfYQtXgDhKJuqejhQergiLnz
         /T9ZAznXtcTXbFODmkTLKTwqsz3QwwoAO7VCb36Y+ndNI9vN5M9780F8QonHkYT0s+Hq
         NanV+a1jVSf3SOHFJKehoV2mKqKOOSYtNp9sa4pA4jiE1Izj5uehXfH/JNs3FhN5OzDw
         12QVNNclNbYWAwW1SvD0eLsg45sVQv82vNzyxyexlJV53cvGEbuKvRsdp5b53ZcYsAg4
         BEdg==
X-Forwarded-Encrypted: i=1; AJvYcCVxMbrBNXclCHeUR6x8n6UPxPaKhAj+E1C7A2/MY+eBk04z4AyINx3B1FEdLDrhfb1bPS5Rw7Sl@vger.kernel.org, AJvYcCWm+QysrMqu2Cm76iyPjGzah6DU4G4DyBL3zEJv39aUV1lhstngP2QlyUWitQkn/A+t6AEVQJ6v+Lw87frtXJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8zQzjNiEtvxEUWczdzXdY6/nVMR7K6X+L3E/Lv94UdrOCcS0v
	P2NfuUKfWWcQOI8QeVab7LLlOQ2iXpH+1L+vtzVHJVlveckz0TyKWZsdAEeY/YNV/1Tl84RLGpP
	CaWYeelQ/8qY2S4afQkgG7JpeORY=
X-Google-Smtp-Source: AGHT+IEaaGr7Re3bIehKL9jHSLAfnQVSKDyD6kka44+n1NEG25X720Rccoi9gAeAbhfOLUHFFNqaj8cDfAPZ8VtYwX4=
X-Received: by 2002:a05:6e02:12ee:b0:3a3:445d:f711 with SMTP id
 e9e14a558f8ab-3a344fc8ff7mr122101905ab.0.1727698681990; Mon, 30 Sep 2024
 05:18:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930092416.80830-1-kerneljasonxing@gmail.com>
 <20240930092416.80830-3-kerneljasonxing@gmail.com> <66fa808374566_17948d2947c@willemb.c.googlers.com.notmuch>
 <CAL+tcoD+Xn0s01ZqfaTRcUOLU7HfLx06FcWKabTcenCXPnXoQQ@mail.gmail.com> <66fa91864f534_17d4532943a@willemb.c.googlers.com.notmuch>
In-Reply-To: <66fa91864f534_17d4532943a@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 30 Sep 2024 20:17:25 +0800
Message-ID: <CAL+tcoBD-pHjGPOY9-N94cbNTE=EX+2riUMSk+n-57rtyFPEQQ@mail.gmail.com>
Subject: Re: [PATCH net-next 2/3] net-timestamp: add OPT_ID_TCP test in selftests
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, shuah@kernel.org, willemb@google.com, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 7:54=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > On Mon, Sep 30, 2024 at 6:42=E2=80=AFPM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > Jason Xing wrote:
> > > > From: Jason Xing <kernelxing@tencent.com>
> > > >
> > > > Introduce a test for SOF_TIMESTAMPING_OPT_ID_TCP for TCP proto so
> > > > that we can get aware of whether using write_seq as an initial key
> > > > value works as expected.
> > >
> > > Does the test behave different with this flag set?
> > >
> >
> > Sorry, my mistake, the last email is not open to the mailing list. So
> > I copy that here.
> >
> > Not that much, only at the very beginning, this new test will use
> > write_seq directly.
>
> The kernel will act differently. But the test does not detect this.

No, it will not cover this.

>
> > I once thought and wondered if I need to setsockopt() when one or two
> > sendmsg() are already done, then we check the behaviour of subsequent
> > sendmsg() calls. Then I changed my mind because it's a bit complex. Do
> > you think it's a good way to test?
>
> Packetdrill is more suitable for deterministically testing such subtle
> differences.
>
> I have a packetdrill test for OPT_ID with and without OPT_ID_TCP. It
> is not public yet. As part of upstreaming our packetdrill tests, this
> will eventually also be available.

Good to hear that. Now I think I will drop this patch.

Thanks,
Jason

