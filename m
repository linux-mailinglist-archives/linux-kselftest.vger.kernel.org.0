Return-Path: <linux-kselftest+bounces-25818-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F94A289CD
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 13:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96CD0164129
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2025 12:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32482288C3;
	Wed,  5 Feb 2025 12:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KmptyAqV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521F0151986;
	Wed,  5 Feb 2025 12:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738756874; cv=none; b=P8/CnJg6cJrbzlchRVVYCABC4yqleitZvP8qZDkJdqeYpHqS+8HkDU3FzKfZGSeifn02NSOUgoq7KQBB0ryuqPcB5P3mV0lQ90YtBurtvPijA5QpbngmOHRf9XwVZy5V+gxsEkkR+MvuaKgesuRgbdcgC4s/SkG/q5AMOoFnocA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738756874; c=relaxed/simple;
	bh=9n6a9uQl9i/L5M+Gtt/Zbkst7PZzAhCGCzvZ1sOdLME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gLZRkQ21ViOrp8h+3s1I8yXhdTSMEiC7QDqcM456uibcvzRyJE+Uedd373vH0KmrtYunOXHGycZeokZYspje2tonBppYTRCJQiwMSlF164VnrX/94qHHyZLvDV/MGfSnmxtiID0hypDrM9sRZFNni8ZbDDBkCRwoxbScs2SzrKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KmptyAqV; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2163dc5155fso117591315ad.0;
        Wed, 05 Feb 2025 04:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738756872; x=1739361672; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nsWH4bkHCYOuJvzfoXTwaNIHGXBOrXdOaMsxD9Y32S0=;
        b=KmptyAqVXGVhSC5OYFkiVV9UpDTUFPYN7+lhhZKol4R0nNMrl0FBf8ZVyopBmeaE88
         HnuzMude+wI/rZim5qGHY/8F4zF/v1sY66eA/6n3AqO1x2xw3kzbDVBGOFjKSFoOWEPZ
         2jxXZ3B7/Vd7i8w65Z+siLvZBovJ9+S4nZ7vEacn3EwiuHXZp5zVrU5pl01rZY2jKD7M
         Wa9E/pkpSHsUc1PuLKyLM/AJf8Yv6urhkFkNqdRdgkn+cn3WsMk0/FMt0e8RNKfK7Xcv
         GfTIKVKKyEg1dmpSXjEZQR7xLSVCatij3xfiAnBYh9NsTEy4VAo984/h3CvGET7t2S5c
         wxFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738756872; x=1739361672;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nsWH4bkHCYOuJvzfoXTwaNIHGXBOrXdOaMsxD9Y32S0=;
        b=RUSx76NHaSqHfolTwCzUoAfUS5aHmF2gwWaSqu0cS5OtzCJuStG3WwN657F1ZTGHOR
         BIPnTtYjgn1SeeeHVAFsnYXpsOtouOVzobwoH/VI/rurxYxqN/XzLD1QWvmvLILLtIEn
         tddcvZUH74NNFZN5qKOKSfw4/8yO0gpK8yzopSRdu3qGh6BOhaslCkBog4ydUssOJY3z
         4TZ20zLUhtoc7qNBmqcTw+5SQod6vDjJXCrbS6VkMoqlmNrf+S/yChLdVxk0np9y6kLw
         hOxcQ0oi3WHww4nK8gUCXEgyd8GNf2XJ7AnSY2GHDxhh2vCUgsOJlXnE+vHpGxFDA8vd
         rEhg==
X-Forwarded-Encrypted: i=1; AJvYcCUpS6KrBQxnIGnfjRqAzXuJTHISXZRCHeduYMQejWEdcXDF2o0PlKHTErEo0L13hsixgBVDuhO7oIrgX24=@vger.kernel.org, AJvYcCVqy08wUL+2v+hme/FV4d2NVsuj7ASHm3SEewJrFCNNp2HpeZBGgRJoiu5AEV1/ysgbruQoorQlkc/F4SB6PoNs@vger.kernel.org
X-Gm-Message-State: AOJu0YybVwKnC2srDcl+yMFzxplWGlDaYRXeNgS6soEZrKcCDEWSigOn
	mmahw7uOkYQSasl3FEmL/J7Bf2ODHw1av/bBQEhV1WOiPpfLdxkvIVckQXY2eh8=
