Return-Path: <linux-kselftest+bounces-45076-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F3106C3F51E
	for <lists+linux-kselftest@lfdr.de>; Fri, 07 Nov 2025 11:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B30304E84EF
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Nov 2025 10:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB892DECC6;
	Fri,  7 Nov 2025 10:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uvrh7bmg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711791E51EE;
	Fri,  7 Nov 2025 10:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762510029; cv=none; b=qjhIfUYwU8Vfwm+Ez/y9vKUufhp262nYJz59seQ/zIDw7NhzOrn1BPb0JxtYMl+5pgIRjAHMKBs/d+Mzk9flkCtejqgGO4gMTnLUctkmxIJxeN+A4nnxL4Z3TtO6JpvL0uV5Mzb7yPwqa5LT0o97EfB9lzrh9eFKxfjGtQHSJLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762510029; c=relaxed/simple;
	bh=WZtYsbZz7hq8cRUYVl0CzWnKlpyzLq2MAyNfLf/oWDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D1rHOdLTib1+DkrT2sHCt3Q9tf1LkUspEfJyfiZuKj0WhMBRoc8mieoP4T+rvwhXredew2Q/sv2i+O+8IpNv7AUr0jPGjUzv+42yak0E2cUFNIAUU8HU66DA0HKyMgEjD67UUxW7W63HDGrmdt1cE4lI3acxZbqNd6Osj+hnB18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uvrh7bmg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E574EC4CEF5;
	Fri,  7 Nov 2025 10:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762510027;
	bh=WZtYsbZz7hq8cRUYVl0CzWnKlpyzLq2MAyNfLf/oWDw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uvrh7bmgBY+tBAsb7DD+U4/m89SPAsoSQ3LXDSimnyIf4WNhMI2r9V21BDQDewyyp
	 enggThienU6s+tm7RuggvjIn9IvQIt9zZzyfp2d8+nPzd99PvwSl36Tir7IHSlqtzg
	 4Fq39T5zVRSXg8WMF9sZbLcKw9iW6/wSMMpOZrgDgxmQ7r5j+QKSG3/so/Fvy5xhFA
	 7vkBtEpyTZNV7pnN9dH6yBx6N7pN8HUocqRLnBIokHX5VOxcI+UIBZGu3y59EjunHu
	 UifLxToXJifOqCH03Ja9cZg+HqkLBHj4kkJUYkRFsENdB81uyvasPsYrRa7NFENFuG
	 9CCMtDrY16aZA==
Date: Fri, 7 Nov 2025 10:07:01 +0000
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, david decotigny <decot@googlers.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, asantostc@gmail.com, efault@gmx.de,
	calvin@wbinvd.org, kernel-team@meta.com, jv@jvosburgh.net
Subject: Re: [PATCH net v9 4/4] selftest: netcons: add test for netconsole
 over bonded interfaces
Message-ID: <aQ3ExWwuiiN0xyBE@horms.kernel.org>
References: <20251106-netconsole_torture-v9-0-f73cd147c13c@debian.org>
 <20251106-netconsole_torture-v9-4-f73cd147c13c@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106-netconsole_torture-v9-4-f73cd147c13c@debian.org>

On Thu, Nov 06, 2025 at 07:56:50AM -0800, Breno Leitao wrote:
> This patch adds a selftest that verifies netconsole functionality
> over bonded network interfaces using netdevsim. It sets up two bonded
> interfaces acting as transmit (TX) and receive (RX) ends, placed in
> separate network namespaces. The test sends kernel log messages and
> verifies that they are properly received on the bonded RX interfaces
> with both IPv4 and IPv6, and using basic and extended netconsole
> formats.
> 
> This patchset aims to test a long-standing netpoll subsystem where
> netpoll has multiple users. (in this case netconsole and bonding). A
> similar selftest has been discussed in [1] and [2].
> 
> This test also tries to enable bonding and netpoll in different order,
> just to guarantee that all the possibilities are exercised.
> 
> Link: https://lore.kernel.org/all/20250905-netconsole_torture-v3-0-875c7febd316@debian.org/ [1]
> Link: https://lore.kernel.org/lkml/96b940137a50e5c387687bb4f57de8b0435a653f.1404857349.git.decot@googlers.com/ [2]
> Signed-off-by: Breno Leitao <leitao@debian.org>

Thanks, my understanding is that this address Paolo's review of v7.

Reviewed-by: Simon Horman <horms@kernel.org>

...

> diff --git a/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh b/tools/testing/selftests/drivers/net/lib/sh/lib_netcons.sh

...

> @@ -137,15 +145,17 @@ function _create_dynamic_target() {
>  	then
>  		echo 1 > "${NCPATH}"/extended
>  	fi
> +}
>  
> +function create_and_enable_dynamic_target() {
> +	_create_dynamic_target "${FORMAT}" "${NCPATH}"
>  	echo 1 > "${NCPATH}"/enabled
> -
>  }
>  
>  function create_dynamic_target() {
>  	local FORMAT=${1:-"extended"}
>  	local NCPATH=${2:-"$NETCONS_PATH"}
> -	_create_dynamic_target "${FORMAT}" "${NCPATH}"
> +	create_and_enable_dynamic_target "${FORMAT}" "${NCPATH}"

Sorry for not noticing this when I looked over v8.
It's not that important and I don't think it should block progress.

create_and_enable_dynamic_target() seems to only be used here.
If so, perhaps the 'enabled' line could simply be added to
create_dynamic_target() instead of creating adding
create_and_enable_dynamic_target().

>  
>  	# This will make sure that the kernel was able to
>  	# load the netconsole driver configuration. The console message

...

