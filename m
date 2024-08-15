Return-Path: <linux-kselftest+bounces-15390-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FEB952ADA
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 10:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37B571F23116
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 08:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FB019EEA4;
	Thu, 15 Aug 2024 08:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="H7sh/MnH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69984176AA9;
	Thu, 15 Aug 2024 08:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723709835; cv=none; b=tnmW+Y3X2r5ftpqHxS1FTkdTBWvLvAMuUJH5dydmosn8nVCb4KUsZX5N8jY9vMMjz+KgLRkYhW69Fwhaf0BsOTtdGdwjQq9hyhskGxrM5RFcMgxQeLZwu/H9/ORF81J5is5+G6iNC0vd5VAxMD3mQ+MOPYmwFNPnsc4ZlACg050=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723709835; c=relaxed/simple;
	bh=GWBiH4ZVUiEUOh/sI4hXvLeuzGmyotK5Kv8uwRcqHKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c7/1dLKAPYXkNqSp5URnYQPXyCuytUtOPQLIMwfY6RcUjgYjLysolrNq0Golvhdki7wxPr1qJhIK4yzwIzTfFFsQz/yhE2wIswq8e6qdYHbzpDAx8vU+i63EV2HIvq3Q/WESCuF1rRQ91W71VZ5/z/VhUBO6/T5W4n2pUexpqvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=H7sh/MnH; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EEC8060003;
	Thu, 15 Aug 2024 08:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723709825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vWsM5QYpHQfJYyrwAgenUsDSWUQp0I0G8wHG4OAFcv4=;
	b=H7sh/MnH0tgXYkTeVpYjh4tVx8JZzbvFQO0QgUHBE3X7Ho5ZYGq+SmbWFGEeu9FtFUxZVz
	V5E9g+naDOSwMUpDPnTJb4IWc8+HQ2yneA/D/hJ5bvYG9371P8isT1lMgLAUjGpein18TJ
	XjB9/re/wFQact5Im3dyTjAlEyNrtiFSe+9inMMEpH26AQR/umhuloX12ZVYHwHGrfR7Vr
	1VbETwZG2kehwOc8SIqJOP05Pbzx3jVqohcIOvC4B0N57g2e7iheJ2NJ7tRaj324hT7RzS
	v4bS+mf4d85ta/r4DxIPci3jlncKHv8QPt3awguxkdKb8ZYIEMiivXz9eoeKVg==
Message-ID: <b3329b35-a41b-4f21-9b7b-8fc9b04eedd2@bootlin.com>
Date: Thu, 15 Aug 2024 10:17:03 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 4/4] selftests/bpf: convert
 test_skb_cgroup_id_user to test_progs
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, ebpf@linuxfoundation.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
References: <20240813-convert_cgroup_tests-v4-0-a33c03458cf6@bootlin.com>
 <20240813-convert_cgroup_tests-v4-4-a33c03458cf6@bootlin.com>
 <7f47361f-caf8-45f2-9aaf-4a2a49eb525b@linux.dev>
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Content-Language: en-US
In-Reply-To: <7f47361f-caf8-45f2-9aaf-4a2a49eb525b@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

Hello Martin,

On 8/15/24 04:20, Martin KaFai Lau wrote:
> On 8/13/24 5:45 AM, Alexis Lothoré (eBPF Foundation) wrote:
> 
>> +#define DST_ADDR "ff02::1"
> 
> [ ... ]
> 
>> +static int wait_local_ip(void)
>> +{
>> +    char *ping_cmd = ping_command(AF_INET6);
>> +    int i, err;
>> +
>> +    for (i = 0; i < WAIT_AUTO_IP_MAX_ATTEMPT; i++) {
>> +        err = SYS_NOFAIL("%s -c 1 -W 1 %s%%%s", ping_cmd, DST_ADDR,
>> +                 VETH_1);
> 
> I tried in my qemu. This loop takes at least 3-4 iteration to get the ping
> through. This test could become flaky if the CI is busy.
> 
> I have been always wondering why some of the (non) test_progs has this practice.
> I traced a little. I think it has something to do with the "ff02::1" used in the
> test and/or the local link address is not ready. I have not further nailed it
> down but I think it is close enough.
> 
> It will be easier to use a nodad configured v6 addr.
> 
> I take this chance to use an easier "::1" address for the test here instead of
> ff02::1. This also removed the need to add veth pair and no need to ping first.
> 
> Applied with the "::1" changes mentioned above.

Thanks for the improvement. So far I tried to preserve as much as possible the
original test behavior to avoid accidentally removing some important features,
but I guess the more tests I work on, the more confident I will be to
"challenge" some parts ;)

> Thanks for migrating the tests to test_progs. This is long overdue.

For the record, the next test I am targeting is test_xdp_features.sh. I have
undertaken the conversion and have a working base but it still needs some work.

Thanks,

Alexis


-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


