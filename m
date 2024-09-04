Return-Path: <linux-kselftest+bounces-17187-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CE496CADA
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Sep 2024 01:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88063289888
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 23:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BEA716F839;
	Wed,  4 Sep 2024 23:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qxNcmQI/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1716149C52;
	Wed,  4 Sep 2024 23:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725493156; cv=none; b=KvnP0rInXtxTbPfIYD62og7Uhpx47I2EofAe4NUmnASakFLW7gvDZZu6PgoRcwZxP28kWAlXArgdFvO8jv7nka6XVyHhOFd/MRdl+GQ7JaOxTMYfg+y7uySIz3b1D4XzZlwhZ37D54gdrxYJ+j/1z4hRx3dMv70SGFHuLZIP1Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725493156; c=relaxed/simple;
	bh=MtEMk5uvVtx9ERgczCIyD0KhqFCc8a2Mb5QAblSugNI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A/s0x6QTyDxuRpc1J2+oTfUoT85F5+Yogg0KEq/CUSljiwaolMIBCgP1h/05ZlY6VVJvw8cRV1zG+SZyD0TAiaa3QHemjXUHV8J5etFObV6p06tsIg9XpslfQRY3nObSAZtY9yaYa+OLvKCfEIY9bFcvHDh5al4/kLysY9F266I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qxNcmQI/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BE60C4CEC2;
	Wed,  4 Sep 2024 23:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725493155;
	bh=MtEMk5uvVtx9ERgczCIyD0KhqFCc8a2Mb5QAblSugNI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qxNcmQI/5ZNsU2LU44CMZEdweiaq2/i53Jo9DU7zvpA896pkVlff1I99CtRTZ9kvN
	 upr8FfT3CGUdx/gTfVzFZiGg6Kqar/1TvdvkGLSv25V11Ujf1yh59F5VuKMhR/38z0
	 nhyDq9ngIVfQLNnS+a2Rt2ScrmfyZ7cZ0hR7sYiiBU1Knmwn6c6pNtSyLx3LMfGd+a
	 bZQ5Yu+0PYGtQUsCvgjWJxAqb250n0Q98XlLQMPQC2BzPHRgnlrQO6hAuuk82YXzKW
	 k+QmxEnfo2pP9iqQ2aN9NpVTD4Xg2B+RKFkIyJ7o2X9eH9ULqVo/mnZkxJd1OT4tj7
	 HXZIlMX3h35YQ==
Date: Wed, 4 Sep 2024 16:39:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Liu Jing <liujing@cmss.chinamobile.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 shuah@kernel.org, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/net: do_setcpu function not need to have a
 return value
Message-ID: <20240904163914.5279569f@kernel.org>
In-Reply-To: <20240903095111.7204-1-liujing@cmss.chinamobile.com>
References: <20240903095111.7204-1-liujing@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  3 Sep 2024 17:51:11 +0800 Liu Jing wrote:
> in the do_setcpu, this function does not need to have a return value,
> which is meaningless

This test is flaky:
https://netdev.bots.linux.dev/contest.html?executor=vmksft-net-dbg&test=msg-zerocopy-sh
Could you please try to figure out what the problem is and fix it
instead of sending "cleanups"?
-- 
pw-bot: reject

