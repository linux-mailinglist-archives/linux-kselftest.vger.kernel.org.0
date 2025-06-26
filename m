Return-Path: <linux-kselftest+bounces-35863-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E08CCAEA228
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 17:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D76836A4FAC
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 15:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0052ECD22;
	Thu, 26 Jun 2025 15:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Nrd7fB0O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out.smtpout.orange.fr (out-69.smtpout.orange.fr [193.252.22.69])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04A22EAD1A;
	Thu, 26 Jun 2025 15:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750950410; cv=none; b=jVEW8ZSdmf8vCmwsbgqCCTm6t+QuzTZ+xiOxqBVJXOB4Em9/noTIzYieTBr9C/uzEsBJ8siHfoJvwL+B2IDYQMPyhZszPliH4RaxsMgGUgG3VG7UO8QFErVm/IP+oS54feGqbs+COL9eXfmGVU6hO5vNTTfHiU3l1ajl6BQsvXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750950410; c=relaxed/simple;
	bh=GW/yaWy2sR29otqwqoWWBOVeJiyPIEy30RjtkuFDJug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=esmAhaPsliLsMWuKYdfUu1DYtCv7C7/QaDnO05Yg1cCpnMoY0c7+yAfNjUlreIfz73mCHqex7lQp54JP4OWgy1s5g8D6egSTQgh6QsdZ9np71DcX5GJ4BYOLAj+6VbR5SsFwesjrclIAobjAfgsj+F8dzJJgkZSzJNo60yszSXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Nrd7fB0O; arc=none smtp.client-ip=193.252.22.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id UoBPuUP4J9E9ZUoBRuQLvm; Thu, 26 Jun 2025 17:06:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1750950399;
	bh=lAvuKIXenlfXd6kGqY1fPVYHrRTlED4Xf7/Lpv1aLrs=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=Nrd7fB0OSxZVpyYm44m5rfXJDO4SEsJ0bRwqf8WcxkrosG6aZ4zRLTcmdO2e/psda
	 TUgtqrZ/WBmeIhS24PV1IIaFfagggaSAnM9bdmAd9/ZFaoykd5OIxbeks+WKvIuw6D
	 pGRw5tZ7+Waz1cGCS5rAgesOXXLQUcf/jT+iYY+wcb17OQ/4zFSd+Nn+HVhSsHJBq0
	 tBD8Cf13My9nMyrvGLGl6XvlAZdG7WJrv+LgMkshvUfDsyiGBepgNMEraeADRxPZ+w
	 7vB7x1ivxFLpdQHye+Qvbu+rRrXiH13ix1TjeP8XrNS5JBzeJ7CtBlqDjncwYErizZ
	 qTfNZOCa2m9bQ==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Thu, 26 Jun 2025 17:06:39 +0200
X-ME-IP: 124.33.176.97
Message-ID: <fa9e2fae-012a-4a34-883b-30c4c2845e9e@wanadoo.fr>
Date: Fri, 27 Jun 2025 00:06:34 +0900
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: harness: Rework is_signed_type() to avoid
 collision with overflow.h
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@redhat.com>, Kees Cook <kees@kernel.org>,
 Shuah Khan <shuah@kernel.org>
References: <20250624231930.583689-1-seanjc@google.com>
Content-Language: en-US
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Autocrypt: addr=mailhol.vincent@wanadoo.fr; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 LFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI+wrIEExYKAFoC
 GwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AWIQTtj3AFdOZ/IOV06OKrX+uI
 bbuZwgUCZx41XhgYaGtwczovL2tleXMub3BlbnBncC5vcmcACgkQq1/riG27mcIYiwEAkgKK
 BJ+ANKwhTAAvL1XeApQ+2NNNEwFWzipVAGvTRigA+wUeyB3UQwZrwb7jsQuBXxhk3lL45HF5
 8+y4bQCUCqYGzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrbYZzu0JG5w8gxE6EtQe6LmxKMqP6E
 yR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDldOjiq1/riG27mcIFAmceMvMCGwwF
 CQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8VzsZwr/S44HCzcz5+jkxnVVQ5LZ4B
 ANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <20250624231930.583689-1-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/06/2025 at 08:19, Sean Christopherson wrote:
