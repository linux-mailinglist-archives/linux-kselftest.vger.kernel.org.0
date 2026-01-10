Return-Path: <linux-kselftest+bounces-48669-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2214FD0DA0C
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Jan 2026 18:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 766A1300A501
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Jan 2026 17:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D6E28D8F1;
	Sat, 10 Jan 2026 17:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u+IsfEXC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4573519CD0A;
	Sat, 10 Jan 2026 17:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768067039; cv=none; b=mADiRV5ukzpMLnsUI7IM8lCMQKGv6XLoiSf2izG56HSjooQL2SnM0kxPzxYrBAhRJzSZldlqyQ9+147gQ+bbe7565FUSZc9JVbTdzCLHqGrrXoY/SWX+7TbEEsq0k+lDHVCU/nVOBhR4b4xrk7o0wv81k83Mx6h7U4A1TxDutHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768067039; c=relaxed/simple;
	bh=RzdLGJUcpACTY1/qZNpg82Y72LMhnpb5PbODpP+dHlk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sXza/5C4KRaw5fi/g+ZRTLXYw6rjbadMbJFbh49CAa+9gNlJnVyMeFRH30uAHkDx/3he94EUYmlnCz4HFiR+dEiIpNxiLM1Yf7Dg87KCPyY5Tq0dMhozxH1d0AFiE4pZxJwYeXsHYvZuHf1lj9n2PPdrABdDxFAJSVvvqv16H04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u+IsfEXC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EF56C4CEF1;
	Sat, 10 Jan 2026 17:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768067039;
	bh=RzdLGJUcpACTY1/qZNpg82Y72LMhnpb5PbODpP+dHlk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u+IsfEXCyOqdFL2v65MDuMnuOltSaY5C5GoL34HHbzOk7imEOZL6yKcfHMiDv7/9D
	 fiwMYOLNIF+X/TynTpYqV8+YPm5xMV/QC1Odo6S40C6BDwHAQl7TCjhS5C5YCNXGmp
	 mPZ6wA5dFVQHBXx2ygWHV6oGdbil0HHeSGbUoFwE6XZxNPs8pLJocVS9pyXszUlB8I
	 6T6qwY9Yq7C30+1Ms6JijPJsrPtc6bIQLe4RSwTYaqPRY7+A5fWNeC3I6aEf7qmqaV
	 HBh7I0gfmuUYEUzzIcRy9clbWL1/qfcsmwyH0M5eG1YwKcP3gRafWVlN0dzam0iQx3
	 gxAPXEljsAcUA==
Date: Sat, 10 Jan 2026 09:43:57 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, sdf@fomichev.me, willemb@google.com,
 petrm@nvidia.com, willemdebruijn.kernel@gmail.com
Subject: Re: [PATCH net-next v2 4/6] selftests: drv-net: gro: improve
 feature config
Message-ID: <20260110094357.28921354@kernel.org>
In-Reply-To: <20260110005121.3561437-5-kuba@kernel.org>
References: <20260110005121.3561437-1-kuba@kernel.org>
	<20260110005121.3561437-5-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  9 Jan 2026 16:51:19 -0800 Jakub Kicinski wrote:
>      try:
>          # Disable TSO for local tests
>          cfg.require_nsim()  # will raise KsftXfailEx if not running on nsim
>  
> -        cmd(f"ethtool -K {cfg.ifname} gro on tso off")
> -        cmd(f"ethtool -K {cfg.remote_ifname} gro on tso off", host=cfg.remote)
> +        _set_ethtool_feat(cfg.remote_ifname, cfg.remote_feat, {"tso": False},
> +                          host=cfg.remote)
>      except KsftXfailEx:
>          pass

Looks like I haven't re-tested on netdevsim, this needs to spell out
tcp-segmentation-offload :S
-- 
pw-bot: cr

