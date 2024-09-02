Return-Path: <linux-kselftest+bounces-16985-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0E3968B20
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 17:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27F311F23045
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 15:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9031A302B;
	Mon,  2 Sep 2024 15:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZVinsxe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1531A3026;
	Mon,  2 Sep 2024 15:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725291266; cv=none; b=QyGoeshrz1WNXd14/0tdW+tUsLWdfoVHLTxZMrGHfLjwX76QPe270Q+zj98J7nskL/wULEXm9jOMm+OlOhsuPN2sNfde8+0s1KYSZM5NT+7pCcqxGP8XDtWpz/mfVRK/plko+PRp76UXdhu7jg8v64vPDr9OUrKNb6N74lZtVjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725291266; c=relaxed/simple;
	bh=7rMbYapEXYVCo1Z3abOw0TAa9acU0xg7v3Vo9D1Y8+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ftbhdj/STlukZlDI4dNbyLYqDm6keuTXtHYTlG+1ecUpOf51V5HOZDUOK3+17bzM2j0Aq6lIr25yqh1RXcU/YmbxnTmC4ha8axja4f6kmNeF1e8aBo5GY01cJfM7KjgyDkL8Jof2eB1dCELwezXEhv9NOm79x26jlA3xhdrat/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZVinsxe; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-39f4766a939so11902395ab.0;
        Mon, 02 Sep 2024 08:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725291264; x=1725896064; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DxSjun1B4tFjhBYflpUpgDEJOT2ks/51DbIQnk7jJFc=;
        b=eZVinsxetWZT5EUWkQWRB6TkHCsJgnIfCHqfUQ0CJ+a3adf20eEmf+1wotNUkGe0gl
         urLp/qGUsQoonUcGMOBsgqVjoCzJYA7jrjBFd6ZbqWqqih8rsGlIP+uFJw8MvjQ4KhSE
         6+pMg39KKLLhym0tuOzyW/Tfb/RAsUr9v6uOEUU8XkkxJWH0QBwBTxFzaOAlxuktGdN0
         B1wU77irkRuLF0CQUPOdILdXieYzwToRw1Zx0nIwkwmsee8HsCbNd41VDOE9EkYUnRYl
         3AGK8P8KVlPGPBGfX8FmPVk+nfW17Rhduh31HZO2mno+0YYriurdOfBny8B5mq8T8Glw
         SOpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725291264; x=1725896064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DxSjun1B4tFjhBYflpUpgDEJOT2ks/51DbIQnk7jJFc=;
        b=DzwFfpPk33PuofD2oufqUgeWjVgdphuuQ6U48cm6RKIK/p2fZY37ZSLaA1OuyoY7Lf
         GFyUBq35DfsPy1SJ1BWytZXfVXLz8HqUta83P90bXZl3jv8jWS0CrSw+wgxOruK/I/z2
         dlCDnhEiB1xG4Eoo61iCVPQg5ux8JM9SP59VcdXJFr4v08m8CD97Sec5s1r7ZSo1VXxd
         TxNNkbjU+pKLv9WimqNCEPEUrZU2b+67+ctfKb/EVJ5ouwdzHg/vmO8jtmQthjkhjtHi
         nUKl2T2MwyEl1wb4USlI3AeVQ8rrhOaBNrk4QlLIx2/1QBSKbaTFIDIbJKHFPIaGpIcM
         4hlA==
X-Forwarded-Encrypted: i=1; AJvYcCUlaR2pCyaHxYVoWZYwBo2DBf/oJQCRuU0ijgY4bAY5w1qUyEIgfzeeE6+k2iPNV6ngECX0bkEoIZiI4mApuR4=@vger.kernel.org, AJvYcCW+D0GcroB4BJzrSmber/1TbV7WvxnNp2xBJ5XlUM7OpgHLJdnVakkeHTTflE4R5Xh5bojcm5tA@vger.kernel.org
X-Gm-Message-State: AOJu0YyesRGAZvoOH+ggcfRpw7a6n2mHhqr3yHzrNPgHbfjIaTUcPoiq
	FN7gC8clctgJe2mGZzmsuZT3jHZFJoXzDU/ZrMKThyhfGbtsxluBMiTuQiH8+pms1ADYaW3BWG6
	wyhYNK1+tQCsxqR/Rnn5Nr1JXdtg=
X-Google-Smtp-Source: AGHT+IEM3RjIsIIjjwBEskzmJuVc+5DHjOmYWscg9VOM+KXzS1+L1mug3vCsYQraNRwfRR/XTz85GUGGyQY5EjgzG0U=
X-Received: by 2002:a05:6e02:1a45:b0:375:ab93:5062 with SMTP id
 e9e14a558f8ab-39f377ce3aamr182800795ab.2.1725291263829; Mon, 02 Sep 2024
 08:34:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240901051821.94956-1-kerneljasonxing@gmail.com> <66d5d38c1d4b_61388294f0@willemb.c.googlers.com.notmuch>
