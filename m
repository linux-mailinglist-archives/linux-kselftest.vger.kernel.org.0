Return-Path: <linux-kselftest+bounces-8241-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 399AF8A7BE0
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Apr 2024 07:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2910285282
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Apr 2024 05:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356E3524DE;
	Wed, 17 Apr 2024 05:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kpBQIcuV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89AF52F62;
	Wed, 17 Apr 2024 05:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713331797; cv=none; b=TbdQl8hYTJj/4+Pg53BkQscjn1IrPuRDcZwa/MF6Vja0dm3LhliKWkSwLGLusOOtwikOu2uqkvz9G4tlq5vSFKwa4zo2ZLXkmFHj8e5ZMmx6gEV85p8deY+tQh6Q0v3RQK1JDuYXGi1t0ALy2qZkKUBAxKoCmUzUZeGoUM0uoDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713331797; c=relaxed/simple;
	bh=weqydP0eb3rEOce8N5EeNv8gpJqd5E3/fPPd4LRA/i0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lhZvcVdM/CCVeoPu4c1VBFq9qthdIZ0kLsIV3zymE+/QAV9CpFZixN0Mcve7vqN+1sRUjm+6ShPa2b+OI3UQ+kHbgKjg3uDfdzB/+6f8ifsxfMwAGIN+evc5gvD5n+4+MyDy8xLnKLSn5ptwORxax20gOgAXjhlpXiplMyxNhsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kpBQIcuV; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gpxivsdp+mN00C3q1/pka6Me/n6JWPp7eC0c08fzrcw=; b=kpBQIcuVe20vaqV3uRycXoYE3d
	Ex350cgW3fwTebGyDdeB+2NRi4rOUHrM0Vhus2om7VvaT3O7JJOuw9xDrdZwEYS4xAcD3ftfIQKll
	7a7TDOJUwKBJ7T3gWet3sdvN2iVY3x1nFusogp7OFvLYBNBzAJNko3k4pBNH4Aru1UC5OKnGBD5Vi
	ytm359kDssgG9O9lCx6ol5LCcVNCD+XOz02ZDHEEvrLkPw7Ft82tJ8eUAPHviRygadbyj3QCz41QU
	ZFNVR794ss80QIqFM53mq9x0xaqjmgZS1pN7wjAP0fFrGZUnXOBCO0kgfk8LptuO8O+z0u4Blotsk
	ivC12Z4w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwxmf-0000000BPQt-4BjR;
	Wed, 17 Apr 2024 05:27:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 91AAC30040C; Wed, 17 Apr 2024 07:24:37 +0200 (CEST)
Date: Wed, 17 Apr 2024 07:24:37 +0200
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
Message-ID: <20240417052437.GJ30852@noisy.programming.kicks-ass.net>
References: <20240416010837.333694-1-zfigura@codeweavers.com>
 <20240416081421.GB31647@noisy.programming.kicks-ass.net>
 <4340072.ejJDZkT8p0@terabithia>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4340072.ejJDZkT8p0@terabithia>

On Tue, Apr 16, 2024 at 04:18:24PM -0500, Elizabeth Figura wrote:

> Is the concern about poor performance when ntsync is in use, or is nesting a 
> lot of spinlocks like that something that could cause problems for unrelated 
> tasks? I'm not familiar enough with the scheduler to know if this can be 
> abused.

The problem is keeping preemption disabled for potentially a fairly long
time. By doing that you potentially affect the performance of other tasks.

