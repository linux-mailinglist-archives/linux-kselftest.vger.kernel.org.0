Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70500265C82
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Sep 2020 11:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725770AbgIKJcc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Sep 2020 05:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgIKJc3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Sep 2020 05:32:29 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B2DC061573;
        Fri, 11 Sep 2020 02:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=byQIC6UgJWmseFC9nmbs7RXzJK3qdkILERsCoHCugWs=; b=ZQQgMBfS9f9fKGY16bSRLKCWq1
        di1lXzV9qLQwRVhx8rKhL5OEqPI40hatWWKJuXZQQ5T3BNIVVheCCUg3aV2SQPk6kRDQsMzhE0I8N
        3SjYXRORXxuErboIWUpQAq6vztkTGTcbHVENERQl6Thbgotic4jL/3dldPKzMixUYr/U7j3nGzx7R
        g5BzVFC1Bk7IelEby7CMrUBxgygWVvshaWuR8O6aL2aZhEhSc7RYy2dsuvGddS9pIJ+QRUmjMm++x
        vsqiYNJPEjwajyMaC+jG54on15/cFnP2rzHLO0VME7+N10ITOsT/Us4xi2tcBfSiLfNfvnADx5xd/
        MmeLgxcg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kGfPr-0002xq-6V; Fri, 11 Sep 2020 09:32:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 59F22303DA0;
        Fri, 11 Sep 2020 11:32:21 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4C4F62B06AFFE; Fri, 11 Sep 2020 11:32:21 +0200 (CEST)
Date:   Fri, 11 Sep 2020 11:32:21 +0200
From:   peterz@infradead.org
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     luto@kernel.org, tglx@linutronix.de, keescook@chromium.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, willy@infradead.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v6 1/9] kernel: Support TIF_SYSCALL_INTERCEPT flag
Message-ID: <20200911093221.GD1362448@hirez.programming.kicks-ass.net>
References: <20200904203147.2908430-1-krisman@collabora.com>
 <20200904203147.2908430-2-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904203147.2908430-2-krisman@collabora.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Sep 04, 2020 at 04:31:39PM -0400, Gabriel Krisman Bertazi wrote:
> +static inline void __set_tsk_syscall_intercept(struct task_struct *tsk,
> +					   unsigned int type)
> +{
> +	tsk->syscall_intercept |= type;
> +
> +	if (tsk->syscall_intercept)
> +		set_tsk_thread_flag(tsk, TIF_SYSCALL_INTERCEPT);
> +}

Did the above want to be:

	unsigned int old = tsk->syscall_intercept;
	tsk->syscall_intercept |= type;
	if (!old)
		set_tsk_thread_flag(tsk, TIF_SYSCALL_INTERCEPT)

?

> +static inline void __clear_tsk_syscall_intercept(struct task_struct *tsk,
> +					     unsigned int type)
> +{
> +	tsk->syscall_intercept &= ~type;
> +
> +	if (tsk->syscall_intercept == 0)
> +		clear_tsk_thread_flag(tsk, TIF_SYSCALL_INTERCEPT);
> +}
