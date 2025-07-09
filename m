Return-Path: <linux-kselftest+bounces-36877-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 404A5AFF2D0
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 22:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14A17162DE1
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 20:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5631A221267;
	Wed,  9 Jul 2025 20:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DrdI+k3p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F49B5661;
	Wed,  9 Jul 2025 20:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752092284; cv=none; b=HgPsKzxDXs55mBZBL5LQh7QnirVcMsJ5/09OxAaqZqncNHG6xa4eXpZEu/mZ0Ydz4j8H1rS/KTK0E0B6lQB12s4+obw9vIZx7BzWjp3q5F81oXeirdC2VFaN0PIAqsC60KEwVcJMDj2BA4fs32l1YJ/QvmUCM97CdZ7tw3/Gvb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752092284; c=relaxed/simple;
	bh=RlYoB+kZXiNeUDJwbYgQWmg8iP/ByZitMwbHNP6vQLY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lpxKoWX/XuxS5CTccywWlnPyV3H5iKLzn5XokmvtLoC6+rbAHkl+IvH+RPYbDj81F8RJgR5Ka99Z44qHs7BXiFeTNmHLhPMTkTQsa+/oxXEvW4Gi/EryccuRhu7IoBRKUewdMKsq0z/5BmNDUcBDaUrU5nfmidGYuch7R3UpZHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DrdI+k3p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44CB0C4CEEF;
	Wed,  9 Jul 2025 20:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752092281;
	bh=RlYoB+kZXiNeUDJwbYgQWmg8iP/ByZitMwbHNP6vQLY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DrdI+k3p53YVgWVZFb6P58txnLKWzPiZ3uKrdRzScDeb1Nz6zeY6F4KBO+H7nCqrx
	 XwuuxwVFOZLzv/5FM5BTG0bQas+WmPUnwT+4EZrl4D0fWIAnA4e7sKcK2CJWxTSMq0
	 U47a5NXlQDtRt9QTSCFXGK3Np2D6SnAP6esgKhKR6uXNdrKdRTGCneCqj/rURkpwM6
	 AsBMelU1jz9R5cIuvYEcWGQybBqVjtuHPcOaGJ52VkL4PYqwaZuNtQ+LK3kJ0akibR
	 0nbz0kZAeA2sHdqITGz8gPYyIEgmUnl8ADsWZwPFO0lLsLo4D95ZEDEYQSIb+WgPu1
	 3iHNj+Qi5vapQ==
Date: Wed, 9 Jul 2025 13:18:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nimrod Oren <noren@nvidia.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Willem de Bruijn
 <willemb@google.com>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Gal Pressman <gal@nvidia.com>, Carolina
 Jubran <cjubran@nvidia.com>
Subject: Re: [PATCH net] selftests: drv-net: rss_ctx: Add short delay
 between per-context traffic checks
Message-ID: <20250709131800.580fde62@kernel.org>
In-Reply-To: <6b8c512d-ced5-4116-9dde-fee081fda850@nvidia.com>
References: <20250629111812.644282-1-noren@nvidia.com>
	<20250701172352.5dd42418@kernel.org>
	<6b8c512d-ced5-4116-9dde-fee081fda850@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 9 Jul 2025 20:10:14 +0300 Nimrod Oren wrote:
> On 02/07/2025 3:23, Jakub Kicinski wrote:
> > On Sun, 29 Jun 2025 14:18:12 +0300 Nimrod Oren wrote:  
> >> A few packets may still be sent and received during the termination of
> >> the iperf processes. These late packets cause failures when they arrive
> >> on queues expected to be empty.
> >>
> >> Add a one second delay between repeated _send_traffic_check() calls in
> >> rss_ctx tests to ensure such packets are processed before the next
> >> traffic checks are performed.  
> > 
> > Sprinklings sleeps should be last resort. Is there a way to wait for
> > iperf to shut down cleanly, or wait for the socket to be closed fully?
> > Like wait_port_listen() ?  
> 
> The socket may end up in TIME_WAIT state, so waiting for it to be fully
> closed can take ~2 mins.

TIME_WAIT is as good as CLOSED for our purposes. Once we got a FIN
the chances of more traffic should be minuscule.

