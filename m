Return-Path: <linux-kselftest+bounces-11170-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F03D58FABBB
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 09:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A56C01F2229C
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Jun 2024 07:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B7513FD82;
	Tue,  4 Jun 2024 07:19:47 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E38383CB4;
	Tue,  4 Jun 2024 07:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717485587; cv=none; b=fXg1uIjz6jbDkYd97Ur122uk4NS1zwyJ4+wiR/VdX+6DYuAv7q7e4yGm1+pvg/2ZWILpy+Aa3ko28BaJWCJExppguiBG02s5yh0gn/glDkRleWci0QAiI6wwxZuKP1YD/8R50yquaIYN1KhxUa+UBTh2GkErfI8sjd5mAamSdAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717485587; c=relaxed/simple;
	bh=4Khl4f/DSigpRlG4ZGWov9m82cDMFFJRLjDBwlz/h0w=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=hbakC4eoIFKwehh+zdsz9ZcGQKtGnHTHfn55Z/IyQxO+9OZRkoFjKn+ex7IOaRbHJlySbtxF4l6EUoroC/JDRxpRESBlta3eJxOedJDdqLh9SNEU5wIPvhV86xGnVMiOkapxrKj6kWO6QNK+JWK4zFiXUw+yMlv+1feJVsmkmQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Vthj02kJWz1ysV7;
	Tue,  4 Jun 2024 15:16:20 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 1CF0E1A016C;
	Tue,  4 Jun 2024 15:19:36 +0800 (CST)
Received: from [10.173.135.154] (10.173.135.154) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 4 Jun 2024 15:19:35 +0800
Subject: Re: [PATCH v1 0/3] Userspace controls soft-offline HugeTLB pages
To: Jiaqi Yan <jiaqiyan@google.com>, <naoya.horiguchi@nec.com>
CC: <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>,
	<shuah@kernel.org>, <corbet@lwn.net>, <osalvador@suse.de>,
	<rientjes@google.com>, <duenwen@google.com>, <fvdl@google.com>,
	<linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <muchun.song@linux.dev>
References: <20240531213439.2958891-1-jiaqiyan@google.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <21841726-6427-5a92-a3d1-8aac2687c01a@huawei.com>
Date: Tue, 4 Jun 2024 15:19:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240531213439.2958891-1-jiaqiyan@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)

On 2024/6/1 5:34, Jiaqi Yan wrote:
> Correctable memory errors are very common on servers with large
> amount of memory, and are corrected by ECC, but with two
> pain points to users:
> 1. Correction usually happens on the fly and adds latency overhead
> 2. Not-fully-proved theory states excessive correctable memory
>    errors can develop into uncorrectable memory error.

Thanks for your patch.

> 
> Soft offline is kernel's additional solution for memory pages
> having (excessive) corrected memory errors. Impacted page is migrated
> to healthy page if it is in use, then the original page is discarded
> for any future use.
> 
> The actual policy on whether (and when) to soft offline should be
> maintained by userspace, especially in case of HugeTLB hugepages.
> Soft-offline dissolves a hugepage, either in-use or free, into
> chunks of 4K pages, reducing HugeTLB pool capacity by 1 hugepage.
> If userspace has not acknowledged such behavior, it may be surprised
> when later mmap hugepages MAP_FAILED due to lack of hugepages.

For in use hugetlb folio case, migrate_pages() is called. The hugetlb pool
capacity won't be modified in that case. So I assume you're referring to the
free hugetlb folio case? The Hugetlb pool capacity is reduced in that case.
But if we don't do that, we might encounter uncorrectable memory error later
which will be more severe? Will it be better to add a way to compensate the
capacity?

> In addition, discarding the entire 1G memory page only because of
> corrected memory errors sounds very costly and kernel better not
> doing under the hood. But today there are at least 2 such cases:
> 1. GHES driver sees both GHES_SEV_CORRECTED and
>    CPER_SEC_ERROR_THRESHOLD_EXCEEDED after parsing CPER.
> 2. RAS Correctable Errors Collector counts correctable errors per
>    PFN and when the counter for a PFN reaches threshold
> In both cases, userspace has no control of the soft offline performed
> by kernel's memory failure recovery.

Userspace can figure out the hugetlb folio pfn range by using `page-types -b huge
-rlN` and then decide whether to soft offline the page according to it. But for
GHES driver, I think it has to be done in the kernel. So add a control in /sys/
seems like a good idea.

> 
> This patch series give userspace the control of soft-offlining
> HugeTLB pages: kernel only soft offlines hugepage if userspace has
> opt-ed in for that specific hugepage size, and exposed to userspace
> by a new sysfs entry called softoffline_corrected_errors under
> /sys/kernel/mm/hugepages/hugepages-${size}kB directory:
> * When softoffline_corrected_errors=0, skip soft offlining for all
>   hugepages of size ${size}kB.
> * When softoffline_corrected_errors=1, soft offline as before this

Will it be better to be called as "soft_offline_corrected_errors" or simplify "soft_offline_enabled"?

Thanks.
.

