Return-Path: <linux-kselftest+bounces-46730-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBEAC945AD
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Nov 2025 18:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 925EC346DF6
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Nov 2025 17:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACB023D2B4;
	Sat, 29 Nov 2025 17:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CSkh8OQi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3161D36D4E6;
	Sat, 29 Nov 2025 17:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764437430; cv=none; b=UrvNrsGNIqMGR6wJ/94abXzzGWayaldT1UEZwLl9CPwAEHZqUfCG0lYabfzPginQIMW6KZ54qYfpc71JtwB/P8cxY5n7pDziUZzaXogiYvQiHvc3K1CyxoNbQF5yF+uTyMlRNzwnyd9Ah634yc+7G9/F/Y/jr+2mSG9TPI2TcVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764437430; c=relaxed/simple;
	bh=N+PIhgULCwOz2y/llk2bLlH0sCDGdxlzTtlY2cbSxlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tGtfl1Z1hYpFXIOlJHTPev2xM+DX9D7g/0Xrfdr9wvX5Mro0es/4PbPQGs8BkJpUomOCxzwEytDH5DE8iwNMknCeQGfoC9oKSSy8r8ITfKfxOaHEp6L7EJSCndiagz0jGQ9emwMRrJaTDnTsk7NLu1rQfi/yYoK/8aw1I7C26Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CSkh8OQi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5439C4CEF7;
	Sat, 29 Nov 2025 17:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764437429;
	bh=N+PIhgULCwOz2y/llk2bLlH0sCDGdxlzTtlY2cbSxlE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CSkh8OQi5wYitBQ+TtsyVGtWxpqM/J9E6sumzqPcHzLavSwECd18UkDgRWGof6s1I
	 4iSBH0RpVGC+X/w3L3VSoyLgtmO3zggec2F7V2YHPODWYxdPMQxTQKYTqSUEpF+1da
	 sA3hWBuaRcoulKNErjQ68vbWtXPFi0eh+m8+1gI5XXJ3bhwoCBCkDPFGjK5i3Ozpmx
	 5hOOQbRZwfcbvU3Ib1L0ETiWwDhTzSDzBPYsW5Eb5ZmTkNXT38kZJhwLjHCu4T+2pe
	 GK5slfQn6SElgw4I2ZOcKaLN5DdNGROZLUtBC/8llQzBo3vlf86UNWkYzKnXnIcQUj
	 CzKlhhJeJ7ycw==
Date: Sat, 29 Nov 2025 17:30:25 +0000
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, shuah@kernel.org,
	willemb@google.com, petrm@nvidia.com,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next] selftests: net: py: handle interrupt during
 cleanup
Message-ID: <aSstsVBFi-rhKTyl@horms.kernel.org>
References: <20251128004846.2602687-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251128004846.2602687-1-kuba@kernel.org>

On Thu, Nov 27, 2025 at 04:48:46PM -0800, Jakub Kicinski wrote:
> Following up on the old discussion [1]. Let the BaseExceptions out of
> defer()'ed cleanup. And handle it in the main loop. This allows us to
> exit the tests if user hit Ctrl-C during defer().
> 
> Link: https://lore.kernel.org/20251119063228.3adfd743@kernel.org # [1]
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


