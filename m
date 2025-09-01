Return-Path: <linux-kselftest+bounces-40496-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4328B3ED6D
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 19:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94DAC7B1ACA
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 17:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7871320A05;
	Mon,  1 Sep 2025 17:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EnKRiCfF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3D026B0A9;
	Mon,  1 Sep 2025 17:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756748301; cv=none; b=ZNGJlFsHUe0FFmLn+NuSWs24qvMeywwhQiEFl8eRTRE+c6BO+qAh5wW1Kv2EtNaaH/7oMRfgICVL89j7LLsxy8Udmg+7BY8SMvboU+PxuT2MV5cs4/e2tGYER6Pt1a+Z0NnunSPog+cG2jZIAO0Eg3HDxXy1GRWFlTtdY3klyUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756748301; c=relaxed/simple;
	bh=eTVBJY46PwtfLwBhSw/9tZYVpz3GtRud/r1WejWZAA0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qe/wnVwEClMjpOpOcDVfTON3biFJGK025jm/xWnlOqOHGP7wsF0rzxriw3hlKhqreMk/jVb+UHV2V1prDwKJSMoeiryRRwvy9lKGQa+J4Y9cNKDV959mS9FQKFxKMOCl35wqD5N5Q1duJc2+PsHDsBEToJn0GQhxQQl/kuV12gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EnKRiCfF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3B42C4CEF0;
	Mon,  1 Sep 2025 17:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756748301;
	bh=eTVBJY46PwtfLwBhSw/9tZYVpz3GtRud/r1WejWZAA0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EnKRiCfFTkqWQa7nTAMgMVifkamjpgWWSx22c29lhplALk4gdcz1sR0v9tYHGoW2Z
	 F10cwDoW23c+hkMzGP9u5Xqdh4VG0vJFnvVy5GqPloFwUixOdqN8p725RsS0s1FaiY
	 /C9uwZrURFdEeHrLaH6CzTKtpCYhagv6+JGsUGEMgZp++wn5Vwr4iyWWwY+wIVVKpD
	 jccORxDy+N1FX7EdlMFaD69sDcIRW7XK34Wtd0ZQM/Cp0fci332T7OymIj8RuU/qL7
	 89Jp1JHhMX/DFyUSIY74c/z3HvdE/Kz1amaiPfozIl/uSaRBlx40RmlKcka9BrT9ky
	 KdikRCXT3bECw==
Date: Mon, 1 Sep 2025 10:38:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, joe@dama.to,
 sdf@fomichev.me, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] selftests: net: py: don't default to
 shell=True
Message-ID: <20250901103819.77b8fc19@kernel.org>
In-Reply-To: <va6ympcdo4jxfcqnr6uels4hg62sxgzeabdxjkdr7nkufjktk7@4fishek5fpgo>
References: <20250830184317.696121-1-kuba@kernel.org>
	<20250830184317.696121-2-kuba@kernel.org>
	<va6ympcdo4jxfcqnr6uels4hg62sxgzeabdxjkdr7nkufjktk7@4fishek5fpgo>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 1 Sep 2025 02:34:05 -0700 Breno Leitao wrote:
> On Sat, Aug 30, 2025 at 11:43:17AM -0700, Jakub Kicinski wrote:
> > @@ -45,6 +48,10 @@ import time
> >          if host:
> >              self.proc = host.cmd(comm)
> >          else:
> > +            # If user doesn't explicitly request shell try to avoid it.
> > +            if shell is None and isinstance(comm, str) and ' ' in comm:
> > +                comm = comm.split()  
> 
> I am wondering if you can always split the string, independently if
> shell is True or now. Passing comm as a list is usually recommend, even
> when shell is enabled. Also, if there is no space, split() will return
> the same string.

Not sure how that'll interact with various shells..
I'd rather play it safe.

