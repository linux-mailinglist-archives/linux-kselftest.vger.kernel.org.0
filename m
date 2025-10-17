Return-Path: <linux-kselftest+bounces-43449-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE0FBEC02D
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Oct 2025 01:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 520B44EA313
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Oct 2025 23:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8A02DCF6F;
	Fri, 17 Oct 2025 23:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="i1NXAIjC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021D123BF91;
	Fri, 17 Oct 2025 23:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760744088; cv=none; b=hS8uWHD+SxUmEWvyWaOZXKkCFUeZhlYDri3Dd9gVqSSCQT0I6DRYF2ZbJOpJpuvOP+IZlbHK7A//X3PFxkcpIR3wYxsIQ0k661ixv/YQ9zksBZ5UEvu6/psGWVGL215+PrrKWn2Rrm+j9ShpVPw7IKP6Wtoh/K5NbEhXZ3buDqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760744088; c=relaxed/simple;
	bh=pYcbVyw+NDcF/YeLk7YmCeCpRP76yrQzGpy88DcfPE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m6zy/8bRJjPs1Q4cznK/ZtGTnkkTJa16mgxyqjPNZmDWQW8htBJrbXFUYNpcuFSrZG+CFDEmf6KvPY3osrgMh4ijZP5D/ErI97NdtrKfBMAwVJECmpe3p1P5rjKK+Y0KgUJqnaW6LakHX3LdZVvkJVYBSvX7NFbvnblse/Jd/MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=i1NXAIjC; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <056a0000-f74c-47d9-9fdb-04f0646c174b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760744073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tqNv9XZ3cHZq/nZ+ajuryy76A/vXM/wJUR3p9n98Y3I=;
	b=i1NXAIjC5akXkLmD1o92ACUQy2bwsjwVySCw29oQ8btNNAmvRMqiBXLjUpid1Zl2eECReg
	t1gOL/ZegEOz3PFDn85Sj/7l79eGcptPsu8qOxOupI1oEvklUPuXw6ovE14jXt33NHSfhV
	4GEN5CSXX2OOcy7LPicH1qHOSa1QDHA=
Date: Fri, 17 Oct 2025 16:34:27 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 3/5] selftests/bpf: make test_tc_tunnel.bpf.c
 compatible with big endian platforms
To: =?UTF-8?Q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?=
 <alexis.lothore@bootlin.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 ebpf@linuxfoundation.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251017-tc_tunnel-v1-0-2d86808d86b2@bootlin.com>
 <20251017-tc_tunnel-v1-3-2d86808d86b2@bootlin.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20251017-tc_tunnel-v1-3-2d86808d86b2@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 10/17/25 7:29 AM, Alexis Lothoré (eBPF Foundation) wrote:
> +#define ETH_HLEN	14
> +#define TC_ACT_OK	0
> +#define TC_ACT_SHOT	2
> +#define ETH_P_MPLS_UC	0x8847
> +#define ETH_P_IP	0x0800
> +#define ETH_P_IPV6	0x86DD
> +#define ETH_P_TEB	0x6558
> +
> +#define MPLS_LS_S_MASK	0x00000100
> +#define BPF_F_ADJ_ROOM_ENCAP_L2(len)			\
> +	(((__u64)len & BPF_ADJ_ROOM_ENCAP_L2_MASK)	\
> +	 << BPF_ADJ_ROOM_ENCAP_L2_SHIFT)
> +

Some of them (e.g. TC_ACT_OK) should be already in bpf_tracing_net.h, so 
include that header instead. Not sure the remaining ones (e.g. MPLS) 
will be very useful, so I would leave it here for now instead of adding 
them to bpf_tracing_net.h.

