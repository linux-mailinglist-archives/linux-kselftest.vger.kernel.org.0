Return-Path: <linux-kselftest+bounces-43760-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8E2BFC933
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 16:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 026844EEFC4
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 14:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593BC33373B;
	Wed, 22 Oct 2025 14:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iN44lxwi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3075535BDAB;
	Wed, 22 Oct 2025 14:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761143618; cv=none; b=k9Mte0JxI0kzSSgZkn/v8olnqxfGfamyeABM6ApZj7fK1zF++5yNwiMVmr0oBped35lVkO6F6Tqsg7URtSyaLlY+vv8YqHa+mKlIPgExVIFvzoP9chkNAVt5XLe3uT70yfk8oTPG/kr7cR8pGStuv/+N+gh3fLMEiAFequWV6hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761143618; c=relaxed/simple;
	bh=6tM2UgCr2gmFqK+uA4QQnT2L8cTSznjzpaJ4HgWK02o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rKgHvrRX+XGSCmB5bkloh94t88c6beGwCrXVnxlxW9e2oszpm/DWuP+dvwwIjjaxbMSoUdERyUZJy7/UqjeZ1rhJLFWrQEzi6GE2mM0ear2qJgDrHRVNGJa9mkYysNdn3yRb390kBNquh55Jg/XlE7beIMsqZCCLNltGq1/lrMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iN44lxwi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BF73C4CEF5;
	Wed, 22 Oct 2025 14:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761143618;
	bh=6tM2UgCr2gmFqK+uA4QQnT2L8cTSznjzpaJ4HgWK02o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iN44lxwieBv6h4cuONVt50dPTps/aVmwhGwZEPLUssJmvggjnxIu0odWngHyBPA63
	 43+DM30BIpWYEZhi6mN+G1Jv1Ub/ijL7FtR+fTr0DSs98UBOVFrs3XCHe2zQ3yJ3xH
	 t+58J1z2c43f/UdAUz6B7OiYagzhFkMZ2BZ2xWweuaKweCRppznW/X2rAnJPiovWDS
	 h7S174JwGpLZKuRlGa+7pKQsqvSJngt8nN+0azVqx5wL6RMwPSdprHBANRYWeiWwKY
	 RWOIzc9C6Dfogr4io6832RQn2+SB/k1jOJnBp2C483uoLq9xm2fNrHFkaxPhxqYV/U
	 j95A4faPEsGgg==
Date: Wed, 22 Oct 2025 15:33:33 +0100
From: Simon Horman <horms@kernel.org>
To: Alessandro Zanni <alessandro.zanni87@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftest: net: prevent use of uninitialized variable
Message-ID: <aPjrPehLi14L9zuQ@horms.kernel.org>
References: <20251021165451.32984-1-alessandro.zanni87@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251021165451.32984-1-alessandro.zanni87@gmail.com>

On Tue, Oct 21, 2025 at 06:54:33PM +0200, Alessandro Zanni wrote:
> Fix to avoid the usage of the `ret` variable uninitialized in the
> following macro expansions.
> 
> It solves the following warning:
> 
> In file included from netlink-dumps.c:21:
> netlink-dumps.c: In function ‘dump_extack’:
> ../kselftest_harness.h:788:35: warning: ‘ret’ may be used uninitialized [-Wmaybe-uninitialized]
>   788 |                         intmax_t  __exp_print = (intmax_t)__exp; \
>       |                                   ^~~~~~~~~~~
> ../kselftest_harness.h:631:9: note: in expansion of macro ‘__EXPECT’
>   631 |         __EXPECT(expected, #expected, seen, #seen, ==, 0)
>       |         ^~~~~~~~
> netlink-dumps.c:169:9: note: in expansion of macro ‘EXPECT_EQ’
>   169 |         EXPECT_EQ(ret, FOUND_EXTACK);
>       |         ^~~~~~~~~
> 
> The issue can be reproduced, building the tests, with the command:
> make -C tools/testing/selftests TARGETS=net
> 
> Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
> ---
>  tools/testing/selftests/net/netlink-dumps.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/netlink-dumps.c b/tools/testing/selftests/net/netlink-dumps.c
> index 7618ebe528a4..8ebb8b1b9c5c 100644
> --- a/tools/testing/selftests/net/netlink-dumps.c
> +++ b/tools/testing/selftests/net/netlink-dumps.c
> @@ -112,7 +112,7 @@ static const struct {
>  TEST(dump_extack)
>  {
>  	int netlink_sock;
> -	int i, cnt, ret;
> +	int i, cnt, ret = 0;

Hi Alessandro,

I suggest moving this line so that reverse xmas tree order - longest
line to shortest - is preserved.

>  	char buf[8192];
>  	int one = 1;
>  	ssize_t n;
> -- 
> 2.43.0
> 

