Return-Path: <linux-kselftest+bounces-11100-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2E28D7EF3
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jun 2024 11:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 409E428A582
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jun 2024 09:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A10F823A6;
	Mon,  3 Jun 2024 09:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBOCY2XB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDE87A140;
	Mon,  3 Jun 2024 09:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407127; cv=none; b=CirMIZ08Ex2WwIgHmjtmyHGJaG1uB7rnCSFHhqyagEqF7nJbbpisjCc1GZ3UMrXLsqQeY5x/K7JQTOjA601f5kAHYNXnFfzWONo98XQ56l0ZBp/bOJPuVzPy9DZ1YFTI+fsai1qBLInMPYj6Rso/xDkq84VvB/5GQr7/EZwPBiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407127; c=relaxed/simple;
	bh=TVE8DZONja0s1bSsoBvAXL63/o3/AtA5FtzW/UuFgGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hnhueMCVPUksfeK6KHOAMaEgetjydL+7vxuRuyLhwEHV5SuivTAUYuk+8N2hxSXnh7nt1MqLr+/PKguYmi6xydD0LTihej/4w7ZqT0HvTTRbLxqr79rvt8KocM9vz5agmM2xJU+KUn9GlUKCtTT/rHbMCb3NhkluuIMdh1jbTs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jBOCY2XB; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6f6a045d476so3216732b3a.1;
        Mon, 03 Jun 2024 02:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717407125; x=1718011925; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=83ISchEr6FXxHFw79UtFtHyrfzEy5Csmv0xAnwcON+Q=;
        b=jBOCY2XBGppBqd0fXDAEFierWJXwmsPmAdr/zog9SHawABhv2pDmjYE+3xj1r/Xnv6
         5FTThAT7tiSk55GJFblCmE6u72Zu3/cShtUdzFg36APeScNFi4fq+r5DLrqMX53YpksF
         y3hFIoR9+5gbqFv/7uGQo8vJUGccTU3i3gZm+aba+945EGM9Ey+JpuTOutolBhCKuDh7
         bUsmiDOlvWmjM+K/3Ml9MXVdi/Lq/EvWjzbA1wJ6Q46ScDcO2FShUDM44U9XIatGDbAp
         njcaISt0N9IOJGZIbnoj7xpTcPFbu5jKCczRM8A5LugkszGAQVLDOU+QDFnvLr6hWOG7
         tRKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717407125; x=1718011925;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=83ISchEr6FXxHFw79UtFtHyrfzEy5Csmv0xAnwcON+Q=;
        b=TB/vrphPB8ILUjrpWXWXKlqi+eLtvu0ety6WnWf1KNebQyRYKdTSbS5Jqx5cUXWgSQ
         BcEae3NOeg6odHXAalwzxF2Rgxb/brpN5vptUfC2r3DKOdpbdI+lY/EbVg6GHcqpXIIc
         N4aVNu9/0t0HVEIjU3sGp0FE0B9ItzPaBPn5hYBdmx5mxTG2srig2AEkDNJvHCcFjlcl
         6Zz7bNYFBpiERZJAKYGON4YryanEmGubOZ3TpEpI8EpkUWom200UC7rtLufTT3tq9J4T
         6zTRDelMhYzHI6ert64m3L3obZdaRDn/dVJEsuIiYpNo68P09/Z9vIduBmWeuWQ+fbu4
         Fllw==
X-Forwarded-Encrypted: i=1; AJvYcCWK8QfjlLtSlgVyQ5NgSNDtleYgJ9E3CoJUKPd+d5fBb6MXZzPoTYH3qz2gDCuZ2/2PlkBn9WKfd/eX1meXQd9dpSAJfWYWkrAs8xLVsa38ZL//n3v0n+bX5dMN1Ckqig6wUvj8dh5bdCYRtKmCmZdHXraBNgO/eawbmcGh5NsYVrgefWvK
X-Gm-Message-State: AOJu0YxyPA5UdkhnuMe7RLn4Px2t4/Id2+vjJ+Kb0hFbJ2YOcInBul/W
	+DVzRrqUNSll1JWns+oi6mxL3++gTj6rjqi6HZ7IKAVWwf+tbBRM
X-Google-Smtp-Source: AGHT+IFHJ7lL1IuMJkAGrwqCjzB8ikLGZQOZE6B++s4sJfGMIVOwo4inKqH44yjLwZVh3NFDzS/NbQ==
X-Received: by 2002:a05:6a20:3946:b0:1b1:d2b4:1148 with SMTP id adf61e73a8af0-1b26f25d044mr8695675637.48.1717407124823;
        Mon, 03 Jun 2024 02:32:04 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323e9aa7sm60138645ad.192.2024.06.03.02.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 02:32:04 -0700 (PDT)
Date: Mon, 3 Jun 2024 17:31:54 +0800
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
Subject: Re: [PATCH] selftests: hsr: Extend the hsr_ping.sh test to use fixed
 MAC addresses
Message-ID: <Zl2NivvmmChx_ass@Laptop-X1>
References: <20240529142232.2625747-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529142232.2625747-1-lukma@denx.de>

On Wed, May 29, 2024 at 04:22:31PM +0200, Lukasz Majewski wrote:
> Fixed MAC addresses help with debugging as last four bytes identify the
> network namespace.
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---
>  tools/testing/selftests/net/hsr/hsr_ping.sh | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/hsr/hsr_ping.sh b/tools/testing/selftests/net/hsr/hsr_ping.sh
> index 3684b813b0f6..f5d207fc770a 100755
> --- a/tools/testing/selftests/net/hsr/hsr_ping.sh
> +++ b/tools/testing/selftests/net/hsr/hsr_ping.sh
> @@ -152,6 +152,15 @@ setup_hsr_interfaces()
>  	ip -net "$ns3" addr add 100.64.0.3/24 dev hsr3
>  	ip -net "$ns3" addr add dead:beef:1::3/64 dev hsr3 nodad
>  
> +	ip -net "$ns1" link set address 00:11:22:00:01:01 dev ns1eth1
> +	ip -net "$ns1" link set address 00:11:22:00:01:02 dev ns1eth2
> +
> +	ip -net "$ns2" link set address 00:11:22:00:02:01 dev ns2eth1
> +	ip -net "$ns2" link set address 00:11:22:00:02:02 dev ns2eth2
> +
> +	ip -net "$ns3" link set address 00:11:22:00:03:01 dev ns3eth1
> +	ip -net "$ns3" link set address 00:11:22:00:03:02 dev ns3eth2
> +
>  	# All Links up
>  	ip -net "$ns1" link set ns1eth1 up
>  	ip -net "$ns1" link set ns1eth2 up
> -- 
> 2.20.1
> 

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

