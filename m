Return-Path: <linux-kselftest+bounces-24030-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7806A04A7D
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 20:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31FEA1888924
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 19:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C451F63C3;
	Tue,  7 Jan 2025 19:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UoxgCbzg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93741F63E9
	for <linux-kselftest@vger.kernel.org>; Tue,  7 Jan 2025 19:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736279332; cv=none; b=gbHJ52bgXPI0U1T+GFuaiF52BrWV5FzmcyP1tawq4IoTGG9lDetGyAxnhG/WohxyNzZrgquU7A2omshqpkBJ8hjABCTqXEwIg/pf8oQmoMpaLGAxJJn6UBuCcAcDTm9QecIe5BzrL60+SSmkLes+E+2fmaQH1hQgIjajLJpzX/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736279332; c=relaxed/simple;
	bh=Kgz2jx7bib0PN4twzARuqIrW4rC6y55S605NP2TJFDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lPip+WxbuZBkrF910pF0sn/+xyBR9htQ9/byyxexfkVFeBl69EccXiNWicHkx25F1Cg4SM5O6ozf/SknuFz3SBQxBnHxCTWfL/RSYzHTngzGqPzdSLs6w8l695BUsIrg4NJOjbbizCrNzsOJZ+30EESjuArp2yRJNGg57SmwCyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UoxgCbzg; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <01084af1-4f39-46f8-a278-9cfa7f242a11@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736279326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B5ZAmugUbFS8tTnvREFaNPziAJZ+taQuMYqxt7qiZl4=;
	b=UoxgCbzgF9qgfmI7I00gcuVoFHoO7m69/ZcURii2U6nIKntvz3n3PSkCIfLUymfythcrDH
	nDGDw948NmehGcw0ncxnEg/DUlO8aJjNb8nEv4gt4x2u+dNOm2pP0PRx15dapROBxSjg2h
	7X2GsRidLj2ywaHK7povwtQMy+6tgxw=
Date: Tue, 7 Jan 2025 11:48:36 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/3] selftests/bpf: Migrate test_xdp_redirect.sh to
 xdp_do_redirect.c
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
References: <20250103-xdp_redirect-v1-0-e93099f59069@bootlin.com>
 <20250103-xdp_redirect-v1-2-e93099f59069@bootlin.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250103-xdp_redirect-v1-2-e93099f59069@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/3/25 2:10 AM, Bastien Curutchet (eBPF Foundation) wrote:
> +static int ping_setup(struct test_data *data)
> +{
> +	struct nstoken *nstoken = NULL;
> +	int i;
> +
> +	data->ns[0] = netns_new(NS0, false);
> +	if (!ASSERT_OK_PTR(data->ns[0], "create ns"))
> +		return -1;
> +
> +	for (i = 1; i < NS_NB; i++) {
> +		char ns_name[4] = {};
> +
> +		snprintf(ns_name, 4, "NS%d", i);
> +		data->ns[i] = netns_new(ns_name, false);
> +		if (!ASSERT_OK_PTR(data->ns[i], "create ns"))
> +			goto fail;
> +
> +		nstoken = open_netns(NS0);
> +		if (!ASSERT_OK_PTR(nstoken, "open NS0"))
> +			goto fail;
> +
> +		SYS(fail, "ip link add veth%d index %d%d%d type veth peer name veth0 netns %s",
> +		    i, i, i, i, ns_name);
> +		SYS(fail, "ip link set veth%d up", i);
> +		close_netns(nstoken);
> +
> +		nstoken = open_netns(ns_name);
> +		if (!ASSERT_OK_PTR(nstoken, "open ns"))
> +			goto fail;
> +
> +		SYS(fail, "ip addr add %s.%d/24 dev veth0", IPV4_NETWORK, i);
> +		SYS(fail, "ip link set veth0 up");
> +		close_netns(nstoken);

		nstoken = NULL;

Otherwise, the other "goto fail;" of this loop will close and free the already 
closed nstoken again.

Some of the other close_netns(nstoken) in this patch may have similar issue.

> +	}
> +
> +	return 0;
> +
> +fail:
> +	close_netns(nstoken);
> +	cleanup(data);
> +	return -1;
> +}


