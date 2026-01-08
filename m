Return-Path: <linux-kselftest+bounces-48536-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A14AD04318
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 17:09:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2D6E63036375
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 15:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492BF23717F;
	Thu,  8 Jan 2026 15:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nmJzzqIE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CE5625;
	Thu,  8 Jan 2026 15:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767887850; cv=none; b=ED/Gc/5pXPU88anic5HA+CvO07y7YXEJWIJ2/gjUOqB8/5Zq972PQ7QDCI9THfHo0k5lRJGnPZ4A9NZxjnCGmPbgrSigGmPK4uKOC1zwYq/UuTIwF0EpWP//PZ/OeXCWhH2+z+4GCvcaZtcc5k92g+iBkTVTYVqDTatJjxzrc+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767887850; c=relaxed/simple;
	bh=ugz8wdo/6BEOG+khFJF1hZdX/nRQsHinmOapoZfspvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E8SCvPg+rh3KYQ0zBwBkVFjc9r/mQIz+h+1uJgtD20AT9S8UmrrNzlTeQf1AG+7L25RTzHzt43dPqgMO2Ckhp8waFlwd/1utBm2ieqTayfGZVhdRRFnGBxcy+2hztz17e1hfyoTaxP5awKQzlq7YiML0IySYVFbwgTVSCF6x2ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nmJzzqIE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 576DBC116D0;
	Thu,  8 Jan 2026 15:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767887849;
	bh=ugz8wdo/6BEOG+khFJF1hZdX/nRQsHinmOapoZfspvI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nmJzzqIE4IxZRUNZpaA82BmsxC6pFmAomFHBeykBct/d2m/d6EbfBpIozT3vIEt58
	 NPWis4JayhrDP14cvBx9K8rB776JY4suj79SVX3Uv0TLnZJZkoFWmotc4SstZzN0rd
	 hWMEIa39s1FZI0i9x7FT3+u1TbXbB1M42rE+jY7bAIdg+zYaqh89rOi+oMCBZpHajZ
	 fbaS30dbcCz8wOucxN7jD5sN0Mqy2qKvv2OcIvGBhqWuQ92ZWH26oOS1NyzIBk7YYN
	 X9Trl1zAt440AJ1mCv2RFbAADwxaBOVgy67pQk/jhY2QWMuwBUo5iC9VNtk3AzRLnL
	 NoiGLjYLF+ocA==
Date: Thu, 8 Jan 2026 16:57:26 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, rcu@vger.kernel.org,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH -next 3/8] rcu/nocb: Remove unnecessary WakeOvfIsDeferred
 wake path
Message-ID: <aV_T5kLzX2qMpxpt@localhost.localdomain>
References: <20260101163417.1065705-1-joelagnelf@nvidia.com>
 <20260101163417.1065705-4-joelagnelf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260101163417.1065705-4-joelagnelf@nvidia.com>

Le Thu, Jan 01, 2026 at 11:34:12AM -0500, Joel Fernandes a écrit :
> @@ -974,8 +959,7 @@ static bool do_nocb_deferred_wakeup_common(struct rcu_data *rdp_gp,
>  		return false;
>  	}
>  
> -	ndw = rdp_gp->nocb_defer_wakeup;
> -	ret = __wake_nocb_gp(rdp_gp, rdp, ndw == RCU_NOCB_WAKE_FORCE, flags);
> +	ret = __wake_nocb_gp(rdp_gp, rdp, false, flags);

The force parameter can now be removed, right? (same applies to wake_nocb_gp()).

Other than that:

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

-- 
Frederic Weisbecker
SUSE Labs

