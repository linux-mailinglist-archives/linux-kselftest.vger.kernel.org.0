Return-Path: <linux-kselftest+bounces-11101-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A26338D7EF9
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jun 2024 11:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41D411F24DFE
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jun 2024 09:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B9F83CC1;
	Mon,  3 Jun 2024 09:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZzIuOXi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C657B811F8;
	Mon,  3 Jun 2024 09:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407159; cv=none; b=ubcaDSntnz7DlWD+TDW+QfyQPOQYUFhzgbi1iiO8a4OQ6kgIZBp4ZBx2xdAoYQzA6fo9EoYp+rW/f1nJRZ5eR0yMe3ZWAUWJKzWVKKbvonAQ1zsP6AWc81/MA2K/RSXn2GwxiaJRzQqILJu/lf7u5fquUdLLNLFxrYaxc+qxdXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407159; c=relaxed/simple;
	bh=oYGWqWyRSveq4oUmnXF2Tbphy0q/VHVE+jqDDeU2UhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E4L3oWjrtvXgkjsvMYsUNfJZv6ajBqeInmSqUOW3ArQvnf+QXUtZ4iOjX7p4VT5kL4vl79rVZwpGBYU6qZmGLMH/e+2BJGV4nd7tb78UfmTnD7HFNtUmy/XeDiGFiOehnEAGXSDvh8XPHit2YfEk/A1GVvdoYaQ7p/E824yssYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZzIuOXi; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f6134df05fso37436995ad.1;
        Mon, 03 Jun 2024 02:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717407157; x=1718011957; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UV/qo+bV8vb9T6j4/F9/vMYZisRKPxcSus1SVVWYnOE=;
        b=AZzIuOXij0IBYFSAypRAWB04iOYwlrbDo87enGzdUg2PQuVeB0102ALPdMSi9WgD8d
         dLYcZBqaYl+OeGx0oR3tTMQyQ+FhJqNf+/AzqMwJPOXC8Bi+bcX5fnvqK3UsPIr6cSvg
         u2m3H2pkgKrg97ZlQ5dGo9wDzrbjBDAufwh9XcmTerBAt3AUG+Jw1nHp1WiNYiO0BMT0
         V46eRWOIkdCi3J5bcuvkldB8Yb4/Gvs04o6nXG/sSlT6mEHJxkjNcLtiHpcG6vcIVq1f
         YFQXp4DEvPk6AgrdduPXeDOwG6vYnkkdR6BFJs/bQkqPCV/4p9rkKT4/1m5e853WTQh9
         135Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717407157; x=1718011957;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UV/qo+bV8vb9T6j4/F9/vMYZisRKPxcSus1SVVWYnOE=;
        b=VluTLdp2bltMerh2dDFn0jKsMsEybLIguXrh0cJYJxG4QJG6pOVOGA03Y56F5Rmr6h
         fLxXd1QFTJ36IRm/3WhPwLwCTv3Txhhuve4PUDxeSCodKP1nSStJ7HyxKrT882kZ/RW/
         McjCSmU5VLSws5bPiWfc0UmDQ2Ju/KS+U0LhSw9l3hW/IzNMnYgXPvVMBa3XRlYX0ZV9
         PwTxR5OTEWpBch2lc5zC3FmchsJb6kh1oQmIPAZXYj2zTqtwumW5Q56466yt0yePTxCc
         0157RwetuZkzr88TjBEsUivkddhFdSHwrJ7FkgAK6W4AG17HC5ckOGjy/RpvArn0b5nK
         RGxA==
X-Forwarded-Encrypted: i=1; AJvYcCUimZ6aV2PAroC7MxdyjD2iDYhaDHH2ZJa+ltvuAPgcyMgzBX2rLIStP2VdKIwQXs6/QOWVZ4N/9NGcp671WkDKygkBDkWs54cixP0LIXPxIhjr/Zbs8D8aIceBYAoV9Le8ndFmIEPCZpLBNHGCUPZgyct6RvPA3/det434UlLZB/alXGsR
X-Gm-Message-State: AOJu0YzkxeUqCNoY/s1T5AFxaDqTIfSLVhQrQKZyNV6PLEpVM/WboT8q
	7ODODbNWBX0JUHARdlNhFSNxhrNqRGXVNx92xzjENqFII3DfkqE3
