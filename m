Return-Path: <linux-kselftest+bounces-46128-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07750C751DA
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 16:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 174852AF46
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 15:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D0934A3B0;
	Thu, 20 Nov 2025 15:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="AIiLx2bV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1478230BB8F;
	Thu, 20 Nov 2025 15:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763653644; cv=none; b=ESX0IYJmXOxSWRk4mqEmQ7S4ifMMq8mibAqa5RTRbl7iT7k9ClLo1irbI1julTXs1N7UFO8nJ11kc1O6amgSUOD2bsawnpSj6wsf5MatMTjOKi3mHdlVogyNY6AW1bem03fAVJsFcUaraCA1Jb/N5CdaN1pkPhw3ZaFxwxUjcy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763653644; c=relaxed/simple;
	bh=HBfJno7BvPPCiNzoRKdM+LnCU5yqxe07vdiji4/UFdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gQv6eWrOxqaFnmcKucV3QZTMgy3v6JtU1bJDgWaqDRfhGYcpoBVMDM6FJvmfkBfwUW08YjWUwUsROCxWFUW5bcKrNRbge7pT+lPVFH9TagCYE6W4cfMVB8ySshnJz1sFST/N5oNQPqNA2VpETxJISG9HIbgL7Pevg2ixN39h/PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=AIiLx2bV; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TrUtfR6lBLr7f4nfAXkGM59HBmE9/Z1ZFPRFLBh6dic=; b=AIiLx2bVDhrLaRqRB6IOMoC4WL
	rrSAn411J2SqyTKZLPdK01HSqbw0eO8Clw8iXDbK3K2T9uLE33Pv/OXh6ZDL+UtY/1NyW603pPsVj
	8Ohh88OKhble+ifDUXjkm4QNSrTTuW/MDdavW6EFeKanBjFPk827syjefqTGWmBUqp3n0Qx+TrSi2
	RTMcBenUvUS9UrayyganB+SnCVGYd82ueL1TWjYxGViF4ESE2o0MszLpfcRsmnG2Nsv6CGa1rXoXS
	UwQ03vSRJ00wG9O0R5Ob12ix2MslH00SGG9bX4vMjRTBAODtq+VkK8Kf6X6nyQUO4kGRZ8szh5y63
	WsoIgUGw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vM6sO-00H0vZ-Fw; Thu, 20 Nov 2025 15:47:16 +0000
Date: Thu, 20 Nov 2025 07:47:11 -0800
From: Breno Leitao <leitao@debian.org>
To: Andre Carvalho <asantostc@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v5 4/5] netconsole: resume previously
 deactivated target
Message-ID: <jlxgiuqnkwdjujcpv2eaaq4b7yvkynkabnhwlt34cwctladpim@aoeikoylbnld>
References: <20251119-netcons-retrigger-v5-0-2c7dda6055d6@gmail.com>
 <20251119-netcons-retrigger-v5-4-2c7dda6055d6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119-netcons-retrigger-v5-4-2c7dda6055d6@gmail.com>
X-Debian-User: leitao

On Wed, Nov 19, 2025 at 07:49:22AM +0000, Andre Carvalho wrote:
> Attempt to resume a previously deactivated target when the associated
> interface comes back (NETDEV_UP event is received) by calling
> __netpoll_setup on the device.
> 
> Depending on how the target was setup (by mac or interface name), the
> corresponding field is compared with the device being brought up.
> 
> Targets that are candidates for resuming are removed from the target list
> and added to a temp list, as __netpoll_setup is IRQ unsafe.
> __netpoll_setup assumes RTNL is held (which is guaranteed to be the
> case when handling the event). In case of success, hold a reference to
> the device which will be removed upon target (or netconsole) removal by
> netpoll_cleanup.
> 
> Target transitions to STATE_DISABLED in case of failures resuming it to
> avoid retrying the same target indefinitely.
> 
> Signed-off-by: Andre Carvalho <asantostc@gmail.com>

Reviewed-by: Breno Leitao <leitao@debian.org>

This is now conflicting with Gustavo's patchset. I would suggest we get
Gustavo's patches merged first, and then you respin this one, please.

Thus, I am marking this as "change-requested" just to help the main
network maintainers, if that is the right process.

--
pw-bot: cr

