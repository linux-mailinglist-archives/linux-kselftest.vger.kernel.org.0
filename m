Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1717A18E5DB
	for <lists+linux-kselftest@lfdr.de>; Sun, 22 Mar 2020 02:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbgCVBnx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 21 Mar 2020 21:43:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:50280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727296AbgCVBnx (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 21 Mar 2020 21:43:53 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F013520754;
        Sun, 22 Mar 2020 01:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584841433;
        bh=Q13b5glXHFBJZs1KR/nBSkLQOAK6lOsqQAlibGsDiWU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=x8BOMsYzf23Ri1SZ98QIxxvV84n0HJHGdEmX14iaF5afC8+0ple2Y5EIotpsEt4H8
         7Kq0tTfa4BqpLHdDMnMpiMfwl2gmY9LWDgD8l/h5RX20/dpyIAKQ187qNOqmmWCk11
         TXOr85yg95o5fw8xXEi+IeXo80241NgGjbivE71g=
Date:   Sat, 21 Mar 2020 18:43:52 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Rafael Aquini <aquini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, shakeelb@google.com
Subject: Re: [PATCH] tools/testing/selftests/vm/mlock2-tests: fix mlock2
 false-negative errors
Message-Id: <20200321184352.826d3dba38aecc4ff7b32e72@linux-foundation.org>
In-Reply-To: <20200322013525.1095493-1-aquini@redhat.com>
References: <20200322013525.1095493-1-aquini@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, 21 Mar 2020 21:35:25 -0400 Rafael Aquini <aquini@redhat.com> wrote:

> Changes for commit 9c4e6b1a7027f ("mm, mlock, vmscan: no more skipping pagevecs")
> break this test expectations on the behavior of mlock syscall family immediately
> inserting the recently faulted pages into the UNEVICTABLE_LRU, when MCL_ONFAULT is
> passed to the syscall as part of its flag-set.
> 
> There is no functional error introduced by the aforementioned commit,
> but it opens up a time window where the recently faulted and locked pages
> might yet not be put back into the UNEVICTABLE_LRU, thus causing a
> subsequent and immediate PFN flag check for the UNEVICTABLE bit
> to trip on false-negative errors, as it happens with this test.
> 
> This patch fix the false negative by forcefully resorting to a code path that
> will call a CPU pagevec drain right after the fault but before the PFN flag
> check takes place, sorting out the race that way.
> 
>  
> +/*
> + * After commit 9c4e6b1a7027f ("mm, mlock, vmscan: no more skipping pagevecs")
> + * changes made by calls to mlock* family might not be immediately reflected
> + * on the LRUs, thus checking the PFN flags might race against pagevec drain.
> + *
> + * In order to sort out that race, and get the after fault checks consistent,
> + * the "quick and dirty" trick below is required in order to force a call to
> + * lru_add_drain_all() to get the recently MLOCK_ONFAULT pages moved to
> + * the unevictable LRU, as expected by the checks in this selftest.
> + */
> +static void force_lru_add_drain_all(void)
> +{
> +	sched_yield();
> +	system("echo 1 > /proc/sys/vm/compact_memory");
> +}

What is the sched_yield() for?

>  static int onfault_check(char *map)
>  {
>  	unsigned long page_size = getpagesize();
> @@ -343,6 +360,9 @@ static int onfault_check(char *map)
>  	}
>  
>  	*map = 'a';
> +
> +	force_lru_add_drain_all();
> +
>  	page1_flags = get_pageflags((unsigned long)map);
>  	page2_flags = get_pageflags((unsigned long)map + page_size);
>  
> @@ -465,6 +485,8 @@ static int test_lock_onfault_of_present()
>  		goto unmap;
>  	}
>  
> +	force_lru_add_drain_all();
> +
>  	page1_flags = get_pageflags((unsigned long)map);
>  	page2_flags = get_pageflags((unsigned long)map + page_size);
>  	page1_flags = get_kpageflags(page1_flags & PFN_MASK);

