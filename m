Return-Path: <linux-kselftest+bounces-14891-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A591949B5C
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 00:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8CE9281898
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 22:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5BF5171098;
	Tue,  6 Aug 2024 22:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SFifop10"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B4E77F08;
	Tue,  6 Aug 2024 22:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722983799; cv=none; b=PYfOOVOYsuK/Qtz7FKTpNrsEqR2B5O/C4g23UU2+4Jh5MxXhgzDLQCLBIgG2mhr79rmqtk/jVJ2pslJVcgCMJ6HBYCZXu0SxXix3fAOu8qA6Y92SKNbD42jpd3z/MSY07/z5FHASNGiyKSDtRqllkcsgRqEOJSdzixvUAcVYLgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722983799; c=relaxed/simple;
	bh=PAlV09qvEwZ1jZlVGjPzhfejB6qpRR8rsMaenH13gP0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=FhNX7cP/gTGAjkl9t753KUvi2ETVlg0mVpybqNAXOLeq6gkehasKFuGsN313ljBLsYrbLYUos/brJJV0/c4rbX0c3xoR2XeDFzokZNdVSlXQzXFSDfVVFmX4qhDluSZPkuHGEHPINJsjJqBaoMgk2e1hQpHr46UESUNgqFTlxHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SFifop10; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B08FC32786;
	Tue,  6 Aug 2024 22:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1722983798;
	bh=PAlV09qvEwZ1jZlVGjPzhfejB6qpRR8rsMaenH13gP0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SFifop10KUd+U0OWJeE8gRsUQiKirUVAVAJ31rl/YPKOBbH5SHB8MWzVXDnnX/uSR
	 SmrISqZ65OdSBGw5Uzz7xZOOZDDhuwKyjXsCky1gzD5RcAlkWtUVHdiYc0WNkGFXUL
	 azUOvNxuwvb+o4txTSN6vl569Tkb2akDyT3a5JNo=
Date: Tue, 6 Aug 2024 15:36:37 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Tejun Heo <tj@kernel.org>
Cc: David Finkel <davidf@vimeo.com>, Muchun Song <muchun.song@linux.dev>,
 Roman Gushchin <roman.gushchin@linux.dev>, core-services@vimeo.com,
 Jonathan Corbet <corbet@lwn.net>, Michal Hocko <mhocko@kernel.org>, Shakeel
 Butt <shakeel.butt@linux.dev>, Shuah Khan <shuah@kernel.org>, Johannes
 Weiner <hannes@cmpxchg.org>, Zefan Li <lizefan.x@bytedance.com>,
 cgroups@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, Michal =?UTF-8?B?S291dG7DvQ==?=
 <mkoutny@suse.com>
Subject: Re: [PATCH v7] mm, memcg: cg2 memory{.swap,}.peak write handlers
Message-Id: <20240806153637.4549ee6c1d1300042dd01c4c@linux-foundation.org>
In-Reply-To: <ZrKFJyADBI_cLdX4@slm.duckdns.org>
References: <20240730231304.761942-1-davidf@vimeo.com>
	<CAFUnj5Nq_UwZUy9+i-Mp+TDghQWUX7MHpmh8uDTH790HAH2ZNA@mail.gmail.com>
	<ZrKFJyADBI_cLdX4@slm.duckdns.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 6 Aug 2024 10:18:47 -1000 Tejun Heo <tj@kernel.org> wrote:

> On Tue, Aug 06, 2024 at 04:16:30PM -0400, David Finkel wrote:
> > On Tue, Jul 30, 2024 at 7:13 PM David Finkel <davidf@vimeo.com> wrote:
> > >
> > > This revision only updates the tests from the previous revision[1], and
> > > integrates an Acked-by[2] and a Reviewed-By[3] into the first commit
> > > message.
> > >
> > >
> > > Documentation/admin-guide/cgroup-v2.rst          |  22 ++-
> > > include/linux/cgroup-defs.h                      |   5 +
> > > include/linux/cgroup.h                           |   3 +
> > > include/linux/memcontrol.h                       |   5 +
> > > include/linux/page_counter.h                     |  11 +-
> > > kernel/cgroup/cgroup-internal.h                  |   2 +
> > > kernel/cgroup/cgroup.c                           |   7 +
> > > mm/memcontrol.c                                  | 116 +++++++++++++--
> > > mm/page_counter.c                                |  30 +++-
> > > tools/testing/selftests/cgroup/cgroup_util.c     |  22 +++
> > > tools/testing/selftests/cgroup/cgroup_util.h     |   2 +
> > > tools/testing/selftests/cgroup/test_memcontrol.c | 264 ++++++++++++++++++++++++++++++++-
> > > 12 files changed, 454 insertions(+), 35 deletions(-)
> ...
> > Tejun or Andrew,
> > 
> > This change seems to have stalled a bit.
> > Are there any further changes necessary to get this patch merged into
> > a staging branch so it's ready for 6.12?
> 
> Oh, it sits between cgroup core and memcg, so I guess it wasn't clear who
> should take it. Given that the crux of the change is in memcg, I think -mm
> would be a better fit. Andrew, can you please take these patches? FWIW,

I took 'em on Aug 4.  David, your spam folder beckons?

>  Acked-by: Tejun Heo <tj@kernel.org>

Added, thanks.

