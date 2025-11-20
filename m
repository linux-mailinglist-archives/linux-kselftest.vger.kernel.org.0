Return-Path: <linux-kselftest+bounces-46062-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B38C7243C
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 06:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6C91C4E2D27
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 05:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A662FE567;
	Thu, 20 Nov 2025 05:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sYdhT5dU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78232FFDE6
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Nov 2025 05:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763617255; cv=none; b=t/vkGGyCzT0o/Z+mdcxoUztdAH/Ikzz9foIeCznzP6Zw2Of3ECAJWWpb3vthOs1p2/xP+NRgsy+Ht1tJ7pio7kc0RIHxc6zcd4KqOf/2BiAg8uNnIH0ywOtFeBLkNYLyXi+Pr9jUA0rmPIL3wSq9ggaaAPlwXJYX6C1T5ApB+qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763617255; c=relaxed/simple;
	bh=OrHr5OBA3hTwt7niZUu05PDAmRnp8lU0IfHJTEIJMbM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N/ygvoC+VDiKkaYzaGwiaqq+6nOJSFU394vDWLLNT4vRCtyYKFshPcI5cwrHct9H2BP/it2VLoAGFaNjtTzpzROZeBT/RRoPljL4LG5HNZAos7sS3YOy3uE9b4e34JJ8qPxkKjX80ubtzI+LTzlTlI9sx4utxSnl6nEGjmRITRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sYdhT5dU; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5ad2b75f-748a-4e93-8d11-63295bda0cbf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763617249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ij3CZTiXFrpU/rmr2/hRZVBLGTLP5tsrztxvPsm3IUM=;
	b=sYdhT5dU3FtwgTHC76n+k9PosD+C5XAY0ZmggWmW7CL9+DmYwksSch3iIvZ/go5zudOmyE
	6b70vhIA2aOFm/CP3jMFG4xNhLKrwRvbcJfOCIxi1clOauRoJlMyM+UT6wm9hkc5nZhIuK
	D1adzO2n/rYet5pAyLAcoq8mTPdkBvY=
Date: Thu, 20 Nov 2025 13:40:34 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] selftests: cgroup: make test_memcg_sock robust against
 delayed sock stats
Content-Language: en-US
To: Guopeng Zhang <zhangguopeng@kylinos.cn>
Cc: shuah@kernel.org, mkoutny@suse.com, linux-mm@kvack.org,
 muchun.song@linux.dev, linux-kselftest@vger.kernel.org,
 shakeel.butt@linux.dev, linux-kernel@vger.kernel.org, tj@kernel.org,
 hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev
References: <20251120031619.1828911-1-zhangguopeng@kylinos.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20251120031619.1828911-1-zhangguopeng@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/11/20 11:16, Guopeng Zhang wrote:
> test_memcg_sock() currently requires that memory.stat's "sock " counter
> is exactly zero immediately after the TCP server exits. On a busy system
> this assumption is too strict:
> 
>    - Socket memory may be freed with a small delay (e.g. RCU callbacks).
>    - memcg statistics are updated asynchronously via the rstat flushing
>      worker, so the "sock " value in memory.stat can stay non-zero for a
>      short period of time even after all socket memory has been uncharged.
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
>    - Before this patch:  6/50 runs passed.
>    - After this patch:  50/50 runs passed.
> 
> Suggested-by: Lance Yang <lance.yang@linux.dev>
> Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
> ---
> v2:
>   - Mention the periodic rstat flush interval (FLUSH_TIME = 2*HZ) in
>     the comment and clarify the rationale for the 3s timeout.
>   - Replace the hard-coded retry count and wait interval with macros
>     to avoid magic numbers and make the 3s timeout calculation explicit.
> ---
>   .../selftests/cgroup/test_memcontrol.c        | 30 ++++++++++++++++++-
>   1 file changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
> index 4e1647568c5b..7bea656658a2 100644
> --- a/tools/testing/selftests/cgroup/test_memcontrol.c
> +++ b/tools/testing/selftests/cgroup/test_memcontrol.c
> @@ -24,6 +24,9 @@
>   static bool has_localevents;
>   static bool has_recursiveprot;
>   
> +#define MEMCG_SOCKSTAT_WAIT_RETRIES        30              /* 3s total */
> +#define MEMCG_SOCKSTAT_WAIT_INTERVAL_US    (100 * 1000)    /* 100 ms */

Nit: Defines are usually placed at the top of the file (e.g., after the
#include block). Placing them between global variables and functions
looks a bit out of place, IMHO ...
Otherwise, feel free to add:

Reviewed-by: Lance Yang <lance.yang@linux.dev>
[...]

Cheers,
Lance

