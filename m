Return-Path: <linux-kselftest+bounces-42617-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4259BAC268
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Sep 2025 10:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1488319255A5
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Sep 2025 09:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE882F49F8;
	Tue, 30 Sep 2025 08:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T2C+yg0W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA54F4C98;
	Tue, 30 Sep 2025 08:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759222791; cv=none; b=PdwXBlZM2lWGkA4s7+ZLcVKkloDF31nTRy32Xt29jc/XTLXNMhuM8g9Rbs6ph4raEZ5/aIghZN5k6w3KH7ALeZksCTMWRwP5L1OY6KG9D6wz/awn6LT7peY4GcWKOaAioJuNnWioJQa6g5YtePjglDcA/Ajh589vrpfsOkzSmVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759222791; c=relaxed/simple;
	bh=oJFDk7uf6zKXMoNGO8tTRx82bidosJEPLMEojlFOQ9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=toB0prsecX7JVXy8+Jz5++qedZHsFzAi3TaBLQ5Aw2DCC5ZvKvX1jZ8ARcu10s6mmx9+27I+YvC3l5dBeRkF4Z5GjrnJH6j+clGd1S9tdIOC9aXYfuWTet9i80sBnuMX0clwhpdkm1oAU2cJjxNT+HY4xqRQWU2WvRw64OUZCMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T2C+yg0W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FA84C4CEF0;
	Tue, 30 Sep 2025 08:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759222789;
	bh=oJFDk7uf6zKXMoNGO8tTRx82bidosJEPLMEojlFOQ9s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T2C+yg0WQLP71mOvAPXmwXk3J9EPvhT1rUcdKl3u86KUr5moDC/HeqDknSlVywVL1
	 etU9YCP9ZdVtAqcXv0rzub2fGgBFFc/jCahplK1pM4uh7Vc8pipegtA8jEyOlebSA0
	 hT65jIjEhY1gg3KifGnS10TwGN/ExY4qdhfD7ziOfppURe6D3fDSoKHF5Vfve4xcvZ
	 W8cZLj+t5/+lWo7va3NSCVZ6mSgr7qiJcartOuM/km407zCC217O7faXUqurjjBf1P
	 4lR/vvqD65jBMKbuLA7qtpA3tIp2y8yIy0PgKLdHQnJ3SfeO0WPQc0rfk+ZfBoxltG
	 TO3y0xzuG8ebw==
Date: Tue, 30 Sep 2025 09:59:44 +0100
From: Simon Horman <horms@kernel.org>
To: Gopi Krishna Menon <krishnagopi487@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	david.hunter.linux@gmail.com, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH net-next] selftests/net: add tcp_port_share to .gitignore
Message-ID: <aNucABvb0PvBtCxr@horms.kernel.org>
References: <20250929163140.122383-1-krishnagopi487@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929163140.122383-1-krishnagopi487@gmail.com>

On Mon, Sep 29, 2025 at 10:01:38PM +0530, Gopi Krishna Menon wrote:
> Add the tcp_port_share test binary to .gitignore to avoid
> accidentally staging the build artifact.
> 
> Fixes: 8a8241cdaa34 ("selftests/net: Test tcp port reuse after unbinding
> a socket")

I'm not entirely sure this qualifies for a fixes tag.
It is user-visible. It's probably annoying.
But I'm not sure it's a bug.

> Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
> ---
>  tools/testing/selftests/net/.gitignore | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Simon Horman <horms@kernel.org>

I notice that tools/testing/selftests/kexec/test_kexec_jump
is in a similar state. Do you plan to send a patch to address
that too?

..

