Return-Path: <linux-kselftest+bounces-42016-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 021FCB8D75A
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Sep 2025 10:19:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA9951887332
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Sep 2025 08:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505FA23815D;
	Sun, 21 Sep 2025 08:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b="uOjdlXkb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9684B41A8F;
	Sun, 21 Sep 2025 08:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.59.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758442792; cv=none; b=Rmi5cRVyLhRa3DfkpsIR/obrV9R4BtLY9azL+kUf+7ImnNglGqIQUdQ7DFxqZ0Iahl2dSPSs+3lnzXEzk0OgJLdc7kMsquzHqemyAsCbTNHhjh2LPl9yWkHAS1/QCEE+inwZP6Z97YCwqH9hu259RC99SaJuktCz0kzDwJI259I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758442792; c=relaxed/simple;
	bh=eaOczpgidCzBKUgHgRwKsTdsk2t/MjXYDxOj8DZ/pxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yo4tdbqfKGZtdKeayEYSmI9I0w7g9c/OVjiuusw4wDH2VBw9vxMobPm2WnYFgw2/PuM+KsGnMTKhGOTJ/WY01x3ycfA6btDq07sQaeDr0cq8KfdPRWgTeoblpYPZOJUrS245+j9fVSLPApelxiVWo58uiva7ASZh5RZvtdF619M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b=uOjdlXkb; arc=none smtp.client-ip=51.159.59.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1758442787; bh=jLJuxKB/PPgDic7rB4z6F9PG20pfktyXJQHHD419PVM=;
	h=From:Message-ID:From;
	b=uOjdlXkb4h5eCFeMT4fMig8ZEDmQ2dOZSazY6P5NlAnTrN9FOxideYmLGTYRW2zkX
	 HqUSp8kuIjzAEOcJqcfvS0xm3JcgKN5wFqrs/b6SrgnPUCoSUHC8rUVubzXQ5nbelX
	 Pmb8vlnIAWWRtT6gPbWLJgGYcFX/Xm/0jkFzeTD0=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id 71BEDC072E;
	Sun, 21 Sep 2025 10:19:47 +0200 (CEST)
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 58L8Jlt9016845;
	Sun, 21 Sep 2025 10:19:47 +0200
Date: Sun, 21 Sep 2025 10:19:47 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Benjamin Berg <benjamin@sipsolutions.net>, linux-um@lists.infradead.org,
        linux-kselftest@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org, Benjamin Berg <benjamin.berg@intel.com>
Subject: Re: [PATCH v2 10/11] tools/nolibc: add ptrace support
Message-ID: <20250921081947.GC16684@1wt.eu>
References: <20250919153420.727385-1-benjamin@sipsolutions.net>
 <20250919153420.727385-11-benjamin@sipsolutions.net>
 <eced0e2b-8fb3-490f-bcbe-40a72e430db7@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eced0e2b-8fb3-490f-bcbe-40a72e430db7@t-8ch.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sat, Sep 20, 2025 at 11:27:19AM +0200, Thomas Weißschuh wrote:
> > +/*
> > + * long ptrace(int op, pid_t pid, void *addr, void *data);
> > + *
> > + * However, addr may also be an integer in some cases.
> 
> This comment is a bit confusing. It reads like it can be an integer as
> in 'int' datatype. But the kernel expects an integer compatible with
> 'void *', so 'unsigned long'. I think we can drop the comment.

Or if the point is to insist that void* is not strictly required, a
comment might as well say "types for addr and data are ignored and
will be cast to void*". But given that the man page indicates two
void*, I think that callers are expected to cast ints to void* in
any case, and if so maybe indeed not saying anything about it would
be better.

> > + */
> > +static __attribute__((unused))
> > +long sys_vptrace(int op, pid_t pid, va_list args)
> > +{
> > +	return my_syscall4(__NR_ptrace, op, pid,
> > +			   va_arg(args, void *), va_arg(args, void *));
> > +}
> > +
> > +static __attribute__((unused))
> > +ssize_t sys_ptrace(int op, pid_t pid, ...)
> 
> ptrace(2) does not document addr and data to be optional.
> While it does acknowledge the fact that it is variadic on glibc,
> users are still recommended to always supply all arguments.
> I'd prefer to keep it simple and avoid the va_list.

The man indeed says they are *ignored*, not optional. I agree then that
it would be better not doing simpler than the standard and have to roll
back later. Let's just pass unused arguments to the system.

Thanks,
Willy

