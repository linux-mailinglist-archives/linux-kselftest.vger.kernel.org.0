Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEB57777FA8
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Aug 2023 19:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbjHJR4i (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Aug 2023 13:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbjHJR4h (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Aug 2023 13:56:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2406010C0
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Aug 2023 10:56:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACEF466524
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Aug 2023 17:56:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4FD8C433C7;
        Thu, 10 Aug 2023 17:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691690196;
        bh=jIRAXEP+/hVofwmvv0P+5psE1ZOVYRSQ3asUDxcA8qc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a2BGVdLRWAXqOCKMieEtCU/4DATms+FijEV9h3V7E8ykBPkNRICgX7eNO6kbOA8CD
         2FkI1cu7hj85W1ekHPwiDT5lTNKb4a9MD8SfjONT1UTH6UIOb+1rjZ3zYCA0VzYpl+
         Vm+0ff4EBFp00iiqNO4lnlXSQFjDx5QcsjkH/WsM7MG7yaEr9VVuiwsz0DAqm/YMpm
         IGVgsr+CUw0T6H8svv9VaQNoQA2SNGjzfU0j+MpB6b9YgZKGXiQaRVKYN3nKFmUmJR
         wCzl9nJHR0u/dlQogzYGXsgfoYCEepD3bgrRe2/IOwuVWwEME3F7rIqT6SDH+Tc8Cq
         co1q+m+Kp/qjA==
Date:   Thu, 10 Aug 2023 19:56:31 +0200
From:   Simon Horman <horms@kernel.org>
To:     Sabrina Dubroca <sd@queasysnail.net>
Cc:     netdev@vger.kernel.org, Vadim Fedorenko <vfedorenko@novek.ru>,
        Frantisek Krenzelok <fkrenzel@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Apoorv Kothari <apoorvko@amazon.com>,
        Boris Pismenny <borisp@nvidia.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Gal Pressman <gal@nvidia.com>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH net-next v3 3/6] tls: implement rekey for TLS1.3
Message-ID: <ZNUkz7UNMPQVOr2M@vergenet.net>
References: <cover.1691584074.git.sd@queasysnail.net>
 <c0ef5c0cf4f56d247081ce366eb5de09bf506cf4.1691584074.git.sd@queasysnail.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0ef5c0cf4f56d247081ce366eb5de09bf506cf4.1691584074.git.sd@queasysnail.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 09, 2023 at 02:58:52PM +0200, Sabrina Dubroca wrote:
> This adds the possibility to change the key and IV when using
> TLS1.3. Changing the cipher or TLS version is not supported.
> 
> Once we have updated the RX key, we can unblock the receive side. If
> the rekey fails, the context is unmodified and userspace is free to
> retry the update or close the socket.
> 
> This change only affects tls_sw, since 1.3 offload isn't supported.
> 
> v2:
>  - reverse xmas tree
>  - turn the alt_crypto_info into an else if
>  - don't modify the context when rekey fails
> 
> v3:
>  - only call tls_sw_strparser_arm when setting the initial RX key, not
>    on rekeys
>  - update tls_sk_poll to not say the socket is readable when we're
>    waiting for a rekey, and wake up poll() when the new key is installed
>  - use unsafe_memcpy to make FORTIFY_SOURCE happy
> 
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>

...

> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c

...

> @@ -2873,14 +2911,24 @@ int tls_set_sw_offload(struct sock *sk, int tx)
>  
>  	ctx->push_pending_record = tls_sw_push_pending_record;
>  
> +	/* setkey is the last operation that could fail during a
> +	 * rekey. if it succeeds, we can start modifying the
> +	 * context.
> +	 */
>  	rc = crypto_aead_setkey(*aead, key, keysize);
> +	if (rc) {
> +		if (new_crypto_info)
> +			goto out;
> +		else
> +			goto free_aead;
> +	}
>  
> -	if (rc)
> -		goto free_aead;
> -
> -	rc = crypto_aead_setauthsize(*aead, prot->tag_size);
> -	if (rc)
> -		goto free_aead;
> +	if (!new_crypto_info) {
> +		rc = crypto_aead_setauthsize(*aead, prot->tag_size);
> +		if (rc) {
> +			goto free_aead;
> +		}

nit: no need for {} here.

> +	}
>  
>  	if (sw_ctx_rx) {
>  		tfm = crypto_aead_tfm(sw_ctx_rx->aead_recv);

...
