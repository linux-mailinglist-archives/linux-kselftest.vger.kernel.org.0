Return-Path: <linux-kselftest+bounces-24302-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0680AA0A84F
	for <lists+linux-kselftest@lfdr.de>; Sun, 12 Jan 2025 11:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E18A7A31D9
	for <lists+linux-kselftest@lfdr.de>; Sun, 12 Jan 2025 10:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25871990DB;
	Sun, 12 Jan 2025 10:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b="ph2OkD71";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q1z/HPfC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow-b2-smtp.messagingengine.com (flow-b2-smtp.messagingengine.com [202.12.124.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DF319CC0A;
	Sun, 12 Jan 2025 10:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736678526; cv=none; b=A1HvReypL7lCCLdfIrnenmtRPb617xq+9rxlXvbM/nuhAsK9MySyuFqyZ9C/hE2nNBCrOarFvnhcBslfbRtf7G2N6LwKtVglnahEWOML4yJR5zKe+ZPip64P7K5SWjL7PtRvmE8WdGJZdNwe5DpZ+bzQzFG3KfhBZfZAqmAT+1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736678526; c=relaxed/simple;
	bh=UylQ7hbe4mvYcKxM8lJiBMUtP4NwfWTA1XOCBBEM710=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g9qKoVKwUcl3KvZfkwuHOjj4Zn8J/y0iH1IwhF8ZbHC162oauFbLWcFFNoTX+k9cQDoy1O4hf8Z8Ot5hMW3PFanQuhGDlBodZGOVOQ9z065pQr24W6EoVdIYo8yWNB7y+MpVL0Z2rLNRiA37N/6L4MaF7j/HGjJGOV1Cy9XnVu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name; spf=pass smtp.mailfrom=coelacanthus.name; dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b=ph2OkD71; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q1z/HPfC; arc=none smtp.client-ip=202.12.124.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coelacanthus.name
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailflow.stl.internal (Postfix) with ESMTP id 4F0DF1D40AA4;
	Sun, 12 Jan 2025 05:42:02 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sun, 12 Jan 2025 05:42:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	coelacanthus.name; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1736678522; x=1736685722; bh=oaDf/Ac90E
	bejoB/UI1UVChf0YVbXYbpJL+sA5TcwZA=; b=ph2OkD71U6adFSgvCCpweFwQ1u
	ksLpq9skHD0NkR8SWwZaDBvVR/1bzMZbCtABSHPQOQ5F7X5nnDU2x6Sd24UxW0Hv
	F8Of8CWWpECV4frNAjMiwr/MQm2dsxKP4aPwHyds+qdXSfZias6aAk2l8FV/fy+l
	AM0FfqCqzCmTxRFd9ldYQNdRB73BDrjPkSD7qVtKsXTjmSLzA9PT0rcErWBIdhnY
	olz/EhS7L4XICp/7nzhz55P2mEmcV3gKPdTKjtNu4iag1nI+rRK7UKEplugCnoBi
	b6BnWypqnUvztKn/IS5RmncLM+n5KHyV1lYWfLjX+SYxn1Uo7qOTifESXGJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736678522; x=
	1736685722; bh=oaDf/Ac90EbejoB/UI1UVChf0YVbXYbpJL+sA5TcwZA=; b=q
	1z/HPfC5wlgKu1dvVWJdLaRsgHPdXHotzZJ5o1fB8vAVQ+h9V2BDjngziPYn1VNt
	84c/qZLWkCKSqbQfKV/dWei8IHTEZfF5f+3sVKQwG+9gz75ig/T3weSknkMmtuDr
	2mDuIYlK2H5Hbmv6YxvZiva+B5tKPK0AD3peJDbUVem5ef53Hwt2wgMnfvMLoVGP
	O9tI6YrZgITmi9E7moVRtzAgb3p8cgoA+t08IMfVt0yD1jbsjRc2AmaorIVUu5W0
	HRuRc7+RxB+ROWZJ+IJj3iSydC9j5OgwcvzfglRqyuW2E/dC8Xd7+zTeWAlMFLyE
	4ZKkRVIkGDu25EFvwewVQ==
X-ME-Sender: <xms:eJyDZ2RG0QfEE5sJzrKmOa3GKMYNSTar3cymEzku1I4-M1QsaGaXBg>
    <xme:eJyDZ7zsfj3PcfHw8oDBarFmECKDPz7r-n2iYpRt-kkflmD80VAzq7DbSEDSySZJ-
    H0qOnV1FycnAV-_zYs>
X-ME-Received: <xmr:eJyDZz0MbHSWNCu0n3_M68QX8nPAtUFmjt_d4b8KwENphPmMWnvmzW3NKZkpQKIb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehvddgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdej
    necuhfhrohhmpeevvghlvghsthgvucfnihhuuceouhifuhestghovghlrggtrghnthhhuh
    hsrdhnrghmvgeqnecuggftrfgrthhtvghrnhepfefhfeefteekgedvfeehhfefvedutedt
    fefhkeeileehgefgveffvdffudehhfeknecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepuhifuhestghovghlrggtrghnthhhuhhsrdhnrghmvgdp
    nhgspghrtghpthhtohepvdefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegthh
    grrhhlihgvsehrihhvohhsihhntgdrtghomhdprhgtphhtthhopehlughvsehsthhrrggt
    vgdrihhopdhrtghpthhtohepohhlvghgsehrvgguhhgrthdrtghomhdprhgtphhtthhope
    hprghulhdrfigrlhhmshhlvgihsehsihhfihhvvgdrtghomhdprhgtphhtthhopehprghl
    mhgvrhesuggrsggsvghlthdrtghomhdprhgtphhtthhopegvsghivgguvghrmhesgihmih
    hsshhiohhnrdgtohhmpdhrtghpthhtohepkhgvvghssehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehshhhurghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrohhusegvvg
    gtshdrsggvrhhkvghlvgihrdgvughu
X-ME-Proxy: <xmx:eJyDZyBwHxi6hGuPnApGDGL0oR7tdXX2zNO3zrctot6Y2dnA2Q4zzA>
    <xmx:eJyDZ_hB490Z5liCm7rcUr7qePELh2VGdIhiSUMGOzE_LTXCXZwqcA>
    <xmx:eJyDZ-qCjgj1e6N2y82jxhJ9fhZvvt-_xPe19VUSaaUZnl349Verog>
    <xmx:eJyDZyiLobx_jdQIJzud-Ztz92M0ohFxjF3pIG_T3dW9tZN_DqaOfg>
    <xmx:epyDZygjILnW2BAo23eprz0jdRwOKUmmO6ZDU0bbZJ2k3wU6b2s9JzL_>
Feedback-ID: i95c648bc:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 12 Jan 2025 05:41:52 -0500 (EST)
Message-ID: <0b538b70-bc14-4038-a1b2-428192d6f51b@coelacanthus.name>
Date: Sun, 12 Jan 2025 18:41:48 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] riscv: selftests: Add a ptrace test to verify
 syscall parameter modification
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: "Dmitry V. Levin" <ldv@strace.io>, Oleg Nesterov <oleg@redhat.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Eric Biederman <ebiederm@xmission.com>,
 Kees Cook <kees@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Andrea Bolognani <abologna@redhat.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ron Economos <re@w6rz.net>, Andrew Jones <ajones@ventanamicro.com>,
 Quan Zhou <zhouquan@iscas.ac.cn>, Guo Ren <guoren@kernel.org>,
 Eugene Syromyatnikov <evgsyr@gmail.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>
References: <20241226-riscv-new-regset-v4-0-4496a29d0436@coelacanthus.name>
 <20241226-riscv-new-regset-v4-2-4496a29d0436@coelacanthus.name>
 <20241226133459.GA30481@strace.io>
 <2e09aedc-44ba-40e3-ae93-1d6dc21b5eb1@coelacanthus.name>
 <Z4CVQKkViqJycnaq@ghost>
Content-Language: en-GB-large
From: Celeste Liu <uwu@coelacanthus.name>
In-Reply-To: <Z4CVQKkViqJycnaq@ghost>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2025-01-10 11:34, Charlie Jenkins wrote:
> On Thu, Dec 26, 2024 at 11:21:59PM +0800, Celeste Liu wrote:
>>
>> On 2024-12-26 21:35, Dmitry V. Levin wrote:
>>> On Thu, Dec 26, 2024 at 06:52:52PM +0800, Celeste Liu wrote:
>>>> This test checks that orig_a0 allows a syscall argument to be modified,
>>>> and that changing a0 does not change the syscall argument.
>>>>
>>>> Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
>>>> Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
>>>> Co-developed-by: Charlie Jenkins <charlie@rivosinc.com>
>>>> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
>>>> Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
>>>> Signed-off-by: Celeste Liu <uwu@coelacanthus.name>
>>> [...]
>>>> diff --git a/tools/testing/selftests/riscv/abi/ptrace.c b/tools/testing/selftests/riscv/abi/ptrace.c
>>>> new file mode 100644
>>>> index 0000000000000000000000000000000000000000..023695352215bb5de3f91c1a6f5ea3b4f9373ff9
>>>> --- /dev/null
>>>> +++ b/tools/testing/selftests/riscv/abi/ptrace.c
>>> [...]
>>>> +	if (ptrace(PTRACE_GET_SYSCALL_INFO, pid, PTRACE_SYSCALL_INFO_ENTRY, &syscall_info_entry))
>>>> +		perr_and_exit("failed to get syscall info of entry\n");
>>>> +	result->orig_a0 = syscall_info_entry->entry.args[0];
>>>> +	if (ptrace(PTRACE_GET_SYSCALL_INFO, pid, PTRACE_SYSCALL_INFO_EXIT, &syscall_info_exit))
>>>> +		perr_and_exit("failed to get syscall info of exit\n");
>>>> +	result->a0 = syscall_info_exit->exit.rval;
>>>
>>> I'm sorry but this is not how PTRACE_GET_SYSCALL_INFO should be used.
>>>
>>> PTRACE_GET_SYSCALL_INFO operation takes a pointer and a size,
>>> and in this example instead of size you pass constants 1 and 2, which
>>> essentially means that both syscall_info_entry->entry.args[0] and
>>> syscall_info_exit->exit.rval are not going to be assigned
>>> and would just contain some garbage from the stack.
>>>
>>> Also, PTRACE_GET_SYSCALL_INFO operation returns the number of bytes
>>> available to be written by the kernel, which is always nonzero on any
>>> PTRACE_GET_SYSCALL_INFO-capable kernel.  In other words, this example
>>> will always end up with perr_and_exit() call.
>>>
>>> I wonder how this test was tested before the submission.
>>
>> Oops... It seems I forget sync the code to test board so it runs with the old code...
>> The code is completely not tested...
>> I'm so sorry for my mistake.
>>
>> I will correct it and test it carefully later...
> 
> It would be great to get this into 6.14. Let me know if you would like
> any help!

Sorry, delayed due to personal reasons. I have returned to this job recently.
The update patchset will be sent tomorrow.

> 
> - Charlie
> 
>>
>>>
>>>
>>


