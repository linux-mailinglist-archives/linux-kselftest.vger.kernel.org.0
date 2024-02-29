Return-Path: <linux-kselftest+bounces-5613-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FFF86C4AB
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 10:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C8E91F22535
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 09:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CFC85810B;
	Thu, 29 Feb 2024 09:14:12 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD3E58203;
	Thu, 29 Feb 2024 09:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709198052; cv=none; b=WIdxVVdn9CvPr+8QhGd7kItz/R3tBeJuaqAjM7YoZHkrFQRIlm+yCV/G5Gs0rCFrBU0JSls+JrIEOPOXrY95M4nZQgp0k5LVN3pWbVBx1l/yAZCBobbq7cjxj0o/kBu8Hid6NHrzcVHRoetnKza8JrNCtSzHCv5RVelf1etPr9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709198052; c=relaxed/simple;
	bh=fqVpiCKJyUf3+AVsKJYKVVJUv4ltfTVEWfbUmU3zcVI=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=RAPq3C22U/6uhcdOCssxdG+pp+wszSMrugEYviNP5yJYIxFuj/MRHviHqtkDQ4GXFjhf09jGUE5+KymqPNC4CvqHJQvsrvi6dBO0VMVcHVD7BN5576hfKtDqUxhpdE2Vl5joM4NPhClZaEIsaruBlfG9scTyY61oazYjl4bI1Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8DxdfHYSuBlxNMSAA--.47994S3;
	Thu, 29 Feb 2024 17:14:00 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxXs3VSuBlb5JKAA--.63412S3;
	Thu, 29 Feb 2024 17:13:58 +0800 (CST)
Subject: Re: [PATCH v3 0/2] selftests/vDSO: Fix errors on LoongArch
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, Mark Brown <broonie@kernel.org>
References: <20231213012300.5640-1-yangtiezhu@loongson.cn>
 <d73d107d-9e04-4250-f467-f6ff7eb92103@loongson.cn>
 <e64b3529-fb62-3ddf-bde3-b3188f386bc0@loongson.cn>
Cc: linux-kselftest@vger.kernel.org, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <57438b7e-4188-428b-2456-10cfc10f35f9@loongson.cn>
Date: Thu, 29 Feb 2024 17:13:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <e64b3529-fb62-3ddf-bde3-b3188f386bc0@loongson.cn>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:AQAAf8BxXs3VSuBlb5JKAA--.63412S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Cw13CrW3Kw48uw43Gw1kXrc_yoW8Jw4UpF
	WfWayakF4rCrW0yas7K3srXFyavw1fC3WUu3y5Ja97Arn0vF1rtr4xG3y8Ga9xZrWxuw1Y
	yr1IqFna9a4UArgCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUxYiiDU
	UUU

Hi Shuah and Andrew,

On 01/29/2024 04:27 PM, Tiezhu Yang wrote:
>
>
> On 12/27/2023 03:55 PM, Tiezhu Yang wrote:
>> + Andrew Morton <akpm@linux-foundation.org>
>> + Mark Brown <broonie@kernel.org>
>>
>> On 12/13/2023 09:22 AM, Tiezhu Yang wrote:
>>> v3: Rebase on the next branch of linux-kselftest.git,
>>>     modify the patch title and update the commit message
>>>
>>> v2: Rebase on 6.5-rc1 and update the commit message
>>>
>>> Tiezhu Yang (2):
>>>   selftests/vDSO: Fix building errors on LoongArch
>>>   selftests/vDSO: Fix runtime errors on LoongArch
>>>
>>>  tools/testing/selftests/vDSO/vdso_config.h    |  6 ++++-
>>>  .../testing/selftests/vDSO/vdso_test_getcpu.c | 16 +++++-------
>>>  .../selftests/vDSO/vdso_test_gettimeofday.c   | 26 +++++--------------
>>>  3 files changed, 18 insertions(+), 30 deletions(-)
>>>
>>
>> Hi Shuah, Andrew and Mark,
>>
>> The patches still seem to apply cleanly.
>> Could you please review and merge them for the upcoming merge window?
>>
>> https://lore.kernel.org/lkml/20231213012300.5640-1-yangtiezhu@loongson.cn/
>>
>
> Ping, any comments?

This series has received Reviewed-by and Tested-by for two months,
since the merge window is coming soon, should it take through
shuah/linux-kselftest.git or akpm/mm.git?

Thanks,
Tiezhu


