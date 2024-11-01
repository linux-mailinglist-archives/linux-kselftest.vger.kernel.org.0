Return-Path: <linux-kselftest+bounces-21288-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A887F9B9011
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 12:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E8541F2249B
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 11:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C1919ABC5;
	Fri,  1 Nov 2024 11:14:20 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2556B19B3D3;
	Fri,  1 Nov 2024 11:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730459660; cv=none; b=JyIQ1m5OO1U8hce18+/Pdt3BoyviiEgepO2hAvncUKh0MjA38MX5OlJ8gVMZV2pEt7WSEmhKhW/KHD9JWXaZBp2HB0okEhNdQi74jS70Vlj2pKHgUPWpinmqRilqWjWdErQC/kxkcFEbjZ6jQka53c8QBEsM81E5T336jFYAMR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730459660; c=relaxed/simple;
	bh=sB/xWclADAe6BbjPs39pElgMK/SnHQ3N0shlhyPNvg8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=py02dde8JTxG0MaxKLdTYhRrtmdbqOTx3pgFI+G0/4U6ex0W0S5IpH/1nEZ87BX3J5xtjoVnlGX572JR7cAYrdrpHMFr7qGo+ZkZNAB7uAbEmQJ43NsKZGBHy+Vy4EOOWM7lciV7KHoIZlIgDAwZXG4dCyTLGz6Bww9IuuFuipg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Xfyqh4N5mz10PQn;
	Fri,  1 Nov 2024 19:12:00 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 5E82A140202;
	Fri,  1 Nov 2024 19:14:14 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 1 Nov 2024 19:14:14 +0800
Message-ID: <763d9630-3064-4d88-8e99-549a07328ec8@huawei.com>
Date: Fri, 1 Nov 2024 19:14:13 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 2/7] net: page_pool: create
 page_pool_alloc_netmem
To: Mina Almasry <almasrymina@google.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jesper Dangaard Brouer
	<hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Shuah Khan
	<shuah@kernel.org>
References: <20241029204541.1301203-1-almasrymina@google.com>
 <20241029204541.1301203-3-almasrymina@google.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <20241029204541.1301203-3-almasrymina@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/10/30 4:45, Mina Almasry wrote:
> Create page_pool_alloc_netmem to be the mirror of page_pool_alloc.
> 
> This enables drivers that want currently use page_pool_alloc to
> transition to netmem by converting the call sites to
> page_pool_alloc_netmem.

For old API, page_pool_alloc_pages() always return a whole page, and
page_pool_alloc() returns a whole page or a page fragment based on the
requested size.

For new netmem API, page_pool_alloc_netmems() always return a whole
netmem, and page_pool_alloc_netmem() returns a whole netmem or a netmem
fragment based on the requested size.

Isn't it a little odd that old and new are not following the same
pattern?

