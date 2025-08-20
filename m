Return-Path: <linux-kselftest+bounces-39364-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF46DB2D81E
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 11:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 227C17AE4C6
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 09:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568CB2E22A8;
	Wed, 20 Aug 2025 09:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="VFcTqMEB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32692E1742;
	Wed, 20 Aug 2025 09:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755681765; cv=none; b=gENFaoAdanvfGDYCb0+RSJGEWjSynzTzdKZXT3SsSX//XrPQfhQBJA9eUyhIHBEtLiZtAteoA7WVVhwVeS+VAhiaEY8VoZpcOm1rPNgx3CCyS6/Ns4lz5guNthFtnILM4WSlY9PQNFBr79/gSgbrqfvIt23sC2olzKte7USL//k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755681765; c=relaxed/simple;
	bh=yUCt1pPaMx7JVZBQZQbvE7z+7ajLYmKvOlONA/NhJV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MxQBuoxI12wO/b0D9tlpD5RbpqhW5RwscDvTb/NduOmAbCKnsU4TNpAeNkzICiG0+U6dbhy3UsrAZUQj1Lx3HqmxtFfk+RiKhV6hjIaI6cFR14V2/XSXeGUKpKAU8I9OPG8zFO/oas82aIEMDbRGBddO1AYeROecivvx6xLu9T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=VFcTqMEB; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755681753; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=YGgNtPnkWs24Cm5tQaMk9u0G5NYAGMzfPYAnpUK7BCE=;
	b=VFcTqMEBUKg16CarMORmCUvc0TckKrbN7LYdpujoCAbcuq03Za4SWI9TF6zd6hGZ1FMzmKuheep7M17X2mIFp2Z8yb+Keo4HsRW2+324rtYZVlgYN+6Uj/cF35QTU1FbuGX1TgsXcuHI2RcoOepCDQ0eeKLN2Q/H2YmvXHD8sos=
Received: from 30.74.144.118(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WmBG0pZ_1755681750 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 20 Aug 2025 17:22:30 +0800
Message-ID: <a81b7fd3-c466-45c9-9374-361b780ce09b@linux.alibaba.com>
Date: Wed, 20 Aug 2025 17:22:30 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/5] selftests/mm: add check_after_split_folio_orders()
 helper.
To: Zi Yan <ziy@nvidia.com>, Wei Yang <richard.weiyang@gmail.com>,
 wang lian <lianux.mm@gmail.com>, David Hildenbrand <david@redhat.com>,
 linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20250818184622.1521620-1-ziy@nvidia.com>
 <20250818184622.1521620-5-ziy@nvidia.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250818184622.1521620-5-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/8/19 02:46, Zi Yan wrote:
> The helper gathers a folio order statistics of folios within a virtual
> address range and checks it against a given order list. It aims to provide
> a more precise folio order check instead of just checking the existence of
> PMD folios.
> 
> The helper will be used the upcoming commit.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---

I tested this patch, and it works for me.
Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>

By the way, I moved gather_after_split_folio_orders() to the vm_util.c 
file as a helper for mTHP collapse checks in my patchset[1]. I'm not 
sure whether you need to move gather_after_split_folio_orders() to 
vm_util.c in this patch, or if I should move it in my patchset.

[1] 
https://lore.kernel.org/all/955e0b9682b1746c528a043f0ca530b54ee22536.1755677674.git.baolin.wang@linux.alibaba.com/

