Return-Path: <linux-kselftest+bounces-42001-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E20B8CA7D
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Sep 2025 16:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D000E624AF3
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Sep 2025 14:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627EE2FB97B;
	Sat, 20 Sep 2025 14:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WBh26vfu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873FB2FD7A5
	for <linux-kselftest@vger.kernel.org>; Sat, 20 Sep 2025 14:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758379338; cv=none; b=YD/CUpKohWEfR2tM7nNhywnJCVcLhoQOMCnEmyCLKXZh0f6Zc1cthfrhPZggYriZbh+/AvmjxzSJSuAk5CJMNiqJ+7bP99BGjhwvzzldEIxsIjrRKl/t9LhsCwEyRE03RPQ3tJLi0+yuaQKttXLwMzLbL2L8f5VsTyjYnWdI97c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758379338; c=relaxed/simple;
	bh=Usj+C0PegNI69LjXkoxW4n3D3nNnaTN61TPyqGGREUg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dkS8yxzYF0WSTi508O6tg+yQJBLo6aYb8TlfGfzPCyGItI3BDCaedvfZfGj39G0amq9859OBYNawaUmRV336ae0GGnZpbjt+1dvdC1IcAiBtdOm6yvHNPhFI2kw/MQAMynJt9KcyNxRkcnqG3ZXhtCLvX6jq9uAWkzNgrdJdoKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WBh26vfu; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3e9c5faa858so2715810f8f.3
        for <linux-kselftest@vger.kernel.org>; Sat, 20 Sep 2025 07:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758379335; x=1758984135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zEtvZFtGHRjuP+b5JrK4y2e0Le4iom+VLjgkoz3MMAI=;
        b=WBh26vfuPt1v7nUePPcsFH84PRSWsZRe01lfn30cpMtrepsl71yLYCLV+se2DVfnD2
         3kBlNEAQdErnoHHlmWYchDCqpeV1WrNmDizsfWReIMYSvZL7NicvIsUtpw96i8jQZ7qE
         o/Y70ZGKrM0vCd/Hlud7M84kweUA3x6dfKG6m5FMD0AfL0rlzsYCTvDBKdDdVNnPyM0f
         fw0h+/iH9LxW3p51Qaot0+K5noDp5q28cuEvXVRDIUTRTMoS8VzAB3kP2KtkbfjN8ZvS
         g31UsestdnSZAKkIgHcIIsi/mufkmwcLqPzkdj9jIGG2ChKnfylNm9TksgHuIlIhelig
         pOTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758379335; x=1758984135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zEtvZFtGHRjuP+b5JrK4y2e0Le4iom+VLjgkoz3MMAI=;
        b=NsWJgFgBC4Syc8gKRoYVlvOjYjoebUUvvUqvLcvrvqlqNWVNH8WNhipKpME2XrLH8e
         4GEYB3VSbpm0AQd/4WeEFaDv2lEivukXX8PIBoyqddNXX68AiH9BFnG/Uv+jGAk5EOSj
         ieRC2zrSOEmCv51C0484ESGt/5LQTF040Rc3GUS/NHduwl220IA4DT7LPTOAsiDfQusP
         WgYOyxlJk3kWqKcKTzo5lQ1K9ZdQ8x0/az86M+tSjyL8ZJCucmybtWg6PWqGGMNAJVUi
         nR+xF+DbVJPKJHFTCkJE8r5TFyVTNXL5V/bc16sHcKIdNv6/JNI1esd5S37pTv8fxakZ
         XT5g==
X-Forwarded-Encrypted: i=1; AJvYcCUbWriUdGoR4hYZw5IKbR9VXWbuGrhrW6sPlokonKk1rF453ydCJ8zumvGh8aihmP9CwLHRYOSTBZGbBGjMjCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIlNMdn/UNf+ex5j2aXAZPg9c38teTdtxRZOnEXQ2wcGEQSH2I
	8HwpaBdsN4WA9U+LpRM34qRNmuZRzC0Msg0WXZ8IvJvG/0O6qUuFbPhh
