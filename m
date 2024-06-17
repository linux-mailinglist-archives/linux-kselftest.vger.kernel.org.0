Return-Path: <linux-kselftest+bounces-12028-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7E790A729
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 09:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3F941C20FEF
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 07:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DC015FA7A;
	Mon, 17 Jun 2024 07:31:41 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893B2E554;
	Mon, 17 Jun 2024 07:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718609501; cv=none; b=hdYcMfVlfk0+GWEay8mlbPfsq3lDL1JvZZZYnOB2lUgEZYBV+QDzVVLo/MOVp+sCUVIsS69JNrpvnigUJitc0fZIa51cgTpFrgWpbjr4U7nOSIgIEDPz3TyaSp5b6Fv0Saq1JKqen/4TFS+ZpErWH6zS0IC/bDeHE8eTZcWJP/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718609501; c=relaxed/simple;
	bh=HH93OH7bC83B/rZnH0xOE52UI0ZgAtyTh5roLNoIgeY=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=YBjzoGyeB+b6NVRZl3j3yKUPe9wZOH6BoWcGLWMs72F9e5cJXqQLAwYVfh9W3VIUzber1wmYFxondCCXpi5av5zqkkc5hM/BKXNQtPW0RvStTudGCq/2CNoro1mclLHs6ZnEQK86waMTPF8I2faYmvkOzceOwsIPKdNzUcNsVCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4W2hLQ6WLxzPr9c;
	Mon, 17 Jun 2024 15:27:58 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 542171402CA;
	Mon, 17 Jun 2024 15:31:29 +0800 (CST)
Received: from [10.173.127.72] (10.173.127.72) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 17 Jun 2024 15:31:28 +0800
Subject: Re: [PATCH v2 1/3] mm/memory-failure: userspace controls
 soft-offlining pages
To: Jiaqi Yan <jiaqiyan@google.com>
CC: <nao.horiguchi@gmail.com>, <jane.chu@oracle.com>, <muchun.song@linux.dev>,
	<akpm@linux-foundation.org>, <shuah@kernel.org>, <corbet@lwn.net>,
	<osalvador@suse.de>, <rientjes@google.com>, <duenwen@google.com>,
	<fvdl@google.com>, <linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, Lance Yang <ioworker0@gmail.com>
References: <20240611215544.2105970-1-jiaqiyan@google.com>
 <20240611215544.2105970-2-jiaqiyan@google.com>
 <CABzRoyYGY2EgT5wC9o98Vn_auh59poQ-OOnKceCiWQAJrbZoBw@mail.gmail.com>
 <CACw3F5134NmmLNr4zXHV1h0sLMTGcAJLpApQ7Fv_-DtUieD7zw@mail.gmail.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <786a08ff-aa7e-49d5-f589-0a405c7e1a34@huawei.com>
Date: Mon, 17 Jun 2024 15:31:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CACw3F5134NmmLNr4zXHV1h0sLMTGcAJLpApQ7Fv_-DtUieD7zw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)

