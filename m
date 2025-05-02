Return-Path: <linux-kselftest+bounces-32213-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 555F2AA7959
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 20:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57AA04C415E
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 18:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84852266581;
	Fri,  2 May 2025 18:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E3Zty5YU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C7E376;
	Fri,  2 May 2025 18:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746211182; cv=none; b=Fqk4aogoKNcfIlZfNC3WcoaWe7eTdDF9pgcw4tMt5aSiGDZhqAJ2LS8gw/Q20ZyRGhMlUdqfhDvHKhIKN1abvAUDaFmRkauOa5ciSgvo6ULDXFSzZvKnS1NoxnejMyfDDPdcG6HdkhlUE/gtGgfbdVE0nCxV/CN9bLzhkfXakqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746211182; c=relaxed/simple;
	bh=eWeXFUsFqqWiEPqkBtlgn2arWqgAePgxBwoLc+q61HE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YO1bn0EMe1fMF1cm7+axVilgrVyB2yPkRUiXkcvXWentfnBBgi6sYcVqN7ktL0F2yVNdYaGiXw8C9HglwlRr2sMF5VLO0VuSERQb9PiOUQoqoromdmjIXliJXLcLaPLPSayGSm64KaA/7fND/NKtCgFtOfqcOOFdCLJsKpIaMfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E3Zty5YU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F421C4CEE4;
	Fri,  2 May 2025 18:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746211182;
	bh=eWeXFUsFqqWiEPqkBtlgn2arWqgAePgxBwoLc+q61HE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E3Zty5YU1xMsuwMJiRCigUgxNI39PvZ1N4jx+iMe0TG98rOw+D10SZ/8qCZA1nGFb
	 GxikXPlZKLL/qyg8Q5YRuluzxVKFthm+DnWOHyrIk92LuGQ90gjET/Exledj66MVWL
	 9iXWT5uvP4sV/0u6IpZQ1SeudVmOG5Olti8MfMO7Bj9iV3CLd61yXArnXv8Mc9maaQ
	 3qo1CiRcgz+ztVAOsa/C12epXmtZTiv2w3DLbBZSaPsAYKF146gCJR/ZLV24ahDjAn
	 1kjPpgssr4zA7X5otC3WDK+r6xIcjC95bXdU6x9nB/8lpZR3Lrb12WgjNq6joi2iiA
	 j6BwLYBXmCO1w==
Date: Fri, 2 May 2025 08:39:41 -1000
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v8 0/2] memcg: Fix test_memcg_min/low test failures
Message-ID: <aBURbZD1ZpIUPt64@slm.duckdns.org>
References: <20250502010443.106022-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250502010443.106022-1-longman@redhat.com>

On Thu, May 01, 2025 at 09:04:41PM -0400, Waiman Long wrote:
> v8:
>  - Ignore the low event count of child 2 with memory_recursiveprot on
>    in patch 1 as originally suggested by Michal.
> 
> v7:
>  - Skip the vmscan change as the mem_cgroup_usage() check for now as
>    it is currently redundant.
> 
> v6:
>  - The memcg_test_low failure is indeed due to the memory_recursiveprot
>    mount option which is enabled by default in systemd cgroup v2 setting.
>    So adopt Michal's suggestion to adjust the low event checking
>    according to whether memory_recursiveprot is enabled or not.
> 
> The test_memcontrol selftest consistently fails its test_memcg_low
> sub-test (with memory_recursiveprot enabled) and sporadically fails
> its test_memcg_min sub-test. This patchset fixes the test_memcg_min
> and test_memcg_low failures by adjusting the test_memcontrol selftest
> to fix these test failures.
> 
> Waiman Long (2):
>   selftests: memcg: Allow low event with no memory.low and
>     memory_recursiveprot on
>   selftests: memcg: Increase error tolerance of child memory.current
>     check in test_memcg_protection()

Acked-by: Tejun Heo <tj@kernel.org>

Probably best to go through -mm? If cgroup would be better, please let me
know.

Thanks.

-- 
tejun

