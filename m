Return-Path: <linux-kselftest+bounces-19418-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DA9997A97
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 04:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B07D528181E
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 02:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C52A6BB5B;
	Thu, 10 Oct 2024 02:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cXaNvWaH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C4364D;
	Thu, 10 Oct 2024 02:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728527578; cv=none; b=LrYTR3RxGINBM9RUG5h7HBH9daHVsllLixVtFIs8V4Y6G+EXRPL9t2uYrD9zuBKW1ZoEEsR4JVGn1F3Rm+3b+JtQAAOc9mfCTfHjbwkfx98TxD+zgzymzxrey/AXIXUqxLvUDNrgjHxmq88cfF9UhEJrLxyHVZqT0GMUfAy+Zlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728527578; c=relaxed/simple;
	bh=sztnmQz9KBsG/mgeqGMadgLTgH5p3VCVBYnWy8rCQUc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p5p2tTyTVWLBfTr32Q8zC345LbAcwhZr87KTL2tartdK8JJVw6SZzoT4idJYAe5KrPXJfMg6zU1MNWXKyzo8z74pvt2T7r93+crgwLf/aCKjTp1V5ATT5axYJUr3Sny8OUqfCu6i4SbfQvdL5SE9eFmlBYq2eCAkkrxweZqvgHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cXaNvWaH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DEEAC4CECF;
	Thu, 10 Oct 2024 02:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728527577;
	bh=sztnmQz9KBsG/mgeqGMadgLTgH5p3VCVBYnWy8rCQUc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cXaNvWaH8dP6NIhZAU3SeME/2XuHMuTZTCP6oTqN0qfzJ0Izy5Ul9vDyMO7wywm/p
	 6RphBQHo8sqk/9+qu+cX0DXZACKAEvLBSnF/EB6Pa3xKrxiiiLzcAeJg0FjpUbBfnZ
	 ugMB1nNcs8hr7a/uW1XX4g2uuzljDam1pTFiX/1TVuAvqSP4RMGDIDonWiHDmD1m7i
	 w75mRvb/3WCkmc82uaufNSOxmIPg2b/xeOBBb4dQg1PjN8GGrpZDdWCGnK6BEaFDae
	 0QnIpqoaGMMsdI7FS6NGt1ErBUOsPBm5JJXk7EfGmuSO3ZsS2TCTek2zuPkic2b2lo
	 E7UoSRI48y0/w==
Date: Wed, 9 Oct 2024 19:32:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alessandro Zanni <alessandro.zanni87@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 shuah@kernel.org, petrm@nvidia.com, dw@davidwei.uk, martin.lau@kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 anupnewsmail@gmail.com
Subject: Re: [PATCH] selftests: drivers: net: fix name not defined
Message-ID: <20241009193256.2dd476c5@kernel.org>
In-Reply-To: <20241008220137.274660-1-alessandro.zanni87@gmail.com>
References: <20241008220137.274660-1-alessandro.zanni87@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  9 Oct 2024 00:01:33 +0200 Alessandro Zanni wrote:
> This fix solves this error, when calling kselftest with targets "drivers/net":
> 
> File "tools/testing/selftests/net/lib/py/nsim.py", line 64, in __init__
>   if e.errno == errno.ENOSPC:
> NameError: name 'errno' is not defined
> 
> The module errno makes available standard error system symbols.

Can you say more about how you hit this error?

If it's just based on static analysis please mention that in the commit
message, and also mention that the problem doesn't happen in practice.
This will avoid the patch being backported unnecessarily.

We run all the tests in our CI, and the problem is not hit. But I agree
with you that the import is theoretically missing.
-- 
pw-bot: cr

