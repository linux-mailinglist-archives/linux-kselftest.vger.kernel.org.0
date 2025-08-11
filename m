Return-Path: <linux-kselftest+bounces-38734-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 066C5B21991
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 01:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 152C617BE54
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 23:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F1A286D76;
	Mon, 11 Aug 2025 23:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="usiUfNJ3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F52A286D5D
	for <linux-kselftest@vger.kernel.org>; Mon, 11 Aug 2025 23:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754956368; cv=none; b=pHd0gsr0ZyzJReDSdtpaOgrBGj9KvFxXqCk1K0Gi7wy/h2Grx1QTbX4Ua5C6VaO3Dp/OifMKv1xHR1iNHnmcMdky2Wz0AU2RW5n85j3F+mgTR0Wu7uUPDNLNtgpSfsEDy2WJ1Of4f5PYFvS1m/MuzyiyqCbhpjIRyn/xUUEm0t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754956368; c=relaxed/simple;
	bh=LuLa11RQ9Ak3pIPyVTsNhZVG22TpH49u5jkTJNk34+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rpiva457oQWLmNei+5rGKXKdZ8kYoH74yYWA+vSnudfSuoOBFZw6hrYH+7G8+pGjk0ZRRW6aWxi3+uZyM24rFUjCs02/ylnQfQQMKiXyhjuueWoUlgIRciwvJlAzSYQIvtllRpTmq1vV5onZThUxR5ebzIgu8yRRwnsWY62sL8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=usiUfNJ3; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7425bd5a83aso4156138b3a.0
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Aug 2025 16:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1754956366; x=1755561166; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PLq6I+LvQ/j3G+FK4La2KdnSRJKMLfe2wH5rVFD3G/g=;
        b=usiUfNJ3p0z8hwXvb7aD0ShZEf3T5/U5ygofNM3DpvX5aJ59tvL4m5JBZsDEJuRPmq
         S9uJP7tKrs+Rdba9T0QsJSLJ453RXP5l+2PakoSIEciKxKoer7qE25mDQo7DGUhoVrXh
         IXiYgLskZHsHfSBMIlc57XeJRPb9b8BqBQ08tv9o6nUeX3aIZil99PxLYgxk/PnzdKuU
         GoGhI4LCZa4cZ5GGz5nQoeHnQyTRE0a3wgRTPp80DopiuFHuGcE3abrRk/mUoohdYZh3
         d4U+iBT1urR7N/XYk+pfJb5TFw7rHG2Ya8Evsjn2hQjsbJJ957zaLfaY29MLOa+bOR+x
         MFZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754956366; x=1755561166;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PLq6I+LvQ/j3G+FK4La2KdnSRJKMLfe2wH5rVFD3G/g=;
        b=PnrZFKejOw8D9GJIYvlyXChwayGrMYlaHUetPbkrQZpsL7PG0dF3lKkBoI3orH/DXt
         kQKPu5mrm41r4rmwkYLHka2TxnVpB0NoIoV8PQQgUNTgjLYFloxH9aNTPsTIUC0nPGO3
         N20kjm6QTzTO3oUyecIdgxTu/DROB8tMJNJWIxgYU6RO0LCQ2v5F1+mgiKy8e2VzsbOF
         x08HEFq6ksJzf3CP0QNWtX0oDnBJj60tY3ZCvGj+iV44stZYl+s+KAgMO74sTTCQ59qN
         6guJBcW6Fc+YQqIunl8prwrBIpv3+Oi9KOER9H+hC1ojXk2yAD4mK0R4Eqt0L9xE2/Y+
         wcmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxuVyqRWnyMqBFc8+zEv1cglx1joVJ3ZVW7Hh+Adg5xOORp/v9PnBA2CzMwl3Ynqh3keG1eOpzO5uMIm6uqe4=@vger.kernel.org
