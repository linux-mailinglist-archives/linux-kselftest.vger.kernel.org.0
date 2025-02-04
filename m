Return-Path: <linux-kselftest+bounces-25688-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC4FA274AE
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 15:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CD6B18823B3
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 14:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DF5213E8B;
	Tue,  4 Feb 2025 14:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fvgcoB5i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AAA2139D4;
	Tue,  4 Feb 2025 14:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738680303; cv=none; b=nVO95unoll7asgAomrqj+o7pL9osWghlGt0xYfhVhakzE1pMqHXnJEO2GFAUGFipWYhk/iLrJ7StYQ4DVWIj9fKpeOwP5SlZ+Yl12OcSTVfnmxQFIWpLdo9K4+Xq5cJRDkR3hw4923oqLm/6522Ar+cGbIvQ2uOzs673IJwklCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738680303; c=relaxed/simple;
	bh=p0gEmBMjqJWu8syRqJ5MlxTY38trh6OmUVrJizQY2pE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jZATwPtFPBUgbJ5T0ramkDm+H9lnnDXhja3ffmEmyvcmiI3Cqo9OsfAUWYSePDn37hH0Ah1S6oK9GMxmJDxaRTQbh/aTtikwv1ZJVQPpshcNMxY61FVnppU+SFSA9hFJf6f4dwC3N7r6RwSInLSUK16MFZqmIOE7CZM/WL8jVD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fvgcoB5i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5966C4CEDF;
	Tue,  4 Feb 2025 14:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738680302;
	bh=p0gEmBMjqJWu8syRqJ5MlxTY38trh6OmUVrJizQY2pE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fvgcoB5i7+eZOWX9kdWkoy1qY2xus+Fr1AKvEkcwv/6Z1I1mIh1cjCFa33M+osuST
	 5bnKB+4SBQxuOGjEgVSIAiKI3yBJFhOwvPwuQTqpItaNGWj3rl9mMcwr/zWoWoPwru
	 KgSCHAahTZKn0lQiCMPcWmGlTrK/STmIJYJhonYUNMc/Cp2hTcPx/TIjBzXHVCg/4R
	 21xJAMgt60k2PemZvp1p2ZEMD1QkdJzjB+w8TS+J1zLt9Wc3CMZGk7iQIbqQiJ6/Aq
	 AViB+Na6fsfA37GNhM4xi5vYQ98dKoG0inOqCCnlUMIjpCK86FD3KYbqjsH/Hbjl9d
	 GGPb8WXs+E/SQ==
Date: Tue, 4 Feb 2025 14:44:57 +0000
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
Subject: Re: [PATCH net-next v3 06/10] net: pktgen: fix ctrl interface
 command parsing
Message-ID: <20250204144457.GJ234677@kernel.org>
References: <20250203170201.1661703-1-ps.report@gmx.net>
 <20250203170201.1661703-7-ps.report@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203170201.1661703-7-ps.report@gmx.net>

On Mon, Feb 03, 2025 at 06:01:57PM +0100, Peter Seiderer wrote:
> Enable command writing without trailing '\n':
> 
> - the good case
> 
> 	$ echo "reset" > /proc/net/pktgen/pgctrl
> 
> - the bad case (before the patch)
> 
> 	$ echo -n "reset" > /proc/net/pktgen/pgctrl
> 	-bash: echo: write error: Invalid argument
> 
> - with patch applied
> 
> 	$ echo -n "reset" > /proc/net/pktgen/pgctrl
> 
> Signed-off-by: Peter Seiderer <ps.report@gmx.net>

Reviewed-by: Simon Horman <horms@kernel.org>


