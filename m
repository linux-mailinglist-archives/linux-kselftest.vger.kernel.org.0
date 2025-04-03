Return-Path: <linux-kselftest+bounces-30071-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A319DA7A7AE
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Apr 2025 18:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21F1F18904E1
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Apr 2025 16:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A9E2512C0;
	Thu,  3 Apr 2025 16:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dINPapUH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DCB223708;
	Thu,  3 Apr 2025 16:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743696917; cv=none; b=LbzpPYyXytEJMfvf1aa1h7Cs5Gow+An34WmfH08uzlTGbc9SbRwxyOVXPEmahUb0S77psMk9wwb39HF+HUF9nW5GR1/DNwXylR8pTAyFczZlNG/O5+J4UBsIX+FUdZi58bz04GYPiYXOfSzZiRk5gGnKVs4MsFYZu1lveJD0olg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743696917; c=relaxed/simple;
	bh=z/dr+HxZ5s1Xkt0TYhRvQEgeAL2nEwsNt/AN9f2tRoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KHqI8y+RhQnQmAlvGoE3fwDSCmCqC4tKi/RagWa14hXrsvIC0uWxOkrc5CuhdLpPfu0bu4qz2pw6CzNjRN/w5PVHc8LJ7vODaO/bM4a1mhEa8enUhf4Eed5TukeCI1bLp9hjGze5KZWBs0fHevsH7DRpz5RHJ0VIb8D32GC+qbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dINPapUH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB4E5C4CEE3;
	Thu,  3 Apr 2025 16:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743696914;
	bh=z/dr+HxZ5s1Xkt0TYhRvQEgeAL2nEwsNt/AN9f2tRoA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dINPapUHBWgp6N0BwPS4qM+caQW/7mrWzJQgcs2xXMITStkF0Ddnjn8dBN4Q7FZbo
	 4uwYzdSPHDY/jK93YGrR+1lOmmT+GNm61hslq2Q6jossk31FAdR/mMf74zgU945VIv
	 CgcYj3TjGnG3xKT3MIQRkn5XuooADRXFDKMXpdzlGDd6XZZ1HZ7AvDlEqXV+zioW7c
	 EsLfk43Q6jt0o+bu5ZrpRDivNUVQllt8qZPS6ficx5gnZ1yFjDL0TaXMP8k1fv1LRq
	 5K5WpANpFyBDz2Lu+wEY23yySI7CahoahqTiCBJ+w8vqL05tRw1Nm15wm+yJZ3N+z2
	 sxgDFEzO88wHQ==
Date: Thu, 3 Apr 2025 06:15:13 -1000
From: Tejun Heo <tj@kernel.org>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: Waiman Long <longman@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>,
	Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 01/10] cgroup/cpuset: Fix race between newly created
 partition and dying one
Message-ID: <Z-60Ec41f8cQayOg@slm.duckdns.org>
References: <20250330215248.3620801-1-longman@redhat.com>
 <20250330215248.3620801-2-longman@redhat.com>
 <Z-zsGazxeHK9uaA6@slm.duckdns.org>
 <hsbn4pcb6gpipjfacn7tbutheolot6rfia2j6nyit3bpf4adys@mpaop37aps55>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <hsbn4pcb6gpipjfacn7tbutheolot6rfia2j6nyit3bpf4adys@mpaop37aps55>

Hello,

On Thu, Apr 03, 2025 at 03:34:05PM +0200, Michal Koutný wrote:
> On Tue, Apr 01, 2025 at 09:49:45PM -1000, Tejun Heo <tj@kernel.org> wrote:
> > On Sun, Mar 30, 2025 at 05:52:39PM -0400, Waiman Long wrote:
> ...
> > > Add a new cpuset_css_killed() function to reset the partition state of
> > > a valid partition root if it is being killed.
> ...
> > 
> > Applied to cgroup/for-6.15-fixes.
> 
> To be on the same page -- Tejun, this is a mistaken message, right?
> css_killed callback is unoptimal way to go.

I couldn't think of a way which is substantially better and so did apply it.
I'm completely open to backtracking for a better idea.

Thanks.

-- 
tejun

