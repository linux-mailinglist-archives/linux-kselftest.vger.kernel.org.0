Return-Path: <linux-kselftest+bounces-24009-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C81CA04791
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 18:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FCA57A1424
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 17:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877E31F4281;
	Tue,  7 Jan 2025 17:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="euXd9rjI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD351F191A;
	Tue,  7 Jan 2025 17:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736269634; cv=none; b=ixieUgFOMl6eDu98/ydSUhFhXdUQUSo2WSdW5AD1qGy8BoidK/IANNLA4JRHLoPo7WfNham8CEFiPmSwxs+ZvEyV9NLnz5r2WLUZ2BZkwG7EfJW+qRJE+k8/i7XLFN3yT7Y95T1MSaGr+/OeGY73ATfr2eAywmfKDJzsDzIv33E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736269634; c=relaxed/simple;
	bh=U5essjvnz03HrnLxuqFzgcs04QD4HhmrSF1hEo5CPwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YNtQfwvOv8THNiX7yZ4iRMBikB1Z13FPP4QDCniF+W7YR0Jt6ZEEJBosSxs90wLWwZWWm/kfJwfHgHiWxRL9Wn/i7KIo01zdJc79IUSqR4KhVCtzmwKlUmLZBrDZOGAsw5s9GBj1NqUEZfgbKwY0ZqrPIsGBO/b7weaOX7fbuAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=euXd9rjI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12FC4C4CEDD;
	Tue,  7 Jan 2025 17:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736269633;
	bh=U5essjvnz03HrnLxuqFzgcs04QD4HhmrSF1hEo5CPwA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=euXd9rjIRgQ4HjJgGXhsS+Tu0eXe7+HuXmyfyKCVkg58VxM9A8IGpIXvm1GnXgG0R
	 eRBharK+H3XoCHTAXgJkgZGJRuvUDrFSocMInDjdcGdsUjfNHCvxWzonEw/6PBOl5Z
	 /oG4HMlbm/pBcfCnak+Zn3AV9cPVUEy+iu+AQ+Bc=
Date: Tue, 7 Jan 2025 18:06:03 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Elizabeth Figura <zfigura@codeweavers.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, wine-devel@winehq.org,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Wolfram Sang <wsa@kernel.org>,
	Arkadiusz Hiler <ahiler@codeweavers.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andy Lutomirski <luto@kernel.org>, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH v7 00/30] NT synchronization primitive driver
Message-ID: <2025010738-amicably-art-f746@gregkh>
References: <20241213193511.457338-1-zfigura@codeweavers.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213193511.457338-1-zfigura@codeweavers.com>

On Fri, Dec 13, 2024 at 01:34:41PM -0600, Elizabeth Figura wrote:
> This patch series implements a new char misc driver, /dev/ntsync, which is used
> to implement Windows NT synchronization primitives.
> 
> NT synchronization primitives are unique in that the wait functions both are
> vectored, operate on multiple types of object with different behaviour (mutex,
> semaphore, event), and affect the state of the objects they wait on. This model
> is not compatible with existing kernel synchronization objects or interfaces,
> and therefore the ntsync driver implements its own wait queues and locking.
> 
> This patch series is rebased against the "char-misc-next" branch of
> gregkh/char-misc.git.
> 
> == Background ==
> 
> The Wine project emulates the Windows API in user space. One particular part of
> that API, namely the NT synchronization primitives, have historically been
> implemented via RPC to a dedicated "kernel" process. However, more recent
> applications use these APIs more strenuously, and the overhead of RPC has become
> a bottleneck.
> 
> The NT synchronization APIs are too complex to implement on top of existing
> primitives without sacrificing correctness. Certain operations, such as
> NtPulseEvent() or the "wait-for-all" mode of NtWaitForMultipleObjects(), require
> direct control over the underlying wait queue, and implementing a wait queue
> sufficiently robust for Wine in user space is not possible. This proposed
> driver, therefore, implements the problematic interfaces directly in the Linux
> kernel.
> 
> This driver was presented at Linux Plumbers Conference 2023. For those further
> interested in the history of synchronization in Wine and past attempts to solve
> this problem in user space, a recording of the presentation can be viewed here:
> 
>     https://www.youtube.com/watch?v=NjU4nyWyhU8
> 
> 
> == Performance ==
> 
> The performance measurements described below are copied from earlier versions of
> the patch set. While some of the code has changed, I do not currently anticipate
> that it has changed drastically enough to affect those measurements.
> 
> The gain in performance varies wildly depending on the application in question
> and the user's hardware. For some games NT synchronization is not a bottleneck
> and no change can be observed, but for others frame rate improvements of 50 to
> 150 percent are not atypical. The following table lists frame rate measurements
> from a variety of games on a variety of hardware, taken by users Dmitry
> Skvortsov, FuzzyQuils, OnMars, and myself:
> 
> Game                            Upstream        ntsync          improvement
> ===========================================================================
> Anger Foot                       69              99              43%
> Call of Juarez                   99.8           224.1           125%
> Dirt 3                          110.6           860.7           678%
> Forza Horizon 5                 108             160              48%
> Lara Croft: Temple of Osiris    141             326             131%
> Metro 2033                      164.4           199.2            21%
> Resident Evil 2                  26              77             196%
> The Crew                         26              51              96%
> Tiny Tina's Wonderlands         130             360             177%
> Total War Saga: Troy            109             146              34%
> ===========================================================================
> 
> 
> == Patches ==
> 
> The intended semantics of the patches are broadly intended to match those of the
> corresponding Windows functions. For those not already familiar with the Windows
> functions (or their undocumented behaviour), patch 27/28 provides a detailed
> specification, and individual patches also include a brief description of the
> API they are implementing.
> 
> The patches making use of this driver in Wine can be retrieved or browsed here:
> 
>     https://repo.or.cz/wine/zf.git/shortlog/refs/heads/ntsync7
> 

Given a lack of complaints, I've now applied this to my testing tree.
Thanks for sticking with it!

greg k-h

