Return-Path: <linux-kselftest+bounces-26744-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF9FA374A7
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Feb 2025 15:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49A8216C1D7
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Feb 2025 14:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977801990AF;
	Sun, 16 Feb 2025 14:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ad9IXy+Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2641925BA;
	Sun, 16 Feb 2025 14:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739715308; cv=none; b=F1g1Nciv+tmBg2v+0XIKFYGPrWdLm6T4/+KowwCEa3h0DOqIyIHn4WPQ+KPv8jxHmoXVQFUFAByqGbqk5ffATNjj+5awxCBocuI39Cjyr6cHjtOEnSE+yKZZzV0bS/vTIUNHgkG83eAfRDmhOKykQTRZ+IAGK/nkYM0bUFg0h2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739715308; c=relaxed/simple;
	bh=J4Ck2K8+HDsXafxKS/ldlyh5nB7rYOnLZDKN8mRnV0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PWXtynhES2Wgk1+muGZJNPLeKOGAVz0oAe8CISAQfzT2DE+L2zHlWTgllslfLlrElrC7MfPcppvulREtftIJTDmyUgzIfrWYnNmrebIf6XIQlU8Yom/Em6P4+wJMkxjbs2aMnuv114AJHrz+ZjNifjS55juCE/a2FdMMsOUzlDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ad9IXy+Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B3FEC4CEE2;
	Sun, 16 Feb 2025 14:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739715307;
	bh=J4Ck2K8+HDsXafxKS/ldlyh5nB7rYOnLZDKN8mRnV0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ad9IXy+ZDTCmC0IERLpEOWJr4c4c1d1a/F2qrRdHMbv9DyKHa/73khEFA9OyWb6oy
	 jz8A7N7qIPa3Httm0hilxH6ObH8ILcYWeueVJkBzFWfaWgx1xOh6AMg3esWHScZO/x
	 fvEurXTWuILITwEEWccuCyUMNv9WUoabGQ3j91P0MRXIOoYOJyhaTmoG3HLr18MGIz
	 bCnuIQ4wVaUr3b1CIPEZtDkLDh/lqoWYWM5kPwJG5Awdu24m95+izH9siC74XCv/eO
	 K2YYy6V+T7UJxy+CrpLlxRL8XYmZk4SVzBVtiIwsB1nPURnuzsbnzoVPKnUgPVaA1c
	 Zfg0hFJ7gP1Ag==
Date: Sun, 16 Feb 2025 14:15:03 +0000
From: Simon Horman <horms@kernel.org>
To: Peter Seiderer <ps.report@gmx.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Artem Chernyshev <artem.chernyshev@red-soft.ru>,
	Nam Cao <namcao@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH net-next v5 7/8] net: pktgen: remove all superfluous
 index assignements
Message-ID: <20250216141503.GF1615191@kernel.org>
References: <20250213111920.1439021-1-ps.report@gmx.net>
 <20250213111920.1439021-8-ps.report@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213111920.1439021-8-ps.report@gmx.net>

On Thu, Feb 13, 2025 at 12:19:19PM +0100, Peter Seiderer wrote:
> Remove all superfluous index ('i += len') assignements (value not used
> afterwards).
> 
> Signed-off-by: Peter Seiderer <ps.report@gmx.net>
> ---
> Changes v4 -> v5
>   - new patch (suggested by Simon Horman)
> ---
>  net/core/pktgen.c | 52 ++++++-----------------------------------------
>  1 file changed, 6 insertions(+), 46 deletions(-)

Thanks Peter,

I went through each of these and they all seem to be cases
where i is incremented but the function returns without using
the new value of i.

Reviewed-by: Simon Horman <horms@kernel.org>

