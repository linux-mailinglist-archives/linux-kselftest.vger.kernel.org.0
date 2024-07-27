Return-Path: <linux-kselftest+bounces-14293-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E16993DDBB
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jul 2024 09:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 926AE1C21847
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jul 2024 07:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337B738FA5;
	Sat, 27 Jul 2024 07:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="heRvaIr0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A315929406;
	Sat, 27 Jul 2024 07:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722067128; cv=none; b=bAU7nuUIOI0joZPn4mbI+spHsdNVTkzw9zA62xXQ4A9icaSM4QR25pNNx984w08E1LXUVlWuLF9DzEHdq59m+4SGk4ZrL6ZYCIlZxLFGpMwMe4D3WX6gF3KeerrOASPPfRQPZgkzUgmwqwcT2HaJYrvLh+Qh7WxS2cFoqqa46pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722067128; c=relaxed/simple;
	bh=DmIQpTO+/bFZnml12ErnGYWk9fY2KsM1vrj7hx1HAsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jo/Q59m0PZGEhdcpeffADH5uLlHspDSxitd37lz2hjG4BhgU1dDpPwVaxvHFp94Tb9jskd6IXDlgsdzCxNZIjR/hDyDG456bEwntV0awL55WGfskmMRmIGc0hjI29Dgv8qkPfbX4pzi4YxFSJ5VMhnMOZl4fsmrkWzPEN2YfB+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=heRvaIr0; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 86CA01C0004;
	Sat, 27 Jul 2024 07:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722067116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IX0+P3Id008eNk2KpJpmLWSM0D2kf6EvzjpHfL7w4Zo=;
	b=heRvaIr0Pg5ieB2IMkselGgQQqH2MEqiTk9yaMI/foVpXRCCqNBxKkiqHKZutEqiGJvphg
	L32JJXVCIMi6T2UpkiUOc6bAFRUWRAsuCxYS1NKDS7CYtYdFcRP+z+grsrEBEF3Q9XVfA7
	jKTnBn4DjzTPDkHTunddZEmh9KoW8mpbc1UPBxEIdezEV6EuPkhdSVeW7Toyxvec/Z0qGz
	iEOy5GgcHCPPzPwg9XoGV8yE3bDp3rYQU8FXBcqIJjXN6RWavFH74Iqg6l79fX3MQRb1de
	JOhFeOAwAu2ZMECuxnm++lPjBzhlmvkGzxqVCyeJF/aQNQlSf221Mb/4MKVYIw==
Message-ID: <e42a3622-c0a4-4cfd-994e-2261662c1cfd@bootlin.com>
Date: Sat, 27 Jul 2024 09:58:35 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] selftests/bpf: convert test_dev_cgroup to test_progs
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
 ebpf@linuxfoundation.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240725-convert_dev_cgroup-v1-0-2c8cbd487c44@bootlin.com>
 <20240725-convert_dev_cgroup-v1-2-2c8cbd487c44@bootlin.com>
 <ZqQnrxyZ1nT93PLo@mini-arch>
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Content-Language: en-US
In-Reply-To: <ZqQnrxyZ1nT93PLo@mini-arch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

Hello Stanislas, thanks for the review

On 7/27/24 00:48, Stanislav Fomichev wrote:
> On 07/25, Alexis Lothoré (eBPF Foundation) wrote:

[...]

>> +	if (should_fail)
>> +		ASSERT_ERR(ret, "mknod");
>> +	else
>> +		ASSERT_OK(ret, "mknod");
> 
> Optional: might be easier to use something like expected_ret instead
> of should_fail and then do:
> 
> ASSERT_EQ(ret, expected_ret)

Yes, you are right. I initially went with a version relying on system() to
perform the mknods/dd calls, which could return different errors codes so I used
this should_fail. But while debugging some issues in CI with this series, I
realized that the needed commands are basic enough to be replaced with direct
library calls and I forgot to update this part, which can now assert an exact
return value. I will update this accordingly.

> I see this part being copy-pasted in a bunch of places below.
> 
>> +	unlink(path);
>> +}
>> +
>> +static void test_read(const char *path, int should_fail)
>> +{
>> +	char buf[TEST_BUFFER_SIZE];
>> +	int ret, fd;
>> +
>> +	fd = open(path, O_RDONLY);
>> +
>> +	/* A bare open on unauthorized device should fail */
>> +	if (should_fail) {
>> +		ASSERT_ERR(fd, "open file for read");
> 
> [..]
> 
>> +		if (fd)
>> +			close(fd);
> 
> nit: should this be 'if (fd >= 0)'? I'm assuming the intention is to
> avoid close(-1)?

Right as well, I'll fix it (here and below) in v2

Thanks,

Alexis

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


