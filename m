Return-Path: <linux-kselftest+bounces-13925-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9460B9379B6
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jul 2024 17:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EE3E281D65
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jul 2024 15:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D1C14532F;
	Fri, 19 Jul 2024 15:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="G622rTg6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A9728F1;
	Fri, 19 Jul 2024 15:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721402081; cv=none; b=D3Mg+uvGXjxB57c7hJv64lwDROLTn9CK9lfqmq/QQHSv/Aik0cl0cxAXGCr5oDoG44tDSxi1yC72vuaBpJMO2UIjRjUaClVoyEWryepO0Jovf/3rQAo/v8Ojgj44iMygU2FmH1ilb0JjlPf8M+idFrEzThL2l5jKfGg0zfe3ZpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721402081; c=relaxed/simple;
	bh=sROtZYeF8jNHhYcpohB3Gu9/qmli5EL06S8SRkdRgEg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=leQVo/yF9ncG5gvKQbduyaj31bhi2+XtPHcd+NNt7EdOC4DE51Dvwnea/tTlwt8MJps+F1cbYIhT3ZGLqw4pLE8gSt67o4mF/7eaEtA2KsBVUGJlNYSQ7YbGgu4VfZ6rSUZibjE9SPEf3uY9EyAkV0/uAk1Irvo2bmh5E4Gzdc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=G622rTg6; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=VNjSitXgP63OfLmTByumQf2vJ6HMojY6G0+/pVBAVvE=; b=G622rTg6/sGe6WVEkyZHxCceB4
	6iEvshpzRyIQnnQl4hIQa2aGNR0217fb9mZIQwKIHi2a3N5URSDIquif641wJ5kdJK+WTDUKbyOiV
	5cxJ+jhZt0Mm1pQjSVG5JWBbtIIBJ0A7FZ9ZrUfUAyCXYLkkZ5MWQVVYkHk5J6CofN//lkXe8BABM
	1ApcQOoW7Z4k9XkUyckXrJTFWBdJb+lIskYGPPs7zMU2clRdPrakaaFR7nSaVZ0DL3/4F/jXAwlKj
	8ckAS0Qph04lcfDj63M7fB7LTPyZwsbjxhEq4dgxvIdwZKrw+ZQyaMmPOmEugvKRKFPlvbdvHqsV8
	3ok2Bssg==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sUpJC-000639-AC; Fri, 19 Jul 2024 17:14:10 +0200
Received: from [178.197.248.43] (helo=linux-2.home)
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1sUpJA-000Jmi-2U;
	Fri, 19 Jul 2024 17:14:08 +0200
Subject: Re: [PATCH v3 2/2] selftests/bpf: integrate test_xdp_veth into
 test_progs
To: =?UTF-8?Q?Alexis_Lothor=c3=a9_=28eBPF_Foundation=29?=
 <alexis.lothore@bootlin.com>, Alexei Starovoitov <ast@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
 Simon Horman <horms@kernel.org>
Cc: ebpf@linuxfoundation.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20240716-convert_test_xdp_veth-v3-0-7b01389e3cb3@bootlin.com>
 <20240716-convert_test_xdp_veth-v3-2-7b01389e3cb3@bootlin.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <3b1949b9-775a-8093-6a14-16dec843a446@iogearbox.net>
Date: Fri, 19 Jul 2024 17:14:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240716-convert_test_xdp_veth-v3-2-7b01389e3cb3@bootlin.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27341/Fri Jul 19 10:28:50 2024)

On 7/16/24 12:13 PM, Alexis Lothoré (eBPF Foundation) wrote:
[...]
> +static int attach_programs_to_veth_pair(struct skeletons *skeletons, int index)
> +{
> +	struct bpf_program *local_prog, *remote_prog;
> +	struct bpf_link **local_link, **remote_link;
> +	struct nstoken *nstoken;
> +	struct bpf_link *link;
> +	int interface;
> +
> +	switch (index) {
> +	case 0:
> +		local_prog = skeletons->xdp_redirect_maps->progs.xdp_redirect_map_0;
> +		local_link = &skeletons->xdp_redirect_maps->links.xdp_redirect_map_0;
> +		remote_prog = skeletons->xdp_dummy->progs.xdp_dummy_prog;
> +		remote_link = &skeletons->xdp_dummy->links.xdp_dummy_prog;
> +		break;
> +	case 1:
> +		local_prog = skeletons->xdp_redirect_maps->progs.xdp_redirect_map_1;
> +		local_link = &skeletons->xdp_redirect_maps->links.xdp_redirect_map_1;
> +		remote_prog = skeletons->xdp_tx->progs.xdp_tx;
> +		remote_link = &skeletons->xdp_tx->links.xdp_tx;
> +		break;
> +	case 2:
> +		local_prog = skeletons->xdp_redirect_maps->progs.xdp_redirect_map_2;
> +		local_link = &skeletons->xdp_redirect_maps->links.xdp_redirect_map_2;
> +		remote_prog = skeletons->xdp_dummy->progs.xdp_dummy_prog;
> +		remote_link = &skeletons->xdp_dummy->links.xdp_dummy_prog;
> +		break;
> +	}
> +	interface = if_nametoindex(config[index].local_veth);
> +	if (!ASSERT_NEQ(interface, 0, "non zero interface index"))
> +		return -1;
> +	link = bpf_program__attach_xdp(local_prog, interface);
> +	if (!ASSERT_OK_PTR(link, "attach xdp program to local veth"))
> +		return -1;
> +	*local_link = link;
> +	nstoken = open_netns(config[index].namespace);
> +	if (!ASSERT_OK_PTR(nstoken, "switch to remote veth namespace"))
> +		return -1;
> +	interface = if_nametoindex(config[index].remote_veth);
> +	if (!ASSERT_NEQ(interface, 0, "non zero interface index"))
> +		return -1;

Missing `close_netns(nstoken);` in error path here, otherwise looks reasonable to me.

> +	link = bpf_program__attach_xdp(remote_prog, interface);
> +	*remote_link = link;
> +	close_netns(nstoken);
> +	if (!ASSERT_OK_PTR(link, "attach xdp program to remote veth"))
> +		return -1;
> +
> +	return 0;
> +}

Thanks,
Daniel

