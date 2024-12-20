Return-Path: <linux-kselftest+bounces-23655-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F20249F9231
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 13:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7B5616A82E
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 12:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70CD204699;
	Fri, 20 Dec 2024 12:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="AEBsVdtI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBF3204697
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Dec 2024 12:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734697685; cv=none; b=RkHg0fdXLe2LiHY3YskC5IXXDQcg8P5T1DrNbwqzhUn/IIF3vBTAq6AJjnst7YvKf6wsCAoXww6PNLUJYs5PoajIInzRBTz5NZd28KXaDlynD/jp//UELNoFLC+3PXe+txRoz1E+D/cvhT9FPUO+4W1xKgbkqrD/BXOujBdU1fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734697685; c=relaxed/simple;
	bh=crwUz8w4erOpuUncroLz8rVV6rCiCKVlVqP8+2IqluY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FqxNoVZt1Gtkg/7LhQGKNIScLoxcXVIkBXjUUj5YoDEG1GybaOJABPpiqB7RUt5Jf8tA0l5aZhRXlfQXbB4eBPm0aMm2NeDWRr/Hl2L/UwoyGGsh8XHYWppznv9bChqcjk5DfxmwprEY+4QevdQ31mdPaDEZXJd5kv0nvYEVspo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=AEBsVdtI; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-385d7f19f20so944651f8f.1
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Dec 2024 04:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1734697682; x=1735302482; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XW/eDTIh8MSvBLVk4dolZoBmyg128cNU1krHt3uwMlA=;
        b=AEBsVdtIUKJj27uk+G8WIkcjwhU4OPhpHkxI2y0CUYjUOnlijZ3XolYrfQ9K8nw0ID
         VEIt2R7jbau3a3K6dsubwv5OEWHI4Ue2yjdKEnovN8KNTDdjFRCggXcJHdcTqeCLGiFG
         VMuAYWSG7n0NFAr8DrUQodQATGxY0sZBpMS0+729nOvqAg0H9Zj9WQ0c1Z4LT1eWX7FW
         o7ZjCi8qPHIZ93IA96QhVio2nIMLjoqJrUg0MpIRsOiICDCK+aiAi7ot5oW1TH+vfu0Q
         n4HEE6JFrGYIt3+ZnV4xL78rJyap+ty6y/++2Ch5rRpQOQgMDc/DqaLHYE51qspap0SM
         ThVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734697682; x=1735302482;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XW/eDTIh8MSvBLVk4dolZoBmyg128cNU1krHt3uwMlA=;
        b=bFVH/TvWH3T+UhR+913RtIkMp6FJJicRvypC5qTcpzXke9r1ucpCL0c4K5ITq/Jldc
         YvKbPzoANTsU96IfcSHLw1SH1ipRk0Juka9LBU141d/ptWMkGPpI2QHw7Jq5LoOfVB2C
         gnM2rXmq23dr0q944VnSV58U2fOdMVtUdupNTYWe6v3PEFfKBUnyj2ONutRpo49x0zOo
         TvVUP1Z/O2yQ4cJOR4qARkMO0lAU0cm73A0R9Agb2N0XgiG0uyou1/SPatqpoHP8+yuV
         V1utInLjoShGNXqLYFs3HwZlJjcAcpl2rCxOF3RiiHZdOs3mq3bOncaWBPjYHNL3xEZY
         ozHA==
X-Forwarded-Encrypted: i=1; AJvYcCVtAY+E6kqz+kprFU/QfcV8tJENFy74EwSw7HHHhskx44DuvMX8B7dmelipR+vbf8KfySleKvW/8YVhjczqwBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrHsofyvJml7rZxwUDdiCPuX51BqabgFQEHcUCGHpGdF5DskUn
	ikVc1h2A3YDl7b1Xti9D1QPJtezm2U2+9tuKdYK8GIUBtCORKE4X4ullNt6OMnk=
