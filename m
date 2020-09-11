Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0694265CB5
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Sep 2020 11:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725770AbgIKJoh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Sep 2020 05:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgIKJoh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Sep 2020 05:44:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A6FC061573;
        Fri, 11 Sep 2020 02:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=R2qGF7yERmMAU8dGcjKeKqRGk5IWwYFjQLOwCzYOvew=; b=nlrxSROIaG+nAIAL365fVBrVNP
        AK6QNG8gmrAANAQW8v+1ItEcHuCoLR7ztlhn3Bcqq8pHy/zBUDaekucUvrVQzycr2GVW3ss3qL1go
        1NBysp8+kAjTtZLh3IdrjNbSXTKIyHbJ5dl+5Z5LFgR59N+s8AaWifub4I+7hg3iIkCHjGFKt6f8B
        xYbVtvQdwt6xKTUKZdOQJq3YzKAhEPIgEv0r7d/TjgF1ylq2lkjJThllLOS4xM5bF7PLdmX9YDq0d
        5prNXsUxp02n8N9E6ZkF2dEPacKESmy4jyFUwLuM7+x6reR8GtDuyMDmUOmLwuRHpPUNO1rnvrAov
        5FHZcWIw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kGfbc-0003k6-Kt; Fri, 11 Sep 2020 09:44:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 749623050F0;
        Fri, 11 Sep 2020 11:44:31 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5F21C2B06B001; Fri, 11 Sep 2020 11:44:31 +0200 (CEST)
Date:   Fri, 11 Sep 2020 11:44:31 +0200
From:   peterz@infradead.org
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     luto@kernel.org, tglx@linutronix.de, keescook@chromium.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, willy@infradead.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        kernel@collabora.com, Paul Gofman <gofmanp@gmail.com>
Subject: Re: [PATCH v6 5/9] kernel: Implement selective syscall userspace
 redirection
Message-ID: <20200911094431.GF1362448@hirez.programming.kicks-ass.net>
References: <20200904203147.2908430-1-krisman@collabora.com>
 <20200904203147.2908430-6-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904203147.2908430-6-krisman@collabora.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Sep 04, 2020 at 04:31:43PM -0400, Gabriel Krisman Bertazi wrote:

> +struct syscall_user_dispatch {
> +	char __user *selector;
> +	unsigned long dispatcher_start;
> +	unsigned long dispatcher_end;
> +};

> +int do_syscall_user_dispatch(struct pt_regs *regs)
> +{
> +	struct syscall_user_dispatch *sd = &current->syscall_dispatch;
> +	unsigned long ip = instruction_pointer(regs);
> +	char state;
> +
> +	if (likely(ip >= sd->dispatcher_start && ip <= sd->dispatcher_end))
> +		return 0;

If you use {offset,size}, instead of {start,end}, you can write the
above like:

	if (ip - sd->dispatcher_offset < sd->dispatcher_size)
		return 0;

which is just a single branch.

