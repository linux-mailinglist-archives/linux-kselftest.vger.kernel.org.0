Return-Path: <linux-kselftest+bounces-14389-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 228D893FC98
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 19:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FA691F22D98
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 17:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB39161321;
	Mon, 29 Jul 2024 17:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ReAUEGxt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D551586DB;
	Mon, 29 Jul 2024 17:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722275234; cv=none; b=FuE0q0vkoCFDNHDi2Dr5HonINbxaI4Yqmdg0hAmoflW/Sp2uU4rPpfFejKVKO4ckMSIAhxtmoROSZ8Bm9xeV7M0cphY1+yMiEcfuAsZEpxt+mlzWToK6sB/pkh5ARmL7zadmuL78l8Hg0lg6V12iVQhkMMB7atMQ1vN1M0QVqbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722275234; c=relaxed/simple;
	bh=7Om3ODn9VgUsv6KoF/UQ6Qe4kCE3KXW2IjsBgTVvlZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D6a519B113G+LLEdreguVXtPkzNVZpsic4YlSQNAW3mWKYMPUpNiSlXzY5PKfu5y2xZb37smzIfCMN5czC+twWqOl/tuU3P0ZagjoxL4ZZq49mbtNo8FX6M47kuwyB6xCacOiK6Yhb08S/CcITDK3u9W7B9oLRmtC+67c5npDz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ReAUEGxt; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0FDEC240004;
	Mon, 29 Jul 2024 17:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722275227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U7fNaR3Si9Hb8iaQsNpePBd6lFS0aqRooFO9ICBRT6I=;
	b=ReAUEGxtlZGTFRnKKv+eQmmuWANOKIM8OrRr4qBPC9rm6/VgnHeX4EIqucyK9jfNBG5i4w
	2kgzXlgk9h5m3oT+ebpnbJSDbUMoqTbAogMBj07ehK0yQBe+QerolhoOVNU1xlRpaaLI89
	VkE467iO8OZuuVhS2Um2m6sQiEK4sXETyUu2Kl58OE10Lzz7ExxtO7VrbPyYDhPlyk6sCz
	ZKREfirGXAw6cHnxy7D2JiVTs4oueVL04zrr/KBT35iNX4pmeOf0ee41xepRAYUIGKybCt
	KuTn/jZIBHoTWpMdrxXRukAYOaL2hJklCoCO2ieNJV5nfHVANivZmpGb2LgbKQ==
Message-ID: <87d70267-0305-4f4d-a7e2-7d1f8855e14c@bootlin.com>
Date: Mon, 29 Jul 2024 19:47:05 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 2/3] selftests/bpf: convert test_dev_cgroup to
 test_progs
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
 <thomas.petazzoni@bootlin.com>, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240729-convert_dev_cgroup-v2-0-4c1fc0520545@bootlin.com>
 <20240729-convert_dev_cgroup-v2-2-4c1fc0520545@bootlin.com>
 <30ef4e63-02be-4691-b85b-e98c18d59e57@oracle.com>
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Content-Language: en-US
In-Reply-To: <30ef4e63-02be-4691-b85b-e98c18d59e57@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

Hello Alan, thanks for the review

On 7/29/24 19:29, Alan Maguire wrote:
> On 29/07/2024 09:20, Alexis Lothoré (eBPF Foundation) wrote:
>> test_dev_cgroup is defined as a standalone test program, and so is not
>> executed in CI.
>>
>> Convert it to test_progs framework so it is tested automatically in CI, and
>> remove the old test. In order to be able to run it in test_progs, /dev/null
>> must remain usable, so change the new test to test operations on devices
>> 1:3 as valid, and operations on devices 1:5 (/dev/zero) as invalid.
>>
>> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
> 
> A few small suggestions but looks great!
> 
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

[...]

>> +	unlink(path);
>> +	ret = mknod(path, mode, makedev(dev_major, dev_minor));
>> +	ASSERT_EQ(ret, expected_ret, "mknod");
> no need to unlink unless "if (!ret)"

Indeed, you are right.

[...]

>> +	skel = dev_cgroup__open_and_load();
>> +	if (!ASSERT_OK_PTR(skel, "load program"))
>> +		goto cleanup_cgroup;
>> +
>> +	if (!ASSERT_OK(bpf_prog_attach(bpf_program__fd(skel->progs.bpf_prog1),
>> +				       cgroup_fd, BPF_CGROUP_DEVICE, 0),
>> +		       "attach_program"))
> 
> I'd suggest using bpf_program__attach_cgroup() here as you can assign
> the link in the skeleton; see prog_tests/cgroup_v1v2.c.

Ah yes, thanks for the hint !


>> +		goto cleanup_progs;
>> +
>> +	if (test__start_subtest("deny-mknod"))
>> +		test_mknod("/dev/test_dev_cgroup_zero", S_IFCHR, 1, 5, -EPERM);
>> +
> 
> nit: group with other deny subtests.

ACK

>> +	if (test__start_subtest("allow-mknod"))
>> +		test_mknod("/dev/test_dev_cgroup_null", S_IFCHR, 1, 3, 0);
>> +
>> +	if (test__start_subtest("allow-read"))
>> +		test_read("/dev/urandom", buf, TEST_BUFFER_SIZE, TEST_BUFFER_SIZE);
>> +
> 
> Nit: should we have a separate garbage buffer for the successful
> /dev/urandom read? We're not validating buffer contents anywhere but we
> will overwrite our test string I think and it'll end up non-null terminated.

True, but since the tests aren't performing any string operation on it, is it
really a big deal ? I can even switch the string to a byte array, if it can
prevent any mistake.

If that's ok for you, I can bring all the suggestions discussed here in a new
revision and keep your review tag.

Thanks,

Alexis

> 
> Alan

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


