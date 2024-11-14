Return-Path: <linux-kselftest+bounces-22010-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCFB9C8487
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 09:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 156182852D5
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 08:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA821F584F;
	Thu, 14 Nov 2024 08:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="T8Bg8PSl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBAB1E7C37;
	Thu, 14 Nov 2024 08:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731571472; cv=none; b=Nn4VXofNK9ZSRrTyAh063vuKrEmqL/YYHO/KGFHZVPprMM4eL+Mt+DjkWgksKEMW9KjdJ7s8SPguYHR1fpsIhbOOyAj2VoNbloQspIVVzPpn43tma0m0tIIQ4S3LZDEalCUj+zI1TDZ2FK0Bz6PNrSc4yik6nW66UpGGa/HKLy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731571472; c=relaxed/simple;
	bh=c0rK2hD8IInnujEn6ZRZ9mL+YY7avPjUmiMgPOgsHdE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SD5El36JbKjQZNXhStK+Q80TbCoCTy1UjgevdzuySFweqM0/lFFPtmMKtWhMQHz0LThWUE7hC/b5pGEN7AEG6hrAHmcTjV56svEX9Z1qtXiC+brbVfcoyL0g608i08TOcW73GvEOFIir34+RgU1E5PJsNf5tBieq9ls56bJOUyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=T8Bg8PSl; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 69A4FC0004;
	Thu, 14 Nov 2024 08:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731571468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mYIcdsy2gdleesrm6irMs7fMzybCMdHI6kY3Uu5tYOY=;
	b=T8Bg8PSlmbwuNxisyJoS+8fCmVlHb0Rkh03w5aEdN1vbrmr7qdAVb77LtitucqN/mCN6yr
	8/oMrd4r19Z8CnVA0N8TDYYbkrRn1eSl9m541/QbI6rgUlHR2wM77qjQhCWpxFZjgUFNgR
	H18DmZjSYKjq9OLRyQyMtq/z7AFDX6L7ZCuylAep8bIF8Kok0k68a+cunw4rl+KGB4KQkT
	pN1BgeGAXl3PWYluzbx1K1P32TPafeBobG/XmzW//hnriZB+FXQn71LB5Mg9KhPhfr0DFM
	WHpY4VLg0ZtP22tOf0NNeD4b9YRe69Yp3fHcQRMbwMbfnlWUaYN0eWoTc4flzQ==
Message-ID: <81dececf-b646-4ed3-bfa8-e32c0e1d69db@bootlin.com>
Date: Thu, 14 Nov 2024 09:04:27 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 09/10] selftests/bpf: migrate bpf flow dissectors
 tests to test_progs
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 ebpf@linuxfoundation.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Petar Penkov <ppenkov@google.com>, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241113-flow_dissector-v1-0-27c4df0592dc@bootlin.com>
 <20241113-flow_dissector-v1-9-27c4df0592dc@bootlin.com>
 <ZzToxolRWf2uieWP@mini-arch>
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Content-Language: en-US
In-Reply-To: <ZzToxolRWf2uieWP@mini-arch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

On 11/13/24 18:58, Stanislav Fomichev wrote:
> On 11/13, Alexis Lothoré (eBPF Foundation) wrote:
>> test_flow_dissector.sh loads flow_dissector program and subprograms,
>> creates and configured relevant tunnels and interfaces, and ensure that
>> the bpf dissection is actually performed correctly. Similar tests exist
>> in test_progs (thanks to flow_dissector.c) and run the same programs,
>> but those are only executed with BPF_PROG_RUN: those tests are then
>> missing some coverage (eg: coverage for flow keys manipulated when the
>> configured flower uses a port range, which has a dedicated test in
>> test_flow_dissector.sh)
>>
>> Convert test_flow_dissector.sh into test_progs so that the corresponding
>> tests are also run in CI.
>>
>> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
>> ---

[...]

>> +static uint16_t build_udp_v6_csum(const struct ipv6hdr *ip6h,
>> +				  const struct udphdr *udph, int num_words)
>> +{
>> +	unsigned long pseudo_sum;
>> +	int num_u16 = sizeof(ip6h->saddr); /* halfwords: twice byte len */
>> +
>> +	pseudo_sum = add_csum_hword((void *)&ip6h->saddr, num_u16);
>> +	pseudo_sum += htons(ip6h->nexthdr);
>> +	pseudo_sum += ip6h->payload_len;
>> +	return build_ip_csum((void *)udph, num_words, pseudo_sum);
>> +}
> 
> I remember adding a bunch of similar code to tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> and tools/testing/selftests/bpf/network_helpers.h. The csum handling in
> particular (csum_tcpudp_magic/etc for pseudo headers).
> Can you see if something can be reused? Maybe something we
> can move into network_helpers.h? For example build_ip_csum/ip_csum.

Ah, indeed, thanks for the pointer.  I can definitely take a look and make sure
that those helpers are shared.

Thanks,

Alexis

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

