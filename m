Return-Path: <linux-kselftest+bounces-26345-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE570A3083A
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 11:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2418A1887EB2
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 10:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3990E1F153C;
	Tue, 11 Feb 2025 10:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qczIf9Tp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFF817BCE;
	Tue, 11 Feb 2025 10:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739268942; cv=none; b=DG/ko7G4TLgm46Wxd6EkMEwaTCEzIgtL2m75kAyCxV7PunGX+StKQqmEoi1O8epSwlpMKezVpDXMjr9WO3nPDYpGkX1m4fwujgJaERJOWQ9QPqBbVF3vIDlWty8iJgpqBq6pXlec1J+8/kgMHgE309tIalBz+EMGDDLyCkYwF7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739268942; c=relaxed/simple;
	bh=/c4xSQ4dBy2vtRVgtSgITYZTzOC45OXmIZWstd1uUtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=My9HjRZla/CwbMeYtrPFIdkOw3lBABe9z5zQK225ifzlIEeQzcGzaQ+Kf2hYRvyzZ5vlfDD9Lfds6TVFW+3Nhy0DcJvPOPeBXEEJxwWch5g/YSEfdMJ6O/Sxh/Khi4jsgfyaLzWaA2t7gYKnmHMHeJ9w09sRChiZAwscDPbVnNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qczIf9Tp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0108DC4CEE4;
	Tue, 11 Feb 2025 10:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739268941;
	bh=/c4xSQ4dBy2vtRVgtSgITYZTzOC45OXmIZWstd1uUtE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qczIf9TpAhTAXCC7A3m9P3E8I8IOthtyhXuB/BT717nNcVw6IPkBen4Zhc5xMNRcb
	 72/p2DCd9Sgd3o3l0xJMmHEpZ7+OLphJmT7hNfrXEF8JD7YfSJwwmwhqhAli2ff4eB
	 0ZDFRURbRobVtg8eeXzq2TEXEf9fSFVfiuPyMR6D4XWLI9Rye3rdxVru1HODQ5cyOT
	 2kwtqgF8iy3DGalVqVpuz1vblvMLqJjUEWW2/IN60s5RQsB8EXfdwo/D0+4xh+aCLO
	 DPZBKs8vNVf1kUZWy7S51ezf4+sI5c4Bmj72/wvEmH67oI4vIGbGDwFHh8l2HaLmBO
	 Y98T7NzegaBqw==
Date: Tue, 11 Feb 2025 10:15:37 +0000
From: Simon Horman <horms@kernel.org>
To: Peter Seiderer <ps.report@gmx.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH net-next v4 09/17] net: pktgen: align some variable
 declarations to the most common pattern
Message-ID: <20250211101537.GK554665@kernel.org>
References: <20250205131153.476278-1-ps.report@gmx.net>
 <20250205131153.476278-10-ps.report@gmx.net>
 <20250206132538.GU554665@kernel.org>
 <20250211102959.4aeeb806@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211102959.4aeeb806@gmx.net>

On Tue, Feb 11, 2025 at 10:29:59AM +0100, Peter Seiderer wrote:
> Hello Simon,
> 
> On Thu, 6 Feb 2025 13:25:38 +0000, Simon Horman <horms@kernel.org> wrote:
> 
> > On Wed, Feb 05, 2025 at 02:11:45PM +0100, Peter Seiderer wrote:
> > > Align some variable declarations (in get_imix_entries and get_labels) to
> > > the most common pattern (int instead of ssize_t/long) and adjust function
> > > return value accordingly.
> > >
> > > Signed-off-by: Peter Seiderer <ps.report@gmx.net>
> >
> > Hi Peter,
> >
> > These comments are is true in general of this patchset, but particularly so
> > in the case of this patch:
> >
> > * I think a more succinct subject would be nice.
> > * I think the patch description should provide some reason
> >   _why_ the change is being made.
> 
> Yep, will improve...
> 
> >
> > Also, specifically relating to this patch, I wonder if it's scope ought to
> > be extended. For example, the two callers of num_arg(), get_imix_entries() and
> > pktgen_if_write() assign the return value of num_arg() to len, which is now
> > an int in both functions. But num_args() returns a long.
> 
> Aim was to get rid of the int/long mixture in the code (which works flawless
> because no one writes to proc with more than a few bytes AND count is limited
> to INT_MAX - PAGE_SIZE in vfs_write (see [1], [2])...
> 
> I believe the clean way is to use
> 
>   size_t i, max;
>   ssize_t len;
> 
> consequently through out the code and adjust the function signatures
> accordingly...., will re-spin...

Thanks Peter,

I for one am all for things being consistent.

...

