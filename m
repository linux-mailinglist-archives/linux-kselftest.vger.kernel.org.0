Return-Path: <linux-kselftest+bounces-21779-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5029C3E49
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 13:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8282A1F20F10
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 12:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6113C19CC04;
	Mon, 11 Nov 2024 12:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r5wUdOSe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FEE18CC0B;
	Mon, 11 Nov 2024 12:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731327349; cv=none; b=Gr+TsB9TSzrdGlaO1j2cOOUUcqoIQyJU97J8U7vwTG9IpCKv0uJBSzPqArN+AqpKQSdm9zFTdBKr9a3vaCupdacvhoU3eW3rEfdFXiTDIgRFajw9TjnhnwQmJEOrF4aKBkrLHJZbdsh0v9Nqg5WNW3QsZMND3qMI59f3kAx6pac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731327349; c=relaxed/simple;
	bh=OMDya6tWENSARrc/uAgSJX0l5qkMGJFi1IUb/7IH8qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lJyURePqCPCJCH5otWTYt8+BDX1wG0Hi+OM1Xp6XG+JpvGS0rcBkVQLDEpYd9K3dNy4Kl61I8TrR1+nTE+fvba2UYJhacD0LMSucwAHAPWh1Vz7MH1A8VuaSKQacVAPpCcmt8JaFHEhcy28lFpxa8/n5/C/7iwh28dz/awOaWJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r5wUdOSe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2667C4CECF;
	Mon, 11 Nov 2024 12:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731327348;
	bh=OMDya6tWENSARrc/uAgSJX0l5qkMGJFi1IUb/7IH8qo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r5wUdOSeV29zsG+fYc9egO7TQtydbXh03GyflQCzc2N4zmL96RyMYYJx2sPAGwJnK
	 w2yyiZ3OALqOXHX3Xa5h2QD4RBLryHwZixXONYJ6TuOyhl2Eggj62fLR2EKVMy362Y
	 pQc66VVuU9uoNOSoc9hRHe377TpvpUQeRmmWMyVU2zDdap4V+6BfR2NOv0etvDmnaq
	 PQ4mGhEst+W6M1J4QgOOZ7h3VxweSFWH31ygHqNJ1vAb+iCz6zxNnF22dEQPKMC5nm
	 MiG8++WowP8NhJtLt5QgetfE6LU19BME8abjK9lA0HToH6UTqe4w4hnJ4OLN4oTMrZ
	 l/YCqENFtAUsw==
Date: Mon, 11 Nov 2024 12:15:45 +0000
From: Simon Horman <horms@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 3/8] macsec: add some of the lower device's
 features when offloading
Message-ID: <20241111121545.GW4507@kernel.org>
References: <cover.1730929545.git.sd@queasysnail.net>
 <8b32c3011d269d6f149724e80c1ffe67c9534067.1730929545.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b32c3011d269d6f149724e80c1ffe67c9534067.1730929545.git.sd@queasysnail.net>

On Thu, Nov 07, 2024 at 12:13:29AM +0100, Sabrina Dubroca wrote:
> This commit extends the set of netdevice features supported by macsec
> devices when offload is enabled, which increases performance
> significantly (for a single TCP stream: 17.5Gbps to 38.5Gbps on my
> test machines).
> 
> Commit c850240b6c41 ("net: macsec: report real_dev features when HW
> offloading is enabled") previously attempted something similar, but
> had to be reverted (commit 8bcd560ae878 ("Revert "net: macsec: report
> real_dev features when HW offloading is enabled"")) because the set of
> features it exposed was too large.
> 
> During initialization, all features are set, and they're then removed
> via ndo_fix_features (macsec_fix_features). This allows the
> offloadable features to be automatically enabled if offloading is
> turned on after device creation.
> 
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>

Reviewed-by: Simon Horman <horms@kernel.org>


