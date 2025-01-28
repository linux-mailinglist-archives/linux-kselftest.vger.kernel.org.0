Return-Path: <linux-kselftest+bounces-25315-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 400B2A20E23
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 17:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CCBA1888A1C
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 16:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7B91C331E;
	Tue, 28 Jan 2025 16:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HTZ6IGfe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2DA13FD72;
	Tue, 28 Jan 2025 16:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738080759; cv=none; b=At8j4asR99dihdUSE8+rOpqJBRU/RtgzFRQ7s18oIfgjL1PGU2tT/aOHIiTLN+vUNXmTtR0ELhIZggJjm+fTEh98JRPmA7WbR0n/4xhOgOqJuFC7uSdXLwLx4xBCWIvOvvQfkHUngvaRp0Z0gS9Onrk9sikovknLKSI2II3m7zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738080759; c=relaxed/simple;
	bh=QWZ2A/7lG2ISbMmNG34nmuDjqzbZkZ7VV3VfzIHM7Zs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XjnLEBiiVTjDQo1uAa1Xs86/SexXrdXVjEaFS1gGl2DY22J323foQFN/PK0qHIH2LosxFV1Vj0BYUzw1qLGnyzpT29do1bdMO/b2+5DJ+GcMbams3bpiWvQ0/101mQnkoio1Gzj0iO/t9eBX8Tl6BQas9GP+ZjbaJXvOiz3J7UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HTZ6IGfe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CC49C4CED3;
	Tue, 28 Jan 2025 16:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738080759;
	bh=QWZ2A/7lG2ISbMmNG34nmuDjqzbZkZ7VV3VfzIHM7Zs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HTZ6IGfeQON5LKNDY2XXFHnUXrfy+hgt0esoeftKhRHAkc2UY4+HqZMIZMKH0LU5/
	 eyQDb+ZLV8196OIq/u9R2Kf+da7DmD4E5eVRnAjAuvAcgAPh9kpo8FygYMMOMvetZW
	 sf5jS/LZE5i3THfuSedweO2MeZqe51MbsI65mbKTm7NQJCtEbYbRPbSFS8igFAFg7B
	 t7FQGLbVRQuNdbRrhDeSkeqgcjJ0NTL4BrVXSFtFUzyacwAqjtoQzqLx1tunZcKtkt
	 vTBN/VTMyBYzP31+l7rrfK1695I5r//xCv/qcF8Ovspl3v5hplqYpq53V63VUjh+4u
	 qamK4avc/NO0Q==
Date: Tue, 28 Jan 2025 16:12:34 +0000
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	rdunlap@infradead.org, kernel-team@meta.com
Subject: Re: [PATCH RFC net-next v3 4/8] netconsole: Introduce configfs
 helpers for sysdata features
Message-ID: <20250128161234.GC277827@kernel.org>
References: <20250124-netcon_cpu-v3-0-12a0d286ba1d@debian.org>
 <20250124-netcon_cpu-v3-4-12a0d286ba1d@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250124-netcon_cpu-v3-4-12a0d286ba1d@debian.org>

On Fri, Jan 24, 2025 at 07:16:43AM -0800, Breno Leitao wrote:
> This patch introduces a bitfield to store sysdata features in the
> netconsole_target struct. It also adds configfs helpers to enable
> or disable the CPU_NR feature, which populates the CPU number in
> sysdata.
> 
> The patch provides the necessary infrastructure to set or unset the
> CPU_NR feature, but does not modify the message itself.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  drivers/net/netconsole.c | 81 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 81 insertions(+)
> 
> diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c

...

> @@ -792,7 +817,62 @@ static ssize_t userdatum_value_store(struct config_item *item, const char *buf,
>  	return ret;
>  }
>  
> +/* disable_sysdata_feature - Disable sysdata feature and clean sysdata
> + * @nt: target that is diabling the feature

nit: disabling

> + * @feature: feature being disabled
> + */
> +static void disable_sysdata_feature(struct netconsole_target *nt,
> +				    enum sysdata_feature feature)
> +{
> +	nt->sysdata_fields &= ~feature;
> +	nt->extradata_complete[nt->userdata_length] = 0;
> +}

...

