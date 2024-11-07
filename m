Return-Path: <linux-kselftest+bounces-21600-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 866579C03D8
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 12:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DA0A1F23501
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 11:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12BF01F4FD7;
	Thu,  7 Nov 2024 11:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKNcUSyS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE371F4FAC;
	Thu,  7 Nov 2024 11:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730978655; cv=none; b=NO+1RvAL6p0w93tCt8VN+nk9uCSSTruvJY6k6IM1xmLBg2DLkqQtcdB8ICCBIAkwg2uiI0r9RUi6vB0C/wvsb3McMzYU3ex9NnI5y0lWVT5cdQeZFIVGuXlm/aoKOnrtC3vLD3yFzIB7y7PS54/u9pxMUovWfO0r6W3F0LWVYUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730978655; c=relaxed/simple;
	bh=GoNe6/q7REWxoVhFOfRrz2ijnlCfaDTpIKKYt2g7RSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sHsNwkNiJUNYZCsvTNofhOZvABUjoKcMIrb3OaBN9f9oT1wfqygmT4k2KxHUJYiomi71E8lMSUsA+N4h5OW82RrVkEvs0mL4TF6sneaAOor+kDvrSDzCMUKy+6RzDduTdHjP5vS8jLRaqguVuC36u72xZ2aOFgP/CpNn964ItTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jKNcUSyS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BA30C4CECC;
	Thu,  7 Nov 2024 11:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730978653;
	bh=GoNe6/q7REWxoVhFOfRrz2ijnlCfaDTpIKKYt2g7RSc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jKNcUSySUY2gcgPgoGjUqf2LVi4NQw+GwGsz/vb7uTNqed46LWPa39tyTR21mrziR
	 P96LakLbAsrR78ibhRehpVwYT1clA6AIdXbaSgrFLsslyivM8hikKPHLfyunkRmk4S
	 Z8vJM96Kql1eCqEXQvq78C+n5VptHcW4Hl305AsyKxmBFdRgoltIPOU0ymkkqbterM
	 E1IoT/bh3l/slCRtP7qYIefMDZrtQv7cW5sX/9z5xzGc/lbflaEKCuwWWsrTcgrXgg
	 FGFYSVLavAQi5ONUEuzvEKh9rlyTnetwqMhzN0yEGp4+e0UoT4xE/pGR/GOXFcnFWc
	 UV2jlhU1T4DXg==
Date: Thu, 7 Nov 2024 11:24:08 +0000
From: Will Deacon <will@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Shuah Khan <shuah@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] kselftest/arm64: fp-stress signal delivery
 interval improvements
Message-ID: <20241107112407.GB15424@willie-the-truck>
References: <20241030-arm64-fp-stress-interval-v2-0-bd3cef48c22c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030-arm64-fp-stress-interval-v2-0-bd3cef48c22c@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Oct 30, 2024 at 12:02:01AM +0000, Mark Brown wrote:
> One of the things that fp-stress does to stress the floating point
> context switching is send signals to the test threads it spawns.
> Currently we do this once per second but as suggested by Mark Rutland if
> we increase this we can improve the chances of triggering any issues
> with context switching the signal handling code.  Do a quick change to 
> increase the rate of signal delivery, trying to avoid excessive impact
> on emulated platforms, and a further change to mitigate the impact that
> this creates during startup.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
> Changes in v2:
> - Minor clarifications in commit message and log output.
> - Link to v1: https://lore.kernel.org/r/20241029-arm64-fp-stress-interval-v1-0-db540abf6dd5@kernel.org
> 
> ---
> Mark Brown (2):
>       kselftest/arm64: Increase frequency of signal delivery in fp-stress
>       kselftest/arm64: Poll less often while waiting for fp-stress children

With these changes, I was easily able to reproduce the SVCR=0 bug so:

Acked-by: Will Deacon <will@kernel.org>

for both.

Will

