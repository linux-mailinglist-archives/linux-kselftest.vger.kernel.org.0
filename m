Return-Path: <linux-kselftest+bounces-12749-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A51917443
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 00:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67A4D284547
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 22:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E8517D374;
	Tue, 25 Jun 2024 22:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A970dsMG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F635149C6E;
	Tue, 25 Jun 2024 22:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719354688; cv=none; b=nHVVfPDoxKf+7Yc5Hhk2OUYzzLElOgSeIIpajNWRmTl0T9RBLNk/g0lDdab3iU4AQtSWwwQb9Q483vMw+fb0P63j5mGgv2s1N1CJWfLHoG8KgAHR+GAo5UPi4CkyjNleUo2xD7ZZ4jHlYnz0WPNojAkwdXFy5Wc2QUNNYHpQj08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719354688; c=relaxed/simple;
	bh=NNHWeZcyyS4P5K0t1W/YqG4GhaBLe/fDc32RMTJakEc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rTsqhVdBgWid+LNL/ZYYHOw6EbEYX0ar3YkbImrcYgmRzkSuLmHXPnAQgUZdaggZnjWn9Bq2D3T1rSyLT4nV+b39YqBfpWBBy/7F+XzLdSXtSj3nXY6xMbxomKykiKFz4J2WdZXUz1MYx/qqghC+f/3tH/7Dxc32h54AqxuZ+ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=A970dsMG; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=gBGJpt/3ReVlJkwGEJYBKb36lu8imtdr3lQE4kDPaL8=; b=A970dsMGTdJ4wDpvciuf0s05a+
	SgpFHcVFFi89sw6juxMHz1f9m09GSU9WMzTxxqqZ6FkGPAzoU31ynfjqzhHjYvjAjNtxhXBNwKRnB
	uhBla1pjIR2aJffXePgeTh0o7ekivLAHDDbDRlnuH6iqjJOlKyXwKjIR09E55CZ/CWzwNkS1zBBh/
	wIFQTaXTaXGq3LIha1ZVopP8vFDFvSKDCnbR4E37CByy2VdIcICuk2aFaoXVetrp+K3s+ygF7m2kT
	oLyrKlBiNfqMqqhi9tH8OOJMGyEuToh+o2XS+6gua+w8AGc080/JbdJw9AcP6HkhOBMejJZj6BKju
	lGM1B+fQ==;
Received: from [50.53.4.147] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMEgw-00000004hHz-017F;
	Tue, 25 Jun 2024 22:31:10 +0000
Message-ID: <d935fe05-9e52-487b-8873-3a35cd6b037e@infradead.org>
Date: Tue, 25 Jun 2024 15:31:08 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFT v6 1/9] Documentation: userspace-api: Add shadow stack
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
 Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira
 <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>,
 Christian Brauner <brauner@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, jannh@google.com,
 linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org,
 Kees Cook <kees@kernel.org>
References: <20240623-clone3-shadow-stack-v6-0-9ee7783b1fb9@kernel.org>
 <20240623-clone3-shadow-stack-v6-1-9ee7783b1fb9@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240623-clone3-shadow-stack-v6-1-9ee7783b1fb9@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 6/23/24 4:23 AM, Mark Brown wrote:
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

Fix run-on sentences...

> diff --git a/Documentation/userspace-api/shadow_stack.rst b/Documentation/userspace-api/shadow_stack.rst
> new file mode 100644
> index 000000000000..c576ad3d7ec1
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

                                      Linux. On x86

> +Control Enforcement Technology (CET), on arm64 it is Guarded Control

                                  (CET); on arm64

> +Stacks feature (FEAT_GCS) and for RISC-V it is the Zicfiss extension.

                  (FEAT_GCS); and for

> +It is expected that this feature will normally be managed by the
> +system dynamic linker and libc in ways broadly transparent to
> +application code, this document covers interfaces and considerations.

               code. This document

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
> +themselves have shadow stacks enabled.
> +
> +
> +Enablement considerations
> +=========================
> +
> +- Returning from the function that enables shadow stacks without first
> +  disabling them will cause a shadow stack exception.  This includes
> +  any syscall wrapper or other library functions, the syscall will need

                                          functions. The syscall

> +  to be inlined.
> +- A lock feature allows userspace to prevent disabling of shadow stacks.
> +- Those that change the stack context like longjmp() or use of ucontext
> +  changes on signal return will need support from libc.
> 

-- 
~Randy

