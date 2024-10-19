Return-Path: <linux-kselftest+bounces-20190-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5089A9A4BEC
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Oct 2024 09:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 099B7283D81
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Oct 2024 07:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E731DC739;
	Sat, 19 Oct 2024 07:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvm28UCI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA221EA73;
	Sat, 19 Oct 2024 07:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729324650; cv=none; b=OUBXfPs6qnoy1lMiuZJJN86gQXS1mOZZzWZLhPy95+YZrojZV/psR544GZR/kvKmf4kex4g2OjBxmQjWc63KjBDQ0aOzSiK/y8a58kB1l7rnRlh7IpPp8ksyCFC/vduladv7sh4JFVi3ZRqF4ygBLvsHGSTAbtBL5fdMImHFT6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729324650; c=relaxed/simple;
	bh=KRPqgsqv/4ULAhftz9ppDBtcFKe/BircvnVWLwFcbDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cQPH+IYkchwau0Fg6ZDknxDiqZ5aVXqknScotMeWI/PaWAE+z7tUcyGPKYWOBUH28upR91//t9EWh0h1dnRW4lGPV3HEq106Ds2igHIKxP7Nna9XnL1sGQFUpiNFeKetCjU1ofGZbz4+pcIKP1V0XDR0trzzzf1kUn9QID8dx0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvm28UCI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4204DC4CEC5;
	Sat, 19 Oct 2024 07:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729324650;
	bh=KRPqgsqv/4ULAhftz9ppDBtcFKe/BircvnVWLwFcbDc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jvm28UCIohbROk3IwMjs5N4Y2MZ9rReGn81DP8E7XLsxyUccWYGJ+k9DR0DcP5w+f
	 3vQaNCMakF/VEr0AaMbWtnBsuZffvSvpcCXxZodT0SLmoWhGLsXzDx/xdNAXS8TZxR
	 Q3UdYfs604NEKhNQiPmW28WJSyjYifMe7iBWsL6P5zCAjxz2uLQDMuj00pEY37kzDX
	 EN1PUCt0k7+WHlJEEIv7guf9nKnvV9ATleeXdEYeRJ4R3YqLhBuwrb/JBViwR0FBpA
	 PLwoPxh6eBu5oBeO8YhwWNZheAmIRBWk2ajwIWr0vhdaeHo7SfopcP2sp1VqJkST90
	 zTF9GbAaz3RSA==
Date: Sat, 19 Oct 2024 08:57:25 +0100
From: Simon Horman <horms@kernel.org>
To: Liu Jing <liujing@cmss.chinamobile.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, shuah@kernel.org, 0x7f454c46@gmail.com,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Liu Jing <liujing_yewu@cmss.chinamobile.com>
Subject: Re: [PATCH] selftests/net: Add missing va_end in test_snprintf
Message-ID: <20241019075725.GF1697@kernel.org>
References: <20241017075251.127762-1-liujing@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017075251.127762-1-liujing@cmss.chinamobile.com>

On Thu, Oct 17, 2024 at 03:52:51PM +0800, Liu Jing wrote:
> There is no va_end after va_copy, just add it.
> 
> Signed-off-by: Liu Jing <liujing_yewu@cmss.chinamobile.com>
> Signed-off-by: Liu Jing <liujing@cmss.chinamobile.com>

Thanks,

This is correct. However, it was fixed recently in the same way
by the following commit authored by one of your colleagues, Zhang Jiao:

- 7c2f1c2690a5 ("selftests/net: Add missing va_end.")
  https://git.kernel.org/netdev/net-next/c/7c2f1c2690a5

-- 
pw-bot: not-applicable

