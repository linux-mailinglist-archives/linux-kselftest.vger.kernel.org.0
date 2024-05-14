Return-Path: <linux-kselftest+bounces-10198-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DC18C5CC5
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 May 2024 23:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8755528300D
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 May 2024 21:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AB8181CEB;
	Tue, 14 May 2024 21:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="r+ym+12D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A36181BA3;
	Tue, 14 May 2024 21:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715722110; cv=none; b=mX2PLX3wUjdDbB5i7EhJaQLKKDc57/2ionjlCF+Yye4EjKAdZuPCKNzLWMCeK4LXGD7CBIHLhN2aZKJUt2aQAVw0N/aBAF2rljKcQL/gxJ0xDXmzaxLilkacVRoAYP18sbK9VSzkITwQLQgxkkU4ObTIFVjVyY05Pip5j60DjIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715722110; c=relaxed/simple;
	bh=v0RcfcwgjnK6DXraXfbbO0hweNJe7AtF6Td2ScAX+f4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uUtcLR2/oedZ+njjW3EUM2WB8doNR8TRubuNCMCYZWgUfc9AfXvF0zz1jPtVpBZcsAOVY5JSDySm2Id0SuBVOwcqiodVsbwtvUc7QXZX/IWZV8J3HCWPvbQfEAQKOLWULt0rS/wvS9IXPcDPbY2lrYNw1mJA/UJhpyzN/fqbi78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=r+ym+12D; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=18MZUUawb/h4MdJ2B0MrgZRDL4PYAEDgDX9KON4i6lc=; b=r+ym+12DadmXIqEpLKf2643jfL
	vyQHT+0RozPUfuV+RVz0aW6W8NuvhWmjpAgP7GeFcXlmaVBgCz/9eW6kfqGkGbXPF2QhtH3+J08rY
	ydmGCoc/qzLKre6U7YSK6rkO1m/SmtV0REeYhGVbZwgPeu8a1j2M680C+hed2l2cD6g8Wy22mKPvN
	qhPd9bzVX5ZScN/8atD34ZEXC4GDUKFEJ8jo4w73HhFLzfm3tkTBHbKpeoK8ggAgFS9bwvHEdaso9
	nziKaHoELR3qKSgWGMgI5TNPaWcpkGJXCcX+/SZM9qtVMubjtpzZG9Dk6cyvwIbDa1uZRbflV893d
	c/oZ/jxA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6zh3-00000009WDa-3cXA;
	Tue, 14 May 2024 21:28:18 +0000
Date: Tue, 14 May 2024 22:28:17 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, jeffxu@chromium.org,
	keescook@chromium.org, jannh@google.com, sroettger@google.com,
	gregkh@linuxfoundation.org, torvalds@linux-foundation.org,
	usama.anjum@collabora.com, Liam.Howlett@oracle.com,
	surenb@google.com, merimus@google.com, rdunlap@infradead.org,
	jeffxu@google.com, jorgelo@chromium.org, groeck@chromium.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, pedro.falcato@gmail.com, dave.hansen@intel.com,
	linux-hardening@vger.kernel.org, deraadt@openbsd.org
Subject: Re: [PATCH v10 0/5] Introduce mseal
Message-ID: <ZkPXcT_JuQeZCAv0@casper.infradead.org>
References: <20240415163527.626541-1-jeffxu@chromium.org>
 <20240514104646.e6af4292f19b834777ec1e32@linux-foundation.org>
 <871q646rea.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871q646rea.fsf@meer.lwn.net>

On Tue, May 14, 2024 at 02:59:57PM -0600, Jonathan Corbet wrote:
> Andrew Morton <akpm@linux-foundation.org> writes:
> 
> > On Mon, 15 Apr 2024 16:35:19 +0000 jeffxu@chromium.org wrote:
> >
> >> This patchset proposes a new mseal() syscall for the Linux kernel.
> >
> > I have not moved this into mm-stable for a 6.10 merge.  Mainly because
> > of the total lack of Reviewed-by:s and Acked-by:s.
> >
> > The code appears to be stable enough for a merge.
> >
> > It's awkward that we're in conference this week, but I ask people to
> > give consideration to the desirability of moving mseal() into mainline
> > sometime over the next week, please.
> 
> I hate to be obnoxious, but I *was* copied ... :)
> 
> Not taking a position on merging, but I have to ask: are we convinced at
> this point that mseal() isn't a chrome-only system call?  Did we ever
> see the glibc patches that were promised?

I think _this_ version of mseal() is OpenBSD's mimmutable() with a
basically unused extra 'flags' argument.  As such, we have an existance
proof that it's useful beyond Chrome.

I think Liam still had concerns around the
walk-the-vmas-twice-to-error-out-early part of the implementation?
Although we can always fix the implementation later; changing the API
is hard.

