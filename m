Return-Path: <linux-kselftest+bounces-30386-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A76A81927
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 01:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97DCE4A7927
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Apr 2025 23:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060ED2550B4;
	Tue,  8 Apr 2025 23:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FsbwV0Q8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421E74A21
	for <linux-kselftest@vger.kernel.org>; Tue,  8 Apr 2025 23:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744153858; cv=none; b=g/reN0Lkrz635GX1sw7bYx1vw8IP01Q0FPaIw0z/l//eEDpTRBnPhSSS4wFVAVEjV7XylnwpWEDdMsUMf6KLDIzyYsOdeRCHpKDLstPi1/SjcMss6iKazxOZpvkvRd2BwDsrzNko1KS8c2x7SXKulX35Tt1Sze9xiRaomqDkzpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744153858; c=relaxed/simple;
	bh=AmHad/9/i/5F/5p9sUG9/4/r8US4xLS3IaPYNjUKK50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CmpdMPpXSwAwUU7contIkzDFgpcgJCDDu+4c0N0tCClbmfb2CN+Wk9hqWgV6CfjPPjGhq8opKvmgTm7pGzBjHWdYe/PZIpdhwUF/W6Ax1ZBNPayHpUewUJ+4Sq8RHzSLattgcmCn4dwwUziKY9R68qU19X4sv/w0gYu21U/4uqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FsbwV0Q8; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43cfe808908so26035e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Apr 2025 16:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744153855; x=1744758655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p1FIuCowBhNP8eAFX/hLBNl3HpsjGHnEOZ9EDbTavv8=;
        b=FsbwV0Q8peCUjUhkIGz/zw8afkDHcQBMdqkpiIWRsNvqpKpSNA2mgtVPst1lJ3HNy4
         0eKrxjkrODmdFDk8hpJtvmcdvIt/M0fImXeHgLPTyNRrkj+c7GYrrw4BJi4f/ZIYhig8
         4i1FekgGMgllBa6A2abw6huv+mOFs29Sgk+FfNZFES+bTMmOUbxnqpQzKm8BjFdxpXPL
         IrQwlMHWjn/6yIuQsPJGTEBs7gxlLQrb5cXExnl9kLqrrsPCTKnR+hPSC0EHDpAM0gEu
         uyt5fixW1fyBbc3lDpZVtbrWiW/fHUJRWSKQlriQH7ulzzzF2qjxS3XgWXfix0nDi9Q/
         fKOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744153855; x=1744758655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p1FIuCowBhNP8eAFX/hLBNl3HpsjGHnEOZ9EDbTavv8=;
        b=PJwEkS//vcS4YpSqEh9MjKD3QWn3ebaQvXjoRxL4aiwaW1gw3YenBRV9JsAF2vE6lv
         K80+L+Ky8vppRZ8PK8sDrrWfExW/qQPzj2AYebX7A9nFVGqNc43HiOxRTO9i3db8jODC
         ImGi8FyI7Px+JZgGRF4+9FgfefwxqUWST7NzL4xSLjzS9r13gb0xo+SPugIO83PRLIvv
         /LnanZ6WkNI4oqXNPBDLZ4rlhptUcbGEJPLicoDBf6+kwrQOw3Db4Jnx/8elqp/KAhCS
         rtEFvd0/J4NLaFw7d9QcOkYkM5uKgCl3sPRebiFNGH4H9X0w9EYtSanW1Lie4szmKGeR
         /4Wg==
X-Forwarded-Encrypted: i=1; AJvYcCUiDYdtxM4h+tWJXarap8TaPuL6WQDrG6835uG3hggRNJyPHB3pPw0GFgT+gKUu344lRA6vp+0C00dTjwGz1us=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUap0QJxDAfeBhiBzJxLYXDr8mzCZzpsUPseDgPnA9eYmGg4oy
	quQlcWDqQfha1HE6SSwHjmL9WjVTjy9B3ohIKUPAYq2VBYVUdZqSNKoJHmR4IkSI9Dro6ekC8xU
	aMvmgpTeT6DMLLZojxg8IfWIkZmcMUQA1oWhA
