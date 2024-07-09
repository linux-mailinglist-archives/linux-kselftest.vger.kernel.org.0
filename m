Return-Path: <linux-kselftest+bounces-13358-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDA892B38F
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 11:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 497011F227CF
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 09:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF5A154457;
	Tue,  9 Jul 2024 09:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lzwClH18"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F08154434;
	Tue,  9 Jul 2024 09:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720516795; cv=none; b=SsqafzTDJRbS5jj6ENubLCQaLsEObLm8IPWjQpB97+BgWLcW3Vts+cY4t7I5dqlqc/wgRNKuu0OJ7G+tEG7J3VVQUKuvW/bNpZjNVTFWCjXRSfbkcMyuUPyy8mijmzq7PmPxIfdZZCO+egDvphFLxKLjozL+C2hlFZcx9vWQBJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720516795; c=relaxed/simple;
	bh=C5LaxZmJe3hgAAtn7Gpmwp0uINpw4vV2fjMcNKJkXSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hLb0LUbaf6sBwmLIQIS/4hHyQQjX2hYi2x3IR7zTKipW2gESGFDmhacOgApwC+XmIPQUfROS12ysx0Mgp/v8D3khF1q6xKCkAIDPJSevfpbxe8JptGUzi0fgPJnWv0VZm1omJ275rASTlDBZsPxRXMFZXnyYuRlgpt/f7jpGCwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lzwClH18; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D9EDC3277B;
	Tue,  9 Jul 2024 09:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720516794;
	bh=C5LaxZmJe3hgAAtn7Gpmwp0uINpw4vV2fjMcNKJkXSg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lzwClH18GW+BOKoOdoysjRyNnPrJhMpU+14WHzzR3y72OF6yRptAs8o0v0/6PGgyv
	 rUBBEC0/dHiLChlJZHXbyS3vXcV0ET/A2sF+bvFJUjORRXNPZBHrpOav8kF3jW2VtX
	 jlXNXx+h71idWxkVLCKUzLgttUdwDRg3ZHeP3xL0l//jjRp04oyU/W+D9do+cctMSb
	 pa2EaNcB3w/GC/i85QJpcBLPi4M8rzC4bIyIMvhfUHrhgAl/gfWvW+b8712rSBJBGL
	 UXpE9v+4DlZ3rFzcnlhrUemTDkqIour8vzu9HJLSidP/JSRC4zTMpNYhcf9g4Gx04r
	 2u4x+berVOsDQ==
Date: Tue, 9 Jul 2024 10:19:50 +0100
From: Simon Horman <horms@kernel.org>
To: zijianzhang@bytedance.com
Cc: netdev@vger.kernel.org, edumazet@google.com,
	willemdebruijn.kernel@gmail.com, cong.wang@bytedance.com,
	xiaochun.lu@bytedance.com, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v7 3/3] selftests: add MSG_ZEROCOPY msg_control
 notification test
Message-ID: <20240709091950.GF346094@kernel.org>
References: <20240708210405.870930-1-zijianzhang@bytedance.com>
 <20240708210405.870930-4-zijianzhang@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240708210405.870930-4-zijianzhang@bytedance.com>

+ Dave Miller, Jakub Kicinski, Paolo Abeni, Shuah Khan,
  linux-kselftest@vger.kernel.org

