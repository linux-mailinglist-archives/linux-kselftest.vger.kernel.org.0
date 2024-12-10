Return-Path: <linux-kselftest+bounces-23126-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C88C9EBF54
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 00:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78786284B7E
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Dec 2024 23:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C2B1EE7AD;
	Tue, 10 Dec 2024 23:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gIo0mEZv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC101A3056;
	Tue, 10 Dec 2024 23:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733873592; cv=none; b=l09SwnFSYCHJ+pgMjP3vyNB1qiQ/T6QBOu2/WKG5VB4T/WdkggSC2xMu0k3kD1k8BiTRUN3ZEll2aV9TMFilaVYA5ZpvVvzsYKPNFiWEnKHm525/eXqn6o/9SYNZFFuU1MczuY00cV4AG1aMjyZTg9yVzDEFDqb56Dhle8I7gSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733873592; c=relaxed/simple;
	bh=E2mnBLhTWM+I9hJhwY4TEXvbKF5r9VIcpGS6+gV2Qic=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EUSsgKsvNyvQ5Z8/i8gSU8U7TrQveMyHbVU+QSnUIxI+fftJaFy5vD5htHcdXtNfdQF65uq2CC7cqMkYrglsXNRLdPwExS6DTogoejnNZ3azHWtKPaOrrsM2NxN8kcWwPhOcAM97cbHIr6ZWf5zUJ+GhnvBvklAK8/G+A6hwEiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gIo0mEZv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A307C4CED6;
	Tue, 10 Dec 2024 23:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733873592;
	bh=E2mnBLhTWM+I9hJhwY4TEXvbKF5r9VIcpGS6+gV2Qic=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gIo0mEZvHLjQEnnrLvgiE3fg6IpC9FzdhUkSUbGqknhAigLL0ZVAnCXiHSWyC+ohH
	 niCAJehiNb/e2TLsYj/4kFEuKB+tVLqG9LkkDrQ2sjvrVGV5pxv9hBek1pmlwPea6G
	 z465GXnjcVFBcd86yXfP/X0JY7lSZcAp0nCOdhqBKSAH2zkxBulyukm/EVrVcBUPLa
	 jSpxlrcLzNTWpVk6VQlbjY7obcnbb4dtY64vfg3IeHRGLNgINOiI+Ybyu0hNq+9Sgv
	 g9twsGFhMWIp0LIVDlwcoY3bvV8TChT2g1PkPg/VfuH2hdAutC33zxsg+mIBOm3j7u
	 VPti+IE3yqoLw==
Date: Tue, 10 Dec 2024 15:33:10 -0800
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
Message-ID: <20241210153310.6535e6b3@kernel.org>
In-Reply-To: <Z1hpSbYKgytCFiPG@hog>
References: <cover.1731597571.git.sd@queasysnail.net>
	<327cb575d15fa5c5379f9c38a5132d78953fb648.1731597571.git.sd@queasysnail.net>
	<20241203194701.48e74c8e@kernel.org>
	<Z1hpSbYKgytCFiPG@hog>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Dec 2024 17:16:09 +0100 Sabrina Dubroca wrote:
> > The only reason the check_pending_rekey() can fail is if the message is
> > mis-formatted, I wonder if we are better off ignoring mis-formatted
> > rekeys? User space will see them and break the connection, anyway.
> > Alternatively - we could add a selftest for this.  
> 
> Going back to tls_check_pending_rekey():
> 
> > > +	if (rxm->full_len < 1)
> > > +		return -EINVAL;  
> 
> There's no real reason to fail here, we should probably just ignore
> it. It's not a rekey, and it's not a valid handshake message, but one
> could say that's not the kernel's problem. I'll make that return 0
> unless you want to keep -EINVAL.

returning 0 SGTM

> Hard to write a selftest for because we'd have to do a sendmsg with
> len=0, or do the crypto in the selftest.
> 
> > > +	err = skb_copy_bits(skb, rxm->offset, &hs_type, 1);
> > > +	if (err < 0)
> > > +		return err;  
> 
> This probably means that the skb we got from the parser was broken. If
> we can't read 1B with full_len >= 1, something's wrong. Maybe worth a
> DEBUG_NET_WARN_ON_ONCE?

Also SG!

> > > +	if (hs_type == TLS_HANDSHAKE_KEYUPDATE) {  
> 
> Here I don't actually check if it's a correct KeyUpdate message [1],
> we pause decryption and let userspace decide what to do (probably
> break the connection as you said).

