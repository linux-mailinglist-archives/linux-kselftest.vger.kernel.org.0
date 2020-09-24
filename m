Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94D28276FD1
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Sep 2020 13:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbgIXLYp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Sep 2020 07:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727195AbgIXLYp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Sep 2020 07:24:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F215C0613CE;
        Thu, 24 Sep 2020 04:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LKUxmCaND0rMd4TqkVPk13jipt+snOdJO/HwxFGNvVc=; b=YJTYTmtZYUZeNGEgx90scbS7qo
        5tQ7gYe7tUdKBUnsLlMoUjSiT0KxarH6WQVTUsP8IcdaPPdaKtVPbt6e9nTatqVTBmBFLISAWV8UL
        SGBw3sovX06wUyp+SihgpLVizAnUqIfZQz6XeqzCw6gX7kAWachwju1KoBUGYnV2G/tLxEnRcGt8p
        DdB5eZTHgVDOcowpDRveom1QhQBPRBeAGiE0mLmoPS5gUOBPuHAAhNoGMtVeIykWrUahes6USsO2k
        mAfZp1o5eEMtL7/nkx0rtB91Pyl+Yv8mcYzhFHegOsKGmJ2NV2lvuPkPaDgz3QsUggg/CicbivMC0
        39dIXcLA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kLPMg-0001am-3i; Thu, 24 Sep 2020 11:24:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4EC15300DB4;
        Thu, 24 Sep 2020 13:24:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3BB59203161DB; Thu, 24 Sep 2020 13:24:41 +0200 (CEST)
Date:   Thu, 24 Sep 2020 13:24:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     luto@kernel.org, tglx@linutronix.de, keescook@chromium.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, willy@infradead.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v6 1/9] kernel: Support TIF_SYSCALL_INTERCEPT flag
Message-ID: <20200924112441.GF2628@hirez.programming.kicks-ass.net>
References: <20200904203147.2908430-1-krisman@collabora.com>
 <20200904203147.2908430-2-krisman@collabora.com>
 <20200911093221.GD1362448@hirez.programming.kicks-ass.net>
 <878sdgnkj6.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878sdgnkj6.fsf@collabora.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Sep 11, 2020 at 04:08:45PM -0400, Gabriel Krisman Bertazi wrote:
> peterz@infradead.org writes:
> 
> > On Fri, Sep 04, 2020 at 04:31:39PM -0400, Gabriel Krisman Bertazi wrote:
> >> +static inline void __set_tsk_syscall_intercept(struct task_struct *tsk,
> >> +					   unsigned int type)
> >> +{
> >> +	tsk->syscall_intercept |= type;
> >> +
> >> +	if (tsk->syscall_intercept)
> >> +		set_tsk_thread_flag(tsk, TIF_SYSCALL_INTERCEPT);
> >> +}
> >
> > Did the above want to be:
> >
> > 	unsigned int old = tsk->syscall_intercept;
> > 	tsk->syscall_intercept |= type;
> > 	if (!old)
> > 		set_tsk_thread_flag(tsk, TIF_SYSCALL_INTERCEPT)
> >
> 
> Hi Peter,
> 
> Thanks for the review!
> 
> I'm not sure this change gains us anything.  For now,
> __set_tsk_syscall_intercept cannot be called with !type, so both
> versions behave the same, but my version is safe with that scenario.
> This won't be called frequent enough for the extra calls to
> set_tsk_thread_flag matter.  Am I missing something?

Your version will do set_tsk_thread_flag() for every invocation
(assuming non-zero type). That's sub-optimal.