X-Gm-Gg: ASbGncvEePbbKaLANyoo1po9OVSNMxCkaNjMQwezLZRRmtokDl+k2nrCWBOaPMj+DCz
	UJ56DrR0A+wp9e80SOERrZkhrxVvlxszb0dzR+rM3cuoJMfONLKPu/b59ybACCE5zyfWnqtuK8s
	s3pQm9AGsya5q24i7Al4TmjFvLcKgjGx6j53q2s8EXK3GQuKLWZ5ABl0cO9SDxEgiyYcwPsoRSl
	WkLBaV7+rZJ+rMsBQ72SXKk2rY0i+3qAqMz+DymQPl2hc/CdDZW4xzOBlbQpVJRFZkrKKiFQmff
	VDbzzUxeeINPVh43HFT7
X-Google-Smtp-Source: AGHT+IHbUO12GorCrmQIRZNcPoHPznkzO7CbXQYcdmUxThQjrieOYuKxhwBHCmv49y5FFm7+e7PUHg==
X-Received: by 2002:a05:6a21:6e41:b0:1e1:a829:bfb6 with SMTP id adf61e73a8af0-1ede881baecmr4405764637.3.1738756871955;
        Wed, 05 Feb 2025 04:01:11 -0800 (PST)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe69ba38bsm12566007b3a.90.2025.02.05.04.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 04:01:11 -0800 (PST)
Date: Wed, 5 Feb 2025 12:01:03 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>, Jianbo Liu <jianbol@nvidia.com>,
	Boris Pismenny <borisp@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/2] bonding: fix incorrect MAC address setting to
 receive NA messages
Message-ID: <Z6NS_7rbUVLy_yJn@fedora>
References: <20250205080336.2197369-1-liuhangbin@gmail.com>
 <20250205080336.2197369-2-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205080336.2197369-2-liuhangbin@gmail.com>


Oh, I just found the subject is incorrect. We want to receive the NS
message, not NA message on backup slaves.

Thanks
Hangbin
On Wed, Feb 05, 2025 at 08:03:35AM +0000, Hangbin Liu wrote:
> In order to receive the neighbor solicitation messages on the backup slave,
> we should add the NS target's corresponding MAC address. But the target in
> bonding is a unicast addresses. We can't use it directly. Instead, we should
> convert it to a Solicited-Node Multicast Address first and then convert
> the multicast address to the right MAC address.
> 
> Fixes: 8eb36164d1a6 ("bonding: add ns target multicast address to slave device")
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  drivers/net/bonding/bond_options.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
> index 327b6ecdc77e..63cf209dcdc9 100644
> --- a/drivers/net/bonding/bond_options.c
> +++ b/drivers/net/bonding/bond_options.c
> @@ -1246,6 +1246,7 @@ static void slave_set_ns_maddrs(struct bonding *bond, struct slave *slave, bool
>  {
>  	struct in6_addr *targets = bond->params.ns_targets;
>  	char slot_maddr[MAX_ADDR_LEN];
> +	struct in6_addr mcaddr;
>  	int i;
>  
>  	if (!slave_can_set_ns_maddr(bond, slave))
> @@ -1255,7 +1256,8 @@ static void slave_set_ns_maddrs(struct bonding *bond, struct slave *slave, bool
>  		if (ipv6_addr_any(&targets[i]))
>  			break;
>  
> -		if (!ndisc_mc_map(&targets[i], slot_maddr, slave->dev, 0)) {
> +		addrconf_addr_solict_mult(&targets[i], &mcaddr);
> +		if (!ndisc_mc_map(&mcaddr, slot_maddr, slave->dev, 0)) {
>  			if (add)
>  				dev_mc_add(slave->dev, slot_maddr);
>  			else
> -- 
> 2.39.5 (Apple Git-154)
> 

