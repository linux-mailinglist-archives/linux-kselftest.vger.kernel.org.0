Return-Path: <linux-kselftest+bounces-12403-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8AF911CE8
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 09:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 917251F219AD
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 07:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78D812BEBE;
	Fri, 21 Jun 2024 07:34:19 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD3314D449;
	Fri, 21 Jun 2024 07:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718955259; cv=none; b=BnygXAA1A+PrMbAP+La9jBL4Yxi00ieKiJ7On9BA1FgTS581zlhMc8OEaJzZ4viXm1+YVgOJMHLT0poLiHnTmZtfPxyvgbRw74q0j7fY5navLIe2+ODsB25fqXTt5gUkaKtVDHw0zzt0rs34kgxqVblktSW5icjdIZlnVZXcsCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718955259; c=relaxed/simple;
	bh=Gwq6u0YCCzYCOfptO7otMj7O3Gq0JFVLsGNCsPeB498=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k74CSAI10O+iGy0DXoc2ISJ3EQmQtCU/1HwZbrvi8skXVAo1IyQdkgfNGHY0FLqiAtk7/2Gcg7/Z6slcIFTtA1mFaE0tWUxCfjsLfAIIl25PA8DPstblWXmUS/no7z4RIOVhRbxaccKNG4HHahS4HaryqlSKtxpouEnMmk+Mw1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6AE4ADA7;
	Fri, 21 Jun 2024 00:34:41 -0700 (PDT)
Received: from [10.57.74.104] (unknown [10.57.74.104])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE5773F64C;
	Fri, 21 Jun 2024 00:34:14 -0700 (PDT)
Message-ID: <4bf2aecc-1c7b-420c-aa82-8613e2422407@arm.com>
Date: Fri, 21 Jun 2024 08:34:13 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: Introduce a test program to assess swap
 entry allocation for thp_swapout
Content-Language: en-GB
To: Chris Li <chrisl@kernel.org>, Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, shuah@kernel.org, linux-mm@kvack.org,
 david@redhat.com, hughd@google.com, kaleshsingh@google.com,
 kasong@tencent.com, linux-kernel@vger.kernel.org, ying.huang@intel.com,
 linux-kselftest@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>
References: <20240620002648.75204-1-21cnbao@gmail.com>
 <CAF8kJuOserGkULxghiMFP=UhC_DdVaYVXZhqu6RY=SHT3mszpQ@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAF8kJuOserGkULxghiMFP=UhC_DdVaYVXZhqu6RY=SHT3mszpQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/06/2024 00:34, Chris Li wrote:

>> + * thp_swap_allocator_test
>> + *
>> + * The purpose of this test program is helping check if THP swpout
>> + * can correctly get swap slots to swap out as a whole instead of
>> + * being split. It randomly releases swap entries through madvise
>> + * DONTNEED and do swapout on two memory areas: a memory area for
>> + * 64KB THP and the other area for small folios. The second memory
>> + * can be enabled by "-s".
>> + * Before running the program, we need to setup a zRAM or similar
>> + * swap device by:
>> + *  echo lzo > /sys/block/zram0/comp_algorithm
>> + *  echo 64M > /sys/block/zram0/disksize
>> + *  echo never > /sys/kernel/mm/transparent_hugepage/hugepages-2048kB/enabled
>> + *  echo always > /sys/kernel/mm/transparent_hugepage/hugepages-64kB/enabled
>> + *  mkswap /dev/zram0
>> + *  swapon /dev/zram0
> 
> This setup needs to go into run_vmtest.sh as well.
> 
> Also tear it down after the test.

Additionally, if keeping this as a selftest, you'll want to add

CONFIG_ZRAM=y

to tools/testing/selftests/mm/config so that automated systems ensure zram is
available in the kernel under test.

And you will need to ensure that the zram device has a higher priority than any
other already configured swap devices. Otherwise there will not even be an
attempt to use it for mTHP. The easy way is to do "swapoff -a" as the first step
but that makes cleanup tricky.


