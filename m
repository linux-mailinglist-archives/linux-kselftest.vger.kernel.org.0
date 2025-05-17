Return-Path: <linux-kselftest+bounces-33243-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE78ABA8A2
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 May 2025 09:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC2DC1BA30CD
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 May 2025 07:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEAAA1C862F;
	Sat, 17 May 2025 07:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hftEwuY2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866511C84B8;
	Sat, 17 May 2025 07:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747466103; cv=none; b=rn0Uy8FccRS6XIim0vOr4A01R6mlKI71MBIbHhJvqu/S0kGoQ25ORWBt0IOTOguYgesPQZXgNDy/E3HpemakUzkrLFIRIjQFEvjdz3J2gLtk0fosz+qzIaVsDMFkfxdY8Cff4oFRRbU5bL1uZYVCZ1FllwV/MmTK0hqlpjVbtVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747466103; c=relaxed/simple;
	bh=JNy+peeFwalxMPP/8hXWA78JMDjaOY6Zxki+6gHUlqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UF9h8RSoj+0AToHNb7GjsLcB0bw1PAWJZ6AGii7dRstFUiWGUPo/IaXT3R3XKJIHCxTjP1R/cIIp/ET8xeuQNU+yFlBlzOdhVcJ7ixkGUi1jV85CbF13AwV97sgbmLzxf+upZPVc9j4Ot1oNqhTORZZvEKQvzob0tni6dw/C33c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hftEwuY2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1303C4CEE3;
	Sat, 17 May 2025 07:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747466103;
	bh=JNy+peeFwalxMPP/8hXWA78JMDjaOY6Zxki+6gHUlqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hftEwuY20qCoJXH2HLhnHmDi9F9mLDdgT5I7uN++Sf5gmQ/R/IBxMPdFH63oNEcD/
	 cuGd8ho8RkuD96jUwt145WikGLcikANU641IKnoLpgCe59h55YnoOcshnDNHmfT2aV
	 wTAw8EZG7CGHGco0zkGAxe2bDGWKTY22QOVLL9saX7lEM7RRIOoBlfr+1lqTIlJ5dk
	 AlTbrqjBeKY3f3uuAh100fJpovrHeB6RIU7xgfNrIwNXNdhvU6MmkdBM8mdSbIdCvg
	 xa/OIXhUqehMaNNV8KTWr6W6+9G0L4wresZypIoe+I5+aU3CLrkb8czQHNa5dLNg2Z
	 zr3bISDu7+quA==
Date: Sat, 17 May 2025 09:14:58 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Sukrut Heroorkar <hsukrut3@gmail.com>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	shuah@kernel.org, hpa@zytor.com, x86@kernel.org,
	dave.hansen@linux.intel.com, bp@alien8.de, mingo@redhat.com,
	tglx@linutronix.de
Subject: Re: [PATCH] kselftests/x86: Correct grammer in VMX pairing message
Message-ID: <aCg3ctv0ODAp9G0F@gmail.com>
References: <20250516192057.7518-1-hsukrut3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250516192057.7518-1-hsukrut3@gmail.com>


* Sukrut Heroorkar <hsukrut3@gmail.com> wrote:

> Fixes a small grammatical error in the print message.

No it doesn't.

> signed-off-by: Sukrut Heroorkar <hsukrut3@gmail.com>
> ---
>  tools/testing/selftests/x86/ioperm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/x86/ioperm.c b/tools/testing/selftests/x86/ioperm.c
> index 69d5fb7050c2..a5099e526912 100644
> --- a/tools/testing/selftests/x86/ioperm.c
> +++ b/tools/testing/selftests/x86/ioperm.c
> @@ -107,7 +107,7 @@ int main(void)
>  		err(1, "fork");
>  
>  	if (child == 0) {
> -		printf("[RUN]\tchild: check that we inherited permissions\n");
> +		printf("[RUN]\tchild: check that if we inherited permissions\n");

Wot?

Thanks,

	Ingo

