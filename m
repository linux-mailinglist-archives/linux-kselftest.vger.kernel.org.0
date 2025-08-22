Return-Path: <linux-kselftest+bounces-39713-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A549B321CA
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 19:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FF4B160D27
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 17:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1235B28D8DB;
	Fri, 22 Aug 2025 17:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JVoud6mL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D148A19F422;
	Fri, 22 Aug 2025 17:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755885087; cv=none; b=EUFGqyqEsdEncMqu8nGJLfUrT/zIeDae3wmgU9jIuVHIfPauA1NKHBU8j2XQhLUkaHLfRGBEujI6DOaKThKucZlVCIg4KggJOqtuLVUVe1y9qXRLsyEEMiT1ykpqyAtu75SyxQc5u2wA1wMVburEfKMSlKkhwitLUCbwptG/Wqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755885087; c=relaxed/simple;
	bh=aD8+ds7nYN/JrrUWGfgklx///DHtTRGvjBkMg7m1/78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pUHWdC2ucX7dHi4RV9rnm12rM4AOEIIIF3JItI/G1zbDpP3E2h7Y+UbxFxEYsHRNnt10ODMM/ev/b/WjE3+9OWRj6KIQD9khrybrmJ9uw7Ikn7sBj3GyAnQ1dn99AURxGwZLrFMkrIAoxw94teneD00dCcTJZ+L7igxrs1uS9BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JVoud6mL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 332A5C4CEED;
	Fri, 22 Aug 2025 17:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755885086;
	bh=aD8+ds7nYN/JrrUWGfgklx///DHtTRGvjBkMg7m1/78=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JVoud6mLg4D/K38Guig7VA3SOByS6iBZJyeyCIDZNZpG2wHqQU0Uaxh3ITW9UvCHv
	 +DpH+5g2nlcZW4ho1/MgzraC2gUFGFx3Yn+qKxJ18rQUzSTxXlm0a9q2QZpqjQogiy
	 fKWm6EbTdHvHpUTNPj+4TAkUqKrhP7LQGwLmGlwtigl2o/SMSEjrG7U10oYaHalgB8
	 XcM4i2GWwVe7ORmc2o28qLjEe1FRAPV9F2vzuQRKEINaAQfN5TsRGb6lhxQgIlAvDC
	 araclU0fy5MQzvKr2igdhqozqMRH0Wce2yeP88SQ1FwK+t0HgGhGC0XeWX51FT3Y+P
	 sdgmYL7kwQKSw==
Date: Fri, 22 Aug 2025 07:51:25 -1000
From: Tejun Heo <tj@kernel.org>
To: Tiffany Yang <ynaffit@google.com>
Cc: linux-kernel@vger.kernel.org, John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Chen Ridong <chenridong@huawei.com>, kernel-team@android.com,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 0/2] cgroup: Track time in cgroup v2 freezer
Message-ID: <aKiuHbu5NPSPcpYp@slm.duckdns.org>
References: <20250822013749.3268080-6-ynaffit@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822013749.3268080-6-ynaffit@google.com>

On Thu, Aug 21, 2025 at 06:37:51PM -0700, Tiffany Yang wrote:
> Hello,
> 
> The cgroup v2 freezer controller is useful for freezing background
> applications so they don't contend with foreground tasks. However, this
> may disrupt any internal monitoring that the application is performing,
> as it may not be aware that it was frozen.
> 
> To illustrate, an application might implement a watchdog thread to
> monitor a high-priority task by periodically checking its state to
> ensure progress. The challenge is that the task only advances when the
> application is running, but watchdog timers are set relative to system
> time, not app time. If the app is frozen and misses the expected
> deadline, the watchdog, unaware of this pause, may kill a healthy
> process.
> 
> This series tracks the time that each cgroup spends "freezing" and
> exposes it via cgroup.stat.local. Include several basic selftests to
> demonstrate the expected behavior of this interface, including that:
>   1. Freeze time will increase while a cgroup is freezing, regardless of
>      whether it is frozen or not.
>   2. Each cgroup's freeze time is independent from the other cgroups in
>      its hierarchy.
> 
> Thanks,
> Tiffany
> 
> Signed-off-by: Tiffany Yang <ynaffit@google.com>

Applied to cgroup/for-6.18. Let's address further issues incrementally.

Thanks.

-- 
tejun

