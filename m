Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 531A52B92A7
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Nov 2020 13:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbgKSMic (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Nov 2020 07:38:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbgKSMib (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Nov 2020 07:38:31 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC88AC0613CF;
        Thu, 19 Nov 2020 04:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EXnB16mLl4Y+IqQmV0xsRFSOkOPyaDc6osJseO3iLTI=; b=drrbmnTRqep/Do0FL85M9Uvcah
        ThoUFK+/hVu6fq5mx7QmjXlr/llb5xABXDrf+Ch1e4pFCS+wBPGr+JhT5o0a/7cnltGgyez8wmMfS
        yhh5G2fj/TTBExpJUgIDpU3Gkjg3XdS/ogMjpERgHx1tmrhCCCs2Al2hsFrRsdr8bMq7l2AWysDds
        q4aaZ3EggGAR2St1Mukeq47OXdk0Kxb0id0GnZ2Rw6baevqicgqnFkpf1zTRzrjxrNwc2hLkW8WaA
        afj9p4GZVPoQpJQbx8nvbW4ypTlILNsinOPaZjlhsVt0wmo27g35kCmLNiltfPa7xfLMbwJx6ByDW
        rHmWa6MQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kfjCm-0001BQ-NF; Thu, 19 Nov 2020 12:38:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 17F8C3019CE;
        Thu, 19 Nov 2020 13:38:28 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 035712C12590E; Thu, 19 Nov 2020 13:38:27 +0100 (CET)
Date:   Thu, 19 Nov 2020 13:38:27 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     luto@kernel.org, tglx@linutronix.de, keescook@chromium.org,
        christian.brauner@ubuntu.com, willy@infradead.org,
        shuah@kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kselftest@vger.kernel.org,
        x86@kernel.org, gofmanp@gmail.com, kernel@collabora.com
Subject: Re: [PATCH v7 0/7] Syscall User Dispatch
Message-ID: <20201119123827.GL3121392@hirez.programming.kicks-ass.net>
References: <20201118032840.3429268-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118032840.3429268-1-krisman@collabora.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 17, 2020 at 10:28:33PM -0500, Gabriel Krisman Bertazi wrote:
> Gabriel Krisman Bertazi (7):
>   x86: vdso: Expose sigreturn address on vdso to the kernel
>   signal: Expose SYS_USER_DISPATCH si_code type
>   kernel: Implement selective syscall userspace redirection
>   entry: Support Syscall User Dispatch on common syscall entry
>   selftests: Add kselftest for syscall user dispatch
>   selftests: Add benchmark for syscall user dispatch
>   docs: Document Syscall User Dispatch

Aside from the one little nit this looks good to me.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
