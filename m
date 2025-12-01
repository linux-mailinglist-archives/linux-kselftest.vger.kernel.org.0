Return-Path: <linux-kselftest+bounces-46857-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7EDC9946A
	for <lists+linux-kselftest@lfdr.de>; Mon, 01 Dec 2025 22:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ED45A4E2FD3
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Dec 2025 21:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7D527FD5A;
	Mon,  1 Dec 2025 21:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PWZDy8qZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5F4285CBA
	for <linux-kselftest@vger.kernel.org>; Mon,  1 Dec 2025 21:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764626241; cv=none; b=lLXHoN14shPE4WmA6lv43veHm4XisJBlBogBi2yt4iwHhzWWG3j21Sl2ld3FJTDd1Nz3YO/Q8qjCafY8on8inCmsHKtpY94j9yp8kFhjm+rk5xiqqb3znt7CT+iuF7PnHJCOk8Xo5+bu+pktW1xZDS8XM82aNp0YZ7s+mN0VF7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764626241; c=relaxed/simple;
	bh=qZWIlvtYphfZcCD2iB+89oKRSWC8v4am+O1Yam6YnyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d5ORvmYYdtU3/62xHo9d3mLC6WPV9C1dWoHXNHohAKohC+4h4qC0qM2tCJzs5h+zb5q55qb1Pr9teXrgzwdqsO3aWJB7hlGm4Suwi/Bk7FJnFKT4VPBpKBUfR/uEV7ULL9uOVZM1dzV9bDSBc8JhKrDkEYZDpbVNlSgEMNlejhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PWZDy8qZ; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7ad2c03d-47bf-4eb2-98f9-44919bb19b8d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764626225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HIgEooAuZfYBGtSMdgL7MEx82djnBNlIKpwfR1F7SPM=;
	b=PWZDy8qZon+1l3Nw4SGR5/7DDnYUlb5R7CZVgA8WLZe8DB3ggmiU4/3I5XtstYgHr7y0xl
	3xtmagQ3rjtWQtJ/MWJDe02OMfYIjo/G5Dx6+ODzd6k9tbc5zYxhlQpdKHd5FOnVb3hBTc
	oDEnPvBC92TYpKx4pxV50O+axsgHpWs=
Date: Mon, 1 Dec 2025 13:56:57 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 00/21] vfio/pci: Base support to preserve a VFIO device
 file across Live Update
To: David Matlack <dmatlack@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
 Alex Williamson <alex@shazbot.org>,
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
 Parav Pandit <parav@nvidia.com>, Philipp Stanner <pstanner@redhat.com>,
 Pratyush Yadav <pratyush@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
 Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <shuah@kernel.org>,
 Tomita Moeko <tomitamoeko@gmail.com>, Vipin Sharma <vipinsh@google.com>,
 William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
 Yunxiang Li <Yunxiang.Li@amd.com>
References: <20251126193608.2678510-1-dmatlack@google.com>
 <dadaeeb9-4008-4450-8b61-e147a2af38b2@linux.dev>
 <46bbdad1-486d-4cb1-915f-577b00de827f@linux.dev>
 <CALzav=eigAYdw5-hzk1MAHWBU29yJK4_WWTd0dyoBN91bnRoZQ@mail.gmail.com>
 <4998497c-87e8-4849-8442-b7281c627884@linux.dev>
 <aS3RF6ROa7uZsviv@google.com> <aS3SJxAjVT-ZH1YT@google.com>
 <CA+CK2bDQh6jG53mbksYW7WjukSKy6egCfKs8+mmAcNKSQ9m4mQ@mail.gmail.com>
 <3aa3a726-147d-4573-ae50-eef94a910640@linux.dev>
 <CALzav=fCjZnU5jqHTwFziAcssUys+XqWX1GkM7_PGufBnVyPmQ@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Yanjun.Zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <CALzav=fCjZnU5jqHTwFziAcssUys+XqWX1GkM7_PGufBnVyPmQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 12/1/25 1:48 PM, David Matlack wrote:
