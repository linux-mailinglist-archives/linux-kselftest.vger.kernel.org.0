Return-Path: <linux-kselftest+bounces-47630-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6E5CC5E23
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 04:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D24B301EC40
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Dec 2025 03:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB167262B;
	Wed, 17 Dec 2025 03:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="oR+cDav9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C1E256D;
	Wed, 17 Dec 2025 03:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765941513; cv=none; b=Txngn4arXRqzh9KvvXsNyACliPyNDpdS2RcHnI9OdjQGluugR/W2FZr6b2UW4LH5QI6Cz+WXLR+PaagDw1u0XZPhS3kT2ZWh/gVaIBHtFWx982ATtVSzHsZy2YuefBJnTa6NwShmvLq0d6Olt5YR3GCC68J5T5dWchmwJURrOk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765941513; c=relaxed/simple;
	bh=8dL7aBrMbHQuWLe7o83TzNW1A4Opgrxt9bnUpPzEsqA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MH8gAL+pK6W2FR/cVdYpr5DjIb6FCQ9vGFzOIbWgahgPqzb9pzBArxfnXvM9Rn7NjFmDthOPT3z0B4GD2Y+9qylsw2cKcyORvINA2YZM6tP/lZ9UHx74l6wmGD8tLFJg9tnkIVaKAavjc0IsFOfAJk9KJicXxw3LK+TYYCbbapk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=oR+cDav9; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=ZUOzTgYQB8Tecz2GimhrlhEA5uFteptR3rbBR5YGgXs=;
	b=oR+cDav99PZGFTqVPoFeaCYAS52GFj3uo08gPMDEQTkxU7OmAyb5HCgdGxyQ6SazlXYGjaiHi
	LwI5EP0RJW+uOZ8YknIdKr/AGBHoTK0noPRP6gNgaLKWzgVFwrcomi5c11DXIKf8Nej70xLdorp
	9SsiSrcz9g5m+iAuRptAUuY=
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4dWJqF3MXVz1prLY;
	Wed, 17 Dec 2025 11:16:25 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 5707C140158;
	Wed, 17 Dec 2025 11:18:27 +0800 (CST)
Received: from [10.67.112.40] (10.67.112.40) by dggpemf200006.china.huawei.com
 (7.185.36.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 17 Dec
 2025 11:18:26 +0800
Message-ID: <b62c18a2-7036-4cca-a3e6-8a873a2ca832@huawei.com>
Date: Wed, 17 Dec 2025 11:18:20 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] selftests/mm: remove flaky header check
To: Kevin Brodsky <kevin.brodsky@arm.com>, <linux-mm@kvack.org>,
	<linux-kselftest@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes
	<lorenzo.stoakes@oracle.com>, Mark Brown <broonie@kernel.org>, Ryan Roberts
	<ryan.roberts@arm.com>, Shuah Khan <shuah@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
References: <20251216142633.2401447-1-kevin.brodsky@arm.com>
 <20251216142633.2401447-2-kevin.brodsky@arm.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <20251216142633.2401447-2-kevin.brodsky@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2025/12/16 22:26, Kevin Brodsky wrote:
> Commit 96ed62ea0298 ("mm: page_frag: fix a compile error when kernel
> is not compiled") introduced a check to avoid attempting to build
> the page_frag module if <linux/page_frag_cache.h> is missing.
> 
> Unfortunately this check only works if KDIR points to
> /lib/modules/... or an in-tree kernel build. It always fails if KDIR
> points to an out-of-tree build (i.e. when the kernel was built with
> O=$KDIR make) because only generated headers are present under
> $KDIR/include/ in that case.
> 
> <linux/page_frag_cache.h> was added more than a year ago (v6.13) so
> we can probably live without that check.

As some commercial OS still uses v6.6, I am wondering if we need that
check for a little longer, is it possible to do something like below to
avoid the flaky check?

@@ -46,7 +46,8 @@ CFLAGS += -U_FORTIFY_SOURCE

 KDIR ?= /lib/modules/$(shell uname -r)/build
 ifneq (,$(wildcard $(KDIR)/Module.symvers))
-ifneq (,$(wildcard $(KDIR)/include/linux/page_frag_cache.h))
+KSRC := $(shell readlink -f $(KDIR)/source 2>/dev/null || echo $(KDIR))
+ifneq (,$(wildcard $(KSRC)/include/linux/page_frag_cache.h))
 TEST_GEN_MODS_DIR := page_frag
 else
 PAGE_FRAG_WARNING = "missing page_frag_cache.h, please use a newer kernel"

> 
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Yunsheng Lin <linyunsheng@huawei.com>
> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
> ---
>  tools/testing/selftests/mm/Makefile | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
> index eaf9312097f7..aba51fcac752 100644
> --- a/tools/testing/selftests/mm/Makefile
> +++ b/tools/testing/selftests/mm/Makefile
> @@ -46,12 +46,8 @@ CFLAGS += -U_FORTIFY_SOURCE
>  
>  KDIR ?= /lib/modules/$(shell uname -r)/build
>  ifneq (,$(wildcard $(KDIR)/Module.symvers))
> -ifneq (,$(wildcard $(KDIR)/include/linux/page_frag_cache.h))
>  TEST_GEN_MODS_DIR := page_frag
>  else
> -PAGE_FRAG_WARNING = "missing page_frag_cache.h, please use a newer kernel"
> -endif
> -else
>  PAGE_FRAG_WARNING = "missing Module.symvers, please have the kernel built first"
>  endif
>  

