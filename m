Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4755A779C47
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Aug 2023 03:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236089AbjHLBh4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Aug 2023 21:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjHLBh4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Aug 2023 21:37:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0463580
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Aug 2023 18:37:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83A7C64389
        for <linux-kselftest@vger.kernel.org>; Sat, 12 Aug 2023 01:37:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 451E3C433C7;
        Sat, 12 Aug 2023 01:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691804274;
        bh=Y3jlMG7U38Uvwq9s8XM0hS54dhwwvJi9rI3hlZA/GwI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VdN+8WRIQQxtvmjwzfT7j1VOMGnph7TNmRcEOh4aQLRZCCkVy3IAZpsz+LWNMGCfg
         JbrSTIuEDEhfRG3NzmXqZg6hPXzstIu/bYrKC59z5Z9pb2SlSrvCpoG5dCDpn23dw4
         X0iySDDTK3MYwAOQIAA4/upzUGDOouZIulxQnkzOrGgmeA3Fxvr06Wg7e2nRm8UVWx
         xldYuIePbx+G3NN86+HPaeNpzq/6/JG1GVhzhNaCkPVjoGUxJ8nS+o9AYGRMlnrw8D
         x6kdbi6MCRP8i7cmKcYZZHfftrQHtG/kc8MUK3yU/jWNVn6+ukfAhz4Fnx+FCpVuj9
         P/ZnfDEvYyOPQ==
Date:   Fri, 11 Aug 2023 18:37:53 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Sabrina Dubroca <sd@queasysnail.net>
Cc:     netdev@vger.kernel.org, Vadim Fedorenko <vfedorenko@novek.ru>,
        Frantisek Krenzelok <fkrenzel@redhat.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Apoorv Kothari <apoorvko@amazon.com>,
        Boris Pismenny <borisp@nvidia.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Gal Pressman <gal@nvidia.com>,
        Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH net-next v3 2/6] tls: block decryption when a rekey is
 pending
Message-ID: <20230811183753.3a18a09a@kernel.org>
In-Reply-To: <eae51cdb1d15c914577a88fb5cd9d1c4b1121642.1691584074.git.sd@queasysnail.net>
References: <cover.1691584074.git.sd@queasysnail.net>
        <eae51cdb1d15c914577a88fb5cd9d1c4b1121642.1691584074.git.sd@queasysnail.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed,  9 Aug 2023 14:58:51 +0200 Sabrina Dubroca wrote:
> +static int tls_check_pending_rekey(struct sock *sk, struct sk_buff *skb)
> +{
> +	const struct tls_msg *tlm = tls_msg(skb);
> +	const struct strp_msg *rxm = strp_msg(skb);
> +
> +	if (tlm->control == TLS_RECORD_TYPE_HANDSHAKE) {

unlikely()

does the nachine code look worse if we flip the condition and return
early instead of indenting the entire function?

> +		char hs_type;
> +		int err;

I'd probably err on the side of declaring those on the outside, but if
we don't we should move rxm in here, it's not needed outside. Either,
or.

> +		if (rxm->full_len < 1)
> +			return -EINVAL;
> +
> +		err = skb_copy_bits(skb, rxm->offset, &hs_type, 1);
> +		if (err < 0)
> +			return err;
> +
> +		if (hs_type == TLS_HANDSHAKE_KEYUPDATE) {
> +			struct tls_context *ctx = tls_get_ctx(sk);

feels a bit like we should just pass ctx rather than sk?

> +			struct tls_sw_context_rx *rx_ctx = ctx->priv_ctx_rx;
> +
> +			rx_ctx->key_update_pending = true;
> +		}
> +	}
> +
> +	return 0;
> +}
