Return-Path: <linux-kselftest+bounces-32209-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA77AA7899
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 19:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B5554A4C70
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 17:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6441B87E1;
	Fri,  2 May 2025 17:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wqt8QvWf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20F74A32;
	Fri,  2 May 2025 17:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746206542; cv=none; b=qdUqKOd5OTRr+2FrQ1KIEdLzwiLbhPk4kDxFOrruAXRaXetfj0pnF2lJ6hvj9zITR0MYCSiAT4+cfgp1VV/bV6fGjb7wwfN7dWxnUuiISURxI5kfzxQGpoKNwZk6x+FQPZ2iBQSrsd/MkS/tYg7UtMpTzFW/kC3nGVFya0uIM6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746206542; c=relaxed/simple;
	bh=9LJTALKSTEV2XrYJMQs8DBuJgbACG9nEUyI0fP4zw3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KIWonWO4+NWxuKCX9D5Dgdz0hQs8AN5qeEVcZjLD9OTJdnqbr4vXTc2Wi9kAhODIQbz48B+MHQhbCA6kHwH6xqbUs7Ep5PK8/mUYMUS8kgpR2AFOL6B7w+8kUOyaIpUGquHhgxXQX9yU/JVXJn+hgTE+AdX55jbEA6EusFbN8Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wqt8QvWf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EABFC4CEE4;
	Fri,  2 May 2025 17:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746206541;
	bh=9LJTALKSTEV2XrYJMQs8DBuJgbACG9nEUyI0fP4zw3E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wqt8QvWfOafh8WjS/ExCCdF5SeZdP8mmwVsDNlE8XyBU6bcaKHKyNy0hU4sJIDEaG
	 A/sE2DOUkxKb4zzq23pvUPhp6PktflrvC+cS/ZwaqSrrx978oWYVK9jfl7Y/Oq9DKy
	 3RyEppYcYchR9v6RsOdfhfcJyxPWDHgwItAZ5aYpFd7wpvI5DqM8FpqMh6skGJ4YV7
	 czW9pD0PN9a2n4mD/R1TuNDOQRZZ0hS21BPAn6RavaCGUDFyrQkDAO6OaQGOdr6xYf
	 ank8GVPXMsI48awFiWfBAt5l0IrqvuFbyyu47aCjyFXKxTT1NKrjPjWakjbOvLgyzY
	 IloaDCPnHnYdA==
Date: Fri, 2 May 2025 18:22:17 +0100
From: Simon Horman <horms@kernel.org>
To: Haiyue Wang <haiyuewa@163.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	David Wei <dw@davidwei.uk>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v1] selftests: iou-zcrx: Clean up build warnings for
 error format
Message-ID: <20250502172217.GO3339421@horms.kernel.org>
References: <20250502042240.17371-1-haiyuewa@163.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250502042240.17371-1-haiyuewa@163.com>

On Fri, May 02, 2025 at 12:22:20PM +0800, Haiyue Wang wrote:
> Clean up two build warnings:
> 
> [1]:
> iou-zcrx.c: In function ‘process_recvzc’:
> iou-zcrx.c:263:37: warning: too many arguments for
>   format [-Wformat-extra-args]
>   263 |               error(1, 0, "payload mismatch at ", i);
>       |                           ^~~~~~~~~~~~~~~~~~~~~~
> 
> [2]:
> iou-zcrx.c: In function ‘run_client’:
> iou-zcrx.c:357:47: warning: format ‘%d’ expects argument of
>   type ‘int’, but argument 4 has
>   type ‘ssize_t’ {aka ‘long int’} [-Wformat=]
>   357 |               error(1, 0, "send(): %d", sent);
>       |                                    ~^   ~~~~
>       |                                     |   |
>       |                                     int ssize_t {aka long int}
>       |                                    %ld
> 
> Signed-off-by: Haiyue Wang <haiyuewa@163.com>

Hi Haiyue Wang,

This feels more like a clean-up for net-next than a bug-fix to net.

> ---
>  tools/testing/selftests/drivers/net/hw/iou-zcrx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
> index c26b4180eddd..19e1ff45deb4 100644
> --- a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
> +++ b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
> @@ -260,7 +260,7 @@ static void process_recvzc(struct io_uring *ring, struct io_uring_cqe *cqe)
>  
>  	for (i = 0; i < n; i++) {
>  		if (*(data + i) != payload[(received + i)])
> -			error(1, 0, "payload mismatch at ", i);
> +			error(1, 0, "payload mismatch at %d", i);
>  	}
>  	received += n;
>  
> @@ -354,7 +354,7 @@ static void run_client(void)
>  		chunk = min_t(ssize_t, cfg_payload_len, to_send);
>  		res = send(fd, src, chunk, 0);
>  		if (res < 0)
> -			error(1, 0, "send(): %d", sent);
> +			error(1, 0, "send(): %ld", sent);

As the type of sent is ssize_t I think that "%zd" would be best here.

>  		sent += res;
>  		to_send -= res;
>  	}
> -- 
> 2.49.0
> 
> 

-- 
pw-bot: changes-requested

