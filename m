Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6C7777F6F
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Aug 2023 19:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235359AbjHJRoj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Aug 2023 13:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235218AbjHJRog (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Aug 2023 13:44:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CAE32722
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Aug 2023 10:44:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D24B9664F1
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Aug 2023 17:44:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B78B7C433C9;
        Thu, 10 Aug 2023 17:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691689472;
        bh=n0C0xsJRCoQ1zz3+jdXD559Dlf268Mp5wZ8Z51tNZx4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nJc3Jjr/fpHOiDL1uf3Za+t1c989oaqw5vSnc78UXLj6OkJBHAAdkVnCRsycLctBm
         KG8b2zA33JReA+svBmFKR7QrspW9NfZ5dU56In8kDIjXrGPGyVCwVH1Tm7reKpAqgo
         EZtzvwYw6BF9j3pxl4xVClx/ldac2YV0a4wGU+68o3OTCeq0xB1Lpn578BKYriABwP
         5vESzfXTddCfKAqUYgOuE0NVfqry+rNf5d2CYctwodhw3Z4oG/55x2fIzZ4sbAxkTO
         3QOg8vn67hTBEYDCvA+yuUVfzrJhZL/ROuqllDxEU/IlG51w3KIse0UsK2BbRG9E/m
         5wz0cLf/hpZKg==
Date:   Thu, 10 Aug 2023 19:44:27 +0200
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
Subject: Re: [PATCH net-next v3 2/6] tls: block decryption when a rekey is
 pending
Message-ID: <ZNUh+3EHK+R0/W2a@vergenet.net>
References: <cover.1691584074.git.sd@queasysnail.net>
 <eae51cdb1d15c914577a88fb5cd9d1c4b1121642.1691584074.git.sd@queasysnail.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eae51cdb1d15c914577a88fb5cd9d1c4b1121642.1691584074.git.sd@queasysnail.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 09, 2023 at 02:58:51PM +0200, Sabrina Dubroca wrote:
> When a TLS handshake record carrying a KeyUpdate message is received,
> all subsequent records will be encrypted with a new key. We need to
> stop decrypting incoming records with the old key, and wait until
> userspace provides a new key.
> 
> Make a note of this in the RX context just after decrypting that
> record, and stop recvmsg/splice calls with EKEYEXPIRED until the new
> key is available.
> 
> v3:
>  - move key_update_pending check into tls_rx_rec_wait (Jakub)
>  - TLS_RECORD_TYPE_HANDSHAKE was added to include/net/tls_prot.h by
>    the tls handshake series, drop that from this patch
>  - move key_update_pending into an existing hole
> 
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
> ---
>  include/net/tls.h |  3 +++
>  net/tls/tls_sw.c  | 36 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 39 insertions(+)
> 
> diff --git a/include/net/tls.h b/include/net/tls.h
> index 06fca9160346..219a4f38c0e4 100644
> --- a/include/net/tls.h
> +++ b/include/net/tls.h
> @@ -69,6 +69,8 @@ extern const struct tls_cipher_size_desc tls_cipher_size_desc[];
>  
>  #define TLS_CRYPTO_INFO_READY(info)	((info)->cipher_type)
>  
> +#define TLS_HANDSHAKE_KEYUPDATE		24	/* rfc8446 B.3: Key update */
> +
>  #define TLS_AAD_SPACE_SIZE		13
>  
>  #define MAX_IV_SIZE			16
> @@ -141,6 +143,7 @@ struct tls_sw_context_rx {
>  	u8 async_capable:1;
>  	u8 zc_capable:1;
>  	u8 reader_contended:1;
> +	bool key_update_pending;

Hi Sabrina,

Would it make sense for this to be

	u8 key_update_pending:1;

>  
>  	struct tls_strparser strp;
>  
> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index 2ca0eb90a2a5..497f56c5f169 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c
> @@ -1293,6 +1293,10 @@ tls_rx_rec_wait(struct sock *sk, struct sk_psock *psock, bool nonblock,
>  	DEFINE_WAIT_FUNC(wait, woken_wake_function);
>  	long timeo;
>  
> +	/* a rekey is pending, let userspace deal with it */
> +	if (unlikely(ctx->key_update_pending))
> +		return -EKEYEXPIRED;
> +
>  	timeo = sock_rcvtimeo(sk, nonblock);
>  
>  	while (!tls_strp_msg_ready(ctx)) {
> @@ -1689,6 +1693,33 @@ tls_decrypt_device(struct sock *sk, struct msghdr *msg,
>  	return 1;
>  }
>  
> +static int tls_check_pending_rekey(struct sock *sk, struct sk_buff *skb)
> +{
> +	const struct tls_msg *tlm = tls_msg(skb);
> +	const struct strp_msg *rxm = strp_msg(skb);

nit: reverse xmas tree

> +
> +	if (tlm->control == TLS_RECORD_TYPE_HANDSHAKE) {
> +		char hs_type;
> +		int err;
> +
> +		if (rxm->full_len < 1)
> +			return -EINVAL;
> +
> +		err = skb_copy_bits(skb, rxm->offset, &hs_type, 1);
> +		if (err < 0)
> +			return err;
> +
> +		if (hs_type == TLS_HANDSHAKE_KEYUPDATE) {
> +			struct tls_context *ctx = tls_get_ctx(sk);
> +			struct tls_sw_context_rx *rx_ctx = ctx->priv_ctx_rx;
> +
> +			rx_ctx->key_update_pending = true;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static int tls_rx_one_record(struct sock *sk, struct msghdr *msg,
>  			     struct tls_decrypt_arg *darg)
>  {
> @@ -1708,6 +1739,10 @@ static int tls_rx_one_record(struct sock *sk, struct msghdr *msg,
>  	rxm->full_len -= prot->overhead_size;
>  	tls_advance_record_sn(sk, prot, &tls_ctx->rx);
>  
> +	err = tls_check_pending_rekey(sk, darg->skb);
> +	if (err < 0)
> +		return err;
> +
>  	return 0;
>  }
>  
> @@ -2642,6 +2677,7 @@ int tls_set_sw_offload(struct sock *sk, int tx)
>  		skb_queue_head_init(&sw_ctx_rx->rx_list);
>  		skb_queue_head_init(&sw_ctx_rx->async_hold);
>  		aead = &sw_ctx_rx->aead_recv;
> +		sw_ctx_rx->key_update_pending = false;
>  	}
>  
>  	switch (crypto_info->cipher_type) {
> -- 
> 2.40.1
> 
> 
