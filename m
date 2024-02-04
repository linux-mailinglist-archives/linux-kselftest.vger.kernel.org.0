Return-Path: <linux-kselftest+bounces-4115-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DACB848A38
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Feb 2024 02:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 481FF2836C6
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Feb 2024 01:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517CA80C;
	Sun,  4 Feb 2024 01:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VoAxtBvh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C7C816;
	Sun,  4 Feb 2024 01:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707010401; cv=none; b=XSjotE5OQbFcajiZJO607nHve3j0r4BtbBGB5dFY1YVZNiunPz1rIZy77m3xiXG4CdPGR93DiQPD0pjnvjGy1lbBOJUX7G7w6VRUoMUsJhH5ZKAUCC/H59MAFxyPTQd1b3bBvPsshu2fHXYGAijVNIsUmtbWsPGnC8cIeucCFbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707010401; c=relaxed/simple;
	bh=Iw/fEuyQ7mi/lXa3d20ylxNcCWQhhKBXMwjanLwFV3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oJQ2cbRnwSjch7IxI68Ndf2tzxlFBeEqkFLKAfu/V3gLnhnmk/uu/Bv0IuJTNtGPPpW/RuNMZTXYfNTrymWMTHpB9ho7UNzq6AY8tlzWsSrQbHAqNVxd1Eo/pveMOQWv/68yS+3luit/g1I7Y/yCSndeKkLYj0AUnZJOWrMElNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VoAxtBvh; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=g/e21LICe/FNUov3txLgNkHBc/RFMYIe48KaXgpnzOM=; b=VoAxtBvhL+JmLBoXdctdEbQwPd
	IrbezwTR6Lj9IqpfmGjRi/81ae1JiGXyAgqoC1CuW7aUFFM7vKeRtBUIJSSpYYEhH2SUbR3gi3EGL
	pkiWs6xYlDWMIuP7GjeYmNJ0AxPxUfVWkFJnnKYgnt4BZU5RYMy9CGiAg78GvAmBIQrrDc3JkptMy
	OHDEJ1GBQ9Hs9TL1om3iaJOWoVzv+DgtxPDP256f+eeAIgz46JkI454jgGx7ZWNvnxVP1Mh/Zg0Xs
	lLBsu8TZjh3wLl/mEafPGF8O8VxiVBwhn3fBAs4RmT7jtqDOEygHSGgeEHHOnxPfyu9c1OgB9M9zK
	akSWs3Ng==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWRNY-0000000HWm3-1uVM;
	Sun, 04 Feb 2024 01:33:04 +0000
Message-ID: <0371ffc5-f6c9-4352-89d5-0e98afa9ad7f@infradead.org>
Date: Sat, 3 Feb 2024 17:33:02 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFT v5 1/7] Documentation: userspace-api: Add shadow stack
 API documentation
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>,
 "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
 Deepak Gupta <debug@rivosinc.com>, Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
 "H.J. Lu" <hjl.tools@gmail.com>, Florian Weimer <fweimer@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira
 <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>,
 Christian Brauner <brauner@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Kees Cook <keescook@chromium.org>,
 jannh@google.com, linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org
References: <20240203-clone3-shadow-stack-v5-0-322c69598e4b@kernel.org>
 <20240203-clone3-shadow-stack-v5-1-322c69598e4b@kernel.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240203-clone3-shadow-stack-v5-1-322c69598e4b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 2/2/24 16:04, Mark Brown wrote:
> There are a number of architectures with shadow stack features which we are
> presenting to userspace with as consistent an API as we can (though there
> are some architecture specifics). Especially given that there are some
> important considerations for userspace code interacting directly with the
> feature let's provide some documentation covering the common aspects.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  Documentation/userspace-api/index.rst        |  1 +
>  Documentation/userspace-api/shadow_stack.rst | 41 ++++++++++++++++++++++++++++
>  2 files changed, 42 insertions(+)
> 


> diff --git a/Documentation/userspace-api/shadow_stack.rst b/Documentation/userspace-api/shadow_stack.rst
> new file mode 100644
> index 000000000000..c6e5ab795b60
> --- /dev/null
> +++ b/Documentation/userspace-api/shadow_stack.rst
> @@ -0,0 +1,41 @@
> +=============
> +Shadow Stacks
> +=============
> +
> +Introduction
> +============
> +
> +Several architectures have features which provide backward edge
> +control flow protection through a hardware maintained stack, only
> +writeable by userspace through very limited operations.  This feature
> +is referred to as shadow stacks on Linux, on x86 it is part of Intel

                                   on Linux. On x86

> +Control Enforcement Technology (CET), on arm64 it is Guarded Control
> +Stacks feature (FEAT_GCS) and for RISC-V it is the Zicfiss extension.> +It is expected that this feature will normally be managed by the
> +system dynamic linker and libc in ways broadly transparent to
> +application code, this document covers interfaces and considerations

               code. This                                considerations.

> +
> +
> +Enabling
> +========
> +
> +Shadow stacks default to disabled when a userspace process is
> +executed, they can be enabled for the current thread with a syscall:

   executed. They

> +
> + - For x86 the ARCH_SHSTK_ENABLE arch_prctl()
> +
> +It is expected that this will normally be done by the dynamic linker.
> +Any new threads created by a thread with shadow stacks enabled will
> +themsleves have shadow stacks enabled.

   themselves

> +
> +
> +Enablement considerations
> +=========================
> +
> +- Returning from the function that enables shadow stacks without first
> +  disabling them will cause a shadow stack exception.  This includes
> +  any syscall wrapper or other library functions, the syscall will need

                                          functions. The

> +  to be inlined.
> +- A lock feature allows userspace to prevent disabling of shadow stacks.
> +- This that change the stack context like longjmp() or use of ucontext

     Those
?

> +  changes on signal return will need support from libc.
> 

-- 
#Randy

