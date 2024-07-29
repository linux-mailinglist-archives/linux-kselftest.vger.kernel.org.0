Return-Path: <linux-kselftest+bounces-14387-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D612493FC74
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 19:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81D0D1F22513
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 17:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDB8158D8F;
	Mon, 29 Jul 2024 17:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ohmjf8bF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332501474CE;
	Mon, 29 Jul 2024 17:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722274262; cv=none; b=uIIMZ2pvmcYAtXT8ixBit5bIW5s/yvqVlo71ayTT3/i6n/zYLwRX2+F8fLwq+p2FYJjWMmpMYs2s6R7hC/14dGybeyj8jmNYntd3U7/vMpIp9y/XMDaU9EU1Etr6FZHPL3QI5reOseDNERfNBPZTmobTzx6NuRxw5df1xExB4Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722274262; c=relaxed/simple;
	bh=CdtaVd7VIIR571BkU5/kSKOE6N/pPDBG2KYvS0kLzRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gGyIPBt6Yz1wgMCKPNx7e6ppRXmegsdIOtjYZKvLvKla4HrFnbEKEABmwYtHdQDEX75K00pmBM8Ao1x1E/XcC/js0q1EKU81EU05611/Or5L0YH+Gaa9a9ZYhndnsmMvUz3xm/11A/qRFNo8MRlEcZFuTtQFtgAbUkOTiTTVzaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ohmjf8bF; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2E61B60005;
	Mon, 29 Jul 2024 17:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722274257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4gDdxM3hNuzMN/4oidvNm3a7yUBz8RIoBl8u5J8ULOk=;
	b=ohmjf8bFsBx8v9MtElenq1aRpkn3MsIk8FwhnZe3aBIOmwnqV/YyCYK84QnoOsQyjBD1in
	L0c6rKYfpMwjhwqWGEUoNYwsmHrkqYoLFjgbMMF4V0soyEiqlvVrSoZ8AgfbYpDGkc7Nof
	A65rIo/pV04c9hG3308ASfFBlB1ZJYksLi/PBfGH+kOH4GkIA8Smq10dl+B3BbgK410TzM
	PICqrPT6MvWpc2SS9rUCaR1KuT/G3R9XqCqzgXK/LnVTssA5sQ6nWukJwSAb0sVcXH+HVa
	jnrLar3+rZ6n8tDKQl4Y6jDJjcivJzm/KVe59VLMEJzCfpT1CP23q8WKMlEPpA==
Message-ID: <3d809ae0-d228-4ba0-baa4-c1b299024c55@bootlin.com>
Date: Mon, 29 Jul 2024 19:30:55 +0200
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
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Content-Language: en-US
In-Reply-To: <39781c99-95db-4c48-b363-a482a426e3b0@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

Hello Alan,

On 7/29/24 18:59, Alan Maguire wrote:
> On 29/07/2024 09:20, Alexis Lothoré (eBPF Foundation) wrote:
>> test_dev_cgroup currently loads a small bpf program allowing any access on
>> urandom and zero devices, disabling access to any other device. It makes
>> migrating this test to test_progs impossible, since this one manipulates
>> extensively /dev/null.
>>
>> Allow /dev/null manipulation in dev_cgroup program to make its usage in
>> test_progs framework possible. Update test_dev_cgroup.c as well to match
>> this change while it has not been removed.
>>
>> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
>> ---
>>  tools/testing/selftests/bpf/progs/dev_cgroup.c |  4 ++--
>>  tools/testing/selftests/bpf/test_dev_cgroup.c  | 18 +++++++++---------
> 
> Not a big deal, but I found it a bit confusing that this file was
> modified then deleted in patch 2. Would it work having patch 1 stop
> building the standalone test/remove it and .gitignore entry, patch 2
> updating progs/dev_cgroup.c to allow /dev/zero, /dev/urandom access,
> patch 3 add cgroup_dev.c test support, and patch 4 add the device type
> subtest? Or are there issues with doing things that way? Thanks!

I've done this to make sure that at any point in the git history, there is one
working test for the targeted feature, either the old or the new one. I've done
it this way because the old test also helped me validate the new one while
developing it, but also because if at some point there is a (major) issue with
the new test, reverting only the relevant commit brings back the old test while
disabling the new one.

But maybe this concern is not worth the trouble (especially since the old tests
are not run automatically) ? If that's indeed the case, I can do it the way you
are suggesting :)

Thanks,

Alexis

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


