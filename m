Return-Path: <linux-kselftest+bounces-38017-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A07A4B12A34
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Jul 2025 13:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FE4AAA33F6
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Jul 2025 11:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77BA021ADC5;
	Sat, 26 Jul 2025 11:01:13 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D28BE55A;
	Sat, 26 Jul 2025 11:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753527673; cv=none; b=g1o779WI3mKrB9Z9AiYVGcLSy1WbjpRzA/0jaW5eJ/HVCyeVkH8bGBg5eG8a+snrJnNDcr6zSt7zlE5haYZsw7LvEC5ck7cYry1cWpW21nTTYfoQPG+qLWo31fVgfAlh+nL2ast9ashDIKXuXnGfmGgNvP7jLKI2gHoCfziO0Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753527673; c=relaxed/simple;
	bh=fl/PV+ZyQsIPcnTVHtSrC4wfylDUmx6XAB53C7LWOqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CMhSOG7tbJo0kR3z+XynBl9zD7cJ8POTh4gJGWtPcZCS/vgzbpYaX7mguBeuciLAWy/xf0RyO5u2FZbDnMGDOyaAlOpXtth+QOc8aUVYbN1Ig6FFUvt7U+O1Es5l0rdtEEGbE/7LVJuD3ceHTodVNDO2suZ+lvkkM9UUIz6YTDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bq1xq70PgzYQtrN;
	Sat, 26 Jul 2025 19:01:03 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A98531A151A;
	Sat, 26 Jul 2025 19:01:02 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP4 (Coremail) with SMTP id gCh0CgC3MhNttYRoOzkwBg--.1541S2;
	Sat, 26 Jul 2025 19:01:02 +0800 (CST)
Message-ID: <3140a3ba-6db0-45d7-bbd5-707fc8bf1dcc@huaweicloud.com>
Date: Sat, 26 Jul 2025 19:01:01 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] selftests/ftrace: Prevent potential failure in
 subsystem-enable test case
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Shuah Khan <shuah@kernel.org>, Yuanhe Shu <xiangzao@linux.alibaba.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20250710130134.591066-1-wutengda@huaweicloud.com>
 <20250710153409.3135fb17@batman.local.home>
 <88286bd2-a833-47e3-a0f0-896fbdd3fcbb@huaweicloud.com>
 <20250721132957.5184cd68@batman.local.home>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <20250721132957.5184cd68@batman.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgC3MhNttYRoOzkwBg--.1541S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYU7kC6x804xWl14x267AKxVW8JVW5JwAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7
	xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxAq
	zxv26xkF7I0En4kS14v26r126r1DMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUrR6zUU
	UUU
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2025/7/22 1:29, Steven Rostedt wrote:
> On Mon, 21 Jul 2025 09:54:22 +0800
> Tengda Wu <wutengda@huaweicloud.com> wrote:
> 
>> I noticed this patch hasn't been merged yet. Do you plan to merge it soon?
>> If you're too busy, would you like me to help submit it instead?
> 
> Nah, I simply forgot about it. Let me go write up a patch and send it
> out.
> 
> -- Steve

Just got the patch application notice, thanks.
-- Tengda


