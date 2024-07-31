Return-Path: <linux-kselftest+bounces-14574-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 409FA943662
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 21:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE40E284462
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 19:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A55714D70E;
	Wed, 31 Jul 2024 19:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="T69FbPm9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8078F219FF;
	Wed, 31 Jul 2024 19:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722454066; cv=none; b=Aq9p/mVOf7YPBYvHPa5wi78I9doX39YAoWcmt4frjsmRmW6qezB4q5qhF66pwfXHglmvOplyU9/Yi1AbMOvex1ErjrHB8V+MC5lgLkx0hQzP05WPh3QoTiC9mcC2DIJhDhoTm4Bks0P8/HOfiNPrxIwKR/TmZBEIshTOEygipCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722454066; c=relaxed/simple;
	bh=NQ4zOAgDS+g0eFTvmmGPXEvyIAmBQb+Oa6VhLGuQzyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ecACK5tHDpKfqeSc2GnH2WcKHy688rZAIkEtVEHGCLjE6P9KehQHuefz+8VbAMSy3dygsRem60nrmBXcVGlaGs6jYjkat0S072rCou3/MTTd8l8xyjrtfSNZFdbq4Ks6URP/8/hRgB+N1OfoD7JOKM4u8ICspbA6VQb2HMUKV5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=T69FbPm9; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E5251FF804;
	Wed, 31 Jul 2024 19:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722454054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vmFYIjz7BwroUiQCbjrJtatEglxmooXjM7H6XpOVo64=;
	b=T69FbPm9rWYD8fQ3Gv1ludeIeOPWanqetTYcG7+UeoyFvoY2tSgV1nrUfohLiWvrrrcuFj
	tMSGjI7kYFKBtVKZDHKFCWQsfPyKqi1zr1OCZV5Hs+Gs/5HpSmULuE3bRxjzA7X9DLblhh
	1X9mehuV7aHYnIkgxiFdnApBeNOAozDPrZOz6s5UF878PPafBc/zNYc8WbkM8b0tjMny7B
	pE1R96vOgQuOd6762kkjLzib06fMXpexslX6e1AlqziabENFz5ZlGjAb06wwbbLRSlZ72x
	nwR60GWPh1Gvl/ag67OP/pcih3UliFplucVeeH9KDoTi0nRZvWaXioa7W72wzw==
Message-ID: <c405781e-1ada-4f93-8d12-3d532eaeb4a0@bootlin.com>
Date: Wed, 31 Jul 2024 21:27:32 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 0/3] selftests/bpf: convert test_dev_cgroup to
 test_progs
To: patchwork-bot+netdevbpf@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
 shuah@kernel.org, ebpf@linuxfoundation.org, thomas.petazzoni@bootlin.com,
 alan.maguire@oracle.com, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240731-convert_dev_cgroup-v4-0-849425d90de6@bootlin.com>
 <172245123319.23492.11789565242662835897.git-patchwork-notify@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
In-Reply-To: <172245123319.23492.11789565242662835897.git-patchwork-notify@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

On 7/31/24 20:40, patchwork-bot+netdevbpf@kernel.org wrote:
> Hello:
> 
> This series was applied to bpf/bpf-next.git (master)
> by Martin KaFai Lau <martin.lau@kernel.org>:
> 
> On Wed, 31 Jul 2024 08:37:24 +0200 you wrote:
>> Hello,
>> this small series aims to integrate test_dev_cgroup in test_progs so it
>> could be run automatically in CI. The new version brings a few differences
>> with the current one:
>> - test now uses directly syscalls instead of wrapping commandline tools
>>   into system() calls
>> - test_progs manipulates /dev/null (eg: redirecting test logs into it), so
>>   disabling access to it in the bpf program confuses the tests. To fix this,
>>   the first commit modifies the bpf program to allow access to char devices
>>   1:3 (/dev/null), and disable access to char devices 1:5 (/dev/zero)
>> - once test is converted, add a small subtest to also check for device type
>>   interpretation (char or block)
>> - paths used in mknod tests are now in /dev instead of /tmp: due to the CI
>>   runner organisation and mountpoints manipulations, trying to create nodes
>>   in /tmp leads to errors unrelated to the test (ie, mknod calls refused by
>>   kernel, not the bpf program). I don't understand exactly the root cause
>>   at the deepest point (all I see in CI is an -ENXIO error on mknod when trying to
>>   create the node in tmp, and I can not make sense out of it neither
>>   replicate it locally), so I would gladly take inputs from anyone more
>>   educated than me about this.
>>
>> [...]
> 
> Here is the summary with links:
>   - [bpf-next,v4,1/3] selftests/bpf: do not disable /dev/null device access in cgroup dev test
>     https://git.kernel.org/bpf/bpf-next/c/ba6a9018502e
>   - [bpf-next,v4,2/3] selftests/bpf: convert test_dev_cgroup to test_progs
>     https://git.kernel.org/bpf/bpf-next/c/d83d8230e415
>   - [bpf-next,v4,3/3] selftests/bpf: add wrong type test to cgroup dev
>     https://git.kernel.org/bpf/bpf-next/c/84cdbff4a935
> 
> You are awesome, thank you!

For the record, I am not receiving the notification about my patches being
merged (well, I receive it at least thanks to the mailing list, but not as the
author). I see that my email address looks pretty broken in the recipient field.
Could patchwork automation be confused by "customized" identity ?

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


