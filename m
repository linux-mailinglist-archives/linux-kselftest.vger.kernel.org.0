Return-Path: <linux-kselftest+bounces-48122-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFC0CF0929
	for <lists+linux-kselftest@lfdr.de>; Sun, 04 Jan 2026 04:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 92D2B300AB36
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Jan 2026 03:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B835217A31E;
	Sun,  4 Jan 2026 03:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="2DxekCI6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169094207A;
	Sun,  4 Jan 2026 03:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767496822; cv=none; b=UvSYCZARILBxuJY2kUrYRTZiBIZPjtTI7YQ2lRM/lUyBO1vE2FzDIP1+10QVA5AcXg+RL+cGP0B3XapiSWb+qNcbTZvaqqaOV0ZY92/WGgjcc8vKN8MMyOK0kxDShd0KQf5rdPhJ9wRoLl3DtNJ4lwnhLJLM6BBzbWNvVkyXUKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767496822; c=relaxed/simple;
	bh=deB/+QbuRhSdxPDzkCIe+IHLh6zQpP07rAYmgj93QXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kStiI/3yvJGtTItNtGhszp+v5+apFwThBVI05YCS8fsHfXaJcKJC2ICJwWSyog89jlvL2X6sOVbBEjsGWeXOKsYTOi0NM80gn+7hDBPwTGV5e2EXO20GEgokRSOnDSXJuLBCv4VOrjyoUAebgBBq2UmjyJAEzxCYuKmnT+gWW2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=2DxekCI6; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=QLL7bjv1BrNnYVbdl19Xciy9EaxpvUqn9pTDGtvKwFY=;
	b=2DxekCI6xA0svzyz06lFYaIP0F3CctLtkVXsnWH6ooDabtuqxsGIBaIPCWzXVv+EB1633oOg8
	y105HtpnGbgh7uL9vS0IV2c1GOlayzYBUu3OYYEuI3YPmvNi9xyXNWZFYLzFt9cKClQr6TcLoWM
	Lrm0hxuDflZv2LqEviIf/vg=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4dkMzX15HfzRhRF;
	Sun,  4 Jan 2026 11:16:56 +0800 (CST)
Received: from dggpemr500006.china.huawei.com (unknown [7.185.36.185])
	by mail.maildlp.com (Postfix) with ESMTPS id DCC674056E;
	Sun,  4 Jan 2026 11:20:09 +0800 (CST)
Received: from [100.103.109.15] (100.103.109.15) by
 dggpemr500006.china.huawei.com (7.185.36.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sun, 4 Jan 2026 11:20:08 +0800
Message-ID: <34ff0ff6-217e-4574-a3b1-af74b2f40937@huawei.com>
Date: Sun, 4 Jan 2026 11:20:07 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 1/8] rcu: Fix rcu_read_unlock() deadloop due to
 softirq
To: Joel Fernandes <joelagnelf@nvidia.com>, <paulmck@kernel.org>, Steven
 Rostedt <rostedt@goodmis.org>
CC: Boqun Feng <boqun.feng@gmail.com>, <rcu@vger.kernel.org>, Frederic
 Weisbecker <frederic@kernel.org>, Neeraj Upadhyay
	<neeraj.upadhyay@kernel.org>, Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Shuah Khan <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, Tengda Wu
	<wutengda2@huawei.com>, <liuyongqiang13@huawei.com>, <yujiacheng3@huawei.com>
References: <20260101163417.1065705-1-joelagnelf@nvidia.com>
 <20260101163417.1065705-2-joelagnelf@nvidia.com>
 <20260102122807.7025fc87@gandalf.local.home>
 <20260102123009.453dfb90@gandalf.local.home>
 <68b5b122-036b-475a-85bb-e39830f99fbe@paulmck-laptop>
 <252063db-ec72-42df-b9e0-b8dc0aa6bef9@nvidia.com>
Content-Language: en-US
From: Yao Kai <yaokai34@huawei.com>
In-Reply-To: <252063db-ec72-42df-b9e0-b8dc0aa6bef9@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemr500006.china.huawei.com (7.185.36.185)



On 1/3/2026 8:41 AM, Joel Fernandes wrote:
> 
> 
> On 1/2/2026 2:51 PM, Paul E. McKenney wrote:
>> On Fri, Jan 02, 2026 at 12:30:09PM -0500, Steven Rostedt wrote:
>>> On Fri, 2 Jan 2026 12:28:07 -0500
>>> Steven Rostedt <rostedt@goodmis.org> wrote:
>>>
>>>> Stacktrace should have recursion protection too.
>>>>
>>>> Can you try this patch to see if it would have fixed the problem too?
>>>
>>> As I believe the recursion protection should be in the tracing
>>> infrastructure more than in RCU. As RCU is used as an active participant in
>>> the kernel whereas tracing is supposed to be only an observer.
>>>
>>> If tracing is the culprit, it should be the one that is fixed.
>>
>> Makes sense to me!  But then it would...  ;-)
>>
> Could we fix it in both? (RCU and tracing). The patch just adds 3 more net lines
> to RCU code. It'd be good to have a guard rail against softirq recursion in RCU
> read unlock path, as much as the existing guard rail we already have with
> irq_work? After all, both paths attempt to do deferred work when it is safer to
> do so.
> 
> Yao, if you could test Steve's patch and reply whether it fixes it too?
> 
> thanks,
> 
>   - Joel
> 
> 
> 
> 

Yes, I tested Steve's patch. It fixes the issue too.

Tested-by: Yao Kai <yaokai34@huawei.com>

  - Yao

