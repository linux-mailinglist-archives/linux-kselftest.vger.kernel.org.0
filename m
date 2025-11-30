Return-Path: <linux-kselftest+bounces-46738-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E408C94A11
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Nov 2025 02:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 070153A5633
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Nov 2025 01:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F67B217704;
	Sun, 30 Nov 2025 01:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cb7F40O2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E07019DF4D;
	Sun, 30 Nov 2025 01:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764465242; cv=none; b=p6xXsddxSiiPZyCC2ntFO/ro0Vnlao9WGMtyrqwbjBoW5xJ7k9Y2ebTMT4eG604tgZDedCaSh94LQvK2id5eWbVn+o9Nv+CO/40G6apcKDI4hIXd4c/ozZR7znyep2KwUIeEG41j1mgTACSWA5fDY+dCkxQvz3E5Ol30SUAmUjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764465242; c=relaxed/simple;
	bh=Tczjtjj7xgVd+NwhdsV/3NyQPFxLzXNhe24wSCwA+Oc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IQNDiZVZmyVX+xXHkYDAwhZMGslL0levj96Oh2sy957SWQpJk54knpMGvWD7/OiAeB80hZxfXmsso68gp6eF4ce46bctcOW3PLvnZrCMdtvKnCg1lU8kQZLbmoOVyU6WBKPdpFd4ile46DotI861p91MocvrMMy3l/K8CKtlN0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cb7F40O2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 968F6C4CEF7;
	Sun, 30 Nov 2025 01:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764465241;
	bh=Tczjtjj7xgVd+NwhdsV/3NyQPFxLzXNhe24wSCwA+Oc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cb7F40O2wdIq8p34/rcCY4FGLWmwRGWxZVVv9cwMIS4AnJVPSMSc7Y72nGZ5GNPV5
	 Pkff9cbyAwVhk2QTd+kmqAq9gKREx/PpYWD9tYe9K+XZ0GbBqECXsWIAKFuKe7erPJ
	 gWfKyLkbwELAU76mwHLMXqy0Dyx3zqpGvKSdaHhY4YdyPIbjmavmF0ZZRxnYuoczir
	 clMdmvlwpjELpD5mHCfugd8/8Puy6dz0elgJ9XUV+MLXDxVyg2WQpIRIwq6y2FAr2l
	 LbqEH4SmME154V1iFt1Us/fdLD4CCb6tM4GLN0W+0rBwo/uiZgOQGZjW0Chs99UFXS
	 x2S/0Pqtofl0w==
Date: Sat, 29 Nov 2025 17:13:59 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] selftests: drv-net: gro: improve feature
 config
Message-ID: <20251129171359.7fd4ddb4@kernel.org>
In-Reply-To: <willemdebruijn.kernel.2a528ef888696@gmail.com>
References: <20251128005242.2604732-1-kuba@kernel.org>
	<willemdebruijn.kernel.2a528ef888696@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Nov 2025 15:44:06 -0500 Willem de Bruijn wrote:
> >  import os
> >  from lib.py import ksft_run, ksft_exit, ksft_pr
> >  from lib.py import NetDrvEpEnv, KsftXfailEx
> > -from lib.py import cmd, defer, bkg, ip
> > +from lib.py import cmd, defer, bkg, ethtool, ip  
> 
> Is there a pattern behind this order. Since inserted rather than
> appended. Intended to be alphabetical?

"alphabetical if I remember"? :(

> >  from lib.py import ksft_variants
> >  
> >  
> > @@ -70,6 +70,27 @@ from lib.py import ksft_variants
> >          defer(ip, f"link set dev {dev['ifname']} mtu {dev['mtu']}", host=host)
> >  
> >  
> > +def _set_ethtool_feat(dev, current, feats, host=None):
> > +    s2n = {True: "on", False: "off"}
> > +
> > +    new = ["-K", dev]
> > +    old = ["-K", dev]
> > +    no_change = True
> > +    for name, state in feats.items():
> > +        new += [name, s2n[state]]
> > +        old += [name, s2n[not state]]  
> 
> Should the change set not only include items for which
> current != state?
> 
> Now old assumes not state, but that is not necessarily true?

Good catch

