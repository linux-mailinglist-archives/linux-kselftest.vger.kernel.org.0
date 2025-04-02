Return-Path: <linux-kselftest+bounces-30011-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A80A78925
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Apr 2025 09:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 299587A57E3
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Apr 2025 07:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE1B2327A7;
	Wed,  2 Apr 2025 07:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y2rCDwF9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C222220E6E3;
	Wed,  2 Apr 2025 07:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743580186; cv=none; b=H31MWcIzoerWRBy+tqrxce9uTwQr7pN7pS9+zj3Oi+WayZgXC+krrMbqBc0d0XAyWjwfo1oIiZP8IQS1/Do424n6d18QSnbzL9W9ckkyb6KV0kapmqDST6RT5XreGaf7vxlR33ZrMwKVoWWXM2vQzEhDkCWNeQdWYhDx9EGcjPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743580186; c=relaxed/simple;
	bh=u9HKDWdKPmOemTxsFQ9btUD3Wrgam41mvMrBts7MGXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lJBUZ4LOzodBZLKJXfp0VCT5ZeYKu/OLZaG2tAQn2s6ZT3lqwbUy4nSJquizN/mQHT2nFItUzO+S6F+RtKHNIhSOx9uIOe0hVQ+Um4K2dLIZFKaCYfWWmLlvH+H7w66o3cVRnOm9tAOKCWt8Uul2mpONf8Iu/yJnr5AHCkRUReI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y2rCDwF9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BA5DC4CEDD;
	Wed,  2 Apr 2025 07:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743580186;
	bh=u9HKDWdKPmOemTxsFQ9btUD3Wrgam41mvMrBts7MGXY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y2rCDwF9vyCniKjVEcF0QNuoverj/TfxcghMBkvVZiWJKP5tK3+gura3RUUBTQOee
	 EmrxGaNKUmeRExXfDqYNKPvxhgu4j1QxrrxEw/cj1RBvjX9oXWJgGjFrY7sO0vas6W
	 qYj52AzSI4bpJ1SDH2zliaJpPyP5lM5EFQXFTZa0Mlm2K1zoi+t5qCq8+yRiyRkfOU
	 ZoZcyk3Mt5JUl3xlDxCxdXixxiNtops9gbSOgIaahAf9Ri3FWo0XEvbtJ35LDiwybB
	 yfllzsRs/jqfeNAGSP6FpucqFMCKOuloqCFRptqfug5ufC6Y+RExwenJmJj1ONs7eL
	 AWgA/w/ThZBVQ==
Date: Tue, 1 Apr 2025 21:49:45 -1000
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 01/10] cgroup/cpuset: Fix race between newly created
 partition and dying one
Message-ID: <Z-zsGazxeHK9uaA6@slm.duckdns.org>
References: <20250330215248.3620801-1-longman@redhat.com>
 <20250330215248.3620801-2-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250330215248.3620801-2-longman@redhat.com>

On Sun, Mar 30, 2025 at 05:52:39PM -0400, Waiman Long wrote:
> There is a possible race between removing a cgroup diectory that is
> a partition root and the creation of a new partition.  The partition
> to be removed can be dying but still online, it doesn't not currently
> participate in checking for exclusive CPUs conflict, but the exclusive
> CPUs are still there in subpartitions_cpus and isolated_cpus. These
> two cpumasks are global states that affect the operation of cpuset
> partitions. The exclusive CPUs in dying cpusets will only be removed
> when cpuset_css_offline() function is called after an RCU delay.
> 
> As a result, it is possible that a new partition can be created with
> exclusive CPUs that overlap with those of a dying one. When that dying
> partition is finally offlined, it removes those overlapping exclusive
> CPUs from subpartitions_cpus and maybe isolated_cpus resulting in an
> incorrect CPU configuration.
> 
> This bug was found when a warning was triggered in
> remote_partition_disable() during testing because the subpartitions_cpus
> mask was empty.
> 
> One possible way to fix this is to iterate the dying cpusets as well and
> avoid using the exclusive CPUs in those dying cpusets. However, this
> can still cause random partition creation failures or other anomalies
> due to racing. A better way to fix this race is to reset the partition
> state at the moment when a cpuset is being killed.
> 
> Introduce a new css_killed() CSS function pointer and call it, if
> defined, before setting CSS_DYING flag in kill_css(). Also update the
> css_is_dying() helper to use the CSS_DYING flag introduced by commit
> 33c35aa48178 ("cgroup: Prevent kill_css() from being called more than
> once") for proper synchronization.
> 
> Add a new cpuset_css_killed() function to reset the partition state of
> a valid partition root if it is being killed.
> 
> Fixes: ee8dde0cd2ce ("cpuset: Add new v2 cpuset.sched.partition flag")
> Signed-off-by: Waiman Long <longman@redhat.com>

Applied to cgroup/for-6.15-fixes.

Thanks.

-- 
tejun

