Return-Path: <linux-kselftest+bounces-6534-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CDB88AA2B
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 17:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21C5DB450FB
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 13:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D367E16F853;
	Mon, 25 Mar 2024 10:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Gcg29h6F"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FDB1782F2;
	Mon, 25 Mar 2024 09:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711357878; cv=none; b=YgRiJhRtGsVdiu6Dy+6g6c2teT5BElTmiPnjv7Teo/+iqceRltAqxnQ8dmur67eRVW9pa4KYXOpCQuKeZqFRHoG+FayHky3YVbjbDvx5TAkCbl9+he8YneUqLAVDP7s4VGVvG7e70pL5+FD58VJfv6XWH5SmRM3LPMfEHozbIis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711357878; c=relaxed/simple;
	bh=9y0G1BTQ2uSEPU8w/gXoViJAhzs3aCSAw8+ySzYVdsE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Wq6/i5BM1bDW07jXznPlomj9clpQyyJx3kuri/QAT53e0fj99KeIO03otb9mIT3KPYqU1pjzlDh1sICDOHVMofTQCjYhDTl1jeAV8Ec/tHksZsae32Su6WBwC+8Fgr/vGMT8vL8iQnJjWzww7xnfNGd7GZSOM6DMFccxtsLdZBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Gcg29h6F; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711357874;
	bh=9y0G1BTQ2uSEPU8w/gXoViJAhzs3aCSAw8+ySzYVdsE=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=Gcg29h6Fl6MMWzOHduYzYk3qGVJVOIlA7Btxb3MA7Ws8wZ5QKxYYC3kjmW+uTfSX9
	 S++sZAm/9uTl6getLAOPLAMWvn1Dz4FdY13NjP28wJz450LZmqLvt9wv0VB3EMEVOf
	 +VmHMLCqZyhKvAd9UROs0xgm7xl3zCmH0g5xLAYeKHleDMYV8/Ljwl38XrEgHyuyCB
	 eP4jhkGldACbYxfdU/O9SlOZZbFNtuifz+U2txkjWTMXGaGQnplD9F/fQrU6gzvP0o
	 NsPcjiNAkucgDSMl1I8EaRdOYZzF91A/zT9YQZYxQ7+CPQhoSrtUsB0nPgS4MXEpIz
	 T6vMUmKiMkmcQ==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 03062378209C;
	Mon, 25 Mar 2024 09:11:10 +0000 (UTC)
Message-ID: <45b4d209-675a-4b42-b62c-6644bafa36c0@collabora.com>
Date: Mon, 25 Mar 2024 14:11:41 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, kernel@collabora.com,
 iommu@lists.linux.dev, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: iommu: add config needed for iommufd_fail_nth
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
 Shuah Khan <shuah@kernel.org>
References: <20240325090048.1423908-1-usama.anjum@collabora.com>
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240325090048.1423908-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/25/24 2:00 PM, Muhammad Usama Anjum wrote:
> Add FAULT_INJECTION_DEBUG_FS and FAILSLAB configurations which are
> needed by iommufd_fail_nth test.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> While building and running these tests on x86, defconfig had these
> configs enabled. But ARM64's defconfig doesn't enable these configs.
> Hence the config options are being added explicitly in this patch.
Please disregard this extra comment. Overall this patch is needed to enable
these config options of x86 and ARM both.

> ---
>  tools/testing/selftests/iommu/config | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/iommu/config b/tools/testing/selftests/iommu/config
> index 110d73917615d..02a2a1b267c1e 100644
> --- a/tools/testing/selftests/iommu/config
> +++ b/tools/testing/selftests/iommu/config
> @@ -1,3 +1,5 @@
>  CONFIG_IOMMUFD=y
> +CONFIG_FAULT_INJECTION_DEBUG_FS=y
>  CONFIG_FAULT_INJECTION=y
>  CONFIG_IOMMUFD_TEST=y
> +CONFIG_FAILSLAB=y

-- 
BR,
Muhammad Usama Anjum

