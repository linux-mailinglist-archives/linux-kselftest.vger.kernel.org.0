Return-Path: <linux-kselftest+bounces-21005-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4079B52D0
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 20:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86EA61F22A5A
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 19:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7422071FF;
	Tue, 29 Oct 2024 19:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="A5eXiE57"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB8F206979
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Oct 2024 19:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730230554; cv=none; b=GeNowUg8YhrgAQbtSBRrhEu57SfZojkfY+d8f675BCwRBXQJzGGRjc+Wup4INV06znEuUfPtoQOnHkaYo48hbYDG2LyJCPiUFSo7P0DxT5hBQcptRULfg9BGlrQeomWVTIpLJt+cS13z6SnJzVWNo5s6851PwP1096bq/PUz6Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730230554; c=relaxed/simple;
	bh=l97u7AD85Vr+jSAuDtGnAXLN3oFK5lQIbSKv/kprs9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pib/5+2R1WXnQ9zZza21xKhbflJxNvTpuTf4H3wcwiooT0oDAj/As1xzKqNanMjbPzj3QgObIimCgwmF5ZQZLHOogPG3Yom24j2H5zWPICDHjn3JdP1/IV32WmYHZKq+8ySKsAC5/G5sfsqe+M+A6d0Pf6nyRsKWTL/o7G/79Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=A5eXiE57; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7ede6803585so151132a12.0
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Oct 2024 12:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730230551; x=1730835351; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Zcs4o+8nn0iIRd8I2+/9Q9KReeiO44oWp58nygwPzE=;
        b=A5eXiE57StiQAghyP/TJOgEMRTRlSTWciQMsc1DxX7kytnMCdD6SUAz5qny1qvVPQw
         6EmX71GEpo1u4QBeHWT0Rjl0NLtY8HWzv2vfV/qAltYmv6nSosEQfA/tqwmAltSuyAVp
         WHUnQJ6zA10RczXTfBh9qouz1VGshkeNNPSyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730230551; x=1730835351;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Zcs4o+8nn0iIRd8I2+/9Q9KReeiO44oWp58nygwPzE=;
        b=aBNYLME8MjN71iMZOEKwM06OjdynUBuLuloOfpitE1r8+z7jUIeo4O+p0qorAA2o7p
         sEih9JMqnlO8Bl7KxTcgaag38YE7K9mdDiDcaXxD94r9vPuLYnJMneASYCaj8i/glpIb
         UfYFwp57CEDeDOu1LCR83jssPQiVrHp1LcCDupTR/c8B49+e6Lc6uyvn//PLqt2vtarb
         R+VNpiuduF6ULHcAYxO4ndzZc+Z84Zp6AJXk8T476Ow/s/kK+ojvig6QD2+h04UDLyIV
         oDHSdir7/ZFCyYaM8dHL5pGd4gtA1CC74g9tp9tYeyGm/VIbkB97qNEDY3ZRF846yJHm
         Z8rg==
X-Forwarded-Encrypted: i=1; AJvYcCUCQBqpOm/u+1Th3IkJ24PUK0TwN0Rpgx9dDwiA1YYC22dBGhx/jW5ZMOBpS25XoffTJKYAVGRyXcLDx7A2gsM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6C+9Vagp4SIkyaXbWz0+xLzgofsxXiLzLSU0R9838iftaU9Cz
	0+Astv6aln2ZekSsc2qgLRVWIdOX5vJvEFOXRQyzHPa4iKqjBtvvRjtO89/XNHc=
X-Google-Smtp-Source: AGHT+IHxuosv81KXF0Kia30ocKL+gRC+ueg02iUmaAs4LNtAl5SZZm8KQcTtCNiPhmT/l0f9qmLBvA==
X-Received: by 2002:a17:90a:3986:b0:2e2:ad14:e467 with SMTP id 98e67ed59e1d1-2e92204cd1dmr4813267a91.3.1730230551489;
        Tue, 29 Oct 2024 12:35:51 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e77e48ed34sm13193552a91.9.2024.10.29.12.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 12:35:51 -0700 (PDT)
Date: Tue, 29 Oct 2024 12:35:48 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, shuah@kernel.org,
	linux-kselftest@vger.kernel.org, petrm@nvidia.com
Subject: Re: [PATCH net-next] selftests: netdevsim: add fib_notifications to
 Makefile
Message-ID: <ZyE5FHwhbU9V9-GG@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, shuah@kernel.org,
	linux-kselftest@vger.kernel.org, petrm@nvidia.com
References: <20241029192603.509295-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029192603.509295-1-kuba@kernel.org>

On Tue, Oct 29, 2024 at 12:26:03PM -0700, Jakub Kicinski wrote:
> Commit 19d36d2971e6 ("selftests: netdevsim: Add fib_notifications test")
> added the test but didn't include it in the Makefile.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: andrew+netdev@lunn.ch
> CC: shuah@kernel.org
> CC: linux-kselftest@vger.kernel.org
> CC: petrm@nvidia.com
> ---
>  tools/testing/selftests/drivers/net/netdevsim/Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/drivers/net/netdevsim/Makefile b/tools/testing/selftests/drivers/net/netdevsim/Makefile
> index 5bace0b7fb57..cc08b220323f 100644
> --- a/tools/testing/selftests/drivers/net/netdevsim/Makefile
> +++ b/tools/testing/selftests/drivers/net/netdevsim/Makefile
> @@ -8,6 +8,7 @@ TEST_PROGS = devlink.sh \
>  	ethtool-pause.sh \
>  	ethtool-ring.sh \
>  	fib.sh \
> +	fib_notifications.sh \
>  	hw_stats_l3.sh \
>  	nexthop.sh \
>  	peer.sh \
> -- 
> 2.47.0

Reviewed-by: Joe Damato <jdamato@fastly.com>

