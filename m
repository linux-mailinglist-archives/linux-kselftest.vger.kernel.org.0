Return-Path: <linux-kselftest+bounces-16998-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FD4968C56
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 18:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A5311F24E85
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Sep 2024 16:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806F61A304E;
	Mon,  2 Sep 2024 16:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khlsPMpN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022B613C67A;
	Mon,  2 Sep 2024 16:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725295550; cv=none; b=lfklnBM0EWykRvj36GEdFU61Ljyx2t2FXmo9GmCXhlA5xfibvL5sTiVYBKPb/nYons0ylYudGzBu0WXFsEYLVxVqjIpwrNVTRooeNk453479KBOYhSFcU4ww+5j9GN8YHYrXJ1Pd5jFWQ0uqtLcNH8rXo4uxV7YEODCeMqelnCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725295550; c=relaxed/simple;
	bh=lxgIHKkLerAKSvoZrvocGCfnbP9s3pOmvvsnq7TdUTI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=BjgmUqrwLdrWffngVHnzVB68ySKTP2vY10lBgdVV+Ng4X6yBDWoeC50pvNdGzy5u7Ui/XqXJULONCuxIKOvJyVpeDtequM9THDBbhOf3L8Z8E29L00GlJeVo1YUNXzWBEvGnVACJSxtWzKZ8ZsZdhP85sZqtGa7DbgiXB+MWkIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=khlsPMpN; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7a9782651bdso18281185a.1;
        Mon, 02 Sep 2024 09:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725295548; x=1725900348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=73K8+J42EH8WL1fVikCQ0QCInxeRcbM+5/Vk46MiNwo=;
        b=khlsPMpNecqJZHGv++Wg/aRA4N7c+VQ/6jj918gqKuKK7e39mAkZoRk2DYMIae44Et
         SztPuFMitzs5OqonpfyPCZGxZ2Mq6MEX/PnmKeJ1v5X73fzIhCHvb5PIEOxy/vu9xHjT
         cAlT1bYUc42uX7vGpO32vb3zVTVqIk3+4Y15LewzfqLfjovhnKvXxX/2Mf7eoQIKapu7
         pY6/G+pH/uGh1OuV5WO3XBfE7kDeDh93bSnbGhpZFWuXVLcxIrP74mK9LN26cpftaVMT
         TCkqq67OL3hKe0cDutorvpKfigzZgKW45Nm5weqnuIqUGPygp54ep5+ZuPsT5zJAV0Uo
         xLpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725295548; x=1725900348;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=73K8+J42EH8WL1fVikCQ0QCInxeRcbM+5/Vk46MiNwo=;
        b=HMZ8YM277Q/wShThJX21vHZQDH5qMLJV3xFEbtGESHX7qGVCxGrrGPgsLHjZFnoqxI
         /yQ2KUS63G4adDpCFbXMbwxdeXML/25ewLNCqPWNcgF3aRFnFOC8EOmY1uX6ANt3wgbY
         vB3Bm3W+OCQIkP+Uh5ytCcSi3Ddq2yTsuRmz+t8TMeIaKuyRdFWI4UpZOyfmCiliIfUG
         5YjqzkxODOm+ah38WbV+Rwc3kIBKzwKYkf+yLEqR2jklGxaxm71OtkNrNTxlVtn8vvAJ
         EassOhGpZRFXm/ruyPRm2BqQqIWQbyPQu7MHTuSTJFzZFHP9Z+NGj+V7/+1hyMgkkqix
         idbw==
X-Forwarded-Encrypted: i=1; AJvYcCUt/UE3IUXQxhoRzvUJum1Gcy+rXi5AM6wV2YgN/tu8D4QUFFJePob7XQPMWuRkvp+7v/gbsG/8JOM7UQbkm7Q=@vger.kernel.org, AJvYcCWM5zfPmy0l6hrspVHPXqXTehzHh89pzlxD91V/XC84RwN4UsNwrR3PhKurLXGkEFJxqKoF1217@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbzza4uqPKVZLlazNY7HcTY0saGhJQ+ZrykrbvefJVbJATisiR
	Q7JJPmwCMNha4S3q1/HuvWgw/3fUQeJD4GQhNIXAA/PtJmCKmyL6
X-Google-Smtp-Source: AGHT+IE7uraoJdKhSg/1tqCBJVmPBuguCKCI8d0tYQmX8Gaj2MPz9U8nZPuF9yXoCpDCKeBID8p8gg==
X-Received: by 2002:a05:620a:bc6:b0:795:e9cd:f5b8 with SMTP id af79cd13be357-7a804c7f1cdmr2580436385a.23.1725295547649;
        Mon, 02 Sep 2024 09:45:47 -0700 (PDT)
Received: from localhost (193.132.150.34.bc.googleusercontent.com. [34.150.132.193])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a806bf75e4sm433698685a.11.2024.09.02.09.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 09:45:47 -0700 (PDT)
Date: Mon, 02 Sep 2024 12:45:46 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 shuah@kernel.org, 
 jmaloy@redhat.com, 
 linux-kselftest@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>
Message-ID: <66d5ebbacf29c_67e67294e8@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAL+tcoDy4XNBTZK3_MwzS1Js0NPg1e46xTtHmpJNckLywJ6NQQ@mail.gmail.com>
References: <20240901051821.94956-1-kerneljasonxing@gmail.com>
 <66d5d38c1d4b_61388294f0@willemb.c.googlers.com.notmuch>
 <CAL+tcoDy4XNBTZK3_MwzS1Js0NPg1e46xTtHmpJNckLywJ6NQQ@mail.gmail.com>
Subject: Re: [PATCH net-next] selftests: add selftest for UDP SO_PEEK_OFF
 support
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
> On Mon, Sep 2, 2024 at 11:02=E2=80=AFPM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Jason Xing wrote:
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > Add the SO_PEEK_OFF selftest for UDP. In this patch, I mainly do
> > > three things:
> > > 1. rename tcp_so_peek_off.c
> > > 2. adjust for UDP protocol
> > > 3. add selftests into it
> > >
> > > Suggested-by: Jon Maloy <jmaloy@redhat.com>
> > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> >
> > A few minor comments. Nothing important.
> >
> > Subject to Stan's point about .gitignore:
> >
> > Reviewed-by: Willem de Bruijn <willemb@google.com>
> =

> Thanks for your review!
> =

> >
> > > -int tcp_peek_offset_probe(sa_family_t af)
> > > +int sk_peek_offset_probe(sa_family_t af, int proto)
> > >  {
> > > +     int type =3D (proto =3D=3D IPPROTO_TCP ? SOCK_STREAM : SOCK_D=
GRAM);
> > >       int optv =3D 0;
> > >       int ret =3D 0;
> > >       int s;
> > >
> > > -     s =3D socket(af, SOCK_STREAM | SOCK_CLOEXEC, IPPROTO_TCP);
> > > +     s =3D socket(af, type, proto);
> >
> > Removing the SOCK_CLOEXEC because not relevant to this single thread
> > process, I suppose?
> =

> Yep. We don't need this one.
> =

> >
> > Not important, but no need for proto, can just be 0.
> =

> You're right. I wonder if it is better if we explicitly pass the proto
> here? I would like not to touch it here.

It's not better or worse. Just not needed. So either way.
 =

