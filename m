Return-Path: <linux-kselftest+bounces-46921-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 23189C9D4F6
	for <lists+linux-kselftest@lfdr.de>; Wed, 03 Dec 2025 00:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E772A4E4D24
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Dec 2025 23:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2CD27FD4A;
	Tue,  2 Dec 2025 23:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EapuCEfR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454052BE033
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Dec 2025 23:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764717140; cv=none; b=gR1XrnCOHpoqEPAC3N2MaQJeBnC3F/MXR6MLcVGIdH5kKDA1uAfseeXfdbx1K1cucRLF5W9EtsI23gxHET2PwJKiwSbO3KR+I0/yCGgCiadhuMpzy3WOdn4gGriYerQRilZy/VxST0rMc6LMWGkylCSTS/UiTmGr+EG/i9syyiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764717140; c=relaxed/simple;
	bh=75sSCBtRGy5T5ufmiL9hJBrzyTcEKxK0WYe8fYYV+QA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=edvxniFQdl8DcEYBc0jprPvrgR2wW+nERzGKrTMs1OUtpD/lG/SlmJeL125aLmCi/jOJK+wpdG+0mv6+GDD1n9Gr8+UA6jcRWpE/RGIm4PbAQPNEtJOKF0TaYUa0QfpkSW0/KZ1Bsj5EdAm4n0uAVmSZEBR8YVED2frBMOs1lKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EapuCEfR; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 2 Dec 2025 15:12:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764717125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+xnFBORuZ6ngaKR/uhhUBVVKjmGvNc8Ti2cvoD5Olcc=;
	b=EapuCEfRnurnBKjqKLc5ANQkfN4J4DSkmrrhz+Liy72uoxFYzKLxAYfz+62OE9BOc+njH0
	wZRwK0Bfe7cYfr3vEOvKMZotyrQoiISFRTZas6ZPXAWGPM2H18OdkivEJW9Z6QQI3AOv2S
	PE2U/Plr9Bk2q1hlkeYIOf+VpbORRYE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Guopeng Zhang <zhangguopeng@kylinos.cn>
Cc: tj@kernel.org, hannes@cmpxchg.org, mhocko@kernel.org, 
	roman.gushchin@linux.dev, mkoutny@suse.com, muchun.song@linux.dev, lance.yang@linux.dev, 
	shuah@kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] selftests: cgroup: make test_memcg_sock robust
 against delayed sock stats
Message-ID: <me7djjzkgufieiyvrsbezi4i4t6v5zsbonirjlacce6hgilb2c@sxnifdeh2gnv>
References: <20251124123816.486164-1-zhangguopeng@kylinos.cn>
 <20251124123816.486164-3-zhangguopeng@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251124123816.486164-3-zhangguopeng@kylinos.cn>
X-Migadu-Flow: FLOW_OUT

On Mon, Nov 24, 2025 at 08:38:15PM +0800, Guopeng Zhang wrote:
> test_memcg_sock() currently requires that memory.stat's "sock " counter
> is exactly zero immediately after the TCP server exits. On a busy system
> this assumption is too strict:
> 
>   - Socket memory may be freed with a small delay (e.g. RCU callbacks).
>   - memcg statistics are updated asynchronously via the rstat flushing
>     worker, so the "sock " value in memory.stat can stay non-zero for a
>     short period of time even after all socket memory has been uncharged.
> 
> As a result, test_memcg_sock() can intermittently fail even though socket
> memory accounting is working correctly.
> 
> Make the test more robust by polling memory.stat for the "sock "
> counter and allowing it some time to drop to zero instead of checking
> it only once. The timeout is set to 3 seconds to cover the periodic
> rstat flush interval (FLUSH_TIME = 2*HZ by default) plus some
> scheduling slack. If the counter does not become zero within the
> timeout, the test still fails as before.
> 
> On my test system, running test_memcontrol 50 times produced:
> 
>   - Before this patch:  6/50 runs passed.
>   - After this patch:  50/50 runs passed.
> 
> Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
> Suggested-by: Lance Yang <lance.yang@linux.dev>
> ---
>  .../selftests/cgroup/test_memcontrol.c        | 20 ++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
> index 4e1647568c5b..dda12e5c6457 100644
> --- a/tools/testing/selftests/cgroup/test_memcontrol.c
> +++ b/tools/testing/selftests/cgroup/test_memcontrol.c
> @@ -21,6 +21,8 @@
>  #include "kselftest.h"
>  #include "cgroup_util.h"
>  
> +#define MEMCG_SOCKSTAT_WAIT_RETRIES        30              /* 3s total */

No need for the comment at the end as it will be stale when someone
change DEFAULT_WAIT_INTERVAL_US in future.

Anyways it's a nit.

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

