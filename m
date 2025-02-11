Return-Path: <linux-kselftest+bounces-26320-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E74EA3018A
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 03:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8FC83A0711
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 02:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605631BD9FA;
	Tue, 11 Feb 2025 02:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aKD1XJhh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AE043AA1;
	Tue, 11 Feb 2025 02:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739241446; cv=none; b=dOSXPqvpz8/IxrTWV1F+e/NwCAysQFaK7/yFPOUGSbsa2RxFTfO4rFxvISJapM1SN+XknpuIRrgfmDnt0klqA764uz7dmnEU9bxqyNWRBG2jFnTMOjsWUMzTs1SUZfUdG09v1mF4t0XHynFVOPNG/RxpYvyAZqwON8dOtTYw9aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739241446; c=relaxed/simple;
	bh=/nh38VH3RUeFVnEms/rFcvaBjtX6qP9VQp0unQP9LtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ERkSgYfKz8mIo2Uk8lb6FPdwcnQZ9e4PwFB4MchkfrYyfEWNHsled30vFCf/KSNiQq74zw47ZT6GV6zt+ZhHsGPzLdaIVal2TmUnoP4yjufNV2u1ZfW3g1PZibBqjMkoLkPOWo2rev7jWwK6F7Wxk0pyIUVyRYQuCFctIM8ygWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aKD1XJhh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CAADC4CED1;
	Tue, 11 Feb 2025 02:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739241445;
	bh=/nh38VH3RUeFVnEms/rFcvaBjtX6qP9VQp0unQP9LtY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aKD1XJhhVVFuXuZZQCq318mBjivsRJLvZGWHyw3ENdIleqa4h9kaFjK9hLdFHTmGU
	 PtXKEYPew/+hvpdHfQlUkP1u7mshSYDxSQbUSW48mK66E4ft71uLTa1v4ewRMQNXsn
	 tyG7Dc53b5Tgc9FP+Uvh8FinYWgZYigCSC3EUPNRrDxucJin0vwK6S7kYB8/aaGixn
	 2tmio+NiSPsyjk7qiiDUb78IXLjI0rNY7vULWcaFApQ5VzmvnROQ7vQFHfRKlLZ64J
	 9FBdfnHIFqt8mCJJ+DSnOSuofkUd9KIlNcCLQxUzSXWQ+RSAdPu33rSvSgwW0hwDcC
	 m9isMa2qzDtNw==
Date: Mon, 10 Feb 2025 18:37:25 -0800
From: Kees Cook <kees@kernel.org>
To: Tamir Duberstein <tamird@gmail.com>
Cc: David Gow <davidgow@google.com>, Shuah Khan <skhan@linuxfoundation.org>,
	Luis Felipe Hernandez <luis.hernandez093@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v5 2/2] lib/prime_numbers: convert self-test to KUnit
Message-ID: <202502101836.2B3E7BC4@keescook>
References: <20250208-prime_numbers-kunit-convert-v5-0-b0cb82ae7c7d@gmail.com>
 <20250208-prime_numbers-kunit-convert-v5-2-b0cb82ae7c7d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250208-prime_numbers-kunit-convert-v5-2-b0cb82ae7c7d@gmail.com>

On Sat, Feb 08, 2025 at 09:44:39PM -0500, Tamir Duberstein wrote:
> Extract a private header and convert the prime_numbers self-test to a
> KUnit test. I considered parameterizing the test using
> `KUNIT_CASE_PARAM` but didn't see how it was possible since the test
> logic is entangled with the test parameter generation logic.
> 
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
>  lib/Kconfig.debug                            | 14 +++++
>  lib/math/prime_numbers.c                     | 87 +++++-----------------------
>  lib/math/prime_numbers_private.h             | 17 ++++++
>  lib/math/tests/Makefile                      |  1 +
>  lib/math/tests/prime_numbers_kunit.c         | 59 +++++++++++++++++++
>  tools/testing/selftests/lib/config           |  1 -
>  tools/testing/selftests/lib/prime_numbers.sh |  4 --
>  7 files changed, 106 insertions(+), 77 deletions(-)

Thanks! I've applied this and rebased it onto:
https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=for-next/move-kunit-tests

-- 
Kees Cook

