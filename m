Return-Path: <linux-kselftest+bounces-15848-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CDDF959BC7
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 14:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 395751C20AD9
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Aug 2024 12:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360E21531DC;
	Wed, 21 Aug 2024 12:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eYI7UPfc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC531D1303;
	Wed, 21 Aug 2024 12:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724243308; cv=none; b=nbwZlLJhpk55X33Wq7QCb1n+xp33GnQGP2kCD3815fgvl4XY/vJwAw1IIxMkchhZkIZXmJoYE6x49+Fy61xV2Od/bCHwK+lcvDtMOcij5saRtVu/B3lDjj6zSq4Q8ZZ1N6zxTzTWVulniKmt2YgLS7v893M5vtWZXcuOwGwXLsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724243308; c=relaxed/simple;
	bh=V3kzTZmwbXb3DObhpY6QyGYiGN8addQ00DEUYOUkl+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bPjb6JUMF4CwjF/esdpsnpgluf/K9ECjR0/ACDcOaZyfJthILSXrLRPsNzLJvq5PS2Q2aXKyN7XXFj/rdNG8pq3S1SAj+RHMgjQxsERuh8pfREAmf6mtiZuyERyhn6E0Qh7tTTLiiS0Yp+o8xEyLqI7iJoap8bVGO9rGBOovP1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eYI7UPfc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12B90C32782;
	Wed, 21 Aug 2024 12:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724243307;
	bh=V3kzTZmwbXb3DObhpY6QyGYiGN8addQ00DEUYOUkl+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eYI7UPfcNE2OKeP4oypJFe9Fad32d2vw/Ey8LtodpOy/MxY4mRF6uVkfkI/dcprCW
	 VnPaxLaRFvit24SKhaEAhNPJcrfReoW108+mtlSWDyis2/N9W/F7umBrYgk9GGR6pz
	 bEkmd6MVZWoeSUaKjTdC1jehkzErPgsCCtEyGu4d44467ucONKU/186I3LNoWcDVSV
	 x7CxdlCD2J6NaUpqJgOAiVb7+qu9INWn8yetVXXxy9K9bXUapX/dIVSpeha3g3klSw
	 BISqU+x1rAMSBsPcjfYqxK8DBplyoPFmKO137DB28za0CwsMMB9qPw8pLRydNYLpLs
	 YKJBydhuN7rXQ==
Date: Wed, 21 Aug 2024 13:28:23 +0100
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	mlxsw@nvidia.com, Ido Schimmel <idosch@nvidia.com>
Subject: Re: [PATCH net] selftests: mlxsw: ethtool_lanes: Source ethtool lib
 from correct path
Message-ID: <20240821122823.GA6387@kernel.org>
References: <2112faff02e536e1ac14beb4c2be09c9574b90ae.1724150067.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2112faff02e536e1ac14beb4c2be09c9574b90ae.1724150067.git.petrm@nvidia.com>

On Tue, Aug 20, 2024 at 12:53:47PM +0200, Petr Machata wrote:
> From: Ido Schimmel <idosch@nvidia.com>
> 
> Source the ethtool library from the correct path and avoid the following
> error:
> 
> ./ethtool_lanes.sh: line 14: ./../../../net/forwarding/ethtool_lib.sh: No such file or directory
> 
> Fixes: 40d269c000bd ("selftests: forwarding: Move several selftests")
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>

