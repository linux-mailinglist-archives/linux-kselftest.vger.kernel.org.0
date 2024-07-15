Return-Path: <linux-kselftest+bounces-13716-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D567E930EFA
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jul 2024 09:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95EF22812EA
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jul 2024 07:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809F9143878;
	Mon, 15 Jul 2024 07:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ptRic9PV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B9E33C5;
	Mon, 15 Jul 2024 07:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721029353; cv=none; b=tmUXzX9WRqfr7Hx9qOC8Y1h89ozO4IDqqSLsfAooo7cyMvsr/GxyYTp3QZKbx/UzpyHerLe090IoSCswZruEF+foox+3cSvr9Yt1XEydBgSj/HoyyTAZYtEa7NUPh+j3FnsYQjCh2hi4yQSAiTZPsnqDN7VEG6JC1IsGiPayNEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721029353; c=relaxed/simple;
	bh=EL/EnjA7Q6yLjOznAJXHadHPSivUgS3vUfItbwORD3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=faUGcn0E00ZdULPU0RqbuCCci0N8iq4mqZvdVSuuAjlwJXe0O9dkZ5Zo9TZNl9rO+H7YD1v35Mju7zdorttZLzZKht022iSU3i9zb1b9WHlLsL1l6c/uC0WaJsJCTbp+LcFU71pxVeCE7PrZtaiad2fcCzjIJ82UFX4UnKoc7UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ptRic9PV; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 82D8F1C0004;
	Mon, 15 Jul 2024 07:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1721029341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8vzX8nU5lrzqIX2SRywegQj7ulo3keq7VTkALYgs36g=;
	b=ptRic9PVeSGiN1Wq5nBAKXah+dKKzS5wmI5MqC+liP2YQhlbllNIOUL7W6JEtm4s+8/55J
	xIwY3k/jpnfH80GoWePLk4qCxMTSc75oIhpDYeF/VQeKz680bRTRIwq3ntKC3BP3P5jC3g
	W6jv9RFLa9ojhOJgAOcNZ5kA0unpiH4hcz9om0gnKQD5j2Mamg+Loup1K1puEfs53pVjQn
	M03QSpP9+0+TzC7Wex/V4np2P811PUT5sbW4xJXq/qtvwNo8XGS/z3u33oLfijsKno6EH+
	R4sFJjsM7cRcaUgRxR0b+nbK9MHTceD4Za80/ILNNJuRFHw42kIjyDSy7AjSjA==
Message-ID: <48581ce1-f141-46ec-86ac-88092e00b967@bootlin.com>
Date: Mon, 15 Jul 2024 09:42:20 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] selftests/bpf: integrate test_xdp_veth into
 test_progs
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, ebpf@linuxfoundation.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20240711-convert_test_xdp_veth-v1-0-868accb0a727@bootlin.com>
 <20240711-convert_test_xdp_veth-v1-2-868accb0a727@bootlin.com>
 <ZpCCjQP3XQeJPpwH@mini-arch>
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Content-Language: en-US
In-Reply-To: <ZpCCjQP3XQeJPpwH@mini-arch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

Hello Stanislas, thanks for the review

On 7/12/24 03:10, Stanislav Fomichev wrote:
> On 07/11, Alexis Lothoré (eBPF Foundation) wrote:
>> test_xdp_veth.sh tests that XDP return codes work as expected, by bringing
>> up multiple veth pairs isolated in different namespaces, attaching specific
>> xdp programs to each interface, and ensuring that the whole chain allows to
>> ping one end interface from the first one. The test runs well but is
>> currently not integrated in test_progs, which prevents it from being run
>> automatically in the CI infrastructure.
>>
>> Rewrite it as a C test relying on libbpf to allow running it in the CI
>> infrastructure. The new code brings up the same network infrastructure and
>> reuses the same eBPF programs as test_xdp_veth.sh, for which skeletons are
>> already generated by the bpf tests makefile.
>>
>> Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>

[...]

>> +static void generate_random_ns_name(int index, char *out)
>> +{
>> +	int random, count, i;
>> +
>> +	count = snprintf(out, NS_NAME_MAX_LEN, "ns%d-", index);
>> +	for(i=0; i<NS_SUFFIX_LEN; i++) {
>> +		random=rand() % 2;
>> +		out[count++]= random ? 'a' + rand() % 26 : 'A' + rand() % 26;
>> +	}
>> +	out[count] = 0;
>> +}
> 
> It's been customary to hard-code netns names for all the tests we have, so
> maybe it's ok here as well?

I indeed wondered if it was really useful to bring this random ns name mechanism
from the shell script, but I saw that it has been brought by the dedicated
commit 9d66c9ddc9fc ("selftests/bpf/test_xdp_veth: use temp netns for testing"),
so I assumed that some real issues about static ns names were encountered and
led to this fix. Maybe it is indeed enough if I hardcode ns names but not with a
too generic prefix ?

> 
>> +static int attach_programs_to_veth_pair(struct skeletons *skeletons, int index)
>> +{
>> +	struct bpf_program *local_prog, *remote_prog;
>> +	struct bpf_link **local_link, **remote_link;
>> +	struct nstoken *nstoken;
>> +	struct bpf_link *link;
>> +	int interface;
>> +
> 
> [..]
> 
>> +	switch(index) {
> 
> Can you pls run the patch through the checkpatch.pl? The formatting
> looks wrong, should be 'switch (index)'. Applies to 'if()' elsewhere as
> well.

Crap, I forgot this very basic part, my bad, I'll fix all those small issues.


> [..]
> 
>> +		snprintf(cmd, IP_CMD_MAX_LEN, "ip netns del %s", config[i].namespace);
>> +		system(cmd);
> 
> SYS_NOFAIL to avoid separate snprintf?

[...]

>> +static int check_ping(struct skeletons *skeletons)
>> +{
>> +	char cmd[IP_CMD_MAX_LEN];
>> +
>> +	/* Test: if all interfaces are properly configured, we must be able to ping
>> +	 * veth33 from veth11
>> +	 */
>> +	snprintf(cmd, IP_CMD_MAX_LEN,
>> +			 "ip netns exec %s ping -c 1 -W 1 %s > /dev/null",
>> +			 config[0].namespace, IP_DST);
>> +	return system(cmd);
> 
> SYS_NOFAL here as well?

Thanks for the tip, I'll use this macro.
> 
> Btw, not sure it makes sense to split that work into 3 patches. After
> you first patch the test is broken anyway, so might as well just delete
> the script at that point...

I have made sure that the sh script still runs correctly even after renaming the
sections in the xdp program. But indeed, maybe I can squash the new test patch
and the shell scrip deletion patch.

Thanks,

Alexis

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


