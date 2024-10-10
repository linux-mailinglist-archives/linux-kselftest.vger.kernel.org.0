Return-Path: <linux-kselftest+bounces-19419-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD82E997AA3
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 04:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11AF5B219AA
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 02:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF04A16A92E;
	Thu, 10 Oct 2024 02:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P7G3O8OP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF08BE57;
	Thu, 10 Oct 2024 02:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728528033; cv=none; b=LMgxAIEFYeKbKs3sr9EwGhDaQETCerHIFaCkg0KXXqpiVzqZOeUo0KYIpy9vqPzD1SWCmA281mE0lVlbQAeqL56L3C4iwRghM8KKVtAqF2i2qkBLYSbG13sNSvtadY7HAn/WqRg2fqUnLRia/v8PKnUU7hEqzyzgDimEBGgHBbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728528033; c=relaxed/simple;
	bh=2OZq6cpy8ZQUZf9IibgWFE6hXVjrnlfNuH6FOPCnKtU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vDjWyWO6SfcB8PnSd8AZLrERW5yPNNlRdZAWn4kbN9yym7C/TK6tXry9jUPhxscLQI1aK6CPW907GsC1HSJNt+H17BO48gfWa+0aIr1WEC9gFLqopVCwo8fYrYBLE6r4Tsg9rJ1eVdryISB9jZGg4T1lWyYuoV6h/UbZm5IKve4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P7G3O8OP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80670C4CEC3;
	Thu, 10 Oct 2024 02:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728528033;
	bh=2OZq6cpy8ZQUZf9IibgWFE6hXVjrnlfNuH6FOPCnKtU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=P7G3O8OP/vmv27cxXvRhREJ3m7ZxiUUEdneNFmcMMJEoD6Ywraa8WWtYvedjRO/e9
	 6EK4zomuGqfiWE5N8ZtziNOTw8LlC0HVUbnXi2oe8xEsbgB5TmG5xhDf+KFY5L7nZT
	 wIu5t25mXDw2KnHYM+d9Afj6GqgQ57Bm3XaIQG6zMTSy4rwMXAlnqSQ/7Hv4yp4eh+
	 ofwDQIx7GZ56dYEfEtPpuVM5vXrQSEVMSfUbqgPYfTlDV8qrJ9g2F4g1/P+ZUKOYhQ
	 /zxb9BBsE0kPRg4dH8zXysyIxrDhPJpL7RkqolR1Kows9vcWlPDcNSMe9nSdDZs6NQ
	 FGIPtd/pwfoqA==
Date: Wed, 9 Oct 2024 19:40:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alessandro Zanni <alessandro.zanni87@gmail.com>
Cc: allison.henderson@oracle.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 anupnewsmail@gmail.com
Subject: Re: [PATCH] selftests: net: rds: fix module not found
Message-ID: <20241009194031.269a1251@kernel.org>
In-Reply-To: <20241008082259.243476-1-alessandro.zanni87@gmail.com>
References: <20241008082259.243476-1-alessandro.zanni87@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  8 Oct 2024 10:22:53 +0200 Alessandro Zanni wrote:
> This fix solves this error, when calling kselftest with targets "net/rds":
> 
> selftests: net/rds: test.py
> Traceback (most recent call last):
>   File "tools/testing/selftests/net/rds/./test.py", line 17, in <module>
>     from lib.py import ip
> ModuleNotFoundError: No module named 'lib'
> 
> Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
> ---
>  tools/testing/selftests/net/rds/test.py | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/rds/test.py b/tools/testing/selftests/net/rds/test.py
> index e6bb109bcead..112a8059c030 100755
> --- a/tools/testing/selftests/net/rds/test.py
> +++ b/tools/testing/selftests/net/rds/test.py
> @@ -14,8 +14,9 @@ import sys
>  import atexit
>  from pwd import getpwuid
>  from os import stat
> -from lib.py import ip
>  
> +sys.path.append("..")
> +from lib.py.utils import ip
>  
>  libc = ctypes.cdll.LoadLibrary('libc.so.6')
>  setns = libc.setns

Does this work regardless of where we try to run the script from?
In other cross-imports we try to build the path based on __file__,
see: tools/testing/selftests/drivers/net/lib/py/__init__.py

Would be good to keep consistency.
-- 
pw-bot: cr

