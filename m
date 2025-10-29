Return-Path: <linux-kselftest+bounces-44254-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B60EC18CDC
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 08:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D4441892E42
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 07:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDCF30FF10;
	Wed, 29 Oct 2025 07:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="34+pqqiA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B2B253B71;
	Wed, 29 Oct 2025 07:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761724581; cv=none; b=Da5pvXBM6b28iUKBfM8bHWxcDTvtP5ml0AfpszLO3SQmTTYJ2o1DgTpKj8wOq3TkDBaBz0pqAWUqA7UEPtXHKcpWIneTRNZ/JUe4o59TJUeGV1f5Njn8uJgVHSYljEcjuKDj83JZ6Seo8yeviPtsbGKkLrtNkZ07gRQgpc9jXjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761724581; c=relaxed/simple;
	bh=yq5i/1jdK4GAdk/5gCKcUxzz6h9TQBP5e3VMa+tJ48c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jYjLMCE13cEGQcWPPRdczCwjhbY6UgBY8Sji3B9l5sfIN+m4ykzT28+mv4MVkfKEE+FWCZsnjlsgzQjh5PTbpneD41Fn5FrEmx/zPEW72PaOh3LTqBTJDVCdSuRxBp3/iFBQfKIcucWpYUAXc+66+PuatCRAm4EoxkNKPhexowo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=34+pqqiA; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=vuHKXm+OhQijHCGxbJTJ7gKVGu/cyR9t2WAMa/3qIME=;
	b=34+pqqiAaUgpKjc0zQxXqV5Ay+UUIAS5jzBDK/oAvbWPu2Bp347b/gH29D8uVWd9xBPWVjC+1
	hVVt0oGQXvWfZ/QkLnPzub9kgOsrIqZ1DCIfwKFG7+zaeUE4kFvK/ZCie55YGmCeiwqXuDfJFcT
	W3rf4E+rGPYpl9u+5qeCpjk=
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4cxKL01jyFz12LFQ;
	Wed, 29 Oct 2025 15:55:36 +0800 (CST)
Received: from dggpemf500016.china.huawei.com (unknown [7.185.36.197])
	by mail.maildlp.com (Postfix) with ESMTPS id 7E08F180B5A;
	Wed, 29 Oct 2025 15:56:13 +0800 (CST)
Received: from [10.174.177.19] (10.174.177.19) by
 dggpemf500016.china.huawei.com (7.185.36.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 29 Oct 2025 15:56:12 +0800
Message-ID: <0feb2a87-b93d-4a99-9180-03a9ccab562e@huawei.com>
Date: Wed, 29 Oct 2025 15:56:11 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] selftests: netdevsim: Fix ethtool-coalesce.sh fail by
 installing ethtool-common.sh
To: Simon Horman <horms@kernel.org>
CC: <kuba@kernel.org>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <pabeni@redhat.com>, <shuah@kernel.org>,
	<acardace@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>
References: <20251027043007.1315917-1-wangliang74@huawei.com>
 <aQD52zzmW1YDC1iH@horms.kernel.org>
From: Wang Liang <wangliang74@huawei.com>
In-Reply-To: <aQD52zzmW1YDC1iH@horms.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500016.china.huawei.com (7.185.36.197)


在 2025/10/29 1:14, Simon Horman 写道:
> On Mon, Oct 27, 2025 at 12:30:07PM +0800, Wang Liang wrote:
>> The script "ethtool-common.sh" is not installed in INSTALL_PATH, and
>> triggers some errors when I try to run the test
>> 'drivers/net/netdevsim/ethtool-coalesce.sh':
>>
>>    TAP version 13
>>    1..1
>>    # timeout set to 600
>>    # selftests: drivers/net/netdevsim: ethtool-coalesce.sh
>>    # ./ethtool-coalesce.sh: line 4: ethtool-common.sh: No such file or directory
>>    # ./ethtool-coalesce.sh: line 25: make_netdev: command not found
>>    # ethtool: bad command line argument(s)
>>    # ./ethtool-coalesce.sh: line 124: check: command not found
>>    # ./ethtool-coalesce.sh: line 126: [: -eq: unary operator expected
>>    # FAILED /0 checks
>>    not ok 1 selftests: drivers/net/netdevsim: ethtool-coalesce.sh # exit=1
>>
>> Install this file to avoid this error. After this patch:
>>
>>    TAP version 13
>>    1..1
>>    # timeout set to 600
>>    # selftests: drivers/net/netdevsim: ethtool-coalesce.sh
>>    # PASSED all 22 checks
>>    ok 1 selftests: drivers/net/netdevsim: ethtool-coalesce.sh
>>
>> Fixes: fbb8531e58bd ("selftests: extract common functions in ethtool-common.sh")
>> Signed-off-by: Wang Liang <wangliang74@huawei.com>
>> ---
>>   tools/testing/selftests/drivers/net/netdevsim/Makefile | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/tools/testing/selftests/drivers/net/netdevsim/Makefile b/tools/testing/selftests/drivers/net/netdevsim/Makefile
>> index daf51113c827..653141a654a0 100644
>> --- a/tools/testing/selftests/drivers/net/netdevsim/Makefile
>> +++ b/tools/testing/selftests/drivers/net/netdevsim/Makefile
>> @@ -20,4 +20,6 @@ TEST_PROGS := \
>>   	udp_tunnel_nic.sh \
>>   # end of TEST_PROGS
>>   
>> +TEST_FILES := ethtool-common.sh
>> +
>>   include ../../../lib.mk
> Hi Wang Liang,
>
> As per commit f07f91a36090 ("selftests: net: unify the Makefile formats")
> I think the desired format is as follows (completely untested!):
>
> TEST_FILES := \
> 	ethtool-common.sh \
> # end of TEST_PROGS


Thanks for the reminder!

I will correct it, and send v2 later.

------
Best regards
Wang Liang

>

