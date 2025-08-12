Return-Path: <linux-kselftest+bounces-38737-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 746A5B219AC
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 02:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CB467B3DD8
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Aug 2025 00:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156481F473C;
	Tue, 12 Aug 2025 00:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="aF+71G73"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4FE1DE4F6
	for <linux-kselftest@vger.kernel.org>; Tue, 12 Aug 2025 00:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754957235; cv=none; b=dlcBFyfECfzD5yosoOCn0er4oh8LzGUptfTTP5DjeHW2qdK7RHr38QWsZtKT1fy71AbkICGoBZnzbGZH0p3/oS8D2pZUgeXUmG+dLC4WK695+QPTZgNbnxNU26zFubfWoct2kKnMM1uHUHaUCVwZw2Mn/QByUCleFa6QxsdRlIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754957235; c=relaxed/simple;
	bh=JcSgJQ59yH0IPqCQ2lzDThjFVcjMFEEKe5mh0ALIIDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BMORK3FW+aRFeBBWk1apUVG0O1WlHoTrdMrGpwk0u/5jyyQEVj7VxuosiPYRoRxupDvLAztMJXiMZLjkv4EMFmtH+X9bAFlrZIOa7i+OVYFZcMYtfMxhPO/ev1bZBTIN09Ttl1153vbDetKUKIWd6nQ9be5jkjFENcLVivIvy4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=aF+71G73; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-315f6b20cf9so5928580a91.2
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Aug 2025 17:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1754957232; x=1755562032; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DqFUKsCtzRdN7XcvDwxDgMUVAASi1G418UR1zVxhIeQ=;
        b=aF+71G73SX2e7aIvoCE84/j+6EVFJw0K0JoWz083ABNL3IJRBUBX6aWmgCIznFIYn8
         GEy/imi42j06lNv9TWNUeulXwbAMy8E/FWf04/DSBrtzanI5cYDkzTJ/Q7NjHfFLw1Hi
         tujGDG163X2TKg3PcpXNzaz+qWf8S0P2oQK4IbHHFZMOf7fBsVNRvujFruMw5iVQPMhP
         24iwg4TvMKFCmbao6vI/PedqPM7s6/56EZ3X6mk8Thf/oElrkXSEMF4Lw6ZlWl9EF4sU
         sPuLaLAQhG/oQxy1Ogb38IXq6ZsrRzjmCA8Fmouvi4kIk/CAHtmkNA4aGfDlmkYr37vk
         jwyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754957232; x=1755562032;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DqFUKsCtzRdN7XcvDwxDgMUVAASi1G418UR1zVxhIeQ=;
        b=EPMxn8oArWG/JeZdx66Crd9ghSX0gNoahrYmLq50uMCHXe/5ygqBe6SA334WCvDgR/
         VNPfavO5GBg/1Z+kQhgYiI7NUP1Gj1hWlqSrNapz27aNimB4azZEezC+238I1wt7je6L
         P7/1CkEU8lXcShdKCDZDuZCO2E/vqksbvH50MWxmphG46UhzM2MIZOyH8GztRNYeANjw
         wbKpqnG0UjGkc4UAioCsUebvWem3zLdWHV/Qo2bsOQQ+UF7fKPbl5QlpYnvCZT9MXpEw
         ck3MRZ3ksErS7pTtw4pLXBwkEDUFMJ1qmO275GRVKWuvNVKvdkU5/6uy3GXjRIqXpmP0
         cS7g==
X-Forwarded-Encrypted: i=1; AJvYcCXUPntRQaj/GqMdG+T2ISR2vWiVrssC8NyrHq7pkYdN0wxaSDxrg3jbmlrUIRcS3Yz0XPtT7rU2nxq+3rEWuLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNNyG3zUVKzMafD5ZePJForBHLQZR13pUnJHmiRsrr06Ohv+46
	SerHR449g8wp51Uq4eBE0Fo5/XKINIv2taJhMBTRvYRumEaJ4bxWh9NCXSSPd3dbSdQ=
