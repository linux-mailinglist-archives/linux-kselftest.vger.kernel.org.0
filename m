Return-Path: <linux-kselftest+bounces-15039-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6747C94C293
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Aug 2024 18:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98CFD1C21FB5
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Aug 2024 16:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8567E18DF70;
	Thu,  8 Aug 2024 16:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1r5SjDe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4761A269;
	Thu,  8 Aug 2024 16:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723134191; cv=none; b=Xkw+l/rGy7P+vJLTFnLuJlUUS/4lSlTuTNj5M0GgzVHHYujM9uI8xTyr5yT9Rjc/H5sejsq7xISYpC+GRSxsjPSO/PlKMXo0tKPDfZedUX7cFKgBM2SHpqHx0nm1GKDV9ft+D/U5uuxQ6Y1LgJ9rDceGxuY8JQs5lwVFzZRGA2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723134191; c=relaxed/simple;
	bh=BnMyJtZaMRIEhIWYDPpCbVxmxFbfGjEGWeEowMeknAs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YXA+4x34Y9n7PCIhpFmYf95OfAlSOXal6hMNSiReFgIJ/TbBE8/Y/F0QjP/NV3Ya1tyIl1BHg9R5rCe4JxE+SPoYlKxXERMhYFnkjKELr7wAuYkMwLedNGKroqnxK7lJGKjqbx9eDP9EGD7xKATdnKXjpYDU9I1TQfR4dCkLkEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1r5SjDe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66BCBC32786;
	Thu,  8 Aug 2024 16:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723134190;
	bh=BnMyJtZaMRIEhIWYDPpCbVxmxFbfGjEGWeEowMeknAs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n1r5SjDesnsT+O4xW96fIWKSVvP05LB8TZye9rOVsA3Idm8A3fl7IzTaYia4as1+Z
	 FKDCOmEH9WDhTKXxy7IqDsVYgScpnqHt14+/VeeEKFFxa5XtD8DkGvdR6YNyec/Hf2
	 7QA/qYUa4cum6B2oyvvin1lh2gztTKXr8RpSrj6G5XKWXQBJreINjVweKnqCw28cHg
	 V1KsRUIgbsPitIzKMwuzfQglgGJ/YyEMa1riNZtIQZeTbtT3mErlL3HtWTNFUBOy9u
	 C5eSiGsvu4g0otKQl2CFW0E/XToVf8jrGaTVanK1D6zoPOQDfWbBCRpVUnMktCjqnT
	 SRh7rDRnbXUkw==
Date: Thu, 8 Aug 2024 09:23:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Abhinav Jain <jain.abhinav177@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 shuah@kernel.org, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 javier.carrasco.cruz@gmail.com
Subject: Re: [PATCH v5 1/2] selftests: net: Create veth pair for testing in
 networkless kernel
Message-ID: <20240808092309.2a811cf4@kernel.org>
In-Reply-To: <20240808122452.25683-2-jain.abhinav177@gmail.com>
References: <20240808122452.25683-1-jain.abhinav177@gmail.com>
	<20240808122452.25683-2-jain.abhinav177@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  8 Aug 2024 12:24:51 +0000 Abhinav Jain wrote:
> Check if the netdev list is empty and create veth pair to be used for
> feature on/off testing.
> Remove the veth pair after testing is complete.

A number of checks now return SKIP because veth doesn't support all
ethtool APIs.

In netdev selftests we try to make sure SKIP is only used when test
cannot be performed because of limitations of the environment.
For example some tool is not installed, kernel doesn't have a config.
Something that the person running the test is able to fix by fixing
how the test is run.

Running this test on veth will always SKIP, nothing CI system can do.
Please make the test use the keyword XFAIL instead of SKIP when
functionality is not supported by the underlying driver.
-- 
pw-bot: cr

