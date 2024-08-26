Return-Path: <linux-kselftest+bounces-16330-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6E795F962
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 21:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 424CCB21566
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 19:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5B91991A9;
	Mon, 26 Aug 2024 19:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qscm7fiN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D38F191473;
	Mon, 26 Aug 2024 19:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724699150; cv=none; b=tDDV+MVgCvMpi+NcgUe/fGWQGSCHvJHPcyB72GMH+sewttYPQh6+CaoO+H+t8zQ1ttEOOhx4fUqIkJJlzhnOLBHhUEAqunCp8T6xQga+zPIbuiSZboxwwwSm7EQH9UP/5p6mU/x2NxckQmapfrFkNLZw6clGfdGVLxaJ7xlGfjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724699150; c=relaxed/simple;
	bh=kodZH7iyjh6N0lyHFBZoDBvoPNAYhvcixfEOgSEJ9AQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qp0e/+2OFhxye/k4bgax0t2NgY1w/z8HeGvsUwW+to4+INi5296w013lODz4uIUeL9iRwExqmijj5WvaBUngxu5v0aYUkx+Vw/JDtm4VXNn07dAtBc6jHBxsyN7gz2SrSugKtWYDPTiL7FrHt5nRCePNJxXIf4CEXDwql13Ac5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qscm7fiN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 946B8C8B7B3;
	Mon, 26 Aug 2024 19:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724699149;
	bh=kodZH7iyjh6N0lyHFBZoDBvoPNAYhvcixfEOgSEJ9AQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qscm7fiND2ORGP7AwoYHBumFm4vbL8RzSSU34z7aMchPb+xR/GBM0E4aoJfsaSPaf
	 aM6JI34+6A4gBmhG8JpucuZZr7ZldCTvKRxeFbDTws2LlaF2ZfleeVVg05eeqwbY5c
	 QJH77ZYeeG6YD9OiL6Yf9PMqCEA7TfipcBoEfJBMnccoqDucCjcs9SFz7Qp/eCjk2T
	 cvijSLqVUu8jemsrupz/voAqEIy3M8coZ+4b8teEmtU2xzCmkokEojWtF7B+VZnq3D
	 tXZAMntpSqRwbhTgYn25JPhBKjQD79ub+kADJKr4Ij3SMLSmZibiHBKfGjmsGYIpBr
	 dmP0jsebscfqw==
Date: Mon, 26 Aug 2024 09:05:48 -1000
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH-cgroup 0/2] cgroup/cpuset: Account for boot time isolated
 CPUs
Message-ID: <ZszSDG7GlvKQTydh@slm.duckdns.org>
References: <20240820195536.202066-1-longman@redhat.com>
 <ce01caf5-e576-4614-b6b8-0206da1a7c49@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce01caf5-e576-4614-b6b8-0206da1a7c49@redhat.com>

Hello, Waiman.

On Mon, Aug 26, 2024 at 03:01:21PM -0400, Waiman Long wrote:
> Ping! Any comment on these patches?

cgroup side looks fine to me. Ping isol people?

Thanks.

-- 
tejun