X-Gm-Gg: ASbGncuFWb2//zUkj8st0CY45ZCArhPGIHzLqUZ/b978KvnSK9JSUyMCs21q5qISBRN
	F8vVon3RXWAHCJwA6FDyxhvxZU4WM1aDsHp3IjhVZro2OFGOw8UFoq0WTsK5A8ZovP1R/P22niO
	igQctEZ/FfVoJQqV33QKnV5wGW5NlLJKnevRJUDElvxJt/4AieHDF15fV4YFnKZzo/tFpn3lTGQ
	hOUFEl7d5szik4KMcHMiDNYwQLbxgclB4ju60alnSAWFbAF0rnDxcyE9jSTGiavPTe8iAtCjoX7
	eCWn4W7OijtFHZlgbkDUkOR7WdXO0Hze4y9GyF46m6eZfczycLycBaUBaODWl5xqHeuGCuxQR8F
	Tqy3E7mhCBaxhTJGMxBhlIMVpVQZCW5CSa6OiDkzIqNmRg8jwRspi/bOUOXC+0UjAj4c=
X-Google-Smtp-Source: AGHT+IHvTfW8ErtYxmCHyfwmYUsv3qThL/CdkOqZ2HZYuqS8vGSb2x0qKaF105IAiumURKGEoJjfPg==
X-Received: by 2002:a17:90b:3c83:b0:31f:22f:a221 with SMTP id 98e67ed59e1d1-32183c46097mr21445066a91.29.1754957232026;
        Mon, 11 Aug 2025 17:07:12 -0700 (PDT)
Received: from MacBook-Air.local (c-73-222-201-58.hsd1.ca.comcast.net. [73.222.201.58])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b43c54fbce4sm5843931a12.55.2025.08.11.17.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 17:07:11 -0700 (PDT)
Date: Mon, 11 Aug 2025 17:07:09 -0700
From: Joe Damato <joe@dama.to>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shuah@kernel.org, sdf@fomichev.me, almasrymina@google.com,
	noren@nvidia.com, linux-kselftest@vger.kernel.org,
	ap420073@gmail.com
Subject: Re: [PATCH net-next 3/5] selftests: drv-net: devmem: add / correct
 the IPv6 support
Message-ID: <aJqFrdKEqRj1mI3y@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
	sdf@fomichev.me, almasrymina@google.com, noren@nvidia.com,
	linux-kselftest@vger.kernel.org, ap420073@gmail.com
References: <20250811231334.561137-1-kuba@kernel.org>
 <20250811231334.561137-4-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811231334.561137-4-kuba@kernel.org>

On Mon, Aug 11, 2025 at 04:13:32PM -0700, Jakub Kicinski wrote:
> We need to use bracketed IPv6 addresses for socat.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  tools/testing/selftests/drivers/net/hw/devmem.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/hw/devmem.py b/tools/testing/selftests/drivers/net/hw/devmem.py
> index baa2f24240ba..0a2533a3d6d6 100755
> --- a/tools/testing/selftests/drivers/net/hw/devmem.py
> +++ b/tools/testing/selftests/drivers/net/hw/devmem.py
> @@ -24,7 +24,7 @@ from lib.py import ksft_disruptive
>      require_devmem(cfg)
>  
>      port = rand_port()
> -    socat = f"socat -u - TCP{cfg.addr_ipver}:{cfg.addr}:{port},bind={cfg.remote_addr}:{port}"
> +    socat = f"socat -u - TCP{cfg.addr_ipver}:{cfg.baddr}:{port},bind={cfg.remote_baddr}:{port}"

FWIW I had no idea socat supports bracketed v4 addresses (just to make sure
this change won't break anything). A quick test I did locally shows it does.

Reviewed-by: Joe Damato <joe@dama.to>

