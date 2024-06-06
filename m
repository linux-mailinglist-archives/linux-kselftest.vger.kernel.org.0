Return-Path: <linux-kselftest+bounces-11309-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B628FF5BE
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jun 2024 22:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8049F1C21632
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jun 2024 20:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013F36EB5C;
	Thu,  6 Jun 2024 20:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="O1ZmJ6Rl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D1038F9C;
	Thu,  6 Jun 2024 20:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717705121; cv=none; b=vCJ251qkXfjCMhcDhWyblUdJgjXz8219QplneHKY3QQpSo8QO+DXfSE2eh5N6j7Ysc033+D99bt00OGPc43/mg/qTSy8S0/rHHQ81izIHtn7QDFGmnG0cV0NBvcV/SxR/5oXhSPo5yxroHq/HeOabRrLeaBPFk8uJl2a/F+U99s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717705121; c=relaxed/simple;
	bh=cyu/1xEpXUTxEGqlT0D38XPGikaORzZ2nxSbTMl8Ksc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i3BgZ3rFna4uOe9pC1zNRNhzmFrEjCyYYQJt5nAcMcwJW/V4DRQOxGhtU7qdMS2sDDEsohjsCiAiN68eLzzS2U/L0clQ7oZ/zWeLEhSJ9lGwP9uvKftFdUaPtgRU7htvdHpcmnfRaPmo2W1HdIji0AZGKmQYMz2oOJblKgJBSyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=O1ZmJ6Rl; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4VwFyg0Hnvz9sq3;
	Thu,  6 Jun 2024 22:18:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1717705115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ohDaG0hOCzORTv2Q7Osb5vtnPE6ReKAWi9dBZ7ab1xc=;
	b=O1ZmJ6RlSaIOZnPqzA910/zSq4CkE+BrWOeNVx/EF5z6ns2s5l8/eGtXfKm/IgSB7aQgWh
	tX4O09EFjB0RqCkS8+vnZwUKX42BvYRExY1SAvJSJg6aFJdwdSnhEJ+Yi0SLMXNqmCGHgP
	AR10WbEyD+zM4kInasIOD27qTCyeC18NseUz9ZlG/IpX7BlbQMOCt/eCGu3oXMsIPoGEeD
	A92YRz07AVoOe/9WTPvYABVKoYDSWHdLSc6z+rP5/0drGs6GgGAqdNIOkDRgFma3bMXNln
	pBG4Y5gAHVzaL8EhZ+Sd0OQeJk8xBrfEqDLIBlDO4e6QYQMMQ4nFlXZpD8nw7g==
Date: Thu, 6 Jun 2024 20:18:31 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: David Hildenbrand <david@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, willy@infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	gost.dev@samsung.com, mcgrof@kernel.org,
	linux-kselftest@vger.kernel.org, Zi Yan <zi.yan@sent.com>,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH] selftests/mm: use volatile keyword to not optimize mmap
 read variable
Message-ID: <20240606201831.ywmawi7xl6jgj3p4@quentin>
References: <20240606135835.600022-1-kernel@pankajraghav.com>
 <5b4e7ef2-3ced-4d4a-989c-e99b06598d32@redhat.com>
 <f199d120-2347-4bc0-8940-155c3c465de9@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f199d120-2347-4bc0-8940-155c3c465de9@redhat.com>
X-Rspamd-Queue-Id: 4VwFyg0Hnvz9sq3

On Thu, Jun 06, 2024 at 05:57:21PM +0200, David Hildenbrand wrote:
> On 06.06.24 17:56, David Hildenbrand wrote:
> > On 06.06.24 15:58, Pankaj Raghav (Samsung) wrote:
> > > From: Pankaj Raghav <p.raghav@samsung.com>
> > > 
> > > create_pagecache_thp_and_fd() in split_huge_page_test.c used the
> > > variable dummy to perform mmap read.
> > > 
> > > However, this test was skipped even on XFS which has large folio
> > > support. The issue was compiler (gcc 13.2.0) was optimizing out the
> > > dummy variable, therefore, not creating huge page in the page cache.
> > > 
> > > Add volatile keyword to force compiler not to optimize out the loop
> > > where we read from the mmaped addr.
> > > 
> > > Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> > > ---
> > >    tools/testing/selftests/mm/split_huge_page_test.c | 2 +-
> > >    1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
> > > index d3c7f5fb3e7b..c573a58f80ab 100644
> > > --- a/tools/testing/selftests/mm/split_huge_page_test.c
> > > +++ b/tools/testing/selftests/mm/split_huge_page_test.c
> > > @@ -300,7 +300,7 @@ int create_pagecache_thp_and_fd(const char *testfile, size_t fd_size, int *fd,
> > >    		char **addr)
> > >    {
> > >    	size_t i;
> > > -	int __attribute__((unused)) dummy = 0;
> > > +	volatile int __attribute__((unused)) dummy = 0;
> > >    	srand(time(NULL));
> > > 
> > > base-commit: d97496ca23a2d4ee80b7302849404859d9058bcd
> > 
> > The rick we do in some other tests is:
> > 
> > char *tmp;
> > 
> > tmp = *whatever;
> > asm volatile("" : "+r" (tmp));
> 
> char tmp; of course. See cow.c as an example.
Thanks David! I remember also seeing this when I grepped for volatile in
the selftests directory.

Willy gave the idea of making it as a global variable [1]. But your
trick also works :)

diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
index d3c7f5fb3e7b..9c957703c1f7 100644
--- a/tools/testing/selftests/mm/split_huge_page_test.c
+++ b/tools/testing/selftests/mm/split_huge_page_test.c
@@ -341,6 +341,7 @@ int create_pagecache_thp_and_fd(const char *testfile, size_t fd_size, int *fd,
 
        for (size_t i = 0; i < fd_size; i++)
                dummy += *(*addr + i);
+       asm volatile("" : "+r" (dummy));
 
        if (!check_huge_file(*addr, fd_size / pmd_pagesize, pmd_pagesize)) {
                ksft_print_msg("No large pagecache folio generated, please provide a filesystem supporting large folio\n");

I am fine with either solutions. But using the trick asm volatile is more
cleaner than making it a global variable IMO and makes it more uniform
across the other mm tests.

Let me know what others think.


[1] https://lore.kernel.org/linux-mm/20240606154428.672643-1-kernel@pankajraghav.com/

