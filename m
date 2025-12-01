Return-Path: <linux-kselftest+bounces-46831-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB54C987CE
	for <lists+linux-kselftest@lfdr.de>; Mon, 01 Dec 2025 18:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B12A04E1BB0
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Dec 2025 17:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C666C33373A;
	Mon,  1 Dec 2025 17:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jgxtlOKw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96639335BAC
	for <linux-kselftest@vger.kernel.org>; Mon,  1 Dec 2025 17:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764609391; cv=none; b=T+v8iUQBbymc6uSgZlm5Fa+TYjCiBv4+6m4J2DbyBKz8WBcQf4tzkCdK1Y8AFyGlJNEiByx+eExg5gRJL+gYraDoYJCzwu+Piy/y4RYIojimXb7AdbhA1GhA8gB13y4HKj+NIZyv8SarpN3f3MvdgfWq5egQhaxnmdYzQ5oqSHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764609391; c=relaxed/simple;
	bh=FcZez0vJBRGMJ/poINzC1pRyP+0B4+mCXgXuuSiE1+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DE3Fe5qFPqVxbaEzbsOvSr6Z9EdaLMxbCk9bDajOWQeqtSaYrD1TDKcg+1bhm6RkfOhacwMsrki2sWvgykLLii79eGvVyM+EZRbS0Bi//HqqntZViSq3Dc6gFr1dLlUptoTszP7A4KnWHip/jG+9VRQc7FJmzq+mEpSYfE4w/Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jgxtlOKw; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4998497c-87e8-4849-8442-b7281c627884@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764609385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y4emLxERSU432DRVgYdwZZc/maGKs+hdetkw753wwn8=;
	b=jgxtlOKwgj97JRRLqqH3Yvfd9oiUN0W+lJIH2imQAVg1NZSJldxAdMDOyOWnHbq9iouFwl
	IHgXoLDiucZlxUhMAcjj5+tIROfX4kBnJPGEeLIQSjJNex3aXdbTBnjKbCUuHMT6mD4/mf
	pGmXSSvxKylNyHc8pGxqNCnI9/0FIFs=
Date: Mon, 1 Dec 2025 09:16:06 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 00/21] vfio/pci: Base support to preserve a VFIO device
 file across Live Update
To: David Matlack <dmatlack@google.com>
Cc: Alex Williamson <alex@shazbot.org>,
 Adithya Jayachandran <ajayachandra@nvidia.com>, Alex Mastro
 <amastro@fb.com>, Alistair Popple <apopple@nvidia.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
 David Rientjes <rientjes@google.com>,
 Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Josh Hilke <jrhilke@google.com>,
 Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
 Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org,
 Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>,
 Parav Pandit <parav@nvidia.com>, Pasha Tatashin <pasha.tatashin@soleen.com>,
 Philipp Stanner <pstanner@redhat.com>, Pratyush Yadav <pratyush@kernel.org>,
 Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>,
 Shuah Khan <shuah@kernel.org>, Tomita Moeko <tomitamoeko@gmail.com>,
 Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
 Yi Liu <yi.l.liu@intel.com>, Yunxiang Li <Yunxiang.Li@amd.com>
References: <20251126193608.2678510-1-dmatlack@google.com>
 <dadaeeb9-4008-4450-8b61-e147a2af38b2@linux.dev>
 <46bbdad1-486d-4cb1-915f-577b00de827f@linux.dev>
 <CALzav=eigAYdw5-hzk1MAHWBU29yJK4_WWTd0dyoBN91bnRoZQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <CALzav=eigAYdw5-hzk1MAHWBU29yJK4_WWTd0dyoBN91bnRoZQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2025/12/1 9:10, David Matlack 写道:
> On Mon, Dec 1, 2025 at 7:49 AM Zhu Yanjun <yanjun.zhu@linux.dev> wrote:
>> 在 2025/11/27 20:56, Zhu Yanjun 写道:
>>> Hi, David
>>>
>>> ERROR: modpost: "liveupdate_register_file_handler" [drivers/vfio/pci/
>>> vfio-pci-core.ko] undefined!
>>>
>>> ERROR: modpost: "vfio_pci_ops" [drivers/vfio/pci/vfio-pci-core.ko]
>>> undefined!
>>> ERROR: modpost: "liveupdate_enabled" [drivers/vfio/pci/vfio-pci-core.ko]
>>> undefined!
>>> ERROR: modpost: "liveupdate_unregister_file_handler" [drivers/vfio/pci/
>>> vfio-pci-core.ko] undefined!
>>> ERROR: modpost: "vfio_device_fops" [drivers/vfio/pci/vfio-pci-core.ko]
>>> undefined!
>>> ERROR: modpost: "vfio_pci_is_intel_display" [drivers/vfio/pci/vfio-pci-
>>> core.ko] undefined!
>>> ERROR: modpost: "vfio_pci_liveupdate_init" [drivers/vfio/pci/vfio-
>>> pci.ko] undefined!
>>> ERROR: modpost: "vfio_pci_liveupdate_cleanup" [drivers/vfio/pci/vfio-
>>> pci.ko] undefined!
>>> make[4]: *** [scripts/Makefile.modpost:147: Module.symvers] Error 1
>>> make[3]: *** [Makefile:1960: modpost] Error 2
>>>
>>> After I git clone the source code from the link https://github.com/
>>> dmatlack/linux/tree/liveupdate/vfio/cdev/v1,
>>>
>>> I found the above errors when I built the source code.
>>>
>>> Perhaps the above errors can be solved by EXPORT_SYMBOL.
>>>
>>> But I am not sure if a better solution can solve the above problems or not.
>> I reviewed this patch series in detail. If I’m understanding it
>> correctly, there appears to be a cyclic dependency issue. Specifically,
>> some functions in kernel module A depend on kernel module B, while at
>> the same time certain functions in module B depend on module A.
>>
>> I’m not entirely sure whether this constitutes a real problem or if it’s
>> intentional design.
> Thanks for your report. Can you share the .config file you used to
> generate these errors?


IIRC, I used FC 42 default config. Perhaps you can make tests with it. 
If this problem can not be reproduced, I will share my config with you.

Yanjun.Zhu


-- 
Best Regards,
Yanjun.Zhu


