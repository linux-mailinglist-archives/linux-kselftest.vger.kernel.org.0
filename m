Return-Path: <linux-kselftest+bounces-3684-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D104D84000F
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jan 2024 09:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E9ACB231B4
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jan 2024 08:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9ED537E8;
	Mon, 29 Jan 2024 08:27:42 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616C5537ED;
	Mon, 29 Jan 2024 08:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706516862; cv=none; b=ALoiltfD8DAFbjaxYBUKv2osxCjPZsIYHhIw1BQVTk5T5yCaYIOtUoC8PdiPkD2Jd+6LBn+0/G25HeRkxXmh1k5rLcqP1KOtZW6anRA5MpiGuqu6rPB2nEOW2BmQglq6+5M++etHdEdp91D05ArSXBbS87CiVMFR7nMeSQtcIHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706516862; c=relaxed/simple;
	bh=yul8c8KuBdTXo/dcNvUV+pw6koXcl4vGdplZ6y2p8cg=;
	h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Ve3jqNfR8a6VmcY66mQ5LNdhxBJCmj/x1Qn/ZIwDdlnt4KZmNPczhKFz3ZT50UxqIC31bwVEqf+9bx6zBbhJ17qacs4JoiDWtIAliH/hJYuT8k/sCk+aBghNJv/5a4WXqA6IBfgb881yZ8NG0D2Z6uwER8kSsi5sWsrWd3gOWU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8DxmfB4YbdlIrIHAA--.24452S3;
	Mon, 29 Jan 2024 16:27:36 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxX891Ybdl9hwlAA--.16337S3;
	Mon, 29 Jan 2024 16:27:33 +0800 (CST)
Subject: Re: [PATCH v3 0/2] selftests/vDSO: Fix errors on LoongArch
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, Mark Brown <broonie@kernel.org>
References: <20231213012300.5640-1-yangtiezhu@loongson.cn>
 <d73d107d-9e04-4250-f467-f6ff7eb92103@loongson.cn>
Cc: linux-kselftest@vger.kernel.org, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <e64b3529-fb62-3ddf-bde3-b3188f386bc0@loongson.cn>
Date: Mon, 29 Jan 2024 16:27:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <d73d107d-9e04-4250-f467-f6ff7eb92103@loongson.cn>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:AQAAf8AxX891Ybdl9hwlAA--.16337S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoW7XFWrWF1xtFW8KFy5Ar45CFX_yoWDCwbE9F
	W8uFWkGrZ3WFsxAF4Fg345Zr9xJFWIkr4xWry29a17Jr9IyrWDGF4rKFW09FyagFW3tr9r
	JF4DC39avr17XosvyTuYvTs0mTUanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbfAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y
	6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr4
	1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8hiSPUUUUU==



On 12/27/2023 03:55 PM, Tiezhu Yang wrote:
> + Andrew Morton <akpm@linux-foundation.org>
> + Mark Brown <broonie@kernel.org>
>
> On 12/13/2023 09:22 AM, Tiezhu Yang wrote:
>> v3: Rebase on the next branch of linux-kselftest.git,
>>     modify the patch title and update the commit message
>>
>> v2: Rebase on 6.5-rc1 and update the commit message
>>
>> Tiezhu Yang (2):
>>   selftests/vDSO: Fix building errors on LoongArch
>>   selftests/vDSO: Fix runtime errors on LoongArch
>>
>>  tools/testing/selftests/vDSO/vdso_config.h    |  6 ++++-
>>  .../testing/selftests/vDSO/vdso_test_getcpu.c | 16 +++++-------
>>  .../selftests/vDSO/vdso_test_gettimeofday.c   | 26 +++++--------------
>>  3 files changed, 18 insertions(+), 30 deletions(-)
>>
>
> Hi Shuah, Andrew and Mark,
>
> The patches still seem to apply cleanly.
> Could you please review and merge them for the upcoming merge window?
>
> https://lore.kernel.org/lkml/20231213012300.5640-1-yangtiezhu@loongson.cn/

Ping, any comments?

Thanks,
Tiezhu