X-Gm-Message-State: AOJu0YylhfkqDCZlap2WoRZyVn1atuoL8ZWi5MbUff/se6LSSmkl7L8D
	An2jGushOSbQCqi2+5ETyiYIuqeQQl/+Iz9koPA/jdsMW+b/4mz0d6IX4XXyt83OnjA=
X-Gm-Gg: ASbGnct1260pusfWjz91Liy8F/0i28xE3WAnHlVL3df8/0fmSUWFyT73RrmfsHViQ21
	Rzv9dpfiP/0ToYMTB8zxsG8RqViu1jUic6VUiOFFNe85zdbww4AH7qv4n2BsBjB7TwutUYxPPgi
	XGME7MOOY5JA1vVHokcU13KJ37fLiDII3tPwvTMAb4KCpWFsnjzxPxSdGA/PCJGiDM3wNeeT5gd
	zFd+3C+vhmynqMr0bCrnbyrTj01jnv4tNVyhBwEtEwhmFHS+kdASd5ycxH6ktA6MZBn2Xpa9pNm
	PKrYdpx1EzPuxZ64QFeAyHCPzYDhWEFwLZdBaLWU2MYTdFFUSe67fj4CVFlR+A99PXAuJzkz7hZ
	ofyfhvLHlBWnAQJJQh7W6fqybkITIYAPXcLmGA7GQrCvYcJZRiXo7KII8J937tMBZXGU=
X-Google-Smtp-Source: AGHT+IGgSzJ8+46VNOZXexlqYViBQQ0yPEQdQYjheVTYFx2jan9h9qwT1GQqTaqshNqjHKDQFZMH9g==
X-Received: by 2002:a17:903:2984:b0:234:ef42:5d65 with SMTP id d9443c01a7336-242c2257710mr232368915ad.52.1754956366570;
        Mon, 11 Aug 2025 16:52:46 -0700 (PDT)
Received: from MacBook-Air.local (c-73-222-201-58.hsd1.ca.comcast.net. [73.222.201.58])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-242fe07f5c0sm3552955ad.97.2025.08.11.16.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 16:52:46 -0700 (PDT)
Date: Mon, 11 Aug 2025 16:52:43 -0700
From: Joe Damato <joe@dama.to>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shuah@kernel.org, sdf@fomichev.me, almasrymina@google.com,
	noren@nvidia.com, linux-kselftest@vger.kernel.org,
	ap420073@gmail.com
Subject: Re: [PATCH net-next 1/5] selftests: drv-net: add configs for
 zerocopy Rx
Message-ID: <aJqCS3xqi6UXwsP6@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
	sdf@fomichev.me, almasrymina@google.com, noren@nvidia.com,
	linux-kselftest@vger.kernel.org, ap420073@gmail.com
References: <20250811231334.561137-1-kuba@kernel.org>
 <20250811231334.561137-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811231334.561137-2-kuba@kernel.org>

On Mon, Aug 11, 2025 at 04:13:30PM -0700, Jakub Kicinski wrote:
> Looks like neither IO_URING nor UDMABUF are enabled even tho
> iou-zcrx.py and devmem.py (respectively) need those.
> IO_URING gets enabled by default but UDMABUF is missing.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  tools/testing/selftests/drivers/net/hw/config | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/drivers/net/hw/config b/tools/testing/selftests/drivers/net/hw/config
> index 88ae719e6f8f..e8a06aa1471c 100644
> --- a/tools/testing/selftests/drivers/net/hw/config
> +++ b/tools/testing/selftests/drivers/net/hw/config
> @@ -1,5 +1,7 @@
> +CONFIG_IO_URING=y
>  CONFIG_IPV6=y
>  CONFIG_IPV6_GRE=y
>  CONFIG_NET_IPGRE=y
>  CONFIG_NET_IPGRE_DEMUX=y
> +CONFIG_UDMABUF=y
>  CONFIG_VXLAN=y

Reviewed-by: Joe Damato <joe@dama.to>

