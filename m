Return-Path: <linux-kselftest+bounces-29503-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8C2A6A923
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 15:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B06E18971AC
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 14:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7BC1DED46;
	Thu, 20 Mar 2025 14:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jszpzKGD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A496A29A5;
	Thu, 20 Mar 2025 14:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742481884; cv=none; b=UOlTm5haFxtIFtYpUTZhcYtNbr5fvqo9BlQxm0N+bA1w1CA038sB6ibPinVwWZRL/2mzHsPi6eVCMNFwLbhrpjMMWO3TJx8wDCspEXI1T2EcixGfytE+cLM2bIMgB3CW0d5gogF5yJ4XIVSzUxpE/pQRy243XX7fjY3+P06ZwxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742481884; c=relaxed/simple;
	bh=KrW2IyIVlYschxF4PsvADIlgYxPLPiRXGUOL7zmZ290=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Huy38DbyLTxCEgCJbdfr12DJ2QhOua7HSqqnfWsaTt3ydenEdlHo0EWjw6lKbXZ0WrXMSCeEtNJEoWJy4JDECUHjfCHw3IkVHCkRYAtgbplmZrTmSk8spGk8TW4CtNMwMhpQQUwcEfVRuRNlFgyWR/JdwWWHqxwclqH66ohFYdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jszpzKGD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14196C4CEDD;
	Thu, 20 Mar 2025 14:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742481884;
	bh=KrW2IyIVlYschxF4PsvADIlgYxPLPiRXGUOL7zmZ290=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jszpzKGDIBiICKS5dk5f0AYZ/wyDeTFaea7I8+QvvzegK6S+FQ2Kkchs1/iFKzjnE
	 va5zFaIeBE5qBJnJHIEE/qJwICGKxVCO5bDnjCxIy79NMrFzJ5J1NQ07Xcw0VHhZBI
	 sdQ6N23KyL8ufPjCrXLXslHpgN0U3Pz2Q27fLvUlb3imDdWpqFEv+tEYxV3/v8+cwT
	 OReUHE2248AhBo8yS/2zJrTOgFZu2NAOp9aMF6QghkQaKyX1qBIDiZMq/XAYik3wFy
	 sdbbIghyEqGS9xnuBxtKpdqB/X4+jypJ+o7px8OksL5lJK2YTzsMQfkjjjZQkupxq1
	 Ua3G7729ixoYw==
Date: Thu, 20 Mar 2025 14:44:40 +0000
From: Simon Horman <horms@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	Nimrod Oren <noren@nvidia.com>
Subject: Re: [PATCH net-next] selftests: drv-net: rss_input_xfrm: Check test
 prerequisites before running
Message-ID: <20250320144440.GA889584@horms.kernel.org>
References: <20250317123149.364565-1-gal@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317123149.364565-1-gal@nvidia.com>

On Mon, Mar 17, 2025 at 02:31:49PM +0200, Gal Pressman wrote:
> Ensure the following prerequisites before executing the test:
> 1. 'socat' is installed on the remote host.
> 2. Python version supports socket.SO_INCOMING_CPU (available since v3.11).
> 
> Skip the test if either prerequisite is not met.
> 
> Reviewed-by: Nimrod Oren <noren@nvidia.com>
> Signed-off-by: Gal Pressman <gal@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


