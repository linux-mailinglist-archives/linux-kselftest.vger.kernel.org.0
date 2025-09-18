Return-Path: <linux-kselftest+bounces-41831-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3F7B8468A
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 13:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B67E6174E0B
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 11:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1F12C0263;
	Thu, 18 Sep 2025 11:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="afUQKMJe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E18283153;
	Thu, 18 Sep 2025 11:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758196122; cv=none; b=R8JWPB+jj1+QdzsKsvwuirGUb/E+eI2Lr4wT40jHvop05juDvgta/H/PCUwBnLq7wDzBnZ5K5UJduOiAd1Gn7TTl1+xHsi7gEXfqLaJtHMjT0xAoxGosciMx4Rf102IKtWyib7J3vdUlfYZYZewDJKCFMSJ8a+TEfTL6hzj8j3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758196122; c=relaxed/simple;
	bh=/GS2pi0BPhylD1m4PDk3EtPIv0KWtd8YNZ8MMg1pVkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ucwx74BIePSj9CjenmF0Lumr+h/uHdxiirmLnnZIKJvkzi1HED7+eRSsM+pyg8LLpFkJaC4JTBNNagf65xP91GNlgeJ4EWj3Wz6Mv31wRwUXjaecJgYcZqr9jP/D8Ppi2Q71Rs4khUnX1fPc2qegEk5+zkmTZrbc8Nw+OMYp1YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=afUQKMJe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E8F7C4CEE7;
	Thu, 18 Sep 2025 11:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758196121;
	bh=/GS2pi0BPhylD1m4PDk3EtPIv0KWtd8YNZ8MMg1pVkY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=afUQKMJe3SZLc6Bp48RNJW9wskTebguMeMhbdotT0nsxBGAcS1HoUw2x2+voUrCUL
	 2hmNJ3tq26QDYQ84qBCcX6kBuH1IWQVDajTU+S1GAcHxBIy6wfV+ZCCqJSWdUta9RR
	 Ge0px/b+idBZT2BMlCVCTw9myHppianrLaXtnHTbgEhSlFag2bxRGqmaCmWB8f8uLX
	 Mh0srkBkFOp+1sbDwS80Ugnpk3zV6kQqaj6gcCkTNGk272pV/NsoBrJKsPsGHGqZCR
	 P/GSwyvyLSip48Wh6Elz+LqNSRlTBZrGtsiwI7o8JMUlXiwZNoddrbJfa4CuSXJz9w
	 iPf1DTrWIe2qA==
Date: Thu, 18 Sep 2025 12:48:35 +0100
From: Will Deacon <will@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Oleg Nesterov <oleg@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	David Spickett <david.spickett@arm.com>,
	Thiago Jung Bauermann <thiago.bauermann@linaro.org>,
	Luis Machado <luis.machado.foss@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH 3/5] arm64/sme: Support disabling streaming mode via
 ptrace on SME only systems
Message-ID: <aMvxkzg_LT4C4Quh@willie-the-truck>
References: <20250820-arm64-sme-ptrace-sme-only-v1-0-f7c22b2871f8@kernel.org>
 <20250820-arm64-sme-ptrace-sme-only-v1-3-f7c22b2871f8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820-arm64-sme-ptrace-sme-only-v1-3-f7c22b2871f8@kernel.org>

On Wed, Aug 20, 2025 at 07:29:05PM +0100, Mark Brown wrote:
> Currently it is not possible to disable streaming mode via ptrace on SME
> only systems, the interface for doing this is to write via NT_ARM_SVE but
> such writes will be rejected on a system without SVE support. Enable this
> functionality by allowing userspace to write SVE_PT_REGS_FPSIMD format data
> via NT_ARM_SVE with the vector length set to 0 on SME only systems. Such
> writes currently error since we require that a vector length is specified
> which should minimise the risk that existing software is relying on current
> behaviour.
> 
> Reads are not supported since I am not aware of any use case for this and
> there is some risk that an existing userspace application may be confused if
> it reads NT_ARM_SVE on a system without SVE. Existing kernels will return
> FPSIMD formatted register state from NT_ARM_SVE if full SVE state is not
> stored, for example if the task has not used SVE. Returning a vector length
> of 0 would create a risk that software would try to do things like allocate
> space for register state with zero sizes, while returning a vector length of
> 128 bits would look like SVE is supported. It seems safer to just not make
> the changes to add read support.
> 
> It remains possible for userspace to detect a SME only system via the ptrace
> interface only since reads of NT_ARM_SSVE and NT_ARM_ZA will succeed while
> reads of NT_ARM_SVE will fail. Read/write access to the FPSIMD registers in
> non-streaming mode is available via REGSET_FPR.
> 
> sve_set_common() already avoids allocating SVE storage when doing a FPSIMD
> formatted write and allocating SME storage when doing a NT_ARM_SVE write so
> we change the function to validate the new case and skip setting a vector
> length for it.
> 
> The aim is to make a minimally invasive change, no operation that would
> previously have succeeded will be affected, and we use a previously
> defined interface in new circumstances rather than define completely new
> ABI.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  Documentation/arch/arm64/sve.rst |  5 +++++
>  arch/arm64/kernel/ptrace.c       | 40 +++++++++++++++++++++++++++++++++-------
>  2 files changed, 38 insertions(+), 7 deletions(-)

It would be good to have an Ack from the userspace side (GDB?) so that
we know that the minimal ABI change you're proposing is sufficient.

In the meantime, I'll pick up the first two selftests as they are
independent of this part.

Will

