Return-Path: <linux-kselftest+bounces-41059-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 308AFB50468
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 19:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E59035E3E25
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 17:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04273570CC;
	Tue,  9 Sep 2025 17:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Wjx32i4A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FBE3568F2
	for <linux-kselftest@vger.kernel.org>; Tue,  9 Sep 2025 17:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757438787; cv=none; b=dUfY75+jsPrywegso04wNpyskuv/EZX3FO/nonQMijpu2XbIR/DbCmYbvYOnE6n4nEyqnS/a9Qv/WXmqYG5RK8/4JBsLjhBYwGL0702iTHUJQbVf9VUSs5mvbIOn2+4NdyuTsJYUvUz3HVbK5dLthQEd4YAQMKSf/g66eZerhW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757438787; c=relaxed/simple;
	bh=fYwwelCpjz0TKSvgunEd+NMziwStEViYCA4Flr+qADY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jZbTvKIMtzzA4ycT+8zm89JcZgfXu9hTiNeSG0XlnRQYjhm/l8WMMx8PIVQ4pdoGG3K3s7EUL2igGgSr4RIbU4PBT05V0g62yp5lietqbxU7N+IVlZExuT0I5xkQEXOARNbnuxYBjf3u0W9mqp/qSBoA8C07UoNukUhT8VaGjvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Wjx32i4A; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0b8c5619-455b-4a9f-bab5-ec10ae0f2184@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757438783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZM23rJaFMUQOdytqcrD9TWG8M7I3bEgVDd8tdlcZtwg=;
	b=Wjx32i4ADe/Drt2X3vlWrZirvIcRj6p5YnD9myOHdeO1k8GLL6pTVHYCWIc/d6vi6gSX0H
	R14Pwa4qc3oIPEeYb0aqrG5plQZa36cjmbQGBwvDG3ibO2ukuCVne51r2eioV1zPquP06V
	cdqWwmaStnx3snRzM/9ioZGDrWwys1o=
Date: Tue, 9 Sep 2025 10:26:09 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH RFC net-next 3/5] selftests: drv-net: Test XDP head
 adjustment with bpf_dynptr
To: Nimrod Oren <noren@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Mohsin Bashir
 <mohsin.bashr@gmail.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 Amery Hung <ameryhung@gmail.com>
References: <20250909085236.2234306-1-noren@nvidia.com>
 <20250909085236.2234306-4-noren@nvidia.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250909085236.2234306-4-noren@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/9/25 1:52 AM, Nimrod Oren wrote:
> +	if (bpf_dynptr_read(tmp_buff, hdr_len, &ptr, 0, 0) < 0)
>   		return -1;
>   
> -	if (bpf_xdp_store_bytes(ctx, 0, tmp_buff, hdr_len) < 0)
> +	if (bpf_dynptr_write(&ptr, offset, tmp_buff, hdr_len, 0) < 0)

Instead of bpf_dynptr_read() and then bpf_dynptr_write(), try to use 
bpf_dynptr_copy(). I think you have also noticed that Amery is also modifying 
xdp_native.bpf.c to test the linear access (i.e. data/data_end) with the 
bpf_xdp_pull_data addition. Not sure if xdp_native.bpf.c wants to keep testing 
both (data/data_end and dynptr). In the bpf selftests, it does want to have test 
coverage for both and have some existing selftests for that.

> +		return -1;
> +
> +	if (bpf_xdp_adjust_head(ctx, offset) < 0)
>   		return -1;
>   
>   	return 0;


