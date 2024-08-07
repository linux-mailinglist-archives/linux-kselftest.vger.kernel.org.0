Return-Path: <linux-kselftest+bounces-14910-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89BCB949D1B
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 02:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4199A1F23F1D
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 00:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0FE1DFFC;
	Wed,  7 Aug 2024 00:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTOuHy+l"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6506210E6;
	Wed,  7 Aug 2024 00:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722991382; cv=none; b=Uix1bCjqjRTb5Zbu4aZvJsq5GsUNRGBWEIYEd86ZzeKJT8bRH7VYW2a1LFIviCMh6Zr66thix4jYnCAdag7BGcWM3owoVO6fMYkqilYFVprf6ouugS9fLPYWbNS/z8KBKDuYD5tEV5glii826LS8xxoBk0Uf7YCIYK0wTg1w91k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722991382; c=relaxed/simple;
	bh=THgrFxOvDXE+2v3n1CkA70MHFc1YG8taPAprp4UBcmg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oOxiUSEWrdlrvFnZplnr4+qWH5B2w6NAgV7tV/MQJ2acqPmx/MnF2vp9CTrfl2dxol4ko7uVleAtb40eido15xTM7JVm1NxlT96bRMk6jRTMIoWHZ2dfd5JMr2IJ4vi23TI1zqBwSGqe9i/xaZH140yonchS+YRssE+twq3mN3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JTOuHy+l; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2cb5b783c15so1042134a91.2;
        Tue, 06 Aug 2024 17:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722991380; x=1723596180; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WJcwAfk1mYx7VMxqvLgur/RPG+y57ybIEmXDFWr7wPg=;
        b=JTOuHy+ll3jqUmte2nDgbZmMOlRAkuIxmUDPPO/kqvuGcn+6evgovRglNA6Yavb1f6
         YTaVrpodxK4ObPbIf8l61+sAoEU9ajAuo+j8GTib8Smn1oaWL6eBPZ6xgiAAF4cXH9TD
         NppqakpSlkdZLD0+wgjCp2+0nDhwhqmwy3J3JiMeZaL3TR7G8W0e+mwVFJN8ym098IV8
         7Dju/Ya8Tr4OKtLSC3o+0ZlgXlAz6vHutD9ohjwJ2dAQbtmXXi6ikJ5Ge+BdxfYLBIqg
         r22eDokCykDv/9axQWNRiqySjh01Xz5d6q1oAPl2jA6x8AY2nfFWM6Uw3QkLm/b6c1oz
         g79g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722991380; x=1723596180;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WJcwAfk1mYx7VMxqvLgur/RPG+y57ybIEmXDFWr7wPg=;
        b=bp4tKTyO45H5uiINMP+uY38tu7WCUFCtZF+WBTQ/3NZ2jF3dGru4IY7UnhJRBAYFxm
         kBgzmRnslBIR7umCMqIM2GeCQG4tamejXMbqW98jvlPCV+trabZNVKbwp3PX3HNIT9+f
         2FoBlFS2a542wrFLuhwDqQMTSUcq3q9CO4Ph6WzmUeWzeJYcUggn0uCxPfH7nK5IHAC5
         t+RTQiUtCVRzqNHrpSPmeW+jEPZkstfEsWdEcyjkEvCDIyMkkxBa5OcKgON4LfIeb34y
         VZ7PiggbpLZ/x8SFVpZY5CuUKK10Pk24lDEkJfoYHn9nVZ67P/DOCgwQ174+n7WJ+a73
         nWVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUg9wyf3k40FJ6y2Qdc2QuVZZ//wyrzdhRpAjYED9o3L+RYVPprwiMRemUj+5dO1Gyhe1eUNkoGuUNlqgLI9bZG6mje0Xpc/hJljnIVUqlCIPJ9KZon99aG+GCcts3T+rxTdsjibNZcmbbfly/nf/rG2KIUckwkp9M4atcjsC+4k16RMPeF
