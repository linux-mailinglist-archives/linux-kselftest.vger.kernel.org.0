Return-Path: <linux-kselftest+bounces-8665-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 468538AE002
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 10:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02244283EC9
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 08:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE0054FAD;
	Tue, 23 Apr 2024 08:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="fzp7ISOZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56354320E;
	Tue, 23 Apr 2024 08:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713861749; cv=none; b=qr89vKFZqXK7kq4FHIywEZ5DKkTSvqOUpmM73VCsUwXXcWUcffZafCKrvjsIqsmjiv3vVVzcIQ4LyI+89/P5yNAnA1M0WA8CFEmI4NhnQ5R2Lro5MHVusFxm6EvYVZLHIaYLGpt6RsHtdVuUd8dwARD5ykml61UASSe6huuBTHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713861749; c=relaxed/simple;
	bh=lCEgH6CjISLGxTFDuXB9DyweUCZb4U8cml+VeZJsxb8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ly9gL5wQAkkCsbJDg02PAk+RHgsjcu1lgcNniLlV+gz+Pwvm8guHZ6sKv4I3OByidPqIRRzTrLt2aC8ZJ+e/f7rc6Niccm9+lzrYQ+Mdj0PC/QVPF1mcgpFYuNg+HRj9BPPIQVP6x4wv3Y0yL7nGUAFoiULn3vMOBIgpCfI1MY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=fzp7ISOZ; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713861746;
	bh=lCEgH6CjISLGxTFDuXB9DyweUCZb4U8cml+VeZJsxb8=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=fzp7ISOZTZr9+iDobVs6ZrXUUgMj/2HKNiqi++bWH1yrgi0BBaw/5HPRADC5gSZPF
	 AF0AD+MWcLZPUht2FcDsov+eDyXcX3TQxl95tqFmMh8BMsKgvSq8rUNsurpHwiptAV
	 sbCQBP+edEMGYOcpk3HlkV/TxHxrE8WIfStYP8p5vUZvW+o0wag0btWoUKcntDl344
	 VOZ3HpLkMs/YJT18LDa9O/hLofOJCxyNuDBAu145pZnFQULT+oEFE3Nx22Cs/NswBe
	 7IxVByNuufNWddqj/X116zbdxG05ItoUFoYfOeufLwNkGfK2SoIAofLnOQNLw5s2v1
	 yctat8YJbky+Q==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 28D363780016;
	Tue, 23 Apr 2024 08:42:22 +0000 (UTC)
Message-ID: <e9c9a9e3-188e-4c6a-b7be-03802e833ef3@collabora.com>
Date: Tue, 23 Apr 2024 13:42:51 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kselftest: arm64: Add a null pointer check
To: Kunwu Chan <chentao@kylinos.cn>, kunwu.chan@hotmail.com,
 catalin.marinas@arm.com, will@kernel.org, shuah@kernel.org
References: <20240423082102.2018886-1-chentao@kylinos.cn>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240423082102.2018886-1-chentao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/23/24 1:21 PM, Kunwu Chan wrote:
> There is a 'malloc' call, which can be unsuccessful.
> This patch will add the malloc failure checking
> to avoid possible null dereference and give more information
> about test fail reasons.
LGTM

Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> 
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> ---
>  tools/testing/selftests/arm64/tags/tags_test.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/testing/selftests/arm64/tags/tags_test.c b/tools/testing/selftests/arm64/tags/tags_test.c
> index 5701163460ef..955f87c1170d 100644
> --- a/tools/testing/selftests/arm64/tags/tags_test.c
> +++ b/tools/testing/selftests/arm64/tags/tags_test.c
> @@ -6,6 +6,7 @@
>  #include <stdint.h>
>  #include <sys/prctl.h>
>  #include <sys/utsname.h>
> +#include "../../kselftest.h"
The test isn't conformed to TAP. Maybe the next patch could be to conform
the whole test into TAP, would be easy and straight forward.

>  
>  #define SHIFT_TAG(tag)		((uint64_t)(tag) << 56)
>  #define SET_TAG(ptr, tag)	(((uint64_t)(ptr) & ~SHIFT_TAG(0xff)) | \
> @@ -21,6 +22,9 @@ int main(void)
>  	if (prctl(PR_SET_TAGGED_ADDR_CTRL, PR_TAGGED_ADDR_ENABLE, 0, 0, 0) == 0)
>  		tbi_enabled = 1;
>  	ptr = (struct utsname *)malloc(sizeof(*ptr));
> +	if (!ptr)
> +		ksft_exit_fail_msg("Failed to allocate utsname buffer\n");
> +
>  	if (tbi_enabled)
>  		tag = 0x42;
>  	ptr = (struct utsname *)SET_TAG(ptr, tag);

-- 
BR,
Muhammad Usama Anjum

