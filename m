Return-Path: <linux-kselftest+bounces-15777-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B27A9958B88
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Aug 2024 17:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E41F285B8B
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Aug 2024 15:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980BA194081;
	Tue, 20 Aug 2024 15:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPyGgIEd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F11028FA;
	Tue, 20 Aug 2024 15:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724168654; cv=none; b=jVxX0zg+UgewRyJ0RLXS+DZ1zF3ud+N3HnS6wCGK4H8QLzxIx1Skx8osIyW17fRnRhr/GhxheRIEyrD2gc0QMLa+VVJGuhybEgYr9WGrbpFOpiujSu5x/p2+WyF2qD7dcExf4TnUix6BbqssENtcj4ba5+NxO1F82xeiCc8t2Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724168654; c=relaxed/simple;
	bh=LJHIjjZmTeHPbvbylPUDocAOSUXKU4/fe6hYJ39l/Jc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gm3ckTdYbEv1Kob+bgDL2wd8S+gn0zHcyZDvZzz+tzDsiFEs3jxKfTZw8wFav9VTXv8t9ZQVTKPXKJ5fDRPWPn9QohQe6+A3EMJypi0K4+JD3FPDPQlZ7j5kq3KNTsXm5+uZBKIB1oSDAsQDFqjfaq4uJytLXqHharPGZnmLDFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPyGgIEd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E580C4AF0B;
	Tue, 20 Aug 2024 15:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724168654;
	bh=LJHIjjZmTeHPbvbylPUDocAOSUXKU4/fe6hYJ39l/Jc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mPyGgIEdP3WlUsYf9EgnhV3vJ+69e4hpvnc5K9hLaZLc+J1JOIV456zwKvPIt23On
	 pU2yOwj6GlLL4Gw2Enc+i1I2hqFEmhRNpV7/Om16wDFIA0w83ysiKrsBvUVWHeh4ps
	 rVpwVJ+iPQHFAM0/ACz6jEKS4SdDCy1Ly0dLiIIKCSFPeptCz+JFwsPmwBmNMz8alG
	 HPMJDo7aF24B1EF/HwTq54yIcj+i8JYn0D8o010T2nM62kHdvxlGQW0O9F5bOS1rp2
	 ciMhdgDybY7DotkBpz9Nb6dMx+IuGMkxaAO1xwcoTJDIRJ4AWUTecn3f9OpAZizt5f
	 cixEuk86zn6RQ==
Date: Tue, 20 Aug 2024 08:44:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, shuah@kernel.org, linux-kselftest@vger.kernel.org, Ido
 Schimmel <idosch@idosch.org>
Subject: Re: [PATCH net-next v2] selftests: net: add helper for checking if
 nettest is available
Message-ID: <20240820084412.4aa6abfb@kernel.org>
In-Reply-To: <ZsQLFwkNa-JnymGg@Laptop-X1>
References: <20240820004217.1087392-1-kuba@kernel.org>
	<ZsQLFwkNa-JnymGg@Laptop-X1>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Aug 2024 11:18:47 +0800 Hangbin Liu wrote:
> Excuse me, what's profile used here? I can't find the definition in
> Documentation/dev-tools/kselftest.rst.

Ah, sorry, I added timestamping output as a local patch for NIPA.

Random example:

TAP version 13
1..1
# overriding timeout to 7200
# selftests: net: amt.sh
# 13.15 [+13.15] TEST: amt discovery                                                 [ OK ]
# 16.27 [+3.12] TEST: IPv4 amt multicast forwarding                                 [ OK ]
# 19.14 [+2.86] TEST: IPv6 amt multicast forwarding                                 [ OK ]
# 670.88 [+651.74] TEST: IPv4 amt traffic forwarding torture                           [ OK ]
# 1203.28 [+532.40] TEST: IPv6 amt traffic forwarding torture                           [ OK ]
ok 1 selftests: net: amt.sh

It's not great, makes the lines longer and misaligned.
But it's helpful for debugging slow tests.

