Return-Path: <linux-kselftest+bounces-40486-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1082B3EB41
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 17:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E940D7A4E9B
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 15:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE592D5931;
	Mon,  1 Sep 2025 15:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HCt9kBPw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315381FDE31;
	Mon,  1 Sep 2025 15:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756741562; cv=none; b=Aigj9QK47WrdUI049LU8U60EThL994iAv7ihXQ6G92BO6z3/AEpfFpyebe36O83m53eTtYrqQQ6LxubRVgZ/nLTRV/679I9wcLr3DtbARrElJCi91P7Li/Gfv8Bf56SCM7nO9GWFUaGHFqg8Mhzsepvw5nkQ94y1gT6fZG1brO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756741562; c=relaxed/simple;
	bh=W6HU5T75/kQQFXTNeqyzyWkcsnx+bhCs/i6yFjNZjOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TPqOqzI4ZChnAjpvo4oBK+G4e2JcdD+HdzWljEfsQ8f9y4VTLPesxBx5+VoR78LUoc9NrfJ6UANX6T3XdusjE7RGMIU8t23DSjMiew3S33ZF+lCq0kz37OTGY1zEnUEtHZzutk1e35G5NCFdUWo0hBBEvKW+WyDP7nFczfyzb4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HCt9kBPw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD89C4CEF1;
	Mon,  1 Sep 2025 15:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756741561;
	bh=W6HU5T75/kQQFXTNeqyzyWkcsnx+bhCs/i6yFjNZjOM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HCt9kBPw/mExVJf+gqU12GTBw0zVHcE40RpYndBiwkx6G9+98LVerEG8N/Ym77qo3
	 N1CuCW4hHcjRPd5QYtz8eJW4Wekt1K7zYzoa7bmcIrqm9PWez+WOUFQej5M0elk6JJ
	 /h6ux3X7HSTlE4CDjrxZvo+K2YrsfMRi5lcQWzoIO47TbrFcESXyr1PW+Z+q41wpiA
	 oIBRvXDb7ZE4AOnsPh3tIXTx8EF7+0wnBJXjnoqcpUM98oRgZZHD4RcmaheV3DMwzv
	 hK8uqq7UsWka1zyacF4d/yjRWmDt9vj7hVR73QJGWJLJEPNqP8z7kcowRbeylXk3ts
	 JzBKkGb40w7BA==
Date: Mon, 1 Sep 2025 16:45:57 +0100
From: Simon Horman <horms@kernel.org>
To: Carolina Jubran <cjubran@nvidia.com>
Cc: Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Gal Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>, Nimrod Oren <noren@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 2/3] selftests: drv-net: Fix tolerance calculation in
 devlink_rate_tc_bw.py
Message-ID: <20250901154557.GI15473@horms.kernel.org>
References: <20250831080641.1828455-1-cjubran@nvidia.com>
 <20250831080641.1828455-3-cjubran@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250831080641.1828455-3-cjubran@nvidia.com>

On Sun, Aug 31, 2025 at 11:06:40AM +0300, Carolina Jubran wrote:
> Currently, tolerance is computed against the TC’s expected percentage,
> making TC3 (20%) validation overly strict and TC4 (80%) overly loose.
> 
> Update BandwidthValidator to take a dict of shares and compute bounds
> relative to the overall total, so that all shares are validated
> consistently.
> 
> Fixes: 23ca32e4ead4 ("selftests: drv-net: Add test for devlink-rate traffic class bandwidth distribution")
> Tested-by: Carolina Jubran <cjubran@nvidia.com>
> Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
> Reviewed-by: Nimrod Oren <noren@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


