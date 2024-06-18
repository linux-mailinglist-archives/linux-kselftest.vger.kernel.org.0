Return-Path: <linux-kselftest+bounces-12117-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCCA90C230
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 05:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32B2A1C2206C
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 03:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DBA19D091;
	Tue, 18 Jun 2024 03:01:47 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6479819CCF6;
	Tue, 18 Jun 2024 03:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718679707; cv=none; b=Bf4ibeF55tXNmAm3G5kzNsE6zxnP+STnMJFXiGkL1eD/p5ovLciZEJJHoQ8uqRYxgeYuojtSoX3AC1yOv+QhLbUm6SphgUn/82tgmyWXzFUtebrsTeZulpEcw8+CwntocUfMqEEqXZ6zUH1RbxoiCpLsH/5XSlCtmjSCA1h5nRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718679707; c=relaxed/simple;
	bh=ROPSq3DntxyeU61ML55YtJPnVKnOvuO8SpuNe18ZsvI=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=FRlBLS6IJwOFSh8EC+OkS50kyOYSIyNoFsSt28QeTkardrfZ3QQiEMD0ZIPbQCnDv3r6NYVkz84yWYCDGGBNKDQ0iTjQWUStArrkLnLfulFCWYZP0iXqZwhpAHJgnZDGnTIUy+mCzYmTACIzXqRIaWHLM83Gzw7mWhO4nnlFD6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4W3BH42FR6znVbf;
	Tue, 18 Jun 2024 10:56:48 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id BA01518007A;
	Tue, 18 Jun 2024 11:01:40 +0800 (CST)
Received: from [10.173.127.72] (10.173.127.72) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 18 Jun 2024 11:01:39 +0800
Subject: Re: [PATCH v3 1/3] mm/memory-failure: userspace controls
 soft-offlining pages
To: Jiaqi Yan <jiaqiyan@google.com>, Andrew Morton <akpm@linux-foundation.org>
CC: <nao.horiguchi@gmail.com>, <jane.chu@oracle.com>, <ioworker0@gmail.com>,
	<muchun.song@linux.dev>, <shuah@kernel.org>, <corbet@lwn.net>,
	<osalvador@suse.de>, <rientjes@google.com>, <duenwen@google.com>,
	<fvdl@google.com>, <linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>
References: <20240617170545.3820912-1-jiaqiyan@google.com>
 <20240617170545.3820912-2-jiaqiyan@google.com>
 <20240617121348.4ee672a1d6bc9202b3ad0e08@linux-foundation.org>
 <CACw3F51wq4H-Hoxvm7GgCKodAR4Wy28hwBD=VngcF-fbxyRmUg@mail.gmail.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <1a40217a-240c-4efb-5c2a-fe885c0109ea@huawei.com>
Date: Tue, 18 Jun 2024 11:01:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CACw3F51wq4H-Hoxvm7GgCKodAR4Wy28hwBD=VngcF-fbxyRmUg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)

On 2024/6/18 7:17, Jiaqi Yan wrote:
> On Mon, Jun 17, 2024 at 12:13 PM Andrew Morton
> <akpm@linux-foundation.org> wrote:
>>
>> On Mon, 17 Jun 2024 17:05:43 +0000 Jiaqi Yan <jiaqiyan@google.com> wrote:
>>
>>> Correctable memory errors are very common on servers with large
>>> amount of memory, and are corrected by ECC. Soft offline is kernel's
>>> additional recovery handling for memory pages having (excessive)
>>> corrected memory errors. Impacted page is migrated to a healthy page
>>> if it is in-use; the original page is discarded for any future use.
>>>
>>> The actual policy on whether (and when) to soft offline should be
>>> maintained by userspace, especially in case of an 1G HugeTLB page.
>>> Soft-offline dissolves the HugeTLB page, either in-use or free, into
>>> chunks of 4K pages, reducing HugeTLB pool capacity by 1 hugepage.
>>> If userspace has not acknowledged such behavior, it may be surprised
>>> when later failed to mmap hugepages due to lack of hugepages.
>>> In case of a transparent hugepage, it will be split into 4K pages
>>> as well; userspace will stop enjoying the transparent performance.
>>>
>>> In addition, discarding the entire 1G HugeTLB page only because of
>>> corrected memory errors sounds very costly and kernel better not
>>> doing under the hood. But today there are at least 2 such cases
>>> doing so:
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
>>> new sysctl at /proc/sys/vm/enable_soft_offline. By default its value
>>> is set to 1 to preserve existing behavior in kernel. When set to 0,
>>> soft-offline (e.g. MADV_SOFT_OFFLINE) will fail with EOPNOTSUPP.
>>>
>>
>> Seems reasonable.  A very simple patch.
> 
> Thanks for taking a look, Andrew!
> 
>>
>> Is there sufficient instrumentation in place for userspace to be able
>> to know that these errors are occurring?  To be able to generally
>> monitor the machine's health?
> 
> For corrected memory errors, in general they are available in kernel
> logs. On X86 Machine Check handling will log unparsed MCs (one needs
> to read mci_status to know what exactly the error is). On ARM, GHES
> logs parsed CPER (already containing error type and error severity).
> The shortcoming is logs are rate limited. So in a burst of corrected
> memory errors the user may not be able to figure out exactly how many
> there were.
> 
> For uncorrectable memory errors, num_poisoned_pages is a reliable counter.
> 
>>
>>> @@ -2783,6 +2795,12 @@ int soft_offline_page(unsigned long pfn, int flags)
>>>               return -EIO;
>>>       }
>>>
>>> +     if (!sysctl_enable_soft_offline) {
>>> +             pr_info("%#lx: OS-wide disabled\n", pfn);
>>
>> This doesn't seem a very good message.  There's no indication that it
>> comes from the memory failure code at all.  If the sysadmin sees this
>> come out in the kernels logs, he/she will have to grep the kernel
>> sources just to figure out where the message came from.  Perhaps we can
>> be more helpful here..
> 
> For sure. I took it for granted that any pr_info will have the "Memory
> failure: " prefix, but now realize there is a `#undef pr_fmt` +
> `#define pr_fmt(fmt) "" fmt` just above unpoison_memory.
> 
> I propose to do `#define pr_fmt(fmt) "Soft offline: " fmt` above
> mf_isolate_folio, so that any soft-offline related code generates logs
> with the same following format:
> 
>   "Soft offline: 0x${pfn}: ${detailed_message}"
> 
> If everyone thinks this is reasonable, in v4 I can insert a new commit
> to make the log formats unified.

This sounds fine to me. And even better, `#define pr_fmt(fmt) "Unpoison: " fmt` can
also be done just above unpoison_memory.

Thanks.
.


