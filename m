Return-Path: <linux-kselftest+bounces-45395-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A79C51D26
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 12:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A27E618959D8
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 11:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDAB30B53B;
	Wed, 12 Nov 2025 11:03:05 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720D4307AD2;
	Wed, 12 Nov 2025 11:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762945385; cv=none; b=gbRMYfRKsPWn9W4Ib0yVzStN7IY4tzh3kdOLT6lSAwPDfJgnMIK57CU/JaCBBah/1T9yNZ9PXHHoruB2YQafmO4eeJFc65iomaiw5jn3EeaZCGzdfhe2HfZ0YDu8oIqfIcPY9Gh3kckLllwlWb52mwc+vO1L3L7eQ6YHBQs1usA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762945385; c=relaxed/simple;
	bh=mRdHHDT+l/aWNe5U39cCXkYuFI9jtrvAfepTP4K14T0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PzAhUTMwQS3lGz8oUqZv31I0w5mvxjlWK1E5C+E68SfbPQwZCB82k2jXSmocTkQ5KuQm/Mm6eWxIFxjGZu0APzrOHjtWD9rvWpObKmKsZpPnjXWXeS/HKQ09MLJQaexh7nmbZtgtBNjWNlaUqVk7GQ7lMk5eWlpkgwjKgIwYb4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4d60qB2kHfzYQtlJ;
	Wed, 12 Nov 2025 19:02:30 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A9CC81A07BB;
	Wed, 12 Nov 2025 19:02:58 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgCnzlthaRRpHJ7tAQ--.24376S2;
	Wed, 12 Nov 2025 19:02:58 +0800 (CST)
Message-ID: <8e4de6bc-1398-48f5-aaed-b366ed1b771b@huaweicloud.com>
Date: Wed, 12 Nov 2025 19:02:57 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] cpuset: Avoid unnecessary partition invalidation
To: Sun Shaojie <sunshaojie@kylinos.cn>
Cc: longman@redhat.com, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com,
 shuah@kernel.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <b9dce00a-4728-4ac8-ae38-7f41114c7c81@redhat.com>
 <20251112094610.386299-1-sunshaojie@kylinos.cn>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20251112094610.386299-1-sunshaojie@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCnzlthaRRpHJ7tAQ--.24376S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXr13uw4DCFW8uFW5Gry8Zrb_yoW5Gw43pF
	WDKw4Yya95WrySkw42yw1xWFWFyan7ursrJr15Jr4xu3yUur1vyFn0ya98W3W3W3s8Xa4Y
	vrWDK3s3ZFn8AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU17KsUUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/11/12 17:46, Sun Shaojie wrote:
> Hi Ridong,
> 
> Thank you for your response.
> 
>>From your reply "in case 1, A1 can also be converted to a partition," I 
> realize there might be a misunderstanding. The scenario I'm addressing 
> involves two sibling cgroups where one is an effective partition root and 
> the other is not, and both have empty cpuset.cpus.exclusive. Let me 
> explain the intention behind case 1 in detail, which will also illustrate 
> why this has negative impacts on our product.
> 

I think I understand what you mean.

> In case 1, after #3 completes, A1 is already a valid partition root - this 
> is correct.After #4, B1 was generated, and B1 is no-exclusive. After #5, 
> A1 changes from "root" to "root invalid". But A1 becoming "root invalid" 
> could be unnecessary because having A1 remain as "root" might be more 
> acceptable. Here's the analysis:
> 

What I want to note is this: what if we run echo root > /sys/fs/cgroup/B1/cpuset.cpus.partition
after step #5? There’s no conflict check when enabling the partition.

> As documented in cgroup-v2.rst regarding cpuset.cpus: "The actual list of 
> CPUs to be granted, however, is subjected to constraints imposed by its 
> parent and can differ from the requested CPUs". This means that although 
> we're requesting CPUs 0-3 for B1, we can accept that the actual available 
> CPUs in B1 might not be 0-3.
> 
> Based on this characteristic, in our product's implementation for case 1, 
> before writing to B1's cpuset.cpus in #5, we check B1's parent 
> cpuset.cpus.effective and know that the CPUs available for B1 don't include 
> 0-1 (since 0-1 are exclusively used by A1). However, we still want to set 
> B1's cpuset.cpus to 0-3 because we hope that when 0-1 become available in 
> the future, B1 can use them without affecting the normal operation of other 
> cgroups.
> 
> The reality is that because B1's requested cpuset.cpus (0-3) conflicts with 
> A1's exclusive CPUs (0-1) at that moment, it destroys the validity of A1's 
> partition root. So why must the current rule sacrifice A1's validity to 
> accommodate B1's CPU request? In this situation, B1 can clearly use 2-3 
> while A1 exclusively uses 0-1 - they don't need to conflict.
> 
> This patch narrows the exclusivity conflict check scope to only between 
> partitions. Moreover, user-specified CPUs (including cpuset.cpus and 
> cpuset.cpus.exclusive) only have true exclusive meaning within effective 
> partitions. So why should the current rule perform exclusivity conflict 
> checks between an exclusive partition and a non-exclusive member? This is 
> clearly unnecessary.
> 
> Thanks
> Sun Shaojie

-- 
Best regards,
Ridong


