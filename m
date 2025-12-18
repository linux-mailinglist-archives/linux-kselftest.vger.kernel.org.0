Return-Path: <linux-kselftest+bounces-47718-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FBB6CCD48D
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Dec 2025 19:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB6CA300C6EF
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Dec 2025 18:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F394308F38;
	Thu, 18 Dec 2025 18:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hJDfbjuz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A062EB87B;
	Thu, 18 Dec 2025 18:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766084160; cv=none; b=uJ2/YPOvCtJCtCaipbAhRqSi+hgCYEpEjtlauTHBq9kI6ICBaGqx/6oZYJBUkl/2M7VMkZwvBcsXdZEnP8lnSHuezUwN1IXZW7qhRIpchQ8vx2ruGGhA3XjDe+VBLrUnCnrtD5QmJKDS/0kpokO4QI4ZT14wFWq7b/VOLnVs1uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766084160; c=relaxed/simple;
	bh=eR+5uLRObPw9vI+9HKkKwbbOQ8+BEKv7X5bbS1ozIdo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E6IdUA82xf8OPpWqWGL1jFN0MczusOZ6D7VHyvo/kZ4aBXdovZY8Hu8QRRzoAD3XyHAB4tx5zBR0gkOqk5pcqbGx5LXnH1zN4OatZBzK+3org1l4ig4GNUurjs29GdIydBHRXx3WIExqUBojTfcRm4cXkRjt8PSmimcuw1JQy20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hJDfbjuz; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=GMhqqTIZnD8W2W+jc3ikRTNx42Nq+VOngbP+j/GYnkY=; b=hJDfbjuzxm6w1R3TEc6pjLImve
	bLU63v82pKKK+Q6TJcxJrPr+qC4pwcLtu9XFUOj5LKcO/Q+jTHC1W8tLGJO1T7T76JnTXT+SMj0wb
	EXcuGsonbtdhNb2nVNGHsSnRLZEmBL3fns+dCEGpPXx1C/n5nigxjqauPfVV6uvdNA13wxe6kqJGJ
	joP4d9IV8UzioHRfdRQ5usHxP6XSnUncDBKlJ8STpmJK8Sl/YD48Ho9eFizZGb6xbgYXgjWdKjLv0
	ireVqoc+em0kevQZ2Xnb576907n0KbYQWSE4jdpeN5EeKFMzGCFyeU3HWZY8rHidDOr20llPG+Z+V
	0KWNcG3Q==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWJA8-000000091qk-1MjO;
	Thu, 18 Dec 2025 18:55:44 +0000
Message-ID: <e1ebe42c-8ea4-4f56-a017-610c8885f4f2@infradead.org>
Date: Thu, 18 Dec 2025 10:55:42 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v23 2/8] Documentation: userspace-api: Add shadow stack
 API documentation
To: Mark Brown <broonie@kernel.org>,
 "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
 Deepak Gupta <debug@rivosinc.com>, "H.J. Lu" <hjl.tools@gmail.com>,
 Florian Weimer <fweimer@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Christian Brauner <brauner@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, jannh@google.com,
 Andrew Morton <akpm@linux-foundation.org>,
 Yury Khrustalev <yury.khrustalev@arm.com>,
 Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
 Wilco Dijkstra <wilco.dijkstra@arm.com>, CarlosO'Donell
 <codonell@redhat.com>, Rich Felker <dalias@libc.org>,
 linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org,
 Kees Cook <kees@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>
References: <20251218-clone3-shadow-stack-v23-0-7cb318fbb385@kernel.org>
 <20251218-clone3-shadow-stack-v23-2-7cb318fbb385@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20251218-clone3-shadow-stack-v23-2-7cb318fbb385@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/18/25 12:10 AM, Mark Brown wrote:
> There are a number of architectures with shadow stack features which we are
> presenting to userspace with as consistent an API as we can (though there
> are some architecture specifics). Especially given that there are some
> important considerations for userspace code interacting directly with the
> feature let's provide some documentation covering the common aspects.
> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Reviewed-by: Kees Cook <kees@kernel.org>
> Tested-by: Kees Cook <kees@kernel.org>
> Acked-by: Shuah Khan <skhan@linuxfoundation.org>
> Acked-by: Yury Khrustalev <yury.khrustalev@arm.com>
> Reviewed-by: Deepak Gupta <debug@rivosinc.com>
> Tested-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  Documentation/userspace-api/index.rst        |  1 +
>  Documentation/userspace-api/shadow_stack.rst | 44 ++++++++++++++++++++++++++++
>  2 files changed, 45 insertions(+)
> 
> diff --git a/Documentation/userspace-api/index.rst b/Documentation/userspace-api/index.rst
> index 8a61ac4c1bf1..64b0099ee161 100644
> --- a/Documentation/userspace-api/index.rst
> +++ b/Documentation/userspace-api/index.rst
> @@ -63,6 +63,7 @@ Everything else
>     ELF
>     liveupdate
>     netlink/index
> +   shadow_stack
>     sysfs-platform_profile
>     vduse
>     futex2
> diff --git a/Documentation/userspace-api/shadow_stack.rst b/Documentation/userspace-api/shadow_stack.rst
> new file mode 100644
> index 000000000000..42617d0470ba
> --- /dev/null
> +++ b/Documentation/userspace-api/shadow_stack.rst
> @@ -0,0 +1,44 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=============
> +Shadow Stacks
> +=============
> +
> +Introduction
> +============
> +
> +Several architectures have features which provide backward edge
> +control flow protection through a hardware maintained stack, only
> +writable by userspace through very limited operations.  This feature
> +is referred to as shadow stacks on Linux, on x86 it is part of Intel
> +Control Enforcement Technology (CET), on arm64 it is Guarded Control
> +Stacks feature (FEAT_GCS) and for RISC-V it is the Zicfiss extension.
> +It is expected that this feature will normally be managed by the
> +system dynamic linker and libc in ways broadly transparent to
> +application code, this document covers interfaces and considerations.
> +
> +
> +Enabling
> +========
> +
> +Shadow stacks default to disabled when a userspace process is
> +executed, they can be enabled for the current thread with a syscall:
> +
> + - For x86 the ARCH_SHSTK_ENABLE arch_prctl()
> + - For other architectures the PR_SET_SHADOW_STACK_ENABLE prctl()
> +
> +It is expected that this will normally be done by the dynamic linker.
> +Any new threads created by a thread with shadow stacks enabled will
> +themselves have shadow stacks enabled.
> +
> +
> +Enablement considerations
> +=========================
> +
> +- Returning from the function that enables shadow stacks without first
> +  disabling them will cause a shadow stack exception.  This includes
> +  any syscall wrapper or other library functions, the syscall will need
> +  to be inlined.
> +- A lock feature allows userspace to prevent disabling of shadow stacks.
> +- Those that change the stack context like longjmp() or use of ucontext

     Those <what>?  maybe syscalls, library calls, specific functon calls?

> +  changes on signal return will need support from libc.
> 

-- 
~Randy


