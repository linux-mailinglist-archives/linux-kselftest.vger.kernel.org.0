Return-Path: <linux-kselftest+bounces-34868-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E916DAD82F3
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 08:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D39BD3B3FEA
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 06:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00BE42561C2;
	Fri, 13 Jun 2025 06:09:06 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBAB2550A4
	for <linux-kselftest@vger.kernel.org>; Fri, 13 Jun 2025 06:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749794945; cv=none; b=cSHbf9ZJO6nARbf3gFRHLXx8U+xBteKC+V9ssJG+P9mdkNAbfAun/K3q7Vz+5PsBhf7VLqFC0PwpjfGi7/YhI52vxtlL0ASgBl4tXWFymxe8tfDJE92OhauAPidNdiSpDBO8TLJQLpdGAHw/QnyNhnnc8VLo+riS5CdsPBR+2WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749794945; c=relaxed/simple;
	bh=Q1Cp2x71ESLXf0+qZNt9fNYz3j+h5itL4G3w36SWAiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YJLkQNlx4xf07hJRa9UKbH2yocOzjpW+37TWQ95Wdrj930kROSYFwiuWW4ctL9o3ZWq0mCmGYbLlFy56NJdrzzsgqHFLR8+xPdZ7M2REcOrp3xS+dRsym8prAcsCoL95ixWG9n6uel9+9uPQYpvmNiI6VPt68UA6oWAWem3zZmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 04DE41D14;
	Thu, 12 Jun 2025 23:08:43 -0700 (PDT)
Received: from [10.164.146.16] (J09HK2D2RT.blr.arm.com [10.164.146.16])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8AADD3F59E;
	Thu, 12 Jun 2025 23:08:58 -0700 (PDT)
Message-ID: <5305275a-d3d2-43ce-96f3-646d2765b753@arm.com>
Date: Fri, 13 Jun 2025 11:38:55 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/mm: Add configs to fix testcase failure
To: Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org,
 Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, shuah@kernel.org,
 pfalcato@suse.de
Cc: vbabka@suse.cz, jannh@google.com, pulehui@huawei.com, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, aishwarya.tcv@arm.com, broonie@kernel.org,
 ryan.roberts@arm.com, donettom@linux.ibm.com
References: <20250613034912.53791-1-dev.jain@arm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20250613034912.53791-1-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 13/06/25 9:19 AM, Dev Jain wrote:
> If CONFIG_UPROBES is not set, a merge subtest fails:
> 
> Failure log:
> 
>   7151 12:46:54.627936  # # #  RUN           merge.handle_uprobe_upon_merged_vma ...
>   7152 12:46:54.639014  # # f /sys/bus/event_source/devices/uprobe/type
>   7153 12:46:54.639306  # # fopen: No such file or directory
>   7154 12:46:54.650451  # # # merge.c:473:handle_uprobe_upon_merged_vma:Expected read_sysfs("/sys/bus/event_source/devices/uprobe/type", &type) (1) == 0 (0)
>   7155 12:46:54.650730  # # # handle_uprobe_upon_merged_vma: Test terminated by assertion
>   7156 12:46:54.661750  # # #          FAIL  merge.handle_uprobe_upon_merged_vma
>   7157 12:46:54.662030  # # not ok 8 merge.handle_uprobe_upon_merged_vma
> 
> CONFIG_UPROBES is enabled by CONFIG_UPROBE_EVENTS, which gets enabled by
> CONFIG_FTRACE. Therefore add these configs to selftests/mm/config so that
> CI systems can include this config in the kernel build. To be completely
> safe, add CONFIG_PROFILING too, to enable the dependency chain
> PROFILING -> PERF_EVENTS -> UPROBE_EVENTS -> UPROBES.
> 
> Fixes: efe99fabeb11b ("selftests/mm: add test about uprobe pte be orphan during vma merge")
> Reported-by: Aishwarya <aishwarya.tcv@arm.com>
> Closes: https://lore.kernel.org/all/20250610103729.72440-1-aishwarya.tcv@arm.com/
> Tested-by: Aishwarya TCV <aishwarya.tcv@arm.com>
> Tested-by : Donet Tom <donettom@linux.ibm.com> 
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---
> v1->v2:
>  - Add CONFIG_UPROBES (Mark Brown)
>  - Add CONFIG_PROFILING (Lorenzo)
> 
>  tools/testing/selftests/mm/config | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/testing/selftests/mm/config b/tools/testing/selftests/mm/config
> index a28baa536332..deba93379c80 100644
> --- a/tools/testing/selftests/mm/config
> +++ b/tools/testing/selftests/mm/config
> @@ -8,3 +8,6 @@ CONFIG_GUP_TEST=y
>  CONFIG_TRANSPARENT_HUGEPAGE=y
>  CONFIG_MEM_SOFT_DIRTY=y
>  CONFIG_ANON_VMA_NAME=y
> +CONFIG_FTRACE=y
> +CONFIG_PROFILING=y
> +CONFIG_UPROBES=y

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

