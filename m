Return-Path: <linux-kselftest+bounces-24519-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 736ACA1120C
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 21:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3EEC169D87
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 20:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8E720F090;
	Tue, 14 Jan 2025 20:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b="FUu2prLJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DFgmAYnt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B551220C47F;
	Tue, 14 Jan 2025 20:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736886726; cv=none; b=G4BQ4pECgj926Q8UnvIDONg8M5vo4qw2BLybTT36NnVFew/lAYooZM/2YpotqwcK+AiYEelRP1N9F7H2bUDEx0TuTwzxZiTArQqWcSTfMW3uVJIVB0Qn1+iuWd/ctIfIidrDsoa8tX3pBIt+OQ+YgoeabtHXO/VRRREXocS6ANo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736886726; c=relaxed/simple;
	bh=/v/P2m8/hpnNoBNP9m4lZJpDZj91viqX7SE/j73ggHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h6XZKdHMaHUiEdapVSV5ZRdZ5PBrSqbueSWaoikfrqIeSbj+ViVE6D2GCgPNW8CmC0yMEmPiUJhn/xnmiYwun3jA22OkBui+txedqIVYeVD4yHdNufvlkR861j+AfSXMMffmvZ5h1YHZWiEwyUV/mhcYhZTsgUQAKn8OUb2bNXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name; spf=pass smtp.mailfrom=coelacanthus.name; dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b=FUu2prLJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DFgmAYnt; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coelacanthus.name
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id 14FC91D40844;
	Tue, 14 Jan 2025 15:32:03 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 14 Jan 2025 15:32:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	coelacanthus.name; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1736886722; x=1736893922; bh=k3aK0yvw6s
	3XgHhobmGdwD1q9qT+ce2iJbSudHfZEug=; b=FUu2prLJ1is+E6pfAnsUuGSgwu
	F2PNTmouhWFckCjs7RP2LXWUbMWmQP861AX7k699XzNt+GIDaThA9BaonOyr0wB3
	iOBNfyQNFbIzTXgMB3H+ppZH5/W6rQz4weA10Hc/AtNEvIYMKnecZbn8hzNawett
	e5k0Svbmqo02Pz6x2DLFtXN5gkhamNCZXES/bGFC0DF2EN4wKhon+GiTeaabqU1i
	tg9/r3WaEzNbr/gjzcLugNmDc7KgTA0ki683cFHSSVDIFnDVWapEVt5HqT3XShYb
	AWOgP8mq+fdSDaesmeuadnycx3PzjfS93whEaDRwdC8JjUnWS/1yQ+/kDctA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736886722; x=
	1736893922; bh=k3aK0yvw6s3XgHhobmGdwD1q9qT+ce2iJbSudHfZEug=; b=D
	FgmAYnt5ayLH5wRYBsYb9NOkdf0VuWsBSxpJYNWxtSLbZkROUVUjE98RK+5YnLuS
	NdNPZ2jddAQkFsSM2L7MbdmZ6TlrfmUB8iA7B4Ha5zgsdlb8zGLyyo+HwfuxR/GE
	hmxQ2Z2iqyikGW+/td2nta7C6xy2eeIG+5jVs3Xy1RrYPzRbrDDTufXkBp3eaI3R
	Hw/1e7CpXB3+A3dNpaqxc1vstFlua9yP/s2bbeAU0ltCJ3YR/tf83yvHaE2jQ3cV
	WJiOYY7lBf2hBuwT4le0zSu3DJYTn8q581pqZRks905uKxgPo/ZDjktp8sORvKjb
	iOihm+YdBxecJbouyxGVA==
X-ME-Sender: <xms:wcmGZ8yWRyXxhIcvlmuRbHY6A2sbKJsWVN5lamYYR_kRlWitSZ_nOw>
    <xme:wcmGZwSZ_GThlD7ZWI0cf7dapvWckQSuKJePUeBDxpP5pOk3-RXjC4WNhMenIspfS
    obLIiMupBSlvy4XfNc>
