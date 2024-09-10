Return-Path: <linux-kselftest+bounces-17654-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A817A97446E
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 23:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64694282BE6
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2024 21:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0595186E4C;
	Tue, 10 Sep 2024 21:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YysRfCfC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F361F951;
	Tue, 10 Sep 2024 21:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726002068; cv=none; b=mB8ny3Lf7i57kDYQRKVm2psScQZdx+KSmgmgyNFI8OO56Kc8NQDdGZmLXxo1SvXOSqppHo6ANB0lXvy5hhy4xGmoYV91ZtU2a1YMAqJSJB47dTafi37BXVOCv6gVpYSUSQnu2J7IdV//Z+ucCul/HeHpBkJQUNzFRpu+K8UBJC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726002068; c=relaxed/simple;
	bh=XAhD9zZ7L6FTk+v1v095phD9725qTz69L10DWWYy8iY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P8r1B7a7K4blNyJWddz55PjtLCBUDB1ZmLfkG+SFsfUwFoQLB1ZpUz5n4MEppW1cxJi8S37Brz8+hVwEd/cwE1Xqv8ee3rnONj+GGMVO01iClxkbhqEnsjkZp2yDqtzVgORJ9nHEMgosbY72kod4FhPN9SYpGd3cTWdDQ+spSUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YysRfCfC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2308C4CECE;
	Tue, 10 Sep 2024 21:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726002068;
	bh=XAhD9zZ7L6FTk+v1v095phD9725qTz69L10DWWYy8iY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YysRfCfCqj803oDGpS3HrkfypgycjS93+bW8iiPe7b2klFpy24pEJKZZJNSOQGvFJ
	 jtpGzyI7SuO1QwSLzM1w3sBDygVo2iXQZk/YtOKv0TjxeP33T/A3XhjVMnwtFeYXoC
	 TYkjj2ZV4a5Bh3pSdNrd66nxQCztEcJ/LXWVI2gzjNdIu9BrzD8tJiwE45Vlj21q4w
	 1Zy9Wo96R6tsr93VdFC4kO331kUPm8iS+ng9rj4cNEgVsubd9cqsptbl4w+Xfaz2Ym
	 ZkzlFdx+NXPFmk9NJp1wYiZvcPzZGreAbSBN4x8fZpUhib/QN+rN5RLsLHBBQwL+uN
	 /ebHlndc9FPjg==
Date: Tue, 10 Sep 2024 11:01:07 -1000
From: Tejun Heo <tj@kernel.org>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>, cgroups@vger.kernel.org,
	hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, lizefan.x@bytedance.com,
	shuah@kernel.org
Subject: Re: [PATCH v2 0/2] Exposing nice CPU usage to userspace
Message-ID: <ZuCzk2CsLGAliHzQ@slm.duckdns.org>
References: <20240830141939.723729-1-joshua.hahnjy@gmail.com>
 <mhugflcvgtv2iwyz2i63dkteur3xhnqn5qi37gzwc7mkt4sfn7@32kenf3bnhzf>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <mhugflcvgtv2iwyz2i63dkteur3xhnqn5qi37gzwc7mkt4sfn7@32kenf3bnhzf>

Hello, Michal.

On Mon, Sep 02, 2024 at 05:45:39PM +0200, Michal Koutný wrote:
> - It makes (some) sense only on leave cgroups (where variously nice'd
>   tasks are competing against each other). Not so much on inner node
>   cgroups (where it's a mere sum but sibling cgroups could have different
>   weights, so the absolute times would contribute differently).
>
> - When all tasks have nice > 0 (or nice <= 0), it loses any information
>   it could have had.

I think it's as useful as system-wide nice metric is. It's not a versatile
metric but is widely available and understood and people use it. Maybe a
workload is split across a sub-hierarchy and they wanna collect how much
lowpri threads are consuming. cpu.stats is available without cpu control
being enabled and people use it as a way to just aggregate metrics across a
portion of the system.

> (Thus I don't know whether to commit to exposing that value via cgroups.)
> 
> I wonder, wouldn't your use case be equally served by some
> post-processing [1] of /sys/kernel/debug/sched/debug info which is
> already available?
...
> above is only for CPU nr=0. So processing would mean sampling that file
> over all CPUs and time.

I think there are benefits to mirroring system wide metrics, at least ones
as widely spread as nice.

Thanks.

-- 
tejun

