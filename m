Return-Path: <linux-kselftest+bounces-32275-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0049AA7F71
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 May 2025 10:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15C829A3312
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 May 2025 08:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7491A5B89;
	Sat,  3 May 2025 08:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Tp7pcB2m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35EF4EEA9;
	Sat,  3 May 2025 08:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746261060; cv=none; b=MM1/rxGjPLXA+SWVnHmCxGlsu9dPQ8yqWEUXmZ0Sefjzlh+q147ji7LAWoBmF1HINKmcTz3h9aIXWzFiCNt3j4jOdWMahJszBd3CIXxNzFgYrRlPxAw8LDffABii7PwE07aBVK+3LCal4phGGslDyW9slXn7R25JpNyDSt5cUKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746261060; c=relaxed/simple;
	bh=+9t8qS20Rkc+3RP/ZNFnJXR+IwrPQ58ugGY1p6DrTU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NApwvuElakemeFbSpO7vkbvN7F5kBYjsZNH/DTwSWbPoxrxFHdShpiMtxZcQ4l6UU8Vmy4W3Uv6vPXqOEnNkzMgdS/koGHi+vuxWKY+kNMdHYBBX4kW38ZKWAZxclfmRGUGsW/nMAjWg9n1eqiMjKosUPAy7iNiE1xgAD/JIh5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Tp7pcB2m; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=inJYyFL1ypP2D4/JNOPoym7d5fTXv+XebkKdo5p9o4k=;
	b=Tp7pcB2m+iUS8/gRsCFq0VmZ+5s3pyiUQzCJS76O7S7vJPE1RcmURmykAnZxYu
	B+we2zAQj03zbf/Or8eKaSixForZ7Mr3gvsj3V9hDYqZp26muv3lF82OFMTnc1vH
	Z9IRj9iDEIhqDm01WfG8Er/GlwOpK38ml+K5+j+Wki2i0=
Received: from [192.168.31.211] (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wCnACYI1BVooLTAEA--.40108S2;
	Sat, 03 May 2025 16:30:01 +0800 (CST)
Message-ID: <1dcf5c8e-13c6-4969-90aa-a2b8d84050da@163.com>
Date: Sat, 3 May 2025 16:29:53 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] selftests: iou-zcrx: Clean up build warnings
 for error format
To: David Wei <dw@davidwei.uk>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Shuah Khan <shuah@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Simon Horman <horms@kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20250502175136.1122-1-haiyuewa@163.com>
 <12ecd375-441d-440d-bb63-d83651cbb049@davidwei.uk>
From: Haiyue Wang <haiyuewa@163.com>
In-Reply-To: <12ecd375-441d-440d-bb63-d83651cbb049@davidwei.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCnACYI1BVooLTAEA--.40108S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Xw4ftrW3XFy8ZFy8Ar17GFg_yoW8JF1Dpa
	yxtFyDCFW8GryUKFW7K393tw4xCrsrt3yrZ3y5A3Z8tFWUuFyqgrZIkry8KayDGr4I9a18
	ta90ya9xGF1jv3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UYJPiUUUUU=
X-CM-SenderInfo: 5kdl53xhzdqiywtou0bp/1tbiSgpCa2gVzCOtzAAAsa

On 2025/5/3 11:24, David Wei wrote:
> On 5/2/25 10:50, Haiyue Wang wrote:
>> Clean up two build warnings:
>>
>> [1]
>>
>> iou-zcrx.c: In function ‘process_recvzc’:
>> iou-zcrx.c:263:37: warning: too many arguments for format [-Wformat- 
>> extra-args]
>>    263 |                         error(1, 0, "payload mismatch at ", i);
>>        |                                     ^~~~~~~~~~~~~~~~~~~~~~
>>
>> [2] Use "%zd" for ssize_t type as better
>>
>> iou-zcrx.c: In function ‘run_client’:
>> iou-zcrx.c:357:47: warning: format ‘%d’ expects argument of type 
>> ‘int’, but argument 4 has type ‘ssize_t’ {aka ‘long int’} [-Wformat=]
>>    357 |                         error(1, 0, "send(): %d", sent);
>>        |                                              ~^   ~~~~
>>        |                                               |   |
>>        |                                               int ssize_t 
>> {aka long int}
>>        |                                              %ld
>>
>> Signed-off-by: Haiyue Wang <haiyuewa@163.com>
> 
>> ---
>> v2:
>>    - Dont't wrap the build warning message to make scripts/ 
>> checkpatch.pl happy,
>>      keep it as for readability.
>>    - Change the format for ssize_t from "%ld" to "%zd" as Simon 
>> suggested.
>>    - Change the target to net-next tree.
>> v1: https://lore.kernel.org/netdev/20250502042240.17371-1- 
>> haiyuewa@163.com/
> 
> Thanks for the cleanups. But next time please note that there is a 24h
> cooldown on respins in netdev.

Will take care next time. Thanks, David.

> 
> Reviewed-by: David Wei <dw@davidwei.uk>


