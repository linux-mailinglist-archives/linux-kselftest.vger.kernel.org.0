Return-Path: <linux-kselftest+bounces-38706-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C88B214E1
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 20:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4F561A23022
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 18:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7391F2E284D;
	Mon, 11 Aug 2025 18:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6KUrDNG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DFE238C16;
	Mon, 11 Aug 2025 18:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754938299; cv=none; b=GV+feA6+bI4djlsnI7DgBSCg3Wpm2MwNqMrfPy2k0Lced4SGk6ZgQDyFFlDHeHoq1E+nelU7uU81rlYS7Llm0Yu5uzrtxPTF0umJK1LXAjAaTgm7SppDiJ7aVjnUIRsQEanqKx8LUxIPG5FPFliYSFtiYEkR24HIlHbuOcX5rwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754938299; c=relaxed/simple;
	bh=TyL5WM4KmK4UEKtUWLjU9qmPO9uX7gp5FgMMIIGkhR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A0Kw9u8Ed38g87dWDXyHjS529U0JGiuU3AQx1PKofSN9ZpW3QRzm1ylUS0BAIWJqrnQwmprHpETyZCAd0HoGbqKhw29LViik+ivGnHM+80wJ6X/avoQe3oKnhmfMwr7gqd9iij1zIAorJU/Epqcn1dg1H7Y5mcDlm43SCtlXDI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6KUrDNG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A28B0C4CEED;
	Mon, 11 Aug 2025 18:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754938298;
	bh=TyL5WM4KmK4UEKtUWLjU9qmPO9uX7gp5FgMMIIGkhR0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T6KUrDNGWelM7URVAXZGo04+ZxAi3SALiGcDdo0UxtvFW2rLJeiGYAy+K2tV9jaWp
	 kp6Ev7FTupGWIEM+tTCcwxLnwwHS6eH677EawQBgpALNsiXKDiBh6+RTU8GNyeVogD
	 7nXh2/3I5U232t3QATccielwpgjL/QIlLMBu4xR7wmrraJ1E73jQuCQJnDo4xhTr+V
	 L70+SNO/W7ocYzKR2EVwHxA3lbJh5faP645ADGJS1RWnx2VuMG786Pi7J8d/1u+aR0
	 wqMB2cJXVNSfupzUCTB+/l+tyySY/oEdR1km468NI4Z05si1HUZGmy2t58wBCEZpYJ
	 dufb9Mrcityew==
Date: Mon, 11 Aug 2025 08:51:37 -1000
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
Subject: Re: [RFC PATCH v3 1/2] cgroup: cgroup.freeze.stat.local time
 accounting
Message-ID: <aJo7udUoWJt_jLzK@slm.duckdns.org>
References: <20250805032940.3587891-4-ynaffit@google.com>
 <20250805032940.3587891-5-ynaffit@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805032940.3587891-5-ynaffit@google.com>

Hello,

Generally looks good to me. Some comments on cosmetics / interface.

On Mon, Aug 04, 2025 at 08:29:41PM -0700, Tiffany Yang wrote:
...
> +  cgroup.freeze.stat.local

This was mentioned before and maybe I missed the following discussions but
given that cgroup.freeze is a part of core cgroup, cgroup.stat.local is
probably the right place. It's not great that cgroup.stat wouldn't be a
superset of cgroup.stat.local but we can add the hierarchical counter later
if necessary.

> +	A read-only flat-keyed file which exists in non-root cgroups.
> +	The following entry is defined:
> +
> +	  freeze_time_total

How about just frozen_usec? "_usec" is what we used in cpu.stat for time
stats.

> +		Cumulative time that this cgroup has spent between freezing and
> +		thawing, regardless of whether by self or ancestor groups.
> +		NB: (not) reaching "frozen" state is not accounted here.
> +
> +		Using the following ASCII representation of a cgroup's freezer
> +		state, ::

It's a bit odd to include credit in a doc file. Maybe move it to the
description or add Co-developed-by: tag?

Thanks.

-- 
tejun

