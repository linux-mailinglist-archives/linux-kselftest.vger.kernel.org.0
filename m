Return-Path: <linux-kselftest+bounces-12620-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14562915FD4
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 09:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDC3E1F21FD8
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 07:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD751465BA;
	Tue, 25 Jun 2024 07:16:35 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A791465B3;
	Tue, 25 Jun 2024 07:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719299795; cv=none; b=N15jWGvZppPERcTJbZMuUk8O+QmmNc/0mOfihta4M9WsXZDcA8NvZAbDCIYEWDMO/o5j9vRC049+m1xCi4obXMytyI9p3IHTC1SXTlL6dIA1uFbcJ2v+F+MWghuvG3Dvt9UNjUrJIGyBfgCBp7RUjh1cSzp/FvdJFpeJwAi/uws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719299795; c=relaxed/simple;
	bh=9zZpuidzlAzl/sxGf+MCM0rDpPi7Scc+ocDdMqnjg1U=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=bw/LDy+3SuDxbZttQsfnrTdW9i/fKqDJjxtotZHAJxrpiXC027rNUk9eW/Fj7Fxtum5rNtnr0PB64yDrCnIYM5baJQrr8m7HcCRdFav+ZGwIY0xHXFIvPzQR2lEzh8U/BojwnUnIbB3LucOTvQzG6t5SitBKSiCBUxA1dNVTkTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4W7bcR3VcszZg15;
	Tue, 25 Jun 2024 15:12:07 +0800 (CST)
Received: from kwepemd200019.china.huawei.com (unknown [7.221.188.193])
	by mail.maildlp.com (Postfix) with ESMTPS id 3E7461402DE;
	Tue, 25 Jun 2024 15:16:30 +0800 (CST)
Received: from [10.173.127.72] (10.173.127.72) by
 kwepemd200019.china.huawei.com (7.221.188.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 25 Jun 2024 15:16:28 +0800
Subject: Re: [PATCH v5 4/4] docs: mm: add enable_soft_offline sysctl
To: Jiaqi Yan <jiaqiyan@google.com>
CC: <muchun.song@linux.dev>, <akpm@linux-foundation.org>, <shuah@kernel.org>,
	<corbet@lwn.net>, <osalvador@suse.de>, <rientjes@google.com>,
	<duenwen@google.com>, <fvdl@google.com>, <linux-mm@kvack.org>,
	<linux-kselftest@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<nao.horiguchi@gmail.com>, <jane.chu@oracle.com>, <ioworker0@gmail.com>
References: <20240624163348.1751454-1-jiaqiyan@google.com>
 <20240624163348.1751454-5-jiaqiyan@google.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <b9be3eff-6f69-5286-0dd9-30e562bdb7d2@huawei.com>
Date: Tue, 25 Jun 2024 15:16:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240624163348.1751454-5-jiaqiyan@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd200019.china.huawei.com (7.221.188.193)

On 2024/6/25 0:33, Jiaqi Yan wrote:
> Add the documentation for soft offline behaviors / costs, and what
> the new enable_soft_offline sysctl is for.
> 
> Acked-by: Oscar Salvador <osalvador@suse.de>
> 
> Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
> ---
>  Documentation/admin-guide/sysctl/vm.rst | 32 +++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)

LGTM. Thanks.
Acked-by: Miaohe Lin <linmiaohe@huawei.com>
Thanks.
.




