Return-Path: <linux-kselftest+bounces-18420-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FF8987966
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 20:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D9A2288EA0
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 18:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5AD17D378;
	Thu, 26 Sep 2024 18:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="exN51NmZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614E91D5ABC;
	Thu, 26 Sep 2024 18:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727376476; cv=none; b=GrsfuS4Olo4pjIbYe9DA4eAHhBBLBEXaOTQFdhWT/T5JkFIv8TcCrer6D2HhXyEPSMpIGzznMH76KWAmobCQNaxiognZTyVLsxxfPFt1N447Hd0AUNqmfbdKp+7u2gCDCcYdaA9bT6eO4mC68v5cYg2JoQvNJQglAZ3K3p6c6TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727376476; c=relaxed/simple;
	bh=wx5cbUajgmr75jwQwn38OR1kPMvcVyMlLv+3Jjq0igI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rjX97uQZ0sO4fEsSUsJhAqN1OLZphvWmh+Sz6QQXet3/731No3+nFBB8JEj1i0KtCK6CH9R/tFVom2TAZES8F5E0QVuXP1Ba/oP4GGAmGftGK9CAJYLlGncz6XQhg2cORZKB16Htp9jXK+Be/5Hf+mayenpIo5y6Xnk57rXqI/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=exN51NmZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA2B8C4CEC5;
	Thu, 26 Sep 2024 18:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727376475;
	bh=wx5cbUajgmr75jwQwn38OR1kPMvcVyMlLv+3Jjq0igI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=exN51NmZx5NnuKDwvJXXP1RAwhPBGMoZ6++JM8axXjk63taTp95p63pIuUl6YpYbt
	 P+wJKkLNKMKE/ieLISfIPOBXyFJj5KIVcNkDGWq6JM8DSf5iykg4RLOkBBcftm3MGz
	 M+KX2wmb/zcsrSpZYCC1G1rpRUnzo40rS/vphsRzp9H96SY5aFVas8NfJt/0C+rTiq
	 FcAWWLajpTu/xybrdI8XxNauVk+FsJ+ir/OENf5/J1ZvyBVfYzSrrMtLpdcP7+avoA
	 xauWkKxRlM/7L79s5JfAC/zrRUpAlJjcaUcbHv8TiIwCL/yEz2xjPbcIHPO89h4zdi
	 /+54D5Z3H61mw==
Date: Thu, 26 Sep 2024 08:47:54 -1000
From: Tejun Heo <tj@kernel.org>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>, cgroups@vger.kernel.org,
	hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, lizefan.x@bytedance.com,
	shuah@kernel.org
Subject: Re: [PATCH v3 0/2] Exposing nice CPU usage to userspace
Message-ID: <ZvWsWovtTgBi29D9@slm.duckdns.org>
References: <20240923142006.3592304-1-joshua.hahnjy@gmail.com>
 <qjbbaywlodoojlb5n3vavgck2jrffofnlzpf7pc5h7fsyu5y7o@oqh5vbuns7ve>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <qjbbaywlodoojlb5n3vavgck2jrffofnlzpf7pc5h7fsyu5y7o@oqh5vbuns7ve>

Hello, Michal.

On Thu, Sep 26, 2024 at 08:10:35PM +0200, Michal Koutný wrote:
...
> On Tue, Sep 10, 2024 at 11:01:07AM GMT, Tejun Heo <tj@kernel.org> wrote:
> > I think it's as useful as system-wide nice metric is.
> 
> Exactly -- and I don't understand how that system-wide value (without
> any cgroups) is useful.
> If I don't know how many there are niced and non-niced tasks and what
> their runnable patterns are, the aggregated nice time can have ambiguous
> interpretations.
> 
> > I think there are benefits to mirroring system wide metrics, at least
> > ones as widely spread as nice.
> 
> I agree with benefits of mirroring of some system wide metrics when they
> are useful <del>but not all of them because it's difficult/impossible to take
> them away once they're exposed</del>. Actually, readers _should_ handle
> missing keys gracefuly, so this may be just fine.
> 
> (Is this nice time widely spread? (I remember the field from `top`, still
> not sure how to use it.) Are other proc_stat(5) fields different?

A personal anecdote: I usually run compile jobs with nice and look at the
nice utilization to see what the system is doing. I think it'd be simliar
for most folks. Because the number has always been there and ubiqutous
across many monitoring tools, people end up using it for something. It's not
a great metric but a long-standing and widely available one, so it ends up
with usages.

BTW, there are numbers which are actively silly - e.g. iowait, especially
due to how it gets aggregated across multiple CPUs. That, we want to
actively drop especially as the pressure metrics is the better substitute. I
don't think nice is in that category. It's not the best metric there is but
not useless or misleading.

> I see how this can be the global analog on leaf cgroups but
> interpretting middle cgroups with children of different cpu.weights?)

I think aggregating per-thread numbers is the right thing to do. It's just
sum of CPU cycles spent by threads which got niced.

Thanks.

-- 
tejun

