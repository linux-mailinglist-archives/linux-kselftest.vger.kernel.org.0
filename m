Return-Path: <linux-kselftest+bounces-34973-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA61AD992B
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 02:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B3DC1BC2879
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Jun 2025 00:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79284F50F;
	Sat, 14 Jun 2025 00:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bXkUclRN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAEF1DA21;
	Sat, 14 Jun 2025 00:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749861755; cv=none; b=gTCIYvb4yb2xWG9cuNOl4DdkNtXy5vz94/T9Pz2474CSJQn3kLjO264UO3qY1Y72N5oW0eHJSB1Zf93BRz3xLmLJmmUJCnbOhKyu9Y4rxaDcLzwfrHvYDwbQXmS67WKbP2/Ysv8dh480polZlnc9xFDgz5FtGWwRS7uXh9/pEZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749861755; c=relaxed/simple;
	bh=uKOM6v2+PmgvnG+WAFLlO7XD04kdLzHE/y0185cyEF0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rwksGY6iGV7fZz6uvdSq7UMsD6ogpULO1JcAoKN7r6v3ENoNEoCxBa2KJPKnzglWfFPd1oYmmicv03p3HPDgMUZhJeWyfRmigOpiauxhiCCtC4gUAcle1EOB70/80YlM/vUbp8w+oQmhOylSFQ3MOZwe+mKiHSfZLt9J4a6WXwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bXkUclRN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86738C4CEE3;
	Sat, 14 Jun 2025 00:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749861754;
	bh=uKOM6v2+PmgvnG+WAFLlO7XD04kdLzHE/y0185cyEF0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bXkUclRNSN6m6vpPZomqtLo1fg3/gMtnNS5yaEjfpzFG45nmtiWZaF2ICVTS7ref8
	 GzkHmhTpa8o6e5FCTS9roW7k/N7guK8j0QrCbj1Eyrt/2+iGoJMDnYphFEyFnDy+LB
	 oRjWAQdm5UQ3DUox+B+mbUbeZzS+NcR2EUtheaN2GveHYQ84rocGfZLPqizL/6kwlv
	 JsRsWSvzhDr/Q4WiE4yh6r3i8P2KlssGsH47jKxE1n7gmfJc/YUpzbq0V0JT5Dmrcc
	 zAbZ6n/6vnAhcLMDO7DPgfaPV/TtcKfReitejFQ+YY1FdlPxNIjxDnJAPe4xOlXzsn
	 rI/n7B0/8eotQ==
Date: Fri, 13 Jun 2025 17:42:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
 <shuah@kernel.org>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, ast@kernel.org
Subject: Re: [PATCH net-next RFC] selftests: net: add netpoll basic
 functionality test
Message-ID: <20250613174233.0dd5e7c1@kernel.org>
In-Reply-To: <aEwd9oLRnxna97JK@gmail.com>
References: <20250612-netpoll_test-v1-1-4774fd95933f@debian.org>
	<684b8e8abb874_dcc45294a5@willemb.c.googlers.com.notmuch>
	<aEwd9oLRnxna97JK@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Jun 2025 05:47:50 -0700 Breno Leitao wrote:
> > Or is there another way that the packets could be observed, e.g.,
> > counters.  
> 
> Unfortunately netpoll doesn't expose any data, thus, it is hard to get
> it. 
> 
> I have plans to create a configfs for netpoll, so, we can check for
> these numbers (as also configure some pre-defined values today, such as
> USEC_PER_POLL, MAX_SKBS, ip6h->version = 6; ip6h->priority = 0, etc.
> 
> In fact, I've an private PoC for this, but, I am modernizing the code
> first, and creating some selftests to help me with those changes later
> (given we have very little test on netpoll, and I aim to improve this,
> given how critical it is for some datacenter designs).

FWIW you can steal bpftrace integration from this series:
https://lore.kernel.org/all/20250421222827.283737-22-kuba@kernel.org/

