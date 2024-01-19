Return-Path: <linux-kselftest+bounces-3249-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F67A832D11
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jan 2024 17:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC9E92887AA
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jan 2024 16:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2866654F9E;
	Fri, 19 Jan 2024 16:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EiPLr2BC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6423C465;
	Fri, 19 Jan 2024 16:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705681531; cv=none; b=c+VqIcUUUqhCR1b2GL1RgNc0Xgwq4JCEP8gh+YH9aAgfTyePj3xnwIWbN3OKUdK8AFqIYQyJL48bM+2vHY+KylMu3HNePkUJFOMagSKs72JLk86xfaoAGExMBDJeGI6kwU6hA3/Lc2nkINESeu6HImHtUMxUAtgz4jbOQj18YLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705681531; c=relaxed/simple;
	bh=CUedaJecjVn9/eW2Kn50wI1Ofx5Wa2B1ziJ3bXJwdlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I3CFMC/qXi8XuuRk1KI85M0V/jlaRaycqYmYQNUzD3mbE2fsgYomKEshPL8rycPbqK7UvDhFHSiv4Z7QEkBXDS/TaKZl1k3ip0UN+s/b2JtnjGMLatzB9zTdfa99eXxAr69/tGy8KIDaea1P9ucKrG+hXShBQDVCVydb3xnC4AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EiPLr2BC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 145FCC433F1;
	Fri, 19 Jan 2024 16:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705681530;
	bh=CUedaJecjVn9/eW2Kn50wI1Ofx5Wa2B1ziJ3bXJwdlw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EiPLr2BClF200oaMQ2GKzgt79f6UwpvJ25fN9CavTbAPBxLwcLhjUPKzfBZBZez5K
	 II/JfzKKjjXUMya3er/o+qWS8ua6CkfftMPj7EFQlyrFMAkasnhN0CWmqkrTshSD1N
	 FpjylsY6m5RzjI70gZ3iWCzZ7ggpfmSiJqXU1buHsxl0IVmdUNMnawEokurPWxzeJV
	 w72KbqhxZTj5ag3uf6mcDkv+dJPJN5CQnLsuAxUD1CZgx52O8jPgg2heFTYlCEtAod
	 uU/wVPUlLtRYT+BghrMCWwupEn80a/8ElDaQ8b8F5ExeJbU5mh1uCyR3qBi/y4Mjlq
	 nI0wmizAsB+Uw==
Date: Fri, 19 Jan 2024 16:25:25 +0000
From: Simon Horman <horms@kernel.org>
To: Dmitry Safonov <dima@arista.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Dmitry Safonov <0x7f454c46@gmail.com>,
	Mohammad Nassiri <mnassiri@ciena.com>, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] selftests/net: Clean-up double assignment
Message-ID: <20240119162525.GF89683@kernel.org>
References: <20240118-tcp-ao-test-key-mgmt-v1-0-3583ca147113@arista.com>
 <20240118-tcp-ao-test-key-mgmt-v1-3-3583ca147113@arista.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118-tcp-ao-test-key-mgmt-v1-3-3583ca147113@arista.com>

On Thu, Jan 18, 2024 at 02:51:36AM +0000, Dmitry Safonov wrote:
> Yeah, copy'n'paste typo.
> 
> Fixes: 3c3ead555648 ("selftests/net: Add TCP-AO key-management test")
> Reported-by: Nassiri, Mohammad <mnassiri@ciena.com>
> Closes: https://lore.kernel.org/all/DM6PR04MB4202BC58A9FD5BDD24A16E8EC56F2@DM6PR04MB4202.namprd04.prod.outlook.com/
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---

Hi Dmitry,

This seems more like a clean-up than a fix.

>  tools/testing/selftests/net/tcp_ao/lib/sock.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/tcp_ao/lib/sock.c b/tools/testing/selftests/net/tcp_ao/lib/sock.c
> index c75d82885a2e..923a9bb4f1ca 100644
> --- a/tools/testing/selftests/net/tcp_ao/lib/sock.c
> +++ b/tools/testing/selftests/net/tcp_ao/lib/sock.c
> @@ -377,7 +377,6 @@ int test_get_tcp_ao_counters(int sk, struct tcp_ao_counters *out)
>  
>  	key_dump[0].nkeys = nr_keys;
>  	key_dump[0].get_all = 1;
> -	key_dump[0].get_all = 1;
>  	err = getsockopt(sk, IPPROTO_TCP, TCP_AO_GET_KEYS,
>  			 key_dump, &key_dump_sz);
>  	if (err) {
> 
> -- 
> 2.43.0
> 

