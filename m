Return-Path: <linux-kselftest+bounces-15652-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B52AD956E25
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 17:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E81A31C221D5
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 15:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA1B1741D9;
	Mon, 19 Aug 2024 15:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FpAgZLjO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C9A173355;
	Mon, 19 Aug 2024 15:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724079798; cv=none; b=gtQOSEjiBzbTb4z5JLrN8lUHbX7x3dZaREcugJM9ED9KnSQfhB5CvVXRJ7oa1CIvQA8er+6AG5efIPTpBDhKU4Ode3hvFDDq0G3oyLaL5nor0L1T4S3QbD1ECm4sggfdZYUN+leWGdmTOvYFulcMLgLIwBljANz3+x8MW4UQ0cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724079798; c=relaxed/simple;
	bh=aeHJLoOQWcaOWF0e9GClkYwXZFKKKkmjgYDEYtaX0zM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u0avBQ+dO/Hk5gzp7Rm3Bys2WOSZMqC/p/wJ6K47D2GBVuKfkmlOhHAT9O40npbWMPOznLjVgrClnlGPA3UD7pmzlY59ipvW2DgV5tL1mQMnvJUQijmrxAkPnjMQMIfzQ4p/7LBoblgexA8AMUKOs5g0K53bIcNksL5EjUJyKys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FpAgZLjO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0234DC4AF0E;
	Mon, 19 Aug 2024 15:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724079798;
	bh=aeHJLoOQWcaOWF0e9GClkYwXZFKKKkmjgYDEYtaX0zM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FpAgZLjOw5+7uCjXAh0uU3dYKCCR/4ACaxTDo1B4641QVo2MplJeNXjgw2wxGcP+3
	 wVPwVMwocdNkEwShjKprKDcO8+ws6qp04okcUfg+iaFstRHUDutlvIOYfypcNSg9CV
	 irEJ1jtiexhmrHP0ovF3VliVPfIoMoazR9CTkimXEOD/xhXFxqcjuoi8J5p+LOdQp6
	 FPYKPdY7UYfWpeQIuJiyI+MGxU7hrckdCW9yrtq5y/Nh8GfaLV1L8ZXP7aClxLycwE
	 sYvCDNFp3nOLuY64M8sAqgeTIdVkiShZXi2FvjARBpsZhX/whVx8xSq3MK6s0iknSv
	 xxVRX4fGeYwig==
Date: Mon, 19 Aug 2024 16:03:14 +0100
From: Simon Horman <horms@kernel.org>
To: Abhinav Jain <jain.abhinav177@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org, javier.carrasco.cruz@gmail.com
Subject: Re: [PATCH v8 net-next 3/3] selftests: net: Use XFAIL for operations
 not supported by the driver
Message-ID: <20240819150314.GI11472@kernel.org>
References: <20240819121235.39514-1-jain.abhinav177@gmail.com>
 <20240819121235.39514-4-jain.abhinav177@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819121235.39514-4-jain.abhinav177@gmail.com>

On Mon, Aug 19, 2024 at 05:42:35PM +0530, Abhinav Jain wrote:
> Check if veth pair was created and if yes, xfail on setting IP address
> logging an informational message.
> Use XFAIL instead of SKIP for unsupported ethtool APIs.
> 
> Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


