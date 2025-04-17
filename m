Return-Path: <linux-kselftest+bounces-31042-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81CC4A91930
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 12:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EB0C176D9E
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 10:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF52229B15;
	Thu, 17 Apr 2025 10:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kltobh3t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377F6226548;
	Thu, 17 Apr 2025 10:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744885345; cv=none; b=FYMCHBZru6HhI/XbPk6llkk+Gubt1M+xWeNM4sFvVVL25/tMAl39UYduoRRPKIXm5NGAGBzhNHOLMSO1tDqbyJc7XLhnotCUL670Al3efmGvafsbMwm7REYUYyNvPCJy7kXGTIp8GwWx9Ngh65xY3zSnoKrTKA0t2rw03QHZYkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744885345; c=relaxed/simple;
	bh=lOZnhahR1qF67id5B9HuYwqG/y7ktGIPH28tUPNzM1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cM8H4Ar431J1GoGrXN90PQxXQgt4wYBrut/IWi+CqRYhGmmCe9J/NIFjMUwqntXlCnbJw8MPDKQiaGeV00LEacTb/WSzRa5GfgJ3GGqXjUcUgAQZZ71w1intrep6xje+yzzKcg13Ob4Kom78eQcMFQlObWXlHrTSX094aiuY/XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kltobh3t; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cfdc2c8c9so3033565e9.2;
        Thu, 17 Apr 2025 03:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744885342; x=1745490142; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=94xgRrxZzfco6rwsX1FtWa8VIcc+P9G8J4L4uRW1G4Y=;
        b=Kltobh3teZuyMoHVcvFabA119EhvoIcIR1SRhsPf2AdUzvq7NSnbcVf8K2WhMrpQGo
         xH675sHq0le70sHt0nnwoH4lBrFtCVss3EcXYEm8WlDeO3o6HsngiTFTTJOzHURQcx8z
         ia66W2ytnEVpjWuSJOUHZkzwSMLKVH+dRToz2uFDOOFxTjsXqR7rIrCXpSBkKSZRh+bi
         ofbefbKjgp6DG84AmPcdcRUiC65VGA8BmgX9UiFimfQko1T7/Wwd51DYRzWef8TEsFU3
         QqlGfq1XMvKx1GwJ7yM7X+20RRAJbcd8bE2BzHf+j27W6qu7wVAFnhnGbzOMBkfYM/95
         ZH9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744885342; x=1745490142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=94xgRrxZzfco6rwsX1FtWa8VIcc+P9G8J4L4uRW1G4Y=;
        b=ofH6KUwgbWhBe5qZW8tUqV30YEixzHx/5rog5z8Nor6UXvw7y5Prbaes2JapkSdzUs
         SRsrDINBskT8PKABme+pzAgxq078I4pMtQiLDurG6Cv6QHYU62WFR59jDpc+Z9ObsO29
         jM2R84ASjZfWErQDCrwu/XKqT1ESB1IB+Gz4k+cb440nmszTJW6SYyvUNeS+PZLlTSTF
         rnbCzaX1sN3RHwKvb9iIdt2k+BfzgpzL47T54v8ZD/QWfIJI8ksuYyp3GIn5SeWp2d0J
         eYy2BfxIxpKEGHtbj6hdFtSqiACdlD+TDmF9laTxce06HcAf6jNX9EfGinXLrIAJV0IS
         rZfw==
X-Forwarded-Encrypted: i=1; AJvYcCUPqVTZhJIfq9xOuxUPg53bIFUdcaP8kvSBEMHICtcIiRyFsPVEps5AX0yaDFL8ZQ4/LDY=@vger.kernel.org, AJvYcCXBaSI6kCZ6agjKIyn/S8JmW33fjTD8s1+QeCSlThVngdRyr203clkGpw3foWO1YCGCAaOTlvwrpF0NTaGY@vger.kernel.org, AJvYcCXOFNf/aftuvXod7CbfTc/JgDfIz8t8izSy5EjDJmr/8IyBUvEopSy1jBoQkADBiYuz+CacUMA6uB+QT1YzJg7P@vger.kernel.org
X-Gm-Message-State: AOJu0Yxeq/WXGQehnhZMnWqMY4xbwe30tYBPdSNvNTg5rP61GxgXd8ci
	IkYXEfNV4wG+FqmKjsIx34WpsSsC8Nzi7eaz17O2BXDGaYUHHKNpuaNxbRcpo9EwIUNuy1T+0IO
	w1c61WxFuwICvquILLToHopANBv4=
X-Gm-Gg: ASbGncs5JaLbS8zysPq2cBt+KjTSNlc64vYwTRRHYe6TClIvZ6MB5iulcA2KqvkjnZs
	krI1CVTocC20KlB2p+cOR3BNjC6wyLzGc5W+Dp1VzN93Bri2bDBNoC7niNjR1ZUA8ruoc//o9Iw
	9G4bXRHXZbQHsSQfdwm6aCf+/jBqECvMw=
X-Google-Smtp-Source: AGHT+IEVZVuvw+6SAoLcETlvCHCzKcOZP6+5K9puZGeBKqOZl9Bm+78d4Z0Dsrp0e0D4gUsIXxTIYe3nqkyFIDVeGmw=
X-Received: by 2002:a05:600c:384b:b0:43c:e7ae:4bcf with SMTP id
 5b1f17b1804b1-4405d5bdb1cmr59005025e9.0.1744885342186; Thu, 17 Apr 2025
 03:22:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250417013301.39228-1-jdamato@fastly.com> <20250417013301.39228-5-jdamato@fastly.com>
In-Reply-To: <20250417013301.39228-5-jdamato@fastly.com>
From: Xiao Liang <shaw.leon@gmail.com>
Date: Thu, 17 Apr 2025 18:21:44 +0800
X-Gm-Features: ATxdqUGKndy1THGdYPGuJgnpe6dwf0VhCThKzf1scaFa9uI7681XjBOugA0PgDE
Message-ID: <CABAhCOTU4xO1XL-LxkU6M8U94vKt_az00b=xL25iT742-puX8w@mail.gmail.com>
Subject: Re: [PATCH net-next v2 4/4] selftests: drv-net: Test that NAPI ID is non-zero
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, 
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 9:33=E2=80=AFAM Joe Damato <jdamato@fastly.com> wro=
te:
>
[...]
> diff --git a/tools/testing/selftests/drivers/net/napi_id.py b/tools/testi=
ng/selftests/drivers/net/napi_id.py
> new file mode 100755
> index 000000000000..aee6f90be49b
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/napi_id.py
> @@ -0,0 +1,24 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +
> +from lib.py import ksft_run, ksft_exit
> +from lib.py import ksft_eq, NetDrvEpEnv
> +from lib.py import bkg, cmd, rand_port, NetNSEnter
> +
> +def test_napi_id(cfg) -> None:
> +    port =3D rand_port()
> +    listen_cmd =3D f'{cfg.test_dir / "napi_id_helper"} {cfg.addr_v['4']}=
 {port}'
> +
> +    with bkg(listen_cmd, ksft_wait=3D3) as server:
> +        with NetNSEnter('net', '/proc/self/ns/'):
> +          cmd(f"echo a | socat - TCP:{cfg.addr_v['4']}:{port}", host=3Dc=
fg.remote, shell=3DTrue)

There's no need to reenter /proc/self/ns/net. And I think
passing `host=3Dcfg.remote` should be sufficient to run
the command in the other netns.