In-Reply-To: <66d5d38c1d4b_61388294f0@willemb.c.googlers.com.notmuch>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 2 Sep 2024 23:33:47 +0800
Message-ID: <CAL+tcoDy4XNBTZK3_MwzS1Js0NPg1e46xTtHmpJNckLywJ6NQQ@mail.gmail.com>
Subject: Re: [PATCH net-next] selftests: add selftest for UDP SO_PEEK_OFF support
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, shuah@kernel.org, jmaloy@redhat.com, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 2, 2024 at 11:02=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > Add the SO_PEEK_OFF selftest for UDP. In this patch, I mainly do
> > three things:
> > 1. rename tcp_so_peek_off.c
> > 2. adjust for UDP protocol
> > 3. add selftests into it
> >
> > Suggested-by: Jon Maloy <jmaloy@redhat.com>
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
>
> A few minor comments. Nothing important.
>
> Subject to Stan's point about .gitignore:
>
> Reviewed-by: Willem de Bruijn <willemb@google.com>

Thanks for your review!

>
> > -int tcp_peek_offset_probe(sa_family_t af)
> > +int sk_peek_offset_probe(sa_family_t af, int proto)
> >  {
> > +     int type =3D (proto =3D=3D IPPROTO_TCP ? SOCK_STREAM : SOCK_DGRAM=
);
> >       int optv =3D 0;
> >       int ret =3D 0;
> >       int s;
> >
> > -     s =3D socket(af, SOCK_STREAM | SOCK_CLOEXEC, IPPROTO_TCP);
> > +     s =3D socket(af, type, proto);
>
> Removing the SOCK_CLOEXEC because not relevant to this single thread
> process, I suppose?

Yep. We don't need this one.

>
> Not important, but no need for proto, can just be 0.

You're right. I wonder if it is better if we explicitly pass the proto
here? I would like not to touch it here.

>
> >       if (s < 0) {
> >               ksft_perror("Temporary TCP socket creation failed");
> >       } else {
> >               if (!setsockopt(s, SOL_SOCKET, SO_PEEK_OFF, &optv, sizeof=
(int)))
> >                       ret =3D 1;
> >               else
> > -                     printf("%s does not support SO_PEEK_OFF\n", afstr=
(af));
> > +                     printf("%s does not support SO_PEEK_OFF\n", afstr=
(af, proto));
> >               close(s);
> >       }
> >       return ret;
> >  }
> >
> > -static void tcp_peek_offset_set(int s, int offset)
> > +static void sk_peek_offset_set(int s, int offset)
> >  {
> >       if (setsockopt(s, SOL_SOCKET, SO_PEEK_OFF, &offset, sizeof(offset=
)))
> >               ksft_perror("Failed to set SO_PEEK_OFF value\n");
> >  }
> >
> > -static int tcp_peek_offset_get(int s)
> > +static int sk_peek_offset_get(int s)
> >  {
> >       int offset;
> >       socklen_t len =3D sizeof(offset);
> > @@ -50,8 +54,9 @@ static int tcp_peek_offset_get(int s)
> >       return offset;
> >  }
> >
> > -static int tcp_peek_offset_test(sa_family_t af)
> > +static int sk_peek_offset_test(sa_family_t af, int proto)
> >  {
> > +     int type =3D (proto =3D=3D IPPROTO_TCP ? SOCK_STREAM : SOCK_DGRAM=
);
> >       union {
> >               struct sockaddr sa;
> >               struct sockaddr_in a4;
> > @@ -62,13 +67,13 @@ static int tcp_peek_offset_test(sa_family_t af)
> >       int recv_sock =3D 0;
> >       int offset =3D 0;
> >       ssize_t len;
> > -     char buf;
> > +     char buf[2];
> >
> >       memset(&a, 0, sizeof(a));
> >       a.sa.sa_family =3D af;
> >
> > -     s[0] =3D socket(af, SOCK_STREAM, IPPROTO_TCP);
> > -     s[1] =3D socket(af, SOCK_STREAM | SOCK_NONBLOCK, IPPROTO_TCP);
> > +     s[0] =3D recv_sock =3D socket(af, type, proto);
> > +     s[1] =3D socket(af, type, proto);
>
> Same

I think we don't need this one, either.
As we can see, there are already some existing test files without the
SOCK_NONBLOCK flag.

>
> >
> >       if (s[0] < 0 || s[1] < 0) {
> >               ksft_perror("Temporary socket creation failed\n");
> > @@ -82,76 +87,78 @@ static int tcp_peek_offset_test(sa_family_t af)
> >               ksft_perror("Temporary socket getsockname() failed\n");
> >               goto out;
> >       }
> > -     if (listen(s[0], 0) < 0) {
> > +     if (proto =3D=3D IPPROTO_TCP && listen(s[0], 0) < 0) {
> >               ksft_perror("Temporary socket listen() failed\n");
> >               goto out;
> >       }
> > -     if (connect(s[1], &a.sa, sizeof(a)) >=3D 0 || errno !=3D EINPROGR=
ESS) {
> > +     if (connect(s[1], &a.sa, sizeof(a))) {
> >               ksft_perror("Temporary socket connect() failed\n");
> >               goto out;
> >       }
>
> Changed due to the removal of SOCK_NONBLOCK above. Definitely
> simplifies the test.

Yep.

>
> Just note that error test is =3D=3D -1 or < 0, also for consistency with
> the rest of the file.

I will add "< 0" here as you said.

Thanks,
Jason

