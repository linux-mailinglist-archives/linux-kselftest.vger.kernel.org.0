Return-Path: <linux-kselftest+bounces-44197-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1976C161D2
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 18:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D9243ACF00
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 17:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCDE34889F;
	Tue, 28 Oct 2025 17:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uG5Yf5qv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922CB333439;
	Tue, 28 Oct 2025 17:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761671649; cv=none; b=IFz/tFlu3IOigEYkpr849/JyCRGFn3XD6I6W/5DBCZc4i1gvHuItq8vyRZ36k3Hc8kvGSrT0zxbKTbIhosZ8ud9CBKun/DI5OuA2gt2APJN1ObxIRAnlgWOIoPMeb+Gs6gBkZHqZIbXmy9Ayis33S555yoGZyT0bpdSHVQBjskE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761671649; c=relaxed/simple;
	bh=glmcZYpjKXnFwE6F/vjUEs+ItYDJ3pXzGYYKvXVsvv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=btOOAsUUMOrT56IExL9GuE/Maete2Cox9WR9hD72kCgiWjiU86AKYm0+u/zPyejPUdF6EcC1X4IbjykfUUE/BGepzPSSqIKMdKQLIGuVOJsO82dbIbJTTHeGYTloarwlYA2c+NJ03S9fvYSHjNfgrAEmLYIXmgvEtxfC3JxWz1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uG5Yf5qv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D63E4C4CEE7;
	Tue, 28 Oct 2025 17:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761671649;
	bh=glmcZYpjKXnFwE6F/vjUEs+ItYDJ3pXzGYYKvXVsvv4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uG5Yf5qvkbJE0Ln5prAeloihXLy7XMs7e+JhhmNxASNUkE7GpZyQoZv7OucQwQOgT
	 86yk/dh0WMorWCungcR6uuLp9M1YfKwpwTL4/A6vm/lgFq1aHmP7L36io0LefgS2YB
	 f6oFsWDzmCAlTRxE15vGG6PcOH46rINEoz96VIDj2ncgqB4CBXyvCcLh+eej9UvnLE
	 5mIzAPJVOGK9N7xi5n/kwBgw93M5Xsw5Lqi9i9UTaEyAXHeE9H7z0IED5cByltsyCW
	 qsk3bARS3creEQiZHBhZHCXlA2uUowQQKGKVB1NcpD8z9bfMoAsqrWFSz7UwD/IvuJ
	 ybrber+t4Vunw==
Date: Tue, 28 Oct 2025 17:14:03 +0000
From: Simon Horman <horms@kernel.org>
To: Wang Liang <wangliang74@huawei.com>
Cc: kuba@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, shuah@kernel.org,
	acardace@redhat.com, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	yuehaibing@huawei.com, zhangchangzhong@huawei.com
Subject: Re: [PATCH net] selftests: netdevsim: Fix ethtool-coalesce.sh fail
 by installing ethtool-common.sh
Message-ID: <aQD52zzmW1YDC1iH@horms.kernel.org>
References: <20251027043007.1315917-1-wangliang74@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027043007.1315917-1-wangliang74@huawei.com>

On Mon, Oct 27, 2025 at 12:30:07PM +0800, Wang Liang wrote:
> The script "ethtool-common.sh" is not installed in INSTALL_PATH, and
> triggers some errors when I try to run the test
> 'drivers/net/netdevsim/ethtool-coalesce.sh':
> 
>   TAP version 13
>   1..1
>   # timeout set to 600
>   # selftests: drivers/net/netdevsim: ethtool-coalesce.sh
>   # ./ethtool-coalesce.sh: line 4: ethtool-common.sh: No such file or directory
>   # ./ethtool-coalesce.sh: line 25: make_netdev: command not found
>   # ethtool: bad command line argument(s)
>   # ./ethtool-coalesce.sh: line 124: check: command not found
>   # ./ethtool-coalesce.sh: line 126: [: -eq: unary operator expected
>   # FAILED /0 checks
>   not ok 1 selftests: drivers/net/netdevsim: ethtool-coalesce.sh # exit=1
> 
> Install this file to avoid this error. After this patch:
> 
>   TAP version 13
>   1..1
>   # timeout set to 600
>   # selftests: drivers/net/netdevsim: ethtool-coalesce.sh
>   # PASSED all 22 checks
>   ok 1 selftests: drivers/net/netdevsim: ethtool-coalesce.sh
> 
> Fixes: fbb8531e58bd ("selftests: extract common functions in ethtool-common.sh")
> Signed-off-by: Wang Liang <wangliang74@huawei.com>
> ---
>  tools/testing/selftests/drivers/net/netdevsim/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
> 

> diff --git a/tools/testing/selftests/drivers/net/netdevsim/Makefile b/tools/testing/selftests/drivers/net/netdevsim/Makefile
> index daf51113c827..653141a654a0 100644
> --- a/tools/testing/selftests/drivers/net/netdevsim/Makefile
> +++ b/tools/testing/selftests/drivers/net/netdevsim/Makefile
> @@ -20,4 +20,6 @@ TEST_PROGS := \
>  	udp_tunnel_nic.sh \
>  # end of TEST_PROGS
>  
> +TEST_FILES := ethtool-common.sh
> +
>  include ../../../lib.mk

Hi Wang Liang,

As per commit f07f91a36090 ("selftests: net: unify the Makefile formats")
I think the desired format is as follows (completely untested!):

TEST_FILES := \
	ethtool-common.sh \
# end of TEST_PROGS

-- 
pw-bot: changes-requested

