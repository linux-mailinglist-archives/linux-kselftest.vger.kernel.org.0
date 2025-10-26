Return-Path: <linux-kselftest+bounces-44066-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 530BAC0A622
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Oct 2025 11:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8D883AE26C
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Oct 2025 10:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5452153ED;
	Sun, 26 Oct 2025 10:44:58 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2E2335C7;
	Sun, 26 Oct 2025 10:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761475498; cv=none; b=fazIXZQZKFYdmP9Oj/AZ4Kyoisey1VbiOSsgwxM5+2DWDd2BEslzdadE/SIKkk2vKX767ecCI1rv3GCfusIanQorCgOTLja0elV1eohB10lpIUmUJY5H1VhQ14WOYinY8ezSLEic9I/naF542ksygzQfhLLWUU1yDVAg0i2HAuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761475498; c=relaxed/simple;
	bh=pSHBeKw/R6rKCZNSguZUfNIAjlS57FRnL+lgEqm4MD8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GLC1jHAB0UtOsX60siFBhyBBQ4AQH8cyYBqn96QxGUYSG+qR5ZxpnL7i2uUa3mB5TdHGdjaoLy3tncdukIajEQCRgM7JqksWxeCwEbZYKgKy4mDGP5yv9G9eu+GAPbhdCytxuOQtCjH6ZJ9f1jBS8azEDv/XTkn+mvXHRfx8BAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from mop.sam.mop (2.8.3.0.0.0.0.0.0.0.0.0.0.0.0.0.a.5.c.d.c.d.9.1.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:19dc:dc5a::382])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sam)
	by smtp.gentoo.org (Postfix) with ESMTPSA id DACFF341438;
	Sun, 26 Oct 2025 10:44:53 +0000 (UTC)
From: Sam James <sam@gentoo.org>
To: Nirbhay Sharma <nirbhay.lkd@gmail.com>
Cc: Kees Cook <kees@kernel.org>,  Shuah Khan <shuah@kernel.org>,  Andy
 Lutomirski <luto@amacapital.net>,  Will Drewry <wad@chromium.org>,  Nathan
 Chancellor <nathan@kernel.org>,  Nick Desaulniers
 <nick.desaulniers+lkml@gmail.com>,  Bill Wendling <morbo@google.com>,
  Justin Stitt <justinstitt@google.com>,  linux-kselftest@vger.kernel.org,
  linux-kernel@vger.kernel.org,  bpf@vger.kernel.org,
  llvm@lists.linux.dev,  khalid@kernel.org,  david.hunter.linux@gmail.com,
  linux-kernel-mentees@lists.linuxfoundation.org,  Jiri Olsa
 <olsajiri@gmail.com>
Subject: Re: [PATCH v2] selftests/seccomp: fix pointer type mismatch in
 UPROBE test
In-Reply-To: <20251026091232.166638-2-nirbhay.lkd@gmail.com>
Organization: Gentoo
References: <aP0-k3vlEEWNUtF8@krava>
	<20251026091232.166638-2-nirbhay.lkd@gmail.com>
User-Agent: mu4e 1.12.13; emacs 31.0.50
Date: Sun, 26 Oct 2025 10:44:50 +0000
Message-ID: <87v7k2gcwt.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Nirbhay Sharma <nirbhay.lkd@gmail.com> writes:

> Fix compilation error in UPROBE_setup caused by pointer type mismatch
> in the ternary expression when compiled with -fcf-protection. The
> probed_uprobe function pointer has the __attribute__((nocf_check))
> attribute, which causes the conditional operator to fail when combined
> with the regular probed_uretprobe function pointer:
>

Just as a curiosity to share: I found a few tangential issues and
reported them as https://gcc.gnu.org/PR122427.

>   seccomp_bpf.c:5175:74: error: pointer type mismatch in conditional
>   expression [-Wincompatible-pointer-types]
>
> Cast both function pointers to 'const void *' to match the expected
> parameter type of get_uprobe_offset(), resolving the type mismatch
> while preserving the function selection logic.
>
> This error appears with compilers that enable Control Flow Integrity
> (CFI) protection via -fcf-protection, such as Clang 19.1.2 (default
> on Fedora).
>

Reviewed-by: Sam James <sam@gentoo.org>

> Signed-off-by: Nirbhay Sharma <nirbhay.lkd@gmail.com>
> ---
>  tools/testing/selftests/seccomp/seccomp_bpf.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
> index 874f17763536..e13ffe18ef95 100644
> --- a/tools/testing/selftests/seccomp/seccomp_bpf.c
> +++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
> @@ -5172,7 +5172,8 @@ FIXTURE_SETUP(UPROBE)
>  		ASSERT_GE(bit, 0);
>  	}
>  
> -	offset = get_uprobe_offset(variant->uretprobe ? probed_uretprobe : probed_uprobe);
> +	offset = get_uprobe_offset(variant->uretprobe ?
> +		(const void *)probed_uretprobe : (const void *)probed_uprobe);
>  	ASSERT_GE(offset, 0);
>  
>  	if (variant->uretprobe)

