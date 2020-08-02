Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8CE12356D8
	for <lists+linux-kselftest@lfdr.de>; Sun,  2 Aug 2020 14:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgHBMBZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 2 Aug 2020 08:01:25 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:51464 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728179AbgHBMBZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 2 Aug 2020 08:01:25 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 640651C0BD4; Sun,  2 Aug 2020 14:01:21 +0200 (CEST)
Date:   Sun, 2 Aug 2020 14:01:15 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        kernel@collabora.com, willy@infradead.org, luto@kernel.org,
        gofmanp@gmail.com, keescook@chromium.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH v4 0/2] Syscall User Redirection
Message-ID: <20200802120115.GC1289@bug>
References: <20200716193141.4068476-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716193141.4068476-1-krisman@collabora.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi!

> This is v4 of Syscall User Redirection.  The implementation itself is
> not modified from v3, it only applies the latest round of reviews to the
> selftests.
> 
> __NR_syscalls is not really exported in header files other than
> asm-generic for every architecture, so it felt safer to optionally
> expose it with a fallback to a high value.
> 
> Also, I didn't expose tests for PR_GET as that is not currently
> implemented.  If possible, I'd have it supported by a future patchset,
> since it is not immediately necessary to support this feature.
> 
> Finally, one question: Which tree would this go through?

Should it come with Documentation?

How does it interact with ptrace, seccomp and similar?
									Pavel

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
