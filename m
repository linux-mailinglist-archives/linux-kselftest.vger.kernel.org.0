Return-Path: <linux-kselftest+bounces-21658-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A6F9C168F
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 07:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F07D11F228B0
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Nov 2024 06:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93911CFEB0;
	Fri,  8 Nov 2024 06:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mNihol4T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BAA1CF7B1;
	Fri,  8 Nov 2024 06:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731048317; cv=none; b=ARGmUhl4VaMDKQdaugS3VUvY0/iWoDQuCHJ3/9vd1dMqPQVkvWDjK25yurR14Wy+P0bhr+bKTUqgViqcAWPyLpJikYIummG0u69nRCgORPzPqEDjABCXmz7Y+YyTAbqbbYsbup27ia6qCLEYuOZ/lcCCT+uoXLq/iNQ7aV62PE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731048317; c=relaxed/simple;
	bh=3twojJ5BunKyZY2Zya8PeRW8DN+uJqLzkli1KCsW3GY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XBbCXwqT6hZgRTj7Ci1J1q/hIT6pv6LM2Ad/2rf9rtqDUy63AKrGTr2DUpR8hIDoA4G47fkJcSKEGt0Dp+47PmMUjpBBOqRbsyAlnCe6V5fcN8ggnOt1J5n01FYfPXh0Gqo+9ZDaHo8TeuqVEqacumm1XWlVlNvJ1vooIIwmiiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mNihol4T; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37d6a2aa748so1073240f8f.1;
        Thu, 07 Nov 2024 22:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731048314; x=1731653114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nRC0OujsL3tfRd9bjfGRlrRVMYS63P+agBwF3Xz23C8=;
        b=mNihol4ToigJluIrfR6InRe3eypp6i8m/o0zuis5exphTP47kccHaWgRgQmoj0AskY
         DNb1CLMhoSCv5ar1U94lcd/1EKlWp6zn/bdltKAHyAkyRUg63Aw0OyCI4aWnSa7XgLB6
         XpfCyHL646o/UIWebyaH3BgxDIIiwghsPgQKuh32l4MzxyceOCMhubQ4FfPQdQVhc6KX
         B1XB9sKIBv7Evo6uM9amgblxj6DwxXZyOpHrAk0DxL2rk4kDBgnY/6LATtSlXUKDS0QC
         1cWgINvx3Dl1vqvbJ2gZp6mt+elmVfauAT8PaogVIrG/ksCfMvXsaSjpzdnRnJXtqetX
         kVDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731048314; x=1731653114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nRC0OujsL3tfRd9bjfGRlrRVMYS63P+agBwF3Xz23C8=;
        b=TCSyzS2DCIvOVta8zm5wO7PxH3JUH6c1iIQXfTXGMY1+Tq1kVRGJUgYdgvCox+gPLy
         ktgZq+KwRdo/rG70dCd772LfLlcioIn2V9+e88cBVfiHrRXCwP8uwBUYtFG+cy3W2xVD
         zqwX8OeFNxWIbe6azDdQE7AAcT1sdfovrN0aB2AOpvuRgi3MNCiOsotJGfhx0GhxA4ag
         YIlpw9Hz+5CshZj7Y/U/5MkAeGwCoqCqMBPNEoop29HE91bFITcoT9EUGfzm2ync7kDY
         EubVqVK9JZqyWDFHwdBAI1GYq6Nk//vPTRjp/0Sr90P4QMWjUkGS9agl2uG/EVsezrLE
         RZ7A==
X-Forwarded-Encrypted: i=1; AJvYcCUcTgaDELOxx6Mr5v6pBTpKwK+gDZBWBCQglO4JRhlmKqNOHhsk6J4+MoENsbEhf1rTUdasHn7+rkfJWb9mR6A=@vger.kernel.org, AJvYcCW27gGpotZaB9WFTLIwdjuRxShcPiECAWJQOXV5dleV40QIq8lYMk1m4ROLRClDj2lNq7s1nRB9@vger.kernel.org
X-Gm-Message-State: AOJu0YwrRwHUvBNEhVOKjDtm3z/ZhvLP1oB+MrTl7Ks6xTs2IIC7g9jz
	RBxZWCPN1Ufx/vZ+zZx/7NYWjQJMCBAberQiG5LcXJdGWkl41KPTlsql7o5ORq1BZlZxVrFpODa
	Vok088tjvqNg2WbVzF52n367cmmc=
X-Google-Smtp-Source: AGHT+IHCGvEMg37mLFTPnjYHHqnJxtAig9Up94JE3XMEEHF9HjeCGeiNZ9wm4Jsbn/hYGlzsjFMByBNs0IrZJzxaX5k=
X-Received: by 2002:a5d:5f52:0:b0:374:ca16:e09b with SMTP id
 ffacd0b85a97d-381f1863404mr1360391f8f.9.1731048314262; Thu, 07 Nov 2024
 22:45:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107133004.7469-1-shaw.leon@gmail.com> <20241107133004.7469-6-shaw.leon@gmail.com>
 <CANn89iLvC0H+eb1q1c9X6M1Cr296oLTWYyBhqTAyGW_BusHA_A@mail.gmail.com>
 <CABAhCOS8WUqOsPCzQFcgeJbz-mkEV92OVXaH3E1tFe7=HRiuGg@mail.gmail.com>
 <20241107075943.78bb160c@kernel.org> <CABAhCOSvhUZE_FE4xFsOimzVBQpQYLNk51uYNLw+46fibzfM2Q@mail.gmail.com>
 <20241107200410.4126cf52@kernel.org>
In-Reply-To: <20241107200410.4126cf52@kernel.org>
From: Xiao Liang <shaw.leon@gmail.com>
Date: Fri, 8 Nov 2024 14:44:37 +0800
Message-ID: <CABAhCOSyG6sTWfDfoYDCbiXesDbGiWYFrK4OGi+3zFgO-CZPxA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 5/8] net: ip_gre: Add netns_atomic module parameter
To: Jakub Kicinski <kuba@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@nvidia.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>, 
	Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Jiri Pirko <jiri@resnulli.us>, Hangbin Liu <liuhangbin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 12:04=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 8 Nov 2024 00:53:55 +0800 Xiao Liang wrote:
> > IMO, this is about driver capability, not about user requests.
>
> The bit is a driver capability, that's fine. But the question was how
> to achieve backward compatibility. A flag in user request shifts the
> responsibility of ensuring all services are compatible to whoever
> spawns the interfaces. Which will probably be some network management
> daemon.

OK. So I think we can change the driver capability indicator in rtnl_ops
to a tristate field, say, "linkns_support".
If it is
  - not supported, then keep the old behavior
  - supported (vlan, macvlan, etc.), then change to the new behavior
  - compat-mode (ip_tunnel), default to old behavior and can be changed
    via an IFLA flag.
Is this reasonable?

> > BTW, I didn't find what's going on with module parameters, is there
> > any documentation?
>
> Not sure if there is documentation, but module params are quite painful
> to work with. Main reason is that they are global and not namespace
> aware. Plus developers usually default to making them read only, which
> means they practically speaking have to be configured at boot.

Understood, thanks.

