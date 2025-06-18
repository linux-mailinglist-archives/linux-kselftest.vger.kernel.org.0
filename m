Return-Path: <linux-kselftest+bounces-35268-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DD2ADE920
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 12:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54E9E3B175E
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 10:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49A1285040;
	Wed, 18 Jun 2025 10:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GdSGfVWY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA50F1F3FED;
	Wed, 18 Jun 2025 10:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750242861; cv=none; b=haA/9K7YciRP2EFvOxOpUl1zBeEbCdz4wULnZXPGoOqJ99hkU3cWGEVRgmuufRwT6NN9JRmuiHPDtY8Qr2LXeAFpHijDIYjak73lLxTDIIMUp/rJsVsEgWrTuEclFQNZoYhTtZHWbKQxPSIBHrt4UnMTxOxCCZ12DJISsvjXrCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750242861; c=relaxed/simple;
	bh=PwPfAAmn+kW3DanE5qUczEGSEkKeIYW9SgBb7kO2sXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DT9WV5bh92TFkxk0K/PrxYrNzhdH5COzpv8sjazUgSiXhn5bYkyESBC4WxLKq+ViDadVyy/vsKr3UmAuXKoQCrW8aNYGToWlQ3++ULlaZcm7nCOzBVUM5ti5S4k4lhwow9yEs3Ydw3osxde0Czi7quanzijaaZVFcGBzWeWlfHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GdSGfVWY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A98F0C4CEE7;
	Wed, 18 Jun 2025 10:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750242861;
	bh=PwPfAAmn+kW3DanE5qUczEGSEkKeIYW9SgBb7kO2sXU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GdSGfVWYm0wAqnaEvTu8qQPJxTdsvHiL0AfFsxt3oGUl7Y3zVO9SrZkf508Kk/0Ke
	 EOZMfEoahq1VUVeEh7GDbhQIOlYsYNcGiQCV4aM/gbE6mxGC8MyA0E14Yuvf8bmGmR
	 AzFgsiN+KsnUGk2wgx/kspxNGc2RMwTPsak1jkt+CVVqq3Yv5ocTF0yHSBWahCcnOo
	 BXqX/1hPLh5j7pQs0qmKq8lJgzLeDjAN/CJcmXfNKmeEzkJ9LznyibyFEsAZPC7Poa
	 sWXUpCb6dZPoO+em6khGquOSsEp47AqVmwyCVeklhkveQ17VIYDoKiYkF+32zy4jwl
	 4GOGSI4Ja9zDA==
Date: Wed, 18 Jun 2025 11:34:17 +0100
From: Simon Horman <horms@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] selftests: net: use slowwait to make sure
 IPv6 setup finished
Message-ID: <20250618103417.GC1699@horms.kernel.org>
References: <20250617105101.433718-1-liuhangbin@gmail.com>
 <20250617105101.433718-3-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617105101.433718-3-liuhangbin@gmail.com>

On Tue, Jun 17, 2025 at 10:51:00AM +0000, Hangbin Liu wrote:
> Sometimes the vxlan vnifiltering test failed on slow machines due to
> network setup not finished. e.g.
> 
>   TEST: VM connectivity over vnifiltering vxlan (ipv4 default rdst)   [ OK ]
>   TEST: VM connectivity over vnifiltering vxlan (ipv6 default rdst)   [FAIL]
> 
> Let's use slowwait to make sure the connection is finished.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


