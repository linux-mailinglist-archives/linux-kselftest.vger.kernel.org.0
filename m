Return-Path: <linux-kselftest+bounces-42974-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B9266BCEECD
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Oct 2025 05:26:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A96F74E3007
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Oct 2025 03:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B54B1C5F13;
	Sat, 11 Oct 2025 03:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="MBf0e9+3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539A317597;
	Sat, 11 Oct 2025 03:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760153182; cv=none; b=sF/xmXBXLfaREChHzp2dseSBruqXzI6S4qqpmeEZU1zMZDEkTotH1TlWWq7UQdtTyA5fMPHesZNYJLEx6bKnSGxee4zL2BT9wRPmwL/PcStteyhsoCz4ZAgkmi669bo6/Cggo6s5AEZUo4zyUZGWJ9N5Xp3/5B5pIWNq1Ym/0Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760153182; c=relaxed/simple;
	bh=nDN+5xwyCF0PzNnG3wQBuDTx5chaq0N8vuyoQBLAorM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Qz3ytZJDObpRA3+oni3SL4RjnVTLGOFPMs66hoz1i8N4p3r+F0u3UB6WFcjei5fFOb/EJg5Sq+TNwTYBvkp8eT7C2B3M6tVpilQX1WGRzH3tcfwYi4rmzjOhFZtz/0ryDiXBikprBGyrdU6vZxURokyK8Q0WrYwgM8kaZRmfOnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=MBf0e9+3; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=H2iiEAPwBLPH0DGUvQ4cdjgQFvnaTKNZCAyEXAhXuH0=;
	b=MBf0e9+3pDboDOYgh/7lHFJC38mleEubiG/+/Gi19Xko4vbIDRUPtbO/jblFkfKpMxmHV8MaV
	bYGeMw/iiRBpyTltMRPXh0mMyMneKt2m2CpgovLLOmJWKa9zRVVpKutAsCZcZ/nBNlLjm3GO/pP
	W30R7TbjZOVlQCxCV0B4/dQ=
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4ck8C53rG4z1K97q;
	Sat, 11 Oct 2025 11:25:53 +0800 (CST)
Received: from dggpemf500016.china.huawei.com (unknown [7.185.36.197])
	by mail.maildlp.com (Postfix) with ESMTPS id 8A06B180043;
	Sat, 11 Oct 2025 11:26:10 +0800 (CST)
Received: from [10.174.177.19] (10.174.177.19) by
 dggpemf500016.china.huawei.com (7.185.36.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 11 Oct 2025 11:26:09 +0800
Message-ID: <61c106d9-6ea9-4ed4-ae01-267e6691e80b@huawei.com>
Date: Sat, 11 Oct 2025 11:26:08 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] selftests: net: check jq command is supported
To: Paolo Abeni <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <yuehaibing@huawei.com>,
	<zhangchangzhong@huawei.com>
References: <20251010033043.140501-1-wangliang74@huawei.com>
 <bd3149e8-e213-48b0-8f8a-0888d1837b84@redhat.com>
From: Wang Liang <wangliang74@huawei.com>
In-Reply-To: <bd3149e8-e213-48b0-8f8a-0888d1837b84@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500016.china.huawei.com (7.185.36.197)


在 2025/10/10 22:56, Paolo Abeni 写道:
> On 10/10/25 5:30 AM, Wang Liang wrote:
>> The jq command is used in vlan_bridge_binding.sh, if it is not supported,
>> the test will spam the following log.
>>
>>    # ./vlan_bridge_binding.sh: line 51: jq: command not found
>>    # ./vlan_bridge_binding.sh: line 51: jq: command not found
>>    # ./vlan_bridge_binding.sh: line 51: jq: command not found
>>    # ./vlan_bridge_binding.sh: line 51: jq: command not found
>>    # ./vlan_bridge_binding.sh: line 51: jq: command not found
>>    # TEST: Test bridge_binding on->off when lower down                   [FAIL]
>>    #       Got operstate of , expected 0
>>
>> The rtnetlink.sh has the same problem. It makes sense to check if jq is
>> installed before running these tests. After this patch, the
>> vlan_bridge_binding.sh skipped if jq is not supported:
>>
>>    # timeout set to 3600
>>    # selftests: net: vlan_bridge_binding.sh
>>    # TEST: jq not installed                                              [SKIP]
>>
>> Signed-off-by: Wang Liang <wangliang74@huawei.com>
> This looks more a fix than net-next material (and net-next is currently
> closed for the merge window).
>
> Please re-post for net including suitable fixes tag(s). You can retain
> Hangbin's ack.
>
> Thanks,
>
> Paolo


Thanks for your reminder!

I missed the ANN e-mail when I was in Chinese National Day vacation. I will
repost this patch for net later.

------
Best regards
Wang Liang

>

