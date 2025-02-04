Return-Path: <linux-kselftest+bounces-25685-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18ABAA274A4
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 15:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB08F7A1053
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 14:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F04D2135DF;
	Tue,  4 Feb 2025 14:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7nyxwBl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4058207679;
	Tue,  4 Feb 2025 14:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738680230; cv=none; b=T+yS4MZ35/ELgxRLK4O9PgXMGRGKnYRZmSjTO05JnkTARMvUtWENNLebcuHmUL0pSw1xd4Diubrs9NY/pYQBpuaZDywhcBbw378l3QOrJcS3fUVw7U0EqPxEKj1LpR7Hj+k3aQ4zNdmzGpUiqYNnBduUPWhf9ggwpAt6ym8uGD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738680230; c=relaxed/simple;
	bh=opNk7WE6pGAh53lJlLsM3LPrvl5qb33kmosTioaevuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IPKJrTPAYOsT4sQy3uFcPm/4Lp8lZusOg6+z59PNJnzzWtYUHcgnIZFShTQdRJ7iJi1lqnDbpgjIBADQbhC7aemW+7B+E+ST7ASDctgSjxgyMyWtOIxCYJ3nXYiUoQt0hZFdbiCN/UeGpSVl4SND/57NR+2QxD+9qFB7SjeBXD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W7nyxwBl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36FC7C4CEDF;
	Tue,  4 Feb 2025 14:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738680229;
	bh=opNk7WE6pGAh53lJlLsM3LPrvl5qb33kmosTioaevuc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W7nyxwBlamtBfbA/l8K2Dbni5fvY3Adapm1A8vcHDRhd7KcrK1+084CnCocCl7Q27
	 d8nMIgfd3HrnytMz30JfQVA4VC4D+woQMaxymhg4sMGZWSV2wr09aSc+ToJddZcS6T
	 pObgoUizjkRnhonHYlYDOvu705UwOj5HonOzkZuZtstSDQK7gQMJL8ZQBkFOVLRifn
	 M5ykdZB6oiLEtV15hQnFqoyyyruo0V3lH1bzLfCKJI3Ard1XK/xQlPUWePpJYh/Ppp
	 0OWYMxF8vewP7N5S3YTkvBayI5hs1Yna2bjW/Jc+6k11FRnsf68dbzW6710svBziLr
	 RSQ6Nna178IbQ==
Date: Tue, 4 Feb 2025 14:43:43 +0000
From: Simon Horman <horms@kernel.org>
To: Peter Seiderer <ps.report@gmx.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Nam Cao <namcao@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Artem Chernyshev <artem.chernyshev@red-soft.ru>
Subject: Re: [PATCH net-next v3 03/10] net: pktgen: fix hex32_arg parsing for
 short reads
Message-ID: <20250204144343.GG234677@kernel.org>
References: <20250203170201.1661703-1-ps.report@gmx.net>
 <20250203170201.1661703-4-ps.report@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250203170201.1661703-4-ps.report@gmx.net>

On Mon, Feb 03, 2025 at 06:01:54PM +0100, Peter Seiderer wrote:
> Fix hex32_arg parsing for short reads (here 7 hex digits instead of the
> expected 8), shift result only on successful input parsing.
> 
> - before the patch
> 
> 	$ echo "mpls 0000123" > /proc/net/pktgen/lo\@0
> 	$ grep mpls /proc/net/pktgen/lo\@0
> 	     mpls: 00001230
> 	Result: OK: mpls=00001230
> 
> - with patch applied
> 
> 	$ echo "mpls 0000123" > /proc/net/pktgen/lo\@0
> 	$ grep mpls /proc/net/pktgen/lo\@0
> 	     mpls: 00000123
> 	Result: OK: mpls=00000123
> 
> Signed-off-by: Peter Seiderer <ps.report@gmx.net>

Reviewed-by: Simon Horman <horms@kernel.org>


