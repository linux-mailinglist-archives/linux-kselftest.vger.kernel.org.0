Return-Path: <linux-kselftest+bounces-25928-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D43DA2AA68
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 14:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31ED318892E6
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 13:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6431C6FED;
	Thu,  6 Feb 2025 13:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QiV8fFK6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8221C1624C7;
	Thu,  6 Feb 2025 13:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738849918; cv=none; b=K+h1IV/cVob/dwLAk2fwzbVaYFigSJpoZ4u4zGJXjP4o1pxaCpl5JLhDZ1/l7l44P1HFbop0cNY4djUBVAVf2MsX6yxFY1pJlY+8Fdm0w6q52Mzqxv1i6lySr8YNFLui38bsZtqNK3Y5u+yUoQNpsjg1rckaroEQP73CbDQlbY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738849918; c=relaxed/simple;
	bh=7q+xyRIitmC8CLo7GyGb0DCDQ14y3LrrFILuyZVkG2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qmRRLQh6LH0VawaqB/P8ZGANISRv5p4FnEtPN5bWC7eZQmpppa45cYPotGUmqo0pQL6GCXbvo25JqL1yz1/bs01EFIihYN8RHnLb2TagQbnBshWJ5qWAKR0wLGlRBmqphraXK7MUxmaR0/dPzzS4F2qHX9NIVvM08a5oyIlss0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QiV8fFK6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3414AC4CEDF;
	Thu,  6 Feb 2025 13:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738849918;
	bh=7q+xyRIitmC8CLo7GyGb0DCDQ14y3LrrFILuyZVkG2I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QiV8fFK6K2ZA87yAvrNrKdgeHaYX5VKz/tfhOw83dpjVRK2H4pFS6Uzefa874K2Fx
	 BjKP8yZMGfNbPhl8CYCJQGHTFb7b/MWMuGRB/L01L63JyMGfCmYse5myJt5GObXW5L
	 COhvEDpdrIohjCdT6TLiS/sU0jQYZ4V8fDb9RE2KHr1Zm++as9fXg+CREcyoO0mKbI
	 OZEPt+oRWy2OonCCPKvNKu60Dby2kACoj2OWi3wxN+G8CtiHn1rAippICoznCfnKHV
	 JlhawP4AAXgfp8xVCWceTDVDhggNwUNx7I6BFA5cylzlURrtC2Hdr0YeqUuvPa3Ipd
	 DWqLjeUJMifpA==
Date: Thu, 6 Feb 2025 13:51:54 +0000
From: Simon Horman <horms@kernel.org>
To: Peter Seiderer <ps.report@gmx.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH net-next v4 00/17] Some pktgen fixes/improvments
Message-ID: <20250206135154.GB641369@kernel.org>
References: <20250205131153.476278-1-ps.report@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205131153.476278-1-ps.report@gmx.net>

On Wed, Feb 05, 2025 at 02:11:36PM +0100, Peter Seiderer wrote:
> hile taking a look at '[PATCH net] pktgen: Avoid out-of-range in
> get_imix_entries' ([1]) and '[PATCH net v2] pktgen: Avoid out-of-bounds access
> in get_imix_entries' ([2], [3]) and doing some tests and code review I
> detected that the /proc/net/pktgen/... parsing logic does not honour the
> user given buffer bounds (resulting in out-of-bounds access).
> 
> This can be observed e.g. by the following simple test (sometimes the
> old/'longer' previous value is re-read from the buffer):
> 
>         $ echo add_device lo@0 > /proc/net/pktgen/kpktgend_0
> 
>         $ echo "min_pkt_size 12345" > /proc/net/pktgen/lo\@0 && grep min_pkt_size /proc/net/pktgen/lo\@0
> Params: count 1000  min_pkt_size: 12345  max_pkt_size: 0
> Result: OK: min_pkt_size=12345
> 
>         $ echo -n "min_pkt_size 123" > /proc/net/pktgen/lo\@0 && grep min_pkt_size /proc/net/pktgen/lo\@0
> Params: count 1000  min_pkt_size: 12345  max_pkt_size: 0
> Result: OK: min_pkt_size=12345
> 
>         $ echo "min_pkt_size 123" > /proc/net/pktgen/lo\@0 && grep min_pkt_size /proc/net/pktgen/lo\@0
> Params: count 1000  min_pkt_size: 123  max_pkt_size: 0
> Result: OK: min_pkt_size=123
> 
> So fix the out-of-bounds access (and some minor findings) and add a simple
> proc_net_pktgen selftest...
> 
> Regards,
> Peter
> 
> Changes v3 -> v4:
>  - add rev-by Simon Horman
>  - new patch 'net: pktgen: use defines for the various dec/hex number parsing
>    digits lengths' (suggested by Simon Horman)
>  - replace C99 comment (suggested by Paolo Abeni)
>  - drop available characters check in strn_len() (suggested by Paolo Abeni)
>  - factored out patch 'net: pktgen: align some variable declarations to the
>    most common pattern' (suggested by Paolo Abeni)
>  - factored out patch 'net: pktgen: remove extra tmp variable (re-use len
>    instead)' (suggested by Paolo Abeni)
>  - factored out patch 'net: pktgen: remove some superfluous variable
>    initializing' (suggested by Paolo Abeni)
>  - factored out patch 'net: pktgen: fix mpls maximum labels list parsing'
>    (suggested by Paolo Abeni)
>  - factored out 'net: pktgen: hex32_arg/num_arg error out in case no
>    characters are available' (suggested by Paolo Abeni)
>  - factored out 'net: pktgen: num_arg error out in case no valid character
>    is parsed' (suggested by Paolo Abeni)

Hi Peter,

Thanks for splitting up the patchset some more, I for one find it much
easier to review them in this form.

That said, we are now over the preferred maximum of 15 patches in a series.
Perhaps the maintainers are ok with that, but I'd like to suggest breaking
the series in two: The first 7 patches seem to be somewhat stable, from a
review perspective, and could be posted as "part i"; And then the remaining
patches could be posted as "part ii" once "part i" has been accepted.

As for the selftests (the last patch of the series). A version,
trimmed down as appropriate, could be included in "part i", with a
follow-up in "part ii". Or the cover note for "part i" could state that the
selftests have been deferred to "part ii".

Perhaps the maintainers have other ideas, if so hopefully they will comment
here.

