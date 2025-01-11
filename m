Return-Path: <linux-kselftest+bounces-24279-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9081A0A02B
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Jan 2025 02:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DF1F3AB1D8
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Jan 2025 01:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26AB481CD;
	Sat, 11 Jan 2025 01:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IYLLMPex"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2734438B;
	Sat, 11 Jan 2025 01:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736559975; cv=none; b=H0cijr6fhKGdRQWQ32bN9yWqWf/bo4XMa89gjJGiDmqL/sXsj3L+uIvlv2X60wlWZWTO9+k/yHXgpF9cur7rfxi++1GUirPVTOeYll2/AOXgu4SegbpAijybp2mh/n4Y4pQbqLcBue3VTWUfJeUlSu5aczlda6MEicjY+rJt3Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736559975; c=relaxed/simple;
	bh=oL1znrA+BuRTsJSUJJ28nbRVw8azI79r0G/QLQ0/4o4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BcprjWs9TxThGbLXOn3trEz7e/w3Jyqg0ww0XF48bqmC0LIR9E/nbiH6QaoWJPQ0ZemCHu5McAFBUmQcg4Y9ZHS0tMVMM3V5bzys9EehqPq9OmF5hY7EDAdvGMVuLj8ZD9mfzwMkGH3+PCyidBEMT+v9Hlfu1KNXMKFuvdptWHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IYLLMPex; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8b72630d-8804-4b80-b4bd-857066b64b08@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736559957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MFVi31aY68398PatoQWdmgcINX7DagiGOAeQw2HTam8=;
	b=IYLLMPexR21QLu7QXdCu3/evVz+nvYMGe3ML8ZcEdzziHZXSOyhmw04YDiOax6C6N13ONg
	bX+0f4lBidpi8Kkm0M1ZyfSbd8M/B8eI/pYt0ShdUQPuuhoCPaK8fqSEckvvnY0KjExxJH
	CefzJJpO1O/MSWulw5tTUxnD14mAPLw=
Date: Fri, 10 Jan 2025 17:45:45 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 2/3] selftests/bpf: Migrate
 test_xdp_redirect.sh to xdp_do_redirect.c
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
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Alexis Lothore <alexis.lothore@bootlin.com>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250110-xdp_redirect-v2-0-b8f3ae53e894@bootlin.com>
 <20250110-xdp_redirect-v2-2-b8f3ae53e894@bootlin.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20250110-xdp_redirect-v2-2-b8f3ae53e894@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/10/25 1:21 AM, Bastien Curutchet (eBPF Foundation) wrote:
> +static void ping_test(struct test_data *data)
> +{
> +	struct test_xdp_redirect *skel = NULL;
> +	struct xdp_dummy *skel_dummy = NULL;
> +	struct nstoken *nstoken = NULL;
> +	int i, ret;
> +
> +	skel_dummy = xdp_dummy__open_and_load();
> +	if (!ASSERT_OK_PTR(skel_dummy, "open and load xdp_dummy skeleton"))
> +		goto close;
> +
> +	for (i = 1; i < NS_NB; i++) {
> +		char ns_name[4] = {};
> +
> +		snprintf(ns_name, 4, "NS%d", i);
> +		nstoken = open_netns(ns_name);
> +		if (!ASSERT_OK_PTR(nstoken, "open ns"))
> +			goto close;
> +
> +		ret = bpf_xdp_attach(if_nametoindex("veth0"),
> +				     bpf_program__fd(skel_dummy->progs.xdp_dummy_prog),
> +				     data->xdp_flags, NULL);
> +		if (!ASSERT_GE(ret, 0, "bpf_xdp_attach dummy_prog"))
> +			goto close;
> +
> +		close_netns(nstoken);
> +		nstoken = NULL;
> +	}
> +
> +	skel = test_xdp_redirect__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "open and load skeleton"))
> +		goto close;
> +
> +	nstoken = open_netns(NS0);
> +	if (!ASSERT_OK_PTR(nstoken, "open NS0"))
> +		goto close;
> +
> +	ret = bpf_xdp_attach(VETH2_INDEX,
> +			     bpf_program__fd(skel->progs.xdp_redirect_to_111),
> +			     data->xdp_flags, NULL);
> +	if (!ASSERT_GE(ret, 0, "bpf_xdp_attach"))
> +		goto close;
> +
> +	ret = bpf_xdp_attach(VETH1_INDEX,
> +			     bpf_program__fd(skel->progs.xdp_redirect_to_222),
> +			     data->xdp_flags, NULL);
> +	if (!ASSERT_GE(ret, 0, "bpf_xdp_attach"))
> +		goto close;
> +
> +	close_netns(nstoken);
> +	nstoken = NULL;
> +
> +	nstoken = open_netns(NS1);
> +	if (!ASSERT_OK_PTR(nstoken, "open NS1"))
> +		goto close;
> +
> +	SYS(close, "ping -c 1 %s.2", IPV4_NETWORK);

I added "> /dev/null" to remove noise for common case.

Applied. Thanks.

