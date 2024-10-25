Return-Path: <linux-kselftest+bounces-20659-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 583439AFF62
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 12:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB3F3B22BE1
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 10:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1761DDA1C;
	Fri, 25 Oct 2024 10:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LA56r5ua"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E6C1A0BEE;
	Fri, 25 Oct 2024 10:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729850457; cv=none; b=m3iOXMyeL39a8xF+lFP2DRm+qLsa1BxJ3/dp3+BSS6HgdMnSX2tcLp+A0k3iCKEZmMmU1TQnaTYa41n86RC3vQMxKuzFp6WKh3J00PHZuW8rCbVBi4N0DDH81oSaPh5DJ+qcPEPXKnsYFeMAq0f640otl5KXTWR2K/T+KbSQum0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729850457; c=relaxed/simple;
	bh=aVscTLXVO2A6+3+8E/Ek0ANx+Z3F0Cm1Fng5HkdRojk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oR345UTfVIIWJS1iKJKH5+HEXpyPZQPHwE+fke3EealpEvXX3iCL5yi8cF4rzVYXeNIxQAVGgBkvt1miyyxetqsdoIXoucmv4corbKonU/mqjPyt36V12I0Uj/5V6KM2QVw/ikA4P4iB/rHzPagMYalRIfOk4/3cUrSpfu1Xw84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LA56r5ua; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C095C4CECD;
	Fri, 25 Oct 2024 10:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729850456;
	bh=aVscTLXVO2A6+3+8E/Ek0ANx+Z3F0Cm1Fng5HkdRojk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LA56r5uaoLwbRheEYnLRqfCHnEID20EJj9AVZCo7bTAEDQfIcMjZdWR/PPDta8XUg
	 9fDwO6M/kyEB9qcKY1fqBPDF880trPwrdyo0PP1y2CAzU/gcHyZd8l+UcoNpBhZUjK
	 5dLp1LeN83iwhUaiie22v0f2u3HyqAI44kwdEJgy0fZu0tlMdVKkXo4psK4A87+STV
	 yYKoVS33pZmre/5Y+rIK+hGbL6oc7366qlw1YOM2KvNzf4Dbd5NltYVAu4NsC28Uph
	 dBWwFRfZmW52BrwXwuDYzlrkaxWD82PkCLha3PwoPqq4IeZnhNf/vAzpZmGKR/yMeN
	 ycMm3RJXU88Yw==
Date: Fri, 25 Oct 2024 11:00:51 +0100
From: Simon Horman <horms@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Gregory Detal <gregory.detal@gmail.com>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net 2/3] mptcp: remove unneeded lock when listing scheds
Message-ID: <20241025100051.GN1202098@kernel.org>
References: <20241021-net-mptcp-sched-lock-v1-0-637759cf061c@kernel.org>
 <20241021-net-mptcp-sched-lock-v1-2-637759cf061c@kernel.org>
 <20241023122128.GT402847@kernel.org>
 <4ca239db-6a05-4735-916c-73cee0ee22a0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ca239db-6a05-4735-916c-73cee0ee22a0@kernel.org>

On Wed, Oct 23, 2024 at 04:13:36PM +0200, Matthieu Baerts wrote:
> Hi Simon,
> 
> Thank you for the reviews!
> 
> On 23/10/2024 14:21, Simon Horman wrote:
> > On Mon, Oct 21, 2024 at 12:25:27PM +0200, Matthieu Baerts (NGI0) wrote:
> >> mptcp_get_available_schedulers() needs to iterate over the schedulers'
> >> list only to read the names: it doesn't modify anything there.
> >>
> >> In this case, it is enough to hold the RCU read lock, no need to combine
> >> this with the associated spin lock.
> >>
> >> Fixes: 73c900aa3660 ("mptcp: add net.mptcp.available_schedulers")
> >> Cc: stable@vger.kernel.org
> >> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> >> Reviewed-by: Geliang Tang <geliang@kernel.org>
> >> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> > 
> > I do wonder if it would be more appropriate to route this via net-next
> > (without a fixes tag) rather than via net. But either way this looks good
> > to me.
> Good point. On one hand, I marked it as a fix, because when working on
> the patch 1/3, we noticed these spin_(un)lock() were not supposed to be
> there in the first place. On the other hand, even it's fixing a small
> performance issue, it is not fixing a regression.
> 
> I think it is easier to route this via -net, but I'm fine if it is
> applied in net-next.

Understood. FTR, I don't feel strongly about this either way.

