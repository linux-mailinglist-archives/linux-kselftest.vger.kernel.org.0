Return-Path: <linux-kselftest+bounces-44165-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B47C1226E
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 01:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9A1819A7EB9
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Oct 2025 00:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD2A146A66;
	Tue, 28 Oct 2025 00:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mMkLmU5K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80057481CD;
	Tue, 28 Oct 2025 00:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761610541; cv=none; b=YmDgNTRan7c4ClQQlGfM3l97x3eeDe8O6dy0J/u7c2d7zWGm9D9LRvkTPUEUn4gxqWU+Z9fyHWLrPDbUk4XyBPXiWMENVV/lMCzK47QTgD9/VSKo265XOvH4/r+uS1hesDZjk9HhxyRgbJ8uUIVyKTOWn8iGvRiOqu54hjJJOr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761610541; c=relaxed/simple;
	bh=RZuksO8prqcJbjUS4jt+Fnct3Wsi2aptjwqPycmCu40=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k0ErFMWpqBScBw6Cu6SNfoxGFnH7VrwyuXZ2mVnFWeFPEj4zdQeS4dQenUUo8eHiaqNYniY8JKlek9nBQwfa7Yv2Wob+48jm2MpzH7tUONOZsOJ5IXm5KpT9qCSk36Ju1hKBCktKQUlMq3BPMLZIaBewMXPnk2pQR59OBGCyVMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mMkLmU5K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AF4FC4CEF1;
	Tue, 28 Oct 2025 00:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761610541;
	bh=RZuksO8prqcJbjUS4jt+Fnct3Wsi2aptjwqPycmCu40=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mMkLmU5KTmW2Jy9L12iZ/EaVzu+QjOKp6jjSviE3QUFIBboaziERnwbP6b2Jdirk0
	 SDh8nr6bOizAQ2lmqi/voDsTivmScP/kfKkgWMcmCw+FHDpptUeUVdgoh4nadfTSnC
	 g+3Wb4cwFUv1bXfkDX/HCSVol80iYQtx3vFjr9MVwP3Q61bJ7BL6uC4c4kDMFMaiGO
	 GRhYdb6JO1OsACnrLjlB3ze/A4elgPNSDGORTIA0VlVwxDdyxBj/EHEUSYDrXG/RJ8
	 XO6zgm1gNi/qGZTIRqOz28iuA5NshXOZfZmOy2wqNvGgyAkgqX841ypOkCr0oiyuaM
	 GlReh72A3m9VA==
Date: Mon, 27 Oct 2025 17:15:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v2] selftests: drv-net: replace the nsim ring
 test with a drv-net one
Message-ID: <20251027171539.565e63f2@kernel.org>
In-Reply-To: <57359fb9-195c-4a4a-b102-f7739453a94f@lunn.ch>
References: <20251027192131.2053792-1-kuba@kernel.org>
	<57359fb9-195c-4a4a-b102-f7739453a94f@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Oct 2025 20:46:00 +0100 Andrew Lunn wrote:
> > +    def test_config(config):
> > +        try:
> > +            cfg.eth.channels_set(ehdr | config)
> > +            get = cfg.eth.channels_get(ehdr)
> > +            for k, v in config.items():
> > +                ksft_eq(get.get(k, 0), v)
> > +        except NlError as e:
> > +            failed.append(mix)
> > +            ksft_pr("Can't set", config, e)
> > +        else:
> > +            ksft_pr("Okay", config)  
> 
> We expect failure to leave the configuration unchanged. So i would
> actually do:
> 
> try:
> 	before = get()
> 	set()
> except:
> 	after = get()
> 	fail(after != before)

Please allow me to introduce you to the magic of defer() ;)
This registers a command to run after the test completely exits:

+    defer(cfg.eth.channels_set, ehdr | restore)

> Also, does nlError contain the error code?
> 
>         fail(e.errcode not in (EINVAL, EOPNOTSUPP))
> 
> It would be good to detect and fail ENOTSUPP, which does appear every
> so often, when it should not.

Dunno, checkpatch warns about ENOTSUPP. I don't that think checking 
for funny error codes in every test scales :(

> > +    # Try to reach min on all settings
> > +    for param in params:
> > +        val = rings[param]
> > +        while True:
> > +            try:
> > +                cfg.eth.rings_set({'header':{'dev-index': cfg.ifindex},
> > +                                   param: val // 2})
> > +                val //= 2
> > +                if val <= 1:
> > +                    break
> > +            except NlError:
> > +                break  
> 
> Is 0 ever valid? I would actually test 0 and make sure it fails with
> EINVAL, or EOPNOTSUPP. Getting range checks wrong is a typical bug, so
> it is good to test them. The happy days cases are boring because
> developers tend to test those, so they are hardly worth testings. Its
> the edge cases which should be tested.

I believe that 0 is a valid settings. I don't have much experience with
devices which support it. But presumably using 0 to disable mini/jumbo
rings would make sense for example? And max validation is done by the
core so nothing interesting to explore there at the driver level :(

