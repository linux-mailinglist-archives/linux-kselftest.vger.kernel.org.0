Return-Path: <linux-kselftest+bounces-14614-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53AD5944925
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 12:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76F2A1C212E6
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 10:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEA2183CC2;
	Thu,  1 Aug 2024 10:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BZayysk4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9C316D33D;
	Thu,  1 Aug 2024 10:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722507192; cv=none; b=PHBxRfqSzLG/YcrevIyhN7ltrqPULYtH6oJOEu/cpbbMgy0gZPs4kHAwwUo9Q2A7QdckyQk294nH0UAElq9CvpkCJagmX4PHl0vNHVssOQ5LYqg/9Uf8XSc4bvPSrBIWYGYfeTGCo5UR8NenYzodGezT35lFzxnHLusq6MJz7z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722507192; c=relaxed/simple;
	bh=yvknAgAsbDgXnDDOUbFiwbboa9k2xuKDgC3TuA1a3ng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HweebZq2/tC67H5rCGe0kM/Emqj/ZPtxxYQt5Huefd7520oi4ix2TUUMlmykxrKS3FVvljev/Z08L4mNcTIG5jj924ZtYGGhDIlYfgTM6uRulnkjkBnahzY5LTeuZJOSXHFL2tEFri2ZzIikI5UvRdSmai9tHrZdLG2q81DmO88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BZayysk4; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 30AF3E0002;
	Thu,  1 Aug 2024 10:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722507182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MUr7kViu85BUT3K6BYdK14c4JnciAuUgSaYmFW3JG0Y=;
	b=BZayysk4Ikk8YF0U+rcLZ1Af8b60BSwA2GoSzMrtVzl5YNbXQrk79fWiox58lqEIA7jmjD
	L057EFUkH0B4OdPws382peAPlFdwWTexy2zXtphaCK56zDRS3unQO8ItNRmIpMceNwPlTG
	MMdUf8o8Oxyv67dvhWTsMVuZp+sB0LlHx+vjLY9zOww00HIB8B4yuEIX0X/EvrBUQroYCC
	kXioxUUfuokZ+zKQaUctpx62e2sCF6Hw2eTrehg9Jj9sV6odxFv4inRcMgjD6rhv5KdioP
	YI0+2UvBa/s8BnalnDg6J5wrtPUljqkpJBQJfjpAbEJkmPHGmB6ruOIGHiVhrA==
Message-ID: <fa0b7986-27d2-47f7-ba1e-1d8075e5c35d@bootlin.com>
Date: Thu, 1 Aug 2024 12:12:55 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 4/4] selftests/bpf: convert
 test_skb_cgroup_id_user to test_progs
To: Alan Maguire <alan.maguire@oracle.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>
Cc: ebpf@linuxfoundation.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20240731-convert_cgroup_tests-v1-0-14cbc51b6947@bootlin.com>
 <20240731-convert_cgroup_tests-v1-4-14cbc51b6947@bootlin.com>
 <1edbf600-237f-45b2-8fc5-47e471a17db8@oracle.com>
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Content-Language: en-US
In-Reply-To: <1edbf600-237f-45b2-8fc5-47e471a17db8@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

On 8/1/24 10:49, Alan Maguire wrote:
> On 31/07/2024 11:38, Alexis Lothoré (eBPF Foundation) wrote:

[...]

>> +static int wait_local_ip(void)
>> +{
>> +	char *ping_cmd = ping_command(AF_INET6);
>> +	int i, err;
>> +
>> +	for (i = 0; i < WAIT_AUTO_IP_MAX_ATTEMPT; i++) {
>> +		err = SYS_NOFAIL("%s -c 1 -W 1 %s%%%s", ping_cmd, DST_ADDR,
>> +				 VETH_1);
>> +		if (!err)
>> +			break;
>> +	}
> 
> 
> thinking about the risks of CI flakiness, would a small sleep between
> checks be worth doing here?

I assumed that adding -W 1 (ping timeout duration) to the command would be
enough to make sure that there is a proper wait between each attempt (so
currently, waiting at most 10s for network configuration between the 2 veths).
Don't you think it is enough to prevent issues in CI ?

>> +

[...]

>> +
>> +	expected_ids[0] = get_cgroup_id("/.."); /* root cgroup */
>> +	expected_ids[1] = get_cgroup_id("");
>> +	expected_ids[2] = get_cgroup_id(CGROUP_PATH);
>> +	expected_ids[3] = 0; /* non-existent cgroup */
>> +
>> +	for (level = 0; level < NUM_CGROUP_LEVELS; level++) {
>> +		err = bpf_map__lookup_elem(t->skel->maps.cgroup_ids, &level,
>> +					   sizeof(level), &actual_ids[level],
>> +					   sizeof(__u64), 0);
> 
> could probably simplify this + the BPF prog using a global array of
> actual_ids[], then compare it to the expected values using
> skel->bss->actual_ids

ACK, I'll update this.

Thanks,

Alexis

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


