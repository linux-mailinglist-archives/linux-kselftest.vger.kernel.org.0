Return-Path: <linux-kselftest+bounces-42564-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA88BA7CCC
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Sep 2025 04:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFF637A9FBC
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Sep 2025 02:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BADC1DE3C0;
	Mon, 29 Sep 2025 02:26:13 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70152C859;
	Mon, 29 Sep 2025 02:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759112773; cv=none; b=KcsltDzyLrH5+LS55t3EYcqAhfaATWWMwwcicfNIL8BJ9qryr789SLQLnLskfoRCOvSYKrdTxENe4xumJWymJQh938wZHvCT148cPr3gNO2PHanmz2X8k+4O8vpHOZBnhewyxDZK2hroIpZUqJvLUugxnwX7UiyO/bi04FgJPEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759112773; c=relaxed/simple;
	bh=a5Wfg5tELcz7AuujkhJoAqJQqCx9KPDs8icoLZ84UKc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=gehorBzm5NzwP1WV8bSCHyp5cQf54z8/Pm9J2zcVGyJ5AJ7dGwCiaPYegEcN33wXan5rdVgi8nYwug66/ztdzaUpwN5+h+I1kRv4olvsyHoSmsYwa+OsdlsdBjIdLJSq9vPo1SbdDydx7BobJFY0+8Qlvb5h1k14nqqjQSnYzQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4cZlRP2TjVzYQv4y;
	Mon, 29 Sep 2025 10:25:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 8CA2E1A16AA;
	Mon, 29 Sep 2025 10:26:08 +0800 (CST)
Received: from [10.67.111.192] (unknown [10.67.111.192])
	by APP3 (Coremail) with SMTP id _Ch0CgCHHz5A7tlodzydBA--.36317S2;
	Mon, 29 Sep 2025 10:26:08 +0800 (CST)
Message-ID: <68865683-6f2d-4971-a3cc-8d7ce2533eb7@huaweicloud.com>
Date: Mon, 29 Sep 2025 10:26:08 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/3] bpf: Add overwrite mode for bpf ring
 buffer
Content-Language: en-US
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Yonghong Song <yhs@fb.com>, Song Liu <song@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Willem de Bruijn <willemb@google.com>,
 Jason Xing <kerneljasonxing@gmail.com>,
 Paul Chaignon <paul.chaignon@gmail.com>, Tao Chen <chen.dylane@linux.dev>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin Kelly <martin.kelly@crowdstrike.com>
References: <20250905150641.2078838-1-xukuohai@huaweicloud.com>
 <20250905150641.2078838-2-xukuohai@huaweicloud.com>
 <CAEf4BzaSEjQzF47BZeh0de9pFbKpaB8JqCs629hV9xZDhMyTgw@mail.gmail.com>
 <9c0b56b1-168f-4970-a945-e4440c9e0d9f@huaweicloud.com>
In-Reply-To: <9c0b56b1-168f-4970-a945-e4440c9e0d9f@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgCHHz5A7tlodzydBA--.36317S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYV7kC6x804xWl14x267AKxVW5JVWrJwAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4
	x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
	64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r
	1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kI
	c2xKxwCF04k20xvY0x0EwIxGrwCF54CYxVCY1x0262kKe7AKxVW8ZVWrXwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x07UdxhLUUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

On 9/29/2025 10:22 AM, Xu Kuohai wrote:
> On 9/20/2025 6:10 AM, Andrii Nakryiko wrote:
>> On Fri, Sep 5, 2025 at 8:13 AM Xu Kuohai <xukuohai@huaweicloud.com> wrote:
>>>
>>> From: Xu Kuohai <xukuohai@huawei.com>
>>>
>>> When the bpf ring buffer is full, new events can not be recorded util
>>
>> typo: until
>>
> 
> ACK
> 

[...]

oops, I wasn’t done with my reply and hit send by mistake.
Please ignore it, thanks!


