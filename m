Return-Path: <linux-kselftest+bounces-21121-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6239B6615
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 15:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B2C91F20F95
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 14:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5AA21EE039;
	Wed, 30 Oct 2024 14:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ew12GuLe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EB61E7C12;
	Wed, 30 Oct 2024 14:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730298823; cv=none; b=TaT511c9SdOYBc3GfHwn9u5y2rFV6nTqf8v7lbu6cyq1LYX12mzALnVAA3zpd2tn2WGveXeJ+SHV7xPAhOxPIFtFK1EnNjlpli3xz/3JhtxFlbI576uJE3C6T2aFvpcc5ZLUsUCtGV3vTbCx/3QMK/5Llv7mLWrrbQNytohF8Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730298823; c=relaxed/simple;
	bh=GdrLnAcoyLbuyIkP4M7EWVlAvKcTHkaUfN511LRxwPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xty+wTzYGywlm2PSuIMg6C00qh8V5XVNAiSWGHuBXz8gC1mhWjY91yKa8tVbQtdlVrn7w++oKg9u2YjYTotvNhNXrqu5YVG5pT6XZ+1BVKJf8uA/7bnwZYMb4t+wf2I4pWaD68MdK2/A0yYgY1w2KNWiLKnTyJhNuSTTKMLJpD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ew12GuLe; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7ee020ec76dso2486901a12.3;
        Wed, 30 Oct 2024 07:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730298821; x=1730903621; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kdt8y8wCusL4+S51EkCSh7l/zTm5/WwfbbuBF+5V9wY=;
        b=Ew12GuLe1KJgiX5Fh3SwLWcgqGnMDPDHEjYkjYWP2JThQODnTU8tVMDlT0yhJ3Sidb
         nTXc/mvTNYHGCLySHazgGrCE7KbZHYs9QJbRkUYtmJwSf8PR0VcEMuS29zYqKfAXgMzW
         THLlzrzq47EpnO1eWMLQ+ifJ9HouiTyyPI9LHA76H5lDGHYt8A8J3u3c+lkGG3CaoaiA
         3QAP0Sm9l/RMAX8VaEMRzSL0veydKGLLtIwDAbI2VDzaZ8wxIFaL8WatoHmmlhyz0HIA
         CmqyU0D0szzJQk8k68tRwQz6j4BcVXDGM5j3LTnDBRsbun+Wu6/ghn2SttOUPlqSuQpK
         qZKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730298821; x=1730903621;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kdt8y8wCusL4+S51EkCSh7l/zTm5/WwfbbuBF+5V9wY=;
        b=AxcOPgH7HMkb9lBVNwdf0r04lOMLrd4LkvoCftKcCm50Z1oY0qRYCdlPPJsyrXoebS
         l/LIcGxQD08KuG58b/mz1llNrkEOai4fEyYvhNSx8SQNPNlI9RqdgcumZefqFErWhXI3
         Q5Wv1pvrZ9BPgscvAZ8E9MfWMx0npwQp/FxQjyoMQsGvZkZPtKzLUKMvGlkj3mbBUwSM
         /Ij1oUXudSeNA75AqpESgkKatCC3l12Y3m5+wimWgEQT+xXfcMdQ2hlOlz3ukN3oad9V
         zkk5oz76MnHestzpPx+iJmXyI0pRe8l156fQtprQN+eGmgv9ajWuq4ZZgZiVewSN/tgw
         4y1w==
X-Forwarded-Encrypted: i=1; AJvYcCUTrPX5Olgw0GYccVRGkrk8IJEjUe0Q6csR+ZQwKk58SmEPO+x7EGQSTHRpOEkULrXrIpCZ6+FEOgPfX0g=@vger.kernel.org, AJvYcCXC8xOotc+U1cPbfpjY0TRIbaEbD7QoPBHBIA44uSQdjm9sS1qMfRdbF/0suXmPDjZvSN1EgF7ebczVd7DrpRqq@vger.kernel.org
X-Gm-Message-State: AOJu0YxsUVF412BlAE388VdpeEVESi8SJVmPemNDlqUa77HEnp9gJgWd
	jhzNWTP2g7q6JVK8n7rBAT/KhYvQOhvLt+VVOgDPEnOKyEUlKMc=
X-Google-Smtp-Source: AGHT+IEve8HxoMBLYPBXREW/IQ8rQr+VlBoXiX0uAQiQOUjrlCCv7vNIOQoUXXJ5gLY/N23zW/Vv6g==
X-Received: by 2002:a05:6a20:c793:b0:1d8:d613:7d6f with SMTP id adf61e73a8af0-1d9a83a9a56mr20896378637.4.1730298821018;
        Wed, 30 Oct 2024 07:33:41 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a20f9asm9627350b3a.170.2024.10.30.07.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 07:33:40 -0700 (PDT)
