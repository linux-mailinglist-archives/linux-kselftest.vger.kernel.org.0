Return-Path: <linux-kselftest+bounces-38637-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7678B1F801
	for <lists+linux-kselftest@lfdr.de>; Sun, 10 Aug 2025 04:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C426817BE4D
	for <lists+linux-kselftest@lfdr.de>; Sun, 10 Aug 2025 02:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D67626ACB;
	Sun, 10 Aug 2025 02:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="qaIyKwLI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E4A1367
	for <linux-kselftest@vger.kernel.org>; Sun, 10 Aug 2025 02:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754791485; cv=none; b=SkJvyWzK0V48r7ZJI8znRMlhpo1mLNh01E7DI30e1h/iL+fNA6wHPd7PxE4x+I26DKeqDXvcu0VMXDQQZT79mGiBPgNvwuu+d3oHClzm5Gjec6FyW4DognhhxQeBrPII+okiFUqDc+jXoF3AUO5jfsCrLRA/TpfJ5aadgw7vjS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754791485; c=relaxed/simple;
	bh=5B9EcPlaYkNFgWW2w0IjOvRGR5xFsqb+684FjwZuIdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/x+NI2rl7Yo/pXflKNXPtLzKbgTtHU+/VuB5zKAc8BtQ4gJ767LQ8qVXTvpS0UlxHFg2CqXzXGN3AwOt2N0IZI+A4PNieB5K0t/A7q3Q3iRa0ZtOB8vqsUeg95haUEK63v3gOhb/dMWoWU/fvX6ooKbpyuY6ZtCq5zEdivgXwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=qaIyKwLI; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-76c3607d960so3556038b3a.1
        for <linux-kselftest@vger.kernel.org>; Sat, 09 Aug 2025 19:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1754791483; x=1755396283; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PpEDcR/rY+YXUvIHTjoMmFXmGhwOZhEhJLky7Dw6ZkA=;
        b=qaIyKwLIV9p9uK/AqsiUY2LWiLIoFnpGOyUbNIM2mY+5onKztlemdtQfwV/giuu0nk
         GTBFkn2l3j3pp3rzdqEXRplOlYvnwnaN45PuDpVnG8hqDmth9Qd/4b4PTt6q2NscuOzP
         OGNuwaOq1PO6V0P5078ERdHJoTHT+GvDhj5trAEgBv1CVjpWp6az9biNKEiik7SqkCvQ
         5tgaHq58RUv0eOyQtNI9xZQ1zSb33k/4tYpTUsUDie8iwrPPdxrp045MVmcl7sz9OOdx
         pG041gidt7jPmGkby+uUNuH8xnapuhEOyEn3nDMkrsnV+Ye+1dPtMZvA+YGV7h+zatA7
         kW7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754791483; x=1755396283;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PpEDcR/rY+YXUvIHTjoMmFXmGhwOZhEhJLky7Dw6ZkA=;
        b=JZexJ+v+Rw5w3CwpYjJV6666ZogJsKpxBnWE2qBj3wFf+YUvls7n12LAh9LZlSPugy
         Q3CNC0blwT6BQ6EY6fvLGuOjXJa9MZ371jMb/PQf0Pu6LF94HipIiQtZZG36W48LMVpf
         s1BY1Fu4+qv0VOoARCpjWVUUqoHrkX0GjO73tHrrQ342GuXGatHq/tqEqEyb2913D3rz
         YqD2jgpmcDSXBpiCbok7cW62V2QCxPLLrnEBZtatrEL9jvRKMQCmxCD46ZPu8uSqtHKe
         BM/A+77YKQe0AkOgzsnfigPRdmzTGe9yTKwLMhtmbtR9N1uF41TMIugSClrUNUp2WgGw
         L5Ag==
X-Forwarded-Encrypted: i=1; AJvYcCVmHNNeTB+1KCXz2/I3ew0XuCZX9EHw6K4v/jirDoJtkdpfMifJFqNz8kbelr+/X3OpASR9WIgauYY/ur6nkbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTibiTjv2EraZFOfjiVhYhuldOWobeguiz1l4/CA1wZy3514rV
	BFmLh1OUfcaetWONjBrmy0p43D2B/lRpixq7RxfabFhQSnJwmRGPjhu4C9ep5GsGZd8=
