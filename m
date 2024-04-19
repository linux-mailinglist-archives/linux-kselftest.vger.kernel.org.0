Return-Path: <linux-kselftest+bounces-8461-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C75A8AB34F
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 18:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D19E1F22B1C
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 16:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07F8131180;
	Fri, 19 Apr 2024 16:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Lo39iPXb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29ADB2AE90
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Apr 2024 16:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713544015; cv=none; b=V29XIvRgPJLrsCpxarIEykMS4BbyCHHCyws4SJtA7h9bbnCMcfcR7h8XsdnitPgVnGwqPR+UBsK+8am2g2A86lWmTRVFM56A3XMbkPCyU6VghvGJzP/0XH2ewHipBKcvDbTWXNTIiFDFz82yx74pHaiY/aKkUg+NgMK/i9+/Yck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713544015; c=relaxed/simple;
	bh=D+wsIPoBQVcBpGYpWlOPWEl5tnQocJdK14Ye5RZEtlk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=nFiK1/iHmAcYipo0/Dmv9qvavwWPvf0FSQKFoky7TblJjbPOwmgCmoYOTuqAD3kZc+8s9G5IoRwdzpPUjHaWtcV0+yMI70Eh5x3H9MhUrVrRxv8d5fqxQv+oXNdqEIKaUsMzY20q5+E87RRvhD8VL3ufaLhCO/8cPEPNUdDUEng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Lo39iPXb; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713544012;
	bh=D+wsIPoBQVcBpGYpWlOPWEl5tnQocJdK14Ye5RZEtlk=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=Lo39iPXb2/C3XqF8+SzGAJ/HcRYQshoAPD8Ce+DesJH6tVyEJjizKN8nIwlB33I02
	 JgNyg3qSRgc7mk5C9Rc4QTrLLfr9jJwu0uJGfAdOfQDs3MDei7jXG3v/LdZEpbF1UI
	 vrlK/meGBJ23Zy7l9g9wbv8brjNPGDnPhSTLOTu+jqC73AZPl+to219oKXvp4yBLLy
	 wC/2cP/RhteJvZmuT1usQexx06Bq8CP8IsPaf1X2+ThJ/51GOWSqQC8mb+/ErZMImz
	 jWAR95H8vB7eLtX9EWPScAhcBVktF0FrGYS9msdJXJ2rWN5/4rtuqMZC8/08U7MyhG
	 4JlX4EOovJ2LA==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 48F18378214A;
	Fri, 19 Apr 2024 16:26:49 +0000 (UTC)
Message-ID: <88265824-ae69-4250-af0d-d30eed114569@collabora.com>
Date: Fri, 19 Apr 2024 21:27:14 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, jeffxu@google.com,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 kernel test robot <yujie.liu@intel.com>
Subject: Re: [PATCH 1/1] selftest mm/mseal: fix compile warning
To: jeffxu@chromium.org, akpm@linux-foundation.org
References: <20240419034350.127838-1-jeffxu@chromium.org>
 <20240419034350.127838-2-jeffxu@chromium.org>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240419034350.127838-2-jeffxu@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/19/24 8:43 AM, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@chromium.org>
> 
> fix compile warning reported by test robot
> 
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> Reported-by: kernel test robot <yujie.liu@intel.com>
> Closes: https://lore.kernel.org/r/202404190226.OfJOewV8-lkp@intel.com/
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  tools/testing/selftests/mm/mseal_test.c | 3 +--
>  tools/testing/selftests/mm/seal_elf.c   | 3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/selftests/mm/mseal_test.c
> index 4a326334726d..35cdae93e580 100644
> --- a/tools/testing/selftests/mm/mseal_test.c
> +++ b/tools/testing/selftests/mm/mseal_test.c
> @@ -79,7 +79,7 @@ static unsigned long get_vma_size(void *addr, int *prot)
>  		return 0;
>  
>  	while (fgets(line, sizeof(line), maps)) {
> -		if (sscanf(line, "%lx-%lx %4s", &addr_start, &addr_end, &protstr) == 3) {
> +		if (sscanf(line, "%lx-%lx %4s", &addr_start, &addr_end, (char *) &protstr) == 3) {
>  			if (addr_start == (uintptr_t) addr) {
>  				size = addr_end - addr_start;
>  				if (protstr[0] == 'r')
> @@ -208,7 +208,6 @@ static u64 set_pkey_bits(u64 reg, int pkey, u64 flags)
>  
>  static void set_pkey(int pkey, unsigned long pkey_value)
>  {
> -	unsigned long mask = (PKEY_DISABLE_ACCESS | PKEY_DISABLE_WRITE);
>  	u64 new_pkey_reg;
>  
>  	new_pkey_reg = set_pkey_bits(__read_pkey_reg(), pkey, pkey_value);
> diff --git a/tools/testing/selftests/mm/seal_elf.c b/tools/testing/selftests/mm/seal_elf.c
> index 7143dc4f1b10..b7e72f9804f8 100644
> --- a/tools/testing/selftests/mm/seal_elf.c
> +++ b/tools/testing/selftests/mm/seal_elf.c
> @@ -105,7 +105,6 @@ static void test_seal_elf(void)
>  	int ret;
>  	FILE *maps;
>  	char line[512];
> -	int size = 0;
>  	uintptr_t  addr_start, addr_end;
>  	char prot[5];
>  	char filename[256];
> @@ -136,7 +135,7 @@ static void test_seal_elf(void)
>  	 */
>  	while (fgets(line, sizeof(line), maps)) {
>  		if (sscanf(line, "%lx-%lx %4s %*x %*x:%*x %*u %255[^\n]",
> -			&addr_start, &addr_end, &prot, &filename) == 4) {
> +			&addr_start, &addr_end, (char *)&prot, (char *)&filename) == 4) {
>  			if (strlen(filename)) {
>  				/*
>  				 * seal the mapping if read only.

-- 
BR,
Muhammad Usama Anjum

