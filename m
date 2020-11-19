Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE352B92A2
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Nov 2020 13:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbgKSMgM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Nov 2020 07:36:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbgKSMgL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Nov 2020 07:36:11 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA455C0613CF;
        Thu, 19 Nov 2020 04:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=prYI31egyLxulVNZTSFWVHHVZvnIZTtRH4T/WwIN/DM=; b=IIYlIN6x2njHzskqq2Z5UBEZc1
        Nc6mldpXYaJOmvSbRMghosebbnVBg5Dfgk6QoUAjo08Zge3TIFiWw7u/ihdMBwLSUH1iAyuUulw2r
        ni0aqb0n9XRPcoH0Dp0H8sQ3UouinABYv2ahL/IO8UVCc8piU5349l/yF/IzTiJYVn+VJmsMynCo2
        QJ6TXPPcCWOxdQLPzL8uY8sJagFICdVRFnNEixIisZ7EW4BL71nSffwPF8GQlUdjlDF9cxyA6Pgvr
        z6Be+3ojGYSZ2a+VvwCWr2i4VJgIX2zkDx1iTxlx68AVdJHDZGKR36l2vJVPuAbr1cKQUSnPxFD84
        E+uBY9DQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kfjAR-00015e-30; Thu, 19 Nov 2020 12:36:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4FDB13011C6;
        Thu, 19 Nov 2020 13:36:02 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 388092BC7366A; Thu, 19 Nov 2020 13:36:02 +0100 (CET)
Date:   Thu, 19 Nov 2020 13:36:02 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     luto@kernel.org, tglx@linutronix.de, keescook@chromium.org,
        christian.brauner@ubuntu.com, willy@infradead.org,
        shuah@kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kselftest@vger.kernel.org,
        x86@kernel.org, gofmanp@gmail.com, kernel@collabora.com
Subject: Re: [PATCH v7 3/7] kernel: Implement selective syscall userspace
 redirection
Message-ID: <20201119123602.GK3121392@hirez.programming.kicks-ass.net>
References: <20201118032840.3429268-1-krisman@collabora.com>
 <20201118032840.3429268-4-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118032840.3429268-4-krisman@collabora.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 17, 2020 at 10:28:36PM -0500, Gabriel Krisman Bertazi wrote:
>   prctl(PR_SET_SYSCALL_USER_DISPATCH, <op>, <off>, <length>, [selector])
> 
> The range [<offset>,<offset>+len] is a part of the process memory map

> +	if (likely(instruction_pointer(regs) - sd->offset < sd->len))
> +		return false;

The actual implementation ^ is: [<offset>, <offset>+<length>).

Which seems consistent and right, so I would suggest simply changing the
Changelog, something that could be done when applying.
