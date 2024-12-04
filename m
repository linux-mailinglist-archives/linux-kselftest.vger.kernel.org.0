Return-Path: <linux-kselftest+bounces-22808-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE329E3245
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2024 04:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E776B293F0
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2024 03:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239906F06D;
	Wed,  4 Dec 2024 03:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jiZUFoaj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE59F17BA1;
	Wed,  4 Dec 2024 03:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733284023; cv=none; b=gc6B3CqIIG1B+Xex/OT2E78vz0TN+ntWoH6LlBi2el3VZ7NwY700K6tqN6a3bOi8IvHEu+byC8a0eFCBIrOGKjJjdphcc1S4wKrZrDhKdmcKFF/da908hZ5tYBZ2E2oSedQIVGDIgHoVnFQ0bOKT2nCvjcQx6ipeA8PHJIFEAcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733284023; c=relaxed/simple;
	bh=rV2kU3EXJi1nCePhMpNyNdzmMfRJXruCC3USeEGD31I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tJK6H/lnDJZ9cutIXV21cemDeoqQ+z4yyDERRa4WJC4S8O10fENER/lZLC0cNqcV5ljnIGVOfp4WJcyAz2pH2sr9NGtcoaGZp7IjFGe1kkOc+roo0hAqPFlQnF9sIKTo+8Wyzzq9CIQzBJDo5ec71ibSzkeQqgA3xCqecUCLySE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jiZUFoaj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F5FCC4CED1;
	Wed,  4 Dec 2024 03:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733284022;
	bh=rV2kU3EXJi1nCePhMpNyNdzmMfRJXruCC3USeEGD31I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jiZUFoajZ1VdviSWCV/zCWDPWG/1oOFQDpiDcFsI1RCBRxLCvQEwK9hOn7koG0Dq3
	 mKMlCNOjDcZb25GXAy+rw0uZKwmMAq+f9tmk6BlKeyA58LAlWyDC3yfi8D7F/VAkSW
	 uJuKMkl9GPHZuAXfcA8mzAfisM5tKXCTJn795gtBZmAdsRTnZ8mQ0e/WNagXd0tvD1
	 IDn3XMWRIHn7EWwO6tzr9lZYSbDVhL3AASR0NBnxQTh9Az7L65/vfgIxmbqQr7Tufq
	 KSTR37Mdg1CbprUX7jYXDGEXHkUEW6r5aHSfeW6uZPjcFnQM0c7+mrD+COjAj9nEtA
	 /JNNsENNecjbA==
Date: Tue, 3 Dec 2024 19:47:01 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vfedorenko@novek.ru>, Frantisek
 Krenzelok <fkrenzel@redhat.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
 Apoorv Kothari <apoorvko@amazon.com>, Boris Pismenny <borisp@nvidia.com>,
 John Fastabend <john.fastabend@gmail.com>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, Gal Pressman <gal@nvidia.com>, Marcel
 Holtmann <marcel@holtmann.org>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v4 1/6] tls: block decryption when a rekey is
 pending
Message-ID: <20241203194701.48e74c8e@kernel.org>
In-Reply-To: <327cb575d15fa5c5379f9c38a5132d78953fb648.1731597571.git.sd@queasysnail.net>
References: <cover.1731597571.git.sd@queasysnail.net>
	<327cb575d15fa5c5379f9c38a5132d78953fb648.1731597571.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Nov 2024 16:50:48 +0100 Sabrina Dubroca wrote:
> +static int tls_check_pending_rekey(struct tls_context *ctx, struct sk_buff *skb)
> +{
> +	const struct tls_msg *tlm = tls_msg(skb);
> +	const struct strp_msg *rxm = strp_msg(skb);
> +	char hs_type;
> +	int err;
> +
> +	if (likely(tlm->control != TLS_RECORD_TYPE_HANDSHAKE))
> +		return 0;
> +
> +	if (rxm->full_len < 1)
> +		return -EINVAL;
> +
> +	err = skb_copy_bits(skb, rxm->offset, &hs_type, 1);
> +	if (err < 0)
> +		return err;
> +
> +	if (hs_type == TLS_HANDSHAKE_KEYUPDATE) {
> +		struct tls_sw_context_rx *rx_ctx = ctx->priv_ctx_rx;
> +
> +		WRITE_ONCE(rx_ctx->key_update_pending, true);
> +	}
> +
> +	return 0;
> +}
> +
>  static int tls_rx_one_record(struct sock *sk, struct msghdr *msg,
>  			     struct tls_decrypt_arg *darg)
>  {
> @@ -1739,6 +1769,10 @@ static int tls_rx_one_record(struct sock *sk, struct msghdr *msg,
>  	rxm->full_len -= prot->overhead_size;
>  	tls_advance_record_sn(sk, prot, &tls_ctx->rx);
>  
> +	err = tls_check_pending_rekey(tls_ctx, darg->skb);
> +	if (err < 0)
> +		return err;

Sorry if I already asked this, is this 100% safe to error out from here
after we decrypted the record? Normally once we successfully decrypted
and pulled the message header / trailer we always call tls_rx_rec_done()

The only reason the check_pending_rekey() can fail is if the message is
mis-formatted, I wonder if we are better off ignoring mis-formatted
rekeys? User space will see them and break the connection, anyway.
Alternatively - we could add a selftest for this.

