Return-Path: <linux-kselftest+bounces-8250-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 018EE8A8235
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Apr 2024 13:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D4F91C210D7
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Apr 2024 11:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A96413CAAE;
	Wed, 17 Apr 2024 11:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bJMw/qGp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D75813C9B2;
	Wed, 17 Apr 2024 11:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713353837; cv=none; b=eCYoKbx4/9J8JRNvL4fORMlC/kaUom7nxU7M5LQ+c/72S7qAwDbRH48jb+6Z6pwmkfiPxM8NThZ4z2mQ786KC/lDje5vAWcdbBBZx0XU+xyK2NXkzN0B5jTzshAPVOgxAsBYrqHoKirRH4L/LhMEmBDi8fA4v33ABVm6s4JjyhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713353837; c=relaxed/simple;
	bh=ni1rHrQkZPj0oa4mBUOmn8s86m7db/sCZzs6v/o4CR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XkfIxwl9+Pt1c+X27fylONGLeZU01zrNMBx6hlLi8n9gMUYyT0/zrX1cZ3v+zeDDJyWxDBbY5+wuARXgy92uwXcn3JoDrUbWKzhQOfIrIE+4PSoS++Wc9JkhMDKV9KEycfnuG9oDzM7pfUqQrDsohjLQA8lv+ZTxfW2TVkbUalU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bJMw/qGp; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=O4FJeYjzVSrCJLMWVOfo4rKcH+oK+crdFCS4dm+nSJw=; b=bJMw/qGpR0b9/jwlohMK0wYLf1
	3Iwlt7Xkt9gigpNoAdTdquU7sEYatU38PE510DDkwfDrHKtGRQbpAidJD8zSXTfq4tTFDwlgDLXVh
	F4Y3GC71PcDSALfxgIDKtiFbh5WsoIjhmwBOl9qMNila0XmgFv+8lb9bZypVyLO8eapLGebDXE6O7
	lRkgfqEQYfMeV7FRigv654M98vQQzL6C3V2ehXS4ULWzyg9sYCgt0NgCb1yQC7Pbo5Mf0gKAGJKVP
	3p54qePNYQE4fziXioJM6YxOb3p9UMIqBk2fXDPPa5uS43dzqlUATOkKTBpTn5qzbw2y3pOKR0JRf
	5Jpkbk5Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rx3b5-00000002pWR-24HE;
	Wed, 17 Apr 2024 11:37:03 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2553630047C; Wed, 17 Apr 2024 13:37:03 +0200 (CEST)
Date: Wed, 17 Apr 2024 13:37:03 +0200
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
Subject: Re: [PATCH v4 02/27] ntsync: Introduce NTSYNC_IOC_WAIT_ALL.
Message-ID: <20240417113703.GL30852@noisy.programming.kicks-ass.net>
References: <20240416010837.333694-1-zfigura@codeweavers.com>
 <20240416010837.333694-3-zfigura@codeweavers.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416010837.333694-3-zfigura@codeweavers.com>

On Mon, Apr 15, 2024 at 08:08:12PM -0500, Elizabeth Figura wrote:
> +	if (atomic_read(&sem->all_hint) > 0) {
> +		spin_lock(&dev->wait_all_lock);
> +		spin_lock_nest_lock(&sem->lock, &dev->wait_all_lock);
>  
> +		prev_count = sem->u.sem.count;
> +		ret = post_sem_state(sem, args);
> +		if (!ret) {
> +			try_wake_all_obj(dev, sem);
> +			try_wake_any_sem(sem);
> +		}
>  
> +		spin_unlock(&sem->lock);
> +		spin_unlock(&dev->wait_all_lock);
> +	} else {
> +		spin_lock(&sem->lock);
> +
> +		prev_count = sem->u.sem.count;
> +		ret = post_sem_state(sem, args);
> +		if (!ret)
> +			try_wake_any_sem(sem);
> +
> +		spin_unlock(&sem->lock);
> +	}
>  
>  	if (!ret && put_user(prev_count, user_args))
>  		ret = -EFAULT;

vs.

> +	/* queue ourselves */
> +
> +	spin_lock(&dev->wait_all_lock);
> +
> +	for (i = 0; i < args.count; i++) {
> +		struct ntsync_q_entry *entry = &q->entries[i];
> +		struct ntsync_obj *obj = entry->obj;
> +
> +		atomic_inc(&obj->all_hint);
> +
> +		/*
> +		 * obj->all_waiters is protected by dev->wait_all_lock rather
> +		 * than obj->lock, so there is no need to acquire obj->lock
> +		 * here.
> +		 */
> +		list_add_tail(&entry->node, &obj->all_waiters);
> +	}

This looks racy, consider:

	atomic_read(all_hints) /* 0 */

				spin_lock(wait_all_lock)
				atomic_inc(all_hint)	/* 1 */
				list_add_tail()

	spin_lock(sem->lock)
	/* try_wake_all_obj() missing */




I've not yet thought about if this is harmful or not, but if not, it
definitely needs a comment.

Anyway, I need a break, maybe more this evening.



