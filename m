Return-Path: <linux-kselftest+bounces-12822-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DAA9187FB
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 18:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 753471C22020
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jun 2024 16:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67DCC18FC69;
	Wed, 26 Jun 2024 16:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KKoMqFPd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A70D13C3F9;
	Wed, 26 Jun 2024 16:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719420930; cv=none; b=RovM0h0rHAYTL0xEqDtK3g08tJbcLvvQedapHBSmv5SxF3UNayrqCVhR21frhcJZK3K03YMKQ4sV/yxA/FzoKkGPVhP094Fc5HU/4jLiHYaytPEcvGM2c1wLGEhrY2iLIWohTX081IJm/2bfrUGsq9xEoPtP9uVPzOvflJnZEO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719420930; c=relaxed/simple;
	bh=msgAYn/k5BpBOopJH8TWxMsYVHSlr+Iborc38B0DjHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fq3x1iy+1C6i80+p1L7cDIwsllefonQlGaFKuxU37oOrXA4Cs7fPU1XYdWASJTY05GQuReJ+mtb/csu0STV1BE8XtavjBUm+2TjQPnp5YJxQPaMPoa15CgPtXN2KMqzFomyVtumQXrNB6YLUZB0htuemOmtW1OKrgQ+60oXVdU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KKoMqFPd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84326C116B1;
	Wed, 26 Jun 2024 16:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719420930;
	bh=msgAYn/k5BpBOopJH8TWxMsYVHSlr+Iborc38B0DjHY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KKoMqFPdJsBH/Y94bxZc8x0mHgH47BwJIxvgDtLYXDXaYMfXS81qwdtMr3LbkCFT3
	 3d+RZF40UTcAow6RIIS8aNQ4cZjjzrjP6Fyc+ApcrHsc7QfAETD63mzdnXpQ/pTzQt
	 IM5zwzIvcxMK4DEkPXVcXGiyBXMZMvBAJ4g1UpZcwqJVsVCwmmd7BP4zXYdgLmr178
	 zXpw0X1TkrN3WX26ixHD7n60KIncI93IczzsWjrb/opg3uwsWaI7ZnkErpmx+0z39e
	 juma3RngnjoCPrZR8WvYAdLKCJOzvZZRTvoGm65KgmqwTirVongd9TSOET9cQEo9Bd
	 tXp0o5FehZkrQ==
Date: Wed, 26 Jun 2024 17:55:25 +0100
From: Simon Horman <horms@kernel.org>
To: Aaron Conole <aconole@redhat.com>
Cc: netdev@vger.kernel.org, dev@openvswitch.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Pravin B Shelar <pshelar@ovn.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Stefano Brivio <sbrivio@redhat.com>,
	=?utf-8?Q?Adri=C3=A1n?= Moreno <amorenoz@redhat.com>
Subject: Re: [PATCH net-next v3 4/7] selftests: openvswitch: Add support for
 tunnel() key.
Message-ID: <20240626165525.GB3104@kernel.org>
References: <20240625172245.233874-1-aconole@redhat.com>
 <20240625172245.233874-5-aconole@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625172245.233874-5-aconole@redhat.com>

On Tue, Jun 25, 2024 at 01:22:42PM -0400, Aaron Conole wrote:
> This will be used when setting details about the tunnel to use as
> transport.  There is a difference between the ODP format between tunnel():
> the 'key' flag is not actually a flag field, so we don't support it in the
> same way that the vswitchd userspace supports displaying it.
> 
> Signed-off-by: Aaron Conole <aconole@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Simon Horman <horms@kernel.org>


