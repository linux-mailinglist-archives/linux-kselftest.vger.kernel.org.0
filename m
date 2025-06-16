Return-Path: <linux-kselftest+bounces-35124-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA1DADB82F
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 19:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54AC81676A8
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 17:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD76289E2D;
	Mon, 16 Jun 2025 17:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fUtQz+D5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3251288CB1;
	Mon, 16 Jun 2025 17:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750096381; cv=none; b=fRVyRfrMA6QH96RY1P4LTmkHeZ4mPr42RRvmeiDt8OnrlxOYtQT7Z4fCeUXEMv+rleah8VvFycss8CTPOH1e3/FK/LdYRP3BatvdQu1BHSIxAghdjeyFXiNemCty1noPNOSfGKdQqJtIypcUcLN+2oKpBd5un4+L8t5tylQbZFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750096381; c=relaxed/simple;
	bh=MA6AoeE17e3tBiZfeH94+bR+Eh8c1BHZnFVFWm/rYVY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dIMu9rm4zBdVmycK+W+wmelxexVrd9wCxRpEZ6lsC8wDbh6BU8y5zT2EJ6C/nXBzpxdxQVRnkE+q3MTRnlrIbscSHpzGIywDeO6M1WquNSDM6t6SdFDnsbC//ZNBSr4dj/mYNbIwHqGs4tKRKhdiordd4xlIFDZlVAdi4sSVnPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fUtQz+D5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3777C4CEF0;
	Mon, 16 Jun 2025 17:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750096380;
	bh=MA6AoeE17e3tBiZfeH94+bR+Eh8c1BHZnFVFWm/rYVY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fUtQz+D5eAsN7DWPsso0r0H6QTyOrqmKu47cgt91sM4Pp0YjIeX4WZQsMkcKgwt4X
	 XMUxWKKZgfGl9gMRisNDuFMmdUXOFntbGtc1Vx9OAvg9A8RBmjrv2UcVPVmErto2fm
	 r8vE9M3SyiY41OZShe3HRdbCh+GqY5fe4fd1Agu+aFiwYN7PF0nPn7+5hF0OyqlIYE
	 KTQ3vZVlA10B6tFRvFV4YEuAn8F7FEEkMM9CeQWt2cADQl3SqQ63DTLAHjwhc2USBJ
	 KhJdF0GaDpBAMXkbRAS6KeVuox4uNwQUAq+RyxW9AiFzWoFwDX82LWRyDAZUOl+KyO
	 bQdKc6burG38g==
Date: Mon, 16 Jun 2025 10:52:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Petr Machata <petrm@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, David Ahern <dsahern@gmail.com>,
 netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, Nikolay
 Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>,
 mlxsw@nvidia.com, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v2 14/14] selftests: forwarding: Add a test for
 verifying VXLAN MC underlay
Message-ID: <20250616105259.2f09ce96@kernel.org>
In-Reply-To: <426a2c83-38ca-4fa2-9270-b3e600e30d19@kernel.org>
References: <cover.1749757582.git.petrm@nvidia.com>
	<78edac89730a346e957b69d4107fcd8f1c5c6266.1749757582.git.petrm@nvidia.com>
	<20250613095755.54381628@kernel.org>
	<ccaf0784-d7a3-41e2-b3e0-65b9022f15a6@kernel.org>
	<87wm9bu13q.fsf@nvidia.com>
	<426a2c83-38ca-4fa2-9270-b3e600e30d19@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Jun 2025 18:18:18 +0200 Matthieu Baerts wrote:
> > The ALL_TESTS issue is not the end of it either. We use helpers that
> > call stuff indirectly all over the place. defer, in_ns... It would make
> > sense to me to just disable SC2317 in NIPA runs. Or maybe even put it in
> > net/forwarding/.shellcheckrc. Pretty much all those tests are written in
> > a style that will hit these issues.  
> 
> In this case, I think it would be better to add this .shellcheckrc file
> in net/forwarding. If you modify NIPA, I don't think people will know
> what is allowed or not, or what command line to use, no?

Let's do both? I disabled it to NIPA over the weekend.