X-Google-Smtp-Source: AGHT+IHVzs3iOQhuWCA3gi9pdn/VQ4DRI4J59EJyDdQQZASW/fnYKMBVbKcWHuHGphINAMG7dqTVMw==
X-Received: by 2002:a17:902:7ec8:b0:1f6:62c:96fb with SMTP id d9443c01a7336-1f637016951mr72103445ad.30.1717407157060;
        Mon, 03 Jun 2024 02:32:37 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323ff9f3sm62003845ad.247.2024.06.03.02.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 02:32:36 -0700 (PDT)
Date: Mon, 3 Jun 2024 17:32:27 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Lukasz Majewski <lukma@denx.de>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Oleksij Rempel <o.rempel@pengutronix.de>, Tristram.Ha@microchip.com,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Ravi Gunasekaran <r-gunasekaran@ti.com>,
	Simon Horman <horms@kernel.org>,
	Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Arvid Brodin <Arvid.Brodin@xdin.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	Casper Andersson <casper.casan@gmail.com>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Geliang Tang <tanggeliang@kylinos.cn>,
	Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH] selftests: hsr: Extend the hsr_redbox.sh test to use
 fixed MAC addresses
Message-ID: <Zl2Nq_EXB1wJ9mgU@Laptop-X1>
References: <20240529142232.2625747-1-lukma@denx.de>
 <20240529142232.2625747-2-lukma@denx.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529142232.2625747-2-lukma@denx.de>

On Wed, May 29, 2024 at 04:22:32PM +0200, Lukasz Majewski wrote:
> Fixed MAC addresses help with debugging as last four bytes identify the
> network namespace.
> 
> Moreover, it allows to mimic the real life setup with for example bridge
> having the same MAC address on each port.
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---
>  tools/testing/selftests/net/hsr/hsr_redbox.sh | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/hsr/hsr_redbox.sh b/tools/testing/selftests/net/hsr/hsr_redbox.sh
> index 1f36785347c0..998103502d5d 100755
> --- a/tools/testing/selftests/net/hsr/hsr_redbox.sh
> +++ b/tools/testing/selftests/net/hsr/hsr_redbox.sh
> @@ -96,6 +96,21 @@ setup_hsr_interfaces()
>  	ip -n "${ns4}" link set ns4eth1 up
>  	ip -n "${ns5}" link set ns5eth1 up
>  
> +	ip -net "$ns1" link set address 00:11:22:00:01:01 dev ns1eth1
> +	ip -net "$ns1" link set address 00:11:22:00:01:02 dev ns1eth2
> +
> +	ip -net "$ns2" link set address 00:11:22:00:02:01 dev ns2eth1
> +	ip -net "$ns2" link set address 00:11:22:00:02:02 dev ns2eth2
> +	ip -net "$ns2" link set address 00:11:22:00:02:03 dev ns2eth3
> +
> +	ip -net "$ns3" link set address 00:11:22:00:03:11 dev ns3eth1
> +	ip -net "$ns3" link set address 00:11:22:00:03:11 dev ns3eth2
> +	ip -net "$ns3" link set address 00:11:22:00:03:11 dev ns3eth3
> +	ip -net "$ns3" link set address 00:11:22:00:03:11 dev ns3br1
> +
> +	ip -net "$ns4" link set address 00:11:22:00:04:01 dev ns4eth1
> +	ip -net "$ns5" link set address 00:11:22:00:05:01 dev ns5eth1
> +
>  	ip -net "${ns1}" link add name hsr1 type hsr slave1 ns1eth1 slave2 ns1eth2 supervision 45 version ${HSRv} proto 0
>  	ip -net "${ns2}" link add name hsr2 type hsr slave1 ns2eth1 slave2 ns2eth2 interlink ns2eth3 supervision 45 version ${HSRv} proto 0
>  
> -- 
> 2.20.1
> 

Tested-by: Hangbin Liu <liuhangbin@gmail.com>

