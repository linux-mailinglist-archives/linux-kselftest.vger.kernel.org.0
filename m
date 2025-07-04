Return-Path: <linux-kselftest+bounces-36571-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22132AF949F
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 15:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B07061CA7F34
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 13:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037D730E857;
	Fri,  4 Jul 2025 13:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qftfLblA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7BB3093DC;
	Fri,  4 Jul 2025 13:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751637031; cv=none; b=Wzjbur92XtlnP3CPpIZIjGFw5wIlZIzY6GL140VM1ztVfNzIXHy08UPxcylGLlmJoDU8EwjiDCBya3aeCgyIAM66CeKBKx14UCrh+aEy7jgpsPSRwB2KaF5D3Lnqqtv9MZP8PnW+8WTIm1Wxp/PNyy28vfUCuYPkenP1VtRL0GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751637031; c=relaxed/simple;
	bh=vipOAhEShnkbc7YvZlAmzBI8cdPmlOvoAE2pLoD+pfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LMX5qi5KlWHA2g5fqd0dh392zck97jbKUNG7RV3ZbqnxxBRB+Wi5fUpSxdCHaFljwAZBAi6aXONIpiQQV5vrz7924Kru0/BiwDYODTLpRDeCYIglLJ2rGa0RgQLJ7ld3aq8Ei6VZASo0Ga+XN2cbQ2YJai1I4BtYxFPo6z+yARg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qftfLblA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC553C4CEF1;
	Fri,  4 Jul 2025 13:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751637031;
	bh=vipOAhEShnkbc7YvZlAmzBI8cdPmlOvoAE2pLoD+pfc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qftfLblA0lt7pjera3ueLaMfRUO72L6spQsI98HCtRIcjuCEiSAklZzfSdZaesKDy
	 DazAm5CDda6cvbzeIAfBD1T930IGGHcLQk3PBVspBjZXQESoV5jHpc3weZHQah2Tit
	 tvhOEX44axtWWovkkwAnOHxUEF5T0aMTy7BwJv6go4cudPC7vJt4Sfhyq0vYhsr0+k
	 xn26RdvxnuYi7ghY2SeK5yKZFRT0QkzGt6Brchy9TMGGpJuD/bLhc941RRvoZoigZZ
	 ks7Ky3VCmcZvMnRpVtRNaR1xg2OIW2qXTrFHkym3aVDGHYmGXIZG0uRTJVnP2yfVJ9
	 cD+crx0WgOeBw==
Date: Fri, 4 Jul 2025 14:50:26 +0100
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next v2 2/7] netpoll: factor out UDP checksum
 calculation into helper
Message-ID: <20250704135026.GP41770@horms.kernel.org>
References: <20250702-netpoll_untagle_ip-v2-0-13cf3db24e2b@debian.org>
 <20250702-netpoll_untagle_ip-v2-2-13cf3db24e2b@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702-netpoll_untagle_ip-v2-2-13cf3db24e2b@debian.org>

On Wed, Jul 02, 2025 at 03:06:34AM -0700, Breno Leitao wrote:
> Extract UDP checksum calculation logic from netpoll_send_udp()
> into a new static helper function netpoll_udp_checksum(). This
> reduces code duplication and improves readability for both IPv4
> and IPv6 cases.
> 
> No functional change intended.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <horms@kernel.org>


