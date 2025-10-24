Return-Path: <linux-kselftest+bounces-43965-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 194EEC0408F
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 03:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E05FA4E225F
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 01:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51DB1C701F;
	Fri, 24 Oct 2025 01:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ouUbOohm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B056338FA6;
	Fri, 24 Oct 2025 01:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761270248; cv=none; b=mSxZQC8RsQse+ABlelLVc4Thu/868Idf8JLi0shmRTz035VvNaPNsxgB+a8X/5U4cFjmbqlI6G4mxGpUwKcLYDphd+eXQzFhhElsD8p195WEFfIRAg/kdcI/mZXQ4oyTO6mKYw7ZDZZKx2sEMv1mRlYysXojFlqro4NoE3mBLwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761270248; c=relaxed/simple;
	bh=axiWZbssjlpH1aFl7mg+golcYlw6gkQMBkAvr0ja23s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZeTA389PaaahGBL02fBv6IMUKd37x0ZZl7YRXrQZpo/3Quqyzp2dyarnshhj2yPOmEjWJpcdB2HUd4hYtxSpk/sSenms6yE9eoEODSmanRURpEPvIUr+Y+W8o3cApO5AUlEFwrI9wPGuiWDashFKEHZBcbbxkvPdPxqR8pFYDWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ouUbOohm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 727FAC4CEE7;
	Fri, 24 Oct 2025 01:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761270246;
	bh=axiWZbssjlpH1aFl7mg+golcYlw6gkQMBkAvr0ja23s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ouUbOohmzSE5kKxvkHQ+qoiD369U/2WAfU+44lSxnZIB3JmmNxl2ypBy3UyIUbAU1
	 W+BaQkk+B74MG9QlEmPVicFy3+nE8qt61HCrpeAKqU+1cVm97KU7ILDS85m+D421ks
	 HD+n7f7zNOUm+zNd6ODja0+nhxjeJifwDXSOedHQ10hpTFI+zOQS7KEOq1a/Fwkc1m
	 hdyNf//vazgKOqE8jumapXnzgSPuLmBrnW+1SCiHiShVyd124qTfA4M7p7ZS+Vne1w
	 V1NB7tXEdfvu1F4gkvxtdYDtxky2pwLzmvM+E4G4nPK6vnoG4LbRVSWHPDIhuyB8s4
	 ZhluJuGJTjPJg==
Date: Thu, 23 Oct 2025 18:44:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wilfred Mallawa <wilfred.opensource@gmail.com>, Sabrina Dubroca
 <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Simon Horman
 <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Shuah Khan
 <shuah@kernel.org>, Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: Re: [PATCH net-next v8 1/2] net/tls: support setting the maximum
 payload size
Message-ID: <20251023184404.4dd617f0@kernel.org>
In-Reply-To: <20251022001937.20155-1-wilfred.opensource@gmail.com>
References: <20251022001937.20155-1-wilfred.opensource@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Oct 2025 10:19:36 +1000 Wilfred Mallawa wrote:
> +TLS_TX_MAX_PAYLOAD_LEN
> +~~~~~~~~~~~~~~~~~~~~~~
> +
> +Specifies the maximum size of the plaintext payload for transmitted TLS records.
> +
> +When this option is set, the kernel enforces the specified limit on all outgoing
> +TLS records. No plaintext fragment will exceed this size. This option can be used
> +to implement the TLS Record Size Limit extension [1].
> +
> +* For TLS 1.2, the value corresponds directly to the record size limit.
> +* For TLS 1.3, the value should be set to record_size_limit - 1, since
> +  the record size limit includes one additional byte for the ContentType
> +  field.
> +
> +The valid range for this option is 64 to 16384 bytes for TLS 1.2, and 63 to
> +16384 bytes for TLS 1.3. The lower minimum for TLS 1.3 accounts for the
> +extra byte used by the ContentType field.
> +
> +[1] https://datatracker.ietf.org/doc/html/rfc8449

Sorry for not paying attention to the last few revisions.

So we decided to go with the non-RFC definition of the sockopt
parameter? Is there a reason for that? I like how the "per RFC"
behavior shifts any blame away from us :)

> +	err = nla_put_u16(skb, TLS_INFO_TX_MAX_PAYLOAD_LEN,
> +			  ctx->tx_max_payload_len);
> +

nit: unnecessary empty line 

> +	if (err)
> +		goto nla_failure;


