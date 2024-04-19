Return-Path: <linux-kselftest+bounces-8459-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2318AB31F
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 18:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FE7C1C20E58
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 16:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1FA1311BC;
	Fri, 19 Apr 2024 16:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="neuR3b4X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E72130AFC;
	Fri, 19 Apr 2024 16:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713543394; cv=none; b=ew6FZPC2TNrEPLD5sYSkO7uf/Y38b2Md+TQrxaIKqumwWpnj8b8q/GxNgO3RWsTlfiE+hGmjA0wEdK2zxM7mF6sx8NzGIkPRSPPEcOA0QGfu2O/Yl3U5fsUj9D8FY8U1yJBW2GVHuf6LoAnTe5YlYk72Wanm4qycNkgKgio2X2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713543394; c=relaxed/simple;
	bh=q617qq5zMo5ijKoNGFf4Z2wYryS175yLupd0rStsqKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MQBiIJFoRMZHhQDYX1hlt4cuFhzsgnV5D3ubzBTJEjJOWARwn7xkbELHpcjdYjpWX7ZFxcxIRZuJ/jSUIqbgfBtXC8MlECtGjjsuEfEKSZ2uyXMCHNwAzTMYBa47T9SCbHlT8pk3u31ZlquJVLWS1I8iFVRWx8qxYi3VWsQ+EtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=neuR3b4X; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=z0uJ2mNKNYe4v74CHFNt2XTUYpLXqH8JD5oBo7CvRlQ=; b=neuR3b4X9U4GAZNRluckQqraLs
	rSH4J4D60AjfeFLroB1/JxSxV/mvVj54ic3cohagIpB8Wus8LlH2ZRgUoEPmVmSi/6XoLfuPcncYr
	7c30ZtTANpUf5A7gMMRu8zAP1C9xRj4lofuWC+KvrjNiZhWr8GKi8q7yMiYgFpxq1UBsi3b32oVh1
	5+XgA1NxBZu7kJEMdsnu+Jv1eZRDslJOasBhK5Ln78vPQ3OGUSLamgSHsUWJntTz9skWNuTyY1mnN
	2hhIJPCAiLJ4lMGO4XQG5OHHVFjh98lIpn8u1y91vbu9AbtxSeYbkjKrtcQeesas6+7XgxgN9X8KE
	bKbjoH6Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxquJ-0000000CVet-3cRa;
	Fri, 19 Apr 2024 16:16:15 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 83EF630043E; Fri, 19 Apr 2024 18:16:11 +0200 (CEST)
Date: Fri, 19 Apr 2024 18:16:11 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Elizabeth Figura <zfigura@codeweavers.com>
Cc: wine-devel@winehq.org, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Wolfram Sang <wsa@kernel.org>, Andy Lutomirski <luto@kernel.org>,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH v4 00/30] NT synchronization primitive driver
Message-ID: <20240419161611.GA23130@noisy.programming.kicks-ass.net>
References: <20240416010837.333694-1-zfigura@codeweavers.com>
 <20240416081421.GB31647@noisy.programming.kicks-ass.net>
 <4340072.ejJDZkT8p0@terabithia>
 <3743440.MHq7AAxBmi@terabithia>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3743440.MHq7AAxBmi@terabithia>

On Tue, Apr 16, 2024 at 05:18:56PM -0500, Elizabeth Figura wrote:
> On Tuesday, 16 April 2024 16:18:24 CDT Elizabeth Figura wrote:
> > On Tuesday, 16 April 2024 03:14:21 CDT Peter Zijlstra wrote:
> > > I don't support GE has it in his builds? Last time I tried, building
> > > Wine was a bit of a pain.
> > 
> > It doesn't seem so. I tried to build a GE-compatible ntsync build, uploaded
> > here (thanks Arek for hosting):
> > 
> >     https://f002.backblazeb2.com/file/wine-ntsync/ntsync-wine.tar.xz
> 
> Oops, the initial version I uploaded had broken paths. Should be fixed now.
> 
> (It's also broken on an unpatched kernel unless explicitly disabled with 
> WINE_DISABLE_FAST_SYNC=1. Not sure what I messed up there—it should fall back 
> cleanly—but hopefully shouldn't be too important for testing.)

So I've tried using that wine build with lutris, and I can't get it to
start EGS or anything else.

I even added a printk to the ntsync driver for every open, to see if it
gets that far, but I'm not even getting that :/


