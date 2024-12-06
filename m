Return-Path: <linux-kselftest+bounces-22914-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2849E7280
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Dec 2024 16:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07F051888245
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Dec 2024 15:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573D5207650;
	Fri,  6 Dec 2024 15:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tM3ik0DT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2601953A7;
	Fri,  6 Dec 2024 15:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733497763; cv=none; b=YKvtvZxSQr7/g9O6zC2Nft0EHn3PNBoXmOkNZC3yD6JRzGsnO0dlxxmK5elP/EVkLCC3SOzmTNeV1Dwk2v9VrWPx+xTcmZVt9MVT+NiDouyRHzCFOibShLKyMsk5lCsLsrXb1q3JpO1O0ag883S9+xGh2LaS4GmNeBCFG3HutBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733497763; c=relaxed/simple;
	bh=AcySnufDoHnAqbhwmrqCRJ6hJFOvsfgvt4sBL8BqwlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aK8h3umE8PjyFX63n7/sDQfF8LqzcezY0s0oa64O4cmog6cuBwz/yXc4bmgvdRy93XzHVwZFTyyuoeaEW6K5dFrtKtk2GfKpQPoczVRmDDlgXvMMoDLXW2j3cDikaoSJz8HXIQfGtn5l+YmIvTbbXPOB0Qi4o2OF3K+PunU7cTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tM3ik0DT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E32A2C4CEDC;
	Fri,  6 Dec 2024 15:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733497762;
	bh=AcySnufDoHnAqbhwmrqCRJ6hJFOvsfgvt4sBL8BqwlU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tM3ik0DTD6q1rL1rCHPC4mjmqbC8dIlwD9EbO4t87+XHTvD/DePJ1nwbz06rzKHtx
	 KbN6g2+ED++WM2cQQSxvhEYNw6irQZ7ANI9Nw+mWsEn9UG62k3wiaFCEDEoSZb7vFs
	 kuFuhdw3sXsNrsdCgIdigf22NO0ydYdn9xWbHDb6Lsm2D7SZSgL2PD/RGVDZfj8R07
	 y3ddk3j7hULCnNIGSLmPsEpozWjvFaMsaWLXWVNEfG2WVJIguZtfp9RsrXSpIoL1Vh
	 w1N1SexxMdFBj5KK68a8mEMrHyYdvERZhNf7eAicV8ovPs3Ss9N10LiC7nBzEWTBuT
	 i3Tf5+vLk/fSQ==
Date: Fri, 6 Dec 2024 15:09:18 +0000
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 4/4] netconsole: selftest: verify userdata entry
 limit
Message-ID: <20241206150918.GU2581@kernel.org>
References: <20241204-netcons_overflow_test-v1-0-a85a8d0ace21@debian.org>
 <20241204-netcons_overflow_test-v1-4-a85a8d0ace21@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204-netcons_overflow_test-v1-4-a85a8d0ace21@debian.org>

On Wed, Dec 04, 2024 at 08:40:45AM -0800, Breno Leitao wrote:
> Add a new selftest for netconsole that tests the userdata entry limit
> functionality. The test performs two key verifications:
> 
> 1. Create MAX_USERDATA_ITEMS (16) userdata entries successfully
> 2. Confirm that attempting to create an additional userdata entry fails
> 
> The selftest script uses the netcons library and checks the behavior
> by attempting to create entries beyond the maximum allowed limit.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  MAINTAINERS                                        |  2 +-
>  .../selftests/drivers/net/netcons_overflow.sh      | 67 ++++++++++++++++++++++
>  2 files changed, 68 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8af5c9a28e68c4b6a785e2e6b82db20b3cf59822..62192db4641a4056d1eab911f5c141fb37eaed36 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16092,7 +16092,7 @@ S:	Maintained
>  F:	Documentation/networking/netconsole.rst
>  F:	drivers/net/netconsole.c
>  F:	tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh
> -F:	tools/testing/selftests/drivers/net/netcons_basic.sh
> +F:	tools/testing/selftests/drivers/net/netcons\*
>  
>  NETDEVSIM
>  M:	Jakub Kicinski <kuba@kernel.org>
> diff --git a/tools/testing/selftests/drivers/net/netcons_overflow.sh b/tools/testing/selftests/drivers/net/netcons_overflow.sh

Nit: I think you need to add netcons_overflow.sh to
     tools/testing/selftests/drivers/net/Makefile

Other than that, this looks good to me.

Tested-by: Simon Horman <horms@kernel.org>
Reviewed-by: Simon Horman <horms@kernel.org>

...

