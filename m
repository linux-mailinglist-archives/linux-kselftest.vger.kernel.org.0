Return-Path: <linux-kselftest+bounces-43783-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC49BFDCFE
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 20:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D388218C8B3C
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 18:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D05F344042;
	Wed, 22 Oct 2025 18:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DnOyrUwt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D17226D02;
	Wed, 22 Oct 2025 18:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761157447; cv=none; b=JUMB4c/9h11U1czlfNSM8Ww5Vn/s1ef7fZmyK3y5qXafhVoopweVozVnAAi7uXeg7fk01EbNN+D+b0AyV/4OZHWNyewVPySRHk2SXwen/NOLElyNmoZb+wW7Sg1gG0xwhxE8117rPpS0A4nlGh4i0MpCkmlnYijKA14+gbjTi9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761157447; c=relaxed/simple;
	bh=lN16kSfzrXPzyaR7YDMKSTzasvBepHm3SWk9ngJJhSs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=OWJcScfrPH2zqIhrSWZah2mMZDyjpEOxmsnKDueUM9mFCraohO77QvrPKB2uHuPVKuv4bDyX+BdZtvDsVVmHZcjv4WSzTZxAaiOFN20WQBiP2fP8iSnn5Ne0Fat3lt9uXYUpU3yWHvbypGhjYNo2ORrGCsOigWmQ0WM08X80sxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DnOyrUwt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7753C4CEE7;
	Wed, 22 Oct 2025 18:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1761157446;
	bh=lN16kSfzrXPzyaR7YDMKSTzasvBepHm3SWk9ngJJhSs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DnOyrUwtRAwzJloHfIE5bmAiAyWXeBHZ9/k3vL9S6xEPKYSyTXIxJdo7XzKzTwln6
	 ma4xd7hPWcgBS72Jz2UDN0ayuGVM3OSvZIFtEGhvHO+ZvznXRZKk5J4ZzfIpKfYb6C
	 ISH/gBZ7zPEawCQIJXr8OpfNLdzCebnhUpJG2o0Y=
Date: Wed, 22 Oct 2025 11:24:05 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, brauner@kernel.org,
 corbet@lwn.net, graf@amazon.com, jgg@ziepe.ca,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org, masahiroy@kernel.org, ojeda@kernel.org,
 pratyush@kernel.org, rdunlap@infradead.org, tj@kernel.org,
 jasonmiu@google.com, dmatlack@google.com, skhawaja@google.com
Subject: Re: [PATCH v3 0/3] KHO: kfence + KHO memory corruption fix
Message-Id: <20251022112405.8ef617335ba0387f0608188c@linux-foundation.org>
In-Reply-To: <aPhwMitTY9De7md8@kernel.org>
References: <20251021000852.2924827-1-pasha.tatashin@soleen.com>
	<aPchmxfh4ACM0vY2@kernel.org>
	<CA+CK2bAHH1tzMEGxAwbmrLnLTzJANMntRu=cp0J8-n101ER7Pw@mail.gmail.com>
	<20251021135331.8e0185a173a5fa40add60802@linux-foundation.org>
	<CA+CK2bDPLAS7EM--stHkZkx8FSgYBjDOz6FdvWBYrdHwZpZZjw@mail.gmail.com>
	<aPhwMitTY9De7md8@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Oct 2025 08:48:34 +0300 Mike Rapoport <rppt@kernel.org> wrote:

> > We are using KHO and have had obscure crashes due to this memory
> > corruption, with stacks all over the place. I would prefer this fix to
> > be properly backported to stable so we can also automatically consume
> > it once we switch to the upstream KHO. I do not think disabling kfence
> > in the Google fleet to resolve this problem would work for us, so if
> > it is not going to be part of stable, we would have to backport it
> > manually anyway.
> 
> The backport to stable is only relevant to 6.17 that's going to be EOL soon
> anyway. Do you really think it's worth the effort?

If some organization is basing their next kernel on 6.17 then they'd
like it.

Do we assume that all organizations follow the LTS schedule?  I haven't
been doing that.

