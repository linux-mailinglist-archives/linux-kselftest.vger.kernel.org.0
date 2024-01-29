Return-Path: <linux-kselftest+bounces-3689-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0368405DA
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jan 2024 13:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC674286C61
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jan 2024 12:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22A66169C;
	Mon, 29 Jan 2024 12:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="SWhncKUz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B637627FE
	for <linux-kselftest@vger.kernel.org>; Mon, 29 Jan 2024 12:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706533062; cv=none; b=RkuyorMNl8EvpgmyTqIT+X9z3gdB8A24FlJKWE0p5jPV62UM5B7CaI+6HBKqVfBW1t4ZmsBUbuTyn19nhyJNK45GvC+W58LjS7/464pxD0m9tM71LLYdloOBM0blA8J6fbMYBPAjQboMjVEG//ZpOeSQQGi9v6QjwPodVHBlm5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706533062; c=relaxed/simple;
	bh=jaSVy865bX2h0rDCCQjc6YRKM4sXBr/GM085I53ttuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=amPFG5o8XFR9uvrk6XFwyfyeGxo4mfd2Kgo+irKZJJon32n1Us5vxVBBF+m4C+M9o4s63+w5MrzpG87wS1R6R2nM8BH3A7rzmRjgF2H6NrI+PR96gF22XoFu43gDmxJA/kA/hbJrTKI7TK8pu/hhr1jpa+o6rgF5E9xM0+/n790=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=SWhncKUz; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40eec4984acso20683045e9.2
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Jan 2024 04:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1706533058; x=1707137858; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aqxNquXcZc/iMCQgohYDDCtNK5elbT4Q7Xj7LgmBBJk=;
        b=SWhncKUzn9ZfTqBGJTrUW3wSCBS3QZUguiLk47VpOIjUAKHcYl8ndCbAGQkrHmDABs
         KNvWPUmHAgZh4N0jlxkmslEOQNh+cb85yDjuGmUGHb4NnMPJZWFuRcoD9DYUB8DhhOGP
         zlEKBrjBPbIquQ25nbPnZTFeSPqnIv8dDzt1w1hB278XfMJYztFRaFk28Zm2vGXcX5Bs
         Hd/QM4SbFdjazJsU+6ekpk4uOIhmLllZluvHMXHUVGMdY/FlUsA7eEaaskeQytNtnZHS
         LmyK5CDydIdYS6MuDJLiZeuFStnZFG9Nogz0YKsSBchGIDP3sfUbU9LGlbHxvua6qK+2
         Q/xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706533058; x=1707137858;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aqxNquXcZc/iMCQgohYDDCtNK5elbT4Q7Xj7LgmBBJk=;
        b=cvNaxhcnTo8nwpJ0nkQKaKb5qBFsBCiKdet21EGVrR/qow/faxrzguOBie0IzYLK1M
         S5vDtiMk/EtKtS7Lz5NPx2PoImW8mLZLklBS4ey4plSeU8+O/3etQ6ZFEh6koCH5DAVQ
         1lPHxdQ5C5CSEf4RjRYMnjKq/EOkA0UXEoXhrXmsNqANt4EF4Ech13ZwQFcNnnQsnJPr
         eDX2J/w/6f8yQSz+CwsLouQeDACS49UXaSZzXZc9Ja7sNmADBWsUKmZIfzItglPGi4rB
         unMoANCp3HiL5TdF51u8sYuUCDgfX+kcg+zvuLvBmAPYBYm05TvDw4PgQiVMdizGCIOO
         SK7Q==
X-Gm-Message-State: AOJu0YzDWnRs3tgPYKkPX50LlcZ8DdIQeaqb3Fo8YHUix8aE4N4K8gGo
	P8sO8FE0M3k7f4jxj1caUrHDPmPhI+PNalFOSEgWtvZHK0+Y83MfPPwNI2XfjpE=
X-Google-Smtp-Source: AGHT+IH0MQRMcyCA7TLF3/ASPrvl2a2Ii5rt2dOkvRyrr8WPt22HO4ODHhv4+2y4JDYNI0f/7TJ0EA==
X-Received: by 2002:a05:6000:178a:b0:33a:ec16:3d50 with SMTP id e10-20020a056000178a00b0033aec163d50mr2961631wrg.68.1706533058420;
        Mon, 29 Jan 2024 04:57:38 -0800 (PST)
Received: from [192.168.0.161] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id b12-20020a05600010cc00b0033af341d478sm1448356wrx.43.2024.01.29.04.57.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 04:57:37 -0800 (PST)
Message-ID: <1f168109-c5b6-4a64-a5b8-7732858c8797@blackwall.org>
Date: Mon, 29 Jan 2024 14:57:36 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] selftests: net: Add missing matchall classifier
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, shuah@kernel.org
References: <20240129123703.1857843-1-idosch@nvidia.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240129123703.1857843-1-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/01/2024 14:37, Ido Schimmel wrote:
> One of the test cases in the test_bridge_backup_port.sh selftest relies
> on a matchall classifier to drop unrelated traffic so that the Tx drop
> counter on the VXLAN device will only be incremented as a result of
> traffic generated by the test.
> 
> However, the configuration option for the matchall classifier is
> missing from the configuration file which might explain the failures we
> see in the netdev CI [1].
> 
> Fix by adding CONFIG_NET_CLS_MATCHALL to the configuration file.
> 
> [1]
>  # Backup nexthop ID - invalid IDs
>  # -------------------------------
>  [...]
>  # TEST: Forwarding out of vx0                                         [ OK ]
>  # TEST: No forwarding using backup nexthop ID                         [ OK ]
>  # TEST: Tx drop increased                                             [FAIL]
>  # TEST: IPv6 address family nexthop as backup nexthop                 [ OK ]
>  # TEST: No forwarding out of swp1                                     [ OK ]
>  # TEST: Forwarding out of vx0                                         [ OK ]
>  # TEST: No forwarding using backup nexthop ID                         [ OK ]
>  # TEST: Tx drop increased                                             [FAIL]
>  [...]
> 
> Fixes: b408453053fb ("selftests: net: Add bridge backup port and backup nexthop ID test")
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
> Jakub, you can apply to net if you want to, but I'm sending this to
> net-next since I want to see if it helps the CI. I'm unable to reproduce
> this locally.
> ---
>  tools/testing/selftests/net/config | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
> index 19ff75051660..2bd5f9033ade 100644
> --- a/tools/testing/selftests/net/config
> +++ b/tools/testing/selftests/net/config
> @@ -68,6 +68,7 @@ CONFIG_MPLS_ROUTING=m
>  CONFIG_MPLS_IPTUNNEL=m
>  CONFIG_NET_SCH_INGRESS=m
>  CONFIG_NET_CLS_FLOWER=m
> +CONFIG_NET_CLS_MATCHALL=m
>  CONFIG_NET_ACT_TUNNEL_KEY=m
>  CONFIG_NET_ACT_MIRRED=m
>  CONFIG_BAREUDP=m

Thanks,
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