X-ME-Received: <xmr:wcmGZ-UWF3C77y7hucvYopwHtNvkUOjRK2YTmrNo7I25xdN9kbk-_HUWZPJd6E6u>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehiedgudefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthekredttddv
    jeenucfhrhhomhepvegvlhgvshhtvgcunfhiuhcuoehufihusegtohgvlhgrtggrnhhthh
    hushdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeefffdujedtleetieffleehjeffudet
    feeghfdtieeiheevueeggfeuiefgvdekvdenucffohhmrghinhepkhgvrhhnvghlrdhorh
    hgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepuhif
    uhestghovghlrggtrghnthhhuhhsrdhnrghmvgdpnhgspghrtghpthhtohepvdeipdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopegthhgrrhhlihgvsehrihhvohhsihhntgdr
    tghomhdprhgtphhtthhopehlughvsehsthhrrggtvgdrihhopdhrtghpthhtohepohhlvg
    hgsehrvgguhhgrthdrtghomhdprhgtphhtthhopehprghulhdrfigrlhhmshhlvgihsehs
    ihhfihhvvgdrtghomhdprhgtphhtthhopehprghlmhgvrhesuggrsggsvghlthdrtghomh
    dprhgtphhtthhopegvsghivgguvghrmhesgihmihhsshhiohhnrdgtohhmpdhrtghpthht
    ohepkhgvvghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehshhhurghhsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopegrohhusegvvggtshdrsggvrhhkvghlvgihrdgvughu
X-ME-Proxy: <xmx:wcmGZ6jpZW4MqjOd3ak_VcDAOQLuSdpdXsCcWQVmKtGjHt1HiIo67g>
    <xmx:wcmGZ-AwdeQryJpPUW-FMNT3pIq-hYivUf1Mg_Go5E5ykzNFNakRTQ>
    <xmx:wcmGZ7KrNV88kGIaZ3TLH55saBZgmqLpHD7sMHKDpPFt1SXQjuH6ng>
    <xmx:wcmGZ1CY0diCWBx-i2BY_cTyODvMN049uCAh_xGiBRZcQfr9GqJZgw>
    <xmx:wsmGZ_xatnRalfHDXBhBcagXq89TXNU-EnMEZCvBMgZ_6PBtnx-hSnGJ>
Feedback-ID: i95c648bc:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jan 2025 15:31:53 -0500 (EST)
Message-ID: <6bacd2ec-fd86-41c9-b5dc-e14796737b4b@coelacanthus.name>
Date: Wed, 15 Jan 2025 04:31:50 +0800
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
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: "Dmitry V. Levin" <ldv@strace.io>, Oleg Nesterov <oleg@redhat.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Eric Biederman <ebiederm@xmission.com>,
 Kees Cook <kees@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Andrea Bolognani <abologna@redhat.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ron Economos <re@w6rz.net>, Andrew Jones <ajones@ventanamicro.com>,
 Quan Zhou <zhouquan@iscas.ac.cn>, Felix Yan <felixonmars@archlinux.org>,
 Ruizhe Pan <c141028@gmail.com>, Guo Ren <guoren@kernel.org>,
 Yao Zi <ziyao@disroot.org>, Eugene Syromyatnikov <evgsyr@gmail.com>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>
References: <20241226-riscv-new-regset-v4-0-4496a29d0436@coelacanthus.name>
 <20241226-riscv-new-regset-v4-2-4496a29d0436@coelacanthus.name>
 <20241226133459.GA30481@strace.io>
 <2e09aedc-44ba-40e3-ae93-1d6dc21b5eb1@coelacanthus.name>
 <Z4CVQKkViqJycnaq@ghost>
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

v5 has been sent.

Sorry for delay. My test environment was broken yesterday so I have to
spend time to repair it first...

https://lore.kernel.org/lkml/20250115-riscv-new-regset-v5-0-d0e6ec031a23@coelacanthus.name/T/

> 
> - Charlie
> 
>>
>>>
>>>
>>


