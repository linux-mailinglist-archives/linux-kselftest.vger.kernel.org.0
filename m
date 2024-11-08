Return-Path: <linux-kselftest+bounces-21671-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E563B9C1C88
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 13:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 720CAB22F8D
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 12:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7EB1E3771;
	Fri,  8 Nov 2024 12:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fifikJCd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8B038DC8;
	Fri,  8 Nov 2024 12:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731067237; cv=none; b=NuWYE/LlSFOttuWMkrstU6vBYRfKXfZzQk/d3MjJx/yJQzVsB1yoPktIq2KwIwHs7pHpfxclN6zDm8EnuRMJgtEjKcievEdV0WPuA2anIxLZ/H/AqVPPWJ4LnFK5JN/I0+t61RcC71/qVA++f8lcc1qe+Q+p3aCjhTc/PutHk9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731067237; c=relaxed/simple;
	bh=LyRfhF/WSyeR9ZGoUYk/01qxuYXIAkx/uZAveWbdWi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IOBq/uwq3DcPxOSEqoW12TVituK/00VFA+cr9k0I7pTYkkzBQFzqOfzJIz2MTbyce3aEYT5BqTjrw3jIoeyX3ymVoshut9TbV9Z7d/Do2Urh3ONk8oAPN6ZcfZJ1LE5YSKU1yVj0l+r07KOYY51sNIT44npvjxULjcIKO0NZLIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fifikJCd; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5ebc0e13d25so848497eaf.1;
        Fri, 08 Nov 2024 04:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731067235; x=1731672035; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LyRfhF/WSyeR9ZGoUYk/01qxuYXIAkx/uZAveWbdWi0=;
        b=fifikJCddzR3jPkEA0Hmkt5QVvPwkFmhzyrTaPj3FwLWChhFo0/RXVgQXS0qxhVQyp
         htO1gpAYm7S39g0tMVJjxrFaEuoA06xMy2R7TuAL5mjOXiOJtH1G4SoSKhBX8Sun5XfC
         X+nNvkp5guGGyl6RKIW6q0qqqcSZwobX2odmOO6Yn3yjc01TRQ2neAQZghuVVyM02tzd
         dLIGjjp5sPh2m3qGyK28UctYZnXFvyW2Zgxc1JZqP4z7IP7fQ0QglB1HeSi6KIQfJgCZ
         h8GeNWtaXAF2tvvzmIrBGnv19y/PvHh9VmowRdDVV7JH17c9dGqlmbHaYa4u9DABD3VD
         2I2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731067235; x=1731672035;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LyRfhF/WSyeR9ZGoUYk/01qxuYXIAkx/uZAveWbdWi0=;
        b=BHSfzztyymFW3jxsHbYC2E++QponRS6gWXuzipgxVZix6aLE7SDJXWFvXRIdsHmReN
         BMfTsisLZS8+2EGVgGInd6+Mzrjak7SKdznSDcRMBJ98DhHZ6f2ooLrWMQtfxTmNse8l
         dyNr4rowfR6j/Si3sEWG4FCchtYVlLEcSFxZE/LTS65du7l7N+DN2gU6jv2ZYH6fdgjx
         MxlFzLTqHVYued7XTaY7qfIPXZ3chbABL2VXDlgpStf7G+w0ZS62Ig/9Td+AoeBIfBjh
         YEFFeaYFwKaaos+lDZzzs9bic+30VeVGU4wdzo4fM33PoIH1hMT8FqvonlpU4cbjdb53
         Cpmw==
X-Forwarded-Encrypted: i=1; AJvYcCUZvbOJERkP9WjP9W050wVQrKcAf57WODqoipPN2urcb3eCFddWL1dDaWgl7e1CV7xbWgKhWqyQ@vger.kernel.org, AJvYcCVgdkkKeN17dPKS9HrJA/yTo//DEUV9CIrNI0QkURqDX741k2nZ81fq2trrC/vWAn4ZaF/Jlp7kUvqEJM/1zao=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6YdDEy2bvnV1Pp+fumyVwQiH1zz9IpZjOBGVetfNTP1gYYfRk
	OTxNkTQYad81mAB8ls3VjkhT8Ush69tmv3gBMr3nh4Vi16DSRPqvu9yyKXs+E0pY78Dp8CuHCm1
	epSLi7YDSJCPDO3fMXMUWyDvhHu0=
X-Google-Smtp-Source: AGHT+IFQGKytSVO1y2YqYvZP5Kjl73UjnI6ujzlFaVWeeWZ74pwj2bqd3QbQtE50FSvkJRvYYBw1V+CgNBa5TrkA78A=
X-Received: by 2002:a05:6820:1f08:b0:5ee:74:4d35 with SMTP id
 006d021491bc7-5ee57bb6560mr2371166eaf.2.1731067234989; Fri, 08 Nov 2024
 04:00:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107133004.7469-1-shaw.leon@gmail.com> <20241107133004.7469-8-shaw.leon@gmail.com>
 <20241107080420.6a5a5243@kernel.org> <CAD4GDZwOzLQd+FYd0AHr5AUcANWkf731Jgu6aeyix8EjRGXRag@mail.gmail.com>
 <CABAhCOSvo4OemcevEnNmk3Jny_YEoCb3s9GPC6o217oj-t5FnQ@mail.gmail.com> <CAD4GDZx2hEjJWJknS+x++dwPE_UYGiCTYxj2Ntt6BaS=UGZqyA@mail.gmail.com>
In-Reply-To: <CAD4GDZx2hEjJWJknS+x++dwPE_UYGiCTYxj2Ntt6BaS=UGZqyA@mail.gmail.com>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Fri, 8 Nov 2024 12:00:23 +0000
Message-ID: <CAD4GDZzjcrMrnxW0BvtarkM08sV=61H52YZwKbY=QgN9Eqcc9g@mail.gmail.com>
Subject: Re: [PATCH net-next v2 7/8] tools/net/ynl: Add retry limit for async notification
To: Xiao Liang <shaw.leon@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Ido Schimmel <idosch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Jiri Pirko <jiri@resnulli.us>, 
	Hangbin Liu <liuhangbin@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 8 Nov 2024 at 10:04, Donald Hunter <donald.hunter@gmail.com> wrote:
>
> Jakub, is it okay to submit this as a single patch, or would you
> prefer me to actually revert 1bf70e6c3a53? (there's about 5 lines
> retained from the original patch).

I'll submit it as a series with a revert and a new patch. The patch is
much cleaner that way.

