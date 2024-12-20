Return-Path: <linux-kselftest+bounces-23639-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27BAC9F89EB
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 03:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03E947A2893
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 02:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3731E17C2;
	Fri, 20 Dec 2024 02:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tLGEqlOK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2AC2594B4;
	Fri, 20 Dec 2024 02:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734660106; cv=none; b=XHAlvW/A1afu3cx4UEbpeVHVBVsFHG60sub90aXGCGjKXazuclSJT9+ctgN2+kkPpwj2T9GWvFnKAAal9L5DwAS1eGhe7amNyOVzY+Pt2yf5uAOGpyvVm7lG2Q6tF3gW3gL5os5xUwZuLeVRcLZMChv0iNhxLBS7FsNYzwH+DnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734660106; c=relaxed/simple;
	bh=o7NN7eBTW6iyhgMe/qkQ8oAOywcdwyvBMXA9yXkj4ic=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=axVMnwGnLBqlJLR0mgSgx5FkxyZ26LSKhTEkpiEBB+mdLkoeJB5qPFMvXIx4AyOUu897aiwXDgGy15Nwk8WWplPj9FY34ABI1+6zgJg7A+iAxUntcW3SjQ6sn9kaZZSEf49tdtdJw4ZHP5UzlLruvuq1a0AAqJTfb6gqLfxfg3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tLGEqlOK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52504C4CECE;
	Fri, 20 Dec 2024 02:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734660105;
	bh=o7NN7eBTW6iyhgMe/qkQ8oAOywcdwyvBMXA9yXkj4ic=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tLGEqlOK62xm/Xp4gks9GdAwmh1D4ll0SKBzOR9HW09xbP9frDaox+oRsa30WRcoX
	 7MO8L0wHdJdC+AsNYCG27Fujkfi5d4m7dML/lWXbjMuoA29Ya+fXffoUT0KTS1Iktx
	 hwKCiWtpvDTuZIeRF6EWRFfmwgNOHs23Ww6qOTJPc7IOAUyZtq3wYm5N1D8a5I6AV2
	 1d+VOSsODkXnJ/nnzUxSOkBKx+3AWfHUZlQsgVGKvEzjVdr/0O0LODHdh5XBM07Yzj
	 51XwCdEowUpjhQmXqUWOfwH0v1deQYg2XzP7GLr+e5LG9XpXzA5N9/o1+wwzPnTU+j
	 iGjiWvBUwjyaA==
Date: Thu, 19 Dec 2024 18:01:44 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Soham Chakradeo
 <sohamch.kernel@gmail.com>, Willem de Bruijn <willemb@google.com>,
 netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 linux-kselftest@vger.kernel.org, Soham Chakradeo <sohamch@google.com>
Subject: Re: [PATCH net-next 0/4] selftests/net: packetdrill: import
 multiple tests
Message-ID: <20241219180144.7cf5226c@kernel.org>
In-Reply-To: <676474a0398f0_1f2e51294ad@willemb.c.googlers.com.notmuch>
References: <20241217185203.297935-1-sohamch.kernel@gmail.com>
	<20241218100013.0c698629@kernel.org>
	<19df2c4d-c40c-40c5-8fec-bb3e63e65533@redhat.com>
	<676474a0398f0_1f2e51294ad@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Dec 2024 14:31:44 -0500 Willem de Bruijn wrote:
> All three timestamping flakes are instances where the script expects
> the timestamp to be taken essentially instantaneously after the send
> call.
> 
> This is not the case, and the delay is outside even the 14K tolerance.
> I see occurrences of 20K. At some point we cannot keep increasing the
> tolerance, perhaps.

I pinned the other services away and gave the packetdrill tester its
own cores. Let's see how much of a difference this makes.
The net-next-2024-12-20--03-00 branch will be the first to have this.