On Mon, Jul 08, 2024 at 09:04:05PM +0000, zijianzhang@bytedance.com wrote:
> From: Zijian Zhang <zijianzhang@bytedance.com>
> 
> We update selftests/net/msg_zerocopy.c to accommodate the new mechanism,
> cfg_notification_limit has the same semantics for both methods. Test
> results are as follows, we update skb_orphan_frags_rx to the same as
> skb_orphan_frags to support zerocopy in the localhost test.
> 
> cfg_notification_limit = 1, both method get notifications after 1 calling
> of sendmsg. In this case, the new method has around 17% cpu savings in TCP
> and 23% cpu savings in UDP.
> +---------------------+---------+---------+---------+---------+
> | Test Type / Protocol| TCP v4  | TCP v6  | UDP v4  | UDP v6  |
> +---------------------+---------+---------+---------+---------+
> | ZCopy (MB)          | 7523    | 7706    | 7489    | 7304    |
> +---------------------+---------+---------+---------+---------+
> | New ZCopy (MB)      | 8834    | 8993    | 9053    | 9228    |
> +---------------------+---------+---------+---------+---------+
> | New ZCopy / ZCopy   | 117.42% | 116.70% | 120.88% | 126.34% |
> +---------------------+---------+---------+---------+---------+
> 
> cfg_notification_limit = 32, both get notifications after 32 calling of
> sendmsg, which means more chances to coalesce notifications, and less
> overhead of poll + recvmsg for the original method. In this case, the new
> method has around 7% cpu savings in TCP and slightly better cpu usage in
> UDP. In the context of selftest, notifications of TCP are more likely to
> out of order than UDP, it's easier to coalesce more notifications in UDP.
> The original method can get one notification with range of 32 in a recvmsg
> most of the time. In TCP, most notifications' range is around 2, so the
> original method needs around 16 recvmsgs to get notified in one round.
> That's the reason for the "New ZCopy / ZCopy" diff in TCP and UDP here.
> +---------------------+---------+---------+---------+---------+
> | Test Type / Protocol| TCP v4  | TCP v6  | UDP v4  | UDP v6  |
> +---------------------+---------+---------+---------+---------+
> | ZCopy (MB)          | 8842    | 8735    | 10072   | 9380    |
> +---------------------+---------+---------+---------+---------+
> | New ZCopy (MB)      | 9366    | 9477    | 10108   | 9385    |
> +---------------------+---------+---------+---------+---------+
> | New ZCopy / ZCopy   | 106.00% | 108.28% | 100.31% | 100.01% |
> +---------------------+---------+---------+---------+---------+
> 
> In conclusion, when notification interval is small or notifications are
> hard to be coalesced, the new mechanism is highly recommended. Otherwise,
> the performance gain from the new mechanism is very limited.
> 
> Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
> Signed-off-by: Xiaochun Lu <xiaochun.lu@bytedance.com>
> ---
>  tools/testing/selftests/net/msg_zerocopy.c  | 111 ++++++++++++++++++--
>  tools/testing/selftests/net/msg_zerocopy.sh |   1 +
>  2 files changed, 105 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/net/msg_zerocopy.c b/tools/testing/selftests/net/msg_zerocopy.c

...

> @@ -466,6 +504,44 @@ static void do_recv_completions(int fd, int domain)
>  	sends_since_notify = 0;
>  }
>  
> +static void do_recv_completions2(void)
> +{
> +	struct cmsghdr *cm = (struct cmsghdr *)zc_ckbuf;
> +	struct zc_info *zc_info;
> +	__u32 hi, lo, range;
> +	__u8 zerocopy;
> +	int i;
> +
> +	zc_info = (struct zc_info *)CMSG_DATA(cm);
> +	for (i = 0; i < zc_info->size; i++) {
> +		hi = zc_info->arr[i].hi;
> +		lo = zc_info->arr[i].lo;
> +		zerocopy = zc_info->arr[i].zerocopy;
> +		range = hi - lo + 1;
> +
> +		if (cfg_verbose && lo != next_completion)
> +			fprintf(stderr, "gap: %u..%u does not append to %u\n",
> +				lo, hi, next_completion);
> +		next_completion = hi + 1;
> +
> +		if (zerocopied == -1)
> +			zerocopied = zerocopy;
> +		else if (zerocopied != zerocopy) {
> +			fprintf(stderr, "serr: inconsistent\n");
> +			zerocopied = zerocopy;
> +		}

nit: If any arms of a conditional have {}, then all arms should have them

> +
> +		completions += range;
> +
> +		if (cfg_verbose >= 2)
> +			fprintf(stderr, "completed: %u (h=%u l=%u)\n",
> +				range, hi, lo);
> +	}
> +
> +	sends_since_notify = 0;
> +	added_zcopy_info = false;
> +}

...

