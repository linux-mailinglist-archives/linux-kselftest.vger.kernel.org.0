Return-Path: <linux-kselftest+bounces-12531-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B579140DB
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 05:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4ACB1C212F4
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 03:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98ED56FB1;
	Mon, 24 Jun 2024 03:41:35 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D337B623;
	Mon, 24 Jun 2024 03:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719200495; cv=none; b=rPgG0HMQ9ph6IYrtUTypKV9ypzIc9nvYV9gGKoB25nzieh+4sDEJ+v6jiZyMeLtYnJm8KDUfXkytZUBmJjyEo6/BUj1B0RUYGbcVe3+i4mLFBEoXqifOTZeqQyOEYNoDWsCiWjuXkW/6sBA8VyZVpa0d8DTtIFndtVYHMHBQffU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719200495; c=relaxed/simple;
	bh=E1vToBuUQ2HPtfx+Ca740WgpWYW2FSmFop1h8+FeDh4=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=RQ0CLFCXyH8F+XryM2rPF9yvW/jGQVAJ/kWyYi1SlQ9mJiJXBO8aH/nYfPC9u0nzSpnjRJ6zTRU0DymEdXxSffSbxObe/nBmD4pmtGPz79B1OShM1SxRZZUtRYw6VJR+sRE1rBXLy4IlafTarc/qJc8rLKxsUOcZ5odgx3QnYis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4W6ttx1xcjzxT4Y;
	Mon, 24 Jun 2024 11:37:13 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 8BB311402E2;
	Mon, 24 Jun 2024 11:41:30 +0800 (CST)
Received: from [10.173.127.72] (10.173.127.72) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 24 Jun 2024 11:41:29 +0800
Subject: Re: [PATCH v4 2/4] mm/memory-failure: userspace controls
 soft-offlining pages
To: Jiaqi Yan <jiaqiyan@google.com>
CC: <muchun.song@linux.dev>, <akpm@linux-foundation.org>, <shuah@kernel.org>,
	<corbet@lwn.net>, <rientjes@google.com>, <duenwen@google.com>,
	<fvdl@google.com>, <linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <nao.horiguchi@gmail.com>,
	<jane.chu@oracle.com>, <osalvador@suse.de>
References: <20240620184856.600717-1-jiaqiyan@google.com>
 <20240620184856.600717-3-jiaqiyan@google.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <a272d16f-fb9a-48df-c90a-e848f2d44210@huawei.com>
Date: Mon, 24 Jun 2024 11:41:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240620184856.600717-3-jiaqiyan@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)

On 2024/6/21 2:48, Jiaqi Yan wrote:
> Correctable memory errors are very common on servers with large
...
>  
>  /*
> @@ -2749,8 +2760,9 @@ static int soft_offline_in_use_page(struct page *page)
>   * @pfn: pfn to soft-offline
>   * @flags: flags. Same as memory_failure().
>   *
> - * Returns 0 on success
> - *         -EOPNOTSUPP for hwpoison_filter() filtered the error event
> + * Returns 0 on success,
> + *         -EOPNOTSUPP for hwpoison_filter() filtered the error event,
> + *         -EOPNOTSUPP if disabled by /proc/sys/vm/enable_soft_offline,

No strong opinion, but it might be better to write as "or disabled by /proc/sys/vm/enable_soft_offline".

Acked-by: Miaohe Lin <linmiaohe@huawei.com>
Thanks.
.