X-Gm-Message-State: AOJu0YxqWSi3JOT8gZG+Ly6XF9z8GuowwICb3c7EDBS98hg68/O7Zl3G
	sNtk5mEghNN2pZ7KfWbzcOux9uDkHqdi1nKUUY4ehtFBc/jZke4yuiPdQrA5srvqOEgTpWAs9g9
	tDwmHNjVhHArRYJ5jnp/+m2Fy0rk=
X-Google-Smtp-Source: AGHT+IHi8HQXAvWLsYxB3+BDXqzWT1Lv71SGOy6GupXjbph3GLlx09ZXEKHByLZtysxDHHHsKnTl5gk/LR3EEbiYV6A=
X-Received: by 2002:a17:90a:7307:b0:2c9:6f06:8005 with SMTP id
 98e67ed59e1d1-2cff9524412mr18932455a91.26.1722991380498; Tue, 06 Aug 2024
 17:43:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802-tcp-ao-selftests-upd-6-12-v2-0-370c99358161@gmail.com>
 <20240802-tcp-ao-selftests-upd-6-12-v2-6-370c99358161@gmail.com> <20240804094751.GH2504122@kernel.org>
In-Reply-To: <20240804094751.GH2504122@kernel.org>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Wed, 7 Aug 2024 01:42:49 +0100
Message-ID: <CAJwJo6a4tEh2kX6dppyCWFrv3KwtaUkQBPK8uHFTqTsaweEJqg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 6/7] selftests/net: Synchronize client/server
 before counters checks
To: Simon Horman <horms@kernel.org>
Cc: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Mohammad Nassiri <mnassiri@ciena.com>, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 4 Aug 2024 at 10:47, Simon Horman <horms@kernel.org> wrote:
>
> On Fri, Aug 02, 2024 at 10:23:30AM +0100, Dmitry Safonov via B4 Relay wrote:
> > From: Dmitry Safonov <0x7f454c46@gmail.com>
> >
> > On tests that are expecting failure the timeout value is
> > TEST_RETRANSMIT_SEC == 1 second. Which is big enough for most of devices
> > under tests. But on a particularly slow machine/VM, 1 second might be
> > not enough for another thread to be scheduled and attempt to connect().
> > It is not a problem for tests that expect connect() to succeed as
> > the timeout value for them (TEST_TIMEOUT_SEC) is intentionally bigger.
> >
> > One obvious way to solve this would be to increase TEST_RETRANSMIT_SEC.
> > But as all tests would increase the timeouts, that's going to sum up.
> >
> > But here is less obvious way that keeps timeouts for expected connect()
> > failures low: just synchronize the two threads, which will assure that
> > before counter checks the other thread got a chance to run and timeout
> > on connect(). The expected increase of the related counter for listen()
> > socket will yet test the expected failure.
> >
> > Never happens on my machine, but I suppose the majority of netdev's
> > connect-deny-* flakes [1] are caused by this.
> >
> > Fixes:
>
> Hi Dmitry,
>
> I realise it probably wasn't intended to be a fixes tag,
> but it turns out to be an invalid one. Could you express this
> in a different way?

Sure, didn't intend to break someone parsing the tag, heh.

> > > # selftests: net/tcp_ao: connect-deny_ipv6
> > > # 1..21
> > > # # 462[lib/setup.c:243] rand seed 1720905426
> > > # TAP version 13
> > > # ok 1 Non-AO server + AO client
> > > # not ok 2 Non-AO server + AO client: TCPAOKeyNotFound counter did not increase: 0 <= 0
> > > # ok 3 AO server + Non-AO client
> > > # ok 4 AO server + Non-AO client: counter TCPAORequired increased 0 => 1
> > ...
> >
> > [1]: https://netdev-3.bots.linux.dev/vmksft-tcp-ao/results/681741/6-connect-deny-ipv6/stdout
> > Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>
>
> ...


Thanks,
             Dmitry

