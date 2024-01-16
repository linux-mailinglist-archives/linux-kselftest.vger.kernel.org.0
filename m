Return-Path: <linux-kselftest+bounces-3065-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF58C82E973
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 07:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5FCC1C22B47
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 06:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF076DDB9;
	Tue, 16 Jan 2024 06:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Hd0eslxa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310D110A01;
	Tue, 16 Jan 2024 06:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705386015;
	bh=pjsKKV4erevQ59kr8iiq6uoSsFO4WReKv2BQv7eXbEM=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=Hd0eslxaoRusQrkK9ZN4tqXDR4xZ+8gAHhLkFbcthNjvI4D+VVkrIYQQXKm54AH7N
	 KkBtZDH7Tfjb8LDY29vfpL9dBw8MXEUySMoDxAy0vMNafHPssKsbj4Z5Pxo+Z7jzlt
	 Ol00mipSNeMHkEiEfm1Fgk/wKVH51jHNLnmviRU2/8XpBRfiR+zAaiXg1FWROMuhd6
	 +oh9u8vH3PQQPcZ/OAClCgwO4m4ZzhuLH46SpexZ6cxmSbyTndyfVr3XhOd4OnlZZy
	 waniWVx/aT+uxib0w47ley6VLqLFelbfSm7UmQkiKq5UDPqQK7H/eAKZOW4niHjnRP
	 Ia3/SMyuVMTAQ==
Received: from [100.96.234.34] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id EA4513780C13;
	Tue, 16 Jan 2024 06:20:12 +0000 (UTC)
Message-ID: <587055f7-58b6-4aa3-abf2-98ea602daa32@collabora.com>
Date: Tue, 16 Jan 2024 11:20:21 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, netdev@vger.kernel.org,
 edumazet@google.com, pabeni@redhat.com, j.vosburgh@gmail.com,
 andy@greyhouse.net, shuah@kernel.org, bpoirier@nvidia.com,
 jon.toppins+linux@gmail.com, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net] selftests: bonding: add missing build configs
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
References: <20240116020201.1883023-1-kuba@kernel.org>
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240116020201.1883023-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/16/24 7:02 AM, Jakub Kicinski wrote:
> bonding tests also try to create bridge, veth and dummy
> interfaces. These are not currently listed in config.
> 
> Fixes: bbb774d921e2 ("net: Add tests for bonding and team address list management")
> Fixes: c078290a2b76 ("selftests: include bonding tests into the kselftest infra")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Acked-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
> CC: j.vosburgh@gmail.com
> CC: andy@greyhouse.net
> CC: shuah@kernel.org
> CC: bpoirier@nvidia.com
> CC: jon.toppins+linux@gmail.com
> CC: linux-kselftest@vger.kernel.org
> ---
>  tools/testing/selftests/drivers/net/bonding/config | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/testing/selftests/drivers/net/bonding/config b/tools/testing/selftests/drivers/net/bonding/config
> index 70638fa50b2c..f85b16fc5128 100644
> --- a/tools/testing/selftests/drivers/net/bonding/config
> +++ b/tools/testing/selftests/drivers/net/bonding/config
> @@ -1,2 +1,5 @@
>  CONFIG_BONDING=y
> +CONFIG_BRIDGE=y
> +CONFIG_DUMMY=y
>  CONFIG_MACVLAN=y
> +CONFIG_VETH=y

-- 
BR,
Muhammad Usama Anjum

