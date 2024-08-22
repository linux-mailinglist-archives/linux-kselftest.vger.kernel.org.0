Return-Path: <linux-kselftest+bounces-16057-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B32CD95B503
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 14:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48B82B21D3E
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 12:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB0A1C9440;
	Thu, 22 Aug 2024 12:29:32 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BD426AF6;
	Thu, 22 Aug 2024 12:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724329772; cv=none; b=Xzv/bUYPmJJFJeGXwSi9p2pboNLskPoeyQmQe9lWfna4zPrkgcVqyMDnTixJUgBifuj20MoYyh+QCNlt/t03d1rRfMQcDJmZKjHgSIhbBARPCSJms608ABRcGXQQ/n/XzM2GlGcSHCwJK3JNRyC72FmWiyubMDOI0m1XmBRrll0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724329772; c=relaxed/simple;
	bh=EoJ3lk278bxGlQ/KtXGaKBdiWkXqtz/1m21xn9zaLAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lROA5lprudx8G1m1G9cbWj8UU7cRMHgjYAK2/q+96OuOhs4+LhBQ40PNcjeZeGJtCavIGpRrwPs8GrfaUwsnafwS4AvRgfOJ6oRzBDpNa4yIaQn3aXJLdE//kKPxaIfaSRkf83zIKNQikudAR2d4OEqxRPVLwoTxq+WdMXgOiww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8239DA7;
	Thu, 22 Aug 2024 05:29:55 -0700 (PDT)
Received: from [10.163.87.181] (unknown [10.163.87.181])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BBC113F66E;
	Thu, 22 Aug 2024 05:29:25 -0700 (PDT)
Message-ID: <ddbd0cdd-5e13-4904-b6b7-af09dab29586@arm.com>
Date: Thu, 22 Aug 2024 17:59:21 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests:mm: Fix mmap() error paths to check for
 MAP_FAILED
To: Yang Ruibin <11162571@vivo.com>, Andy Whitcroft <apw@canonical.com>,
 Joe Perches <joe@perches.com>, Dwaipayan Ray <dwaipayanray1@gmail.com>,
 Lukas Bulwahn <lukas.bulwahn@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org
Cc: opensource.kernel@vivo.com
References: <20240822120022.2095848-1-11162571@vivo.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20240822120022.2095848-1-11162571@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/22/24 17:30, Yang Ruibin wrote:
> To correctly detect whether mmap is successful, must use if
> (map_ptr == MAP_FAILED)to avoid incorrectly handling a valid
> mapping.Fix mmap() error paths to check for MAP_FAILED.


Shouldn't you have written "avoid processing the return value
from a failed mmap" instead of "avoid incorrectly handling a
valid mapping", because !addr won't be a valid mapping? Also,
I guess it would be better to use ksft_exit_fail_perror(), but
I won't insist.

>
> Signed-off-by: Yang Ruibin <11162571@vivo.com>
> ---
>   tools/testing/selftests/mm/ksm_tests.c     | 2 +-
>   tools/testing/selftests/mm/madv_populate.c | 2 +-
>   tools/testing/selftests/mm/soft-dirty.c    | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/mm/ksm_tests.c b/tools/testing/selftests/mm/ksm_tests.c
> index b748c4890..dad54840f 100644
> --- a/tools/testing/selftests/mm/ksm_tests.c
> +++ b/tools/testing/selftests/mm/ksm_tests.c
> @@ -201,7 +201,7 @@ static void  *allocate_memory(void *ptr, int prot, int mapping, char data, size_
>   {
>   	void *map_ptr = mmap(ptr, map_size, PROT_WRITE, mapping, -1, 0);
>   
> -	if (!map_ptr) {
> +	if (map_ptr == MAP_FAILED) {
>   		perror("mmap");
>   		return NULL;
>   	}
> diff --git a/tools/testing/selftests/mm/madv_populate.c b/tools/testing/selftests/mm/madv_populate.c
> index ef7d911da..b89cb83ca 100644
> --- a/tools/testing/selftests/mm/madv_populate.c
> +++ b/tools/testing/selftests/mm/madv_populate.c
> @@ -34,7 +34,7 @@ static void sense_support(void)
>   
>   	addr = mmap(0, pagesize, PROT_READ | PROT_WRITE,
>   		    MAP_ANONYMOUS | MAP_PRIVATE, 0, 0);
> -	if (!addr)
> +	if (addr == MAP_FAILED)
>   		ksft_exit_fail_msg("mmap failed\n");
>   
>   	ret = madvise(addr, pagesize, MADV_POPULATE_READ);
> diff --git a/tools/testing/selftests/mm/soft-dirty.c b/tools/testing/selftests/mm/soft-dirty.c
> index bdfa5d085..4ccbc053b 100644
> --- a/tools/testing/selftests/mm/soft-dirty.c
> +++ b/tools/testing/selftests/mm/soft-dirty.c
> @@ -134,7 +134,7 @@ static void test_mprotect(int pagemap_fd, int pagesize, bool anon)
>   	if (anon) {
>   		map = mmap(NULL, pagesize, PROT_READ|PROT_WRITE,
>   			   MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
> -		if (!map)
> +		if (map == MAP_FAILED)
>   			ksft_exit_fail_msg("anon mmap failed\n");
>   	} else {
>   		test_fd = open(fname, O_RDWR | O_CREAT, 0664);

