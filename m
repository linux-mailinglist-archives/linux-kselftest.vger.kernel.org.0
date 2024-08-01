Return-Path: <linux-kselftest+bounces-14606-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B22CE944736
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 10:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4ABB1C21DE7
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 08:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB5A170A19;
	Thu,  1 Aug 2024 08:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FTGlziMh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295DE170A04;
	Thu,  1 Aug 2024 08:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722502659; cv=none; b=Yb4N82TbnFhKhlrMIWzoU6DmZpeM4vj4vnHk4j0JWPA/WLNvdZCU5v4sp2No7juqutwR5eP9Ta/XuGZm9Cpdm7w229mPGFG0UhCkSzE+dkhOPQ+reALeHYqArWTUXU6pvkGkI0/xUVV2cFX8htxrg8ydgnmLuOBGy0rnd5hevcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722502659; c=relaxed/simple;
	bh=k5VaIutaAbdCNTUxxxN3B3JYAkNM71+Jpw/ngo+ftNQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bg8Mxd7gTsV1WAoMEbioDPrcmFYIn8CvGyav2d4kZl/pyPqxjRc2nJ5gDdkO1zs4m0cf05iW5Mf7zXbnqlK4f9zZzdrSfnCWZT1kAP97kuy8av8EIgawJ/oPRAlo4FkTTfGSbvC5RfP0TCLDil0B0JOpQ4QTkhvDeLJosbfJzos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FTGlziMh; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EDFD040009;
	Thu,  1 Aug 2024 08:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722502654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3WsXu4DF188KRUc+keQqY5t0HhVNNFj4+qllkduf6go=;
	b=FTGlziMhNOYWsG4wO3LrWRbe59v6obLoRgt0K7Dk7eP6bEB6xiwoBgqwmm0JCPLBhTkTD6
	MrH7/pZ/enn4PFdja31VufJ0kekMOUusqzNZ3+l2MJYXFdliwwul1Yj1Am/pok1q1qpdXk
	22UX13wMhKuHnhUQ6R83B3OlqBkktutK0+skgMOafEMfffGFGvSqFF7NBGc8jnN0qoSAaF
	aD4mauoyrntX443wXXaCpjdcC3EP6W5xN0b8butXab818/kYzFjkr37hHqV0d/DpUe7bRp
	aIgcbVH027sxjaJYEsxAJvE8JmlqW3Ub3D4SgCsWhZMbBFLchW1O7GCWDGp4Uw==
Message-ID: <aa7a0a5e-7dc7-4f72-8bfc-75aafc768dbf@bootlin.com>
Date: Thu, 1 Aug 2024 10:57:28 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/4] selftests/bpf: convert
 get_current_cgroup_id_user to test_progs
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
 <20240731-convert_cgroup_tests-v1-1-14cbc51b6947@bootlin.com>
 <f54ddf95-a5ab-4c56-966f-9bff37f50364@oracle.com>
 <f60d47cc-84ff-4031-a9e6-244954af901e@bootlin.com>
 <c5a9033b-8f47-4ae8-97ca-75c70bce88cd@oracle.com>
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Content-Language: en-US
In-Reply-To: <c5a9033b-8f47-4ae8-97ca-75c70bce88cd@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

Hello Alan,

On 8/1/24 10:17, Alan Maguire wrote:
> On 31/07/2024 19:53, Alexis Lothoré wrote:
>> Hello Alan,
>>
>> On 7/31/24 19:23, Alan Maguire wrote:
>>> On 31/07/2024 11:38, Alexis Lothoré (eBPF Foundation) wrote:
>>
>> [...]
>>
>>>> +	pid = getpid();
>>>> +	if (!ASSERT_OK(bpf_map__update_elem(skel->maps.pidmap, &key,
>>>> +					    sizeof(key), &pid, sizeof(pid), 0),
>>>> +		       "write pid"))
>>>> +		goto cleanup_progs;
>>>> +
>>>
>>> I think it would be worth using a global variable in the BPF program
>>> my_pid, and setting skel->bss->my_pid here as other more up-to-date
>>> tests do (example progs/test_usdt.c, prog_tests/usdt.c). No need for a
>>> separate map anymore.
>>
>> That sounds like a good improvement, thanks for the hint and the example :) I'll
>> spin a new revision with this, and make sure to use it in my next test
>> conversion patches too when relevant.
>>
>> TBH I am not familiar with global variables usage in ebpf/libbpf, so it is not
>> clear for me when I should prefer it over classic maps. From some quick search I
>> feel like it should be the default choice when needing basic controls
>> knobs/feedback on a bpf program from userspace ? Or maybe it should be used even
>> more broadly by default ?
>>
> 
> Yeah, it's certainly what I use by default, unless I need multiple
> instances of an object. Under the hood, the BPF skeleton creates
> single-element array maps for .bss, .data and .rodata sections which
> contain all the initialized, uninitialized and constant globals in the
> BPF object and mmaps() them so you can read/update the values in
> userspace via skel->bss/skel->data without needing a map-related syscalls.

Thanks a lot for the additional details, much appreciated :)

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


