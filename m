Return-Path: <linux-kselftest+bounces-8588-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0DA8AC396
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 07:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A25ACB207E5
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 05:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E651F168DA;
	Mon, 22 Apr 2024 05:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="B2Dl+7E7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B773205E0A
	for <linux-kselftest@vger.kernel.org>; Mon, 22 Apr 2024 05:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713763179; cv=none; b=e+iKsBS3Yah6tMZSb9l+WIrJ/dFbKDTlk4B6vnA2wO0LmUuzRDtiPeWedJVQWx0w98EITqmpHeuJhMcahtGo0ebSNZb+K6lEOe7gGMuqF4ZCXQlrODhccSB+JMG539ACQt7/mXXlgYF9ythsbVKotfOl7/2LEsKk4svhhxpCwws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713763179; c=relaxed/simple;
	bh=Eef3lNUy2bv1+HPvV2IF1OeuXJ7q+egAPAx2TDGRqjk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PQNII5cZOfsb3f4KbiF/tiX9sqT7RJDrQzVkmsEhpykP7dYJBK0Ih0B+u1hcZEgQZZUVS5OdaRrS1o8rMPtSKNnXPrvqMtYAP2HO/7vpuf4xPcnChnBebApSYfmEnNJlSEYlXxeEBGVEEn/d/Ej6SjiadR0gGYIUe7IdUMJde28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=B2Dl+7E7; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713763176;
	bh=Eef3lNUy2bv1+HPvV2IF1OeuXJ7q+egAPAx2TDGRqjk=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=B2Dl+7E7GMGAOCfuRu+Bp7EtaXajyu3gJQx9pXv48Y5ZL5W5NFNAD5VudgPLtSeyq
	 gswoxsr8jiYcyzbchWkP/GqKIREpRaGw0IQ/zYgLM4jYeE6SnzT3cw4CstoTHu53nc
	 Ag5FCMTy5EoKtUqmSMPUYXLkNZJD5sdbOiV813Bl6NeTO0WL2KlWB8v85P7VA/8cQf
	 5MAvpjz/8lA81yxTTCJAusF59gEzecdnIzs4sAEflEDK4qttYP7EMqO7Hs2ziahyeY
	 mqA1rRTR9weBqSs82h1wtHZLpRd11qbTrf7bd5gldkKwWdunQnTcJy4VqKoJXarse5
	 5LSfv9xYY22ug==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id ED02D378202D;
	Mon, 22 Apr 2024 05:19:33 +0000 (UTC)
Message-ID: <6c768ba4-0f86-4a85-8d87-14c1749b3237@collabora.com>
Date: Mon, 22 Apr 2024 10:20:04 +0500
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
Subject: Re: [PATCH v2 1/1] selftest mm/mseal: fix compile warning
To: jeffxu@chromium.org, akpm@linux-foundation.org, pedro.falcato@gmail.com
References: <20240420003515.345982-1-jeffxu@chromium.org>
 <20240420003515.345982-2-jeffxu@chromium.org>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240420003515.345982-2-jeffxu@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/20/24 5:35 AM, jeffxu@chromium.org wrote:
> From: Jeff Xu <jeffxu@chromium.org>
> 
> fix compile warning reported by test robot
> 
> Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> Reported-by: kernel test robot <yujie.liu@intel.com>
> Closes: https://lore.kernel.org/r/202404190226.OfJOewV8-lkp@intel.com/
> Suggested-by: Pedro Falcato <pedro.falcato@gmail.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  tools/testing/selftests/mm/mseal_test.c | 3 +--
>  tools/testing/selftests/mm/seal_elf.c   | 3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/selftests/mm/mseal_test.c
> index 4a326334726d..ca8dbee0c612 100644
> --- a/tools/testing/selftests/mm/mseal_test.c
> +++ b/tools/testing/selftests/mm/mseal_test.c
> @@ -79,7 +79,7 @@ static unsigned long get_vma_size(void *addr, int *prot)
>  		return 0;
>  
>  	while (fgets(line, sizeof(line), maps)) {
> -		if (sscanf(line, "%lx-%lx %4s", &addr_start, &addr_end, &protstr) == 3) {
> +		if (sscanf(line, "%lx-%lx %4s", &addr_start, &addr_end, protstr) == 3) {
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
> index 7143dc4f1b10..48a9b12f99de 100644
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
> +			&addr_start, &addr_end, prot, filename) == 4) {
>  			if (strlen(filename)) {
>  				/*
>  				 * seal the mapping if read only.

-- 
BR,
Muhammad Usama Anjum

