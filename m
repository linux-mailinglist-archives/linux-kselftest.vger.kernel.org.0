Return-Path: <linux-kselftest+bounces-42482-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02CE0BA4022
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 15:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BA393A3266
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 13:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12C42FAC12;
	Fri, 26 Sep 2025 13:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTdsmncl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B462EA720;
	Fri, 26 Sep 2025 13:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758894992; cv=none; b=HI8gaDyxtRTeEX4jLWiw/7Rg3V/HZI9doyPoSHYSh6n/ZDbJMPQw5gRI9hgWcXCP+6fLfh32G0fkBETLiKWlCW+5vFWWpzjOlOMyXd/DnjnXMRG6Vzf86mgsNG5B1lsF4YLp/6qypJdEDR3nxPTA8H3RwnSdL8/f6i3HBClXPbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758894992; c=relaxed/simple;
	bh=wE4qm/XFAF6PofdQiAMe4TLAsgZTwK5tew5yBqY82mQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N9JxhAL+JyiU6WDj9X/8r6o1ZxmYtHB5VArHe0YLRTYz1awpXDCUZDkbGoAclqFO0XkgbBESivt0vYeMwqygzerKIBR6WwX4TJ5cpI4uu6FwxFkMA0MhpkGqQzzuRGKHb5GmGtI/rFqMM4to5/IQPYMY/UyUz2L/ARDfHHejw9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WTdsmncl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42797C4CEF4;
	Fri, 26 Sep 2025 13:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758894992;
	bh=wE4qm/XFAF6PofdQiAMe4TLAsgZTwK5tew5yBqY82mQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WTdsmnclmxsx8BMx2qs0MlXbF2wXq4woNoMfxNjYlricpH7cySPpEz1zPE06CgSvO
	 2HK5nvVFrX8qoY5kqHI0wX35USx/ywR/V3CzEkBuZ7zDNC40paDRj0b+F/Zv1Wk47U
	 6UOc+RYx/2VqpJ5Bzm/3Q336CiGjPz5w9KUr1snTfapYTnY+hJws42abHx0srTpLwk
	 asGMPlDJJ+b5Xo+CTLuWgOYVykDmTQTeGOT4f4QsSFMO7z9bCRCoKuCi9oZnxXY7mi
	 hyvEft3FfwsE4OAjnjHDrdFpb/ThdIDwW0VRc767+3A0ZHegBNttcZj+A0dGAnkK7W
	 e99FSENCkO55A==
Date: Fri, 26 Sep 2025 14:56:27 +0100
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	mlxsw@nvidia.com, Alessandro Zanni <alessandro.zanni87@gmail.com>,
	Hangbin Liu <liuhangbin@gmail.com>, David Yang <mmyangfl@gmail.com>,
	Li Shuang <shuali@redhat.com>
Subject: Re: [PATCH net-next 12/13] selftests: forwarding: lib: Add an
 autodefer variant of forwarding_enable()
Message-ID: <aNabi_eajVDkSUDW@horms.kernel.org>
References: <cover.1758821127.git.petrm@nvidia.com>
 <78b752c40069cde21c44dcf4c7b966a76a0eef2c.1758821127.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78b752c40069cde21c44dcf4c7b966a76a0eef2c.1758821127.git.petrm@nvidia.com>

On Thu, Sep 25, 2025 at 07:31:55PM +0200, Petr Machata wrote:
> Most forwarding tests invoke forwarding_enable() to enable the router and
> forwarding_restore() to restore the original configuration. Add a helper,
> adf_forwarding_enable(), which is like forwarding_enable(), but takes care
> of scheduling the cleanup automatically.
> 
> Convert the tests that currently use defer to schedule the cleanup.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


