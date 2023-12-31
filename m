Return-Path: <linux-kselftest+bounces-2538-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72308820BE4
	for <lists+linux-kselftest@lfdr.de>; Sun, 31 Dec 2023 16:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 851321C213D6
	for <lists+linux-kselftest@lfdr.de>; Sun, 31 Dec 2023 15:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B336132;
	Sun, 31 Dec 2023 15:50:55 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC8A63C3;
	Sun, 31 Dec 2023 15:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [36.44.127.64])
	by gateway (Coremail) with SMTP id _____8DxPOvUjZFlFdEAAA--.3567S3;
	Sun, 31 Dec 2023 23:50:44 +0800 (CST)
Received: from [192.168.0.108] (unknown [36.44.127.64])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Axur3RjZFlEUMTAA--.32041S3;
	Sun, 31 Dec 2023 23:50:42 +0800 (CST)
Message-ID: <ced09963-1a02-5ef0-9e31-e2441e062557@loongson.cn>
Date: Sun, 31 Dec 2023 23:51:00 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3 0/2] selftests/vDSO: Fix errors on LoongArch
Content-Language: en-US
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, Mark Brown <broonie@kernel.org>
Cc: linux-kselftest@vger.kernel.org, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20231213012300.5640-1-yangtiezhu@loongson.cn>
 <d73d107d-9e04-4250-f467-f6ff7eb92103@loongson.cn>
 <d3dd3a6c-ae60-48c9-945b-40aa18ccad86@collabora.com>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
In-Reply-To: <d3dd3a6c-ae60-48c9-945b-40aa18ccad86@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8Axur3RjZFlEUMTAA--.32041S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWrZr48KryUtry5Cr45Ar4UZFc_yoW8Jry3pF
	s3Ga4akw4Fk395tF9F93yDXFyYyr1xCa1Uu345Ja4kAr1YyF1SqrWxWF1xKFyfJ3yfZw1Y
	kF18ta93Za4UArgCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
	twAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	k0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l
	4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j5o7tUUUUU=

Hi Muhammad,

On 12/30/23 15:07, Muhammad Usama Anjum wrote:
> On 12/27/23 12:55 PM, Tiezhu Yang wrote:
>> + Andrew Morton <akpm@linux-foundation.org>
>> + Mark Brown <broonie@kernel.org>
>>
>> On 12/13/2023 09:22 AM, Tiezhu Yang wrote:
>>> v3: Rebase on the next branch of linux-kselftest.git,
>>>      modify the patch title and update the commit message
>>>
>>> v2: Rebase on 6.5-rc1 and update the commit message
>>>
>>> Tiezhu Yang (2):
>>>    selftests/vDSO: Fix building errors on LoongArch
>>>    selftests/vDSO: Fix runtime errors on LoongArch
>>>
>>>   tools/testing/selftests/vDSO/vdso_config.h    |  6 ++++-
>>>   .../testing/selftests/vDSO/vdso_test_getcpu.c | 16 +++++-------
>>>   .../selftests/vDSO/vdso_test_gettimeofday.c   | 26 +++++--------------
>>>   3 files changed, 18 insertions(+), 30 deletions(-)
>>>
>>
>> Hi Shuah, Andrew and Mark,
>>
>> The patches still seem to apply cleanly.
>> Could you please review and merge them for the upcoming merge window?
> People may be on vacation. I'm also waiting to hear back on my patches.
> Lets see when they get back and start picking up patches.

Thank you very much for your reply and review, happy new year.

Thanks,
Tiezhu


