Return-Path: <linux-kselftest+bounces-41815-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3403B838A2
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 10:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC2EE3BD218
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 08:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179442FB0BB;
	Thu, 18 Sep 2025 08:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="NAzFNn9G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550D52F8BD2;
	Thu, 18 Sep 2025 08:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758184453; cv=none; b=DMaf32GSbO27flT/3acj9/8l8S7lyQqX1IKtBqjw6urljvK/vwUyazqk+oDp57oGorVkpj1S96B4FxP4Hqzn1ncaM1tN6hBSNtMIxSy0OqULWZ+2/o8aswMBetHZzxQa9f5bXl/5Byy4ytG3TabXPoMJ884xflXcu+6Rh5QCevA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758184453; c=relaxed/simple;
	bh=YUyJj+AOLpQZ16qQcLa96qh1A9RBn/gEjHPtLkjTIFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z4OPLVDun7BBava3Zt5BBY7Wen4P8yWiaQqvkwU98a/C2zH6wAwRe5eQGIb9noMi0L7OPr3di5aPXdhrHjcwKYFfPqEwIfCzB3mlQCdk9MVokHTGHiDY+2biRC2RofMQ8+8Zj0iIo9CkCFxg2w8Evot+z8DvIPIUPhF9j1eVRFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=NAzFNn9G; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758184447; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=iHPyCqwaIE53kfvtOqEjL6h4xRme2WCE41tGRMbg4OA=;
	b=NAzFNn9GOVJAkfAMVdrcB07/dc9Ms6BXy74/eleljuE18J5xeCe+MSNCWI7mIBMNSKnAqNLzjwLm6kSAz8lYe1mcIwN/wPqqqWp2scY/NlMqRt6OvyP2fdTyiQYDDC+xHtbgB7ivv075GdoONkKJHKPWItxHsyJUsKpC8Jrumlc=
Received: from 30.246.178.33(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WoFHDqY_1758184444 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 18 Sep 2025 16:34:05 +0800
Message-ID: <1211fd9a-93e6-4ebe-a80d-083601138b70@linux.alibaba.com>
Date: Thu, 18 Sep 2025 16:34:03 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/memory-failure: Support disabling soft offline for
 HugeTLB pages
To: Kyle Meyer <kyle.meyer@hpe.com>, "Fan, Shawn" <shawn.fan@intel.com>
Cc: "Luck, Tony" <tony.luck@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, "corbet@lwn.net"
 <corbet@lwn.net>, "david@redhat.com" <david@redhat.com>,
 "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
 "shuah@kernel.org" <shuah@kernel.org>,
 "jane.chu@oracle.com" <jane.chu@oracle.com>,
 "jiaqiyan@google.com" <jiaqiyan@google.com>,
 "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
 "bp@alien8.de" <bp@alien8.de>, "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
 "jack@suse.cz" <jack@suse.cz>,
 "joel.granados@kernel.org" <joel.granados@kernel.org>,
 "laoar.shao@gmail.com" <laoar.shao@gmail.com>,
 "lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
 "mclapinski@google.com" <mclapinski@google.com>,
 "mhocko@suse.com" <mhocko@suse.com>,
 "nao.horiguchi@gmail.com" <nao.horiguchi@gmail.com>,
 "osalvador@suse.de" <osalvador@suse.de>,
 "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
 "rppt@kernel.org" <rppt@kernel.org>, "Anderson, Russ"
 <russ.anderson@hpe.com>, "surenb@google.com" <surenb@google.com>,
 "vbabka@suse.cz" <vbabka@suse.cz>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <aMiu_Uku6Y5ZbuhM@hpe.com>
 <20250915201618.7d9d294a6b22e0f71540884b@linux-foundation.org>
 <aMkOCmGBhZKhKPrI@hpe.com>
 <SJ1PR11MB60831F028E2FEB6B5A3390D9FC14A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <aMmlhPghbpnlCZ09@hpe.com>
 <SJ1PR11MB60833884799B6AA2BC18ECE7FC14A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <LV4PR11MB9513A6EFA88B082E554CB8D6EB17A@LV4PR11MB9513.namprd11.prod.outlook.com>
 <aMsE9XjWKEYTIQyV@hpe.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <aMsE9XjWKEYTIQyV@hpe.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/9/18 02:59, Kyle Meyer 写道:
> On Wed, Sep 17, 2025 at 06:35:14AM +0000, Fan, Shawn wrote:
>>>> My original patch for this just skipped the GHES->offline process
>>>> for huge pages. But I wasn't aware of the sysctl control. That provides
>>>> a better solution.
>>>
>>> Tony, does that mean you're OK with using the existing sysctl interface? If
>>> so, I'll just send a separate patch to update the sysfs-memory-page-offline
>>> documentation and drop the rest.
>>
>> Kyle,
>>
>> It depends on which camp the external customer that reported this
>> falls into:
>>
>> 1) "I'm OK disabling all soft offline requests".
>>
>> or the:
>>
>> 2) "I'd like 4K pages to still go offline if the BIOS asks, just not any huge pages".
>>
>> Shawn: Can you please find out?
>>
>>
>> -> Prefer the 2nd option,  "4K pages still go offline if the BIOS asks, just not any huge pages."
> 
> OK, thank you.
> 
> Does that mean they want to avoid offlining transparent huge pages as well?
> 
> Thanks,
> Kyle Meyer


Hi, Shawn,

As memory access is typically interleaved between channels. When the
per-rank threshold is exceeded, soft-offlining the last accessed address
seems unreasonable - regardless of whether it's a 4KB page or a huge
page. The error accumulation happens at the rank level, but the action
is taken on a specific page that happened to trigger the threshold,
which doesn't address the underlying issue.

I prefer the first option that disabling all soft offline requests from
GHES driver.

Thanks.
Shuai

