Return-Path: <linux-kselftest+bounces-40930-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6D6B489AC
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 12:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0C733A5363
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 10:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8592F3C01;
	Mon,  8 Sep 2025 10:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IMyNksgN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655D02192E3;
	Mon,  8 Sep 2025 10:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757326383; cv=none; b=YnCJo79yKOgbV5514tpEquSYpkrNZnouI2QqmaV9XPH7G8rVSNWiKTk6fPuOS0X4wWGCecFMtvQZkql7qwcGLIMhMVXugaEBQ0pdFg/y+MA7rBhMDjNmmXSH5ivb93NCOmOYYTXZHtJh+d2oS8RtTEnFc0MAmxJZngi+Wa++CM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757326383; c=relaxed/simple;
	bh=P7Gdx6jHyS2mhrerthEgKNkM8QnFvFV6K6JPItqOAl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZYHOjjskQxBO/hLlPX5QlxbcPy+O5cOkjJrdrB373NQdc2bFTYylsSO39RCDjgmqHn0VwssRDxBMpTHxYWcD1355BZR08pskqMmbYT3uYeO7+gZ8CdOA4aDd2OHmCwmI/Fr46ZwnTedx5N7wIvLeORWfq4Q8DWmk11sNSXR4ZVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IMyNksgN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C337CC4CEF1;
	Mon,  8 Sep 2025 10:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757326381;
	bh=P7Gdx6jHyS2mhrerthEgKNkM8QnFvFV6K6JPItqOAl8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IMyNksgNqwSaz0M8/qJ7RUcdg2+SEgAlXLw9tD5aE2Yektd3dshrDvUpm/ptL3pg9
	 nGLYOcjGlKPlH5hru8EJ0nezbjomR74/hWQiVeja5fu1KIudPAO3Z5mgv02jd4XK8B
	 +tAI3eX+weLj18dlWAKsH1U4phxE1ojIZiD+iWNv8baMGcVgdeNAbsHpENNzlztqXR
	 zgRelmHQ4nIdb7LnoGugUQ93aa6MjoimFEJ40J9L2C2xfe8abBDbe9pjG1cFlCV1fW
	 rQJLHivQA6b8BcLnAvGKRMR10uQVwB/o84T4oe6mEzoFN6734OJmAx59NYe4POXmE/
	 aC35kKBsy5gLw==
Date: Mon, 8 Sep 2025 11:12:56 +0100
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, david decotigny <decot@googlers.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, asantostc@gmail.com, efault@gmx.de,
	calvin@wbinvd.org, kernel-team@meta.com, stable@vger.kernel.org,
	jv@jvosburgh.net
Subject: Re: [PATCH net v3 1/3] netpoll: fix incorrect refcount handling
 causing incorrect cleanup
Message-ID: <20250908101256.GA2015@horms.kernel.org>
References: <20250905-netconsole_torture-v3-0-875c7febd316@debian.org>
 <20250905-netconsole_torture-v3-1-875c7febd316@debian.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905-netconsole_torture-v3-1-875c7febd316@debian.org>

On Fri, Sep 05, 2025 at 10:25:07AM -0700, Breno Leitao wrote:
> commit efa95b01da18 ("netpoll: fix use after free") incorrectly
> ignored the refcount and prematurely set dev->npinfo to NULL during
> netpoll cleanup, leading to improper behavior and memory leaks.
> 
> Scenario causing lack of proper cleanup:
> 
> 1) A netpoll is associated with a NIC (e.g., eth0) and netdev->npinfo is
>    allocated, and refcnt = 1
>    - Keep in mind that npinfo is shared among all netpoll instances. In
>      this case, there is just one.
> 
> 2) Another netpoll is also associated with the same NIC and
>    npinfo->refcnt += 1.
>    - Now dev->npinfo->refcnt = 2;
>    - There is just one npinfo associated to the netdev.
> 
> 3) When the first netpolls goes to clean up:
>    - The first cleanup succeeds and clears np->dev->npinfo, ignoring
>      refcnt.
>      - It basically calls `RCU_INIT_POINTER(np->dev->npinfo, NULL);`
>    - Set dev->npinfo = NULL, without proper cleanup
>    - No ->ndo_netpoll_cleanup() is either called
> 
> 4) Now the second target tries to clean up
>    - The second cleanup fails because np->dev->npinfo is already NULL.
>      * In this case, ops->ndo_netpoll_cleanup() was never called, and
>        the skb pool is not cleaned as well (for the second netpoll
>        instance)
>   - This leaks npinfo and skbpool skbs, which is clearly reported by
>     kmemleak.
> 
> Revert commit efa95b01da18 ("netpoll: fix use after free") and adds
> clarifying comments emphasizing that npinfo cleanup should only happen
> once the refcount reaches zero, ensuring stable and correct netpoll
> behavior.
> 
> Cc: stable@vger.kernel.org
> Cc: jv@jvosburgh.net
> Fixes: efa95b01da18 ("netpoll: fix use after free")
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <horms@kernel.org>


