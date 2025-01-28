Return-Path: <linux-kselftest+bounces-25346-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88283A214BA
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 00:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F9253A4586
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 23:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0671DFD86;
	Tue, 28 Jan 2025 23:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="A9qMvB01"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEF61991AE
	for <linux-kselftest@vger.kernel.org>; Tue, 28 Jan 2025 23:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738105239; cv=none; b=EWb9bbccfhy7gz0MDsmn38U4Q0GIgtHEhJxdzI6qKO+szv4EqZUjXXSuH2GwmeSVXXw5EvQyxkChgp4IPnhcPyBkoNT+ck9mOr1sObeyK8Ubuj0GM/562SBzIMLBdAbStRsvMmKqVJzkfW6D4ZH2F/4Jd4+8WSCajaEIbUtaDhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738105239; c=relaxed/simple;
	bh=chm2ypBwThzpaL84x7U9Nnr9yzQ9rB4wBZ7jwetLeJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l4QBpr1DYFiStf6m9PueD34YFhlHbBoabxodsAll5Y27312rgXBO9TYOsH9H8gR1pSBFot/7KgBh1dngkvVM7cZepIsCeae/GhkI/nC2Xx0MXC7HryFmOApmI5Q1x2YHcoNfcqbpXJ61211p9//BnH135uVKua1LKfL5U0f2X8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=A9qMvB01; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3a499ffe-0514-49bf-8022-06a9b713b920@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738105235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TxQEaHtAioWTOPE03cWnnU3Ly/20naE0Cm9ju2UfWJQ=;
	b=A9qMvB01qCeiCa/T4G25MGdbBz2f54lHVjQarpqlOtEXnURllkJWwJ59l40LYSRsJ4roE7
	Ta/eFhjXYhdjq36qPqvgqvUFG6JMV2TE6xGhr2wGdvY/q92gmdsIbQI0G6CoybzzkJTYwn
	tmKC4hWbPJxeueIdOENw0FbE0ZrxFEI=
Date: Tue, 28 Jan 2025 15:00:26 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 09/14] selftests/bpf: test_xdp_veth: Use
 unique names
To: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
 Alexis Lothore <alexis.lothore@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250128-redirect-multi-v3-0-c1ce69997c01@bootlin.com>
 <20250128-redirect-multi-v3-9-c1ce69997c01@bootlin.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250128-redirect-multi-v3-9-c1ce69997c01@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/28/25 1:57 AM, Bastien Curutchet (eBPF Foundation) wrote:
> +#define NO_IP				"NO_IP"
>   #define PROG_NAME_MAX_LEN	128
> +#define NS_NAME_MAX_LEN		32
>   
>   struct veth_configuration {
>   	char local_veth[VETH_NAME_MAX_LEN]; /* Interface in main namespace */
>   	char remote_veth[VETH_NAME_MAX_LEN]; /* Peer interface in dedicated namespace*/
> -	const char *namespace; /* Namespace for the remote veth */
> +	char namespace[NS_NAME_MAX_LEN]; /* Namespace for the remote veth */
>   	int next_veth; /* Local interface to redirect traffic to */
> -	char *remote_addr; /* IP address of the remote veth */
> +	char remote_addr[IP_MAX_LEN]; /* IP address of the remote veth */
>   };
>   

>   	{
> -		.local_veth = "veth2",
> +		.local_veth = "veth2-",
>   		.remote_veth = "veth22",
>   		.next_veth = 2,
> -		.remote_addr = NULL,
> -		.namespace = "ns-veth22"
> +		.remote_addr = NO_IP,
> +		.namespace = "ns-veth22-"
>   	},

> -static int create_network(void)
> +static int create_network(struct veth_configuration *net_config)
>   {
> -	int i;
> +	int i, err;
> +
> +	memcpy(net_config, default_config, VETH_PAIRS_COUNT * sizeof(struct veth_configuration));
>   
>   	/* First create and configure all interfaces */
>   	for (i = 0; i < VETH_PAIRS_COUNT; i++) {
> +		err = append_tid(net_config[i].namespace, strlen(net_config[i].namespace));
> +		if (!ASSERT_OK(err, "append TID to ns name"))
> +			return -1;
> +
> +		err = append_tid(net_config[i].local_veth, strlen(net_config[i].local_veth));
> +		if (!ASSERT_OK(err, "append TID to local veth name"))
> +			return -1;
> +
>   		SYS(fail, "ip netns add %s", net_config[i].namespace);
>   		SYS(fail, "ip link add %s type veth peer name %s netns %s",
>   		    net_config[i].local_veth, net_config[i].remote_veth, net_config[i].namespace);
>   		SYS(fail, "ip link set dev %s up", net_config[i].local_veth);
> -		if (net_config[i].remote_addr)
> +		if (memcmp(net_config[i].remote_addr, NO_IP, 5))

nit. May be "if (net_config[i].remote_addr[0])" instead of defining a new 
"NO_IP" and then memcmp.

>   			SYS(fail, "ip -n %s addr add %s/24 dev %s",	net_config[i].namespace,
>   			    net_config[i].remote_addr, net_config[i].remote_veth);
>   		SYS(fail, "ip -n %s link set dev %s up", net_config[i].namespace,
> @@ -155,7 +169,7 @@ static int create_network(void)
>   	return -1;
>   }


