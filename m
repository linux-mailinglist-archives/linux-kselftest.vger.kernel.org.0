Return-Path: <linux-kselftest+bounces-3096-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10EAB82F55C
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 20:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 378311C23969
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 19:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325DA1D525;
	Tue, 16 Jan 2024 19:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aqgA/t6B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0704C1D522;
	Tue, 16 Jan 2024 19:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705433368; cv=none; b=pyh3VQtLiBYPoG3eZ1Vmoy7jS/mlYVu6C/Z6An++tOEbkUt8a7+/L2CTAPBi0KkVWZoJ5sVgmAb73I+LvZbnoyfKvsAT8ZeVKNhfX92WIkp4iIU66LV+hqCmSOavqr+KKJMKt3K0CXjwtlas0sN9OH/3h6gFRfHXM6TWG8dgMfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705433368; c=relaxed/simple;
	bh=iVy6Hab3XrRSqgzzXtSQGCRl4q3R1LvYO/aANjwkr5o=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding; b=SbjqL3lXhKrlDWmWkGaeJ2iwqHGeVASZfHsPIt0nSxcIv/2GfjVx/mCa+AAnsjUV3k6sRaRTBQkR8g0/id4TA1z3mbS+D0f5Gb/UG5LnWhU8M1bX+keUm256Ap/PWFUJ51bdz//RaL3t5QJ1rRnm3zUPx3ScByPcY25iqTKsaww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aqgA/t6B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57DFEC433C7;
	Tue, 16 Jan 2024 19:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705433367;
	bh=iVy6Hab3XrRSqgzzXtSQGCRl4q3R1LvYO/aANjwkr5o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aqgA/t6BDrC8zZIp3keWLo/qMlxWZr7PPpKdtBlEqziYH7yMF3Y1vr+pgeODBlyjm
	 p5nuOXl+0sWYKK86vCDSuVinyY37f8vC++NLh9T816ZsTBXXVSLkWsXQroHi7crU4k
	 DdsnFvHvJmyWxtTNamug1ZYqlKkvu1Ul/Mflq/cSthe1AQzBYDhkK99OTpCfbPjFii
	 4VJ+NEs1q+iU0BgpOh+LKqUBYe209AEVFtSLU3R1das7ghA6LJa3D/XymnmrmwMh5a
	 OSvBGXdPoZks6wQYT2rfhebBWud9qlPKqmFv/q/4NriCLABSIpIMyjtVQs4qkiASIv
	 xgK+2UhXXS/Fw==
Date: Tue, 16 Jan 2024 11:29:26 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Benjamin Poirier <bpoirier@nvidia.com>
Cc: Jay Vosburgh <jay.vosburgh@canonical.com>, Hangbin Liu
 <liuhangbin@gmail.com>, netdev@vger.kernel.org, Andy Gospodarek
 <andy@greyhouse.net>, Shuah Khan <shuah@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Jonathan Toppins <jon.toppins+linux@gmail.com>,
 Nikolay Aleksandrov <razor@blackwall.org>, Michal Kubiak
 <michal.kubiak@intel.com>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net] selftests: bonding: Add more missing config options
Message-ID: <20240116112926.541e0651@kernel.org>
In-Reply-To: <ZabXT2ZepMuinE50@d3>
References: <20240116154926.202164-1-bpoirier@nvidia.com>
	<20240116104402.1203850a@kernel.org>
	<78106.1705431810@vermin>
	<20240116112012.026e44d9@kernel.org>
	<ZabXT2ZepMuinE50@d3>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Jan 2024 14:21:51 -0500 Benjamin Poirier wrote:
> real    13m35.065s
> user    0m1.657s
> sys     0m27.918s
> 
> The test is not cpu bound; as Jay pointed out, it spends most of its
> time sleeping.

Ugh, so it does multiple iterations of 118 sec?

Could you send a patch to bump the timeout to 900 or 1200 in this case?

