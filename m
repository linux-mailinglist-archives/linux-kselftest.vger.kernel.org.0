Return-Path: <linux-kselftest+bounces-10204-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BC98C5DFE
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 01:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 835B6282DC8
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 May 2024 23:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55CF0182C8A;
	Tue, 14 May 2024 23:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="rffGIS+E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16925181D1B;
	Tue, 14 May 2024 23:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715727717; cv=none; b=CZK69uUbFcP38izaa62SNLKkicwQbdUPQFoj2ioTWqY9NHMu7sZ0mZLkO1q3u3qTWJWsVBgqk7p6qsD2hvU4/OvkjNZlxfWNQABSoWuMnL8rlKOP4rrHM/RC42JXuBZmqsqxUt4wUpDO0LKMhNS3iGQFxGWyvqqOz3jPDXDdRic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715727717; c=relaxed/simple;
	bh=ql9IruMwPF3jx//u401rl++FzKZuu5086c7g9sy74LI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=FTM37K9i7IWAEraH2xaDiSBVl0YH1qpbF4de+KvzN6H8+fUyc/5S29N1F4+3xv2r/XSk/LLdlo4dpJ0Xt4EWxSJ/bJAHt8d0jLfZ5mAQf2nXxHgY5fjrN8r5CnbtTwSmx6Y43RUNjXXOeKY07oUPozL5jVnaq7yeFfDA7eYM+sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=rffGIS+E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E06DAC2BD10;
	Tue, 14 May 2024 23:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1715727716;
	bh=ql9IruMwPF3jx//u401rl++FzKZuu5086c7g9sy74LI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rffGIS+E3mt0Fj4i8hRGK7jzBkFBu2+Ts1IckYH+2iO2fXNtNyBfKYrztj3owuT+k
	 kqYni2rDFcl3C36xXwrddcU8GIRwb+1suRtTtsCyCLSAhH3qfBTQkP2NqqbRK7wr5S
	 05wHzwQfae2uVTicAuWCNkfDhPt5c6OFgiLGDU/I=
Date: Tue, 14 May 2024 16:01:50 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Theo de Raadt" <deraadt@openbsd.org>
Cc: Matthew Wilcox <willy@infradead.org>, Jonathan Corbet <corbet@lwn.net>,
 jeffxu@chromium.org, keescook@chromium.org, jannh@google.com,
 sroettger@google.com, gregkh@linuxfoundation.org,
 torvalds@linux-foundation.org, usama.anjum@collabora.com,
 Liam.Howlett@oracle.com, surenb@google.com, merimus@google.com,
 rdunlap@infradead.org, jeffxu@google.com, jorgelo@chromium.org,
 groeck@chromium.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 pedro.falcato@gmail.com, dave.hansen@intel.com,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH v10 0/5] Introduce mseal
Message-Id: <20240514160150.3ed0fda8af5cbd2f17c625e6@linux-foundation.org>
In-Reply-To: <56001.1715726927@cvs.openbsd.org>
References: <20240415163527.626541-1-jeffxu@chromium.org>
	<20240514104646.e6af4292f19b834777ec1e32@linux-foundation.org>
	<871q646rea.fsf@meer.lwn.net>
	<ZkPXcT_JuQeZCAv0@casper.infradead.org>
	<56001.1715726927@cvs.openbsd.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 May 2024 16:48:47 -0600 "Theo de Raadt" <deraadt@openbsd.org> wrote:

> Matthew Wilcox <willy@infradead.org> wrote:
> 
> > > Not taking a position on merging, but I have to ask: are we convinced at
> > > this point that mseal() isn't a chrome-only system call?  Did we ever
> > > see the glibc patches that were promised?
> > 
> > I think _this_ version of mseal() is OpenBSD's mimmutable() with a
> > basically unused extra 'flags' argument.  As such, we have an existance
> > proof that it's useful beyond Chrome.
> 
> Yes, it is close enough.
> 
> > I think Liam still had concerns around the
> > walk-the-vmas-twice-to-error-out-early part of the implementation?
> > Although we can always fix the implementation later; changing the API
> > is hard.
> 
> Yes I am a bit worried about the point Liam brings up -- we've discussed
> it privately at length.  Matthew, to keep it short I have a different
> viewpoint:
> 
> Some of the Linux m* system calls have non-conforming, partial-work-then-return-error
> behaviour.  I cannot find anything like this in any system call in any other
> operating system, and I believe there is a defacto rule against doing this, and
> Linux has an optimization which violating this, and I think it could be fixed
> with fairly minor expense, and can't imagine it affecting a single application.

Thanks.

> I worry that the non-atomicity will one day be used by an attacker.

How might an attacker exploit this?

