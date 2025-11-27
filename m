Return-Path: <linux-kselftest+bounces-46626-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 488D8C8DDA9
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 11:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A78CF4E2A8E
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Nov 2025 10:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CCA32AADA;
	Thu, 27 Nov 2025 10:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="s14P8P0P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA23C17BA2
	for <linux-kselftest@vger.kernel.org>; Thu, 27 Nov 2025 10:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764240963; cv=none; b=FO8MuLFdEWkYUNe8abZsue7wRTurn5i0NxZhf4pgOgpR41d2d6cPio0TSeDWRu34TWtxEHmALzNkvmkU0Cu4dDyWRWq7/uAY4/3TrhCq4bCS512FgdQtIXrTEZfJVBOo9ibXenfl/iOij/W0mMLGIuh9h1DkoWdbxX7WCJwpI6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764240963; c=relaxed/simple;
	bh=GihA3TSisrEJ4oaVp1bQ7dvj9cWX30pNUjBYyGJcSms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q16LYnIebtJ3ePY1aq9kb9PmmLyIFnXpvfjNGITQkZlDI6yrdP0pj2d0a0C97Fsqy8MjlJlFEhphN1dMGBitlc+APtf3lGmF4tPB9og4fR0UCwTbzzzeBzSIDIpp2jYPHcTrZM0QYFNb+902t1+SEEwvQgIXWo1Oj2Ac2ywWnoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=s14P8P0P; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8ce13061-b4a7-4474-9e57-bab9b1a62b63@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764240946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iRVmjU/Y9Gn+2pqu0CVyrzRMl+J5d/ZiDNk/GmUSLQY=;
	b=s14P8P0PJE11i12hs9kRxZwk7rjf9SBW1ODcAc4YQFqTE6LZUBuEpDAR6JPzETINtrrFQ3
	S5YbMm0FgUEPkxoGwgSnRAshddGklYK3rA/KTAjm8rjln78PtplcUINUcZkF16B/wBYgDU
	v6UPh/nTm3GriJ0S3zaMsz3hCNRFJ9E=
Date: Thu, 27 Nov 2025 18:55:37 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 2/3] selftests: cgroup: make test_memcg_sock robust
 against delayed sock stats
To: Guopeng Zhang <zhangguopeng@kylinos.cn>
Cc: shuah@kernel.org, muchun.song@linux.dev, mkoutny@suse.com,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org, shakeel.butt@linux.dev,
 linux-kernel@vger.kernel.org, tj@kernel.org, hannes@cmpxchg.org,
 mhocko@kernel.org, roman.gushchin@linux.dev,
 Andrew Morton <akpm@linux-foundation.org>
References: <20251124123816.486164-1-zhangguopeng@kylinos.cn>
 <20251124123816.486164-3-zhangguopeng@kylinos.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20251124123816.486164-3-zhangguopeng@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2025/11/24 20:38, Guopeng Zhang wrote:
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
> Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
> Suggested-by: Lance Yang <lance.yang@linux.dev>
> ---
>   .../selftests/cgroup/test_memcontrol.c        | 20 ++++++++++++++++++-
>   1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
> index 4e1647568c5b..dda12e5c6457 100644
> --- a/tools/testing/selftests/cgroup/test_memcontrol.c
> +++ b/tools/testing/selftests/cgroup/test_memcontrol.c
> @@ -21,6 +21,8 @@
>   #include "kselftest.h"

This patch fails to apply to mm-new ...

Hmm, it expects #include "kselftest.h" here, but the tree uses
#include "../kselftest.h".

Which is odd, as that line hasn't been touched in years ...

