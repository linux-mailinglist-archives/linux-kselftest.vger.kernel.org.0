Return-Path: <linux-kselftest+bounces-7510-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA1289E5E8
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Apr 2024 01:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABF7E1C22261
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 23:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB313158DA8;
	Tue,  9 Apr 2024 23:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eCSlAEXM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C13158D95;
	Tue,  9 Apr 2024 23:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712704162; cv=none; b=TuldzEoBiz31a0NWHijPycLQSm38TVJoNsInpm9DTS1ttS+SU8cu+3F0b/Qklb8/Doi5nRQqhOmU5/ZdT6EBVUDXkkw/srs9MhMZuo5YKcz/MmrueQzQ+D+Zr2FCcAYc2t28jaCKVjiqGtGvFbwKz0pymfW1dURpzWuMl5IVt/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712704162; c=relaxed/simple;
	bh=44f1BURDVDavtHs5VgCDimxWZS2jWuTMtVWaaTmGnks=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fGW8WDUBUbzXdHdgXsXPNXuQIAEQLnITUEWAr0nwApZqi8jKcmV6nHPmq8q5njhRj0QTHsI3voFksOsBoII5WvREWmzM5lTEmry+u4zdIvkB5b1Rq17/Z/HRomOWClzMl0fyxX7aDnsmmkvgx1L8R/jmvp1icpmK7E9cva2yR9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eCSlAEXM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADDD7C433F1;
	Tue,  9 Apr 2024 23:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712704162;
	bh=44f1BURDVDavtHs5VgCDimxWZS2jWuTMtVWaaTmGnks=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eCSlAEXMyKvNcSJxudd6yoYMUYQ1HJHm298Ahmq93A2l00Mt63iOwFmxr2YoaLzo2
	 2Vx1pMf1s+fzRX6MQH8NXMfRrlhB7ITaGx4WrZsorSyfXYLRInSJ5zc7M7Ng0Xlvau
	 hpBWlVcBDLvsaLfU4vm0G/8gSmfRuD/KE9Li9UtNJ/nLNoPkv4xosoWlEXS1SEwVlm
	 GsDlkPQpH8UngBnFA/utF5K2r1YTl9q5GIq6Pc0fWjQx3zV8mWuhT78G8iFTokZ+7+
	 UUrQe6ZXl2rG07kwq0IG10r3o0HUhoNh/Qtg9ihkc5zoATkEiAFS0/vJsWLw2OlY7f
	 xUiFRqESA56gA==
Date: Tue, 9 Apr 2024 16:09:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Kees Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>, Nathan
 Chancellor <nathan@kernel.org>, linux-kselftest@vger.kernel.org,
 llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: kselftest_harness: Print empty string, not
 empty fmt on PASS/FAIL
Message-ID: <20240409160920.3bfe3eeb@kernel.org>
In-Reply-To: <20240409224256.1581292-1-seanjc@google.com>
References: <20240409224256.1581292-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  9 Apr 2024 15:42:56 -0700 Sean Christopherson wrote:
> -	ksft_test_result_code(t->exit_code, test_name,
> -			      diagnostic ? "%s" : "", diagnostic);
> +	ksft_test_result_code(t->exit_code, test_name, "%s", diagnostic);

Have you tested that to make sure it doesn't change the output?

.. warning: ^^ leading question ;)

