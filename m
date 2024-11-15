Return-Path: <linux-kselftest+bounces-22087-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD39B9CDB07
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 10:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6258E1F22260
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Nov 2024 09:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A77618A922;
	Fri, 15 Nov 2024 09:03:41 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BE71898EA;
	Fri, 15 Nov 2024 09:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731661421; cv=none; b=HhJ4GjYUk0tGH9CrKWiHnnRLWI6ksTqiWmKJJoWC/Uiq73QckPOqhUvM6ErIO+NfN1bzXkrYU5+BeMxLze611Ig/Cdg5adVdeBa2eS7LemqqoGxuF+nCGNxiR4TMK5Y2FmiZTs0jhbB5SjE5e79LKU9jd30xdZ2jHd3pM3YH9tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731661421; c=relaxed/simple;
	bh=DJwdqLhq4SXFj3DyzqrpE1g6K7+phi0Pt0XV4fkEaDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=m/F8C7ThguGBgEiwyjvDRJQuIkm14l2xJQ2c7aMIBMVq4/CQSGi7ZMjh1lGhUcyu4StKP8rvigNhSieQgFkKkd3HBpfqLeOZoyILu8xOLV70Ey0hU8XdmZJ/Dji9kxG6RYTqXsaVYhjHmwU2pe+hvU6IOdW8yRmsl39AvQXVWeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4XqWHZ2Jj2zQtpf;
	Fri, 15 Nov 2024 17:02:18 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 2C710141045;
	Fri, 15 Nov 2024 17:03:35 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 15 Nov 2024 17:03:34 +0800
Message-ID: <a031f13e-a5ee-4db9-89a3-983b962c3c1b@huawei.com>
Date: Fri, 15 Nov 2024 17:03:34 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v23 1/7] mm: page_frag: add a test module for
 page_frag
To: Mark Brown <broonie@kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, Alexander Duyck <alexander.duyck@gmail.com>,
	Linux-MM <linux-mm@kvack.org>, Alexander Duyck <alexanderduyck@fb.com>, Shuah
 Khan <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>,
	<Aishwarya.TCV@arm.com>
References: <20241028115343.3405838-1-linyunsheng@huawei.com>
 <20241028115343.3405838-2-linyunsheng@huawei.com>
 <ZzYfBp0IO1WW6Cao@finisterre.sirena.org.uk>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <ZzYfBp0IO1WW6Cao@finisterre.sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/11/15 0:02, Mark Brown wrote:
> On Mon, Oct 28, 2024 at 07:53:36PM +0800, Yunsheng Lin wrote:
>> The testing is done by ensuring that the fragment allocated
>> from a frag_frag_cache instance is pushed into a ptr_ring
>> instance in a kthread binded to a specified cpu, and a kthread
>> binded to a specified cpu will pop the fragment from the
>> ptr_ring and free the fragment.

Hi,
Thanks for reporting.

> 
> This is breaking the build in -next on at least arm64 and x86_64 since
> it's trying to build an out of tree kernel module which is included in
> the selftests directory, the kselftest build system just isn't set up to
> do that in a sensible and robust fashion.  The module should probably be
I tried the below kernel modules in the testing directory, they seemed to
have the similar problem if the kernel is not compiled yet.

make -C tools/testing/nvdimm
make -C tools/testing/selftests/bpf/bpf_testmod/
make -C tools/testing/selftests/livepatch/test_modules/

> in the main kernel tree and enabled by the config file for the mm tests.

As discussed in [1], this module is not really a vaild kernel module by
returning '-EAGAIN', which is the main reason that it is setup in the
selftests instead of the main kernel tree.

1. https://lore.kernel.org/all/CAKgT0UdL77J4reY0JRaQfCJAxww3R=jOkHfDmkuJHSkd1uE55A@mail.gmail.com/

> 
> KernelCI sees:
> 
> ***
> *** Configuration file ".config" not found!
> ***
> *** Please run some configurator (e.g. "make oldconfig" or
> *** "make menuconfig" or "make xconfig").
> ***
> Makefile:810: include/config/auto.conf.cmd: No such file or directory
> 
> (see https://storage.kernelci.org/next/master/next-20241114/x86_64/x86_64_defconfig%2Bkselftest/gcc-12/logs/kselftest.log)
> 
> and I've seen:
> 
>   ERROR: Kernel configuration is invalid.
>          include/generated/autoconf.h or include/config/auto.conf are missing.
>          Run 'make oldconfig && make prepare' on kernel src to fix it.
> 
> make[3]: *** [Makefile:788: include/config/auto.conf] Error 1

As above, I am not sure if there is some elegant way to avoid the above error
in the selftest core, one possible way to avoid the above error is to skip
compiling like below as tools/testing/selftests/mm/test_page_frag.sh already
skip the testing for page_frag if the test module is not compiled:

diff --git a/tools/testing/selftests/mm/page_frag/Makefile b/tools/testing/selftests/mm/page_frag/Makefile
index 58dda74d50a3..ab5f457bd39e 100644
--- a/tools/testing/selftests/mm/page_frag/Makefile
+++ b/tools/testing/selftests/mm/page_frag/Makefile
@@ -7,6 +7,8 @@ else
 Q = @
 endif

+ifneq (,$(wildcard $(KDIR)/Module.symvers))
+
 MODULES = page_frag_test.ko

 obj-m += page_frag_test.o
@@ -16,3 +18,10 @@ all:

 clean:
 	+$(Q)make -C $(KDIR) M=$(PAGE_FRAG_TEST_DIR) clean
+
+else
+
+all:
+	$(warning Please build the kernel before building the test ko)
+
+endif

