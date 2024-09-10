Return-Path: <linux-kselftest+bounces-17571-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A94972A56
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 09:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C62EB1F258EB
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 07:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9AD17C208;
	Tue, 10 Sep 2024 07:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="T2k9wACp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4914555884;
	Tue, 10 Sep 2024 07:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725952533; cv=none; b=rwBIroHNkufdbV1p9lu3PAFAsMk1qXSrtCds/a3f7k2huW2hGqXYbUcxIIAtuKaVJqimrz5zO99sC8Xrt9vsb0z8p2v6uSSUIofj2+mEw69M5DzVQKP0jyMr45DLi7GctwBcv7q4Yw6iYKVTibct0Yr/9p2stdGpRY/kHhEsmsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725952533; c=relaxed/simple;
	bh=LVH6SKkK3cR6F01hpn7fuEDkydoETs1y5yzB1IbWltg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LqX61u4ZKJZXeyxjhsjLliD/iwCNQnuYXf6z5FSmsJMsv9JrZTFinelPL1irQ7XYTwMdxUkABgU9afSNrTtRVMUXgARQgw786DvS9AtLN7BOIKDzOEnLwuD1UZK0wcB4cZKKaL6mrYsC0Ptnbtntue0gddOd1PpKl3FQLchP/ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=T2k9wACp; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DCAD160002;
	Tue, 10 Sep 2024 07:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725952528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rQ60DBGOv0B3Rr4ZO4jWbLjG2NSGTwvc1sph6GoxX64=;
	b=T2k9wACpNqFS6Y/LfZX/9lL19y7XpkmY0D8tW4yduHEuaZ3YAJjb54VlFkNWF5h8NqCKk5
	oCDMJEO+gwOWuU8n0VllVqzrkZvV6DDVAUvIwKlq06W/wJqpPPliXIM4fXHWhyeeQQDq/U
	LzcCH/h7rTaOsw4+H6hWkSD0UEawycl4dC2YbLvoA0P85Q3r0ZXU07DImr9EFrTiXjSLtK
	xq0TpVOylr0h8eg9dCjktJ6bBOxFq7gI4QRRltNDefDeVnoMLf10ZRD1DGESjNZ3wGICqm
	HWhFpE8UvoOozxGsCVGsRS+qtX+tj+5z6lUwjJOFybc5ANvFCbCZaKsoPgURSQ==
Message-ID: <b5814f3f-d262-4577-834c-a48bbcc8d005@bootlin.com>
Date: Tue, 10 Sep 2024 09:15:26 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] selftests/bpf: convert test_xdp_features.sh to
 test_progs
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Lorenzo Bianconi <lorenzo@kernel.org>, ebpf@linuxfoundation.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
References: <20240909-convert_xdp_tests-v1-1-925be5fbee3c@bootlin.com>
 <20240909231800.72b6b328@fedora.home>
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Content-Language: en-US
In-Reply-To: <20240909231800.72b6b328@fedora.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

Hey Maxime,

On 9/9/24 23:18, Maxime Chevallier wrote:
> Hi Alexis,
> 
> On Mon, 09 Sep 2024 22:02:07 +0200
> Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com> wrote:

[...]

>> +static void *run_dut_echo_thread(void *arg)
>> +{
>> +	struct test_data *t = (struct test_data *)arg;
>> +	__u32 magic;
>> +
>> +	while (!t->quit_dut_echo_thread) {
>> +		struct sockaddr_storage addr;
>> +		socklen_t addrlen;
>> +		size_t n;
>> +
>> +		n = recvfrom(t->echo_server_sock, &magic, sizeof(magic),
>> +			     MSG_WAITALL, (struct sockaddr *)&addr, &addrlen);
>> +		if (n != sizeof(magic)) {
>> +			usleep(LOOP_DELAY_US);
>> +			continue;
>> +		}
>> +
>> +		if (htonl(magic) != CMD_ECHO)
>> +			continue;
> 
> Shouldn't it be ntohl here ? The former code used the ntohs helper for
> that command, and you're sending the magic in send_echo_msg with a
> htonl() so I guess here you might want to convert the value back to
> host endianness.

You are right, silly mistake from me here :) That will be fixed in v2. I'll
delay a bit before sending it to allow others to take a look at v1 too.

Thanks,

Alexis
> 
> Thanks,
> 
> Maxime
> 

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


