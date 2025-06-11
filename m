Return-Path: <linux-kselftest+bounces-34641-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AABA8AD4C57
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 09:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 301B7189F054
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 07:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13042227B81;
	Wed, 11 Jun 2025 07:12:48 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2081494A8
	for <linux-kselftest@vger.kernel.org>; Wed, 11 Jun 2025 07:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749625968; cv=none; b=hCVYeQNAd3kvrV2CSZ6EY39R/RenQcdzx4UzVqzrEPcQ9CDeazJP9VG2DflnnQ41FGwonINhrCxWkqjcaZoIVKHqYCk4TQB7RAmoMp+nO6Jl0tLtPwWgHe+CfWYY8EpHDIHkTYXeHZrVBoQgg9WBkkVVLrkcfSIBFWqogqU0AsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749625968; c=relaxed/simple;
	bh=KDqn4SC9uY9dIu2R7+Ak8mEey38ZN0g97LQxZV0/YuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sSOAKKOyzwHXCa8bzE/Vpe3kg2Wrvmarv7tf3w+iPMzdMPuaD6UYyXi3gMjn3JCyDj7sKCeP5HNCr8wVayJHIfeRgkgJGs54UPNB+kEvQ0l6yLx3Es57IHh4VKu5E/uRFrbG42s7Aq3A5i8lccp1rU2BhHii7Y7IF3zE1pqo/Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4bHGvq1XlFz10WqD;
	Wed, 11 Jun 2025 15:08:07 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id 31E8F180493;
	Wed, 11 Jun 2025 15:12:38 +0800 (CST)
Received: from [10.67.109.184] (10.67.109.184) by
 kwepemf100007.china.huawei.com (7.202.181.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 11 Jun 2025 15:12:37 +0800
Message-ID: <0c96ef86-958c-4550-bf36-1b0c8d939550@huawei.com>
Date: Wed, 11 Jun 2025 15:12:36 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: Skip uprobe vma merge test if uprobes are
 not enabled
Content-Language: en-US
To: Pedro Falcato <pfalcato@suse.de>, Andrew Morton
	<akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Shuah Khan <shuah@kernel.org>
CC: Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
	<linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>, Aishwarya
	<aishwarya.tcv@arm.com>, <broonie@kernel.org>
References: <20250610122209.3177587-1-pfalcato@suse.de>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20250610122209.3177587-1-pfalcato@suse.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemf100007.china.huawei.com (7.202.181.221)



On 2025/6/10 20:22, Pedro Falcato wrote:
> If uprobes are not enabled, the test currently fails with:
> 
> 7151 12:46:54.627936  # # #  RUN           merge.handle_uprobe_upon_merged_vma ...
> 7152 12:46:54.639014  # # f /sys/bus/event_source/devices/uprobe/type
> 7153 12:46:54.639306  # # fopen: No such file or directory
> 7154 12:46:54.650451  # # # merge.c:473:handle_uprobe_upon_merged_vma:Expected
> read_sysfs("/sys/bus/event_source/devices/uprobe/type", &type) (1) == 0 (0)
> 7155 12:46:54.650730  # # # handle_uprobe_upon_merged_vma: Test terminated by assertion
> 7156 12:46:54.661750  # # #          FAIL  merge.handle_uprobe_upon_merged_vma
> 7157 12:46:54.662030  # # not ok 8 merge.handle_uprobe_upon_merged_vma
> 
> Skipping is a more sane and friendly behavior here.
> 
> Fixes: efe99fabeb11b ("selftests/mm: add test about uprobe pte be orphan during vma merge")
> Reported-by: Aishwarya <aishwarya.tcv@arm.com>
> Closes: https://lore.kernel.org/linux-mm/20250610103729.72440-1-aishwarya.tcv@arm.com/
> Signed-off-by: Pedro Falcato <pfalcato@suse.de>
> ---
>   tools/testing/selftests/mm/merge.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/mm/merge.c b/tools/testing/selftests/mm/merge.c
> index bbae66fc5038..cc26480098ae 100644
> --- a/tools/testing/selftests/mm/merge.c
> +++ b/tools/testing/selftests/mm/merge.c
> @@ -470,7 +470,9 @@ TEST_F(merge, handle_uprobe_upon_merged_vma)
>   	ASSERT_GE(fd, 0);
>   
>   	ASSERT_EQ(ftruncate(fd, page_size), 0);
> -	ASSERT_EQ(read_sysfs("/sys/bus/event_source/devices/uprobe/type", &type), 0);
> +	if (read_sysfs("/sys/bus/event_source/devices/uprobe/type", &type) != 0) {
> +		SKIP(goto out, "Failed to read uprobe sysfs file, skipping");
> +	}
>   
>   	memset(&attr, 0, attr_sz);
>   	attr.size = attr_sz;
> @@ -491,6 +493,7 @@ TEST_F(merge, handle_uprobe_upon_merged_vma)
>   	ASSERT_NE(mremap(ptr2, page_size, page_size,
>   			 MREMAP_MAYMOVE | MREMAP_FIXED, ptr1), MAP_FAILED);
>   
> +out:
>   	close(fd);
>   	remove(probe_file);
>   }

Thanks, feel free to add:

Reviewed-by: Pu Lehui <pulehui@huawei.com>

