Return-Path: <linux-kselftest+bounces-3236-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC7483279A
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jan 2024 11:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50F411F24340
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Jan 2024 10:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6E73C473;
	Fri, 19 Jan 2024 10:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tUnyka1z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C352D3C693;
	Fri, 19 Jan 2024 10:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705659875; cv=none; b=Ee9QJKCx0km0WBg/+7oI1oSGStf+tMf6QhHFMFMYAENUl6h13upBsyIsJhwVr6A+vtMnRYeKXAvmrsoCc3Vp7OOdcGt51oiZObO19yvwiB9NHHOty+Y5WHB0q8Rj7qQWX0ddWLLXHFAoh5Z/Bssy1LRX/3fgUbrpoDppoTNkRfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705659875; c=relaxed/simple;
	bh=1JTZbN5qh9CT0H6mxkpOji2eqTwX6brav/2vU7IADqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mmileMnakmbfjnRHiA5qOMQzPS7IV5Tp1e+w4owR/fC5Iis8Vr0HpnchHRm6A1PbevdKLFONqWS2fZS/kWUMzCFYOKybaLxqcSLONYvYFgWxWMFKBd3NR8fBlEs/nq6Vml0Z/PNRvnPdwzJreuHI7f2EJ2umvdOJoGahlMttOE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tUnyka1z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ABBAC433F1;
	Fri, 19 Jan 2024 10:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705659875;
	bh=1JTZbN5qh9CT0H6mxkpOji2eqTwX6brav/2vU7IADqY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=tUnyka1zdEsMcGr0V3gN/gUgHN0bguQ9TLw7nUFX/7fn6ybsx1BktWgGc0xNHLjl/
	 SvRzF8Gq9PfNJd02epxrJ5++PeV1VC6ajBQVcQIhd5Mm5mQIdnbWFm91ITdtFWfizo
	 yEBab6oTUeAjecNq/BAOSY7N2fjEY1/BOOrTNHDLqg9Z0Fd3hA5ZJrIAXiAZoKqZ9U
	 UqjZexiv/FLTaQStfc2v5R2bv0AFx169ErX7s2LMSPofJqGgOXxJr9GPH4cz+vEHoF
	 t8YN+FLBrbJjDWDEJu7rhvsz1ITB76G7ZUqCw2DrKZ9nspCJ8XbpA5G+5v11U7kgzU
	 HZwj1KeVkRZjw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C29F2CE114A; Fri, 19 Jan 2024 02:24:34 -0800 (PST)
Date: Fri, 19 Jan 2024 02:24:34 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Shuah Khan <shuah@kernel.org>,
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Mrunal Patel <mpatel@redhat.com>,
	Ryan Phillips <rphillips@redhat.com>,
	Brent Rowsell <browsell@redhat.com>, Peter Hunt <pehunt@redhat.com>,
	Cestmir Kalina <ckalina@redhat.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Alex Gladkov <agladkov@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>, Phil Auld <pauld@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Costa Shulyupin <cshulyup@redhat.com>
Subject: Re: [RFC PATCH 0/8] cgroup/cpuset: Support RCU_NOCB on isolated
 partitions
Message-ID: <ad806d7c-91ec-4659-9348-1b0bb42dd417@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240117163511.88173-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117163511.88173-1-longman@redhat.com>

On Wed, Jan 17, 2024 at 11:35:03AM -0500, Waiman Long wrote:
> This patch series is based on the RFC patch from Frederic [1]. Instead
> of offering RCU_NOCB as a separate option, it is now lumped into a
> root-only cpuset.cpus.isolation_full flag that will enable all the
> additional CPU isolation capabilities available for isolated partitions
> if set. RCU_NOCB is just the first one to this party. Additional dynamic
> CPU isolation capabilities will be added in the future.
> 
> The first 2 patches are adopted from Federic with minor twists to fix
> merge conflicts and compilation issue. The rests are for implementing
> the new cpuset.cpus.isolation_full interface which is essentially a flag
> to globally enable or disable full CPU isolation on isolated partitions.
> On read, it also shows the CPU isolation capabilities that are currently
> enabled. RCU_NOCB requires that the rcu_nocbs option be present in
> the kernel boot command line. Without that, the rcu_nocb functionality
> cannot be enabled even if the isolation_full flag is set. So we allow
> users to check the isolation_full file to verify that if the desired
> CPU isolation capability is enabled or not.
> 
> Only sanity checking has been done so far. More testing, especially on
> the RCU side, will be needed.

There has been some discussion of simplifying the (de-)offloading code
to handle only offline CPUs.  Along with some discussion of eliminating
the (de-)offloading capability altogehter.

We clearly should converge on the capability to be provided before
exposing this to userspace.  ;-)

							Thanx, Paul

> [1] https://lore.kernel.org/lkml/20220525221055.1152307-1-frederic@kernel.org/
> 
> Frederic Weisbecker (2):
>   rcu/nocb: Pass a cpumask instead of a single CPU to offload/deoffload
>   rcu/nocb: Prepare to change nocb cpumask from CPU-hotplug protected
>     cpuset caller
> 
> Waiman Long (6):
>   rcu/no_cb: Add rcu_nocb_enabled() to expose the rcu_nocb state
>   cgroup/cpuset: Better tracking of addition/deletion of isolated CPUs
>   cgroup/cpuset: Add cpuset.cpus.isolation_full
>   cgroup/cpuset: Enable dynamic rcu_nocb mode on isolated CPUs
>   cgroup/cpuset: Document the new cpuset.cpus.isolation_full control
>     file
>   cgroup/cpuset: Update test_cpuset_prs.sh to handle
>     cpuset.cpus.isolation_full
> 
>  Documentation/admin-guide/cgroup-v2.rst       |  24 ++
>  include/linux/rcupdate.h                      |  15 +-
>  kernel/cgroup/cpuset.c                        | 237 ++++++++++++++----
>  kernel/rcu/rcutorture.c                       |   6 +-
>  kernel/rcu/tree_nocb.h                        | 118 ++++++---
>  .../selftests/cgroup/test_cpuset_prs.sh       |  23 +-
>  6 files changed, 337 insertions(+), 86 deletions(-)
> 
> -- 
> 2.39.3
> 

