Return-Path: <linux-kselftest+bounces-16851-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AFEE9669F8
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 21:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D8721C220CC
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 19:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D851BD001;
	Fri, 30 Aug 2024 19:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n+PqU9xa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B99E33CD1;
	Fri, 30 Aug 2024 19:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725046902; cv=none; b=pSuftqqSZBuic2yLNBtB5IiD/4+NNPm39ZLPOV4quAjQpS76H1e+wJBgO/JmW1sAa9efb1OoXoTx0InukEJ2PROZ5imzvDWGQARVJx37IvKDSY6ImWDrPcvaVjrDHIgEZKTJTuJ/VypjA59tH+lRyF86fvlxRf+MboIIGRpCwXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725046902; c=relaxed/simple;
	bh=YmAVUv/qdETNoSJhr+xIDAhJhvlKSU3g1VMNFU4pj9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LG2Rtxi8+8lBAEt48tTDFRCU+ZnvJ4Lkbc7Fm9edklM1DBUZSvReDsUcxvy/WwmDDQFOeMu01xR6FVkpnGuBfL4ky1XhQejAGledcRpNAmio2543eOETfOxNxtcVFM9ysjBW43u9JQd5jJcdh/2gHgqoWt8WqwdUbf9bI6MQ4iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n+PqU9xa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85D9DC4CEC2;
	Fri, 30 Aug 2024 19:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725046901;
	bh=YmAVUv/qdETNoSJhr+xIDAhJhvlKSU3g1VMNFU4pj9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n+PqU9xalkg9dGJCeo1NRyvwCGkZAsNMsBn9iC+LsLAvIjD1FQ2Xe3tD80uB8NT9P
	 5Wabgylq4ZN0dzLwoKFzwA0XTM51wfDV2y3zRPFXk3Qk96gQkWIQiNGlTbVXugq9BD
	 eZXQ0VviS7QxPXCfPs8PnXVOAHNBfpiNHTsW1k75D7jVhbDQw8gVTMpDQu8mcglSiD
	 +0/E28Byh8Lf3e3FvZmP8qPAfEWsD9502NfSfXKuqWYQXMJaGhmy5EZEL22dFOyBlr
	 4Rn5VyUtMxqbtw+QaHfEy/Xg9No9N91TadDim9Wsye7Yd1QNhiTC4FW5wlXQsruQnU
	 9NRF0VkUcve9g==
Date: Fri, 30 Aug 2024 09:41:40 -1000
From: Tejun Heo <tj@kernel.org>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: cgroups@vger.kernel.org, hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	lizefan.x@bytedance.com, mkoutny@suse.com, shuah@kernel.org
Subject: Re: [PATCH v2 1/2] Tracking cgroup-level niced CPU time
Message-ID: <ZtIgdEt9RSU4MCIP@slm.duckdns.org>
References: <20240830141939.723729-1-joshua.hahnjy@gmail.com>
 <20240830141939.723729-2-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830141939.723729-2-joshua.hahnjy@gmail.com>

On Fri, Aug 30, 2024 at 07:19:38AM -0700, Joshua Hahn wrote:
> From: Joshua Hahn <joshua.hahn6@gmail.com>
> 
> Cgroup-level CPU statistics currently include time spent on
> user/system processes, but do not include niced CPU time (despite
> already being tracked). This patch exposes niced CPU time to the
> userspace, allowing users to get a better understanding of their
> hardware limits and can facilitate more informed workload distribution.
> 
> A new field 'ntime' is added to struct cgroup_base_stat as opposed to
> struct task_cputime to minimize footprint.

Patch looks fine to me but can you please do the followings?

- Add subsystem prefix to the patch titles. Look other commits for examples.

- Add Signed-off-by to both.

Thanks.

-- 
tejun