> Rename is_signed_type() to is_signed_var() to avoid colliding with a macro
> of the same name defined by linux/overflow.h.  Note, overflow.h's version
> takes a type as the input, whereas the harness's version takes a variable!
> 
> This fixes warnings (and presumably potential test failures) in tests
> that utilize the selftests harness and happen to (indirectly) include
> overflow.h.
> 
>   In file included from tools/include/linux/bits.h:34,
>                    from tools/include/linux/bitops.h:14,
>                    from tools/include/linux/hashtable.h:13,
>                    from include/kvm_util.h:11,
>                    from x86/userspace_msr_exit_test.c:11:
>   tools/include/linux/overflow.h:31:9: error: "is_signed_type" redefined [-Werror]
>      31 | #define is_signed_type(type)       (((type)(-1)) < (type)1)
>         |         ^~~~~~~~~~~~~~
>   In file included from include/kvm_test_harness.h:11,
>                    from x86/userspace_msr_exit_test.c:9:
>   ../kselftest_harness.h:754:9: note: this is the location of the previous definition
>     754 | #define is_signed_type(var)       (!!(((__typeof__(var))(-1)) < (__typeof__(var))1))
>         |         ^~~~~~~~~~~~~~
> 
> Opportunistically use is_signed_type() to implement is_signed_var() so
> that the relationship and differences are obvious.
> 
> Fixes: fc92099902fb ("tools headers: Synchronize linux/bits.h with the kernel sources")
> Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
> 
> This is probably compile-tested only, I don't think any of the KVM selftests
> utilize the harness's EXPECT macros.
> 
>  tools/testing/selftests/kselftest_harness.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
> index 2925e47db995..f3e7a46345db 100644
> --- a/tools/testing/selftests/kselftest_harness.h
> +++ b/tools/testing/selftests/kselftest_harness.h
> @@ -56,6 +56,7 @@
>  #include <asm/types.h>
>  #include <ctype.h>
>  #include <errno.h>
> +#include <linux/overflow.h>
>  #include <linux/unistd.h>
>  #include <poll.h>
>  #include <stdbool.h>
> @@ -751,7 +752,7 @@
>  	for (; _metadata->trigger; _metadata->trigger = \
>  			__bail(_assert, _metadata))
>  
> -#define is_signed_type(var)       (!!(((__typeof__(var))(-1)) < (__typeof__(var))1))
> +#define is_signed_var(var)	is_signed_type(__typeof__(var))

It would potentially make sense to add the is_signed_var() to overflow.h. I see
a couple places doing some is_signed_type(typeof(x)):

  $ git grep "is_signed_type(typeof" | wc -l
  5

And I can imagine this number growing in the future.

But this is by no way a reason strong enough to block this patch. It is just a
random idea I am sharing here.

So that said:

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

>  #define __EXPECT(_expected, _expected_str, _seen, _seen_str, _t, _assert) do { \
>  	/* Avoid multiple evaluation of the cases */ \
> @@ -759,7 +760,7 @@
>  	__typeof__(_seen) __seen = (_seen); \
>  	if (!(__exp _t __seen)) { \
>  		/* Report with actual signedness to avoid weird output. */ \
> -		switch (is_signed_type(__exp) * 2 + is_signed_type(__seen)) { \
> +		switch (is_signed_var(__exp) * 2 + is_signed_var(__seen)) { \
>  		case 0: { \
>  			uintmax_t __exp_print = (uintmax_t)__exp; \
>  			uintmax_t __seen_print = (uintmax_t)__seen; \
> 
> base-commit: 78f4e737a53e1163ded2687a922fce138aee73f5


Yours sincerely,
Vincent Mailhol


