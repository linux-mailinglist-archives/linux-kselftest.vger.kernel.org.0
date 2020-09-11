Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC8C265CBC
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Sep 2020 11:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725776AbgIKJqm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Sep 2020 05:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgIKJqm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Sep 2020 05:46:42 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCB3C061573;
        Fri, 11 Sep 2020 02:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NEEs3sphOm5r5iiLL/EE/1iKkrXLyqvJjoXYEVBIkeA=; b=AR8Q0ajzeTXTHvxHzwx2/HKp6G
        nYtbzV0y21U6m9kM52QxCp1XYwqxhxJFNapZLNM2uZNUEYq2pCspiNmqyti2WUOiw1MXIjogYTzSB
        Ry5X9KNf3rQ88rMOf7/BoNucuk/FS5/zy/OIRofIII6eyvn2uX3o3gNuKb/7wrHq1QlZCiUbnRgvP
        DSHkpt0OrpPIJAv/BDXLMxe8xqKxWekRMHopWL3ZiFbCc83w0ksvAmAbDa0xo/88/r7MVCU58Wren
        4s7Gw/g3rNJyVR8F1f6TNSLWTD5j8JVvEmXIq13e2ZxhFkY7CG/CQM4FH1rRfW3XygP3bISzsQdjU
        szKWpiFg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kGfdc-0005tL-Eg; Fri, 11 Sep 2020 09:46:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F0A96305815;
        Fri, 11 Sep 2020 11:46:34 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DBFD72B06B003; Fri, 11 Sep 2020 11:46:34 +0200 (CEST)
Date:   Fri, 11 Sep 2020 11:46:34 +0200
From:   peterz@infradead.org
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     luto@kernel.org, tglx@linutronix.de, keescook@chromium.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, willy@infradead.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v6 6/9] kernel: entry: Support Syscall User Dispatch for
 common syscall entry
Message-ID: <20200911094634.GG1362448@hirez.programming.kicks-ass.net>
References: <20200904203147.2908430-1-krisman@collabora.com>
 <20200904203147.2908430-7-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904203147.2908430-7-krisman@collabora.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Sep 04, 2020 at 04:31:44PM -0400, Gabriel Krisman Bertazi wrote:
> Syscall User Dispatch (SUD) must take precedence over seccomp, since the
> use case is emulation (it can be invoked with a different ABI) such that
> seccomp filtering by syscall number doesn't make sense in the first
> place.  In addition, either the syscall is dispatched back to userspace,
> in which case there is no resource for seccomp to protect, or the
> syscall will be executed, and seccomp will execute next.
> 
> Regarding ptrace, I experimented with before and after, and while the
> same ABI argument applies, I felt it was easier to debug if I let ptrace
> happen for syscalls that are dispatched back to userspace.  In addition,
> doing it after ptrace makes the code in syscall_exit_work slightly
> simpler, since it doesn't require special handling for this feature.

I think I'm with Andy that this should be before ptrace(). ptrace()
users will attempt to interpret things like they're regular syscalls,
and that's definitely not the case.
