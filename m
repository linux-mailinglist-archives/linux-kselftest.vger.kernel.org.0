Return-Path: <linux-kselftest+bounces-31480-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E719A99E08
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 03:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 178CA5A507B
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 01:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97E741C7F;
	Thu, 24 Apr 2025 01:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="cCHZFTlE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DD22701A5
	for <linux-kselftest@vger.kernel.org>; Thu, 24 Apr 2025 01:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745457749; cv=none; b=IU98WplUceWWqU2GiVvQMing18LeYSvBvc6l1qb4l8t9aYYHs8BiWbMVTe0D53r3BNZ8ovAZSTBeI5kRV8dLYjd9rVAZ0ejyE5rM6DhBu6PwylqTBPneqmsbcNMA6gxWSBL6KDmo4ND72BhgEgA0lnj3Z2zjn+M5BQC058Qcbcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745457749; c=relaxed/simple;
	bh=x3oa0QzQ8q6ab35dz21+IMSIiG4fK6tDUNSCAz2hTWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nzdapQ6/UQVY3QHn8YwXgxD27U6KHcuvPeiJ7MFm6RmNW8MWVYwFRfCYeLUaN3G26OCUFlJg65roxjV8c1dxSMqyx4P2NpysndSTngePN8LBYazm43rjj2wkVQ+F/poBi+mw4H4YoVsdSbW1nRBekdCqDJ7A3mg//Qxf+jt1YL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=cCHZFTlE; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1745457737; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=KX1QHUDprEsYXUHZIvm/vNoDUcOH0o5aczS6FmAUxwE=;
	b=cCHZFTlEzGOR9DJuld5lKogk6aNTcdsg+umPd4EJYpxpPzVPj/2UkvihkbnCFAPkdyStfgxu2kYA6JKI3CE3VsdKGutdh3MSUR+qSDDZn5zLqc8yMgyDoLd1ZspzqVztLc8kq/SQME1UDP9sCi+lpIg1rdjcB5x4COD5ARegEzc=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WXwD2Nt_1745457736 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 24 Apr 2025 09:22:16 +0800
Date: Thu, 24 Apr 2025 09:22:15 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Dev Jain <dev.jain@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Sri Jayaramappa <sjayaram@akamai.com>, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, baolin.wang@linux.alibaba.com
Subject: Re: [PATCH] selftests/mm: compaction_test: Support platform with
 huge mount of memory
Message-ID: <aAmSR628K9rwplVF@U-2FWC9VHC-2323.local>
References: <20250423103645.2758-1-feng.tang@linux.alibaba.com>
 <9260687a-0126-412c-aff2-9a5b358eaca9@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9260687a-0126-412c-aff2-9a5b358eaca9@arm.com>

On Wed, Apr 23, 2025 at 04:33:19PM +0530, Dev Jain wrote:
> 
> 
> On 23/04/25 4:06 pm, Feng Tang wrote:
> > When running mm selftest to verify mm patches, 'compaction_test' case
> > failed on an x86 server with 1TB memory. And the root cause is that it
> > has too much free memory than what the test supports.
> > 
> > The test case tries to allocate 100000 huge pages, which is about 200 GB
> > for that x86 server, and when it succeeds, it expects it's large than
> > 1/3 of 80% of the free memory in system. This logic only works for
> > platform with 750 GB ( 200 / (1/3) / 80% ) or less free memory, and may
> > raise false alarm for others.
> > 
> > Fix it by changing the fixed page number to self-adjustable number
> > according to the real number of free memory.
> > 
> > Fixes: bd67d5c15cc19 ("Test compaction of mlocked memory")
> > Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>
> 
> Not sure if fixes tag is needed.

Yep, I was not very sure either :). And I'm fine with dropping the tag.

> 
> Acked-by: Dev Jain <dev.jain@arm.com>
 
Many thanks for the review!

- Feng

> > ---
> >   tools/testing/selftests/mm/compaction_test.c | 19 ++++++++++++++-----
> >   1 file changed, 14 insertions(+), 5 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/mm/compaction_test.c b/tools/testing/selftests/mm/compaction_test.c
> > index 2c3a0eb6b22d..9bc4591c7b16 100644
> > --- a/tools/testing/selftests/mm/compaction_test.c
> > +++ b/tools/testing/selftests/mm/compaction_test.c
> > @@ -90,6 +90,8 @@ int check_compaction(unsigned long mem_free, unsigned long hugepage_size,
> >   	int compaction_index = 0;
> >   	char nr_hugepages[20] = {0};
> >   	char init_nr_hugepages[24] = {0};
> > +	char target_nr_hugepages[24] = {0};
> > +	int slen;
> >   	snprintf(init_nr_hugepages, sizeof(init_nr_hugepages),
> >   		 "%lu", initial_nr_hugepages);
> > @@ -106,11 +108,18 @@ int check_compaction(unsigned long mem_free, unsigned long hugepage_size,
> >   		goto out;
> >   	}
> > -	/* Request a large number of huge pages. The Kernel will allocate
> > -	   as much as it can */
> > -	if (write(fd, "100000", (6*sizeof(char))) != (6*sizeof(char))) {
> > -		ksft_print_msg("Failed to write 100000 to /proc/sys/vm/nr_hugepages: %s\n",
> > -			       strerror(errno));
> > +	/*
> > +	 * Request huge pages for about half of the free memory. The Kernel
> > +	 * will allocate as much as it can, and we expect it will get at least 1/3
> > +	 */
> > +	nr_hugepages_ul = mem_free / hugepage_size / 2;
> > +	snprintf(target_nr_hugepages, sizeof(target_nr_hugepages),
> > +		 "%lu", nr_hugepages_ul);
> > +
> > +	slen = strlen(target_nr_hugepages);
> > +	if (write(fd, target_nr_hugepages, slen) != slen) {
> > +		ksft_print_msg("Failed to write %lu to /proc/sys/vm/nr_hugepages: %s\n",
> > +			       nr_hugepages_ul, strerror(errno));
> >   		goto close_fd;
> >   	}

