Return-Path: <linux-kselftest+bounces-6041-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 056F1874AAF
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Mar 2024 10:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3747D1C21E30
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Mar 2024 09:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C45183CC0;
	Thu,  7 Mar 2024 09:21:09 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520F683CA7;
	Thu,  7 Mar 2024 09:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709803269; cv=none; b=TobuQzwcJsKfdtD8dTBPlG1VV8Z1qdWnRNbK7x2Gayuy2ztzTiPqlWfkFzsJB3iainnlVk1TUlGwWoLA4keXCblAFPzpFWi+h/Ac2FfXTCDdIdd3n9rrXs4XeguqniJabA6rW8U/mqImJhZlC5QqodnmgqzbEXdWm1IRqpUQVNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709803269; c=relaxed/simple;
	bh=EvwugGIkb2zpwheAiQ8y0YWSKolLwjatKDne0mg74F8=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Jffw3POd4cNteUukRnnXxj0H3VNYGjZxOz0YCwHm0LkWsGqIw94pGxWpPOEP6QZsJIGLGPS6Yp7Y646lsdmjZ4L+SOA7WIHa9BUjE8LuJYAe1z4p7tN7G6pDpcgBdiQGbcEG7Y9ChR1oSd10+CM/B8ez2lktU4TEgjps/7Av9X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Axjuv6hullO8AVAA--.53325S3;
	Thu, 07 Mar 2024 17:20:58 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Dxfs31hullHAFQAA--.14257S3;
	Thu, 07 Mar 2024 17:20:53 +0800 (CST)
Subject: Re: [PATCH v3 0/2] selftests/vDSO: Fix errors on LoongArch
To: Andrew Morton <akpm@linux-foundation.org>
References: <20231213012300.5640-1-yangtiezhu@loongson.cn>
 <d73d107d-9e04-4250-f467-f6ff7eb92103@loongson.cn>
 <e64b3529-fb62-3ddf-bde3-b3188f386bc0@loongson.cn>
 <57438b7e-4188-428b-2456-10cfc10f35f9@loongson.cn>
Cc: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
 Mark Brown <broonie@kernel.org>, linux-kselftest@vger.kernel.org,
 loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <a6ddf07a-99ac-9787-b879-63c3f318c84d@loongson.cn>
Date: Thu, 7 Mar 2024 17:20:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <57438b7e-4188-428b-2456-10cfc10f35f9@loongson.cn>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:AQAAf8Dxfs31hullHAFQAA--.14257S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7CrWrJFy5ZrWUAF4fArW5Jwc_yoW8ZrWrpF
	WfGa15Kr4rtF18tF92gayDZF1av3W5C3W7u3yUJrWkZrn0v3WFqrWxWrW8ua9xXr97ur1Y
	y3WIqasagayUAFgCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	XVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jepB-UUUUU=

On 02/29/2024 05:13 PM, Tiezhu Yang wrote:
> Hi Shuah and Andrew,
>
> On 01/29/2024 04:27 PM, Tiezhu Yang wrote:
>>
>>
>> On 12/27/2023 03:55 PM, Tiezhu Yang wrote:
>>> + Andrew Morton <akpm@linux-foundation.org>
>>> + Mark Brown <broonie@kernel.org>
>>>
>>> On 12/13/2023 09:22 AM, Tiezhu Yang wrote:
>>>> v3: Rebase on the next branch of linux-kselftest.git,
>>>>     modify the patch title and update the commit message
>>>>
>>>> v2: Rebase on 6.5-rc1 and update the commit message
>>>>
>>>> Tiezhu Yang (2):
>>>>   selftests/vDSO: Fix building errors on LoongArch
>>>>   selftests/vDSO: Fix runtime errors on LoongArch
>>>>
>>>>  tools/testing/selftests/vDSO/vdso_config.h    |  6 ++++-
>>>>  .../testing/selftests/vDSO/vdso_test_getcpu.c | 16 +++++-------
>>>>  .../selftests/vDSO/vdso_test_gettimeofday.c   | 26 +++++--------------
>>>>  3 files changed, 18 insertions(+), 30 deletions(-)
>>>>
>>>
>>> Hi Shuah, Andrew and Mark,
>>>
>>> The patches still seem to apply cleanly.
>>> Could you please review and merge them for the upcoming merge window?
>>>
>>> https://lore.kernel.org/lkml/20231213012300.5640-1-yangtiezhu@loongson.cn/
>>>
>>>
>>
>> Ping, any comments?
>
> This series has received Reviewed-by and Tested-by for two months,
> since the merge window is coming soon, should it take through
> shuah/linux-kselftest.git or akpm/mm.git?


Hi Andrew,

There is already a tag linux_kselftest-next-6.9-rc1 [1],
it seems no chance to merge them through kselftest tree,
would you be able to pick them up through your tree [2]?

"If you cannot find a maintainer for the subsystem you are
working on, Andrew Morton (akpm@linux-foundation.org) serves
as a maintainer of last resort."

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/tag/?h=linux_kselftest-next-6.9-rc1
[2] https://www.kernel.org/doc/html/latest/process/submitting-patches.html

Thanks,
Tiezhu


