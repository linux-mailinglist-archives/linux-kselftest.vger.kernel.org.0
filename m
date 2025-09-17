Return-Path: <linux-kselftest+bounces-41736-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C424CB80EA9
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 18:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D03356235BB
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 16:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B5F2FAC07;
	Wed, 17 Sep 2025 16:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pg9mz5oO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DF929ACEE
	for <linux-kselftest@vger.kernel.org>; Wed, 17 Sep 2025 16:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758125161; cv=none; b=dOCT2upuZQLh8kzOWkW5GFj8tbQpxrTG+Mn4F6/U+IWJVPuqd4usx7UO1khzpH1igjoUscxVxPI4b3N6mGxHNg9UOn03nLsPVXXiqDiGhfhcqG8m5QqleTqVuRGaDu72iDObAp5P+r47vFmjD0V/3jciM6gnhxa1EKsIzZzRoW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758125161; c=relaxed/simple;
	bh=rGzvhCSSZAHHlEpBZeE52UHASucCX8HP2pf4IkNCfN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sf1UiO85/mXqj6WJV0aa39e0zjRB3ddJD30tk8mFKdglg8Z93AqDCu8W0qo83QPDYw94Rmrwdi+Dl+i/DJuvsxzbIcaA8DuenlewcYNYfxYGae5Ee1H/T8La0YDJcoTAb4a/Bj/ymDvCYAorOElc6cnmD3jT5JJuC1NOGno7z2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pg9mz5oO; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-afcb7a16441so1043116566b.2
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Sep 2025 09:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758125158; x=1758729958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rGzvhCSSZAHHlEpBZeE52UHASucCX8HP2pf4IkNCfN0=;
        b=Pg9mz5oO17M4GNGPldc3IhFzUXqJWy9wSeR+MmlYeEbktn5ysWSNDU2u0AIFsN0Ljz
         Av0oVsifY04GhEcEzqh1lfFXvvUMnHjqmo3rKS8tNQUzhnE2iwdL1lZN/LJXzwbemiaa
         1mYBCF+28XvM56G5asW9dUzjcKKAIIlx6n+DasqmbqijROCigyjVcr7vT90u1Uci0w1H
         2TYfEb+jvGfmizkZwUHyXNr2fzzDeH7wsW245K1FTB8Uc4A4TLUQe5TGxH5MFzQGi5oH
         0nD/03MFop7QdnS4B94oqaG8ciUkcTlQUUrH2YJC1dMIYsSKlOIN/hv/IxpAWipUjqCc
         3BRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758125158; x=1758729958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rGzvhCSSZAHHlEpBZeE52UHASucCX8HP2pf4IkNCfN0=;
        b=LYug1VBuMeHH7TcKKA1zvsP9kqns+qhK6bCbNfsyRShovCccpm+35lw0eTltopwZDu
         lmHWABF+8euJ0LuwP70cSVHTL45oIqIVaR5xxwKickaXZwEPJrw1Pt1ykuduM4mFVL6v
         iM24+MYLLhBdpHZsfpSy6sevutGbDs6SMBbE0Mdx2BuP8Hb62lDBj8n1nbOKOZ0Ku0b+
         sbl8a29UyALm27nCLLX+xZ1ZIvZo8KRx8mFMkZV909D9jbGasSADjcg4Au+5yO2AULZ1
         pk6rxQMBQmismOniJf+7Jfmb1L/jy5HOPBUtTmXhYVJN5eXDLvn5a9n3IBvf+Tf4lD72
         iXJg==
X-Forwarded-Encrypted: i=1; AJvYcCXrhTobHrydE1+4aXg68yO+MwuGApqg9DmvTXzff9E+6U9bGH3cfplGQRC37kzbA+iLubMwZA/pSuspa/vvO0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YygJlBndT8WZH5/pSqBNWmiEdh/a4QacwC0x1SosTwVDZvGaYOZ
	sPmY/gWrziw7NLGOFL53PAPrE7tnmC52NO7L90Flr/ORRoz8ieP70RS9wJGdMaD1zO27FQZqCPG
	2tt8Kl+0R00blz+6xk8W3jkNLE1Clck0=
X-Gm-Gg: ASbGncttyCVIxn2YkCy51PlrPcRPIsb4p9OKb3NhXsGOKkwpPXI/T5zCYytKqwZCZcK
	MgZHbcKxeBmbbOoAo5Y2fkVVWIZWSEj6GEyNNvMlahcSSJkl6+IFCIkk9QTq+TWlIR1wos8hQ/Y
	JOZa2JxVuooz1DB/SLzf9s0HoG57Jk1O3+k4FDQynRMMpozprJXtzGVAmcwTQfaStpNyF4Y27Sa
	PcogP6eaYEGW3+iEbRmN6J1Iuz7B6oimybkFiQ=
X-Google-Smtp-Source: AGHT+IFYdSGvI+uA61yyZkwt50Ad23ev1FWqCOSE8kh6RNPVGA/Gis8pt6U0TfAHwkQbkeFce5QBPD3rY+N2cvqSbLg=
X-Received: by 2002:a17:907:c15:b0:b04:5b0a:5850 with SMTP id
 a640c23a62f3a-b1bbbe51dcbmr310348066b.40.1758125157798; Wed, 17 Sep 2025
 09:05:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1752824628.git.namcao@linutronix.de> <43d64ad765e2c47e958f01246320359b11379466.1752824628.git.namcao@linutronix.de>
 <aflo53gea7i6cyy22avn7mqxb3xboakgjwnmj4bqmjp6oafejj@owgv35lly7zq> <87zfat19i7.fsf@yellow.woof>
In-Reply-To: <87zfat19i7.fsf@yellow.woof>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 17 Sep 2025 18:05:45 +0200
X-Gm-Features: AS18NWCZPfFFjmQOs9cr5KbbP9wMx9RwhnFf7m9BDXKCe0S4-642QEnnMrWwHTY
Message-ID: <CAGudoHFLrkk_FBgFJ_ppr60ARSoJT7JLji4soLdKbrKBOxTR1Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] eventpoll: Fix epoll_wait() report false negative
To: Nam Cao <namcao@linutronix.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Shuah Khan <shuah@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, 
	Soheil Hassas Yeganeh <soheil@google.com>, Khazhismel Kumykov <khazhy@google.com>, 
	Willem de Bruijn <willemb@google.com>, Eric Dumazet <edumazet@google.com>, Jens Axboe <axboe@kernel.dk>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 3:41=E2=80=AFPM Nam Cao <namcao@linutronix.de> wrot=
e:
> My question is whether the performance of epoll_wait() with zero
> timeout is really that important that we have to complicate
> things. If epoll_wait() with zero timeout is called repeatedly in a loop
> but there is no event, I'm sure there will be measurabled performance
> drop. But sane user would just use timeout in that case.
>
> epoll's data is protected by a lock. Therefore I think the most
> straightforward solution is just taking the lock before reading the
> data.
>

I have no idea what the original use case is. I see the author of the
patch is cc'ed, so hopefully they will answer.

> Lockless is hard to get right and may cause hard-to-debug problems. So
> unless this performance drop somehow bothers someone, I would prefer
> "keep it simple, stupid".
>

Well epoll is known to suffer from lock contention, so I would like to
think the lockless games were motivated by a real-world need, but I'm
not going peruse the history to find out.

I can agree the current state concerning ep_events_available() is
avoidably error prone and something(tm) should be done. fwiw the
refcount thing is almost free on amd64, I have no idea how this pans
out on arm64.

