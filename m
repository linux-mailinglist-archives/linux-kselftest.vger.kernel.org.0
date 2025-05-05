Return-Path: <linux-kselftest+bounces-32418-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63479AA9AFD
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 19:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68773189A2D7
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 17:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD9C26B978;
	Mon,  5 May 2025 17:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBNzI5cH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BD9C8F0;
	Mon,  5 May 2025 17:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746467223; cv=none; b=iQgMbKQy8SjOzfmsEM86QIzfg4sdvRROlbdVJMK0jc7AVocmNQOAP2fcvMczD5kaBsGyDM/LhFWrfFW99rYoP4YM61Zpb9H4MspnWlO6vRv+lIWSpqU9LoazDAg9GIcth7D2ZRejBhF/lwe/0jUBBKeNZ5eQyTBHYdhE5CjuSAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746467223; c=relaxed/simple;
	bh=nsjBifR6yWR4MXUDca/cmqBb6NRin1gFwQZewX7TJHY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UaUhcGAYD4bYagYP/51X9eGxYAjZ0kQraqr1Siyyx9MCTqoxFJsJ5FhY4zHsEA8GPAVboBe+hTR4gNw108OOnHyNruVI+pdPu/DnCyXr5qNzLLsQMOWoYHgyOjN7B+W+1kxhZCwWXPEoyLpDRPZKjnyy/7aFwUqLmfZrae2wgvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SBNzI5cH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A0E8C4CEE4;
	Mon,  5 May 2025 17:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746467222;
	bh=nsjBifR6yWR4MXUDca/cmqBb6NRin1gFwQZewX7TJHY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SBNzI5cHjHND1dv/IRjKkZpMBO6SxmKp5vAcpdLcqNzBX1DBGjGMusbpKFeOr/o7h
	 1p8Mx7i7t5Oy6p/38OW9giYO8IiEaIoEc2z1KQSAYV8AYWxP6WcKj5S5td6gWdfFmT
	 7+YMaE2mG4Tk67m0H9qS90cpJSx0pLzAbYM1Pcq2WzOvGiokn/pDZzMXAOaZui6WQf
	 6/V+0lNV0ew/IZIOqyuAGsGEdPP7j+Gz+BAFA4sTWBLIj9V7Tulm2bmzEgfhZ3TzCf
	 M6/5S0SnPuu7Ib6HRFWTBw10GrZDmMynPIXUOQwXur2xltSVaa3uPKCp73Gz9NtRBi
	 7nJdPgo4mye9w==
Date: Mon, 5 May 2025 10:47:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: Mohsin Bashir <mohsin.bashr@gmail.com>, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, shuah@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, ap420073@gmail.com,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net 2/3] selftests: drv: net: avoid skipping tests
Message-ID: <20250505104701.10d3eb14@kernel.org>
In-Reply-To: <0db1b7f0-028c-44e9-bf98-81468dee32f0@davidwei.uk>
References: <20250503013518.1722913-1-mohsin.bashr@gmail.com>
	<20250503013518.1722913-3-mohsin.bashr@gmail.com>
	<0db1b7f0-028c-44e9-bf98-81468dee32f0@davidwei.uk>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 2 May 2025 21:54:11 -0700 David Wei wrote:
> >   def _test_v4(cfg) -> None:
> > -    cfg.require_ipver("4")
> > +    if not cfg.addr_v["4"]:
> > +        return  
> 
> What if cfg.remote_addr_v['4'] doesn't exist?

Not sure if its super pythonic but it's set to None in the lib
if user doesn't provide the config.

