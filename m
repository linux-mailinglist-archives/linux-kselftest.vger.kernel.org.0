Return-Path: <linux-kselftest+bounces-18712-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C5898B212
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 04:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 072DF1C21A89
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 02:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3475129CFE;
	Tue,  1 Oct 2024 02:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Zcjvl3go"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B9226AFB
	for <linux-kselftest@vger.kernel.org>; Tue,  1 Oct 2024 02:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727749689; cv=none; b=J5bo9rZW+vObe4diNV6VIAW8SM5MRv+Nr8XbB11uHnu6HHlxK21/hUjtx41M9jwcGu+Yy5QbjZkGG58RvxxBn1MZc4U2DpYJYmgjbVqdNXYJbsDkAU8anGUGSQFrPDJQfP452qkMhYA39ZO7tjenZDqfKQKIS7K+ArXjN6nC6Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727749689; c=relaxed/simple;
	bh=lrcNSECS0F9ADelVocaNfTuKwGqVsqaBMolFFw9OsSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=atFgrFp1PVlvvSostbN0lgC2NoAACEYM4sHbIc6s0dJ6U8I/Iv4k2xdE1s3Sgv8g/nLrzawcSGbcMBAPG1Cnraw4HhCUIP41E2FSflF+Vj1G6KIu5L8gMsq/Lk8EIKYUSV6xLuOaJ7JaC0DfMcyeudCRZStuXdxb14sodIQnoxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Zcjvl3go; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8a81f13f-c877-435c-9887-732b20a7d827@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727749685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wio2GI+V4+YOSMyGwU3BmBPIxxwgZ17suvsOmpc7ijQ=;
	b=Zcjvl3goEFjwyRbrXF8wot01mfEiRMkzU/4okDOpEkdcLFhjfSAk+ONkh+T/vVPaoLl9uT
	58d7lbnj9VsX5gZuq/qpwrxfqxKp5bs2UtAra4D7WyV2cDvaTT8nOQmCjkdmkESlVOewOM
	dkdXzBHfrhnBysP85KAVMvzlHjYpxm4=
Date: Mon, 30 Sep 2024 19:27:46 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Fix bpf_get/setsockopt to tos not
 take effect when TCP over IPv4 via INET6 API
To: Feng zhou <zhoufeng.zf@bytedance.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mykolal@fb.com,
 shuah@kernel.org, alan.maguire@oracle.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, yangzhenze@bytedance.com,
 wangdongdong.6@bytedance.com
References: <20240914103226.71109-1-zhoufeng.zf@bytedance.com>
 <20240914103226.71109-2-zhoufeng.zf@bytedance.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240914103226.71109-2-zhoufeng.zf@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/14/24 3:32 AM, Feng zhou wrote:
> From: Feng Zhou <zhoufeng.zf@bytedance.com>
> 
> when TCP over IPv4 via INET6 API, bpf_get/setsockopt with ipv4 will

I think you meant bpf_get/setsockopt with SOL_IP will fail. so s/ipv4/SOL_IP/?

> fail, because sk->sk_family is AF_INET6. With ipv6 will success, not
> take effect, because inet_csk(sk)->icsk_af_ops is ipv6_mapped and
> use ip_queue_xmit, inet_sk(sk)->tos.

Change lgtm.

Patch 2 has a conflict, so can you please reword this commit message to reflect 
the latest change. e.g. afaik, this is no longer specific to mapped address or not.

> 
> Bpf_get/setsockopt use sk_is_inet() helper to fix this case.
> 
> Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
> ---
>   net/core/filter.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index e4a4454df5f9..90f4dbb8d2b5 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -5399,7 +5399,12 @@ static int sol_ip_sockopt(struct sock *sk, int optname,
>   			  char *optval, int *optlen,
>   			  bool getopt)
>   {
> -	if (sk->sk_family != AF_INET)
> +
> +	/*
> +	 * SOL_IP socket options are available on AF_INET and AF_INET6, for
> +	 * example, TCP over IPv4 via INET6 API.
> +	 */
> +	if (!sk_is_inet(sk))
>   		return -EINVAL;
>   
>   	switch (optname) {


