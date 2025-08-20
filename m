Return-Path: <linux-kselftest+bounces-39414-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5B0B2E881
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 01:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 017EDA23C43
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 23:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7FA2DCBEB;
	Wed, 20 Aug 2025 23:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="a5B901bq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E982DA76E;
	Wed, 20 Aug 2025 23:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755731722; cv=none; b=A7JTjJvAMaGGJU8u2aCzPfh2SijuEucQbuZAx983YvMc4+HzDCdOen+k5yi6iaf8T6xMn4xeGbNRfd9kd6KJ5NiXVlSUg5iB/WkCXST9OaWC0+t/7c4fal7TTOGBgMqGaQ2Zgf5p5c0TJpFyvQcu5kf+VX7Oxo+pBJ9j7rWgHlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755731722; c=relaxed/simple;
	bh=OYOlcCTwmKGZgS5KOIn5H+vHPB4jOQ7YEfAFOO/ZXg0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PIBeZQGrSyE7BTeRefrS6rnJYRySA2mAyc+q0d5hRFPbkbpdj4W+BH1elRyzvQ6BDH81KveY+EbklbFSOjTHSZ3ynmg8R3q0caislkA7/vpdzAFCKSKds6fWQuVpmQ/OTOCO7ZU3Ym24jWwmpMpka+S8C4C3k8eqNKU9f0pVt9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=a5B901bq; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=FpjcGExinQ7DizvhjlC/0mgW8VkMGf3pFsHN0FXHDG8=; b=a5B901bqltmOZu1bQYhtL5O1nR
	vDvhyfcxMODQFuDWGBHTqxuTKDsWZzjnmw0gvSA/CvIWJIp+P+adWpHBtVXmZHjwLFA82tLwZgiyh
	a4VH+b6/lHLVQVQU+mUGE6hsXlTwyKJ4IOHUldsw8aM3iLf+2URhXpVCTe5eOi9pv8Nbsjd232WVj
	rhV1zOdMMA/kGOGo2mplaPuohEvnVFsVJG5JzBVg5THmnRP23paSI3VzUzsrHop8k6aYTPGA1kkIH
	MbtskjZbnX9GHMtPG5xlCbX8APXul1SFl2YS6q8+UlktOc7ewTdvP644WGVkJGoMwrbdSX0RLbELy
	zV0hzS/Q==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uos1O-0000000FA4b-2rMG;
	Wed, 20 Aug 2025 23:15:10 +0000
Message-ID: <fb515d1f-beb2-4adb-933d-c9612949ae36@infradead.org>
Date: Wed, 20 Aug 2025 16:15:08 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 2/8] Documentation: userspace-api: Add shadow stack
 API documentation
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
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Christian Brauner <brauner@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, jannh@google.com,
 Andrew Morton <akpm@linux-foundation.org>,
 Yury Khrustalev <yury.khrustalev@arm.com>,
 Wilco Dijkstra <wilco.dijkstra@arm.com>, linux-kselftest@vger.kernel.org,
 linux-api@vger.kernel.org, Kees Cook <kees@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250819-clone3-shadow-stack-v19-0-bc957075479b@kernel.org>
 <20250819-clone3-shadow-stack-v19-2-bc957075479b@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250819-clone3-shadow-stack-v19-2-bc957075479b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/19/25 9:21 AM, Mark Brown wrote:
> There are a number of architectures with shadow stack features which we are
> presenting to userspace with as consistent an API as we can (though there
> are some architecture specifics). Especially given that there are some
> important considerations for userspace code interacting directly with the
> feature let's provide some documentation covering the common aspects.
> 

> ---
>  Documentation/userspace-api/index.rst        |  1 +
>  Documentation/userspace-api/shadow_stack.rst | 44 ++++++++++++++++++++++++++++
>  2 files changed, 45 insertions(+)
> 

> diff --git a/Documentation/userspace-api/shadow_stack.rst b/Documentation/userspace-api/shadow_stack.rst
> new file mode 100644
> index 000000000000..65c665496624
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
> +writeable by userspace through very limited operations.  This feature

$internet says "writable"

> +is referred to as shadow stacks on Linux, on x86 it is part of Intel

                                      Linux. On

> +Control Enforcement Technology (CET), on arm64 it is Guarded Control
> +Stacks feature (FEAT_GCS) and for RISC-V it is the Zicfiss extension.
> +It is expected that this feature will normally be managed by the
> +system dynamic linker and libc in ways broadly transparent to
> +application code, this document covers interfaces and considerations.

               code. This

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

                                          functions; the

> +  to be inlined.
> +- A lock feature allows userspace to prevent disabling of shadow stacks.
> +- Those that change the stack context like longjmp() or use of ucontext
> +  changes on signal return will need support from libc.
> 
-- 
~Randy


