Return-Path: <linux-kselftest+bounces-12033-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9FA90A841
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 10:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6198DB21872
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 08:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1B118C35F;
	Mon, 17 Jun 2024 08:17:03 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF957492;
	Mon, 17 Jun 2024 08:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718612223; cv=none; b=HOplmK59pBELSi2JBllugGvwF0COs5lllMgFAgYIBf1dukzKyWVYquUPALER2FDNQxlXbXhAqGQxtU57CqlLdL/URKG04nqGb/GjtmiPy46FftgbcM94f+vRKK7yctvkVkTd01GlZOu7evY6AdBDh0rAWkMaaHgTs0XdorhiFr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718612223; c=relaxed/simple;
	bh=0Q57YgTwQK5/cF3o7Oawjt7yKEK15mDDg+PrsDfBLio=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=F9h5y+dREoNzPW3TqGXpnwQvwEJCn6g6lnhn89zxptXtyvgNOjQpIIThe/v0E6O9swxTSS3dVZyq+AsrYJcixyXQP0WaiLHmPuxoMgtESecLSPeGSNpUmmn0tbHvll/03Up0lp3zrc9NzVRukZs/c/creu5R1SQ6yzM+gsajxOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4W2jLN5JXsz2Ck7Y;
	Mon, 17 Jun 2024 16:13:00 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id A8C96180066;
	Mon, 17 Jun 2024 16:16:52 +0800 (CST)
Received: from [10.173.127.72] (10.173.127.72) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 17 Jun 2024 16:16:51 +0800
Subject: Re: [PATCH v2 1/3] mm/memory-failure: userspace controls
 soft-offlining pages
To: Oscar Salvador <osalvador@suse.de>, Jiaqi Yan <jiaqiyan@google.com>, Lance
 Yang <ioworker0@gmail.com>
CC: <nao.horiguchi@gmail.com>, <jane.chu@oracle.com>, <muchun.song@linux.dev>,
	<akpm@linux-foundation.org>, <shuah@kernel.org>, <corbet@lwn.net>,
	<rientjes@google.com>, <duenwen@google.com>, <fvdl@google.com>,
	<linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>
References: <20240611215544.2105970-1-jiaqiyan@google.com>
 <20240611215544.2105970-2-jiaqiyan@google.com>
 <CABzRoyYGY2EgT5wC9o98Vn_auh59poQ-OOnKceCiWQAJrbZoBw@mail.gmail.com>
 <CACw3F5134NmmLNr4zXHV1h0sLMTGcAJLpApQ7Fv_-DtUieD7zw@mail.gmail.com>
 <786a08ff-aa7e-49d5-f589-0a405c7e1a34@huawei.com>
 <ea8c5e390bd18c532b768dd9eeaa105a@suse.de>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <8faf45d3-0722-2b9e-f641-9d081aad5a82@huawei.com>
Date: Mon, 17 Jun 2024 16:16:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ea8c5e390bd18c532b768dd9eeaa105a@suse.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)

On 2024/6/17 15:51, Oscar Salvador wrote:
> On 2024-06-17 09:31, Miaohe Lin wrote:
> 
>> IMHO, it might not be suitable to use EAGAIN. Because it means
>> "Resource temporarily unavailable" and
>> this can be solved by simply retry later without any further actions
>> taken. But I might be wrong.
> 
> We usually use 'EOPNOTSUPP' when we fail due to a setting not being set.
> EPERM is more for a capability matter.

Thanks Oscar. So we should return EOPNOTSUPP here.

Thanks.
.

