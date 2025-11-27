Return-Path: <linux-kselftest+bounces-46600-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2573AC8C9E7
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 02:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A2D0D3509F7
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 01:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7862723D2B4;
	Thu, 27 Nov 2025 01:57:16 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C36239594;
	Thu, 27 Nov 2025 01:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764208636; cv=none; b=eV4bRI+6g7Yqtxm14uWvB83+iodVKqsPOQT+x/NJagHl51ootWAgo8lJdbEWg1/znWXm+ycEDwFAG2HdinVGY0HBg+97+c/wgqT0yifJsB+/QhWmTzO94XffLTw6kSjAroyeYMkW5gAGFdMoiUJzNJihfRlAycGe9ZoXnWlAo/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764208636; c=relaxed/simple;
	bh=J+R2CqnwfsgWsmllI+loPgRfxWnnYZ22nUTCkSbhEGU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aAa2uckHtxy0aKski2O6kpLkuqhsTkzuDUWRPyURNwkOtHm4I3kBIvTLngb8eyA8RYkn0z/D5MR+c+fVMG0uto7Thw3ROVgsOqZh4eKYa9w+xffWNl3GTZq5XRRmAWKPI7m8vhXkKzfAR83w8bN7l6jgS170KT5guKYdWV/kDE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dH00G4zj2zKHMS6;
	Thu, 27 Nov 2025 09:56:30 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 1AB121A0EBA;
	Thu, 27 Nov 2025 09:57:10 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP2 (Coremail) with SMTP id Syh0CgDHcHfzrydpMRCYCA--.64064S2;
	Thu, 27 Nov 2025 09:57:08 +0800 (CST)
Message-ID: <60aae228-9f3e-4511-8a92-7a7c4dea5e22@huaweicloud.com>
Date: Thu, 27 Nov 2025 09:57:07 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] cpuset: Avoid invalidating sibling partitions on
 cpuset.cpus conflict.
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Sun Shaojie <sunshaojie@kylinos.cn>
Cc: cgroups@vger.kernel.org, hannes@cmpxchg.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 llong@redhat.com, shuah@kernel.org, tj@kernel.org
References: <unk64xmcj5kt5c5gaauwaeld5qsshaldw7utgzk362w33y3zr7@s765trmj5ccs>
 <20251120130557.1554118-1-sunshaojie@kylinos.cn>
 <nfg4xqeoa4qqz7xypddzj756jhlsieeqfnpgvzwsltb7lnqz57@qgatuaufa7hq>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <nfg4xqeoa4qqz7xypddzj756jhlsieeqfnpgvzwsltb7lnqz57@qgatuaufa7hq>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgDHcHfzrydpMRCYCA--.64064S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CFyrtrykJr1kZr4rAw4Dtwb_yoW8KrW3pF
	W8KFn7Kw4Fqr1rJws2qw4xuF47tws7uF17JF98Gr18ZwsrCFyIkF4vyrZI9FWfX3s8Gw1j
	v3y29r4YvFWDuF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUbmii3UUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/11/26 22:13, Michal Koutný wrote:
> On Thu, Nov 20, 2025 at 09:05:57PM +0800, Sun Shaojie <sunshaojie@kylinos.cn> wrote:
>>> Do you actually want to achieve this or is it an implementation
>>> side-effect of the Case 1 scenario that you want to achieve?
>>
>> Yes, this is indeed the functionality I intended to achieve, as I find it 
>> follows the same logic as Case 1.
> 
> So you want to achieve a stable [1] set of CPUs for a cgroup that cannot
> be taken away from you by any sibling, correct?
> My reasoning is that the siblings should be under one management entity
> and therefore such overcommitment should be avoided already in the
> configuration. Invalidating all conflicting siblings is then the most
> fair result achievable.
> B1 is a second-class partition _only_ because it starts later or why is
> it OK to not fulfill its requirement?
> 
> [1] Note that A1 should still watch its cpuset.cpus.partition if it
> takes exclusivity seriously because its cpus may be taken away by
> hot(un)plug or ancestry reconfiguration.
> 	
> 
>> As for your point that "the effective config cannot be derived just from 
>> the applied values," even before this patch, we couldn't derive the final 
>> effective configuration solely from the applied values.
>>
>> For example, consider the following scenario: (not apply this patch)
>> Table 1:
>>  Step                                       | A1's prstate | B1's prstate |
>>  #1> echo "0-1" > A1/cpuset.cpus            | member       | member       |
>>  #2> echo "root" > A1/cpuset.cpus.partition | root         | member       |
>>  #3> echo "1-2" > B1/cpuset.cpus            | root invalid | member       |
>>
>> Table 2:
>>  Step                                       | A1's prstate | B1's prstate |
>>  #1> echo "1-2" > B1/cpuset.cpus            | member       | member       |
>>  #2> echo "root" > A1/cpuset.cpus.partition | root invalid | member       |
>>  #3> echo "0-1" > A1/cpuset.cpus            | root         | member       |
>>
>> After step #3, both Table 1 and Table 2 have identical value settings, 
>> yet A1's partition state differs between them.
> 

A corner case should be fixed, and I have sent the patch.

https://lore.kernel.org/cgroups/20251115093140.1121329-1-chenridong@huaweicloud.com/

> Aha, I must admit I didn't expect that. IMO, nothing (documented)
> prevents the latter (Table 2) behavior (here I'm referring to
> cpuset.cpus, not sure about cpuset.cpus.exclusive).
> Which of Table 1 or Table do you prefer?
> 
> Thanks,
> Michal

-- 
Best regards,
Ridong