On 2024/6/15 0:30, Jiaqi Yan wrote:
> On Fri, Jun 14, 2024 at 1:35 AM Lance Yang <ioworker0@gmail.com> wrote:
>>
>> Hi Jiaqi,
>>
>> On Wed, Jun 12, 2024 at 5:56 AM Jiaqi Yan <jiaqiyan@google.com> wrote:
>>>
>>> Correctable memory errors are very common on servers with large
>>> amount of memory, and are corrected by ECC. Soft offline is kernel's
>>> additional recovery handling for memory pages having (excessive)
>>> corrected memory errors. Impacted page is migrated to a healthy page
>>> if inuse; the original page is discarded for any future use.
>>>
>>> The actual policy on whether (and when) to soft offline should be
>>> maintained by userspace, especially in case of an 1G HugeTLB page.
>>> Soft-offline dissolves the HugeTLB page, either in-use or free, into
>>> chunks of 4K pages, reducing HugeTLB pool capacity by 1 hugepage.
>>> If userspace has not acknowledged such behavior, it may be surprised
>>> when later mmap hugepages MAP_FAILED due to lack of hugepages.
>>> In case of a transparent hugepage, it will be split into 4K pages
>>> as well; userspace will stop enjoying the transparent performance.
>>>
>>> In addition, discarding the entire 1G HugeTLB page only because of
>>> corrected memory errors sounds very costly and kernel better not
>>> doing under the hood. But today there are at least 2 such cases:
>>> 1. GHES driver sees both GHES_SEV_CORRECTED and
>>>    CPER_SEC_ERROR_THRESHOLD_EXCEEDED after parsing CPER.
>>> 2. RAS Correctable Errors Collector counts correctable errors per
>>>    PFN and when the counter for a PFN reaches threshold
>>> In both cases, userspace has no control of the soft offline performed
>>> by kernel's memory failure recovery.
>>>
>>> This commit gives userspace the control of softofflining any page:
>>> kernel only soft offlines raw page / transparent hugepage / HugeTLB
>>> hugepage if userspace has agreed to. The interface to userspace is a
>>> new sysctl called enable_soft_offline under /proc/sys/vm. By default
>>> enable_soft_line is 1 to preserve existing behavior in kernel.
>>
>> s/enable_soft_line/enable_soft_offline
> 
> Will fix this typo in v3.
> 
>>
>>>
>>> Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
>>> ---
>>>  mm/memory-failure.c | 16 ++++++++++++++++
>>>  1 file changed, 16 insertions(+)
>>>
>>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>>> index d3c830e817e3..23415fe03318 100644
>>> --- a/mm/memory-failure.c
>>> +++ b/mm/memory-failure.c
>>> @@ -68,6 +68,8 @@ static int sysctl_memory_failure_early_kill __read_mostly;
>>>
>>>  static int sysctl_memory_failure_recovery __read_mostly = 1;
>>>
>>> +static int sysctl_enable_soft_offline __read_mostly = 1;
>>> +
>>>  atomic_long_t num_poisoned_pages __read_mostly = ATOMIC_LONG_INIT(0);
>>>
>>>  static bool hw_memory_failure __read_mostly = false;
>>> @@ -141,6 +143,15 @@ static struct ctl_table memory_failure_table[] = {
>>>                 .extra1         = SYSCTL_ZERO,
>>>                 .extra2         = SYSCTL_ONE,
>>>         },
>>> +       {
>>> +               .procname       = "enable_soft_offline",
>>> +               .data           = &sysctl_enable_soft_offline,
>>> +               .maxlen         = sizeof(sysctl_enable_soft_offline),
>>> +               .mode           = 0644,
>>> +               .proc_handler   = proc_dointvec_minmax,
>>> +               .extra1         = SYSCTL_ZERO,
>>> +               .extra2         = SYSCTL_ONE,
>>> +       }
>>>  };
>>>
>>>  /*
>>> @@ -2771,6 +2782,11 @@ int soft_offline_page(unsigned long pfn, int flags)
>>>         bool try_again = true;
>>>         struct page *page;
>>>
>>> +       if (!sysctl_enable_soft_offline) {
>>> +               pr_info("soft offline: %#lx: OS-wide disabled\n", pfn);
>>> +               return -EINVAL;
>>
>> IMO, "-EPERM" might sound better ;)
>>
>> Using "-EPERM" indicates that the operation is not permitted due to
>> the OS-wide configuration.
> 
> Miaohe suggested -EOPNOTSUPP. I agree both EOPNOTSUPP and EPERM may be
> better than EINVAL. But I wonder how about EAGAIN? With EAGAIN plus
> showing "disabled by /proc/sys/vm/enable_soft_offline" in dmesg, users
> now should be clear that they can try again with
> /proc/sys/vm/enable_soft_offline=1.

IMHO, it might not be suitable to use EAGAIN. Because it means "Resource temporarily unavailable" and
this can be solved by simply retry later without any further actions taken. But I might be wrong.

Thanks.
.

