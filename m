Return-Path: <linux-kselftest+bounces-5112-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 692CE85CD91
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 02:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51F511C22D4E
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 01:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3BA443E;
	Wed, 21 Feb 2024 01:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MW4/EGGp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8D317D5;
	Wed, 21 Feb 2024 01:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708480255; cv=none; b=YIK2rAG064n+u3VGsKigUrlLEM37bG7+F+5oVpbBKvzaad3vImxL9rWnAbAXhwU7sYl1KV8qmEqfapzKzku2RhY+dkcWouxT+pU3QG44kjTAd+iuXK7nB1XEEzq6Zmh4+H+OA+xqZDI3QCI3lwg0l6Hb4zYtyHM/x0jNAnOd4d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708480255; c=relaxed/simple;
	bh=VTY6GLJgQzc7n965NSmu5mOJ+wfMjdFW7l8tdFghMKo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Csy27N+xKhDe0qH1uK8OcXXNsZiAAWyxVA1bsnIXxr7qWx6L+EiAElaHMuPx6c8Ew96bdCaU9pUgzB3ypQE3k1/eT/rlI/twwIcF/DNccugaCLwBbCf2jEncahRtXam0fYe0O3VS7ziiFvgazKd4PqEkuMo3ZtP0RLkCXelJpQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MW4/EGGp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F3D0C433C7;
	Wed, 21 Feb 2024 01:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708480254;
	bh=VTY6GLJgQzc7n965NSmu5mOJ+wfMjdFW7l8tdFghMKo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MW4/EGGpRUOlxB/9AV5/eY5TjaHNRnG3lRSQWYhcUpRdcAsoEnVRQHD6C2GUlkG/c
	 dqtMIhy8ee1FJeqOvSl6QPyP3B7tdMBZmnsQYUg5/nZrTohX3JYGsbRZp1keQUdAS7
	 JqdMuXSkNaws+YuG0eMglGAIvighf/Q0BepuJLgB8rziByULoxz+pgTh6sVMGO4uqf
	 Z+NwJ66dm5ouLWkojUrsnqqR8litXDhxS5/9+Yshbu714HBLAgsh2B2CoPSJgw3wB+
	 ryKfe4LZgLJ0YQwohqJQhPg97Q/rV/cujqcRS2GXnByPBohruxi4E9QXJ3ZZnRjbrP
	 odDgW5hZdI+1g==
Date: Tue, 20 Feb 2024 17:50:53 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Boris Pismenny <borisp@nvidia.com>, John
 Fastabend <john.fastabend@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Vakul Garg
 <vakul.garg@nxp.com>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net 3/5] tls: don't skip over different type records
 from the rx_list
Message-ID: <20240220175053.16324f4d@kernel.org>
In-Reply-To: <ZdPgAjFobWzrg_qY@hog>
References: <cover.1708007371.git.sd@queasysnail.net>
	<f00c0c0afa080c60f016df1471158c1caf983c34.1708007371.git.sd@queasysnail.net>
	<20240219120703.219ad3b2@kernel.org>
	<ZdPgAjFobWzrg_qY@hog>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Feb 2024 00:10:58 +0100 Sabrina Dubroca wrote:
> 2024-02-19, 12:07:03 -0800, Jakub Kicinski wrote:
> > On Thu, 15 Feb 2024 17:17:31 +0100 Sabrina Dubroca wrote:  
> > > @@ -1772,7 +1772,8 @@ static int process_rx_list(struct tls_sw_context_rx *ctx,
> > >  			   u8 *control,
> > >  			   size_t skip,
> > >  			   size_t len,
> > > -			   bool is_peek)
> > > +			   bool is_peek,
> > > +			   bool *more)
> > >  {
> > >  	struct sk_buff *skb = skb_peek(&ctx->rx_list);
> > >  	struct tls_msg *tlm;  
> > 
> > > @@ -1844,6 +1845,10 @@ static int process_rx_list(struct tls_sw_context_rx *ctx,
> > >  
> > >  out:
> > >  	return copied ? : err;
> > > +more:
> > > +	if (more)
> > > +		*more = true;
> > > +	goto out;  
> > 
> > Patches look correct, one small nit here -
> > 
> > I don't have great ideas how to avoid the 7th argument completely but   
> 
> I hesitated between this patch and a variant combining is_peek and
> more into a single u8 *flags, but that felt a bit messy (or does that
> fall into what you describe as "not [having] great ideas"? :))

I guess it saves a register, it seems a bit better but then it's a
truly in/out argument :)

> > I think it'd be a little cleaner if we either:
> >  - passed in err as an output argument (some datagram code does that
> >    IIRC), then function can always return copied directly, or   
> 
> (yes, __skb_wait_for_more_packets, __skb_try_recv_datagram, and their
> variants)
> 
> >  - passed copied as an output argument, and then we can always return
> >    err?  
> 
> Aren't those 2 options adding an 8th argument?

No, no, still 7, if we separate copied from err - checking err < 0
is enough to know that we need to exit.

Differently put, perhaps, my preference is to pass an existing entity
(err or copied), rather that conjure new concept (more) on one end and
interpret it on the other.

> I tend to find ">= 0 on success, otherwise errno" more readable,
> probably because that's a very common pattern (either for recvmsg
> style of cases, or all the ERR_PTR type situations).

Right it definitely is a good pattern. I think passing copied via
argument would give us those semantics still?

> > I like the former a little better because we won't have to special case
> > NULL for the "after async decryption" call sites.  
> 
> We could also pass &rx_more every time and not check for NULL.
> 
> What do you want to clean up more specifically? The number of
> arguments, the backwards goto, the NULL check before setting *more,
> something else/all of the above?

Not compiled, but what I had in mind was something along the lines of:

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 9fbc70200cd0..6e6e6d89b173 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1772,7 +1772,8 @@ static int process_rx_list(struct tls_sw_context_rx *ctx,
 			   u8 *control,
 			   size_t skip,
 			   size_t len,
-			   bool is_peek)
+			   bool is_peek,
+			   int *out_copied)
 {
 	struct sk_buff *skb = skb_peek(&ctx->rx_list);
 	struct tls_msg *tlm;
@@ -1843,7 +1844,8 @@ static int process_rx_list(struct tls_sw_context_rx *ctx,
 	err = 0;
 
 out:
-	return copied ? : err;
+	*out_copied = copied;
+	return err;
 }
 
 static bool
@@ -1966,11 +1968,10 @@ int tls_sw_recvmsg(struct sock *sk,
 		goto end;
 
 	/* Process pending decrypted records. It must be non-zero-copy */
-	err = process_rx_list(ctx, msg, &control, 0, len, is_peek);
+	err = process_rx_list(ctx, msg, &control, 0, len, is_peek, &copied);
 	if (err < 0)
 		goto end;
 
-	copied = err;
 	if (len <= copied)
 		goto end;
 
@@ -2128,10 +2129,10 @@ int tls_sw_recvmsg(struct sock *sk,
 		/* Drain records from the rx_list & copy if required */
 		if (is_peek || is_kvec)
 			err = process_rx_list(ctx, msg, &control, copied,
-					      decrypted, is_peek);
+					      decrypted, is_peek, &ret);
 		else
 			err = process_rx_list(ctx, msg, &control, 0,
-					      async_copy_bytes, is_peek);
+					      async_copy_bytes, is_peek, &ret);
 	}
 
 	copied += decrypted;

