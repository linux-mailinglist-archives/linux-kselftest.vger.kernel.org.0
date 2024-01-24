Return-Path: <linux-kselftest+bounces-3489-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A0283B3CE
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 22:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 410EA286963
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 21:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA10D1350F8;
	Wed, 24 Jan 2024 21:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="abcUIYLz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEDF7E760;
	Wed, 24 Jan 2024 21:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706131309; cv=none; b=SU9sZP/PBzpsMulrsVf4TtYtSMYPIkcjqp+Cb2JSoIg0kJZyOH/6lfVLaMxmo76qy1tbkgs9aNsG+JsmPYS91kt++R88krMGjpvyFyjz2ZubWgy0ASzd01VKWbmXVRGJ4fNiugzFq+UWw00D8HUD23FG3moII1vZ5iWjDGgL0YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706131309; c=relaxed/simple;
	bh=s4/+h4EL9rYbjtkxDfsWLSUO+hIa4ufy+G4MfaKgqys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJ9xyg0iz05xFPKlPVAO/Kodub8haBDHTjaDsQWaWUWIsH/yydbkjCx1YswHXLnxOS1rnhkeGrZtgYAzlTaFIgZDkjHrQMKJu+Ql8/z0lgYOToF5Nv48Jj+jEbQ1r2JHlDyOwpRJcA2rTh4ofR84ob3mgq99K6yvW6qMmpKqKuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=abcUIYLz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DF08C43394;
	Wed, 24 Jan 2024 21:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706131309;
	bh=s4/+h4EL9rYbjtkxDfsWLSUO+hIa4ufy+G4MfaKgqys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=abcUIYLz0kTJoe2ctRskesPwzSLbXJELHKAh2rnksL6mY0+pWvfl8oA58qAAcqO8g
	 O2Aiwa/ZWO+eqTvR6NgsRjGKaPklQIkRaDf+Un3TEr5HDCq+1X1XhzvvN+i79etBq4
	 Ydlx+YCYfiCEmcVrxJdpk3jCMXEuPF6BbrIbc9aDrai/8V1daY6lC3jpZ500u20kU6
	 7JM2doZqcluYa2Bwu5QxPPBhxwkl7zkC7lRx5u69/+CtCIexBECjxgwydQTTlO9R5U
	 bShAd/Jk4lNlAxa0YA+VN28HtiaUhUFdiHne2LvswFfm0hGlEx/h6c/RwYAjryEFQ/
	 jEfiJhQMk8vdQ==
Date: Wed, 24 Jan 2024 21:21:44 +0000
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net v3] selftests: net: fix rps_default_mask with >32 CPUs
Message-ID: <20240124212144.GA348693@kernel.org>
References: <20240122195815.638997-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122195815.638997-1-kuba@kernel.org>

On Mon, Jan 22, 2024 at 11:58:15AM -0800, Jakub Kicinski wrote:
> If there is more than 32 cpus the bitmask will start to contain
> commas, leading to:
> 
> ./rps_default_mask.sh: line 36: [: 00000000,00000000: integer expression expected
> 
> Remove the commas, bash doesn't interpret leading zeroes as oct
> so that should be good enough. Switch to bash, Simon reports that
> not all shells support this type of substitution.
> 
> Fixes: c12e0d5f267d ("self-tests: introduce self-tests for RPS default mask")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>