Date: Wed, 30 Oct 2024 07:33:40 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Shuah Khan <shuah@kernel.org>, Yi Lai <yi1.lai@linux.intel.com>
Subject: Re: [PATCH net-next v1 6/7] net: fix SO_DEVMEM_DONTNEED looping too
 long
Message-ID: <ZyJDxK5stZ_RF71O@mini-arch>
References: <20241029205524.1306364-1-almasrymina@google.com>
 <20241029205524.1306364-2-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241029205524.1306364-2-almasrymina@google.com>

On 10/29, Mina Almasry wrote:
> Check we're going to free a reasonable number of frags in token_count
> before starting the loop, to prevent looping too long.
> 
> Also minor code cleanups:
> - Flip checks to reduce indentation.
> - Use sizeof(*tokens) everywhere for consistentcy.
> 
> Cc: Yi Lai <yi1.lai@linux.intel.com>
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> 
> ---
>  net/core/sock.c | 46 ++++++++++++++++++++++++++++------------------
>  1 file changed, 28 insertions(+), 18 deletions(-)
> 
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 7f398bd07fb7..8603b8d87f2e 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -1047,11 +1047,12 @@ static int sock_reserve_memory(struct sock *sk, int bytes)
> 
>  #ifdef CONFIG_PAGE_POOL
> 
> -/* This is the number of tokens that the user can SO_DEVMEM_DONTNEED in
> +/* This is the number of frags that the user can SO_DEVMEM_DONTNEED in
>   * 1 syscall. The limit exists to limit the amount of memory the kernel
> - * allocates to copy these tokens.
> + * allocates to copy these tokens, and to prevent looping over the frags for
> + * too long.
>   */
> -#define MAX_DONTNEED_TOKENS 128
> +#define MAX_DONTNEED_FRAGS 1024
> 
>  static noinline_for_stack int
>  sock_devmem_dontneed(struct sock *sk, sockptr_t optval, unsigned int optlen)
> @@ -1059,43 +1060,52 @@ sock_devmem_dontneed(struct sock *sk, sockptr_t optval, unsigned int optlen)
>  	unsigned int num_tokens, i, j, k, netmem_num = 0;
>  	struct dmabuf_token *tokens;
>  	netmem_ref netmems[16];
> +	u64 num_frags = 0;
>  	int ret = 0;
> 
>  	if (!sk_is_tcp(sk))
>  		return -EBADF;
> 
> -	if (optlen % sizeof(struct dmabuf_token) ||
> -	    optlen > sizeof(*tokens) * MAX_DONTNEED_TOKENS)
> +	if (optlen % sizeof(*tokens) ||
> +	    optlen > sizeof(*tokens) * MAX_DONTNEED_FRAGS)
>  		return -EINVAL;
> 
> -	tokens = kvmalloc_array(optlen, sizeof(*tokens), GFP_KERNEL);
> +	num_tokens = optlen / sizeof(*tokens);
> +	tokens = kvmalloc_array(num_tokens, sizeof(*tokens), GFP_KERNEL);
>  	if (!tokens)
>  		return -ENOMEM;
> 
> -	num_tokens = optlen / sizeof(struct dmabuf_token);
>  	if (copy_from_sockptr(tokens, optval, optlen)) {
>  		kvfree(tokens);
>  		return -EFAULT;
>  	}
> 
> +	for (i = 0; i < num_tokens; i++) {
> +		num_frags += tokens[i].token_count;
> +		if (num_frags > MAX_DONTNEED_FRAGS) {
> +			kvfree(tokens);
> +			return -E2BIG;
> +		}
> +	}
> +
>  	xa_lock_bh(&sk->sk_user_frags);
>  	for (i = 0; i < num_tokens; i++) {
>  		for (j = 0; j < tokens[i].token_count; j++) {
>  			netmem_ref netmem = (__force netmem_ref)__xa_erase(
>  				&sk->sk_user_frags, tokens[i].token_start + j);
> 
> -			if (netmem &&
> -			    !WARN_ON_ONCE(!netmem_is_net_iov(netmem))) {
> -				netmems[netmem_num++] = netmem;
> -				if (netmem_num == ARRAY_SIZE(netmems)) {
> -					xa_unlock_bh(&sk->sk_user_frags);
> -					for (k = 0; k < netmem_num; k++)
> -						WARN_ON_ONCE(!napi_pp_put_page(netmems[k]));
> -					netmem_num = 0;
> -					xa_lock_bh(&sk->sk_user_frags);
> -				}
> -				ret++;

[..]

> +			if (!netmem || WARN_ON_ONCE(!netmem_is_net_iov(netmem)))
> +				continue;

Any reason we are not returning explicit error to the callers here?
That probably needs some mechanism to signal which particular one failed
so the users can restart?

