Return-Path: <linux-kselftest+bounces-10006-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA37C8C2332
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 13:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 229F31C2088A
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2024 11:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3BAE16EC18;
	Fri, 10 May 2024 11:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="c60wX5yT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6758E16F26F;
	Fri, 10 May 2024 11:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715340198; cv=none; b=MYzXV2qlBHjytXZtw9WGm0ONeGN0MfBmBynoeaKpbIJIICX+8Nq7fkJJK4heUJUwvW8GGkLTE+uAREKpBTp9PUBHVs9HD5mpL/F1ySwUp03277AqB80vpIj3Sa7asNkaeDaPPue37ZyWozc7Xpvr1VUfiwzblalpcjj9QHwhV18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715340198; c=relaxed/simple;
	bh=anqqfbe9MJN6ZwLFFJ7e1cXgGip46rgzku8Ub8NGudg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TVlzv/yGEy7CRAzTDkORs++pCQBaUzuHrggJGE1jmzEggzp6CojA8TPzuSAUTZqJyDdzZ1wgpbM/BzJy7rORrdW1YfDTBEPpPFdmcpqTFG+XdYw9yWgx0USDPkAy2ielxJAKxeK26svcvWRA440Bi6Pd6I1LfBCPhf+j7ojrc58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=c60wX5yT; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1715340184;
	bh=anqqfbe9MJN6ZwLFFJ7e1cXgGip46rgzku8Ub8NGudg=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=c60wX5yTRPr3H8fCfHrc0qyQ/4n4HLSAG9/JAuRXeYOl+1LUdCrUtFopC/j9dtJjb
	 1HEQYl+IdXGEQLDAu9eOSiwEwNUUI/tfHzBVbnvsvXN6XeGW0jhdzCHP12F3k+ZUfN
	 5bR/Odls4m4VmNMXILcnuES9O39Mqj0w5igORyyQmrSRMYjwTsl5gFAJZ6QK8TO6q3
	 3vpMQ9VvyAlB1XheQ5Rk2mvQVBLHTn9Bd25NRd0lBlAqt+tm/H95Bjue3DTBGPR70k
	 mso7uR+yAA7egGhWFnkZxYOgUBkwHazFZiiJrM3NXlMOSmYqq+aeiQlef+/0MZIJL0
	 cSflf8UCoppLg==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C429F3782185;
	Fri, 10 May 2024 11:22:59 +0000 (UTC)
Message-ID: <8020398d-497c-48fa-a733-4edc391838ac@collabora.com>
Date: Fri, 10 May 2024 16:23:22 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Kunwu Chan <chentao@kylinos.cn>
Subject: Re: [PATCH bpf-next v2 3/4] selftests/bpf: Add a null pointer check
 for the load_btf_spec
To: kunwu.chan@linux.dev, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
 shuah@kernel.org, kunwu.chan@hotmail.com
References: <20240510095803.472840-1-kunwu.chan@linux.dev>
 <20240510095803.472840-4-kunwu.chan@linux.dev>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240510095803.472840-4-kunwu.chan@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/10/24 2:58 PM, kunwu.chan@linux.dev wrote:
> From: Kunwu Chan <chentao@kylinos.cn>
> 
> There is a 'malloc' call, which can be unsuccessful.
> Add the malloc failure checking to avoid possible null
> dereference.
> 
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
LGTM
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  tools/testing/selftests/bpf/test_verifier.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
> index df04bda1c927..9c80b2943418 100644
> --- a/tools/testing/selftests/bpf/test_verifier.c
> +++ b/tools/testing/selftests/bpf/test_verifier.c
> @@ -762,6 +762,8 @@ static int load_btf_spec(__u32 *types, int types_len,
>  	);
>  
>  	raw_btf = malloc(sizeof(hdr) + types_len + strings_len);
> +	if (!raw_btf)
> +		return -ENOMEM;
>  
>  	ptr = raw_btf;
>  	memcpy(ptr, &hdr, sizeof(hdr));

-- 
BR,
Muhammad Usama Anjum

