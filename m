Return-Path: <linux-kselftest+bounces-2455-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DBDC81ED0B
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Dec 2023 08:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12EA71F20EF3
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Dec 2023 07:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03146566F;
	Wed, 27 Dec 2023 07:55:50 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BE763AB;
	Wed, 27 Dec 2023 07:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8AxG+l82ItlU_YEAA--.23667S3;
	Wed, 27 Dec 2023 15:55:40 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Dxt+Z42ItlT4AMAA--.44482S3;
	Wed, 27 Dec 2023 15:55:37 +0800 (CST)
Subject: Re: [PATCH v3 0/2] selftests/vDSO: Fix errors on LoongArch
To: Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, Mark Brown <broonie@kernel.org>
References: <20231213012300.5640-1-yangtiezhu@loongson.cn>
Cc: linux-kselftest@vger.kernel.org, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <d73d107d-9e04-4250-f467-f6ff7eb92103@loongson.cn>
Date: Wed, 27 Dec 2023 15:55:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231213012300.5640-1-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:AQAAf8Dxt+Z42ItlT4AMAA--.44482S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoWrtr13AF1kZF18Gr1fZw17twc_yoWftrb_uF
	W8ua4kGrZ7uFZ8AF4Fqw1rZry3JF4Iyr4xWryj9w47Jr9rArZ8GF4FkF48uFySgrWayr9r
	JF4DCa9avr1qqosvyTuYvTs0mTUanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbfAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
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

+ Andrew Morton <akpm@linux-foundation.org>
+ Mark Brown <broonie@kernel.org>

On 12/13/2023 09:22 AM, Tiezhu Yang wrote:
> v3: Rebase on the next branch of linux-kselftest.git,
>     modify the patch title and update the commit message
>
> v2: Rebase on 6.5-rc1 and update the commit message
>
> Tiezhu Yang (2):
>   selftests/vDSO: Fix building errors on LoongArch
>   selftests/vDSO: Fix runtime errors on LoongArch
>
>  tools/testing/selftests/vDSO/vdso_config.h    |  6 ++++-
>  .../testing/selftests/vDSO/vdso_test_getcpu.c | 16 +++++-------
>  .../selftests/vDSO/vdso_test_gettimeofday.c   | 26 +++++--------------
>  3 files changed, 18 insertions(+), 30 deletions(-)
>

Hi Shuah, Andrew and Mark,

The patches still seem to apply cleanly.
Could you please review and merge them for the upcoming merge window?

https://lore.kernel.org/lkml/20231213012300.5640-1-yangtiezhu@loongson.cn/

Thanks,
Tiezhu


