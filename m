Return-Path: <linux-kselftest+bounces-27826-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3CEDA49088
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 05:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 209E37A85AC
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Feb 2025 04:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862981ADC9D;
	Fri, 28 Feb 2025 04:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vy8h4olE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70781ADC74
	for <linux-kselftest@vger.kernel.org>; Fri, 28 Feb 2025 04:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740718328; cv=none; b=obuTET7IVtSExHI3Zc8Zx1knoDxf/OAYrVaqoKgrP/gUzwM2R9xHxU4IdT6x6EYWwSlkWIs2/Ta7yYD6Frq9BUtgt4CgcsrBRkiKVCWlDBqQbt+AB/h69mVdnwqfc+Y48R8QPJp2aKaxheaJfBOxCmym/vLe9D4c6E/iWFMyMjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740718328; c=relaxed/simple;
	bh=73nSXngxlZGhX0vHAAQJipqxUw4pAugls4rsyVKjJhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kdqzfv3CM4eGufQBBU3sXcnDukJfY9+Enok6p1zSVDN1frGIYFvRNnyo7pq4+fa858IBgmjggmkZhajUFmzzXHI3H3OvbS1nxXanIHEtXn4ZXplvbV8oiEz/vxBaf+skgsE9wODCP6HIR9rGonBvwjNDWrQBcFHKGAKFY6ewygM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vy8h4olE; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 28 Feb 2025 12:51:42 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740718313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=myBegHys+6qADaBlem5dsLoO+LlbMZzr9bJVqBIXs+w=;
	b=vy8h4olEO5qTuG4g9762xU8ZKNh+YSilxn7mHsz8DkcufmyZCpp/WQT6fj2IOAdC//U/iZ
	18u1C1WUaCFXytAS+/mozbXdkLwr3NFXfS4Z97OmXRwFdl25ju4ZB7kqVwNyRMyt275lHr
	vIlsr4pPeUGLxc5pdc6vyeMvl6/L6O8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: John Fastabend <john.fastabend@gmail.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, cong.wang@bytedance.com, 
	jakub@cloudflare.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, andrii@kernel.org, eddyz87@gmail.com, 
	mykolal@fb.com, ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, mhal@rbox.co, 
	sgarzare@redhat.com, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, mrpre@163.com
Subject: Re: [PATCH bpf-next v1 2/3] selftests/bpf: Add socketpair to
 create_pair to support unix socket
Message-ID: <lk2bgh3pmpgch2n5yfjiyhak66oty3cndhbasnpfn2x457rv7i@mvpb4ctmypxh>
References: <20250226132242.52663-1-jiayuan.chen@linux.dev>
 <20250226132242.52663-3-jiayuan.chen@linux.dev>
 <Z8DCZO8n39avsvnF@pop-os.localdomain>
 <20250227222141.mnvpmnvafisd2pjk@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227222141.mnvpmnvafisd2pjk@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 27, 2025 at 02:21:41PM -0800, John Fastabend wrote:
> On 2025-02-27 11:52:04, Cong Wang wrote:
> > On Wed, Feb 26, 2025 at 09:22:41PM +0800, Jiayuan Chen wrote:
> > > Current wrapper function create_pair() is used to create a pair of
> > > connected links and returns two fds, but it does not support unix sockets.
> > > 
> > > Here we introduce socketpair() into create_pair(), which supports creating
> > > a pair of unix sockets, since the semantics of the two are the same.
> > 
> > Since it is only for UDS and only has effectively 1 line of code, how
> > about just calling socketpair(AF_UNIX) in your patch 3/3?
> 
> If we run that test with more than AF_UNIX it might be best as is. I
> think there might be some value testing that flow on TCP/UDP even if
> its not related to the bug.
> 
> Thanks,
> John
Thanks, John! I'll make selftest cover more types of sockets.

