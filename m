Return-Path: <linux-kselftest+bounces-25684-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F29C5A2749D
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 15:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EB30161F06
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 14:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CC62135DA;
	Tue,  4 Feb 2025 14:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mtvdYWgm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E64182B4;
	Tue,  4 Feb 2025 14:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738680172; cv=none; b=jsTc4XXVIfs2voOdLKw16R2l/rSXRt/mj0uKe2McMmj3iWqSyOicJ7gQ4KVwvnMsDN4m0+wVImQWEe3P7n8AEb/TG2OuN5qSKxLeOPg0BENDiDo4rYJMCSrX9brAmQe+upBjlIIghKIbCglQG67Y1geJOPf4AwwiwX26Y3KGuRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738680172; c=relaxed/simple;
	bh=xChqM6VAZuUHJwXRt/1YXjfqTaIoqnrbU7E9gcCHRbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tTgmNJfnpQt4xR5HPwTRnZKfBJEPeqS8TlzA56pSAFtoA9cFO5gbBBdlsI1UuVECq7d0NN2pKtJEOQQeCy+FWsuaadkaJmAJwcWvM954RkvDpr/3wJL6Jl8uWHYlgB2DJaiaJ9ryHhe3KEUbk21DKvavVWzWWMtT3tfqjwNZ9rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mtvdYWgm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11F02C4CEDF;
	Tue,  4 Feb 2025 14:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738680171;
	bh=xChqM6VAZuUHJwXRt/1YXjfqTaIoqnrbU7E9gcCHRbU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mtvdYWgmur3xlm5J/J0k9LkhPL1TqkvSYNV74n3uwbQJ+Xgxh1TY0leqU1kZZt81n
	 kEAfAtQMw2jK+wnoTYR916XRgj1X49ZH89PeIwFYtvXrHnQWFjINNq94j1XTB1+u8o
	 +XbUtEWaAGElHLBuqf0KLf8tC2sZOy9FuA/ERslYlPQ14nQXPkhG5c2NpZ+2yMB+3Z
	 7H93iM72dIa5YlGSk4xsC5pzfBq/DP9HrdFZqhEkOUtvnnXuaDEBLPWzCKOzpzEjiR
	 oJ1JxecRlVFLaaRFmMymwMgWgYu3IdBMLGVincdbZEh1DhTgYAZOZXiZFXtkmRjp3C
	 hryNLKI/chGGQ==
Date: Tue, 4 Feb 2025 14:42:45 +0000
From: Simon Horman <horms@kernel.org>
To: Peter Seiderer <ps.report@gmx.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Nam Cao <namcao@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Artem Chernyshev <artem.chernyshev@red-soft.ru>
Subject: Re: [PATCH net-next v3 01/10] net: pktgen: replace ENOTSUPP with
 EOPNOTSUPP
Message-ID: <20250204144245.GF234677@kernel.org>
References: <20250203170201.1661703-1-ps.report@gmx.net>
 <20250203170201.1661703-2-ps.report@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203170201.1661703-2-ps.report@gmx.net>

On Mon, Feb 03, 2025 at 06:01:52PM +0100, Peter Seiderer wrote:
> Replace ENOTSUPP with EOPNOTSUPP, fixes checkpatch hint
> 
>   WARNING: ENOTSUPP is not a SUSV4 error code, prefer EOPNOTSUPP
> 
> and e.g.
> 
>   $ echo "clone_skb 1" > /proc/net/pktgen/lo\@0
>   -bash: echo: write error: Unknown error 524
> 
> Signed-off-by: Peter Seiderer <ps.report@gmx.net>

Reviewed-by: Simon Horman <horms@kernel.org>