X-Gm-Gg: ASbGnctO8oEp8WvEE3bUEq4pIFx8jLLUOkeafCZhpIvGIe7TmMK4ILoFsegvSd4yLfH
	LGWwcGkqEjdbcpckJUA049zY67UNQ5A845OvbgqFc0SNS/uXnafYhFKNOZIxLBqc3oBJZryrouE
	MB7qcqTfF9IVJlwgaZegqSGwhpmzdoB/gj4G3tGgvyFelbNvl9/5Vbr9PpjKrJn4NYu2z37ZGOa
	IyyWeLAqTnC4gUfhl5vrF+moB4Q58StH/O5ngm5OYSWVCi430vPeCfR4hA6jKfVdruJu4Q3XZfW
	ssZ+e19wnCJ8
X-Google-Smtp-Source: AGHT+IFIskpEmOR+YWcUP2jYS4Ck9DjO4dUxfusvUv9OGLXmeydXNRW2PPdKQ1wOV9XNaCqV5iGhzg==
X-Received: by 2002:a5d:47cc:0:b0:385:fa2e:a354 with SMTP id ffacd0b85a97d-38a223fd65emr2840355f8f.47.1734697682184;
        Fri, 20 Dec 2024 04:28:02 -0800 (PST)
Received: from [192.168.0.123] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c84840asm3944688f8f.61.2024.12.20.04.28.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2024 04:28:01 -0800 (PST)
Message-ID: <5012d081-eae1-4424-9588-3dd8fc7d933e@blackwall.org>
Date: Fri, 20 Dec 2024 14:28:00 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/4] selftests: net: lib: Add a couple autodefer
 helpers
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>, Roopa Prabhu <roopa@nvidia.com>,
 bridge@lists.linux.dev, Ido Schimmel <idosch@nvidia.com>, mlxsw@nvidia.com,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
References: <cover.1734540770.git.petrm@nvidia.com>
 <856d9e01725fdba21b7f6716358f645b19131af2.1734540770.git.petrm@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <856d9e01725fdba21b7f6716358f645b19131af2.1734540770.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/18/24 19:15, Petr Machata wrote:
> Alongside the helper ip_link_set_up(), one to set the link down will be
> useful as well. Add a helper to determine the link state as well,
> ip_link_is_up(), and use it to short-circuit any changes if the state is
> already the desired one.
> 
> Furthermore, add a helper bridge_vlan_add().
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> ---
> CC: Shuah Khan <shuah@kernel.org>
> CC: linux-kselftest@vger.kernel.org
> 
> ---
>  tools/testing/selftests/net/lib.sh | 31 ++++++++++++++++++++++++++++--
>  1 file changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
> index 2cd5c743b2d9..0bd9a038a1f0 100644
> --- a/tools/testing/selftests/net/lib.sh
> +++ b/tools/testing/selftests/net/lib.sh
> @@ -477,12 +477,33 @@ ip_link_set_addr()
>  	defer ip link set dev "$name" address "$old_addr"
>  }
>  
> +ip_link_is_up()
> +{
> +	local name=$1; shift
> +
> +	local state=$(ip -j link show "$name" |
> +		      jq -r '(.[].flags[] | select(. == "UP")) // "DOWN"')
> +	[[ $state == "UP" ]]
> +}
> +
>  ip_link_set_up()
>  {
>  	local name=$1; shift
>  
> -	ip link set dev "$name" up
> -	defer ip link set dev "$name" down
> +	if ! ip_link_is_up "$name"; then
> +		ip link set dev "$name" up
> +		defer ip link set dev "$name" down
> +	fi
> +}
> +
> +ip_link_set_down()
> +{
> +	local name=$1; shift
> +
> +	if ip_link_is_up "$name"; then
> +		ip link set dev "$name" down
> +		defer ip link set dev "$name" up
> +	fi
>  }
>  
>  ip_addr_add()
> @@ -498,3 +519,9 @@ ip_route_add()
>  	ip route add "$@"
>  	defer ip route del "$@"
>  }
> +
> +bridge_vlan_add()
> +{
> +	bridge vlan add "$@"
> +	defer bridge vlan del "$@"
> +}

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