X-Gm-Gg: ASbGncuLuYmCY4h3yFwK2uq9qxFa/HinWG986g7fNe/JwwkSZnr5ukV+ysZZVIhHOPG
	HJEXNa6YqNNP5sZt733CTSjLxYP0+mTiNpLO5+yrO9aiFCFdc91k7mitiKJxSepvY0yhNPSeUau
	txoARgoagCy3mk6Spji/ZEI/A1xuz0KFStp270338/RWYo9oVKboUgIM0BzBmy6kQB3VdzL6MHL
	ywdtTVXopIz0k2Zejtay1dS5e++2vyIiaLBSp5epTmAUw9C7nv4qRMg0wOmzkwc7IIidh9WvxRp
	AZqg/adskafR0mHJraTpq1jWGIdG+gf6AuQvqPS3WeqXG2ayUMh73Z6zia4lpNjjInQCfyWeWMh
	CKX62NGbI49NEanUuQSfZfwOthac+mQfnWar4nU0Z3I1o1Py+1fxhHnaO+wr0808Oo/Y6dvPX
X-Google-Smtp-Source: AGHT+IH9l+G3vC9KcZ3JXNHknQZtzhkwAF36rtgqVKo/+BrNtn3ph8Wz2bBk6bfnDChBVuLFaLwxXQ==
X-Received: by 2002:a05:6a21:6d94:b0:240:1bdb:bed2 with SMTP id adf61e73a8af0-240551be2a1mr12886194637.32.1754791483437;
        Sat, 09 Aug 2025 19:04:43 -0700 (PDT)
Received: from MacBook-Air.local (c-73-222-201-58.hsd1.ca.comcast.net. [73.222.201.58])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bd7887522sm22372207b3a.20.2025.08.09.19.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Aug 2025 19:04:43 -0700 (PDT)
Date: Sat, 9 Aug 2025 19:04:40 -0700
From: Joe Damato <joe@dama.to>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	willemdebruijn.kernel@gmail.com, skhawaja@google.com,
	sdf@fomichev.me, shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net v2 2/3] net: update NAPI threaded config even for
 disabled NAPIs
Message-ID: <aJf-ONUg3AKXjcqV@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org,
	willemdebruijn.kernel@gmail.com, skhawaja@google.com,
	sdf@fomichev.me, shuah@kernel.org, linux-kselftest@vger.kernel.org
References: <20250809001205.1147153-1-kuba@kernel.org>
 <20250809001205.1147153-3-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250809001205.1147153-3-kuba@kernel.org>

On Fri, Aug 08, 2025 at 05:12:04PM -0700, Jakub Kicinski wrote:

> We chose not to have an "unset" state for threaded, and not to wipe
> the NAPI config clean when channels are explicitly disabled.

Yea... I wonder if we could change that now or if it's too late? I think this
is the thing you mentioned that I couldn't recall in my response to the cover
letter.

> This means the persistent config structs "exist" even when their NAPIs
> are not instantiated.
> 
> Differently put - the NAPI persistent state lives in the net_device
> (ncfg == struct napi_config):
> 
>     ,--- [napi 0] - [napi 1]
>  [dev]      |          |
>     `--- [ncfg 0] - [ncfg 1]
> 
> so say we a device with 2 queues but only 1 enabled:
> 
>     ,--- [napi 0]
>  [dev]      |
>     `--- [ncfg 0] - [ncfg 1]
> 
> now we set the device to threaded=1:
> 
>     ,---------- [napi 0 (thr:1)]
>  [dev(thr:1)]      |
>     `---------- [ncfg 0 (thr:1)] - [ncfg 1 (thr:?)]
> 
> Since [ncfg 1] was not attached to a NAPI during configuration we
> skipped it. If we create a NAPI for it later it will have the old
> setting (presumably disabled). One could argue if this is right
> or not "in principle", but it's definitely not how things worked
> before per-NAPI config..

Thanks for the detailed commit message. I agree that it should probably work
the same now.

> Fixes: 2677010e7793 ("Add support to set NAPI threaded for individual NAPI")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v2: add missing kdoc
> ---
>  include/linux/netdevice.h | 5 ++++-
>  net/core/dev.c            | 7 ++++++-
>  2 files changed, 10 insertions(+), 2 deletions(-)

Reviewed-by: Joe Damato <joe@dama.to>

