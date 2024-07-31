Return-Path: <linux-kselftest+bounces-14580-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED509437C1
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 23:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC2811F22F01
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 21:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2562816B3BF;
	Wed, 31 Jul 2024 21:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="snr4hs8v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369E9208D1;
	Wed, 31 Jul 2024 21:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722461018; cv=none; b=tLhoVqKhWZU6P/DHWrV3schxdAaq/TN7h6H1oGXFe8rSXURMF37AEIQIeEofTBYrqXCCfdDShKxMt0YVhVXm0OhbVTyX28iPLCbjbBFzPvvJ40jq6BJ/YUdG1PxzHRF69WVqSi8BQCgQMSwmGs8sFZL6tpR67o3yzNTz2k0VzxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722461018; c=relaxed/simple;
	bh=osoUFGGb18R2Lb9zuekVkl7jBzHtvin4+eWyeWpzfkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GjnaDR7cQNCuN/ezYa39UaDMW2v+/kiPsIg9RPjcsd0OF224vcPXYf4DNjbuqRF6S8ZqPT4yPQOo9/g/9iwATHHJoSmP4/wGDd2saDYBwxnZUSRzgwOcP+mAsKT9iG+peFH0YuH5mEnSf/JcUs6zBgC5iUEC/h9QJVFNU7YMScI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=snr4hs8v; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=s+phKS5FVZBLaCYfZ7urh2US5nBaT+rwZbSHvhzsxtI=; b=snr4hs8v5N7wl0yV3/1mVU6t8n
	8S4Ygp1IvdyVJpeVk+EZ3EBQoIM/9VLM6ZkOMmhiM5FbLV1OXLzq/TExbtDZUzxuW1H/Zz97erPLA
	EzdR+j1vAqdCl23pd9Sknpw+v1C9a+eWgixEYldll1I57L79jscB0o+Wvmv5ux8rVao9nr1YFylvl
	5+Gl+Mny0L61KjqwvrBxQByKIr2JzO1N1GgBo+AXBljRwrzyJQ6lfiz1ZpW8utXGgCxUJGsRO5PAF
	ajcKC9gjn/3GZvNXL2ESIWF3amIJFzlPBhC3qgYf6AoeJJw47gBp0zhnO2HEU+ZXluhI4jQpbTCZp
	EDY9r07w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZGn8-0000000Ga75-3fz1;
	Wed, 31 Jul 2024 21:23:26 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 056E9300820; Wed, 31 Jul 2024 23:23:26 +0200 (CEST)
Date: Wed, 31 Jul 2024 23:23:25 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kernel@collabora.com
Subject: Re: [PATCH] MAINTAINERS: Add selftests/x86 entry
Message-ID: <20240731212325.GY40213@noisy.programming.kicks-ass.net>
References: <20240610052810.1488793-1-usama.anjum@collabora.com>
 <83d0c57a-dd87-42eb-935a-e4104c17a5ed@collabora.com>
 <3518e3ef-3444-419d-94ce-331f4e7fb391@collabora.com>
 <257c9106-c33a-46c1-9761-111505309176@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <257c9106-c33a-46c1-9761-111505309176@linuxfoundation.org>

On Wed, Jul 31, 2024 at 12:14:16PM -0600, Shuah Khan wrote:
> On 7/31/24 07:42, Muhammad Usama Anjum wrote:
> > Kind reminder
> > 
> > On 7/2/24 3:17 PM, Muhammad Usama Anjum wrote:
> > > Kind reminder
> 
> Top post ???
> 
> > > 
> > > On 6/10/24 10:28 AM, Muhammad Usama Anjum wrote:
> > > > There are no maintainers specified for tools/testing/selftests/x86.
> > > > Shuah has mentioned [1] that the patches should go through x86 tree or
> > > > in special cases directly to Shuah's tree after getting ack-ed from x86
> > > > maintainers. Different people have been confused when sending patches as
> > > > correct maintainers aren't found by get_maintainer.pl script. Fix
> > > > this by adding entry to MAINTAINERS file.
> > > > 
> > > > [1] https://lore.kernel.org/all/90dc0dfc-4c67-4ea1-b705-0585d6e2ec47@linuxfoundation.org
> > > > 
> > > > Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> > > > ---
> > > >   MAINTAINERS | 1 +
> > > >   1 file changed, 1 insertion(+)
> > > > 
> 
> Applied to linux-kselftest next for Linux 6.12-rc1.

You are applying things for the x86 entry, without an x86 ack, srsly?

