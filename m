Return-Path: <linux-kselftest+bounces-23254-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0FE9EE62B
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 13:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB939288C78
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Dec 2024 12:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765A1212D61;
	Thu, 12 Dec 2024 12:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PgMCsYUe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EBD211A1F;
	Thu, 12 Dec 2024 12:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734004917; cv=none; b=njeiUtjXvLdBRM3ya1U0lIs6dH30NDCpbhLZdfQK9rdj8ZcOwwMM8PyDV71Z679rJtS6JzVRIGvS89b0g76sXv/SBO7Y2zJcIph9I97axWAtGzU0w0wkbB2l0CxB5cwbIFrePJAHAoQ1m0bfOOvbQetWjCzg1pF2L+fqNalbokA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734004917; c=relaxed/simple;
	bh=jSqSzyaLyhjRr8wizUe2Y6VnQwAVcfZKmXHFX8I3JZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fkiNF4AoOp7mXOwQPpUutwRfZ6OK/F7tWuqZcIXnWO2euxGSmlU1Av9fA+m4oMmQnMb7Ycdh2DlMbnW+Qpg7Xx3RRHdk6TBc++WZ8lHlaHkv7vsMaw2FxeJWn6eq4W1QCmM7QDpf/ETVEafS4xkPZxwtlzH2tARzxQsu/MvQiFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PgMCsYUe; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=chs8kHtge7jhj9hPJhn7V5CNCvA4fKVOBxopyTOr1+Q=; b=PgMCsYUeTR6A5WK2t4P+17j5Z1
	sluClIdKbSv2dEywec3ZGs6mJB1P405+b3kfjmlChBUrrz85pGhJGpn2/HmbmmRzvI2kYEKA55OUc
	R4e5Ev00pC8nbwVw/vmy75BfPnJWgf4+Bi2Bv8BvjruvgP1qEVgwb1m/0ruue0kgO6EYseNrn+Jak
	FqnbRvwgK3uP6qtWpdsuRDe6pPj9vgIfGTEDnzGg0qi1eDU6FzyipWnHGmBTNlpxgH6MhyWuI3E4a
	B9tSLc6/j582qChR+TovWU8IBcrEfV/fXOhAkN2ZTOYuCeHU53939wuIjjY/1g0CoM4Ewy4c+lEV5
	dCAmBOWA==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tLhsz-000000043Pt-1ohv;
	Thu, 12 Dec 2024 12:01:41 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id EF1563003FF; Thu, 12 Dec 2024 13:01:40 +0100 (CET)
Date: Thu, 12 Dec 2024 13:01:40 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Elizabeth Figura <zfigura@codeweavers.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	wine-devel@winehq.org,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Wolfram Sang <wsa@kernel.org>,
	Arkadiusz Hiler <ahiler@codeweavers.com>,
	Andy Lutomirski <luto@kernel.org>, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH v6 00/28] NT synchronization primitive driver
Message-ID: <20241212120140.GX21636@noisy.programming.kicks-ass.net>
References: <20241209185904.507350-1-zfigura@codeweavers.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209185904.507350-1-zfigura@codeweavers.com>

On Mon, Dec 09, 2024 at 12:58:36PM -0600, Elizabeth Figura wrote:

> I would like to repeat a question from the last round of review, though. Two
> changes were suggested related to API design, which I did not make because the
> APIs in question were already released in upstream Linux. However, the driver is
> also completely nonfunctional and hidden behind BROKEN, so would this be
> acceptable anyway? The changes in question are:
> 
> * rename NTSYNC_IOC_SEM_POST to NTSYNC_IOC_SEM_RELEASE (matching the NT
>   terminology instead of POSIX),
> 
> * change object creation ioctls to return the fds directly in the return value
>   instead of through the args struct. I would also still appreciate a
>   clarification on the advice in [1], which is why I didn't do this in the first
>   place.

I see no problem making those changes; esp. since Arnd doesn't seem to
object to the latter.

> Elizabeth Figura (28):
>   ntsync: Introduce NTSYNC_IOC_WAIT_ANY.
>   ntsync: Introduce NTSYNC_IOC_WAIT_ALL.
>   ntsync: Introduce NTSYNC_IOC_CREATE_MUTEX.
>   ntsync: Introduce NTSYNC_IOC_MUTEX_UNLOCK.
>   ntsync: Introduce NTSYNC_IOC_MUTEX_KILL.
>   ntsync: Introduce NTSYNC_IOC_CREATE_EVENT.
>   ntsync: Introduce NTSYNC_IOC_EVENT_SET.
>   ntsync: Introduce NTSYNC_IOC_EVENT_RESET.
>   ntsync: Introduce NTSYNC_IOC_EVENT_PULSE.
>   ntsync: Introduce NTSYNC_IOC_SEM_READ.
>   ntsync: Introduce NTSYNC_IOC_MUTEX_READ.
>   ntsync: Introduce NTSYNC_IOC_EVENT_READ.
>   ntsync: Introduce alertable waits.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

