Return-Path: <linux-kselftest+bounces-27841-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C50FA49323
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 09:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78B9C1703AC
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 08:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17B422DF83;
	Fri, 28 Feb 2025 08:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="P4+3jflR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B17D22CBCB;
	Fri, 28 Feb 2025 08:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740730544; cv=none; b=U+65TI5vdI4PfMzxbL6LgGqGgqkWm4bFRrlhEt8QjzYjYUaDi0XXCpWj5uhJuSgi+cN+tc5EMXvdWkBsklroSmm+2xXm4EVJGy1d/7QuizI6AIar8BDuFxZpnMmVeJGJnACYy/48c0A37ZON6LAP1eQT2geV0ZwJrjE9dQTaCoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740730544; c=relaxed/simple;
	bh=WvAzpXYuDStbIgKgevXS4PEedZ9dOlJ+/Y44X6oyEF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MXLSj76pEr+HXmP9XiNmnQWdrF29x25nob/Ew5eSTSB1GQ6zaPrehLoVS2Lnx+CR+Je4Pw9rm4NJw+oNtdK9BGpBmAsmZh+PIoeEkxBlt+B2IdL6ybxrNNle928ukZPODlIQ1nkD+igLRJfeN3U0ROX21Btcfka7s/m5dLgoqwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=P4+3jflR; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C61E944432;
	Fri, 28 Feb 2025 08:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740730533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1iuifuyC6NwdJO1A+Y1ARBqJ7aQn+uQXOyq27YtuDWY=;
	b=P4+3jflRxGg/jV135L0ycaPLhy0wFGWV7b4xHnid2vIQ4EWylqaSqoDPc/Mv0xqhG0RF/4
	bXgBQ9zXbuKck7zg+NcVqYBYSvXMmP+z+mRwEG7KgGNbkTJ4yD7A5FRDMZ+LWcskgcZ0ur
	U85N9738IWlHE/ypWDJe7IA20sZP+H7/C2AsWAwEGY/GvUr7G7t5okLPnupvntT/QXks/f
	e2oWQU037PNB84V3g0e028iWOgUa2pdP7XxGHgrncwwXYY6J/QGRVcL9tmh3Uvy+JhiPnM
	4lU7K0Z25QchE2OoSH06FC/B4VNbhVR0/5Kv/qCW7cIRMR4s/N3JSXsgF8Olhw==
Message-ID: <d95c15b7-3641-4334-a42b-b56067e5e0f0@bootlin.com>
Date: Fri, 28 Feb 2025 09:15:32 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 04/10] selftests/bpf: test_tunnel: Move ip6gre
 tunnel test to test_progs
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Alexis Lothore <alexis.lothore@bootlin.com>, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250227-tunnels-v1-0-33df5c30aa04@bootlin.com>
 <20250227-tunnels-v1-4-33df5c30aa04@bootlin.com> <Z8DkxXy9ZAbASXCk@mini-arch>
Content-Language: en-US
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
In-Reply-To: <Z8DkxXy9ZAbASXCk@mini-arch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekleekkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeurghsthhivghnucevuhhruhhttghhvghtuceosggrshhtihgvnhdrtghurhhuthgthhgvthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhephfehgefgteffkeehveeuvdekvddvueefgeejvefgleevveevteffveefgfehieejnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegludelvddrudeikedrtddrudegngdpmhgrihhlfhhrohhmpegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvtddprhgtphhtthhopehsthhfohhmihgthhgvvhesghhmrghilhdrtghomhdprhgtphhtthhopegrshhtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhesihhoghgvrghrsghogidrnhgvthdprhgtphhtthhopegrnhgurhhiiheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrrhhtihhnrdhlrghusehlihhnuhigrdguvghvpdhrt
 ghpthhtohepvgguugihiiekjeesghhmrghilhdrtghomhdprhgtphhtthhopehsohhngheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephihonhhghhhonhhgrdhsohhngheslhhinhhugidruggvvh
X-GND-Sasl: bastien.curutchet@bootlin.com

Hi Stanislav

On 2/27/25 11:18 PM, Stanislav Fomichev wrote:
> On 02/27, Bastien Curutchet (eBPF Foundation) wrote:
>> ip6gre tunnels are tested in the test_tunnel.sh but not in the test_progs
>> framework.
>>
>> Add a new test in test_progs to test ip6gre tunnels. It uses the same
>> network topology and the same BPF programs than the script. Disable the
>> IPv6 DAD feature because it can take lot of time and cause some tests to
>> fail depending on the environment they're run on.
>> Remove test_ip6gre() and test_ip6gretap() from the script.
>>
>> Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
>> ---
>>   .../testing/selftests/bpf/prog_tests/test_tunnel.c | 110 +++++++++++++++++++++
>>   tools/testing/selftests/bpf/test_tunnel.sh         |  95 ------------------
>>   2 files changed, 110 insertions(+), 95 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
>> index bd1410b90b94773ba9bc1fa378bb7139f8d4670a..f00727aedee0c283002c55a45a04a96013d39a5d 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
>> @@ -71,6 +71,8 @@
>>   #define IP4_ADDR2_VETH1 "172.16.1.20"
>>   #define IP4_ADDR_TUNL_DEV0 "10.1.1.100"
>>   #define IP4_ADDR_TUNL_DEV1 "10.1.1.200"
>> +#define IP6_ADDR_TUNL_DEV0 "fc80::100"
>> +#define IP6_ADDR_TUNL_DEV1 "fc80::200"
>>   
>>   #define IP6_ADDR_VETH0 "::11"
>>   #define IP6_ADDR1_VETH1 "::22"
>> @@ -101,11 +103,21 @@
>>   #define GRE_TUNL_DEV0 "gre00"
>>   #define GRE_TUNL_DEV1 "gre11"
>>   
>> +#define IP6GRE_TUNL_DEV0 "ip6gre00"
>> +#define IP6GRE_TUNL_DEV1 "ip6gre11"
>> +
>>   #define PING_ARGS "-i 0.01 -c 3 -w 10 -q"
>>   
>>   static int config_device(void)
>>   {
>>   	SYS(fail, "ip netns add at_ns0");
> 
> [..]
> 
>> +	/* disable IPv6 DAD because it might take too long and fail tests */
>> +	SYS(fail, "ip netns exec at_ns0 sysctl -wq net.ipv6.conf.default.accept_dad=0");
>> +	SYS(fail, "ip netns exec at_ns0 sysctl -wq net.ipv6.conf.all.accept_dad=0");
>> +	SYS(fail, "sysctl -wq net.ipv6.conf.default.accept_dad=0");
>> +	SYS(fail, "sysctl -wq net.ipv6.conf.all.accept_dad=0");
> 
> `ip addr add ... nodad` should be a less invasive alternative?

I didn't know I could do it through `ip addr`, I'll try this !


Best regards,
Bastien

