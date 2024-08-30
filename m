Return-Path: <linux-kselftest+bounces-16837-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8D596680C
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 19:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 337F0B23F94
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 17:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400681B9B34;
	Fri, 30 Aug 2024 17:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVN7CGC4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1852B15C153;
	Fri, 30 Aug 2024 17:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725039225; cv=none; b=Ipv0TFzeREujr4tOqMXdt5RDut+B+dDuNwDJM8AacBePx2qnkGjsBIcj78OVplqOtcVZ7eRfO0h9wjoefd/xIZGCBhew0OwxcKpylQp2Jr1+ALchcDIYqRMt8WJo7zucqZCsnll/BiI1niectmrOetlJ0x9JO6bQ+YGacbIAaEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725039225; c=relaxed/simple;
	bh=TUz9ASTMN2iuiN+gr+m2jjICR/OS4Cf+NxxQRgZo5Ow=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sz5BNeYyBPP+bbaRh3HyQCzIdLFdXiGIzjGaRGk5Dpb6qoIOdQvwNLo6lW6eeQoCyEKFHP8CwOCp0pze/SNG4tYW2RUvKCbQZbKeu69jHvdQXLBGZJz9dnXcUYtF2Zp3sw5RS/P23Y4FMP8aGNPdsKPf3Dv2bvuVcaSCOf6uRjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVN7CGC4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C3CAC4CEC2;
	Fri, 30 Aug 2024 17:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725039224;
	bh=TUz9ASTMN2iuiN+gr+m2jjICR/OS4Cf+NxxQRgZo5Ow=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EVN7CGC4AgBIqaMz810/WfaFVp1nOSFTQVfhf+NPjSV2HV0W32w/e+ZyGE+BnZdiJ
	 S8WiJiz7GJHH+YI+EBwV+PZ6usluQ6pBkZ9OVXFnHI6/xG8LwfW2fNsHnlG029G7pj
	 +xms9bi7NREJ6Y6Y4FN2Hpt19xhyN9cAbPXhHyLzyfSSxR4Fg3yfpZ+E4yIzVLJCXe
	 iUsLl4LnyV2KFJbMjGuS7HqSCpjgqOtz51UPg2/0QLa259PRJdV6tx2jeHoejzLvcb
	 TOVPTyUJahspioxcSJMRXigV9aB4BnyaIqk1GZL/emG9b/I6SvVEPo/ri7XlMOUUcG
	 GrrMaMIpedpMQ==
Date: Fri, 30 Aug 2024 10:33:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, ncardwell@google.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, fw@strlen.de, Willem de
 Bruijn <willemb@google.com>, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
 martineau@kernel.org
Subject: Re: [PATCH net-next RFC] selftests/net: integrate packetdrill with
 ksft
Message-ID: <20240830103343.0dd20018@kernel.org>
In-Reply-To: <66d1e32558532_3c08a22949e@willemb.c.googlers.com.notmuch>
References: <20240827193417.2792223-1-willemdebruijn.kernel@gmail.com>
	<401f173b-3465-428d-9b90-b87a76a39cc8@redhat.com>
	<66cf2e4bd8e89_33815c294b2@willemb.c.googlers.com.notmuch>
	<20240828090120.71be0b20@kernel.org>
	<66cf7b8d1c480_36509229439@willemb.c.googlers.com.notmuch>
	<20240828140035.4554142f@kernel.org>
	<66d1e32558532_3c08a22949e@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 Aug 2024 11:20:05 -0400 Willem de Bruijn wrote:
> Kselftest install does not preserve directories.
> 
> So all .pkt files are copied into net/packetdrill root. This is messy.
> More fundamentally it breaks the includes in the files (e..g, `source
> ../common/defaults.sh`).

Can you show an example of exact commands and what happens?

We have directories in net/lib, and it's a target, and it works, no?

