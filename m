Return-Path: <linux-kselftest+bounces-19037-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6FF99065E
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 16:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BAE2282D16
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 14:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384E3219492;
	Fri,  4 Oct 2024 14:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVNYMI4r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094E9219486;
	Fri,  4 Oct 2024 14:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728052815; cv=none; b=QYoH0hUWemUZpA0+R9mPxrTONg9S/quroZQHUKhStvnumSQ+j5JtcrVbI3CbqikfWPB+fxFKzzLNiGIbG2kEEqRIeeuTKTgAs0VmW0AVtIVGG0gx6U3HImJ3sWKMARwscfD/SD0FPxnPbM3EVuJIWixxUaA0Rslq8dQF2b9fydM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728052815; c=relaxed/simple;
	bh=OOqrp/aX74R3fbutRk9h9Snzzbk6EufuV+Xu9xvdAxE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qpynIyIzJKwEmnmJSfOIkw7euw4yJRmlZVlPQpLszE8xCtw4kvf1mBDHvSftz7u1B1UEcDOr1qbEPLIQssF3tHKtBCCHmjF30OdtVEW3g1fl9BF4CCtaAILHVd2UrjtYav9ygD09KAGFgDXZWLK8BHoNkDjRztZbs/kF4FuK5j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WVNYMI4r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CABCC4CECF;
	Fri,  4 Oct 2024 14:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728052813;
	bh=OOqrp/aX74R3fbutRk9h9Snzzbk6EufuV+Xu9xvdAxE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WVNYMI4rT+Xl8aWQpo6GKoHlFwk61kcHMDPXWU2aGBXfBsOLew36cAfOszZi7Y6G+
	 X6iLIAM/GXTGMRqrDSTLPnmtB8qQhaIizUb2+pEj5vzK+KCqzIFaAyjfVQaA95cGvX
	 9uosCMhXM4xYiTP9LSM1Ea5aiyhruJYLOwV/dxwVW3EvC9QWWftIvk65KIZsbg0lIi
	 aPWn3sxHLY090lBlGENIJSaFCgSnTvVAJ3QKPdt8nOWIA4WRfGj4i9hjXVsSZplFDn
	 IEkTndcqNdrSKiqOUrKeKdyAfhUbBywQuBvT3suPGWkJJHa1l9HTqp6klEKSWA+Quf
	 s+jd+rl8hUItw==
Date: Fri, 4 Oct 2024 07:40:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
 <shuah@kernel.org>, Allison Henderson <allison.henderson@oracle.com>,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 rds-devel@oss.oracle.com
Subject: Re: [PATCH 0/3] selftests: net: add missing gitignore and
 EXTRA_CLEAN entries.
Message-ID: <20241004074012.68b153c7@kernel.org>
In-Reply-To: <20240930-net-selftests-gitignore-v1-0-65225a855946@gmail.com>
References: <20240930-net-selftests-gitignore-v1-0-65225a855946@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Sep 2024 19:34:09 +0200 Javier Carrasco wrote:
> This series is a cherry-pick on top of v6.12-rc1 from the one I sent
> for selftests with other patches that were not net-related:
> 
> https://lore.kernel.org/all/20240925-selftests-gitignore-v3-0-9db896474170@gmail.com/
> 
> The patches have not been modified, and the Reviewed-by tags have
> been kept.

We merged commit 8ed7cf66f484 ("selftests: rds: move include.sh to
TEST_FILES") in meantime, now we have a slight conflict on patch 2.
Could you rebase and repost?

I'd designate the repost as "PATCH net v2", indicating that we probably
want to send these to Linus before 6.12
-- 
pw-bot: cr

