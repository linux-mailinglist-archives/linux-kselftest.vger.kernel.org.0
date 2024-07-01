Return-Path: <linux-kselftest+bounces-12993-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A2B91DA2F
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jul 2024 10:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03EC2B22055
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jul 2024 08:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5655E83CD2;
	Mon,  1 Jul 2024 08:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="D7ro7b9K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1F483CC7;
	Mon,  1 Jul 2024 08:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719823265; cv=none; b=cl9xzrjsl3ZWutnLRxqo6OfM8hqgVzyNRHQIwC7X6HuYBfi+Q727B7YDeNQ2GOTeauKSwPwKu35bx0eS37maCEQrCvImhRGE5MqRJsz+NWN4XwHEiabYKQGdpusONyAKKDCvsjFhSbc+qqbm9TmNEtiuOMQZgOkI8sakZh83D4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719823265; c=relaxed/simple;
	bh=O7/N2xAgN5KMJnrraKivEWkngEmOWMs9C+6n1akqfwQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Sbu2bgFZO1jY1tOhoaYSCJFCCdjPpzBPTPcmq898nW3OvLsSuF/nhOrn6tGCpETGb4XHDcZZc3kl4PyQnDKMvaoFojEEBht+gWw9TaemhkRWvccQOf/nqnCKZYSpQIpogIfCazLCbgyutxJjpEYTqEVOkAZoWSqgysg+sQ2OUsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=D7ro7b9K; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1719823262;
	bh=O7/N2xAgN5KMJnrraKivEWkngEmOWMs9C+6n1akqfwQ=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=D7ro7b9KUPYyxLemYufQPSOrjl6IjUTUuLLYqIzQmYacRvHbGfO7ZjMYX+YG4JiGa
	 lkr9GnI4jE0rz9cEew5hZ9NlZS+e7haV1c43cJQt99IzkL7umtisIRfYh/2B3E0hDB
	 jyihkeScS4cFtGgGAEm0cMseofI/xHb2I51q9TM90g8nYxbQPHADIk6nQK3qolWXm0
	 NMcTVSja27gsHFUhcJ2/9Pt28V8J/2nMpERMVIYyMr4R22cBdz8yDDmBSCHUjbL9mM
	 HB8IwF7vTCq/rzy9YX1B/ouhnPyTUoBYjC6N25oaTxWkbbyEY5WyWTLBoC6MgHT/3T
	 zpC8jCycstfsw==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 45365378210B;
	Mon,  1 Jul 2024 08:40:55 +0000 (UTC)
Message-ID: <599d722c-6d34-42dd-bdfd-5cc862d1c8b4@collabora.com>
Date: Mon, 1 Jul 2024 13:40:51 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, kernel@collabora.com,
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] selftests: arm64: tags_test: conform test to TAP
 output
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Kunwu Chan <chentao@kylinos.cn>,
 Mark Brown <broonie@kernel.org>
References: <20240602132502.4186771-1-usama.anjum@collabora.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240602132502.4186771-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Soft reminder

On 6/2/24 6:24 PM, Muhammad Usama Anjum wrote:
> Conform the layout, informational and status messages to TAP. No
> functional change is intended other than the layout of output messages.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>  tools/testing/selftests/arm64/tags/tags_test.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/arm64/tags/tags_test.c b/tools/testing/selftests/arm64/tags/tags_test.c
> index 955f87c1170d7..8ae26e496c89c 100644
> --- a/tools/testing/selftests/arm64/tags/tags_test.c
> +++ b/tools/testing/selftests/arm64/tags/tags_test.c
> @@ -17,19 +17,21 @@ int main(void)
>  	static int tbi_enabled = 0;
>  	unsigned long tag = 0;
>  	struct utsname *ptr;
> -	int err;
> +
> +	ksft_print_header();
> +	ksft_set_plan(1);
>  
>  	if (prctl(PR_SET_TAGGED_ADDR_CTRL, PR_TAGGED_ADDR_ENABLE, 0, 0, 0) == 0)
>  		tbi_enabled = 1;
>  	ptr = (struct utsname *)malloc(sizeof(*ptr));
>  	if (!ptr)
> -		ksft_exit_fail_msg("Failed to allocate utsname buffer\n");
> +		ksft_exit_fail_perror("Failed to allocate utsname buffer");
>  
>  	if (tbi_enabled)
>  		tag = 0x42;
>  	ptr = (struct utsname *)SET_TAG(ptr, tag);
> -	err = uname(ptr);
> +	ksft_test_result(!uname(ptr), "Syscall successful with tagged address\n");
>  	free(ptr);
>  
> -	return err;
> +	ksft_finished();
>  }

-- 
BR,
Muhammad Usama Anjum