X-Gm-Gg: ASbGncvncFWdZ6yzkxPWNlAW+XNMBXu1cr31D9LORYiPEXwu0F5ezvm/6NRAorTlZjW
	42boDkhDF+BLj/Ogj1t21GJ2kWpHVB+5MOAwL2l0m4zXjSsNG5MxIfnxiY+UmmGlfJ4tPdOtVzw
	B7MXG9EGYQYPJYe7zl6Af6CZZbB6KK2IsydS+Dtl3yuWhw698l7+mkuqrY
X-Google-Smtp-Source: AGHT+IHtmJsZweKCrbbqwaUHqVQ1I9oMcMfjxlUv4b9n4peqYq8L26ce4QJf6P66ACUUpyd7QK/r7U1/kKhWroPfCG8=
X-Received: by 2002:a05:600c:4306:b0:439:7fc2:c7ad with SMTP id
 5b1f17b1804b1-43f201a31bcmr166515e9.7.1744153855212; Tue, 08 Apr 2025
 16:10:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407225953.1540476-1-tjmercier@google.com> <803bf3ec-08ff-49c5-8bf1-1fa27f2477e7@linuxfoundation.org>
In-Reply-To: <803bf3ec-08ff-49c5-8bf1-1fa27f2477e7@linuxfoundation.org>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Tue, 8 Apr 2025 16:10:43 -0700
X-Gm-Features: ATxdqUG1OoE2CMkkaqsYCCXq5FVoSq_bvFdrW8lZVpZuUolfHdkXToOu7iRDnOA
Message-ID: <CABdmKX2ijnYtoJnSoXQOboNrsuyRvT6KoUqdD4koPBu4LtRy6g@mail.gmail.com>
Subject: Re: [PATCH] tests/pid_namespace: Add missing sys/mount.h
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Christian Brauner <brauner@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 3:48=E2=80=AFPM Shuah Khan <skhan@linuxfoundation.or=
g> wrote:
>
> On 4/7/25 16:59, T.J. Mercier wrote:
> > pid_max.c: In function =E2=80=98pid_max_cb=E2=80=99:
> > pid_max.c:42:15: error: implicit declaration of function =E2=80=98mount=
=E2=80=99
> >                                         [-Wimplicit-function-declaratio=
n]
> >     42 |         ret =3D mount("", "/", NULL, MS_PRIVATE | MS_REC, 0);
> >        |               ^~~~~
> > pid_max.c:42:36: error: =E2=80=98MS_PRIVATE=E2=80=99 undeclared (first =
use in this
> >                                    function); did you mean =E2=80=98MAP=
_PRIVATE=E2=80=99?
> >     42 |         ret =3D mount("", "/", NULL, MS_PRIVATE | MS_REC, 0);
> >        |                                    ^~~~~~~~~~
> >        |                                    MAP_PRIVATE
> > pid_max.c:42:49: error: =E2=80=98MS_REC=E2=80=99 undeclared (first use =
in this function)
> >     42 |         ret =3D mount("", "/", NULL, MS_PRIVATE | MS_REC, 0);
> >        |                                                 ^~~~~~
> > pid_max.c:48:9: error: implicit declaration of function =E2=80=98umount=
2=E2=80=99; did
> >                 you mean =E2=80=98SYS_umount2=E2=80=99? [-Wimplicit-fun=
ction-declaration]
> >     48 |         umount2("/proc", MNT_DETACH);
> >        |         ^~~~~~~
> >        |         SYS_umount2
> > pid_max.c:48:26: error: =E2=80=98MNT_DETACH=E2=80=99 undeclared (first =
use in this
> >                                                                 functio=
n)
> >     48 |         umount2("/proc", MNT_DETACH);
> >
> > Fixes: 615ab43b838b ("tests/pid_namespace: add pid_max tests")
> > Signed-off-by: T.J. Mercier <tjmercier@google.com>
>
> Change the short log to include the subsystem. Send v2 with this
> change.
>
> selftests: pid_namespace: Add missing sys/mount.h
>
> thanks,
> -- Shuah

Done, thanks!
https://lore.kernel.org/all/20250408230204.2775226-1-tjmercier@google.com/

