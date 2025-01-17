Return-Path: <linux-kselftest+bounces-24724-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65546A15000
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 14:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A20791884475
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 13:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93CA1FFC42;
	Fri, 17 Jan 2025 13:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gB+0yLEX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fZo1H/BE";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gB+0yLEX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fZo1H/BE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18731FECC2;
	Fri, 17 Jan 2025 13:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737118928; cv=none; b=J2fmZ/yyyFL8NdLnTf3VjA6bme560HfolUy4qH9KCcdlxFNVecmMrUa0k8LqyI7/GuFsfLo000nfUz+kU7bD9nNcdIwieujrPwUHwYiiM9lQtwl2yGjJQuXQI2VB3q1jUPrb9Adv4pSAAGFk04atk6fqGkdfH+BS2OafVfMkhf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737118928; c=relaxed/simple;
	bh=/TGUIfympz2OKS1IPNCkcPWm5uZ53OTf55W1LHs+5bY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ImPscL2r2db7Qz7gDybjWc8q287/ygwVPWC0IANn921MRSBCIARiNmqxi7Pd1K/b3wEIKoeu6ETCZLDiP+FbX3L40cb1+DAU1cR8ToYMsV9rTAOo3Mr66PfCCBYU+9MtIdaEUxpx86d64DZmjrss9G0YeS54Jwnhm57Qps1xLHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gB+0yLEX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fZo1H/BE; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gB+0yLEX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fZo1H/BE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from pobox.suse.cz (unknown [10.100.2.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CDA1221177;
	Fri, 17 Jan 2025 13:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737118924; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JgSrgxATeLSMWrnRc+d58QJE+AgqKRYBqUdU25meeXM=;
	b=gB+0yLEXF2s+dZ6ugNySFz7tUpEiyJU2ys49pfpdfHnwn8ZqxJNXCymKHvpf5/QGv4j8sD
	/eKXq/ZXdqjugJz2j9eUyFWv/Fc3pR9l3CLfapeoXCt7YtO7PwIry/AVJNt2TjfUG4vLDY
	wMz6CvhVegJqwY+qZIedRREjLp+Occw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737118924;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JgSrgxATeLSMWrnRc+d58QJE+AgqKRYBqUdU25meeXM=;
	b=fZo1H/BEKSEaEFUQjYrAy7Ye9Zi6rB9/n8du7zJXp3hL9uZV0R6N5jzUAD0RflvIw7AQhz
	Zeh1+dWrD+V8KxBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737118924; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JgSrgxATeLSMWrnRc+d58QJE+AgqKRYBqUdU25meeXM=;
	b=gB+0yLEXF2s+dZ6ugNySFz7tUpEiyJU2ys49pfpdfHnwn8ZqxJNXCymKHvpf5/QGv4j8sD
	/eKXq/ZXdqjugJz2j9eUyFWv/Fc3pR9l3CLfapeoXCt7YtO7PwIry/AVJNt2TjfUG4vLDY
	wMz6CvhVegJqwY+qZIedRREjLp+Occw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737118924;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JgSrgxATeLSMWrnRc+d58QJE+AgqKRYBqUdU25meeXM=;
	b=fZo1H/BEKSEaEFUQjYrAy7Ye9Zi6rB9/n8du7zJXp3hL9uZV0R6N5jzUAD0RflvIw7AQhz
	Zeh1+dWrD+V8KxBg==
Date: Fri, 17 Jan 2025 14:02:04 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
To: Petr Mladek <pmladek@suse.com>
cc: Joe Lawrence <joe.lawrence@redhat.com>, 
    Madhavan Srinivasan <maddy@linux.ibm.com>, jikos@kernel.org, 
    shuah@kernel.org, mpe@ellerman.id.au, npiggin@gmail.com, 
    christophe.leroy@csgroup.eu, naveen@kernel.org, 
    live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org, 
    linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] selftests: livepatch: handle PRINTK_CALLER in
 check_result()
In-Reply-To: <Z4ktTdwl8aqqwZpf@pathway.suse.cz>
Message-ID: <alpine.LSU.2.21.2501171401290.6283@pobox.suse.cz>
References: <20250114143144.164250-1-maddy@linux.ibm.com> <Z4jRisgTXOR5-gmv@pathway.suse.cz> <af77083e-2100-ea2e-ae14-dc5761456fef@redhat.com> <Z4ktTdwl8aqqwZpf@pathway.suse.cz>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -8.30
X-Spamd-Result: default: False [-8.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[redhat.com,linux.ibm.com,kernel.org,ellerman.id.au,gmail.com,csgroup.eu,vger.kernel.org,lists.ozlabs.org];
	RCVD_COUNT_ZERO(0.00)[0];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_EQ_ENVFROM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

Hi,

On Thu, 16 Jan 2025, Petr Mladek wrote:

> On Thu 2025-01-16 08:10:44, Joe Lawrence wrote:
> > On 1/16/25 04:29, Petr Mladek wrote:
> > > On Tue 2025-01-14 20:01:44, Madhavan Srinivasan wrote:
> > >> Some arch configs (like ppc64) enable CONFIG_PRINTK_CALLER, which
> > >> adds the caller id as part of the dmesg. Due to this, even though
> > >> the expected vs observed are same, end testcase results are failed.
> > > 
> > > CONFIG_PRINTK_CALLER is not the only culprit. We (SUSE) have it enabled
> > > as well and the selftests pass without this patch.
> > > 
> > > The difference might be in dmesg. It shows the caller only when
> > > the messages are read via the syslog syscall (-S) option. It should
> > > not show the caller when the messages are read via /dev/kmsg
> > > which should be the default.
> > > 
> > > I wonder if you define an alias to dmesg which adds the "-S" option
> > > or if /dev/kmsg is not usable from some reason.
> > > 
> > 
> > Hi Petr,
> > 
> > To see the thread markers on a RHEL-9.6 machine, I built and installed
> > the latest dmesg from:
> > 
> >   https://github.com/util-linux/util-linux
> > 
> > and ran Madhavan's tests.  I don't think there was any alias involved:
> > 
> >   $ alias | grep dmesg
> >   (nothing)
> > 
> >   $ ~/util-linux/dmesg | tail -n1
> >   [ 4361.322790] [  T98877] % rmmod test_klp_livepatch
> 
> Good to know. I havn't seen this yet.
> 
> > >From util-linux's 467a5b3192f1 ("dmesg: add caller_id support"):
> > 
> >  The dmesg -S using the old syslog interface supports printing the
> >  PRINTK_CALLER field but currently standard dmesg does not support
> >  printing the field if present. There are utilities that use dmesg and
> >  so it would be optimal if dmesg supported PRINTK_CALLER as well.
> > 
> > does that imply that printing the thread IDs is now a (util-linux's)
> > dmesg default?
> 
> It looks like. The caller ID information is available also via
> /dev/kmsg but the older dmesg version did not show it. I guess that
> they just added support to parse and show it. It actually makes
> sense to show the same output independently on whether the messages
> are read via syslog or /dev/kmsg.
> 
> So, we need this patch, definitely ;-)

Yes.

Madhavan, could you add the above findings to the commit log when you 
submit a new version, please?

Thank you,
Miroslav

