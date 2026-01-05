Return-Path: <linux-kselftest+bounces-48232-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5977BCF594E
	for <lists+linux-kselftest@lfdr.de>; Mon, 05 Jan 2026 21:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AEB68307D82C
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jan 2026 20:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A5C2C0F9A;
	Mon,  5 Jan 2026 20:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+mzFxg2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E74207A32;
	Mon,  5 Jan 2026 20:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767646518; cv=none; b=X4Lqa0rpDBUNBs6vetmHQjuZpiH7aQcSgGmWQL0FjdskT67XEgsL169+ijMJ4oTY+giqFwAEm6WZzC7pvZMXqU3pTuhUq+DLqWiBuDOJXYDq2KSLrLGFaJySqmXeW0+++1T2b9Fu9R3A90QbOpuyJTnS98TiOppomnmb+/ovHiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767646518; c=relaxed/simple;
	bh=X0kZc9BzjwN5JH7faivqULek50zMy1V0qKnPhSZPR40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iu9vJioI33soMriooVsrrm1xfACsQ9PuyY9iVRdlBokMNE7FuYJqYYLy39R+hEU/c1DeOZgeDsQwe7a9Lx05rMjLOxJR90QLO9uFCst9UWuLSortXI0hr8n0/ZZUVbRScCBQzX8eE0a0FCbXbO3TVfYeizTLElZBx7bfTMcj/eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+mzFxg2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE134C116D0;
	Mon,  5 Jan 2026 20:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767646517;
	bh=X0kZc9BzjwN5JH7faivqULek50zMy1V0qKnPhSZPR40=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d+mzFxg2snhJMgHzYxsep1urxQ3+v79zFd17Eu5NrQpC2a7sDkFxwkqY6MCNFHhHQ
	 0oTsesBLF1iss1X4rlnlkvRCzjUWGzNdQV506obKfjc0QkCZI+DjxXnPGQGxHED+A3
	 tujFZt8Ib24w9bNmWtE1wyXqSW5lAvn/MKtl/mNmHgce5QOgnJ61fLhN58qQxaYuYk
	 vPClOfvEX1NYgrkegC7SBERDPxVnjCOfuPyats2f3xXGYEZd2rpv/fPtMTf3zuvlfH
	 UkwxfK5wqPapHGgkjfNcaBk0rwL0tWXdEGApwuxHH0GwHPCHV0VhYEmjk/BYa9QU+e
	 7hmEZO0Oj2ZDg==
Date: Mon, 5 Jan 2026 20:55:10 +0000
From: Will Deacon <will@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Russell King <rmk+kernel@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org
Subject: Re: [PATCH 8/9] arm64: vdso32: Provide clock_getres_time64()
Message-ID: <aVwlLmvwXDFs--S7@willie-the-truck>
References: <20251223-vdso-compat-time32-v1-0-97ea7a06a543@linutronix.de>
 <20251223-vdso-compat-time32-v1-8-97ea7a06a543@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251223-vdso-compat-time32-v1-8-97ea7a06a543@linutronix.de>

On Tue, Dec 23, 2025 at 07:59:19AM +0100, Thomas Weiﬂschuh wrote:
> For consistency with __vdso_clock_gettime64() there should also be a
> 64-bit variant of clock_getres(). This will allow the extension of
> CONFIG_COMPAT_32BIT_TIME to the vDSO and finally the removal of 32-bit
> time types from the kernel and UAPI.
> 
> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> ---
>  arch/arm64/kernel/vdso32/vdso.lds.S      | 1 +
>  arch/arm64/kernel/vdso32/vgettimeofday.c | 6 ++++++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/kernel/vdso32/vdso.lds.S b/arch/arm64/kernel/vdso32/vdso.lds.S
> index e02b27487ce8..c374fb0146f3 100644
> --- a/arch/arm64/kernel/vdso32/vdso.lds.S
> +++ b/arch/arm64/kernel/vdso32/vdso.lds.S
> @@ -86,6 +86,7 @@ VERSION
>  		__vdso_gettimeofday;
>  		__vdso_clock_getres;
>  		__vdso_clock_gettime64;
> +		__vdso_clock_getres_time64;
>  	local: *;
>  	};
>  }
> diff --git a/arch/arm64/kernel/vdso32/vgettimeofday.c b/arch/arm64/kernel/vdso32/vgettimeofday.c
> index 29b4d8f61e39..d7b39b0a9668 100644
> --- a/arch/arm64/kernel/vdso32/vgettimeofday.c
> +++ b/arch/arm64/kernel/vdso32/vgettimeofday.c
> @@ -32,6 +32,12 @@ int __vdso_clock_getres(clockid_t clock_id,
>  	return __cvdso_clock_getres_time32(clock_id, res);
>  }
>  
> +int __vdso_clock_getres_time64(clockid_t clock_id,
> +			       struct __kernel_timespec *res)
> +{
> +	return __cvdso_clock_getres(clock_id, res);
> +}
> +
>  /* Avoid unresolved references emitted by GCC */
>  
>  void __aeabi_unwind_cpp_pr0(void)

Acked-by: Will Deacon <will@kernel.org>

Please merge this along with the 32-bit Arm change, as it doesn't make
sense otherwise.

Will

