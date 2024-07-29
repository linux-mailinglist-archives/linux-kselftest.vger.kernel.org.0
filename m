Return-Path: <linux-kselftest+bounces-14351-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5824C93EEA5
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 09:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E3681F213AB
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 07:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B5312CD96;
	Mon, 29 Jul 2024 07:40:47 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D54D12C554;
	Mon, 29 Jul 2024 07:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722238847; cv=none; b=GHxw+yYyBdj2GryFbse0+84gTXxAjX0RNX6AithlvFuXljVyLYRSZSK7CQJh8p2T1MFPYejKayVc9lE7xrNyjkLMMjeiwgrVgCUo+yGGPpj70t6bO+o9yvkSLTL4G69yny96bm1I9un4wmCk/f7h1XYSu3z0ABl6izZHE+mc4jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722238847; c=relaxed/simple;
	bh=eia76iIeQOuBae5ZXANmVL9PqBgSGOaTFqg0hi9Qbi8=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Rc3hTHH5nmBVzlZvVp2vSPBryjWfe5uLyxXjaJE8USuNZX8k10d5f2LxPHaUuWnDcISw4MpDI+Z0bkk39SJVjmiJ5d9qMUdUEqJqCg+nZpL0sf1aQubEBLofco3xUrgWoxX50Fm1Yi1Qj3JCe0EAgqsuv+7GytvPqkhqgX1fiSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WXVbc0HX5zdkPh;
	Mon, 29 Jul 2024 15:38:52 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id 7EFC41404F8;
	Mon, 29 Jul 2024 15:40:41 +0800 (CST)
Received: from [10.174.178.219] (10.174.178.219) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 29 Jul 2024 15:40:40 +0800
Subject: Re: [PATCH v2] kselftests: dmabuf-heaps: Ensure the driver name is
 null-terminated
To: <daniel.vetter@ffwll.ch>
References: <20240729024604.2046-1-yuzenghui@huawei.com>
 <Zqc-ZWlTYwnKHoQK@phenom.ffwll.local>
CC: <linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
	<linaro-mm-sig@lists.linaro.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <sumit.semwal@linaro.org>,
	<benjamin.gaignard@collabora.com>, <Brian.Starkey@arm.com>,
	<jstultz@google.com>, <tjmercier@google.com>, <shuah@kernel.org>,
	<wanghaibin.wang@huawei.com>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <8d318883-4ea3-b1d8-6613-6ca21a4ba2d2@huawei.com>
Date: Mon, 29 Jul 2024 15:40:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Zqc-ZWlTYwnKHoQK@phenom.ffwll.local>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600007.china.huawei.com (7.193.23.208)

On 2024/7/29 15:01, Daniel Vetter wrote:
> On Mon, Jul 29, 2024 at 10:46:04AM +0800, Zenghui Yu wrote:
> > Even if a vgem device is configured in, we will skip the import_vgem_fd()
> > test almost every time.
> >
> >   TAP version 13
> >   1..11
> >   # Testing heap: system
> >   # =======================================
> >   # Testing allocation and importing:
> >   ok 1 # SKIP Could not open vgem -1
> >
> > The problem is that we use the DRM_IOCTL_VERSION ioctl to query the driver
> > version information but leave the name field a non-null-terminated string.
> > Terminate it properly to actually test against the vgem device.
> >
> > While at it, let's check the length of the driver name is exactly 4 bytes
> > and return early otherwise (in case there is a name like "vgemfoo" that
> > gets converted to "vgem\0" unexpectedly).
> >
> > Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
> > ---
> > * From v1 [1]:
> >   - Check version.name_len is exactly 4 bytes and return early otherwise
> >
> > [1] https://lore.kernel.org/r/20240708134654.1725-1-yuzenghui@huawei.com
> 
> Thanks for your patch, I'll push it to drm-misc-next-fixes.
> 
> > P.S., Maybe worth including the kselftests file into "DMA-BUF HEAPS
> > FRAMEWORK" MAINTAINERS entry?
> 
> Good idea, want to do the patch for that too?

Sure, I can send a patch for that today.

Thanks,
Zenghui

