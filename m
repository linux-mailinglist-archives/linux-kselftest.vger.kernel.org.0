Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45A8DDE541
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2019 09:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfJUHYu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Oct 2019 03:24:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:36586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727047AbfJUHYu (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Oct 2019 03:24:50 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C67022070B;
        Mon, 21 Oct 2019 07:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571642689;
        bh=RR6s7mIccgzeU/T8AvPqnqdOGb3Mp0UjrcZYPHMUYYI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1lYGtq5iYyONLoknJL6+mRREarql2YeAL5xX7EdcDHFVQMn2DsezxxHwc5PiIPGNe
         8SrQ5DXWbk6KsodlJncs8y4sTYK8CO8EKfqnZmvud08Aw9ZRHIPCbGfAT8EzaNGf/Y
         /Qmh0eWToAQNWgk8LDHGUui1+ISrAxUu/hH61XQo=
Date:   Mon, 21 Oct 2019 16:24:45 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     shuah <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        jaswinder.singh@linaro.org
Subject: Re: [BUGFIX PATCH 0/5] selftests: Fixes for 32bit arch
Message-Id: <20191021162445.3f35341ecad791757c0bc043@kernel.org>
In-Reply-To: <ebd87597-9a1e-7d16-2dfb-5bd421383816@kernel.org>
References: <157046101671.20724.9561877942986463668.stgit@devnote2>
        <ebd87597-9a1e-7d16-2dfb-5bd421383816@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shuah,

On Fri, 18 Oct 2019 15:45:56 -0600
shuah <shuah@kernel.org> wrote:

> On 10/7/19 9:10 AM, Masami Hiramatsu wrote:
> > Hi,
> > 
> > Here are some patches to fix some warnings/issues on 32bit arch
> > (e.g. arm).
> > 
> > When I built the ksefltest on arm, I hit some 32bit related warnings.
> > Here are the patches to fix those issues.
> > 
> > 
> >   - [1/5] va_max was set 2^32 even on 32bit arch. This can make
> >          va_max == 0 and always fail. Make it 3GB on 32bit.
> >   - [2/5] Some VM tests requires 64bit user space, which should
> >          not run on 32bit arch.
> >   - [3/5] For counting the size of large file, we should use
> >          size_t instead of unsinged long.
> >   - [4/5] Gcc warns printf format for size_t and int64_t on
> >          32bit arch. Use %llu and cast it.
> >   - [5/5] Gcc warns __u64 and pointer type castings. It should
> >          once translated to unsigned long.
> > 
> > Thank you,
> > 
> > ---
> > 
> > Masami Hiramatsu (5):
> >        selftests: proc: Make va_max 3GB on 32bit arch
> >        selftests: vm: Build/Run 64bit tests only on 64bit arch
> >        selftests: net: Use size_t and ssize_t for counting file size
> >        selftests: net: Fix printf format warnings on arm
> >        selftests: sync: Fix cast warnings on arm
> > 
> > 
> >   tools/testing/selftests/net/so_txtime.c            |    4 ++--
> >   tools/testing/selftests/net/tcp_mmap.c             |    8 ++++----
> >   tools/testing/selftests/net/udpgso.c               |    3 ++-
> >   tools/testing/selftests/net/udpgso_bench_tx.c      |    3 ++-
> >   .../selftests/proc/proc-self-map-files-002.c       |   11 ++++++++++-
> >   tools/testing/selftests/sync/sync.c                |    6 +++---
> >   tools/testing/selftests/vm/Makefile                |    5 +++++
> >   tools/testing/selftests/vm/run_vmtests             |   10 ++++++++++
> >   8 files changed, 38 insertions(+), 12 deletions(-)
> > 
> > --
> > Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
> > 
> 
> Hi Masami,
> 
> I would love to pull these in. But looks like these are spread out
> across several sub-systems.

Right.

> 
> There are some comments on vm patch. Do you mind sending them again
> cc'ing everybody on the cover-letter. Looks like these are getting
> lost in the noise.
> 

OK, I'll update it and resend.

Thank you,


> thanks,
> -- Shuah


-- 
Masami Hiramatsu <mhiramat@kernel.org>
