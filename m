Return-Path: <linux-kselftest+bounces-40483-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBB1B3EB39
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 17:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4CD1480768
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 15:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705592EC087;
	Mon,  1 Sep 2025 15:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cP9OuVZ2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AAF2D5930;
	Mon,  1 Sep 2025 15:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756740869; cv=none; b=VmgtaNHpEYi0UwZMkZrj1vrMU3xAR380m0cbG1WivXzWNqG0OFfnn7ETH9gT+jl6kBR3Si7Rau5HdxDbA0CkmYRmiY4rHzkYlq8Xc3ZEIXsr0RdcCIGCYAOvENpmwYQyOC1HaUTFxAJ//FBNAApaw9xekhvoLB2tTpqGQs3ge8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756740869; c=relaxed/simple;
	bh=zxtkK4szcuhucZHirsMkuZhVjAjva6h2OuGst/leZz4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K/n+noh9cTSNEcBql47SI62SqkKm5PtAWOk5Z/Z03mSu/ICFzREcyC1jdNTJUONNf5k3VoQkU5tQRHjKoM9hgZCG869/2i+m0Z9SBjgrqzyXLBPzr2DPuXxB9C0lAPWAWaHdczZwdcxYoZoY2ChvLxdME+paFBNerfZ2Ag4WjLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cP9OuVZ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56C22C4CEF0;
	Mon,  1 Sep 2025 15:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756740868;
	bh=zxtkK4szcuhucZHirsMkuZhVjAjva6h2OuGst/leZz4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cP9OuVZ23NDBNtDXJFFpVQqErvc4vXBSbezCN2lf0Z+ZFJ4Rlx7tAC1zSjMRusbZL
	 hHL6gkzW5OioboxgBUXsVy+6iXnoyMqo+7eFw5Cp51FLf1vv8OohRWH2VJBOPAq6SD
	 Cwtapx3PiTD/nn896L8YnkjjmVEAwuIXj1KMK/g7BGHwNp8JZxDrz+aQYTrjN7ln63
	 7gG7qZQNojWqtyVe+acFCaI5uxI4JpIbUG1PeNRw1uW1znkcDQUsQWzt8bfpgnvyAp
	 xm84FnKbTDOflUGEtnVAJ3m9+crArYVNvxC9/ot1HNaITebEj62WIlu4BCy11x2wl/
	 IExU5oCKTx3GA==
Date: Mon, 1 Sep 2025 08:34:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Brett A C Sheffield <bacs@librecast.net>
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net,
 edumazet@google.com, gregkh@linuxfoundation.org, horms@kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, shuah@kernel.org,
 willemb@google.com
Subject: Re: [PATCH net-next v4] selftests: net: add test for ipv6
 fragmentation
Message-ID: <20250901083427.5d9e2a1a@kernel.org>
In-Reply-To: <20250901123757.13112-1-bacs@librecast.net>
References: <20250901123757.13112-1-bacs@librecast.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  1 Sep 2025 12:37:14 +0000 Brett A C Sheffield wrote:
> +static int setup(void)
> +{
> +	struct ifreq ifr = {
> +		.ifr_name = "lo"
> +	};
> +	int fd = -1;
> +	int ctl;
> +
> +	/* we need to set MTU, so do this in a namespace to play nicely */
> +	if (unshare(CLONE_NEWNET) == -1)
> +		error(KSFT_FAIL, errno, "unshare");
> +
> +	ctl = socket(AF_LOCAL, SOCK_STREAM, 0);
> +	if (ctl == -1)
> +		error(KSFT_FAIL, errno, "socket");
> +
> +	/* ensure MTU is smaller than what we plan to send */
> +	ifr.ifr_mtu = MTU;
> +	if (ioctl(ctl, SIOCSIFMTU, &ifr) == -1)
> +		error(KSFT_FAIL, errno, "ioctl: set MTU");
> +
> +	disable_dad("lo");
> +	interface_up(ctl, &ifr);
> +
> +	close(ctl);
> +	return fd;

fd is unused here
-- 
pw-bot: cr

