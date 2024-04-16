Return-Path: <linux-kselftest+bounces-8228-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E40678A763B
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 23:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50652B2362E
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 21:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4786CDC9;
	Tue, 16 Apr 2024 21:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="ojmEvc5f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFE35B201;
	Tue, 16 Apr 2024 21:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713302307; cv=none; b=GxxwGzl+pAT0CPUBetp1fjilbvNw6v3z2VtnqZUXkuRRlPgZk5nTQsIN4hUscrCkHF0TLDyugABJtdB/blTvedmNB0AAyqQ5HvGRmQ+ylWGfStOc+KLINOJYecGoW8ao/VgqnaCVUiLzDTSUesrvKLA1AtvLQADIJNkABof4ra8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713302307; c=relaxed/simple;
	bh=LWziM6g41Gi1SkfEjjceEYfqpwAP7alcuM1I0NrWcXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cAGwfepwGe1tw85DjrLbGwAI0hGbasMwuIeluesYntmdElyxhFKIv5V5LiIUVO4gl85FXfZuzHaQ0LRIwqyTzg3MDIUWLjhS+h4dP4pxRQ8tGkFdHvBnTZs7YJxz3/GGghMlhe9jqaq9HEt048wzn/k+dVC0F/GZ4ANriJT5lLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=ojmEvc5f; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=l72sHAs7dX/l/HK2vEslWTg7CeLW4YG1XlCQ3fodzZs=; b=ojmEvc5fEkty0TL3ErN55Cd+Nh
	XvL7riabAmruEnkQwhqqkdGyY4yArMQQgAop8uR8jchwwbrh6lniTsJpzooZh4IGph/fr/P8iqAYV
	Jd0fDz/H93rKoKLxMqlwLVsOjKHOHyNCf9MOHRFJMMbP4cAyAML+lPIlmNnn8DhPfdY8BVj467NUj
	2TJwgBheYOBRgWkblJ9DbWNnpbcHk/rFl7O1JTx0xBvVvoVA4Wrg7IgVG/NADjy8Jpx6khQgZjWq+
	yJlI6sB04iwgWtHf56/BW7w1S/lyFBZeqpvr7tAM2CJh7yNyjXFDo4lTxvGwxyX7lmEcMn5z9qoDu
	9fjgVatg==;
Received: from [10.69.139.14] (helo=terabithia.localnet)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rwqC8-00GSzR-2p;
	Tue, 16 Apr 2024 16:18:25 -0500
From: Elizabeth Figura <zfigura@codeweavers.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 wine-devel@winehq.org,
 =?ISO-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
 Wolfram Sang <wsa@kernel.org>, Arkadiusz Hiler <ahiler@codeweavers.com>,
 Andy Lutomirski <luto@kernel.org>, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
 Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH v4 00/30] NT synchronization primitive driver
Date: Tue, 16 Apr 2024 16:18:24 -0500
Message-ID: <4340072.ejJDZkT8p0@terabithia>
In-Reply-To: <20240416081421.GB31647@noisy.programming.kicks-ass.net>
References:
 <20240416010837.333694-1-zfigura@codeweavers.com>
 <20240416081421.GB31647@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, 16 April 2024 03:14:21 CDT Peter Zijlstra wrote:
> On Mon, Apr 15, 2024 at 08:08:10PM -0500, Elizabeth Figura wrote:
> > This patch series implements a new char misc driver, /dev/ntsync, which is
> > used to implement Windows NT synchronization primitives.
> 
> This patch series does not apply to anything I have at hand. Nor does it
> state anything explicit to put it on top of.

It was written to apply against the 'char-misc-next' branch of gregkh/char-
misc.git. I'll make a note of that next time, sorry for the inconvenience.

> > Hence I would like to request review from someone familiar with locking to
> > make sure that the usage of low-level kernel primitives is correct and
> > that the wait queues work as intended, and to that end I've CC'd the
> > locking maintainers.
> I am sadly very limited atm, but I'll try and read through it. If only I
> could apply...
> 
> > == Patches ==
> > 
> > The intended semantics of the patches are broadly intended to match those
> > of the corresponding Windows functions. For those not already familiar
> > with the Windows functions (or their undocumented behaviour), patch 27/27
> > provides a detailed specification, and individual patches also include a
> > brief description of the API they are implementing.
> > 
> > The patches making use of this driver in Wine can be retrieved or browsed 
here:
> >     https://repo.or.cz/wine/zf.git/shortlog/refs/heads/ntsync5
> 
> I don't support GE has it in his builds? Last time I tried, building
> Wine was a bit of a pain.

It doesn't seem so. I tried to build a GE-compatible ntsync build, uploaded 
here (thanks Arek for hosting):

    https://f002.backblazeb2.com/file/wine-ntsync/ntsync-wine.tar.xz

> > Some aspects of the implementation may deserve particular comment:
> > 
> > * In the interest of performance, each object is governed only by a single
> > 
> >   spinlock. However, NTSYNC_IOC_WAIT_ALL requires that the state of
> >   multiple
> >   objects be changed as a single atomic operation. In order to achieve
> >   this, we first take a device-wide lock ("wait_all_lock") any time we
> >   are going to lock more than one object at a time.
> >   
> >   The maximum number of objects that can be used in a vectored wait, and
> >   therefore the maximum that can be locked simultaneously, is 64. This
> >   number is NT's own limit.
> >   
> >   The acquisition of multiple spinlocks will degrade performance. This is
> >   a
> >   conscious choice, however. Wait-for-all is known to be a very rare
> >   operation in practice, especially with counts that approach the
> >   maximum, and it is the intent of the ntsync driver to optimize
> >   wait-for-any at the expense of wait-for-all as much as possible.
> 
> Per the example of percpu-rwsem, it would be possible to create a
> mutex-spinlock hybrid scheme, where single locks are spinlocks while
> held, but can block when the global thing is pending. And the global
> lock is always mutex like.
> 
> If all that is worth it, I don't know. Nesting 64 spinlocks doesn't give
> me warm and fuzzy feelings though.

Is the concern about poor performance when ntsync is in use, or is nesting a 
lot of spinlocks like that something that could cause problems for unrelated 
tasks? I'm not familiar enough with the scheduler to know if this can be 
abused.

I think we don't care about performance problems within Wine, at least. FWIW, 
the scheme here is actually similar to what Windows does (as described by one 
of their kernel engineers), although slightly different. NT nests spinlocks as 
well, but instead of using the outer lock like our "wait_all_lock" to prevent 
lock inversion, they instead sort the inner locks (by address, I assume).

If there's deeper problems... I can look into (ab)using a rwlock for this 
purpose, at least for now.

In any case making wait_all_lock into a sleeping mutex instead of a spinlock 
should be fine. I'll rerun performance tests but I don't expect it to cause 
any problems.



