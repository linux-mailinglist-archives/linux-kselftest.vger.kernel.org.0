Return-Path: <linux-kselftest+bounces-14572-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE61A9435EA
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 20:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B3481C22943
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 18:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B8712EBDB;
	Wed, 31 Jul 2024 18:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="byDRyuMX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FEB4084E;
	Wed, 31 Jul 2024 18:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722452014; cv=none; b=mieXpRdIz7jfRfugzRH25zf3EJkhBWnofL10zsQaQjooNmX3Aigyaev03uzwKPW+v99aRpAGnHHsQdHdje9UB0uo5TlxUG07WOaEumU6lSvFM8vgWyaMdeM+IiRjFPFQZXnGltytPVjnZZTb8VrnjuAfh8F2En97kgTLK/SAl2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722452014; c=relaxed/simple;
	bh=buUpnDg1F1l0M/Tvk6rpatgsJHyw0PqhGQyFI0jWV6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fB8nyo6g84EIdadEHhRJa0ok9DQ950ejiGa65/bVcSMTjuPoxKx56dzGKCTSh8KH9SZSQHifTITMc+HJktJI0TR2XvMtDjTJ4nUAEX/ADBknJIwaHP3Ewjp4fEFRCJAk0kgNdnQd2qKnE2+RWMjycsyh35NvdxAUFufEuESwRsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=byDRyuMX; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0E33F60003;
	Wed, 31 Jul 2024 18:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722452003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+RwDl/YSl15GSm3QO/xjSVgJYzWaKiDYQt0ysAu1/lc=;
	b=byDRyuMXvLAd8GA90IQiv/5/+RsyV54sSwdDN7CedZEIeijIiRw/GEfMGJmQT/rYIzlwSm
	5QcCIiejRqi682ZECGwr8vD2CHovUCkXoMUkK7D55STCaBMhoGD9yMSkAu1Fk+nL765I9t
	QeSoFKQ2VobkvLho1f4uXi7FfIzZfdIvrOwGc/2+iO+C+aZQKGpjV45mOPrP9Po73qDWZg
	e3Gk4ZEY75wc+8PIhrqU27aWFuhUyyc39VYkKg7i0QilfgK0t3SnRkltIgh2NUKeWJ887Q
	bthXYXpc0HW3mEeUVKneSAbNw0S1DrbA4MyXXJpd2glNGkpDQCkAbmF62G7knA==
Message-ID: <f60d47cc-84ff-4031-a9e6-244954af901e@bootlin.com>
Date: Wed, 31 Jul 2024 20:53:21 +0200
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
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Content-Language: en-US
In-Reply-To: <f54ddf95-a5ab-4c56-966f-9bff37f50364@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

Hello Alan,

On 7/31/24 19:23, Alan Maguire wrote:
> On 31/07/2024 11:38, Alexis Lothoré (eBPF Foundation) wrote:

[...]

>> +	pid = getpid();
>> +	if (!ASSERT_OK(bpf_map__update_elem(skel->maps.pidmap, &key,
>> +					    sizeof(key), &pid, sizeof(pid), 0),
>> +		       "write pid"))
>> +		goto cleanup_progs;
>> +
> 
> I think it would be worth using a global variable in the BPF program
> my_pid, and setting skel->bss->my_pid here as other more up-to-date
> tests do (example progs/test_usdt.c, prog_tests/usdt.c). No need for a
> separate map anymore.

That sounds like a good improvement, thanks for the hint and the example :) I'll
spin a new revision with this, and make sure to use it in my next test
conversion patches too when relevant.

TBH I am not familiar with global variables usage in ebpf/libbpf, so it is not
clear for me when I should prefer it over classic maps. From some quick search I
feel like it should be the default choice when needing basic controls
knobs/feedback on a bpf program from userspace ? Or maybe it should be used even
more broadly by default ?

>> +	/* trigger the syscall on which is attached the tested prog */
>> +	if (!ASSERT_OK(syscall(__NR_nanosleep, &req, NULL), "nanosleep"))
>> +		goto cleanup_progs;
>> +
>> +	if (!ASSERT_OK(bpf_map__lookup_elem(skel->maps.cg_ids, &key,
>> +					    sizeof(key), &kcgid, sizeof(kcgid),
>> +					    0),
>> +		       "read bpf cgroup id"))
>> +		goto cleanup_progs;
>> +
> 
> ditto here, cg_ids could be a global var cg_id that the bpf prog sets
> and we check here via skel->bss->cg_id.

ACK, I'll update this too.

Thanks,

Alexis

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


