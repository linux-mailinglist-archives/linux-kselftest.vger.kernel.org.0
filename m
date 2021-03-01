Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0E1327B53
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Mar 2021 10:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234313AbhCAJ5S (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 1 Mar 2021 04:57:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:52000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234187AbhCAJz3 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 1 Mar 2021 04:55:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B7B8664E3F;
        Mon,  1 Mar 2021 09:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614592489;
        bh=465DNft04Sr+n7THeMGvd9oDfHYZ8L7VeCWhsS06AJk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nqPJUJ02LQ3pRRnvmJx1bF44xq3zfmOEPgSJ4SZuh0tQo4LOvO4qQHSlureSP05a5
         KJNw6LdlHipHfLjFocNIYbkF7gkZyMvr7k7OswgMFxPTju51mqneNn3Ub6DF+/qn51
         8FzKJf77EsduYvsqyL5sNW9HvfvC2NA3qcEsr9by6sf74L7xNbE7d9VEAlSM8XRKF3
         Jvo5rd0BiOL2B92WrKaQQDFhFaRVb553ryb0o4kED0WeaSeCucgAfcuZ6AOMlGhVPt
         WmVw94r//zN1nsa3ndv1zoSj8cbarj5bfwtT9ZaMWsgDBqyt/B53sqPcQL6Ap0NLj3
         R9iLcqoo/Dfdg==
Date:   Mon, 1 Mar 2021 11:54:29 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <seanjc@google.com>,
        Shuah Khan <shuah@kernel.org>, x86@kernel.org,
        linux-sgx@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>
Subject: Re: [PATCH] selftests/sgx: fix EINIT failure dueto
 SGX_INVALID_SIGNATURE
Message-ID: <YDy51R2Wva7s+k/x@kernel.org>
References: <20210301051836.30738-1-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210301051836.30738-1-tianjia.zhang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Mar 01, 2021 at 01:18:36PM +0800, Tianjia Zhang wrote:
> q2 is not always 384-byte length. Sometimes it only has 383-byte.

What does determine this?

> In this case, the valid portion of q2 is reordered reversely for
> little endian order, and the remaining portion is filled with zero.

I'm presuming that you want to say "In this case, q2 needs to be reversed because...".

I'm lacking these details:

1. Why the length of Q2 can vary?
2. Why reversing the bytes is the correct measure to counter-measure
   this variation?

/Jarkko

> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> ---
>  tools/testing/selftests/sgx/sigstruct.c | 41 +++++++++++++------------
>  1 file changed, 21 insertions(+), 20 deletions(-)
> 
> diff --git a/tools/testing/selftests/sgx/sigstruct.c b/tools/testing/selftests/sgx/sigstruct.c
> index dee7a3d6c5a5..92bbc5a15c39 100644
> --- a/tools/testing/selftests/sgx/sigstruct.c
> +++ b/tools/testing/selftests/sgx/sigstruct.c
> @@ -55,10 +55,27 @@ static bool alloc_q1q2_ctx(const uint8_t *s, const uint8_t *m,
>  	return true;
>  }
>  
> +static void reverse_bytes(void *data, int length)
> +{
> +	int i = 0;
> +	int j = length - 1;
> +	uint8_t temp;
> +	uint8_t *ptr = data;
> +
> +	while (i < j) {
> +		temp = ptr[i];
> +		ptr[i] = ptr[j];
> +		ptr[j] = temp;
> +		i++;
> +		j--;
> +	}
> +}
> +
>  static bool calc_q1q2(const uint8_t *s, const uint8_t *m, uint8_t *q1,
>  		      uint8_t *q2)
>  {
>  	struct q1q2_ctx ctx;
> +	int len;
>  
>  	if (!alloc_q1q2_ctx(s, m, &ctx)) {
>  		fprintf(stderr, "Not enough memory for Q1Q2 calculation\n");
> @@ -89,8 +106,10 @@ static bool calc_q1q2(const uint8_t *s, const uint8_t *m, uint8_t *q1,
>  		goto out;
>  	}
>  
> -	BN_bn2bin(ctx.q1, q1);
> -	BN_bn2bin(ctx.q2, q2);
> +	len = BN_bn2bin(ctx.q1, q1);
> +	reverse_bytes(q1, len);
> +	len = BN_bn2bin(ctx.q2, q2);
> +	reverse_bytes(q2, len);
>  
>  	free_q1q2_ctx(&ctx);
>  	return true;
> @@ -152,22 +171,6 @@ static RSA *gen_sign_key(void)
>  	return key;
>  }
>  
> -static void reverse_bytes(void *data, int length)
> -{
> -	int i = 0;
> -	int j = length - 1;
> -	uint8_t temp;
> -	uint8_t *ptr = data;
> -
> -	while (i < j) {
> -		temp = ptr[i];
> -		ptr[i] = ptr[j];
> -		ptr[j] = temp;
> -		i++;
> -		j--;
> -	}
> -}
> -
>  enum mrtags {
>  	MRECREATE = 0x0045544145524345,
>  	MREADD = 0x0000000044444145,
> @@ -367,8 +370,6 @@ bool encl_measure(struct encl *encl)
>  	/* BE -> LE */
>  	reverse_bytes(sigstruct->signature, SGX_MODULUS_SIZE);
>  	reverse_bytes(sigstruct->modulus, SGX_MODULUS_SIZE);
> -	reverse_bytes(sigstruct->q1, SGX_MODULUS_SIZE);
> -	reverse_bytes(sigstruct->q2, SGX_MODULUS_SIZE);
>  
>  	EVP_MD_CTX_destroy(ctx);
>  	RSA_free(key);
> -- 
> 2.19.1.3.ge56e4f7
> 
> 
