Return-Path: <linux-kselftest+bounces-38597-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C90EB1EC62
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 17:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7E683B5A36
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 15:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C51F285CA7;
	Fri,  8 Aug 2025 15:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3N08WGA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644CA277016;
	Fri,  8 Aug 2025 15:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754668212; cv=none; b=CHsG/ayag951KpNL96tWepuQY3/xZrH21vR4jBBzJumj1bhENTv1PaRy/lVX36FRcDeKDjad9iimAecQOfBiNvZ5lSyz/qZabAq8bSXlUj319oX72LB2we/spIg3iRLCjgq5yUrJ5/il9RYIxpVdwHbI8Y9ewPNcUxoja/x4D4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754668212; c=relaxed/simple;
	bh=Fn13LnOkMLX97otRtesVk7OTraqlk5v2xVlghm+sXjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P+mZDKYEATchViSfLZhg5hClJxv2FrOhMKVD1LUwkVR1IWtrul7SbMA5H+mOsj+8j4i+qIFuQ3sxzrBP1zmzWbmt8wZDfWStC44cvrjxeY3j4A73wCtjUW2YE8hjLSAHZogp6lnaTunjh7hC2zRTv7KeCJZJ+IOP3SUvVEHCH4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G3N08WGA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F73EC4CEED;
	Fri,  8 Aug 2025 15:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754668211;
	bh=Fn13LnOkMLX97otRtesVk7OTraqlk5v2xVlghm+sXjQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G3N08WGAjIBlgU8eYjkiXU4FoSp9IQUU06tvK1XaWuYpVwRsqsttAs+659bFTPuXS
	 +auLx87cNatKO5EzQ0I9q5/k1ih0wlMU3MwUYYP3uf1+SJ0XeYnfT2k8Sa/FpZhdDU
	 z+9Yp47zXwejNZm+gIwsLY0ReTmY8eRwC3FdkHXXMvUQNg3o9cEtQqEkYwamwTwE96
	 GED6qrhP4zbsQeXOf/kf/CiUraKjA3WghO80D2v7GEbTa7WoPlQ1Y4jH1LUUClaNK4
	 Jg0Rzff93HXLu3AWlyJRY8Ph6O/RmMgpcSJbIEYZk2jNSDZ0Trq0FBGxTSqgVkjuq9
	 UHUWIgdWk08mA==
Date: Fri, 8 Aug 2025 17:50:09 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Phil Auld <pauld@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Cestmir Kalina <ckalina@redhat.com>
Subject: Re: [RFC PATCH 00/18] cgroup/cpuset: Enable runtime modification of
Message-ID: <aJYcsXEiFmCmDAjz@localhost.localdomain>
References: <20250808151053.19777-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250808151053.19777-1-longman@redhat.com>

Le Fri, Aug 08, 2025 at 11:10:44AM -0400, Waiman Long a écrit :
> The "nohz_full" and "rcu_nocbs" boot command parameters can be used to
> remove a lot of kernel overhead on a specific set of isolated CPUs which
> can be used to run some latency/bandwidth sensitive workloads with as
> little kernel disturbance/noise as possible. The problem with this mode
> of operation is the fact that it is a static configuration which cannot
> be changed after boot to adjust for changes in application loading.
> 
> There is always a desire to enable runtime modification of the number
> of isolated CPUs that can be dedicated to this type of demanding
> workloads. This patchset is an attempt to do just that with an amount of
> CPU isolation close to what can be done with the nohz_full and rcu_nocbs
> boot kernel parameters.
> 
> This patch series provides the ability to change the set of housekeeping
> CPUs at run time via the cpuset isolated partition functionality.
> Currently, the cpuset isolated partition is able to disable scheduler
> load balancing and the CPU affinity of the unbound workqueue to avoid the
> isolated CPUs. This patch series will extend that with other kernel noises
> associated with the nohz_full boot command line parameter which has the
> following sub-categories:
>   - tick
>   - timer
>   - RCU
>   - MISC
>   - WQ
>   - kthread

Thanks for working on that, I'm about to leave for 2 weeks vacation so I
won't have the time to check this until I'm back.

However this series is highly conflicting with mine (cpuset/isolation: Honour
kthreads preferred affinity). Your patchset even redoes things I'm doing
(housekeeping cpumask update, RCU synchronization, HK_TYPE_DOMAIN to include
cpusets, etc...)

I have a v2 that is almost ready to post.

Wouldn't it be better to wait for it and its infrastructure changes before
proceeding with nohz_full?

Thanks.

-- 
Frederic Weisbecker
SUSE Labs

