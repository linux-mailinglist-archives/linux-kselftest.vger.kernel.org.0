Return-Path: <linux-kselftest+bounces-14460-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF4B940BFB
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 10:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B487BB25802
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 08:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3971418FDD7;
	Tue, 30 Jul 2024 08:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OYN4N27H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDD41922F3;
	Tue, 30 Jul 2024 08:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722328931; cv=none; b=R6E7fLwJMx9L24jSSwu2RgMNS37pZPad21Cyb8U0zlvahlbqoIlmWSrKxpU9oWxhlh70BQtbW4FwpZGtK7bOSMiaNoTzvcUf8FAOrXjSYl+FQxj0EnN4DeCv6OkmxtBtwnFwB3s79Mlc5W7ZqxerpLQRVbHdbhKLBlR+aVDQbEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722328931; c=relaxed/simple;
	bh=LMnzgd+Feav2wYV4oglUxLJGBvcpwXxoqyGpw7qOgmM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SLu73/6N4WGbSsJGauXdxO9tEa7D/fZV1hXKwMjHAozSt2lWOWLEZ9NaNUBFQD4PHulD+sd+3wfwHvJmYDdDvCeb6++hMXKVAjR12Ow4Pc1o60XZE11S8CXgPpEvugQZZ+unLUsDpPdvaiVv0gK/1DnDq5gjp6YJ86k/+np0eEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OYN4N27H; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BF7E924000B;
	Tue, 30 Jul 2024 08:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722328925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=onNPQ+wT2NHH+VlsYS0o+kNVGZeHSK/I67IhJY1D0LQ=;
	b=OYN4N27H/vb3J15B5p3qqRZxxtXT/5DGZNqDIwIBW2ZE8cQ9Sl6P2ebyXKBfFHJesPW1sR
	DHlkkqHDn2iuJ2o6xQZO2nswLqnGhYc7b+kcknu5tUjAUnbbfdFPD0I5Rajrgn4X/1MNjg
	sOnwgSD9d762MibFPoGsM8fx/YjaZfVN52I/TZyADb/sCXNPnFic5rKakPG1BPIyXPU8Iv
	LeW56f8MuIJJxHo9idGAdjZVXmJ6MG1AjKToqh1QGT5zE3XieECzonlMGc4t5vUoRznxrB
	g1i2pXvcBRBzZyOs0p+g7zChtaz3xrZs4e0B0lW+cwyevs1Qtaq6EMRjHqKVHA==
Message-ID: <df287de3-8b06-42dd-8353-fae5cffae6a2@bootlin.com>
Date: Tue, 30 Jul 2024 10:42:04 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/3] selftests/bpf: do not disable /dev/null
 device access in cgroup dev test
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
 <20240729-convert_dev_cgroup-v2-1-4c1fc0520545@bootlin.com>
 <39781c99-95db-4c48-b363-a482a426e3b0@oracle.com>
 <3d809ae0-d228-4ba0-baa4-c1b299024c55@bootlin.com>
 <012176d7-646b-49fe-b139-c8072340ecdb@oracle.com>
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Content-Language: en-US
In-Reply-To: <012176d7-646b-49fe-b139-c8072340ecdb@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

On 7/30/24 10:16, Alan Maguire wrote:
> On 29/07/2024 18:30, Alexis Lothoré wrote:
>> Hello Alan,

[...]

>>> Not a big deal, but I found it a bit confusing that this file was
>>> modified then deleted in patch 2. Would it work having patch 1 stop
>>> building the standalone test/remove it and .gitignore entry, patch 2
>>> updating progs/dev_cgroup.c to allow /dev/zero, /dev/urandom access,
>>> patch 3 add cgroup_dev.c test support, and patch 4 add the device type
>>> subtest? Or are there issues with doing things that way? Thanks!
>>
>> I've done this to make sure that at any point in the git history, there is one
>> working test for the targeted feature, either the old or the new one. I've done
>> it this way because the old test also helped me validate the new one while
>> developing it, but also because if at some point there is a (major) issue with
>> the new test, reverting only the relevant commit brings back the old test while
>> disabling the new one.
>>
>> But maybe this concern is not worth the trouble (especially since the old tests
>> are not run automatically) ? If that's indeed the case, I can do it the way you
>> are suggesting :)
>>
> 
> If no-one complains, it seems fine to me to stick with the way you've
> constructed the series the next respin. Thanks!

ACK, thanks, I'll keep it that way then.

For the record, I am accumulating a few other converted tests that I will send
soon, and those follow the same logic (keeping one working test at any point of
time, and pushing it to the point where I start by fixing broken tests before
converting those), so if anyone has an opinion in favor of this or rather in
favor of Alan's suggestion, do not hesitate to share it, so I can adjust before
sending.

Thanks,

> 
>> Thanks,
>>
>> Alexis
>>
> 

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


