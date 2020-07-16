Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E40DB222D5D
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jul 2020 23:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgGPVGF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Jul 2020 17:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbgGPVGF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Jul 2020 17:06:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC85C061755;
        Thu, 16 Jul 2020 14:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=97Vb3ATwIinLeyNU+ffoxlcz4EFi0R63Q1SkJc6H6p4=; b=We2uPn5NrJcfOM7pBBgSN3ww9e
        lCAo0oiIysNi0p6TlBi8cRG351VfGXXjX3rAOl7pOiKOSVWt+DOKn+ILQxK3iM1PJ6SD27rEejTz0
        Nd4LgC6aRVtX7HnRHnpcRI8jiCSSRCk0nOM/9s8RLEA+qF6l33rbGJyfYsJEHkF9wXL1d1ADUxbTT
        /a4BroaC26YXa89MdHmUgQ/xXWk+m0K1gjIXv1wTwfXSkzGwf1r6lekyLqBKUMG1TGrNe2HnCq3t8
        E3Bht6snrABBB2+1XSZweylW1kZLZdojpMa/Evhn9m9eLrtj7EbuPHx5gU/dHhMwDUpe2FHpEKjFA
        Wnlyrahg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jwB4r-0007Wt-55; Thu, 16 Jul 2020 21:06:01 +0000
Date:   Thu, 16 Jul 2020 22:06:01 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        kernel@collabora.com, luto@kernel.org, gofmanp@gmail.com,
        keescook@chromium.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
Subject: Re: [PATCH v4 1/2] kernel: Implement selective syscall userspace
 redirection
Message-ID: <20200716210601.GN12769@casper.infradead.org>
References: <20200716193141.4068476-1-krisman@collabora.com>
 <20200716193141.4068476-2-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716193141.4068476-2-krisman@collabora.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jul 16, 2020 at 03:31:40PM -0400, Gabriel Krisman Bertazi wrote:
> selector is an optional pointer to a char-sized userspace memory region
> that has a key switch for the mechanism. This key switch is set to
> either PR_SYS_DISPATCH_ON, PR_SYS_DISPATCH_OFF to enable and disable the
> redirection without calling the kernel.
> 
> The feature is meant to be set per-thread and it is disabled on
> fork/clone/execv.

Disabled on exec.  Disabled in the child on clone/fork (and vfork, I
think).

That means we don't need to worry about it interacting badly with
a setuid program, right?

