Return-Path: <linux-kselftest+bounces-4942-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B88985ACC4
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Feb 2024 21:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3783A1C21636
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Feb 2024 20:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3246051C2B;
	Mon, 19 Feb 2024 20:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iEpsB0pG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0821D374DD;
	Mon, 19 Feb 2024 20:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708373225; cv=none; b=hwBHYhNxYtgG+/oMiY1TaD772BXt+nCaP8i3YES0F9sNyeOzKRh/OnbLyfZgVGXOZJ4in4BJzjof77jOmAzNE4cPMGLcQl2+K9dpqGzi4hDizQw1jxFFgqoJZn2QRUqcMwzF+vQgpFc8PCCE7jP7NWKPUpsAzgFwXQ0lSMLklW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708373225; c=relaxed/simple;
	bh=YRkjhL1i/ZXfWAIelIA27ZJxiVv++KYXLYGIOkzBnoo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FOXNWRlprE0E03ZTnlfWIDFh+kbrTXSR0Zer+sSR5hSecOHcMF7b1vAOKGhj89S/c+ntiqKW2piv13dcMRf9SS38I59ACbGOclvnZ30I7EJAACGKPUZ07b8cbmVCjLwEm3FfZCmzpyhHO8TEZAqqijVsnFk+RiKBRfOqr1ih4F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iEpsB0pG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C2CCC433F1;
	Mon, 19 Feb 2024 20:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708373224;
	bh=YRkjhL1i/ZXfWAIelIA27ZJxiVv++KYXLYGIOkzBnoo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iEpsB0pGv+bHi4qBi15bwop7SMlsDjDxMGsUaQmYBJxGvtiv9hYv/mKNNViKHkQNa
	 SlW4GeeQAZdkFOdj1WL8Zp+6vo7XVvYFMuNZIq5yePGNcuM5a0HHOkuJ9L1uGHwIsz
	 nOyFaxRTaUycm7y06lSOka2nAV2mkyxA1rJyvoLFnERAW0n9ZLZdEcfdWtr10xdAy6
	 hIsqNJfVEk1IFRxKgxPY1hwybVlfYGakWzkCiMaeWYzqpvmyenbpQQBBjvdhrww02F
	 E3PoguqUc0nHfhoWP1fXuThNjNVWpyTes8i78zlXMEQrnlBujgKYe2wuY5qWjkz5kY
	 dAx6Ev6vD9CxA==
Date: Mon, 19 Feb 2024 12:07:03 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Boris Pismenny <borisp@nvidia.com>, John
 Fastabend <john.fastabend@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Vakul Garg
 <vakul.garg@nxp.com>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net 3/5] tls: don't skip over different type records
 from the rx_list
Message-ID: <20240219120703.219ad3b2@kernel.org>
In-Reply-To: <f00c0c0afa080c60f016df1471158c1caf983c34.1708007371.git.sd@queasysnail.net>
References: <cover.1708007371.git.sd@queasysnail.net>
	<f00c0c0afa080c60f016df1471158c1caf983c34.1708007371.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Feb 2024 17:17:31 +0100 Sabrina Dubroca wrote:
> @@ -1772,7 +1772,8 @@ static int process_rx_list(struct tls_sw_context_rx *ctx,
>  			   u8 *control,
>  			   size_t skip,
>  			   size_t len,
> -			   bool is_peek)
> +			   bool is_peek,
> +			   bool *more)
>  {
>  	struct sk_buff *skb = skb_peek(&ctx->rx_list);
>  	struct tls_msg *tlm;


> @@ -1844,6 +1845,10 @@ static int process_rx_list(struct tls_sw_context_rx *ctx,
>  
>  out:
>  	return copied ? : err;
> +more:
> +	if (more)
> +		*more = true;
> +	goto out;

Patches look correct, one small nit here -

I don't have great ideas how to avoid the 7th argument completely but 
I think it'd be a little cleaner if we either:
 - passed in err as an output argument (some datagram code does that
   IIRC), then function can always return copied directly, or 
 - passed copied as an output argument, and then we can always return
   err?
I like the former a little better because we won't have to special case
NULL for the "after async decryption" call sites.

