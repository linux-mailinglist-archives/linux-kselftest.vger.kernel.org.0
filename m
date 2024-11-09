Return-Path: <linux-kselftest+bounces-21715-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5933D9C2914
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Nov 2024 02:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 626891C21F73
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Nov 2024 01:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C89417C9B;
	Sat,  9 Nov 2024 01:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XSAcBk/w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE9B23A9;
	Sat,  9 Nov 2024 01:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731114683; cv=none; b=cpiggY10YSBjSY06GaeS0aXerTeEdaDUUUGTbPvtk3KfFXGSra8zv9xxDeFf9zurX6eVMH6qC/upJwUyjqrYEP3Yl8bBsEpphA2zyLfv6f05Ofhie0GYEcClAHKesJDSyYaAdxNiDSn7eQ57nQ/QskzOzu68LqQaQ+xBa9ldUGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731114683; c=relaxed/simple;
	bh=P72/2q/dAIDA7p72zatGRkbSLYJtNzkS+VemDMtvzbM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lZbS3LWJlSjSaQroiDMns0HeC5JhXXAwiLTzYk5AMY9mAxuGnonuEKWL39h9NZRZCmmvtpCuztA5b4DvaTwH8Lerj7ns604oZpUnIKKdCG/VTyg0/vV7orZ0t2FdmckzvxWHIfuv5jpSMzRPYSEDiI6N6Sy9pCeC7kJsjCWFtWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XSAcBk/w; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2fb5fa911aaso35748381fa.2;
        Fri, 08 Nov 2024 17:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731114680; x=1731719480; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LsDkNEMMUHDzh0wyiOj+aaVhFGlxd5q3FjPCb/5gWQc=;
        b=XSAcBk/wQ5T9C443OchIqGTDZxZz5jBnib+U1PcmqellbPEAhN1jU1gfmhP0nTs+RY
         eydyWXYHO9dqx4ki+G23XUL5M4KlqSswuziQ7ku2qiEbFIwBx75sqz0Ef9/qeW6VKE+B
         Ic5keaWgBzOo6liq+eywE2t6AOxza7yIkMm7F5te9HYKd/IvtQud9YEGq9j96fzV/2sb
         Q7N8uYu2WZUiLsHmKXUS4mxrvXydEeFfmFS1aiiU+X53++mdGg2Zb5K0SX2HrFPOpiMP
         CfsJm8I01FX2Ne0PWsssYC4r9Ejdq1cKPFi6bJXMxHKjbqYGacGCwR57H9+fTE/yWHDF
         R7Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731114680; x=1731719480;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LsDkNEMMUHDzh0wyiOj+aaVhFGlxd5q3FjPCb/5gWQc=;
        b=wGdEttVcEV/uLyImF90nlmyMw0YkLy2s3rc5DDDT8kMLEQqejuA4qfZzUOmKslonoD
         zSjSJM99blctY8a7cxa5YjiqBF7phShHHT7yt1yF9bw2Ub6OsJG97tREC+C2TdD+C5EZ
         2ZRgsV1XpvMIilL+WwR3BYNFZy0aTy3QgD6KaYgYV0znQ/o6fyhB5iBgAzmN58FmhoQg
         kbASduKLGcCF+rHIHpT5gtlSuPmqqmVPeTU3XeNJd8byYLRu3rrUuTEfuoCjin9EeTnp
         zeByFwAWjgxX/38wIfOQ41TRH1K3BywnqZOdKMj5EKls2pEg1rvrF8ScTiqtyuWApY3H
         jk2g==
X-Forwarded-Encrypted: i=1; AJvYcCU/IvX/WYmly/S4ihvYV33oMXbPKk21Nhal0JVLU+OiOfbJvI4FkbNktceKRNmUzmJXyrmS3JJW@vger.kernel.org, AJvYcCUQn09VluHcweV2pSmUHdFSjnsR9DTFjyvkq1Xdrf/aud/7opDHgYMni1UPlwFt+MY6oPE62rkBe3M8wkA=@vger.kernel.org, AJvYcCVp+qlMjKmaouYysvjYabd8JLjoUXxQuuVH70ImaBrU5+w1ODdk3xMmeTj2deAVhjtcFuM30qXSYd9R4QYlvHfs@vger.kernel.org
X-Gm-Message-State: AOJu0YzY1ZDvwzl2iSkaaUJ0Ew38VuM7i4PljGK4NTF4oNe4S3+dLIGb
	XoGncv3/shGa19/q+MQqrXH87kN7nwF8s+T41I+TkjJcUGz4ZaxFb15TqPYc
X-Google-Smtp-Source: AGHT+IE3AWnOF9wLKOe12uvUKDaeC/oSizRy2C6TppR9FCqhnvgBFvKg5mk096Tc0Wc1GoGep/zNNQ==
X-Received: by 2002:a2e:b896:0:b0:2fa:fdd1:be23 with SMTP id 38308e7fff4ca-2ff2028aadamr40540091fa.28.1731114679304;
        Fri, 08 Nov 2024 17:11:19 -0800 (PST)
Received: from [192.168.0.2] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0a188besm297969666b.8.2024.11.08.17.11.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Nov 2024 17:11:18 -0800 (PST)
Message-ID: <6a171cc9-a052-452e-8b3d-273e5b46dae5@gmail.com>
Date: Sat, 9 Nov 2024 03:11:48 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 05/23] ovpn: keep carrier always on
To: Antonio Quartulli <antonio@openvpn.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, sd@queasysnail.net,
 Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-5-de4698c73a25@openvpn.net>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <20241029-b4-ovpn-v11-5-de4698c73a25@openvpn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.10.2024 12:47, Antonio Quartulli wrote:
> An ovpn interface will keep carrier always on and let the user
> decide when an interface should be considered disconnected.
> 
> This way, even if an ovpn interface is not connected to any peer,
> it can still retain all IPs and routes and thus prevent any data
> leak.
> 
> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> ---
>   drivers/net/ovpn/main.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
> index eead7677b8239eb3c48bb26ca95492d88512b8d4..eaa83a8662e4ac2c758201008268f9633643c0b6 100644
> --- a/drivers/net/ovpn/main.c
> +++ b/drivers/net/ovpn/main.c
> @@ -31,6 +31,13 @@ static void ovpn_struct_free(struct net_device *net)
>   
>   static int ovpn_net_open(struct net_device *dev)
>   {
> +	/* ovpn keeps the carrier always on to avoid losing IP or route
> +	 * configuration upon disconnection. This way it can prevent leaks
> +	 * of traffic outside of the VPN tunnel.
> +	 * The user may override this behaviour by tearing down the interface
> +	 * manually.
> +	 */
> +	netif_carrier_on(dev);

If a user cares about the traffic leaking, then he can create a 
blackhole route with huge metric:

# ip route add blackhole default metric 10000

Why the network interface should implicitly provide this functionality? 
And on another hand, how a routing daemon can learn a topology change 
without indication from the interface?

>   	netif_tx_start_all_queues(dev);
>   	return 0;
>   }
> 


