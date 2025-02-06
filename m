Return-Path: <linux-kselftest+bounces-25933-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50755A2AD32
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 17:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BFFE7A1ABB
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 16:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263A217BA6;
	Thu,  6 Feb 2025 16:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fxvu6Zx0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6471F416F;
	Thu,  6 Feb 2025 16:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738857668; cv=none; b=tvPeLl4hjwq/tArrU0Ffp8jMHeX/OzM4Li/w3N3epBs+WFGmzwYrvxYbKBpP1bcvh2igHWGMH6b7SLDsyitjkzMvTSMVyD7j480fweUhE6DK83xKTw4x7thRkVQrMSKKteiwXDkOb5b8bhyp5Ly+gfbLWXnZ7QxGchL2qLFYlpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738857668; c=relaxed/simple;
	bh=CRbUrt8hTzi7475aDlmDlLKM7hBdm42ThEEOGqT4H4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tmz0rFm0bolvefaMWC7FfgyPdcsQZz3DfjlmvC2idh27Uw4V5vSp0XAzHYBpVjWKzNEwgbEkp/P9oyaikpW87eSAIWtJARx8tHrDCKXa60edwdb+7XwRl3TeaeYhxCCVODNcAlbIqVTuyzBDROv1g7jB8DFo4s86arwn2A2T9aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fxvu6Zx0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F367C4CEDD;
	Thu,  6 Feb 2025 16:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738857667;
	bh=CRbUrt8hTzi7475aDlmDlLKM7hBdm42ThEEOGqT4H4g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fxvu6Zx0Q8P6eCMe27z0y2ijR0hj+oqqiDVgyU0FaM/WikmqoNkuynWHz8cFAweNB
	 LprWdS7bUJcjd34W9B4dU/MK7oCkEYhrzXjsZ7zOhqHHRMaydF1h5r7VHl2x4UhALD
	 XSrlvV8lpc6tAOP8PZU9JOodxhbDVhrMq2S4mCnc+aFZXZmht4LDL9ce00FuSV+XEp
	 OKyIEwNtJqsLVHpriVmMqEUK1Nj+1Ep3Iu+HrJ2rK357D1pti3uo3RCuJq/UK4qB3m
	 awo3jKHl0qZepCjaWzj2DYVRXjHjOwGT/Q5nBjutRntk+Ww5wVnm6hlKrobRRGtwUk
	 +24DXo11ef+aw==
Date: Thu, 6 Feb 2025 16:01:03 +0000
From: Simon Horman <horms@kernel.org>
To: Peter Seiderer <ps.report@gmx.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH net-next v4 13/17] net: pktgen: fix access outside of
 user given buffer in pktgen_if_write()
Message-ID: <20250206160103.GV554665@kernel.org>
References: <20250205131153.476278-1-ps.report@gmx.net>
 <20250205131153.476278-14-ps.report@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205131153.476278-14-ps.report@gmx.net>

On Wed, Feb 05, 2025 at 02:11:49PM +0100, Peter Seiderer wrote:
> Honour the user given buffer size for the hex32_arg(), num_arg(),
> strn_len(), get_imix_entries() and get_labels() calls (otherwise they will
> access memory outside of the user given buffer).
> 
> Signed-off-by: Peter Seiderer <ps.report@gmx.net>
> ---
> Changes v3 -> v4:
>   - replace C99 comment (suggested by Paolo Abeni)
>   - drop available characters check in strn_len() (suggested by Paolo Abeni)
>   - factored out patch 'net: pktgen: align some variable declarations to the
>     most common pattern' (suggested by Paolo Abeni)
>   - factored out patch 'net: pktgen: remove extra tmp variable (re-use len
>     instead)' (suggested by Paolo Abeni)
>   - factored out patch 'net: pktgen: remove some superfluous variable
>     initializing' (suggested by Paolo Abeni)
>   - factored out patch 'net: pktgen: fix mpls maximum labels list parsing'
>     (suggested by Paolo Abeni)
>   - factored out 'net: pktgen: hex32_arg/num_arg error out in case no
>     characters are available' (suggested by Paolo Abeni)
>   - factored out 'net: pktgen: num_arg error out in case no valid character
>     is parsed' (suggested by Paolo Abeni)
> 
> Changes v2 -> v3:
>   - no changes
> 
> Changes v1 -> v2:
>   - additional fix get_imix_entries() and get_labels()

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  net/core/pktgen.c | 176 ++++++++++++++++++++++++++++++----------------

...

> @@ -1015,7 +1025,8 @@ static ssize_t pktgen_if_write(struct file *file,
>  	}
>  
>  	if (!strcmp(name, "min_pkt_size")) {
> -		len = num_arg(&user_buffer[i], DEC_10_DIGITS, &value);
> +		max = min(DEC_10_DIGITS, count - i);
> +		len = num_arg(&user_buffer[i], max, &value);
>  		if (len < 0)
>  			return len;
>  

As an aside:

The code immediately following the hunk above is as follows.
And this block it is representative of many (all?) of the code
modified by the hunks that make up the remainder of this patch.

My observation is that i is incremented but never used again -
the function subsequently returns at the end of the if condition.

So perhaps it would be a nice, as a follow-up, to clean this up
be removing the increment of i from this and similar blocks.


		if (len < 0)
			return len;

		i += len;
		if (value < 14 + 20 + 8)
			value = 14 + 20 + 8;
		if (value != pkt_dev->min_pkt_size) {
			pkt_dev->min_pkt_size = value;
			pkt_dev->cur_pkt_size = value;
		}
		sprintf(pg_result, "OK: min_pkt_size=%d",
			pkt_dev->min_pkt_size);
		return count;
	}

...

