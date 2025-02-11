Return-Path: <linux-kselftest+bounces-26436-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A056A31984
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 00:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4453167A8B
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 23:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11CF426A0AF;
	Tue, 11 Feb 2025 23:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="enp6uTax"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC20426A0A3;
	Tue, 11 Feb 2025 23:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739316386; cv=none; b=mwtwy00qJtvFb13gWbX3IvsYdx0SNADaZoumIh1g3RjkWGVoakyQMNPHPQOmz1A/iOSNmoT0K84TXaKzOYLAdWQ/KGKhEg3aUVkOYJjlIONJr++HOp0Hf/w1fA9BRiIWfyOKbuuWsE/dtsSIkOrvD5tonrYnl0SJkkf9VwcVkjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739316386; c=relaxed/simple;
	bh=5LnETxUqNhj/Ty+sFpEWOJ+kEEqGTxC2idodkEnM47w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C+VRcA6ANMqbtxCcvIq5g+NwUSAEknfcYsdStJGxTo0im4w3VJ3+BIc27eo4s/vkoCFR/GQMsLBZL6wLL8/wRgImuGyzlhMHlYDezVQdCJgC199mvuAmtcFsXhdczUf3vEeQfCxBmoexqCNBY8WMk+Oro/dD2QdT/NsSLcWIn/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=enp6uTax; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1C38C4CEDD;
	Tue, 11 Feb 2025 23:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739316385;
	bh=5LnETxUqNhj/Ty+sFpEWOJ+kEEqGTxC2idodkEnM47w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=enp6uTaxSv49Cj3Ajh9uzcim2GHVylLLrNUuO9i6zse1OqhMK/wzoBQ23ha4iYafo
	 9d9G0CdKZHANlLQlVvrhMlqsaypE9n17ep5j7yO08zsmIG7TJP3dlsN6dDeAntKhic
	 kp9uGc1u7JIPld5Znf0R7TZyFgGsc0Yn/4n7ODJSZbC3fkEnCc2cGpd7zqY9XzZYgE
	 pyR5SAwg+2CA4AMV8CQVStcTBL0d9qN8utwBnD3Jdl3wcLRCSqBFUmBy2vkgWTHyGr
	 WzZSBuW0R5sck3bRM5zJV5HQr0+YZ5CaLKbzYus5IUO3R6c8JSL7mpdfZsOpdj+58Q
	 Jrip2FV8qMeDA==
Date: Wed, 12 Feb 2025 01:26:21 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Ahmed Salem <x0rw3ll@gmail.com>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, shuah@kernel.org,
	skhan@linuxfoundation.org, linux-integrity@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v4] selftests: tpm2: test_smoke: use POSIX-conformant
 expression operator
Message-ID: <Z6vcnSv-fjzRQ1hy@kernel.org>
References: <37ztyakgrrtgvec344mg7mspchwjpxxtsprtjidso3pwkmm4f4@awsa5mzgqmtb>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37ztyakgrrtgvec344mg7mspchwjpxxtsprtjidso3pwkmm4f4@awsa5mzgqmtb>

On Wed, Feb 12, 2025 at 01:16:17AM +0200, Ahmed Salem wrote:
> Use POSIX-conformant expression operator symbol '='.
> 
> The use of the non POSIX-conformant symbol '==' would work 
> in bash, but not in sh where the unexpected operator error 
> would result in test_smoke.sh being skipped.
> 
> Instead of changing the shebang to use bash, which may not be 
> available on all systems, use the POSIX-conformant expression 
> symbol '=' to test for equality.
> 
> Without this patch:
> ===================
>  # make -j8 TARGETS=tpm2 kselftest
>  # selftests: tpm2: test_smoke.sh
>  # ./test_smoke.sh: 9: [: 2: unexpected operator
>  ok 1 selftests: tpm2: test_smoke.sh # SKIP
> 
> With this patch:
> ================
>  # make -j8 TARGETS=tpm2 kselftest
>  # selftests: tpm2: test_smoke.sh
>  # Ran 9 tests in 9.236s
>  ok 1 selftests: tpm2: test_smoke.sh
> 
> Signed-off-by: Ahmed Salem <x0rw3ll@gmail.com>

Perfect, thanks a lot.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Shuah, do you want to pick this or?

BR, Jarkko

