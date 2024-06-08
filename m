Return-Path: <linux-kselftest+bounces-11492-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F7F901144
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2024 12:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5B83282D88
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2024 10:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111641779BC;
	Sat,  8 Jun 2024 10:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="URCHGk+Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE81F6A33A;
	Sat,  8 Jun 2024 10:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717842188; cv=none; b=SCt6/ESc+v4t3zxQO2VEtyd9JAomw2rf9ROLCtBcqPss3zGJzHbPxW/jn/iQSyDu3jtnDrTo0J0eLN1cNJ1+fbBG4CXp2VwxWhR8lYfxZeFDM1T4D1q2/kEWsjn/gMTFJ5YKS+NDZC/eTnzKgfB3zfZW3sK3/w1Pcok2cEd5r9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717842188; c=relaxed/simple;
	bh=kMbwbEvgIsBDBdaKoxpUGxkOA8e3e1TQoet/J4VzvVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K5FpDMQMtLqNKz8KHcXoEjtY9nelT3MHYwjgVoxBH36NHZFhgjb47bImDbDLOX8ZoD1aG8Oa668el1YvM04DiGUDkcUXv5FtwOPfVxWQibPng/o8ksbnzhDGjvyuNREi7L004y7+QPwdrK104jTJExONsEiVS95+W0/rEJE6gzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=URCHGk+Q; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4VxDfY5NTrz9tKL;
	Sat,  8 Jun 2024 12:23:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1717842181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CN42FyvMLfGhJvGBn6PDLQsQ9W8XHB0kTB0fHm6THX4=;
	b=URCHGk+Q/pp8GE03XIx3TgAxSXlyfltHrc7ciz8ok/N9IWHKZLo0jcuNLFJvMBZea/mOYj
	qTfORTIpOljo+10Nogd6KizUXFUfk0gz1tblu/FuEXezTBb/yvSv0DJ2sEGnEfD7DUGkFe
	3Wdm8FjCTUys9nwkX8Ww6JIxzOdvFN4wDiGkzwpSX7w/3O5wOdlHOsqiRKOYMtwXkLbdCa
	VSTxIlmqKSjtVSe14q1oLJo8nDEiemQDhrYWMMZfu5N6Ug2GSA/zEU7nvs5DVQoHfWbvbL
	3agMAx0T5waM5bF3iVr40vm02yirSz6xVimYGq7aTRQkT+vyp4Xn6Kzu8aKr5w==
Date: Sat, 8 Jun 2024 10:22:57 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org, gost.dev@samsung.com,
	David Hildenbrand <david@redhat.com>, willy@infradead.org,
	mcgrof@kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, Zi Yan <zi.yan@sent.com>,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v3] selftests/mm: use asm volatile to not optimize mmap
 read variable
Message-ID: <20240608102257.edfsoqn7dt4s47p3@quentin>
References: <20240606203619.677276-1-kernel@pankajraghav.com>
 <20240607213936.a58028617aacdbf6913d3735@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607213936.a58028617aacdbf6913d3735@linux-foundation.org>
X-Rspamd-Queue-Id: 4VxDfY5NTrz9tKL

On Fri, Jun 07, 2024 at 09:39:36PM -0700, Andrew Morton wrote:
> On Thu,  6 Jun 2024 20:36:19 +0000 "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com> wrote:
> 
> > From: Pankaj Raghav <p.raghav@samsung.com>
> > 
> > create_pagecache_thp_and_fd() in split_huge_page_test.c used the
> > variable dummy to perform mmap read.
> > 
> > However, this test was skipped even on XFS which has large folio
> > support. The issue was compiler (gcc 13.2.0) was optimizing out the
> > dummy variable, therefore, not creating huge page in the page cache.
> > 
> > Use asm volatile() trick to force the compiler not to optimize out
> > the loop where we read from the mmaped addr. This is similar to what is
> > being done in other tests (cow.c, etc)
> > 
> > As the variable is now used in the asm statement, remove the unused
> > attribute.
> > 
> 
> What are the runtime effects of this change?  An inappropriate test
> failure?  If so, shouldn't we fix 6.9.x kernels also?  And is
> fc4d182316bd ("mm: huge_memory: enable debugfs to split huge pages to
> any order") an appropriate Fixes: target?

I mentioned it here in the commit message:

However, this test was skipped even on XFS which has large folio
support.

So the test just skip these cases and does not fail. That is why I
didn't use the Fixes tag. Let me know if it needs one.

--
Pankaj

