Return-Path: <linux-kselftest+bounces-21612-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B449C0890
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 15:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6B20283B12
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 14:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B4A21218E;
	Thu,  7 Nov 2024 14:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fk8kwpiP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB1328F1;
	Thu,  7 Nov 2024 14:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730988722; cv=none; b=sDbBDxKtHU5U2Mx2cpgkyz34L2vLGYxtx0OIcualDBLab2Mu3nIuTweJ5nSGdqzYs6lpTAqXpRcWgJ0WxFMkIY/Y6pW18Uwx64T8s0+tkR1dnKSRg3Akm/T2mowhCNaM5zAtTqMQWnKVvVgNSJ2ONekNrkHf2zHxO7AAbvIkXdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730988722; c=relaxed/simple;
	bh=uhbUtE9i1AyZBoS14bUm/Sz+IXR+OgXGcf4IyZU5vYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EPElYADhKDj0k87QyUg7OpJeGGvWj2knAaRq/oVtnQO9Z3yuSn1+CbAqPhcMY8Oy0nw1S+QDaDlXDibdY+PpRo933LQwGLFx50+PFMUPCJminrHUxjTRUeqH60fokJfHuxl06vu7zvCy9sw+KpqwniWwZ6yHtcSsUuqG7MImCQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fk8kwpiP; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37d6a2aa748so620730f8f.1;
        Thu, 07 Nov 2024 06:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730988719; x=1731593519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uhbUtE9i1AyZBoS14bUm/Sz+IXR+OgXGcf4IyZU5vYQ=;
        b=Fk8kwpiPC6MAV+tbVWJv8asz0H+lwNWkLRTykVDTTjeMhMHcL5FgaXqZB6CpOquucS
         9c7a31bKTJra/4nlltt6JZpGSb+a8veIWObuu7kM2fkG8YDEWtYBjQnJ87hQsuBrzS0S
         FKjA8w0ltff9FqcbxCmN9AfHYqw/jU6JLBfMq/dbp+rUg8Ut8bL3SFIaXRwHEiJmaYsH
         IJWEcK8iQZDI2PS+5akpEi5+oRraMYeStIXBwZKmL1SzF3OwAYPU+3TIM3J0L4FreeaU
         s/xArgnD4w4eqKBjtzyOlOyEOP5YHL4QPApr0oCwPWozhSmLa1ngY8fGamKEgEH0jOFr
         LHxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730988719; x=1731593519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uhbUtE9i1AyZBoS14bUm/Sz+IXR+OgXGcf4IyZU5vYQ=;
        b=r8zgNf24RFftqXmVbzUx/ahqPBTuU4S8qZdP3qSeYnlC2DZ280Heuouj/AhMVnNO/c
         oDE2hbVJLQlwU2Sip0Bkshngk2xwk/9gNmUXntmhXu0pmc/HLEeJ93YIDdh/C7BEljBv
         Ovvz5+QI4tTo+2KbaShlK2V5V6ldtCjZCRueuyPSwrz+oJ6sB59f1qhyA9nbd4erbrZy
         S2PQthSEtk/0fl4afGyNwbua4pgohOAGFNMWrDp8oiiGwJhUCTLRBsznskq2dds5vema
         gEeDY918rSFwCYac3MYdw/Iq0f1EL+QkbX6kyFyzicTVI+cWLEyxLez4HwXb6PFI/eUW
         sNaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWktucdx5jRJ2aUGZNlOdHGyDMev/ZR186x75+rSkstY4JRlQKWJ/NG+EtT3a+6kOZqRumAF5chxUVrtOAYnvg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTsYIIMlrTZ555nsjq6LnfTYnkl9uaE9/tDPFSLUtY6n+KikIN
	8pzi/O800utmaOeTHMyn2SaNnUHpyPavoySCNYJmAe0IZF+JadRjVc81ksBke53JBf1gS37marx
	0PpjYOHf2nQPyF7J5V981nXwHYs4=
X-Google-Smtp-Source: AGHT+IEXCGr4lM7xLIA8M7+HqoyUFdYEzQ3DCLnst6/U6/FQQrrnZXD3oAiWu1HQXkAPeiRSqXxq/yamqJYBwTeu18w=
X-Received: by 2002:a5d:64cc:0:b0:374:bd48:fae9 with SMTP id
 ffacd0b85a97d-381c7a4c99bmr19286392f8f.20.1730988719073; Thu, 07 Nov 2024
 06:11:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107133004.7469-1-shaw.leon@gmail.com> <20241107133004.7469-6-shaw.leon@gmail.com>
 <CANn89iLvC0H+eb1q1c9X6M1Cr296oLTWYyBhqTAyGW_BusHA_A@mail.gmail.com>
In-Reply-To: <CANn89iLvC0H+eb1q1c9X6M1Cr296oLTWYyBhqTAyGW_BusHA_A@mail.gmail.com>
From: Xiao Liang <shaw.leon@gmail.com>
Date: Thu, 7 Nov 2024 22:11:24 +0800
Message-ID: <CABAhCOS8WUqOsPCzQFcgeJbz-mkEV92OVXaH3E1tFe7=HRiuGg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 5/8] net: ip_gre: Add netns_atomic module parameter
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@nvidia.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>, 
	Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Jiri Pirko <jiri@resnulli.us>, Hangbin Liu <liuhangbin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 9:37=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Thu, Nov 7, 2024 at 2:30=E2=80=AFPM Xiao Liang <shaw.leon@gmail.com> w=
rote:
> >
> > If set to true, create device in target netns (when different from
> > link-netns) without netns change, and use current netns as link-netns
> > if not specified explicitly.
> >
>
> Sorry, module parameters are not going to fly.

Sorry, I didn't know that.

> Instead, add new rtnetlink attributes ?

It is to control driver behavior at rtnl_ops registration time. I
think rtnetlink
attributes are too late for that, maybe? Can't think of a way other than
module parameters or register separate ops. Any suggestions?

