Return-Path: <linux-kselftest+bounces-46127-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C610BC7517C
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 16:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id A1A0B319F5
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 15:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A926340A70;
	Thu, 20 Nov 2025 15:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="QR9HcoWh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256EB35CBA6;
	Thu, 20 Nov 2025 15:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763653379; cv=none; b=Iy9jbm+PBQ1h2wnrmjMO9g/eJ4XAeS4kj3739bbkrE2g0UqY0q/0hX9Y6OSylHh+5Ujmwq62qjrs+3lJRYj3nL7adYfCqiTZJ4ygi8Wp7GGN1yKtMPr9X719LPVnUBXxwnSGg5/+I1jHzXVJcSoa7IwPIAtvSfbwH0PS77yGa6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763653379; c=relaxed/simple;
	bh=ygk1zHv6iDbGjm+GZZypyjLpCQV5gripf5JFKbjoQlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NdKSjv+q0Ho/4BYqT3QCz+KmpI78+uHObpcN1gd5GxaWo1sRn9kHeK1IimnaIYv1OPXzeG8z2Q2dco/tYLNmK1Gt4MbSQ7AuTzsi9hu1J5O7MUVpD8g5DDcFURVxW6r2qUYaFBY3cO3B9Kpa2f3tJbjY52s0jF2vRYcTbZK8sgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=QR9HcoWh; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1DejjWV5IE6Y627zgKuh4/6XZNhaCgxWanFFF8GFYD8=; b=QR9HcoWh7whqz+6106X2hPh4jm
	ZZvHSans8aqobvo/Nn/BsVoEEdrtmOIpVfyiV3ljEPP5q7uwbcPDMzU7TYi0eRd2D+1dSY4KONXHi
	dRDh0nIIZpRWyrrTCn5BYDMzKcsOmaXiTVA8ishDa+koErUE/1YzkptHJ4lhWPQX/WNk9cHKfL8Ws
	cG9ere8oan89QlM2GC/70F648tzMP5IrvrUVJ/bYb0Nx7vCE0eKEAAbA3sEcWrmqbERsPYEAwVm2z
	p3hHvzkPzMLaSPWFa2Ty1SwNwH0jKGFZcCelodIOzmq36erUKRZKpqM3iG7yKg72LsYqvCZc9DwMG
	M5Kwluig==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vM6o0-00H0jz-TT; Thu, 20 Nov 2025 15:42:45 +0000
Date: Thu, 20 Nov 2025 07:42:40 -0800
From: Breno Leitao <leitao@debian.org>
To: Andre Carvalho <asantostc@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v5 5/5] selftests: netconsole: validate target
 resume
Message-ID: <nmmxynre57tcwicbfgigh7arzmbugwshy7utp7laembwtnoqhb@ra3tdcapc5lt>
References: <20251119-netcons-retrigger-v5-0-2c7dda6055d6@gmail.com>
 <20251119-netcons-retrigger-v5-5-2c7dda6055d6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119-netcons-retrigger-v5-5-2c7dda6055d6@gmail.com>
X-Debian-User: leitao

On Wed, Nov 19, 2025 at 07:49:23AM +0000, Andre Carvalho wrote:
> Introduce a new netconsole selftest to validate that netconsole is able
> to resume a deactivated target when the low level interface comes back.
> 
> The test setups the network using netdevsim, creates a netconsole target
> and then remove/add netdevsim in order to bring the same interfaces
> back. Afterwards, the test validates that the target works as expected.
> 
> Targets are created via cmdline parameters to the module to ensure that
> we are able to resume targets that were bound by mac and interface name.
> 
> Signed-off-by: Andre Carvalho <asantostc@gmail.com>

Reviewed-by: Breno Leitao <leitao@debian.org>

