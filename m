Return-Path: <linux-kselftest+bounces-48470-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F942D013EF
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 07:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 929F5301E168
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 06:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F6733A008;
	Thu,  8 Jan 2026 06:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5MElXyi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F023527CB35
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Jan 2026 06:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767853718; cv=none; b=U5nHn2A4exkim4Ejm8SaMAjVfrEoVcJVfV3iSwviV+aK541NE8Wi60NoTjIxIJYyklLIdN3S4jgCqOXTdJ8Yt+gGio5QuDeywr0otFekYSKM5/FNpzRrWL7P/YrjMdvoog3bhj2Oi6XXk/RSZCU6Zeu5GaoGs0A53nY/of92hwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767853718; c=relaxed/simple;
	bh=maWf8E4/nR6r4iZkfiudPX2lmDBux7LpubjWVpgYQew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NGBxl0+vOckaDjuPODtGBk0Ju6hFRoyInCEce6TnLNPOkmDKlCUL5cswGnSD7gr6Os7lZ8dGfoHf+jLuTIv5GALRdKy87nnYcDagSIGg+HJkFg52NfDVDX/tR8Gwpxom10RvAMOObxb0MGtSJcEXIarfSAshcgOVTmYVUyQo0t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G5MElXyi; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2abe15d8a4bso299209eec.0
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Jan 2026 22:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767853716; x=1768458516; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZuFRSJyxVGvc7rvYjVUrIZJ8+nTlCmoSPS+Ihaf2wKk=;
        b=G5MElXyiIlCGWGcZgS00L+iPZ06Q/jZui+ZzQ0H3zMi1Bo70cEIVAzGh15sSRxkQsM
         AKk0aXHBQZJhEz+hCbLHEyvmxA/00l+jO/J9Z7/tBbLYDOrB/c2LriEvMmVJCJPabgUK
         094OojlHbr7DDIduYwNfBMZmSUcQCAuBFGTK2GMUqi/uAVvuZDKIm4MDIorZKw25P4tb
         vAMOov5Y1/yTkveWnln8cO4ySv+JJ7W892Djer9XOM91ursmC492zrMgSALLj26QOmTu
         uwv40imPcVHxTcE52bN69TKwQrKxAooI1+oaV+8PBTYOps3cVlANP5n9p4IQ45sXt3Gb
         FZAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767853716; x=1768458516;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZuFRSJyxVGvc7rvYjVUrIZJ8+nTlCmoSPS+Ihaf2wKk=;
        b=ciKZ6A0Yv02MqFr3XAm2dFSzaCR9TXhf8d4ph50VRfCeqtNtCYesjKGeXKFY47OWjT
         VlziSRgH3b+nXoxsOeY9zuZPPtND2lSr3oij2xUIbYUCtRuR1CvDfGcF5jgFphoebcJg
         nn63O5HhlwdDPO9b1Z6VyEH4WAMZIva13Qkn+u1Mu0UlMmB2W0m68DgIWR9bvsfDA9v/
         s3zlptRf0rEVcZlBYf70dF/bzB5s9c4aMyntuXh/TRZgVdDoC9gB4DOoYWdPp2OhXAAC
         3Z9LgAn6pDzO4eRSMFDkixS5hb5HVURlFB/DbyzCbhWcPQfK1/to6VhOH3gaginCWuUz
         4UEw==
X-Forwarded-Encrypted: i=1; AJvYcCX7FkSj75Tdhek3ZHVLRqsHCUi9dp7zA7HbEnJLJkpjr/XgX87BPSKaRnvHCwHN3A+Wnv8C6NQSXxZImTzBMes=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL0va0NNGR+U0nnUeJcfCejDFIx4oQUKR1AbQpgTMVVZfw8+nb
	T7xTdmb+Lqld51gs02w4lJdltkh5jt/+WnExqIS6iLXEEIqt8lY25WtestF1tg==
X-Gm-Gg: AY/fxX55ifDlILRp3OVdM9QY/61aHYs8yBKPh8X8GYdyWTOV7x2y9dwk2t0TWp2ngT3
	SBoYlaB/wdKk7TEcAKwXQfbbIzsSRP5R/Ix6gYlU5rGM18noyILmfNJAN/3p2+FuK55jkS9blJ2
	WYSOUkkmiJBw/Dy5+lr5Dxc/XJ4igpM6HcYI17HK4B1ZMRX02D6waks7Pk5Hq9onahWOmIVUH9v
	wmKqWkpxqHFHArZGC8XB64qtlI67OeCYC1F9dXazsqKHkLVQxTRPmfWySwfAMPJ8uOnW9jKoxw/
	5lTHHcGMj3S69pra57Cw6JqnHp1XNz5YqUQmU9YuRCmeSU3RYda+x6rlRVXIeZABlscRTZbQtQh
	in8CofUHyAPKR0j+/zsSqlKTA3LP9trOUl0fXHGGCSlh/umG7DsrLRs2aPKV/pb4afV71qHrvU0
	rrKtxHY7Jxu50Uonz4PhURbD+jjgk67EsR/rU=
X-Google-Smtp-Source: AGHT+IHr+qha1eOTfp4wLQhnqwmJ68KneYOC7GXQfwKel51U3gavmvexU6VxrRyZtU0m6yrWXG1P3w==
X-Received: by 2002:a53:e239:0:b0:63f:ba88:e8e9 with SMTP id 956f58d0204a3-64716bd5e88mr3638566d50.43.1767847054268;
        Wed, 07 Jan 2026 20:37:34 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:53::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa6a4d00sm25981107b3.41.2026.01.07.20.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 20:37:33 -0800 (PST)
Date: Wed, 7 Jan 2026 20:37:32 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	David Ahern <dsahern@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Stanislav Fomichev <sdf@fomichev.me>, asml.silence@gmail.com,
	matttbe@kernel.org, skhawaja@google.com,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v8 0/5] net: devmem: improve cpu cost of RX
 token management
Message-ID: <aV80jCHD9PGaOr87@devvm11784.nha0.facebook.com>
References: <20260107-scratch-bobbyeshleman-devmem-tcp-token-upstream-v8-0-92c968631496@meta.com>
 <20260107193013.0984ab97@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260107193013.0984ab97@kernel.org>

On Wed, Jan 07, 2026 at 07:30:13PM -0800, Jakub Kicinski wrote:
> On Wed, 07 Jan 2026 16:57:34 -0800 Bobby Eshleman wrote:
> > This series improves the CPU cost of RX token management by adding an
> > attribute to NETDEV_CMD_BIND_RX that configures sockets using the
> > binding to avoid the xarray allocator and instead use a per-binding niov
> > array and a uref field in niov.
> 
> net/ipv4/tcp.c:2600:41: error: implicit declaration of function ‘net_devmem_dmabuf_binding_get’; did you mean ‘net_devmem_dmabuf_binding_put’? [-Wimplicit-function-declaration]
>  2600 |                                         net_devmem_dmabuf_binding_get(binding);
>       |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       |                                         net_devmem_dmabuf_binding_put
> -- 
> pw-bot: cr

I see that net_devmem_dmabuf_binding_get() is lacking a
stub for CONFIG_NET_DEVMEM=n ...

Just curious how pw works... is this a randconfig catch? I ask because
all of the build targets pass for this series (build_allmodconfig_warn,
build_clang, etc.. locally and on patchwork.kernel.org), and if there is
a config that pw uses that I'm missing in my local checks I'd like to
add it.

Best,
Bobby

