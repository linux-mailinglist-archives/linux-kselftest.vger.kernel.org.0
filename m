Return-Path: <linux-kselftest+bounces-18371-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AADE9986759
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2024 22:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59B8D2819E6
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2024 20:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A8F13DDDD;
	Wed, 25 Sep 2024 20:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RqSeqGfC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B307208CA;
	Wed, 25 Sep 2024 20:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727294522; cv=none; b=EwBU7RhmF1c5iXv6UI2hSk3LYKoljcPuJ5ceOK7b6eZnI+5abyFkgx659RMlHe9lSpV9DySY2ZnLOL46r9iFmB8g8Mk/UsQRaeVQuDtFynM2AaPOVkOxm3t5pKu9xq52tbuOLGthlJjY37KWf+/4HdLbEhOfLmWlXhpZ2nz51UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727294522; c=relaxed/simple;
	bh=GuAtbY3FxHHtmaHMBG3KUXH3yBXNnrSuxiRVAzTx8ds=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=BpZnJG3aJOgMTkgh5jFhGMmPbtjulbaR/n7zj4mIcaEBPdWlIz0yk8w5UVwtEg2yPmm9jWgXXthc7JsGTJJkPeDSymZ8a+w0I9r7Yr12BGdA1VGsAgChJKVRVd/+3SwyR7gNgaEpCBGLui+55b2fKBi8w35Egt1Jjqq668H9c1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RqSeqGfC; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <895a685b-7449-4bf1-b14d-00aee1d8f75b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727294518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YfbUzqws6stxPgb9eT4nEGannHed53FdV2xBgbx4dKI=;
	b=RqSeqGfCCZ6YmwlRXsgxBrh7ruqVV3x98v/vzK+XODrCAMKQ6MCbfMsk/ECbPaOVf0KXu5
	ZHHvyrJab4ckHdNyOJzRZlRUbyijhqluskNcQdDO0pmety1vfUgVUBQxZxZjTavhUhfc2W
	p0eLT8aScNV5RHFz5mYDza7TmPMRoj0=
Date: Wed, 25 Sep 2024 13:01:43 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2] selftests/bpf: convert test_xdp_features.sh
 to test_progs
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, ebpf@linuxfoundation.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
References: <20240910-convert_xdp_tests-v2-1-a46367c9d038@bootlin.com>
 <64df8d41-6cfb-45a9-8337-5cc04daedb60@linux.dev> <ZuVWmxoqXFI3qvVI@lore-desk>
 <20240914063828.7bd73c5e@kernel.org>
 <464e0ae0-d6e3-4da4-a157-f74260f96275@bootlin.com>
 <366e4392-bd00-4120-8585-a71b3952e365@linux.dev>
Content-Language: en-US
In-Reply-To: <366e4392-bd00-4120-8585-a71b3952e365@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/25/24 3:37 AM, Martin KaFai Lau wrote:
> I am not sure which case in xdp_features.c does not have existing coverage in 
> test_progs. From a quick look, it seems only BPF_MAP_TYPE_CPUMAP is missing 
> (please check)?

Re: CPUMAP, I noticed there is a xdp_(cpu)map_attach.c test but it only does 
attach test. May be something similar can be done like 
https://lore.kernel.org/bpf/20240911-devel-koalo-fix-ingress-ifindex-v4-2-5c643ae10258@linutronix.de/ 
to exercise the xdp prog that does cpumap redirect.

