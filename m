Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C32A2278645
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Sep 2020 13:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbgIYLuu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Sep 2020 07:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727749AbgIYLut (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Sep 2020 07:50:49 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A5DC0613CE;
        Fri, 25 Sep 2020 04:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=atIdSYTqVSN1dET93QWRtzKrDD+NO7g1yKt3hVPjYBg=; b=kli1xR+OQ0PRUhBLc+8iQpag70
        B5PNVdY+OrX2/xM6ZLwl/uOtK6gZLG+YERi8/mcOfA3VFZiVCTwN/Da8185peOgS6tSZwuCcPPuVR
        Q2i2UrZsUEHdCVKo9HfDzpgUhDCHO2PLnMreNhNf5amRVsfg5HtUBTOus4FkFQ1F0Hr8gaGk9U50d
        WtESu1YZsGsafvP2I4XhbhKNnBKlgmPM5+GIn1n06NJ65l2D6JCq/Bdm3JYetz2F7sw+DyauYGBh9
        f3ln1BkbzA6jFvx/SiGqF03QTADi+MnIFGjoDsF6ER6G4Q8cXaUf9+ZERUWFSkMlXj8nyIuEdvZfh
        CgwNWw+g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kLmFO-0002f2-HQ; Fri, 25 Sep 2020 11:50:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3CCF4302753;
        Fri, 25 Sep 2020 13:50:40 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8DD5720839A41; Fri, 25 Sep 2020 13:50:40 +0200 (CEST)
Date:   Fri, 25 Sep 2020 13:50:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Peter Oskolkov <posk@google.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org, Paul Turner <pjt@google.com>,
        Chris Kennelly <ckennelly@google.com>,
        Peter Oskolkov <posk@posk.io>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v8 1/3] rseq/membarrier: add
 MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ
Message-ID: <20200925115040.GZ2628@hirez.programming.kicks-ass.net>
References: <20200923233618.2572849-1-posk@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923233618.2572849-1-posk@google.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Sep 23, 2020 at 04:36:16PM -0700, Peter Oskolkov wrote:
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -974,7 +974,7 @@ asmlinkage long sys_execveat(int dfd, const char __user *filename,
>  			const char __user *const __user *argv,
>  			const char __user *const __user *envp, int flags);
>  asmlinkage long sys_userfaultfd(int flags);
> -asmlinkage long sys_membarrier(int cmd, int flags);
> +asmlinkage long sys_membarrier(int cmd, int flags, int cpu_id);
>  asmlinkage long sys_mlock2(unsigned long start, size_t len, int flags);
>  asmlinkage long sys_copy_file_range(int fd_in, loff_t __user *off_in,
>  				    int fd_out, loff_t __user *off_out,

The below is required to make arm build... I'll update the patch and
push out again.

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 466c993e52bf..06db09875aa4 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -974,7 +974,7 @@ asmlinkage long sys_execveat(int dfd, const char __user *filename,
 			const char __user *const __user *argv,
 			const char __user *const __user *envp, int flags);
 asmlinkage long sys_userfaultfd(int flags);
-asmlinkage long sys_membarrier(int cmd, int flags, int cpu_id);
+asmlinkage long sys_membarrier(int cmd, unsigned int flags, int cpu_id);
 asmlinkage long sys_mlock2(unsigned long start, size_t len, int flags);
 asmlinkage long sys_copy_file_range(int fd_in, loff_t __user *off_in,
 				    int fd_out, loff_t __user *off_out,
