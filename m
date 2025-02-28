Return-Path: <linux-kselftest+bounces-27840-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD0CA49316
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 09:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FF0C3B7798
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 08:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01EE8212FB4;
	Fri, 28 Feb 2025 08:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YG6m990c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143401FAC31;
	Fri, 28 Feb 2025 08:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740730438; cv=none; b=egqH4ZSUDzNLqq8uIbmyvvEGqNTql2rA2ruLCyuaeavnySIerA4oT5Tpx2si7kGO3mjAm6bz/WvW7TBfkMAUrivq2ebxB8oi9z4HoYeAI4epmvU32A+sd71iGTCYVtk5OzTwXfl2zcBRfiNGYttgNatxqbjKBBXP+S6Wn2pyp5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740730438; c=relaxed/simple;
	bh=gmnwQui9PGhphy1y6k6f2iaJFn2c2puVe6UIWtj8VYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KuRA/5ITP5kWCShwB1Jpt3Ev0HbVOew4pKQoXSWovZrEG2PGPbnQUgNowlqDeT0qt+7lu4X3Mz2pYGMB6TvdppGAOEdSO08rFfZp31i7BM+ICzobRQ0TjpYT9k3cCajgk4bBH1irDPTg0BK7db3oeQhj93tEpC3KDSICCgC0zSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YG6m990c; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C392A44353;
	Fri, 28 Feb 2025 08:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740730434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TEsscNcctrVv+Wd6MiI3V0IKsPpsSuvjyar8nUANyzI=;
	b=YG6m990c3xRVuAPzyMnCvpX5uogvwB6Ai6PK1HCQ9b1E0XlgiiXbx/mFZ+40g9DDucT2vt
	+ItDWwjcHppgEhY+jOIe5gylFUQgTNIF5dij2fC9WIr+qjIBblM0Li6JiYo5I6uCBugJzp
	BbR8DPATJkLQ08N3rmMflaLksyRnyXVUa4BAbRK7aOTRB0qTqZwBKSDSU25NYvIB4ftxYD
	waGv0FyZRJ+er++kvKY4Uy1pyz/0KWtxkZseXfmzZjysHm1ly9GnV7YOjPEaIWZP0nWPwk
	kFuwzcSbT4bMZUiwdol32JKftDlG25Rb0B3zWbPwtLW0Mapeg9odRmlMgMr0+A==
Message-ID: <436b87f7-b5b2-4b5e-8979-47d123783b35@bootlin.com>
Date: Fri, 28 Feb 2025 09:13:52 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 01/10] selftests/bpf: test_tunnel: Add
 generic_attach* helpers
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
 <20250227-tunnels-v1-1-33df5c30aa04@bootlin.com> <Z8DiX8MmJWvO5Ws2@mini-arch>
Content-Language: en-US
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
In-Reply-To: <Z8DiX8MmJWvO5Ws2@mini-arch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekleekjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeurghsthhivghnucevuhhruhhttghhvghtuceosggrshhtihgvnhdrtghurhhuthgthhgvthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhephfehgefgteffkeehveeuvdekvddvueefgeejvefgleevveevteffveefgfehieejnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegludelvddrudeikedrtddrudegngdpmhgrihhlfhhrohhmpegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvtddprhgtphhtthhopehsthhfohhmihgthhgvvhesghhmrghilhdrtghomhdprhgtphhtthhopegrshhtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhesihhoghgvrghrsghogidrnhgvthdprhgtphhtthhopegrnhgurhhiiheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrrhhtihhnrdhlrghusehlihhnuhigrdguvghvpdhrt
 ghpthhtohepvgguugihiiekjeesghhmrghilhdrtghomhdprhgtphhtthhopehsohhngheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohephihonhhghhhonhhgrdhsohhngheslhhinhhugidruggvvh
X-GND-Sasl: bastien.curutchet@bootlin.com

Hi Stanislav,

On 2/27/25 11:08 PM, Stanislav Fomichev wrote:
> On 02/27, Bastien Curutchet (eBPF Foundation) wrote:
>> A fair amount of code duplication is present among tests to attach BPF
>> programs.
>>
>> Create generic_attach* helpers that attach BPF programs to a given
>> interface.
>> Use ASSERT_OK_FD() instead of ASSERT_GE() to check fd's validity.
>> Use these helpers in all the available tests.
>>
>> Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
>> ---
>>   .../testing/selftests/bpf/prog_tests/test_tunnel.c | 128 ++++++++++-----------
>>   1 file changed, 62 insertions(+), 66 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
>> index cec746e77cd3abdf561cfc2422fa0a934fc481cd..27a8c8caa87e4c6b39b2b26c2aa9860b131a70a9 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/test_tunnel.c
>> @@ -397,6 +397,56 @@ static int attach_tc_prog(struct bpf_tc_hook *hook, int igr_fd, int egr_fd)
>>   	return 0;
>>   }
>>   
>> +static int generic_attach(const char *dev, int igr_fd, int egr_fd)
>> +{
>> +	DECLARE_LIBBPF_OPTS(bpf_tc_hook, tc_hook, .attach_point = BPF_TC_INGRESS);
> 
> nit: .attach_point = BPF_TC_INGRESS is a bit confusing to me here
> (because we later attach both ingress and egress progs); mostly
> because the way attach_tc_prog is written I think. Can we move
> tc_hook definition to attach_tc_prog and make it
> .attach_point=BPF_TC_INGRESS|BPF_TC_EGRESS? And then we can make
> attach_tc_prog accept ifindex instead of tc_hook.
> 
> int attach_tc_prog(int ifindex, igr_fd, egr_fd)
> {
> 	DECLARE_LIBBPF_OPTS(bpf_tc_hook, tc_hook, .attach_point = BPF_TC_INGRESS|BPF_TC_EGRESS);
> 
> 	bpf_tc_hook_create(&tc_hook);
> 	if (igr_fd >= 0) {
> 		tc_hook.attach_point = BPF_TC_INGRESS;
> 		...
> 	}
> 	if (egr_fd >= 0) {
> 		tc_hook.attach_point = BPF_TC_EGRESS;
> 		...
> 	}
> }
> 
> Or is it just me?

I agree with you, it will be better this way. I'll do it in V2.


Best regards,
Bastien

