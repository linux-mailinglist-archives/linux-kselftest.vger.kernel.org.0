Return-Path: <linux-kselftest+bounces-10674-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 530EF8CE8A2
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2024 18:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB03828254D
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2024 16:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953D912EBC0;
	Fri, 24 May 2024 16:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="fps5ioFx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F37D126F06;
	Fri, 24 May 2024 16:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716568083; cv=none; b=g2skEpvmYiueYHXjHc9bYGXQe7gQTHowdgj6FVyU/iRgxSWtwUCSDxvVs38flFiJAi8W10SrlbL1lT0qZX0Lm/XuYWm8p4MQFULGauH0OxE3vYhf21wB51EWotuD2xC7ctpHwlGzGiqycIVzhEqjlVb/t3gm5AhWU7VGKe5zsys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716568083; c=relaxed/simple;
	bh=hgKjtqpnBrD07Of/GgbgYcb5JsPipLXArOroUIYRbIA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Q/gf720QFZ269V2/F+DAONeIgqEj600+qsk/+SY+tLpPg8BuXgDjy5zAZ3f8WAKAGpLeiHj3Cjl01x8f7zb6u458Yo4p7j2l+7hHssX0yIwiwBgeT7iqp14Nu+1c0NdwCHF/ogqH5ikGYL5gorKvf9F1VLPOh+gFroENhzxrFn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=fps5ioFx; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=onK/JX9pXTg9x5dECc3ShsOZLHS6PoRdL7pdGhH0BCs=; b=fps5ioFxHwSMfhRK5cLYtVe9it
	qo/oP7tChe/oKUBLEWa6qLYNs+AO91fckAjTWYwsK8Y7bwIqdRrQQCV27sCI9CGVMJEZp5TUqABWJ
	icDK0XxHx4u0LWBY6PASqAy4TSPt6nmQ7KctjvcLLFBNGTgogctUQwCxQgHV0NYPGwXZtEloLjAtH
	diGkdqFhkr1TFaHf9I0IPrXR22ClSR4sVUDTHrhCvrwiyCsdjAAIwIto+OVaixrM8lXoagPOT6ClJ
	OjfFEkjs6ncvr6JY+XEf9OyrWLeuJmuOe0R3R9RRUYOJirKjW6fhKhZZE8CrgttmNEGwGs6z5isLV
	gHZQ3baQ==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sAXlX-000HnP-PT; Fri, 24 May 2024 18:27:35 +0200
Received: from [178.197.248.14] (helo=linux.home)
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1sAXlX-000Ehc-0g;
	Fri, 24 May 2024 18:27:34 +0200
Subject: Re: [PATCH bpf-next] selftests/bpf: Enable INET_XFRM_TUNNEL in config
To: Geliang Tang <geliang@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>
References: <acb442e38544bc5c60dcaa61d56ca1e6bbbc82fe.1715823610.git.tanggeliang@kylinos.cn>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <978a90ad-2e4c-ac06-30bf-6449444d47f9@iogearbox.net>
Date: Fri, 24 May 2024 18:27:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <acb442e38544bc5c60dcaa61d56ca1e6bbbc82fe.1715823610.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27285/Fri May 24 10:30:55 2024)

On 5/16/24 3:41 AM, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> The kconfigs CONFIG_INET_XFRM_TUNNEL and CONFIG_INET6_XFRM_TUNNEL are
> needed by test_tunnel tests. This patch enables them together with the
> dependent kconfigs CONFIG_INET_IPCOMP and CONFIG_INET6_IPCOMP.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>   tools/testing/selftests/bpf/config | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
> index eeabd798bc3a..8aa56e6bdac1 100644
> --- a/tools/testing/selftests/bpf/config
> +++ b/tools/testing/selftests/bpf/config
> @@ -95,3 +95,7 @@ CONFIG_XDP_SOCKETS=y
>   CONFIG_XFRM_INTERFACE=y
>   CONFIG_TCP_CONG_DCTCP=y
>   CONFIG_TCP_CONG_BBR=y
> +CONFIG_INET_IPCOMP=y
> +CONFIG_INET_XFRM_TUNNEL=y
> +CONFIG_INET6_IPCOMP=y
> +CONFIG_INET6_XFRM_TUNNEL=y
> 

[ +Ilya ]

Looks like this triggers a boot hang on s390x :

https://github.com/kernel-patches/bpf/actions/runs/9215175853/job/25353574288

