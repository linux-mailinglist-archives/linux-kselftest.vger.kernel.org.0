Return-Path: <linux-kselftest+bounces-24382-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9EAA0BC7D
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 16:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F98C3A85A9
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 15:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FD420AF64;
	Mon, 13 Jan 2025 15:46:20 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5491C5D60;
	Mon, 13 Jan 2025 15:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736783180; cv=none; b=tXYnoy3hIFYccMB/KveHfIA2T3WiqrzgULBkWxcXe9+dCITc9wTMr/g/UnQWUbPeOZ+UbVzZ37Fctp6LUtFGvwcMWUBAnd8CZBLCUyj2ztwge8SDksmvNYTVEKXOWqI418nJNnieZLu8rfcRAb5t7Lz4UuV++TGamHKwVOqKjdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736783180; c=relaxed/simple;
	bh=XWFyLHUam4Ej2usQjR/mPbGlosnYeMYfEA5NlC4zkZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rASqQfviADYFKbjeT62YWpkiyZUQUCX3j5CxdNcoKx918BHkoMrDPBoKwWk2GiSzDzxw8sFEUJh9ELLyoG/BDkzSZt2BfzpPG6W3l1p64bxPlHBESDqLPwlUtWQkzSonJT0sLxSpM3ZKBichwIsi7UNaWHs8luJvzOiMIu5/DiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9399612FC;
	Mon, 13 Jan 2025 07:46:45 -0800 (PST)
Received: from [10.163.86.16] (unknown [10.163.86.16])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA4813F66E;
	Mon, 13 Jan 2025 07:46:14 -0800 (PST)
Message-ID: <8b402b5d-ca7a-4dc1-867d-013823c8ab00@arm.com>
Date: Mon, 13 Jan 2025 21:16:12 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] selftests/mm: virtual_address_range: mmap()
 without PROT_WRITE
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250113-virtual_address_range-tests-v3-0-f4a8e6b7feed@linutronix.de>
 <20250113-virtual_address_range-tests-v3-1-f4a8e6b7feed@linutronix.de>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250113-virtual_address_range-tests-v3-1-f4a8e6b7feed@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 13/01/25 6:45 pm, Thomas Weißschuh wrote:
> When mapping a larger chunk than physical memory is available with
> PROT_WRITE and overcommit is disabled, the mapping will fail.
> This will prevent the test from running on systems with less then ~1GiB
> of memory and triggering an inscrutinable test failure.
> As the mappings are never written to anyways, the flag can be removed.
> 
> Fixes: 010409649885 ("selftests/mm: confirm VA exhaustion without reliance on correctness of mmap()")
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> Acked-by: David Hildenbrand <david@redhat.com>
> Acked-by: Dev Jain <dev.jain@arm.com>
> ---
>   tools/testing/selftests/mm/virtual_address_range.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/virtual_address_range.c b/tools/testing/selftests/mm/virtual_address_range.c
> index 2a2b69e91950a37999f606847c9c8328d79890c2..ea6ccf49ef4c552f26317c2a40b09bca1a677f8f 100644
> --- a/tools/testing/selftests/mm/virtual_address_range.c
> +++ b/tools/testing/selftests/mm/virtual_address_range.c
> @@ -166,7 +166,7 @@ int main(int argc, char *argv[])
>   	ksft_set_plan(1);
>   
>   	for (i = 0; i < NR_CHUNKS_LOW; i++) {
> -		ptr[i] = mmap(NULL, MAP_CHUNK_SIZE, PROT_READ | PROT_WRITE,
> +		ptr[i] = mmap(NULL, MAP_CHUNK_SIZE, PROT_READ,
>   			      MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>   
>   		if (ptr[i] == MAP_FAILED) {
> @@ -186,7 +186,7 @@ int main(int argc, char *argv[])
>   
>   	for (i = 0; i < NR_CHUNKS_HIGH; i++) {
>   		hint = hint_addr();
> -		hptr[i] = mmap(hint, MAP_CHUNK_SIZE, PROT_READ | PROT_WRITE,
> +		hptr[i] = mmap(hint, MAP_CHUNK_SIZE, PROT_READ,
>   			       MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>   
>   		if (hptr[i] == MAP_FAILED)
> 

Just noticed a thing: I believe the fix commit you are looking for is
4e5ce33ceb32. My commit which you mention is not responsible for 
introducing the problem you are solving.

