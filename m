Return-Path: <linux-kselftest+bounces-23753-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CBE9FCB88
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Dec 2024 16:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B611161801
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Dec 2024 15:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C74487BE;
	Thu, 26 Dec 2024 15:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b="slMx5ygn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o5TPm9Ee"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow-a1-smtp.messagingengine.com (flow-a1-smtp.messagingengine.com [103.168.172.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5BC1E505;
	Thu, 26 Dec 2024 15:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735226535; cv=none; b=edDHTexdG+ikQ0e/u5L7sCoS+FUh983Vg3YPcN7Jd56Rf0PCvmaM2j02850jdOWBRF0bbldyk9Uspx5BXb+0RoXO1Hs+9qtrKB8UNUFz2ifkEhQZLSqG9oLn5XAOEDqFYnCIn0R13tRHaxaK6tbM4Ceiimxh5Qy5YxrKkNAPxRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735226535; c=relaxed/simple;
	bh=TxZEOkvTpkvBYlZZY9Ej4eQOPWlHhFMI0F+giQP2EK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SynZmoEy+QQkAWKzj+t9Dbf9WaYvjlD9hzaBNmKnmIpWizf3Mlk1NoGSSqrhNMVCL1uB1Qq/SR8ycI45/x+NCfQZt3nlSKW1Fiz46padunR5Au25HBJXWAaX5Td0SIBdicHiVtRByQy5a2WvkSdwQEZZ/1dliL/91YqxhHQY8EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name; spf=pass smtp.mailfrom=coelacanthus.name; dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b=slMx5ygn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o5TPm9Ee; arc=none smtp.client-ip=103.168.172.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coelacanthus.name
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailflow.phl.internal (Postfix) with ESMTP id 6B5CC20009E;
	Thu, 26 Dec 2024 10:22:12 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 26 Dec 2024 10:22:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	coelacanthus.name; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1735226532; x=1735233732; bh=9PBKThwQsC
	oEBMlVcV0YVOAr01r6Wd75FiktQTX+myg=; b=slMx5ygnGbiyl8uSIv2ltHyVtz
	mWmBhApz/1RcdlZfXiGE+rlSriu+fGIohAeYxnXTTk1Ktr7Dv8CZ9Sl32sl5ikb2
	1FKfNQirexvBslVcGKdWt9MfTjDEMJF8jVbMCRsRlb8k3NVC6aqlUxnamyeynDSZ
	VcPDwcw8eDSKs5bXHt6VvGi0FTSTxGdRG04hUYkAvNL8+auobIgnkv/eJDJjHCxd
	vLKuJ0WOmktc1s9OQ9hSTc5QMQYtfXvpYJGjeVc4K/7dsh6PV272fTQJN5UF9CDi
	cuPAwyryc0bq+ELSeeaITALSbFpxnzrSkGMyEV8BRdCYPTGrdj5TDQtxDvfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735226532; x=
	1735233732; bh=9PBKThwQsCoEBMlVcV0YVOAr01r6Wd75FiktQTX+myg=; b=o
	5TPm9EepmWxpQrNJUBAwYAbA569TwbzrWANHvYfkSNxykudSN3vTFjopqqpmyMGC
	bgM91TZ7EB3rUqTzKfPKtLsYK1zzEZnAvw1PIH1YtXWjb7xz9mzOZqOo3e1T51MC
	rbbo99gscWs6w8FBCQdE+dF4nK8DlnMVT09wG5ey4vCg85LV0MVuu8ywhOUdlIfe
	boKqvRvZj880z7/rwWmD3twrEQsfiUnTmpzsUcrD3YUiLR73PXMGNtdXPNeUPIkC
	zY8E3PYgOeZEa6TBJKWL/1fZxh/gNfV//Vv5GJ3tqpCz/ekpGjeA2YX6X0dbRg9Q
	embWtt+EJ6wIi2+TcG5Ww==
X-ME-Sender: <xms:onRtZya4uA9TbtofOk_tgS8LFXWjhDUx4y1F9HaiMP2EG388Ta2N9w>
    <xme:onRtZ1aoFqaHxASIa7BU4U6YkQTe8FkxJym4TRbVkFh_hJHUdy1zgExpFJKBm55lO
    94rmNQnkeZAbUzvWe8>
X-ME-Received: <xmr:onRtZ89Ii81TnUZarIxP43FUJMfN7Ev0W65o43UNuWXPZd--jJgymv1fAmbEVGJC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddukedgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdej
    necuhfhrohhmpeevvghlvghsthgvucfnihhuuceouhifuhestghovghlrggtrghnthhhuh
    hsrdhnrghmvgeqnecuggftrfgrthhtvghrnhepfefhfeefteekgedvfeehhfefvedutedt
    fefhkeeileehgefgveffvdffudehhfeknecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepuhifuhestghovghlrggtrghnthhhuhhsrdhnrghmvgdp
    nhgspghrtghpthhtohepvdeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlug
    hvsehsthhrrggtvgdrihhopdhrtghpthhtohepohhlvghgsehrvgguhhgrthdrtghomhdp
    rhgtphhtthhopehprghulhdrfigrlhhmshhlvgihsehsihhfihhvvgdrtghomhdprhgtph
    htthhopehprghlmhgvrhesuggrsggsvghlthdrtghomhdprhgtphhtthhopegvsghivggu
    vghrmhesgihmihhsshhiohhnrdgtohhmpdhrtghpthhtohepkhgvvghssehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehshhhurghhsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegrohhusegvvggtshdrsggvrhhkvghlvgihrdgvughupdhrtghpthhtoheprghlvgigse
    hghhhithhirdhfrh
X-ME-Proxy: <xmx:onRtZ0pmb43OtIMqWtAGWlPjTS-aD-4bTDF1TXUn0COAgu4_QCxfvg>
    <xmx:onRtZ9rN0AK5oO_-8CwpnAZpUT1MfF0DUGcGVitEfDNx26GhKfebiA>
    <xmx:onRtZyQeuB2PJbgdd3sL2bM6xrBuPhkl7g8JceIp8uVdx0h1leKIUw>
    <xmx:onRtZ9q-RoZK6qW4ron4QxAs3P2emewkSm7j7qXvwaIM0Ad7aOsyPA>
    <xmx:pHRtZ0579C5CDjuePJ7TWSFYoqX46UcqNQ2LkpVyXgxiDG_n3V6nwOwz>
Feedback-ID: i95c648bc:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Dec 2024 10:22:01 -0500 (EST)
Message-ID: <2e09aedc-44ba-40e3-ae93-1d6dc21b5eb1@coelacanthus.name>
Date: Thu, 26 Dec 2024 23:21:59 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] riscv: selftests: Add a ptrace test to verify
 syscall parameter modification
Content-Language: en-GB-large
To: "Dmitry V. Levin" <ldv@strace.io>
Cc: Oleg Nesterov <oleg@redhat.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Andrea Bolognani <abologna@redhat.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ron Economos <re@w6rz.net>,
 Charlie Jenkins <charlie@rivosinc.com>,
 Andrew Jones <ajones@ventanamicro.com>, Quan Zhou <zhouquan@iscas.ac.cn>,
 Felix Yan <felixonmars@archlinux.org>, Ruizhe Pan <c141028@gmail.com>,
 Guo Ren <guoren@kernel.org>, Yao Zi <ziyao@disroot.org>,
 Eugene Syromyatnikov <evgsyr@gmail.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>
References: <20241226-riscv-new-regset-v4-0-4496a29d0436@coelacanthus.name>
 <20241226-riscv-new-regset-v4-2-4496a29d0436@coelacanthus.name>
 <20241226133459.GA30481@strace.io>
From: Celeste Liu <uwu@coelacanthus.name>
In-Reply-To: <20241226133459.GA30481@strace.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 2024-12-26 21:35, Dmitry V. Levin wrote:
> On Thu, Dec 26, 2024 at 06:52:52PM +0800, Celeste Liu wrote:
>> This test checks that orig_a0 allows a syscall argument to be modified,
>> and that changing a0 does not change the syscall argument.
>>
>> Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
>> Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
>> Co-developed-by: Charlie Jenkins <charlie@rivosinc.com>
>> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
>> Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
>> Signed-off-by: Celeste Liu <uwu@coelacanthus.name>
> [...]
>> diff --git a/tools/testing/selftests/riscv/abi/ptrace.c b/tools/testing/selftests/riscv/abi/ptrace.c
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..023695352215bb5de3f91c1a6f5ea3b4f9373ff9
>> --- /dev/null
>> +++ b/tools/testing/selftests/riscv/abi/ptrace.c
> [...]
>> +	if (ptrace(PTRACE_GET_SYSCALL_INFO, pid, PTRACE_SYSCALL_INFO_ENTRY, &syscall_info_entry))
>> +		perr_and_exit("failed to get syscall info of entry\n");
>> +	result->orig_a0 = syscall_info_entry->entry.args[0];
>> +	if (ptrace(PTRACE_GET_SYSCALL_INFO, pid, PTRACE_SYSCALL_INFO_EXIT, &syscall_info_exit))
>> +		perr_and_exit("failed to get syscall info of exit\n");
>> +	result->a0 = syscall_info_exit->exit.rval;
> 
> I'm sorry but this is not how PTRACE_GET_SYSCALL_INFO should be used.
> 
> PTRACE_GET_SYSCALL_INFO operation takes a pointer and a size,
> and in this example instead of size you pass constants 1 and 2, which
> essentially means that both syscall_info_entry->entry.args[0] and
> syscall_info_exit->exit.rval are not going to be assigned
> and would just contain some garbage from the stack.
> 
> Also, PTRACE_GET_SYSCALL_INFO operation returns the number of bytes
> available to be written by the kernel, which is always nonzero on any
> PTRACE_GET_SYSCALL_INFO-capable kernel.  In other words, this example
> will always end up with perr_and_exit() call.
> 
> I wonder how this test was tested before the submission.

Oops... It seems I forget sync the code to test board so it runs with the old code...
The code is completely not tested...
I'm so sorry for my mistake.

I will correct it and test it carefully later...

> 
> 


