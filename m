Return-Path: <linux-kselftest+bounces-42032-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C07B8E327
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Sep 2025 20:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC1823BB19B
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Sep 2025 18:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448BC262FE7;
	Sun, 21 Sep 2025 18:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b="hQkV0yRz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6858D2AE6A;
	Sun, 21 Sep 2025 18:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.59.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758479311; cv=none; b=rh/AiyYr/ZH4/SMOaNNbTUNeUcjIcfFvK+eQvNtGPUe88QWnz4NgtSSt67YTbJ/eFLQ3t2xSTz7SCI9C4Se01gfXmyIm8PVOzRdchH2X4lZhyvUit9tjazXK6wfEx5I7noXniFb+liCxBWQaZs0ulx82XEnD4x2X1R0UzvcXhgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758479311; c=relaxed/simple;
	bh=FG1lxChkbhXyDgEWZ5+crnE9F3vtDqK8X7c6k4Aux04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KbX8vFcdAvgR/fBwI8Q+mzOHq8kOfkvslBYNz0rbiYnnQpBzt3BEcr8rDu2WAvYTAKrFQWNqe6ACpbKgFzlhor+mMTevD44VH1m7KKObZHmYr3fS+fRlcyNMsLIdo2zJgvsVJIN+hrtkhWEbjx3sTMryny1+ZUy2C6peKwie9zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b=hQkV0yRz; arc=none smtp.client-ip=51.159.59.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1758479305; bh=BmXXBmIMus/AQCY9Y9SqLz9oz/WtDG9X5Ad9Nc7rYb8=;
	h=From:Message-ID:From;
	b=hQkV0yRzoqv4zMjnqrAkquGTdz73flgfRVhqdMoKN5WJiWdx8+nThwa63csLtvUFw
	 lIpjtAgL9k21WyyE1NQbEbCUsdbHFbf2/X8uAf3DPI/LjU8t5cOx9uq6R0doUN3DNs
	 hNlBOOEwknKN1g13iyeVmreviTf3selOvj/KFcBA=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id E556FC072E;
	Sun, 21 Sep 2025 20:28:24 +0200 (CEST)
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 58LISOAl028613;
	Sun, 21 Sep 2025 20:28:24 +0200
Date: Sun, 21 Sep 2025 20:28:24 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Benjamin Berg <benjamin@sipsolutions.net>, linux-um@lists.infradead.org,
        linux-kselftest@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/11] tools/nolibc/stdio: remove perror if
 NOLIBC_IGNORE_ERRNO is set
Message-ID: <20250921182824.GA28610@1wt.eu>
References: <20250919153420.727385-1-benjamin@sipsolutions.net>
 <20250919153420.727385-4-benjamin@sipsolutions.net>
 <20250921075511.GA16684@1wt.eu>
 <c10503a9-5c63-44a8-9ea7-a7bf6c4ed3fb@t-8ch.de>
 <54d0bf1d1010530941b595129312a56cfdea7c7b.camel@sipsolutions.net>
 <20250921171323.GC28238@1wt.eu>
 <70421908-6300-4df2-a54c-2dca03e8184e@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <70421908-6300-4df2-a54c-2dca03e8184e@t-8ch.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sun, Sep 21, 2025 at 08:26:35PM +0200, Thomas Weißschuh wrote:
> > I'm totally fine with saying that errno shouldn't be defined when building
> > without errno, but all functions must continue to be defined. perror() is
> > used to print an error message, it's a valid use case just as printf() and
> > should remain.
> > 
> > If we disable perror for this, then we must also disable usage of printf
> > for consistency (and I don't want this either).
> 
> Then let's also fix printf(). Benjamin, do you want to add this to your
> series? It should be consitent with the perror() fallback.

Yes that would be great given that the series focuses on fixing errno
usage.

Thanks,
Willy

