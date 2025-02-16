Return-Path: <linux-kselftest+bounces-26732-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA8CA37309
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Feb 2025 10:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32A181889733
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Feb 2025 09:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC2C17BB16;
	Sun, 16 Feb 2025 09:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lJUSv6AL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00F3748F;
	Sun, 16 Feb 2025 09:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739697710; cv=none; b=hvl/UVpF899657HkyaFVXokhVnLmO6aT2IYgUzM9Untn2ETO/db+GmearJuyZBq5Rs1C8UJqesHlMclL6vp/sVm7eMDzqTYoQjBAsq1hj4sikvu5PweYDC4lBIH6ZRiPGtMiKxuaMmVH1TTD/bXP41jeEkp/zKPRN6tx8bjS2cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739697710; c=relaxed/simple;
	bh=VH4VD6duncdZbySK8dpWl861MwxA2T+57iz/zOyt5Lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kqqLi+HGxU9y72+P9q3IpTiSn+fOiJN9ZtrCxuGh1+DjLNzZy9f06BqTHHn2LRUr02FIfQI1QiYuxJgp3GDWiCR8HWk8HyZ0FGaG5FmV6HIDhkc29QN9jYdbfHdxrSbtufzj7ZSCWi1Um1yenmALp7Yt2dOjFjW1OPRo5pguFUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lJUSv6AL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C49DDC4CEDD;
	Sun, 16 Feb 2025 09:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739697710;
	bh=VH4VD6duncdZbySK8dpWl861MwxA2T+57iz/zOyt5Lk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lJUSv6AL1SADA8bbvfEHV/IwCmOYjV2PtYLp5dZD8jLcM4/OgomyX2mIEz4fz1Dyl
	 x1flFPG5+Rr2SjCtnWGBifrONc8j8NF6DkLYfE8FKe608CfVc3NZkC+A8B3ifgYsLW
	 9Go7+8OdaIpkrU/uMWXWyuxF6wy6RYwW50QPUI/kxpqMzcvQaEBb1c32mX9M5qrELx
	 mhBDC5WCqRBtk5cfSyerD6H9nwGKjHzJOEvD+NCGn9gP3Kno2VOzbXzValFcDVC/ia
	 w91QSU3nLSxYwdlakVPCZunIaRYvtpUG99yz9SFN8kzbsdAcsMe2gwTPfphpBX3BST
	 s5JWCkji+WTnQ==
Date: Sun, 16 Feb 2025 09:21:45 +0000
From: Simon Horman <horms@kernel.org>
To: Peter Seiderer <ps.report@gmx.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Artem Chernyshev <artem.chernyshev@red-soft.ru>,
	Nam Cao <namcao@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH net-next v5 2/8] net: pktgen: enable 'param=value' parsing
Message-ID: <20250216092145.GX1615191@kernel.org>
References: <20250213110025.1436160-1-ps.report@gmx.net>
 <20250213110025.1436160-3-ps.report@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213110025.1436160-3-ps.report@gmx.net>

On Thu, Feb 13, 2025 at 12:00:19PM +0100, Peter Seiderer wrote:
> Enable more flexible parameters syntax, allowing 'param=value' in
> addition to the already supported 'param value' pattern (additional
> this gives the skipping '=' in count_trail_chars() a purpose).
> 
> Tested with:
> 
> 	$ echo "min_pkt_size 999" > /proc/net/pktgen/lo\@0
> 	$ echo "min_pkt_size=999" > /proc/net/pktgen/lo\@0
> 	$ echo "min_pkt_size =999" > /proc/net/pktgen/lo\@0
> 	$ echo "min_pkt_size= 999" > /proc/net/pktgen/lo\@0
> 	$ echo "min_pkt_size = 999" > /proc/net/pktgen/lo\@0
> 
> Signed-off-by: Peter Seiderer <ps.report@gmx.net>

Reviewed-by: Simon Horman <horms@kernel.org>

