Return-Path: <linux-kselftest+bounces-24955-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51680A1984A
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 19:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2109C1885E2C
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 18:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3F8215072;
	Wed, 22 Jan 2025 18:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bVKMwpnX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A00185B62;
	Wed, 22 Jan 2025 18:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737569935; cv=none; b=Ce6opXmXk64nuSBcJlPehLGkkyVQ9sZQvZj6rNNkpZ8b1qtqzlcaw0wNeVkVvytjVAY7CVw3jdG5/F2kDQYjMzRB87mkHj0eBvLsWcI6gCP9yQOvjSkCsYMXPtf3J/ZVsLmd7ojCveWYI3/tzYwYmviH7ONXOMS/hkkdVUEBaJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737569935; c=relaxed/simple;
	bh=JhbU4UBr00odYHn1dFYlCDCWvtocY27kc32JdJZPOnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FJ3RKKJJeRgcmtn2CYEafiLsGuvG9BSmufEyf3oXYn69CMNk+kpwDLE+h7LSi/+L0PrPYfHig0Zp0WIRpF9M7vXAjnVo0yJbUSmq4dcopL3zQ+sru35Rbcxr8h5D3CEbjb04pIKAGxqDC7jpD7RDjPXCCdfPCD+reb/lHhla1tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bVKMwpnX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F100C4CED2;
	Wed, 22 Jan 2025 18:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737569935;
	bh=JhbU4UBr00odYHn1dFYlCDCWvtocY27kc32JdJZPOnQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bVKMwpnX6ljRDmwbcd+pxClnhMOoVBk3JMav8r0XuM+4EtsV1Ie4cJTEahN0m/Jfs
	 9gl4x0muYc1XiDsk2hPBgf+CfUPwMBMHnsQkI8EuAH1evEXICS13pO1yeMg+ivSr0H
	 RgIsIrv4uMkMh8KwlsH3UcCHSTlrHGIRxT/BzqJUKXqZaUYdXi0QE5EOOkoReBNzPz
	 M3NXxkaVA7+tj4j9bijjBKeBh0r77yMa/bIgXzcrD4xP+aLYAQw6TKpe1HOt1EIE16
	 4J3sWnFqtWw3CzGEM0tzMSfHpfYr5qFwD2RtBhu+6cI69jffJRB9gXI93472o+nJRC
	 YHDpR4+tLd+oQ==
Date: Wed, 22 Jan 2025 18:18:51 +0000
From: Simon Horman <horms@kernel.org>
To: Peter Seiderer <ps.report@gmx.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Artem Chernyshev <artem.chernyshev@red-soft.ru>,
	Nam Cao <namcao@linutronix.de>
Subject: Re: [PATCH net-next v2 0/8] Some pktgen fixes/improvments
Message-ID: <20250122181851.GH395043@kernel.org>
References: <20250122144110.619989-1-ps.report@gmx.net>
 <20250122181635.GG395043@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122181635.GG395043@kernel.org>

On Wed, Jan 22, 2025 at 06:16:35PM +0000, Simon Horman wrote:
> On Wed, Jan 22, 2025 at 03:41:02PM +0100, Peter Seiderer wrote:
> > While taking a look at '[PATCH net] pktgen: Avoid out-of-range in
> > get_imix_entries' ([1]) and '[PATCH net v2] pktgen: Avoid out-of-bounds access
> > in get_imix_entries' ([2], [3]) and doing some tests and code review I
> > detected that the /proc/net/pktgen/... parsing logic does not honour the
> > user given buffer bounds (resulting in out-of-bounds access).
> > 
> > This can be observed e.g. by the following simple test (sometimes the
> > old/'longer' previous value is re-read from the buffer):
> > 
> >         $ echo add_device lo@0 > /proc/net/pktgen/kpktgend_0
> > 
> >         $ echo "min_pkt_size 12345" > /proc/net/pktgen/lo\@0 && grep min_pkt_size /proc/net/pktgen/lo\@0
> > Params: count 1000  min_pkt_size: 12345  max_pkt_size: 0
> > Result: OK: min_pkt_size=12345
> > 
> >         $ echo -n "min_pkt_size 123" > /proc/net/pktgen/lo\@0 && grep min_pkt_size /proc/net/pktgen/lo\@0
> > Params: count 1000  min_pkt_size: 12345  max_pkt_size: 0
> > Result: OK: min_pkt_size=12345
> > 
> >         $ echo "min_pkt_size 123" > /proc/net/pktgen/lo\@0 && grep min_pkt_size /proc/net/pktgen/lo\@0
> > Params: count 1000  min_pkt_size: 123  max_pkt_size: 0
> > Result: OK: min_pkt_size=123
> > 
> > So fix the out-of-bounds access (and two minor findings) and add a simple
> > proc_net_pktgen selftest...
> 
> Hi Peter,
> 
> Unfortunately net-next is closed at this time.

Sorry, I was a little hasty.

It looks like a number of these patches are fixes.

If so, please consider separating them out into a separate series,
targeted at net (rather than net-next), each with an appropriate Fixes tag.

