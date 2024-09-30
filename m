Return-Path: <linux-kselftest+bounces-18684-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE6A98ACAE
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 21:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 707D11C20B64
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 19:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D843E19925A;
	Mon, 30 Sep 2024 19:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1ckGOt5k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389D943AB0
	for <linux-kselftest@vger.kernel.org>; Mon, 30 Sep 2024 19:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727724007; cv=none; b=gPNrK14zPeSa0xl7HgulhkbWHnlx+Y+s9tGGKjGfSkcYS+YJ86So16sL/sTFK0b8etNAJrXx+uwoqgr5KEsduFdO2o/5oOfCeP5vKzH/PYTgW0a9j3uo57qbzv1gg2nCc2+vP3l5D+BxnO+itQBmzp40HzorFqjp2XYlJJtUDOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727724007; c=relaxed/simple;
	bh=mf+50EJUKH2G+VIDzDYloLY0NZqWPq0TA/VPI1bK4M4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WqJIL1ZVTQujNQN0HOv9kcis5k2zE/jEL+6OzjE66iQuxBwg9EEm/4VOuTdgu6eOWXfMQar9AeXS9Y+xVwnBYhsQP7EFA1tE7boWw+7IV8OWWyF/VetkIsfjbEhZ9Na0DLenEXc1UFpRlXfRIh7T+rOmUvUQAoSGQMknIci5QWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1ckGOt5k; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a8d446adf6eso817986066b.2
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Sep 2024 12:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727724004; x=1728328804; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BrMCWhLObLkAZVaSKoGWeeF5Ek4X8SnDW3CCgCMFgEA=;
        b=1ckGOt5kZkYmwZKA4U/IfHpEifQGKzYxBdFac6E4Soyb3CEGTTb9B8W5/bcWUh/xtH
         oMyyli+rz3LI8ffrSLrCJx9qm2PljXAKQ1xTU6izTIsvB7/sV88NhMvvkRqvzqRphu9m
         9dqAHMMeR39TBg/O8eD7fkaxWvdFPCSfEpyGRwS+wdvnWNaHGG9vYkrm00tEye7PkLji
         EWlszcXu/F7vF1u5ZkjQ9dFwiuuFm91m1ujpHogUy+gbJI4mn3yMWixMW1B4fTul2en1
         M/IwV3Wo6ItEPgaS+XShJ9mJxY//3mEysNhmhuciwJN6kZXwZ/YoCiZNEHkIqNhTIvZI
         PAZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727724004; x=1728328804;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BrMCWhLObLkAZVaSKoGWeeF5Ek4X8SnDW3CCgCMFgEA=;
        b=wQNZepkbjyHKHVpcgpjKqSDEtdsf654KmMboHK7RxndX1gxlbFPlQhncV2nAmYE4AL
         Cee2DLNv88WKK/ueLW7AbulmJUB5lu28P3CnjE+hN9n2cOnwCriZqSp8CQAbRNfolEvS
         sZ93uFtxSdjcu9WQjWom8rF6NI2CE/6lQiYhQUlVtDgCKfRGh2m+PCKPbv/eHJQFImMJ
         gKf0Y5vS8w3puotLfEbIXKfM+TxhUF+5D3QUc+Uz1KoKY0TAn8xGGh8/vGLXlHEhBHbZ
         5mEJZpn5sOrV5wHcukDydKcOCt7k7rFFu/v4Uyfqlrl9xZ7ZKcffJZ122bQo/1QzRySB
         D68w==
X-Forwarded-Encrypted: i=1; AJvYcCVEs9W8XhEeNPleL4XgUcIjJpF8PUewQmzxYYZFFsU3E54v36e6GbDsrOtxH8FzkmfoAayMVD2+GOv9ZEu31E0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN3zXdjx1h93zJnX7cCGZGCptUzwaybpUl6y9R+et0seBRl96l
	QRmb0mH+uSZw3GGsgAwln2H2BeBjZwTqO/ayZchBbVFpCuqa+e6KLdc4/TYdyAf6k6FTgG800On
	LjcTFg1/LyQA+2/axFR8Wf3GOHex+2hNBZnE=
X-Google-Smtp-Source: AGHT+IGizTcAYIYliVggPxLrC+q0pHsenv2ZJhGwlOaJPrMlP2ugO4F/m94+m8sBE8qNLzKDCDs8bOmnBbXVJ8w6SFE=
X-Received: by 2002:a17:907:3cb:b0:a93:d271:52aa with SMTP id
 a640c23a62f3a-a93d2715d83mr789764566b.52.1727724004344; Mon, 30 Sep 2024
 12:20:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <877cbz9x8t.ffs@tglx> <20240829153725.4437-1-gianf.trad@gmail.com> <54d1bcb6-b817-4ab5-be0e-aea34cfe0d5f@linuxfoundation.org>
In-Reply-To: <54d1bcb6-b817-4ab5-be0e-aea34cfe0d5f@linuxfoundation.org>
From: John Stultz <jstultz@google.com>
Date: Mon, 30 Sep 2024 12:19:52 -0700
Message-ID: <CANDhNCrzWz0=5az1a9_-rzCYo42ex0aNbXgdso9sx55BAEp_jg@mail.gmail.com>
Subject: Re: [PATCH] selftests: timers: improve timer_create failure message
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Gianfranco Trad <gianf.trad@gmail.com>, tglx@linutronix.de, sboyd@kernel.org, 
	anna-maria@linutronix.de, frederic@kernel.org, shuah@kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 11:49=E2=80=AFAM Shuah Khan <skhan@linuxfoundation.=
org> wrote:
>
> On 8/29/24 09:37, Gianfranco Trad wrote:
> > improve timer_create failure message with strerror() function
> > to give more information to the user.
> >
> > Signed-off-by: Gianfranco Trad <gianf.trad@gmail.com>
> > ---
> >   tools/testing/selftests/timers/alarmtimer-suspend.c | 5 +++--
> >   1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/testing/selftests/timers/alarmtimer-suspend.c b/tool=
s/testing/selftests/timers/alarmtimer-suspend.c
> > index ad52e608b88e..74acdb87d4f4 100644
> > --- a/tools/testing/selftests/timers/alarmtimer-suspend.c
> > +++ b/tools/testing/selftests/timers/alarmtimer-suspend.c
> > @@ -28,6 +28,7 @@
> >   #include <signal.h>
> >   #include <stdlib.h>
> >   #include <pthread.h>
> > +#include <errno.h>
> >   #include "../kselftest.h"
> >
> >   #define CLOCK_REALTIME                      0
> > @@ -142,8 +143,8 @@ int main(void)
> >
> >               alarmcount =3D 0;
> >               if (timer_create(alarm_clock_id, &se, &tm1) =3D=3D -1) {
> > -                     printf("timer_create failed, %s unsupported?\n",
> > -                                     clockstring(alarm_clock_id));
> > +                     printf("timer_create failed, %s unsupported?: %s\=
n",
> > +                                     clockstring(alarm_clock_id), stre=
rror(errno));
> >                       break;
> >               }
> >
>
> Jon, Does this look good to you? I can pick this up if you
> okay with this change.

No objection from me, sorry this slipped by me.

Acked-by: John Stultz <jstultz@google.com>

