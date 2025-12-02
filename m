Return-Path: <linux-kselftest+bounces-46873-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A85C9B392
	for <lists+linux-kselftest@lfdr.de>; Tue, 02 Dec 2025 11:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 00DDF4E3EC4
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Dec 2025 10:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B4230F95E;
	Tue,  2 Dec 2025 10:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="cBnsgUrU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62C530F80F;
	Tue,  2 Dec 2025 10:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764672693; cv=none; b=nU8zntYF0Gy5x+K7Rt86BpLg4jwH5cyuPhsb3ZTQsTefExIaTF0CUHpaJyuMC5s85E/hNcuQQDu9A2WJpfLfSkSqNJ5/EMQh/fTSQIUNBfTbp4ZOL435ik0Ug3pdbiVfpv6MdSDpgrz/orCqGCEWGm/53mjx80pKww3IINeEOdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764672693; c=relaxed/simple;
	bh=vdmypxi2Q7eMlCKO+QQHzbP+TioHRSk8qcbeexE8kX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vE4ssj5oBaBwPlQsuD7BnXv8s2cArJvCCfVjc81HPaIghXP2srSwR76lm/YMrZ9JIsEGLrqH62kkA4dXv05vSwg7QvIPgtv98f90KbegRupNBcawEn7bGP0KGqdQ++oEggLsyD1CfOVN1cJwFjedFdpY2TJM58xdJet4CXOAp+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=cBnsgUrU; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Mf+PMwj5K9z+HLqC9OLEzJzEbfd/nHVlgeSaDHAcscE=; b=cBnsgUrUifdzNTfOZkSbqmG4DJ
	x8ZFgNa7h1hVkGIaRa7zJJfEegC87H50LmmsVh0z7pL/EnHVD4ItQaveuFuLEcEMRzhDk+l9PMmAB
	5uZjMKrbwPVQs2vItvBo0/xBuK4lJkfF7NniF5VqBmMAIz86ix6xWEOa1DEb9NRg2suD3kK/Lz91Z
	gbDNomdV8Lh1/FYimgEy9JsogKYu8o1J52v9qa3r80O7G2XGHyN4R6DWoXBoLAIjAt3OAfbg0YZTf
	ivrxOqPoomxIdiJfJfbUE9CE+vrLyh8C3sEWuerPZXTKaEbGnoOntvPtsq9U/vyn6nOV/FXI0Jovw
	MLixQmvw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vQNye-001OBY-Li; Tue, 02 Dec 2025 10:51:24 +0000
Date: Tue, 2 Dec 2025 02:51:19 -0800
From: Breno Leitao <leitao@debian.org>
To: Andre Carvalho <asantostc@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v8 4/5] netconsole: resume previously
 deactivated target
Message-ID: <szx2wszdd3k3ze5hufynb7tgl54732lsv4ymphnb6om6m37yqh@s774ngir5kie>
References: <20251128-netcons-retrigger-v8-0-0bccbf4c6385@gmail.com>
 <20251128-netcons-retrigger-v8-4-0bccbf4c6385@gmail.com>
 <65vs7a63onl37a7q7vjxo7wgmgkdcixkittcrirdje2e6qmkkj@syujqrygyvcd>
 <2sqyjsod2s6kdukgipgcpjqdoysaw6trpgymxci36lmi3gykvx@tvg4qh3veuiq>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2sqyjsod2s6kdukgipgcpjqdoysaw6trpgymxci36lmi3gykvx@tvg4qh3veuiq>
X-Debian-User: leitao

On Mon, Dec 01, 2025 at 10:06:24PM +0000, Andre Carvalho wrote:
> On Mon, Dec 01, 2025 at 03:35:04AM -0800, Breno Leitao wrote:
> > might hit a similar problem to the one fixed by e5235eb6cfe0  ("net:
> > netpoll: initialize work queue before error checks")
> > 
> > The code path would be:
> >   * alloc_param_target()
> > 	  * alloc_and_init()
> > 		  * kzalloc() fails and return NULL.
> > 		  * resume_wq() is still not initialized
> >   fail:
> > 	* free_param_target()
> > 		* cancel_work_sync(&nt->resume_wq); and resume_wq is not
> > 		  initialized
> 
> Checking this a bit now and I'm not sure if we have the same problem. On 
> alloc_param_target() the cleanup is simply kfree(nt).
> 
> free_param_target() is only called as part of netconsole module setup/cleanup but
> only for targets that were succesfully added to the target list (so are guaranteed
> to have resume_wq initialised) before we hit the error.
> 
> Let me know if I'm missing something!

You are not, fail: code only iterates over the targets in the list. If
kzalloc() fails above, it will not be included in the list, thus,
free_param_target() will not be called.

