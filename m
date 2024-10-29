Return-Path: <linux-kselftest+bounces-21022-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 764299B5704
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 00:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00C9CB22F42
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 23:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0432A20C01D;
	Tue, 29 Oct 2024 23:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cylx7kcr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67FB190665;
	Tue, 29 Oct 2024 23:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730244827; cv=none; b=WEmq5h2z5QvZIE/v5GsCp6+Da4w61GBGXcGI9FT7f7tmfYbUxVe9RnKK1NCfxLgHjoErfEQA4h/v3uBPBMXgrLttqYI+FT9PXcEU42Re7LUlt111SJbC9hHw4BfPK3Z69uTarXC3b3EvgTKnaFV32mFholWJMzFeJl4KAA+IBQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730244827; c=relaxed/simple;
	bh=yHTmnEDobpeaBdAjL2m1Muml6fIMSZI5JfvgmlPZQJs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=miivwHK+tRDNXcVgW9txndriwIzy6UpQoFO2P9eA7//Nk9O9oFLAm6Gu5Z33xAeuLSMCMVuvOLrRKzVlBxNDIEoAcJPX0uycl1ndWvePuQ/+cYk61sHGbCgae6w/21PEGOlsuc4yvyCKHH6JB8qTHOjD4jxIIdswEvx9TY9oUa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cylx7kcr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDD6EC4CECD;
	Tue, 29 Oct 2024 23:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730244827;
	bh=yHTmnEDobpeaBdAjL2m1Muml6fIMSZI5JfvgmlPZQJs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Cylx7kcrJVTzZUZGoQc2s4qzGvuOHoIx3IdCZ3MO0aiyuly5KYRMfH/dDoYl6Xfgw
	 /de+C/Q2YhQ/J1Jok1O6PykWaS5HzTmzGyyjVz7XgbT/abiDe6MIFUzRI3bj8Z+KMv
	 92fCjT1qtH4kNqIL76HowWrybWBqrFTBReqjoOGhJo3gIJ6OWnoY8SZnW036+/7P1f
	 wpYngs+FGU+eaAqtAZiHdeiLlRL5Is6WU6W4gWX+hTVvIbhl3OWKsv9IQp83RAn0fp
	 8xgwNUbz8b13mK8iHJHbyD+lxlBnDrWGNTUivuzah35fzWyi4E5RpA2Q7mjmM9cdGg
	 vpICEwW3ClkMA==
Date: Tue, 29 Oct 2024 16:33:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: linux-kselftest@vger.kernel.org, shuah@kernel.org,
 linux-kernel@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netfilter-devel@vger.kernel.org,
 coreteam@netfilter.org, netdev@vger.kernel.org
Subject: Re: [PATCH for-next 4/7] selftests/net: Add missing gitignore file
Message-ID: <20241029163345.19ff1bc0@kernel.org>
In-Reply-To: <20241025014010.6533-4-lizhijian@fujitsu.com>
References: <20241025014010.6533-1-lizhijian@fujitsu.com>
	<20241025014010.6533-4-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Oct 2024 09:40:07 +0800 Li Zhijian wrote:
> diff --git a/tools/testing/selftests/net/netfilter/.gitignore b/tools/testing/selftests/net/netfilter/.gitignore
> index 0a64d6d0e29a..eef8d5784e94 100644
> --- a/tools/testing/selftests/net/netfilter/.gitignore
> +++ b/tools/testing/selftests/net/netfilter/.gitignore
> @@ -4,3 +4,4 @@ connect_close
>  conntrack_dump_flush
>  sctp_collision
>  nf_queue
> +conntrack_reverse_clash

This gitignore file appears to be sorted, please move the new entry up
into the right place and repost as a standalone patch (not part of a
series) so that its easier to netfilter maintainers to pick it up.

