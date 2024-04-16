Return-Path: <linux-kselftest+bounces-8183-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB8C8A70AB
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 18:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDBFC28195A
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 15:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F8013C669;
	Tue, 16 Apr 2024 15:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Cn57aN//"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0019713C3FB;
	Tue, 16 Apr 2024 15:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713282840; cv=none; b=pLujvcztLkLPamwTEnZMHsQIKDP6lOZdOhefhmvLrG8ELpoT8s97Kg2Z/8nCxB3uwZVg/HlWDqsizOon3F+FPTzbpOsiWYIrV3hGxUhxbYuq3eZuty9APMDf+OtmVoX25ZJuaTZY+3NpAA3VAEtzEI5nAooSpClMcXNTLJPWnY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713282840; c=relaxed/simple;
	bh=xr7ky7Cb0ygGptcAXZwef1Q17uuZn48m+YBRnvcd9GE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qhBIOj0D61j4cWtUXMQ7FicfFICkPkr5U5lQC7mzR4EFPj5Hvbe8Wa9wnxU6RK8mOwBowMW7AIOVYFg5k1Dg4a750ofDGwV3dBwAkpwz0Ct/6to14eepBwJYL2JDDGQIGdd2vAm4Ebj4GkyQVmRDLCDsHo2vmUVovPmp1ojk+tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Cn57aN//; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wZEy1lpoVSmMRE0DeOc5Gd5oUzFgnMEWwvGF0LAHu8U=; b=Cn57aN//MYZ+dXqCms+9QZ2xFM
	R6jH8lG6V6rsLnVsxURyoEsjbtBO9tDJ7v6UB/+HgbxZsAyFFOBR+YDH5xpjk7FVFActU1ECnBScj
	N4ho/AR8AAxxxhz93MqQpIYfDGuWKuTvhQcG6IvQrIbyfOd5oSjCOA4iYUcVjHN3NL6S91Me6bJGx
	7qqb2+R4sImsoxiMBzz11/ADpFTAwXs5ytiwivw4SLINRHcE3VrgJ9HhImwP87YrY3IglUYI/zgfL
	H1NJOi2F75jD1YIvcett5AlBNg1Y6joZY9hDc/LKkyUmLc1x69gk/ogvw0l41MO6CZMBFrddqPe1Z
	k1Ulqj2A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwl7y-00000000r5i-0m9z;
	Tue, 16 Apr 2024 15:53:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BC83030040C; Tue, 16 Apr 2024 17:53:45 +0200 (CEST)
Date: Tue, 16 Apr 2024 17:53:45 +0200
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
Subject: Re: [PATCH v4 00/30] NT synchronization primitive driver
Message-ID: <20240416155345.GC12673@noisy.programming.kicks-ass.net>
References: <20240416010837.333694-1-zfigura@codeweavers.com>
 <20240416081421.GB31647@noisy.programming.kicks-ass.net>
 <20240416155014.GB12673@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416155014.GB12673@noisy.programming.kicks-ass.net>

On Tue, Apr 16, 2024 at 05:50:14PM +0200, Peter Zijlstra wrote:
> On Tue, Apr 16, 2024 at 10:14:21AM +0200, Peter Zijlstra wrote:
> 
> > > Some aspects of the implementation may deserve particular comment:
> > > 
> > > * In the interest of performance, each object is governed only by a single
> > >   spinlock. However, NTSYNC_IOC_WAIT_ALL requires that the state of multiple
> > >   objects be changed as a single atomic operation. In order to achieve this, we
> > >   first take a device-wide lock ("wait_all_lock") any time we are going to lock
> > >   more than one object at a time.
> > > 
> > >   The maximum number of objects that can be used in a vectored wait, and
> > >   therefore the maximum that can be locked simultaneously, is 64. This number is
> > >   NT's own limit.
> 
> AFAICT:
> 
> 	spin_lock(&dev->wait_all_lock);
> 	  list_for_each_entry(entry, &obj->all_waiters, node)
> 	    for (i=0; i<count; i++)
> 	      spin_lock_nest_lock(q->entries[i].obj->lock, &dev->wait_all_lock);
> 
> Where @count <= NTSYNC_MAX_WAIT_COUNT.
> 
> So while this nests at most 65 spinlocks, there is no actual bound on
> the amount of nested lock sections in total. That is, all_waiters list
> can be grown without limits.
> 
> Can we pretty please make wait_all_lock a mutex ?

Hurmph, it's worse, you do that list walk while holding some obj->lock
spinlokc too. Still need to figure out how all that works....

