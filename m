Return-Path: <linux-kselftest+bounces-29495-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8570DA6A55F
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 12:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5BA23BC000
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Mar 2025 11:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F2221D5B0;
	Thu, 20 Mar 2025 11:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V0ZFk1kR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45CC1E5B8B;
	Thu, 20 Mar 2025 11:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742471252; cv=none; b=XT6+y+OVLW+GRvsV2K4I9gwyeMj2jqMgnjcA3AIxu9D+5Z1/4UkwHiBNd9NaUMLvPcbHgJnc7ooy3S+VzHZdYQODF6qcmbJY+oiz5vjUk41Pi56foUZOi0NBnYvQD/yau3mj2dUF7yLUg8cwqpIrEhnckJyJ7ZF1PY6W6hDQ/F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742471252; c=relaxed/simple;
	bh=F+Bdo8eocTU0Qmgl1duygS8GfMrZkbf5pQstCgDIMoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DaOLF5QWMoB0z/eAIcD5b9Ub/2oTYk/qzJzANwkjgu9b2hXdZmnzllJFFcxFZ/1iDYwYJApWuKkOlqQUyW+5Y6/A+IFWoPl7IaJbyzRPPABrhygrVmdWAr9EbmFYybpIOhYqqhIAaI+L4AmmANGUVqkvhT6iRk48zlisFUsy290=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V0ZFk1kR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38103C4CEDD;
	Thu, 20 Mar 2025 11:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742471252;
	bh=F+Bdo8eocTU0Qmgl1duygS8GfMrZkbf5pQstCgDIMoc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V0ZFk1kRkw0oiw9DQJcIEBG5dmkxn4bjVj/atWWyL+F65xVc2ctBL/q2ekA4q0LFk
	 p8FlbTXiairAlIAuR14q0qe1GsuzJ12rht3M5AdxYbzDmphYxS9raHcJix6xlfVpfs
	 gl7pvrQ2Rr8H13wi9oDGEVFTiD4Ghfmvr4dMw+pHb/p1VtN6EfbAAKl5Vd+l7U7gWy
	 wAKqly2fB3xg7H5E3E42qPZQf59XEgbmT3rxCWmjFDS3HE9mV/MZCmbcYT6qVZRuRC
	 Xcrd7EEGyb9wHG71Mo05II4RUGZAfxy8SrWaH3L4hN0zyEh0He6WeYuNKtwf3zT0y4
	 22jajhwfcfecA==
Date: Thu, 20 Mar 2025 11:47:28 +0000
From: Simon Horman <horms@kernel.org>
To: Peter Seiderer <ps.report@gmx.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH net-next v1 1/2] net: pktgen: add strict buffer parsing
 index check
Message-ID: <20250320114728.GL280585@kernel.org>
References: <20250317090401.1240704-1-ps.report@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317090401.1240704-1-ps.report@gmx.net>

On Mon, Mar 17, 2025 at 10:04:00AM +0100, Peter Seiderer wrote:
> Add strict buffer parsing index check to avoid the following Smatch
> warning:
> 
>   net/core/pktgen.c:877 get_imix_entries()
>   warn: check that incremented offset 'i' is capped
> 
> Checking the buffer index i after every get_user/i++ step and returning
> with error code immediately avoids the current indirect (but correct)
> error handling.
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/netdev/36cf3ee2-38b1-47e5-a42a-363efeb0ace3@stanley.mountain/
> Signed-off-by: Peter Seiderer <ps.report@gmx.net>

Reviewed-by: Simon Horman <horms@kernel.org>


