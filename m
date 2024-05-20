Return-Path: <linux-kselftest+bounces-10420-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CEC8C9B0F
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 May 2024 12:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E732280CA3
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 May 2024 10:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EFCE4D9FE;
	Mon, 20 May 2024 10:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pwU2RKFc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255A44D9E8;
	Mon, 20 May 2024 10:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716199989; cv=none; b=d02KVRrtgjjHOAyqMbOfpbNx3nB5ziF60YHUqogSJy4WXOKvLUmeCYDGI9XxuXveE34jNYmt0qqZOavs27RsLvbr9SY9Hpn8vHh1AvupoYSRzIpRyvevdKsvCr1k04r38qoVno6gqZIRIcq+uZdkrTFL4tUDGDUx0q92UZONurg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716199989; c=relaxed/simple;
	bh=iB1/AGMuI2COmHUKNKYxTjsIWqrSI+JI2QtGpq3yc54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GBe8pUfAZFmGugq2QTBKgnGOG8bQqFh/LxeiSE768scIbBbPq+l4lSn9wEM9WcFZbMkk7ugZgprghSkvZrvtrbHGbXJfUhQis2JbdUopcbJx5vfzpD1K++6mMgVmkuJWKsKr9+iwPVZH7ddf8XesFReDW7jQg2D1Xj77c+8p0KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pwU2RKFc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFEE3C2BD10;
	Mon, 20 May 2024 10:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716199988;
	bh=iB1/AGMuI2COmHUKNKYxTjsIWqrSI+JI2QtGpq3yc54=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pwU2RKFcZsq99WDem1ZJGcQ0YMzo+q6mt003rOBynMyS8d5zc+KZR+EMAOcOHN2VU
	 5z3kDPVB2Jmw/5B8tcwYzMz+Sggh2NEMHIN0mCRqbwxTVVbWeW3k/iQ1wbHk5i0Qxr
	 sCIU0o29bbK03UYU6Qkfr6Cv0ya4ViLMTjGGzicoCgDNGouAemxYCZIk3fHw/oxnID
	 k/0H78auW+0zLW1TQKnhqNxumdpEmBh9NsMB53H+sPwKQVOzahiKjd5WIj7Dj3eBRM
	 S6ibI7AYPDfg3DtPIAcM8MNRE7w3twDBt6lmGH3b1Jpbg2uGJArRONE6PAQS6CJvI5
	 asBZAS/1BUU7Q==
Date: Mon, 20 May 2024 11:13:04 +0100
From: Simon Horman <horms@kernel.org>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net v3] selftests: net: kill smcrouted in the cleanup
 logic in amt.sh
Message-ID: <20240520101304.GA764145@kernel.org>
References: <20240518132052.1293474-1-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240518132052.1293474-1-ap420073@gmail.com>

On Sat, May 18, 2024 at 01:20:52PM +0000, Taehee Yoo wrote:
> The amt.sh requires smcrouted for multicasting routing.
> So, it starts smcrouted before forwarding tests.
> It must be stopped after all tests, but it isn't.
> 
> To fix this issue, it kills smcrouted in the cleanup logic.
> 
> Fixes: c08e8baea78e ("selftests: add amt interface selftest script")
> Signed-off-by: Taehee Yoo <ap420073@gmail.com>

Thanks for the updates.

Reviewed-by: Simon Horman <horms@kernel.org>


