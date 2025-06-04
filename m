Return-Path: <linux-kselftest+bounces-34297-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF77ACDAE9
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 11:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC8491898ED2
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 09:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0485E28B500;
	Wed,  4 Jun 2025 09:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="ycher373"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50B2169397;
	Wed,  4 Jun 2025 09:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749029006; cv=none; b=oZOlsA951cXzo4Ah1UQw3oLSPFsPnm0WXHDpPQixXtd/bphi7zRAVuXm4eEzuVM1mq/nM/9K2RbI87GsfLeNgtRtUEIODXaaUHKOQnel1tdQWU0PkamLzZltBeTeRCoCwuq0MpGzgOyF0asHa/m9oNcn+yezgBi7W4NoUH8Fqpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749029006; c=relaxed/simple;
	bh=RIYky3gjpTsCWWoJfEf+lc/dCW5mVapm/m/j24bH0IQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qB2GYhmjleqDoLmO8Gx+QJF1E5CG/1qeTlOOHAXUw3E2lEksY19xN5UwtHDreTPxZcRViE234i2CohWis+n28GL/aAhb0t/hIqKwLz0Ovff7BqYL3uq3EOxonbmwkV18j1PcBPyGC42LKZNexdPsS0kflppvSi4s5hPlzQeK2A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=ycher373; arc=none smtp.client-ip=162.62.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1749028692;
	bh=RIYky3gjpTsCWWoJfEf+lc/dCW5mVapm/m/j24bH0IQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ycher37324IbzHf505SgsNe0/N4ZdnkYj649dMDb/GhGeWesGIE3SrM/+cZ1q2okb
	 yoMMu8EXjpW6yYmzZxhOwF48U3a5v616v1tM7AX9TvI4I6ArVWldq/pnj/WxCLLTtR
	 FlhD+VLFxgrMTYZlAD4Xez5wbXyrcPWL13F9q/lA=
Received: from [10.56.52.9] ([39.156.73.10])
	by newxmesmtplogicsvrszc16-0.qq.com (NewEsmtp) with SMTP
	id 30098838; Wed, 04 Jun 2025 17:12:00 +0800
X-QQ-mid: xmsmtpt1749028320tno68hupx
Message-ID: <tencent_CC0310590D7085E8B3EC2E1955E45E4B4709@qq.com>
X-QQ-XMAILINFO: NvKPbWBbh1DVYUNrtUaO4h9Jj+nOhO0LDaL7Td6QvGV4lWUff2j/vEKUwNnLFs
	 OLHiU8HjtO7X0BTo/mZpmoEGAb9JuMxziyE13yu5EmANI/1w0vmju9epZ/bZzbSXA1flXKOlJCZZ
	 0xdvAOAB8VyNKr2QluATxTOYVEe1IAEr29eygOc9y2gqvHEs7zbaNV8svwb2YcQomlJh10O1DWLo
	 PXJrtg35/w2KjVub9G4hXlaaODVaIv5HxLJLIeGw8haZVbKol3pxT1UVrVP9PIE6iW6oGW1DASKk
	 JglRxN8iFlXFrH408POil0NYTrv4Qls947B0al8UFnJ6xeYWFPfvmK+l6mw3Cl/4BLpWgDOMRt+k
	 UrYDh0qAZTVf2FDZg6dIj2VABZbbalypmmpKQdY8zk4jeja07vCJfEocQCBNTybGixtgoKvRvcd0
	 dSUcqfu9AgFxz8oM4ks2OZfJVc/+1YSKiZdZ5oWg4JzNvrD9IgDKripzGOCf2gfOXHhj67JKwtdc
	 Xvt5qdrp6RIu3qv8q79nDMT9pBldnw+GpvGZd/GLfkykzwt4ZRmcEt2ADl0Bj/tfDN1XajAgi+NF
	 AsgwcY3cJtX3K3Gh0WXK45o4Zof4kxKsygFeKzZU7NXl28+E4sH5vCLV4aIsOknG4m5D4CDUYdkm
	 ac+ZcB+WCWf2D8wX5w4fMtWUtYNjW7X5EOQolpYsuNItcckXyWQP4hfCMgfdHYjzdbYS0UlIiByU
	 buyWQSQCSzDpvNini1IwsOxoHQ0QcHWYCf9zveyqN85O1YLWoGw3uO39Vd/oSSS+IDCnTmE0vPoY
	 owrNAXU/M0Msa9kRe2HGy9sJT5ME7CAy1QM/JX+1nQtOq0ShztSqPRXhjEkQ1Q9NeYf8YE416HyZ
	 z06m9cTiKe6VUYzTY0knFb75smemeGwBRoXSxAC2fADTT93GciJy/QFtVo0WJYjvAQga58hOqboM
	 8qdx5zDNtzNRgK0zCw8mhNrpqwX8kASut9RkRk/ypcFd0xG05u1ALrQq/VzpXCpTMwV84eDOcSsO
	 PVaspGNOPthDgcgF8X
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-OQ-MSGID: <365843f4-d33d-490d-b567-fe9250577725@foxmail.com>
Date: Wed, 4 Jun 2025 17:12:00 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix compile error of
 bin_attribute::read/write()
To: Jiri Olsa <olsajiri@gmail.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, rongtao@cestc.cn,
 Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Shuah Khan <shuah@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Peter Zijlstra <peterz@infradead.org>, Amery Hung <ameryhung@gmail.com>,
 Juntong Deng <juntong.deng@outlook.com>, Oleg Nesterov <oleg@redhat.com>,
 "open list:BPF [SELFTESTS] (Test Runners & Infrastructure)"
 <bpf@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 "moderated list:ARM/STM32 ARCHITECTURE"
 <linux-stm32@st-md-mailman.stormreply.com>,
 "moderated list:ARM/STM32 ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <tencent_A6502A28AF21A3CA88B106F3421159869708@qq.com>
 <aEAJbBH00yL2iTgn@krava>
Content-Language: en-US
From: Rong Tao <rtoax@foxmail.com>
In-Reply-To: <aEAJbBH00yL2iTgn@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 6/4/25 16:53, Jiri Olsa wrote:
> On Wed, Jun 04, 2025 at 01:53:22PM +0800, Rong Tao wrote:
>> From: Rong Tao <rongtao@cestc.cn>
>>
>> Since commit 97d06802d10a ("sysfs: constify bin_attribute argument of
>> bin_attribute::read/write()"), make bin_attribute parameter of
>> bin_attribute::read/write() const.
> hi,
> there's already fix for this in bpf/master
>
> thanks,
> jirka
I am confused, when should I use bpf/master[2] and when should I use
bpf-next/master[1]? thank you :)

[1] https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git
[2] https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git


