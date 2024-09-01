Return-Path: <linux-kselftest+bounces-16894-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D091C967407
	for <lists+linux-kselftest@lfdr.de>; Sun,  1 Sep 2024 02:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28BB3B21C6C
	for <lists+linux-kselftest@lfdr.de>; Sun,  1 Sep 2024 00:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8785F8469;
	Sun,  1 Sep 2024 00:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bfGesE53"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA4F1D1319;
	Sun,  1 Sep 2024 00:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725150815; cv=none; b=V5FTW/P39luEoyx9mIvrK8q3qMVx2o9mdbiOQZwsbRUHyRSPuxovBPnmOmM3ciL112KaeBPYFCJrNBKuhHJeBiwIJHqsIxEqY9t7GReYCkzGWfhKETQaFju47LnVtMxXy4R7HTLiespboVefeAbNCBFqJXY+HVHpuJUt43JhY3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725150815; c=relaxed/simple;
	bh=FIFYBB5d/DjVuL/KRdGWSSyy3J0ccWBnOJQj3l4eicU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CA9+dptaq0/PgSXsOoXWlmKU2ALbKiOW2KHLhKluq3ab8gX0UVtKs0LbX0Mq9OEAbFQl+TrckMCZFk9DWYr0NjwDKfusFJsbCTDBAHKS53qPjasgmLCsnq7JT0M2Bp2KQ3C5l4vD1vbk7x8QeoeKG+nj4NlrlZ6+rOm3cYH6WkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bfGesE53; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-39f49600297so4637615ab.1;
        Sat, 31 Aug 2024 17:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725150813; x=1725755613; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FIFYBB5d/DjVuL/KRdGWSSyy3J0ccWBnOJQj3l4eicU=;
        b=bfGesE53mk6Nmio2+CSPevZTo+cUdjCkKvvY9siloKi2//y26wM8yKFCdDQaA5ASjc
         S5mwo92VSdSE9RrlO8M6u+ncap2GJ95RyISj/eEs8coygpkP2eWHbuanUK2Vq34dvGM4
         5iDrENU2iCsrZZWv3Sesh8Ni5TysBQN7cCTH27q5iiSKcg1WZ1H66IAZ3SXEn9e+lo6e
         scT57ZJM1PadeSb+Tt/FhxIuFO1E+ufEDI9pwPsU1Iy0yLYRkqram1911duE5osv+TNx
         6zCC2DxwmiaBDBqZ3DEAVFnrcs17aTAHXKeeMUEgsakB0eBbWoWcbWMrPSOUvZ+Q61hQ
         FvRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725150813; x=1725755613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FIFYBB5d/DjVuL/KRdGWSSyy3J0ccWBnOJQj3l4eicU=;
        b=iwlriChbewBIt03FjflDCjlYVJ84y3vAgpcFkMe7qeTBJJIviMcukF2fUJY9Cx+WJJ
         GSLFlAnFMTo8C74gQymTqV8nQIQ2DPgPoS/ezZ7Gt5cJS12JCQspMg13FlbQhDyiBhcC
         VwQgaOvKE7UekNm55veD+HBW8UNwhja3a9NARaFXdrMgJ4RSc4SlwYp3wQUW86zy0hPn
         ks6WTCwMRzv8DJXDV0w8NE290haUIZhGPpC+EL+p1hRDpEB4UHSnN7XHXo0AwdJERwP7
         MT5VEt8nyCEmiQ3A6cXSIpygrz2MIvI4XFpA2YyY6KM85/nUioDSD9IqOqtyYvzJPnGh
         8cbw==
X-Forwarded-Encrypted: i=1; AJvYcCVQwxvd8OEGy0PNbnH3W+zkSOHzgLou29tZb2UbGD6EVyOErmEIV6li5yZ8FbkpGDan6udYv4EzUtn0BklWOes=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQlzKs1vSRRQ8eWc+al+n3PQ+fv2UcGbQDmXDPBqMT7kVfv1fQ
	WKkXpiQYk+hTtvCLhPAg8HDBqOICLuW8zxM6C5EU0MltcdeHnHQz6FbCDcvdGU3Cqn/xHY7xQIY
	2k66ejrqz6Um5rE3skzpHOrTbfpk=
X-Google-Smtp-Source: AGHT+IGAuVE5H8OI7mCNt6Ix3Wwb302ZPbbpuB6ddxAUy0um/AJ7EiW+n5jRqTbA7bQ1iYSBEZht0P9U307WACvd+xE=
X-Received: by 2002:a05:6e02:b4e:b0:39d:514b:311a with SMTP id
 e9e14a558f8ab-39f379e39f5mr101626025ab.27.1725150813050; Sat, 31 Aug 2024
 17:33:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823211902.143210-1-jmaloy@redhat.com> <20240823211902.143210-3-jmaloy@redhat.com>
 <CAL+tcoCro6o5ZkhVJdKah9o2p=tPUSu06D0ZzNPPDB2Ns66kMw@mail.gmail.com> <9f4dd14d-fbe3-4c61-b04c-f0e6b8096d7b@redhat.com>
In-Reply-To: <9f4dd14d-fbe3-4c61-b04c-f0e6b8096d7b@redhat.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sun, 1 Sep 2024 08:32:57 +0800
Message-ID: <CAL+tcoC-CTaD-_68Nee+CoysJV7zYojqqgU8Y+Nq6RkQRuv=DA@mail.gmail.com>
Subject: Re: [PATCH 2/2] selftests: add selftest for tcp SO_PEEK_OFF support
To: Jon Maloy <jmaloy@redhat.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	davem@davemloft.net, kuba@kernel.org, passt-dev@passt.top, sbrivio@redhat.com, 
	lvivier@redhat.com, dgibson@redhat.com, eric.dumazet@gmail.com, 
	edumazet@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Jon,

On Tue, Aug 27, 2024 at 3:58=E2=80=AFAM Jon Maloy <jmaloy@redhat.com> wrote=
:
>
>
>
> On 2024-08-23 19:44, Jason Xing wrote:
> > Hello Jon,
> >
> > On Sat, Aug 24, 2024 at 5:19=E2=80=AFAM <jmaloy@redhat.com> wrote:
> >> From: Jon Maloy <jmaloy@redhat.com>
> >>
> >> We add a selftest to check that the new feature added in
> >> commit 05ea491641d3 ("tcp: add support for SO_PEEK_OFF socket option")
> >> works correctly.
> >>
> >> Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
> >> Tested-by: Stefano Brivio <sbrivio@redhat.com>
> >> Signed-off-by: Jon Maloy <jmaloy@redhat.com>
> > Thanks for working on this. Sorry that I just noticed I missed your
> > previous reply :(
> There is still the ditto UDP selftest to be done ;-)

The reason why I didn't respond at that time is because I was unsure
if I had enough time to finish it. Now it's time.

After digging into this, there will be a lot of duplicated code if I
write a new one named like "udp_so_peek_off". I think adjusting your
tcp_so_peek_off.c to complete the UDP part is just fine. Of course,
tcp_so_peek_off.c will be renamed :)

I will post one later to see if it's reasonable...

Thanks,
Jason

