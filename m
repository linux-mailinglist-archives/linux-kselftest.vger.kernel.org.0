Return-Path: <linux-kselftest+bounces-4052-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 835B2847BCB
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 22:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C8B81F2AC8F
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 21:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AAC4839FE;
	Fri,  2 Feb 2024 21:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JN6Gmx9k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40670839F8
	for <linux-kselftest@vger.kernel.org>; Fri,  2 Feb 2024 21:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706910649; cv=none; b=M8yRucO45QVMXDs+MmoYUzUNG9KHgHGz1ky1r14LKEu532uzTh5H4WLXn/IJzpamcZvzrpLDZE3a0u0muQFmW17HmkAKxDktWpPkYL/6kAUpZ34+kh7ws5HIwQHCQ6Rq99b3HYYdK6wz/Df2XAULNWSGm0SdTZE0CRh3M7aLBgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706910649; c=relaxed/simple;
	bh=VZbnTeSWw8U2MGSVh9v3Lwt3NwuQtFuNk5k6Qqx8jyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EKWQbTtjTe9sub+HJ1r2762sgKff/L6wB8z8FYJHHj6rWN/hxtbOuDMm1vUPYaodMRApXLU79cgDOGyzjUKlh2BsYHP5vIvYTcb9TwSA2Y2V/FXs38TAaYLMFrMhwlai1KwLJ6/tKMfpd+JbCFVJG/Dygtztoo912xdbWU76mHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JN6Gmx9k; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b7a0b41e-569d-4d70-957d-0bb8e3556b32@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706910645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R+DDcT4cQ+ZQNKsrJ8G/v4WyIDU0Jo5aM9bFB2AEJog=;
	b=JN6Gmx9kZZt2cVs44M1gPVCj48aVYfbzkXs9/84xuss/aVnvDDLtRQUGIkFRSqo2feg4qf
	AyQeuZt0SJBw2BlWNmtEb/i3ViP/TnccSFSfOu883L2KsfX3t47Bej0HZk4IgKsS3o6U2U
	rRv5Lg99QsIb2LqVC+VH7tyYc+QjZXs=
Date: Fri, 2 Feb 2024 13:50:35 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] selftests/bpf: Use ARRAY_SIZE for array length
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net,
 song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 shuah@kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>,
 andrii@kernel.org
References: <20240202090652.11294-1-jiapeng.chong@linux.alibaba.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20240202090652.11294-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/2/24 1:06 AM, Jiapeng Chong wrote:
> Use of macro ARRAY_SIZE to calculate array size minimizes
> the redundant code and improves code reusability.
> 
> ./tools/testing/selftests/bpf/progs/syscall.c:122:26-27: WARNING: Use ARRAY_SIZE.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8170
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>   tools/testing/selftests/bpf/progs/syscall.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/progs/syscall.c b/tools/testing/selftests/bpf/progs/syscall.c
> index 3d3cafdebe72..297a34f224c3 100644
> --- a/tools/testing/selftests/bpf/progs/syscall.c
> +++ b/tools/testing/selftests/bpf/progs/syscall.c
> @@ -119,7 +119,7 @@ int load_prog(struct args *ctx)
>   	static __u64 value = 34;
>   	static union bpf_attr prog_load_attr = {
>   		.prog_type = BPF_PROG_TYPE_XDP,
> -		.insn_cnt = sizeof(insns) / sizeof(insns[0]),
> +		.insn_cnt = ARRAY_SIZE(insns)

This does not even compile: 
https://github.com/kernel-patches/bpf/actions/runs/7761734279/job/21170796228

The existing code here is fine.

>   	};
>   	int ret;
>   


