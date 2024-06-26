Return-Path: <linux-kselftest+bounces-12757-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 564D691751E
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 02:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBF201F22560
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 00:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116861FDA;
	Wed, 26 Jun 2024 00:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TqeUx0T1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6F1EC2;
	Wed, 26 Jun 2024 00:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719360145; cv=none; b=dwFcW/GUUn8AqcehfgWje6NOfzOV05CRDD0dE1bZDHLQKveo1UR/uL3ReldswsWx75jhxWBW5mfVLfuyWESgyVjCnDjszKu5FQBoQLDP3uvg1j7pnSz9S2/4O5uKBvadiqvem+hIzGHBnrGao8cvUYMS4FVuQWJNceSC8kJnEVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719360145; c=relaxed/simple;
	bh=/2IBfj1eds1oagrh/9XL5GsGZRw70KnkF73QwnMy1es=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XBQ/QqRtY26H66EBDHsyw3AM3V+vF8tLCBDB48X5QjwKcPmTv7oKlTInu22PuKtWMwB77dEC9XBgZ6JnfUZy40aiZwf7cCA0tl6R7qzrAN6oLsyhuE0cuBWopC77NHcA4rS9fW8f7T2KRjXBpsFaVBLAgMEYApuPDIJ144/p3LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TqeUx0T1; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=1mNvHSeA/32WVrnX7X9JQIGgpQLA3aHXM77KwB0Y8R4=; b=TqeUx0T18zMZQyijpiKcmomH21
	ZPZiODfZvN5e/bC6hxb6YYkViWcG2b8QnHrjUii8pGy9Z6vJ0zoLE9Ve2kgeF9j8HbpehkxWbZoN9
	4VLKWdmevQtus91Jpkk2eO9yzTnOi3PAHV0v849+Z0MJ7A+fFs9kQN9HvkWl2gbPEQHRoq6EmkJCY
	acj44wePR1KS1XsWcpoTRU8vpTxo9r4iiUEi8cWRV1tslzUpcq2KfAMaHOo89CGqU5LKSBkYNGAT+
	MtHsnzVbibbBJIRJA77FJ4W3CtiErb12datXszy8OYw1qqhnnb4u9Tlt9F1metwEUSFqDulNLvPoM
	/8y9bjsw==;
Received: from [50.53.4.147] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMG74-00000004rBo-0bQL;
	Wed, 26 Jun 2024 00:02:14 +0000
Message-ID: <78857a6a-f9a2-4072-b2d4-82fcfda25d2d@infradead.org>
Date: Tue, 25 Jun 2024 17:02:12 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] docs: mm: add enable_soft_offline sysctl
To: Jiaqi Yan <jiaqiyan@google.com>, nao.horiguchi@gmail.com,
 linmiaohe@huawei.com, jane.chu@oracle.com, ioworker0@gmail.com
Cc: muchun.song@linux.dev, akpm@linux-foundation.org, shuah@kernel.org,
 corbet@lwn.net, osalvador@suse.de, rientjes@google.com, duenwen@google.com,
 fvdl@google.com, linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20240624163348.1751454-1-jiaqiyan@google.com>
 <20240624163348.1751454-5-jiaqiyan@google.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240624163348.1751454-5-jiaqiyan@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi--

On 6/24/24 9:33 AM, Jiaqi Yan wrote:
> Add the documentation for soft offline behaviors / costs, and what
> the new enable_soft_offline sysctl is for.
> 
> Acked-by: Oscar Salvador <osalvador@suse.de>
> 
> Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
> ---
>  Documentation/admin-guide/sysctl/vm.rst | 32 +++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
> index e86c968a7a0e..71463a7b3e2a 100644
> --- a/Documentation/admin-guide/sysctl/vm.rst
> +++ b/Documentation/admin-guide/sysctl/vm.rst
> @@ -267,6 +268,37 @@ used::
>  These are informational only.  They do not mean that anything is wrong
>  with your system.  To disable them, echo 4 (bit 2) into drop_caches.
>  
> +enable_soft_offline
> +===================
> +Correctable memory errors are very common on servers. Soft-offline is kernel's
> +solution for memory pages having (excessive) corrected memory errors.
> +
> +For different types of page, soft-offline has different behaviors / costs.
> +- For a raw error page, soft-offline migrates the in-use page's content to
> +  a new raw page.
> +- For a page that is part of a transparent hugepage,  soft-offline splits the

Use only one space after the comma ...................^

> +  transparent hugepage into raw pages, then migrates only the raw error page.
> +  As a result, user is transparently backed by 1 less hugepage, impacting
> +  memory access performance.
> +- For a page that is part of a HugeTLB hugepage, soft-offline first migrates
> +  the entire HugeTLB hugepage, during which a free hugepage will be consumed
> +  as migration target.  Then the original hugepage is dissolved into raw
> +  pages without compensation, reducing the capacity of the HugeTLB pool by 1.
> +
> +It is user's call to choose between reliability (staying away from fragile
> +physical memory) vs performance / capacity implications in transparent and
> +HugeTLB cases.
> +
> +For all architectures, enable_soft_offline controls whether to soft offline
> +memory pages.  When setting to 1, kernel attempts to soft offline the pages

                  When set to 1,

> +whenever it thinks needed.  When setting to 0, kernel returns EOPNOTSUPP to

                               When set to 0,

> +the request to soft offline the pages.  Its default value is 1.
> +
> +It is worth mentioning that after setting enable_soft_offline to 0, the
> +following requests to soft offline pages will not be performed:
> +- Request to soft offline pages from RAS Correctable Errors Collector.
> +- On ARM, the request to soft offline pages from GHES driver.
> +- On PARISC, the request to soft offline pages from Page Deallocation Table.
>  
>  extfrag_threshold
>  =================

-- 
~Randy

