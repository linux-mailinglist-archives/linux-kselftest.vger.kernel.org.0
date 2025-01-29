Return-Path: <linux-kselftest+bounces-25395-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C86A224F4
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 21:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A33716721E
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 20:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2D9199921;
	Wed, 29 Jan 2025 20:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TBYGpX/2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5385B29A2;
	Wed, 29 Jan 2025 20:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738181128; cv=none; b=UBJZAlNfmz8JOGLxnlSa2U96rTXkFmB0HSmH3XskKt8xXyax41R+oo0oylnyIm/bzAXX4aJ1Mp4lw3mFN2zEVcifoe0hp9aJCdodZS3s+VPSMBSSZFYc+OV2GGKbHsp4Fyp3qKs5iaHpnqdUG3llxsL0ztwKV9mICAh0RQgHMMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738181128; c=relaxed/simple;
	bh=ctiHtXdHi1w62PgzZwSkmiiiPPdzp0pSp2L7RWvYviE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i0C6M/Wc6ptE7JTS/tOv/23/kCHGrgt8tPCrJKJ560R9gYXUo+GxNL4eRr91GIU61wWnjbGxApIUh3lm8sSRj30kFtc8IwUQlqZpL4hJdRHvi9WzrM20vkKZ3R+4FxywllDmULErus5TUc9ZukSkpglD/jwF0VEYACrfY+62pd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TBYGpX/2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AFE9C4CED1;
	Wed, 29 Jan 2025 20:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738181128;
	bh=ctiHtXdHi1w62PgzZwSkmiiiPPdzp0pSp2L7RWvYviE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TBYGpX/23LzeD9iFp5304St7Oq8+pAv7QL64Im1mzecTvpZK2XGJwPa/W4wiz1nYb
	 T7bYxuIH+cyNJKmPBohy7mQl2U/VT1TwgSeQOOeNqVUjI3ka/bPpO6nT9n2+b3em8G
	 K7m4ko0DmMLTbHaTubNgluq6wVhLgikDeQd00Uf+Y4YoHrwYywzcy9DwBZrl1oCgrk
	 Pk78ydKcrN9EUDaWEjjCTkRcY3jCLVjmGxd8f2DQT56KgFFElBgI2V79NkBXNkREC6
	 R0amNmk61eKcOX695Np9rLBQsGDobQ7okAsUBuuuV2y0vEK5iAruGaNgEopBueTpXq
	 Yn6nN79tk4ufw==
Date: Wed, 29 Jan 2025 12:05:26 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Anna Emese Nyiri <annaemesenyiri@gmail.com>
Cc: netdev@vger.kernel.org, fejes@inf.elte.hu, edumazet@google.com,
 pabeni@redhat.com, willemb@google.com, idosch@idosch.org,
 davem@davemloft.net, horms@kernel.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 1/1] selftests: net: Add support for testing
 SO_RCVMARK and SO_RCVPRIORITY
Message-ID: <20250129120526.7ba0958b@kernel.org>
In-Reply-To: <20250129143601.16035-2-annaemesenyiri@gmail.com>
References: <20250129143601.16035-1-annaemesenyiri@gmail.com>
	<20250129143601.16035-2-annaemesenyiri@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Jan 2025 15:36:01 +0100 Anna Emese Nyiri wrote:
> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
> index 73ee88d6b043..98f05473e672 100644
> --- a/tools/testing/selftests/net/Makefile
> +++ b/tools/testing/selftests/net/Makefile
> @@ -33,6 +33,7 @@ TEST_PROGS += gro.sh
>  TEST_PROGS += gre_gso.sh
>  TEST_PROGS += cmsg_so_mark.sh
>  TEST_PROGS += cmsg_so_priority.sh
> +TEST_PROGS += test_so_rcv.sh

You need to add the C part to the TEST_GEN_PROGS, otherwise it won't
get built. We're seeing:

./test_so_rcv.sh: line 25: ./so_rcv_listener: No such file or directory

in the CI.

> +	memset(&recv_addr, 0, sizeof(recv_addr));
> +	recv_addr.sin_family = AF_INET;
> +	recv_addr.sin_port = htons(atoi(opt.service));
> +
> +	if (inet_pton(AF_INET, opt.host, &recv_addr.sin_addr) <= 0) {
> +		perror("Invalid address");
> +		ret_value = -errno;
> +		goto cleanup;
> +	}

Any reason not to use getaddrinfo() ?

Otherwise LGTM, thanks for following up!
-- 
pw-bot: cr

