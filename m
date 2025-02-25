Return-Path: <linux-kselftest+bounces-27526-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66206A44B7B
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 20:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40BF97A8DC9
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 19:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A727520CCEA;
	Tue, 25 Feb 2025 19:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="NSZHyqkx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx25lb.world4you.com (mx25lb.world4you.com [81.19.149.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC46020C006;
	Tue, 25 Feb 2025 19:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740512375; cv=none; b=WIgPDOBp5OzShCh5/uizX45sxIvj3yNw6CHd2v2jjptSjEhKlpHe/oR2yzGUZrTa6GIbhVmskNIYcVtFjVrrjA5ZBtQffwBtrsgnQxsyEa5bWbu16FSkX8wOZr6sfzvu27aS7bVeeJ+WXNdJ6qdgq0nIiaqXZQZ5YqOqgpqNxLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740512375; c=relaxed/simple;
	bh=Xvt8IjPQniAU3unHdTZNJ7+x2xb6VbQHY3p2fi8W+EQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hy9vqKpWpJ6eckuR9YYG7b705V0yVkYrZ5RbiFwK0Uf2XCBBqaDI+lskqsPmgSlb1yOdpOD2wPEdHYV8D/lk85lyk2KNdMx0+dqHFukZp+P5Cr2GAQ4k3KvkIGCLcrIlNCqxVkANgnbTA3E+aq3naD26VLDL4yrpMl76+DRqodI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=NSZHyqkx; arc=none smtp.client-ip=81.19.149.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4kLJhwKp4a4wG/8lLsj5hZ9Nkskn7kgFDs+gfjkBo4s=; b=NSZHyqkxgDLzxO93hgamLOrlIJ
	zM+fgXC2R6B9QK0a5KlebUd9xD+0F7OBzc9edJuaQZ/OzGobQPZ8Uolv9zMWIDhFingFAOw24LhDw
	9LHjOO4LDVIZh4g6qLz3owCRtSiaBoI3sxW4fMcP4KyKvMPeiNLepUkVF513HIi28OxY=;
Received: from [88.117.55.1] (helo=[10.0.0.160])
	by mx25lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1tn0Xc-000000003XD-0rtK;
	Tue, 25 Feb 2025 20:24:28 +0100
Message-ID: <085f0a9b-654d-4ce7-986c-043a6ca135de@engleder-embedded.com>
Date: Tue, 25 Feb 2025 20:24:26 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] selftests: drv-net: Check if combined-count exists
To: Joe Damato <jdamato@fastly.com>
Cc: dw@davidwei.uk, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Shuah Khan <shuah@kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
References: <20250225181455.224309-1-jdamato@fastly.com>
Content-Language: en-US
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <20250225181455.224309-1-jdamato@fastly.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes

On 25.02.25 19:14, Joe Damato wrote:
> Some drivers, like tg3, do not set combined-count:
> 
> $ ethtool -l enp4s0f1
> Channel parameters for enp4s0f1:
> Pre-set maximums:
> RX:		4
> TX:		4
> Other:		n/a
> Combined:	n/a
> Current hardware settings:
> RX:		4
> TX:		1
> Other:		n/a
> Combined:	n/a
> 
> In the case where combined-count is not set, the ethtool netlink code
> in the kernel elides the value and the code in the test:
> 
>    netnl.channels_get(...)
> 
> With a tg3 device, the returned dictionary looks like:
> 
> {'header': {'dev-index': 3, 'dev-name': 'enp4s0f1'},
>   'rx-max': 4,
>   'rx-count': 4,
>   'tx-max': 4,
>   'tx-count': 1}
> 
> Note that the key 'combined-count' is missing. As a result of this
> missing key the test raises an exception:
> 
>   # Exception|     if channels['combined-count'] == 0:
>   # Exception|        ~~~~~~~~^^^^^^^^^^^^^^^^^^
>   # Exception| KeyError: 'combined-count'
> 
> Change the test to check if 'combined-count' is a key in the dictionary
> first and if not assume that this means the driver has separate RX and
> TX queues.
> 
> With this change, the test now passes successfully on tg3 and mlx5
> (which does have a 'combined-count').
> 
> Fixes: 1cf270424218 ("net: selftest: add test for netdev netlink queue-get API")
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---
>   tools/testing/selftests/drivers/net/queues.py | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/queues.py b/tools/testing/selftests/drivers/net/queues.py
> index 38303da957ee..baa8845d9f64 100755
> --- a/tools/testing/selftests/drivers/net/queues.py
> +++ b/tools/testing/selftests/drivers/net/queues.py
> @@ -45,10 +45,13 @@ def addremove_queues(cfg, nl) -> None:
>   
>       netnl = EthtoolFamily()
>       channels = netnl.channels_get({'header': {'dev-index': cfg.ifindex}})
> -    if channels['combined-count'] == 0:
> -        rx_type = 'rx'
> +    if 'combined-count' in channels:
> +        if channels['combined-count'] == 0:
> +            rx_type = 'rx'
> +        else:
> +            rx_type = 'combined'
>       else:
> -        rx_type = 'combined'
> +        rx_type = 'rx'
>   
>       expected = curr_queues - 1
>       cmd(f"ethtool -L {cfg.dev['ifname']} {rx_type} {expected}", timeout=10)
> 
> base-commit: bc50682128bde778a1ddc457a02d92a637c20c6f

Reviewed-by: Gerhard Engleder <gerhard@engleder-embedded.com>

