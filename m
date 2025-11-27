Return-Path: <linux-kselftest+bounces-46666-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E596C9015A
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 21:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9747B353428
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 20:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C77730DD2A;
	Thu, 27 Nov 2025 20:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c89VzHD8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D945530DD06;
	Thu, 27 Nov 2025 20:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764273997; cv=none; b=JcnnIvXi5i6m+6tOlxucqh1YqyZG8pKQx6fAJ0Tc5Y7Ns+aUUhRN3Yd9MP+18eckxYItogiJeKa0M7op42nzHtFCIJbFyjKN68dM0WgMeWNprPU2hWOA1EbWM7GHSWYJkVtJnGmnuqRFFsXZS3xwYsmHO4DDYNvlnTjPGyKTEP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764273997; c=relaxed/simple;
	bh=jnL5tP7VUoG8mpJi+s2F6SszKuVjvvL+PAqOALc0RuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VyQY8kkJ+XWYft/gpBet+oJyKEJqI82bNFNSUhgEAhecn+BLMooZJW6UsyPd52ML32IPHllMzIYPyXtfi7s9GEryoWyH3jfkTeYKwP0M2zqlOmb/4Gopt5/eAHkBi6OmyAaPWf37lYIEgiWvUj8jXLd7DTb6WaHSxR8BFF9hdHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c89VzHD8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B790FC4CEF8;
	Thu, 27 Nov 2025 20:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764273996;
	bh=jnL5tP7VUoG8mpJi+s2F6SszKuVjvvL+PAqOALc0RuI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c89VzHD8qAagoVgodoLZz8iGYgI+22YwtwdE3mxI85w28yDbvvbyZrGbwmGTOSJNJ
	 VbNNwfB3ZaJLIpoMELX8ZjfV4OnSp/Q6ixtVlf4owtgAf6vqE/JsGL5WUB4CdEK4Xy
	 lDwofnXnChGJu/w5y/Wa5WtC9NzrLmt6UA4T5gtmzHqv2j/60Eqhx5as84J1x6YRvP
	 euVulmTpuhaT8v4uM1WNqqOlXhzdT7O5QwNC/kwqd5XN/4ao/3iAGzStQE1JAeDbwc
	 q24TJygQ6VxwRu6of6b7Y4sFD/VrDggTyoSNC1Ar7ZENT7TWOHRIkN+K363Rug3v/h
	 aDq+aLo3XcFjg==
Date: Thu, 27 Nov 2025 20:06:31 +0000
From: Simon Horman <horms@kernel.org>
To: Carolina Jubran <cjubran@nvidia.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Gal Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>, Nimrod Oren <noren@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next V2 0/6] selftests: drv-net: Fix issues in
 devlink_rate_tc_bw.py
Message-ID: <20251127200631.GA737230@horms.kernel.org>
References: <20251123171015.3188514-1-cjubran@nvidia.com>
 <20251124191026.1438551c@kernel.org>
 <d81820e1-21e0-4c59-8532-ba55ac47c6fd@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d81820e1-21e0-4c59-8532-ba55ac47c6fd@nvidia.com>

On Wed, Nov 26, 2025 at 10:06:18AM +0200, Carolina Jubran wrote:
> 
> On 25/11/2025 5:10, Jakub Kicinski wrote:
> > On Sun, 23 Nov 2025 19:10:09 +0200 Carolina Jubran wrote:
> > > This series fixes issues in the devlink_rate_tc_bw.py selftest and
> > > introduces a new Iperf3Runner that helps with measurement handling.
> > Sorry to report but patch 2 doesn't apply cleanly.
> 
> 
> I am based on top of net-next, and I do not see any issues applying the
> series. I rebased on top of commit ab084f0b8d6d2ee4b1c6a28f39a2a7430bdfa7f0
> and patch 2 still applies cleanly for me.
> 
> I’ll prepare a v3 to fix the new pylint warnings in load.py while I’m at
> it.
> 
> If you are applying it on a different base, please let me know which
> one.

Hi Carolina,

FWIIW, I do see that b4 shazam (which I assume runs git am) is unable to
apply this series cleanly to ab084f0b8d6d2ee4b1c6a28f39a2a7430bdfa7f0 due
to some fuzz when applying the first patch: Hunk #1 of
tools/testing/selftests/drivers/net/hw/lib/py/__init__.py

And I expect that a rebase figures this out, which is why you
aren't seeing it.

