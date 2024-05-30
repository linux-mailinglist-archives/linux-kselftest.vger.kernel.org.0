Return-Path: <linux-kselftest+bounces-10891-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FBC8D42FB
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 03:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1665428406E
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 01:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEA7168BD;
	Thu, 30 May 2024 01:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQOiKjlv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78350134DE;
	Thu, 30 May 2024 01:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717032868; cv=none; b=UkuAPiez9dHWDBDDxZbtjE6X7Yqffu5CZ98K7TYFXpazeginO0bKEAlybxbziiP/pVUtGhkvCDr/R8gQur4NIEzxb/0Pn9FlkydG5StYwGaSWpbUDKIVrCCKiqdyyr/P44ecerdX+9nHDMnK8NJJTgNPWsDCzzY/DLZW60jDuGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717032868; c=relaxed/simple;
	bh=scYKQLLie7Snp8rTwRhCqK4FGsPnWKidk0pUWlozPpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GDyUOXi/rU1MPNtlYJc/asyBA1HRY70gwS9J5hQgNn3Sze5gFH79y2niXSFF7+XwFs+az/i3w3Z2dws31l+YWSTXlIwaDBKV9LMcxU46Si9QCSs8ouvcYQCBQeLNvqqH6RNAjFu2slfEOhw4ajIl5Cxs4s15yFKdp/bKJuoci6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NQOiKjlv; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2bd816ecaf5so264134a91.2;
        Wed, 29 May 2024 18:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717032867; x=1717637667; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lz9rT6iMtPGxWAxp0Dgc6em4/oZcPEZrP5wJjE1TLsU=;
        b=NQOiKjlvRwiaEENKEyJ14+L5becJ9aiD/N/udVI17BDHAho+NkSdaJEbXsat/ndYUX
         BbvVs6gwsibB7YkCnyqJiVLetLzY009dB3TA9WRjQMU3scH+fW0Vrv8XapJzUuQWLE+L
         rDg93zuGs0+Uwx8RkFd9zXJpYgwyCTXVHybVACOf6D/RO2G99t4sVhIEAHG7BbMVhO7B
         FfUOWPPPlyi31qipkxia5nG67d9GR0v/WHnYvE/ylLmXPTLiF6wJoLHVpPF9ZqEnJSjD
         izVbvPossakq6Ne3b7fnaCH/qLhDMM4EZpnU68YaCXwQB6bUEqztr3VWZIkzASMcRSmV
         r4Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717032867; x=1717637667;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lz9rT6iMtPGxWAxp0Dgc6em4/oZcPEZrP5wJjE1TLsU=;
        b=KUbNqM/tuM7VuHk9TKQ22pDbdFcZ8jcTMafdVy7w9OOZKWE2t+gIrOlLlm+6loSjFz
         DSFOlStSOrB46MGoCCUGlg9iuhIlzn/OaXgz/QnK2+lik+DtZkBGExyDFhMThB6BEWrD
         RunbjgHSNpwX00eLcJOQV4Bfxqaler35mpGrYn24CE/QdzxCo1bbi+Jm0w96+9IlwApY
         s20U/uQhNGFQHRLUnIRD5nl4wb/7uZ6Dcu/LSTyDwnWDLFlvKEexZNMBGEoLHCv4IUQD
         vQ42ep6MX77P8rP/jSvRlKStF3cIcsjc1PYqDia0WppRmKA1dpWoJJtnKam8mJo00AaS
         JTQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpHIxUTJWVeXfElsuGMF2kx2M0bramvELlYr8ebzzyXSzTTSFdKHmKGo0Kf5HOZeYdKcj+tx2+qmUJjDa3oVLIM8eSx6Us2TXC6D1TpJJCjLedtzeU6PJt+JQ/Rmuk5juKHyJaFiDvIpam954HJGpB4HXWRZHC4NeshSla3dg5rOVRk9dC
X-Gm-Message-State: AOJu0YzMiz/ex8WLa2rTbVsI5M+z2V2VWpVMqPT2UXhteulQ6d77jOIC
	jMgrHENLfXWmcT7l9sP6pKGUiYCNCDGbuk/SPS7eKWMVLpr7K+hr
X-Google-Smtp-Source: AGHT+IHYFUxRloxCcpin5n6RPZ78K2DMBhJxsrtugp2WausT+RjrzexhzIiEsjaQDoxMoGrE81FJTQ==
X-Received: by 2002:a17:90a:cb8b:b0:2c1:97c2:5cbb with SMTP id 98e67ed59e1d1-2c1abbfa718mr837475a91.21.1717032866670;
        Wed, 29 May 2024 18:34:26 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c1a7780affsm534189a91.23.2024.05.29.18.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 18:34:26 -0700 (PDT)
Date: Thu, 30 May 2024 09:34:16 +0800
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
Message-ID: <ZlfXmDN-W1dZRYQL@Laptop-X1>
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

The ns3's mac addresses are same, is it a copy-paste error?

BTW, please add the target tree for the patch, e.g.

[PATCH net-next]

Thanks
Hangbin