X-Gm-Gg: ASbGncvK4+9tB18joJbi00gRlgHWDJbUW8G6cmn1THqU6stRHBirpPK46sCcCM3akfl
	FhkS12p0ADctEWfVSsJ+i/2QM26J9vq0e1emE3bjKj5xELBOlWU6RD5zpn7pTNQ7saNiTHgIHEE
	YMqxoBWQ+rPUq1TnYRjWkqsBSa7LKa8XPy4F9+9ZBURVPRLQzHICIBX2UnHqJ8NFeodTEGnxphi
	A3Cja58dbsHY+vsp2XGJS0ehRCFKDDkkaw1XMPtzdk/PbAq2VesatrD8sVUZXPUeCURgH2JP5DJ
	QLkpKT2+QvEkyrpvthu/2mQr2MN6H/vttm+8WmHZpNWWJXvyDmTI2t802yI2D8Oyg9pQkzmT19+
	rDVqMnx2F4A2YJjp3+NCQtSPTG/EDZBNFvBoRREJbkhUsSPoSk9CEFWOCKDvCKOc90eoHhD8=
X-Google-Smtp-Source: AGHT+IE1XfrrZKs7jUn/HCTxExNiug3StteTdhLU8bG47WeeJj4XJHY17xNSaGVA8TgcYBm5il8CoA==
X-Received: by 2002:adf:8bc5:0:b0:3f0:9bf0:a37b with SMTP id ffacd0b85a97d-3f09bf0a4afmr3138635f8f.43.1758379334535;
        Sat, 20 Sep 2025 07:42:14 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f6695a9dsm132985055e9.24.2025.09.20.07.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 07:42:14 -0700 (PDT)
Date: Sat, 20 Sep 2025 15:42:12 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Nam Cao <namcao@linutronix.de>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
 <jack@suse.cz>, Shuah Khan <shuah@kernel.org>, Davidlohr Bueso
 <dave@stgolabs.net>, Soheil Hassas Yeganeh <soheil@google.com>, Khazhismel
 Kumykov <khazhy@google.com>, Willem de Bruijn <willemb@google.com>, Eric
 Dumazet <edumazet@google.com>, Jens Axboe <axboe@kernel.dk>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] eventpoll: Fix epoll_wait() report false negative
Message-ID: <20250920154212.70138da8@pumpkin>
In-Reply-To: <CAGudoHFLrkk_FBgFJ_ppr60ARSoJT7JLji4soLdKbrKBOxTR1Q@mail.gmail.com>
References: <cover.1752824628.git.namcao@linutronix.de>
	<43d64ad765e2c47e958f01246320359b11379466.1752824628.git.namcao@linutronix.de>
	<aflo53gea7i6cyy22avn7mqxb3xboakgjwnmj4bqmjp6oafejj@owgv35lly7zq>
	<87zfat19i7.fsf@yellow.woof>
	<CAGudoHFLrkk_FBgFJ_ppr60ARSoJT7JLji4soLdKbrKBOxTR1Q@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 17 Sep 2025 18:05:45 +0200
Mateusz Guzik <mjguzik@gmail.com> wrote:

> On Wed, Sep 17, 2025 at 3:41=E2=80=AFPM Nam Cao <namcao@linutronix.de> wr=
ote:
> > My question is whether the performance of epoll_wait() with zero
> > timeout is really that important that we have to complicate
> > things. If epoll_wait() with zero timeout is called repeatedly in a loop
> > but there is no event, I'm sure there will be measurabled performance
> > drop. But sane user would just use timeout in that case.
> >
> > epoll's data is protected by a lock. Therefore I think the most
> > straightforward solution is just taking the lock before reading the
> > data.
> > =20
>=20
> I have no idea what the original use case is. I see the author of the
> patch is cc'ed, so hopefully they will answer.
>=20
> > Lockless is hard to get right and may cause hard-to-debug problems. So
> > unless this performance drop somehow bothers someone, I would prefer
> > "keep it simple, stupid".
> > =20
>=20
> Well epoll is known to suffer from lock contention, so I would like to
> think the lockless games were motivated by a real-world need, but I'm
> not going peruse the history to find out.
>=20
> I can agree the current state concerning ep_events_available() is
> avoidably error prone and something(tm) should be done. fwiw the
> refcount thing is almost free on amd64, I have no idea how this pans
> out on arm64.

Atomic operations are anything but free....
They are likely to be a similar cost to an uncontested spinlock entry.

	David


