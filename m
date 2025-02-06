Return-Path: <linux-kselftest+bounces-25924-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4191AA2A97F
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 14:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB9047A2AA1
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 13:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79ED24633D;
	Thu,  6 Feb 2025 13:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lrb8ckY3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2E4235C1E;
	Thu,  6 Feb 2025 13:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738847690; cv=none; b=utqTR0zW2kjNvUWLMVTu4q3G5pyMy1ndXnmPnHz2GJDrwtD+LNwgThMs6f/rK2nFXIxKZkvRrmq/h8fULiz+wxerLUWVGQqzsfssWRKCMGNzNmXgEeQKXgRLzEnwck2BIQawo3Wbaa4OpSgURTKdAVZnDfP64XwHZuSDB0m9GLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738847690; c=relaxed/simple;
	bh=kaS3NGN+Lk7Lqlz+lqvaRNTpXNwElil01lw0HgcUBeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q3Nh4vzPVu87+SMvYzo/t8XiNhGEQFobxNrSN2dO93UQyiAlNU0geHg133hyK6jT6dv9vV6NV9o8YOgh/nY/UX+QEav2S0jUhnah1mZh6pHdLjxcY926m7niWFubLk5AK/bUu+ge7ihCvK+hOEeXToIRCQm3PL+cLsIBRz61CaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lrb8ckY3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38E0BC4CEDD;
	Thu,  6 Feb 2025 13:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738847690;
	bh=kaS3NGN+Lk7Lqlz+lqvaRNTpXNwElil01lw0HgcUBeo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lrb8ckY36zAk8FA4xsIn8fSzZ/33gqWmH/by8566GrpUHw5CRZDYgEZDD9pgJa7ah
	 C0lm9zLBKxKwo8KoYgqAiqceNSNohwxo2mx9h9lCzDQxewMxETXfUnjJD8GDT5fl0d
	 Oa2Xwn04tiuGLxgJYjewLrCUGoMPPgywG22A4to6GTbZwXTCkMyXa4xdBLzPBgWfrh
	 a7+x8o4wOLn9CeNOHnAK+7pWZ6UU67MzKL1YOD2ObNVpmnR8o0TMWB0RvZCUCdy2/x
	 9l0jj2sF/PWU9We4X3V6qmfeGJlpeLTUNSEAcDdO927lozxPKT7hhgnalQbb2cJEt0
	 84uGKPdvbaVzw==
Date: Thu, 6 Feb 2025 13:14:46 +0000
From: Simon Horman <horms@kernel.org>
To: Peter Seiderer <ps.report@gmx.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH net-next v4 08/17] net: pktgen: use defines for the
 various dec/hex number parsing digits lengths
Message-ID: <20250206131446.GT554665@kernel.org>
References: <20250205131153.476278-1-ps.report@gmx.net>
 <20250205131153.476278-9-ps.report@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205131153.476278-9-ps.report@gmx.net>

On Wed, Feb 05, 2025 at 02:11:44PM +0100, Peter Seiderer wrote:
> Use defines for the various dec/hex number parsing digits lengths
> (hex32_arg/num_arg calls).
> 
> Signed-off-by: Peter Seiderer <ps.report@gmx.net>
> ---
> Changes v3 -> v4
>   - new patch (suggested by Simon Horman)

Reviewed-by: Simon Horman <horms@kernel.org>


