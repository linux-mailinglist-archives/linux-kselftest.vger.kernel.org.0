Return-Path: <linux-kselftest+bounces-44635-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2A5C2AAA4
	for <lists+linux-kselftest@lfdr.de>; Mon, 03 Nov 2025 09:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 564731889713
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Nov 2025 08:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BA32E370E;
	Mon,  3 Nov 2025 08:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="sFhv3Gsf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044362DF6F8;
	Mon,  3 Nov 2025 08:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762160329; cv=none; b=CI7YD+AikEmu2uD2Bdk1Hm0VxkTIXSqtQjMN32qPX+mslVOhAujT3d8ZAzHjPa6g5tOLXFw/U1MpwplB9BgYhk40hwsJVGNzKpqduamodRJGhJmgvINoEmlimnZnPb9LdT/QIgH34VUB/xRE0nbgybyoES71n6QxrOxrHWKuQiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762160329; c=relaxed/simple;
	bh=JXPCsQTTxVnoh0TkP1LaQ3H1WCvGUkzl8sNo7rus+JQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pOdeot5EPzYYNJMcQVvhSoxckJc5xmfd4A/SNEcA5RwoGeAM0n4mcZr/Acv0vKqTFYMqx5tK3dRFi4ZQ7oG+KIYn8QvCQwFvz2U/jSM1KmrCp/X5E3u54gJZyy8OEDGCoPfQyMCzOsDUHpIvQXu7XoOcREUlg2WlzSPcMgx4lHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=sFhv3Gsf; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=vhZdASlHH+QeEq0UbVzWVoPF8l6AizkcGzyv7NcZ9Mk=;
	b=sFhv3GsfQN1H1yy+8lqdJs/YTjxE/ctYLlpRHqbIF1HL8eVbhAa3uTGbSJfEK7Ap7X5qK2Vn7
	symE54OrB7tDUT/1FniVkv2WM2Pe1+FwsRqZ2PoPlmHtorOtuW3sfSCwtF9Dw9DzF9laYu4UtYB
	rJ8NDNTnYlIDS1bk3vJFhtc=
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4d0QSk5RT4zLlVC;
	Mon,  3 Nov 2025 16:57:10 +0800 (CST)
Received: from dggpemf500016.china.huawei.com (unknown [7.185.36.197])
	by mail.maildlp.com (Postfix) with ESMTPS id 65DAE1A016C;
	Mon,  3 Nov 2025 16:58:44 +0800 (CST)
Received: from [10.174.177.19] (10.174.177.19) by
 dggpemf500016.china.huawei.com (7.185.36.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 3 Nov 2025 16:58:43 +0800
Message-ID: <2ea387c7-cd15-44cc-8789-af3fbe0460a3@huawei.com>
Date: Mon, 3 Nov 2025 16:58:42 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] selftests: netdevsim: Fix ethtool-features.sh fail
To: Sabrina Dubroca <sd@queasysnail.net>
CC: <kuba@kernel.org>, <andrew@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <pabeni@redhat.com>, <shuah@kernel.org>,
	<horms@kernel.org>, <netdev@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>
References: <20251030032203.442961-1-wangliang74@huawei.com>
 <aQPxN5lQui5j8nK8@krikkit>
From: Wang Liang <wangliang74@huawei.com>
In-Reply-To: <aQPxN5lQui5j8nK8@krikkit>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500016.china.huawei.com (7.185.36.197)


在 2025/10/31 7:13, Sabrina Dubroca 写道:
> 2025-10-30, 11:22:03 +0800, Wang Liang wrote:
>> This patch adds executable permission to script 'ethtool-features.sh', and
>> check 'ethtool --json -k' support.
> Those are two separate things, probably should be two separate patches.


Ok, I will extract the executable permission change to a new patch.

>
> [...]
>> @@ -7,6 +7,11 @@ NSIM_NETDEV=$(make_netdev)
>>   
>>   set -o pipefail
>>   
>> +if ! ethtool --json -k $NSIM_NETDEV > /dev/null 2>&1; then
> I guess it's improving the situation, but I've got a system with an
> ethtool that accepts the --json argument, but silently ignores it for
>   -k (ie `ethtool --json -k $DEV` succeeds but doesn't produce a json
> output), which will still cause the test to fail later.


That is indeed a bit strange.

I'm not sure the best way to handle this situation now. Maybe update ethtool
instead of checking the output is not a bad method.