> On Mon, Dec 1, 2025 at 1:46 PM Yanjun.Zhu <yanjun.zhu@linux.dev> wrote:
>>
>> On 12/1/25 9:44 AM, Pasha Tatashin wrote:
>>> On Mon, Dec 1, 2025 at 12:36 PM David Matlack <dmatlack@google.com> wrote:
>>>> On 2025-12-01 05:32 PM, David Matlack wrote:
>>>>> On 2025-12-01 09:16 AM, Zhu Yanjun wrote:
>>>>>> 在 2025/12/1 9:10, David Matlack 写道:
>>>>>>> On Mon, Dec 1, 2025 at 7:49 AM Zhu Yanjun <yanjun.zhu@linux.dev> wrote:
>>>>>>>> 在 2025/11/27 20:56, Zhu Yanjun 写道:
>>>>>>>>> Hi, David
>>>>>>>>>
>>>>>>>>> ERROR: modpost: "liveupdate_register_file_handler" [drivers/vfio/pci/
>>>>>>>>> vfio-pci-core.ko] undefined!
>>>>>>>>>
>>>>>>>>> ERROR: modpost: "vfio_pci_ops" [drivers/vfio/pci/vfio-pci-core.ko]
>>>>>>>>> undefined!
>>>>>>>>> ERROR: modpost: "liveupdate_enabled" [drivers/vfio/pci/vfio-pci-core.ko]
>>>>>>>>> undefined!
>>>>>>>>> ERROR: modpost: "liveupdate_unregister_file_handler" [drivers/vfio/pci/
>>>>>>>>> vfio-pci-core.ko] undefined!
>>>>>>>>> ERROR: modpost: "vfio_device_fops" [drivers/vfio/pci/vfio-pci-core.ko]
>>>>>>>>> undefined!
>>>>>>>>> ERROR: modpost: "vfio_pci_is_intel_display" [drivers/vfio/pci/vfio-pci-
>>>>>>>>> core.ko] undefined!
>>>>>>>>> ERROR: modpost: "vfio_pci_liveupdate_init" [drivers/vfio/pci/vfio-
>>>>>>>>> pci.ko] undefined!
>>>>>>>>> ERROR: modpost: "vfio_pci_liveupdate_cleanup" [drivers/vfio/pci/vfio-
>>>>>>>>> pci.ko] undefined!
>>>>>>>>> make[4]: *** [scripts/Makefile.modpost:147: Module.symvers] Error 1
>>>>>>>>> make[3]: *** [Makefile:1960: modpost] Error 2
>>>>>>>>>
>>>>>>>>> After I git clone the source code from the link https://github.com/
>>>>>>>>> dmatlack/linux/tree/liveupdate/vfio/cdev/v1,
>>>>>>>>>
>>>>>>>>> I found the above errors when I built the source code.
>>>>>>>>>
>>>>>>>>> Perhaps the above errors can be solved by EXPORT_SYMBOL.
>>>>>>>>>
>>>>>>>>> But I am not sure if a better solution can solve the above problems or not.
>>>>>>>> I reviewed this patch series in detail. If I’m understanding it
>>>>>>>> correctly, there appears to be a cyclic dependency issue. Specifically,
>>>>>>>> some functions in kernel module A depend on kernel module B, while at
>>>>>>>> the same time certain functions in module B depend on module A.
>>>>>>>>
>>>>>>>> I’m not entirely sure whether this constitutes a real problem or if it’s
>>>>>>>> intentional design.
>>>>>>> Thanks for your report. Can you share the .config file you used to
>>>>>>> generate these errors?
>>>>>> IIRC, I used FC 42 default config. Perhaps you can make tests with it. If
>>>>>> this problem can not be reproduced, I will share my config with you.
>>>>>>
>>>>> What does "FC 42 default config" mean?
>>>>>
>>>>> Either way I was able to reproduce the errors you posted above by
>>>>> changing CONFIG_VFIO_PCI{_CORE} from "y" to "m".
>>>>>
>>>>> To unblock building and testing this series you can change these configs
>>>>> from "m" to "y", or the following patch (which fixed things for me):
>>>> Oops, sorry, something went wrong when I posted that diff. Here's the
>>>> correct diff:
>>>>
>>>> diff --git a/drivers/vfio/pci/Makefile b/drivers/vfio/pci/Makefile
>>>> index 929df22c079b..c2cca16e99a8 100644
>>>> --- a/drivers/vfio/pci/Makefile
>>>> +++ b/drivers/vfio/pci/Makefile
>>>> @@ -2,11 +2,11 @@
>>>>
>>>>    vfio-pci-core-y := vfio_pci_core.o vfio_pci_intrs.o vfio_pci_rdwr.o vfio_pci_config.o
>>>>    vfio-pci-core-$(CONFIG_VFIO_PCI_ZDEV_KVM) += vfio_pci_zdev.o
>>>> -vfio-pci-core-$(CONFIG_LIVEUPDATE) += vfio_pci_liveupdate.o
>>>>    obj-$(CONFIG_VFIO_PCI_CORE) += vfio-pci-core.o
>>>>
>>>>    vfio-pci-y := vfio_pci.o
>>>>    vfio-pci-$(CONFIG_VFIO_PCI_IGD) += vfio_pci_igd.o
>>>> +vfio-pci-$(CONFIG_LIVEUPDATE) += vfio_pci_liveupdate.o
>>>>    obj-$(CONFIG_VFIO_PCI) += vfio-pci.o
>>>>
>>>>    obj-$(CONFIG_MLX5_VFIO_PCI)           += mlx5/
>>>> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
>>>> index c5b5eb509474..b9805861763a 100644
>>>> --- a/drivers/vfio/vfio_main.c
>>>> +++ b/drivers/vfio/vfio_main.c
>>>> @@ -1386,6 +1386,7 @@ const struct file_operations vfio_device_fops = {
>>>>           .show_fdinfo    = vfio_device_show_fdinfo,
>>>>    #endif
>>>>    };
>>>> +EXPORT_SYMBOL_GPL(vfio_device_fops);
>>>>
>>>>    /**
>>>>     * vfio_file_is_valid - True if the file is valid vfio file
>>>> diff --git a/kernel/liveupdate/luo_core.c b/kernel/liveupdate/luo_core.c
>>>> index 69298d82f404..c7a0c9c3b6a8 100644
>>>> --- a/kernel/liveupdate/luo_core.c
>>>> +++ b/kernel/liveupdate/luo_core.c
>>>> @@ -256,6 +256,7 @@ bool liveupdate_enabled(void)
>>>>    {
>>>>           return luo_global.enabled;
>>>>    }
>>>> +EXPORT_SYMBOL_GPL(liveupdate_enabled);
>>>>
>>>>    /**
>>>>     * DOC: LUO ioctl Interface
>>>> diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
>>>> index fca3806dae28..9baa88966f04 100644
>>>> --- a/kernel/liveupdate/luo_file.c
>>>> +++ b/kernel/liveupdate/luo_file.c
>>>> @@ -868,6 +868,7 @@ int liveupdate_register_file_handler(struct liveupdate_file_handler *fh)
>>>>           luo_session_resume();
>>>>           return err;
>>>>    }
>>>> +EXPORT_SYMBOL_GPL(liveupdate_register_file_handler);
>>>>
>>>>    /**
>>>>     * liveupdate_unregister_file_handler - Unregister a liveupdate file handler
>>>> @@ -913,3 +914,4 @@ int liveupdate_unregister_file_handler(struct liveupdate_file_handler *fh)
>>>>           liveupdate_test_register(fh);
>>>>           return err;
>>>>    }
>>>> +EXPORT_SYMBOL_GPL(liveupdate_unregister_file_handler);
>>
>> Sure. Exactly. The above is the same with my solution. But after that
>> EXPORT_SYMBOL_GPL, a cyclic dependency issue will occur.
> Did see the change to drivers/vfio/pci/Makefile? That fixes the

Ah, I overlooked this change. I'll conduct a test.

Thanks,

Yanjun.Zhu

> circular dependency between vfio-pci and vfio-pci-core that I created
> in this series.

