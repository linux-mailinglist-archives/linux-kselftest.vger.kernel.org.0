Return-Path: <linux-kselftest+bounces-42475-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B629BA4001
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 15:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B92847B9B40
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 13:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F247E2ED870;
	Fri, 26 Sep 2025 13:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eeVgYVOE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA69B19FA93;
	Fri, 26 Sep 2025 13:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758894891; cv=none; b=BwA6G7Uw7DzoisryT+xCqN1keVOISZrU9SBeBfOjHsry+qI9tGQ9jd2h2L5htYNcEDvlddVnjGopB1AsF8Ei2NM1TRbsgySfPmSCBD6O4I82PGtBkjbbz46Bjq/sZ9JsXq8fwC4sFTrOjXHktVFF3Vf8w9X575dZdundFzWPkrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758894891; c=relaxed/simple;
	bh=wGWeJLWGBhB9S705e0wVpD3HZ4bMT1X4AWKE8aXWWTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r9khVp6TfbKhtapI2t4REeXI5xUnGzrDO0tqxWYN8mgMoOgoZwQ1Ydw7NijjV08WXV9KcY4B4aHTbUSXkN0i1TfhzCKxeqim8dbjpgx4UBS8ucO2XcTp8Ogt4rETHMNpZtSDYrsB36uUyVCVnWzggAjVJlPMpV5j+3LGIEoN3E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eeVgYVOE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CFD2C4CEF4;
	Fri, 26 Sep 2025 13:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758894891;
	bh=wGWeJLWGBhB9S705e0wVpD3HZ4bMT1X4AWKE8aXWWTg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eeVgYVOECQ76N0WAYw0tw0y/Adi9TRsg/+R+THeL0nYgkaEp77tv3M2r/DxVVT+67
	 8SR0+THdgcYV9c90vZVoUU3BgllQV4dbXpTome2XRfhH5IMfRrkNyLt+FLPvqxeVmd
	 sG+Ol5j46dla9IjTu7m0S3TFvXbsSyp4u9qm01knj/m3RYYZomsWPW8KjQvoxz9J/I
	 TxUVRHwdGixfI9/BcI27f3X1C+RaMDohw1efvW+P5WP+YKOaKpO6f0GwtyN3+dCs6D
	 /JsZaFE6Dtg7tT4+RqSFM2V9aThROvFnhFc+6/sE6pYcBjJG7+m2hDfAfSEk0X2I29
	 MLg0fppc5fwyA==
Date: Fri, 26 Sep 2025 14:54:47 +0100
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	mlxsw@nvidia.com
Subject: Re: [PATCH net-next 05/13] selftests: net: lib: Rename
 ip_link_set_down() to adf_*
Message-ID: <aNabJ927KETkVN-r@horms.kernel.org>
References: <cover.1758821127.git.petrm@nvidia.com>
 <e5bf4cb3405fb50fe6e217a04268952e97410dc2.1758821127.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5bf4cb3405fb50fe6e217a04268952e97410dc2.1758821127.git.petrm@nvidia.com>

On Thu, Sep 25, 2025 at 07:31:48PM +0200, Petr Machata wrote:
> Rename this function to mark it as autodefer.
> For details, see the discussion in the cover letter.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


