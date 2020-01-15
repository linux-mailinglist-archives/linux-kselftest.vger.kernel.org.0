Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81CA113CFFC
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2020 23:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730052AbgAOWRz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Jan 2020 17:17:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:37364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728899AbgAOWRz (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Jan 2020 17:17:55 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B31C32187F;
        Wed, 15 Jan 2020 22:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579126674;
        bh=KRACwXXWKO/EznwyzDu7lnYus4D5z0F5HFebQ6mV67A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vQDz4L3I+zNXlHoV/yl0mng1PqZTdqI34xdNfY1tpzXxo7DwkfhndIBNVHQSuk5eS
         bxE1ZS1d7WJnGwLZyKWeRL2QjzRf8jLzTN1R5FgFEY9cfNOCrkzdXaiKM2RS3tyd3U
         Et/ca6hqUoSBV4mLJ/Y7o52mj9EGSwqjE4zs3zqQ=
Date:   Thu, 16 Jan 2020 07:17:50 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, jaswinder.singh@linaro.org,
        bpf@vger.kernel.org, daniel@iogearbox.net
Subject: Re: [BUGFIX PATCH] selftests: Fix pthread link option
Message-Id: <20200116071750.0bde391266ea7637ee041d8c@kernel.org>
In-Reply-To: <20200115192528.kq44bg24ezsgo5hm@ast-mbp.dhcp.thefacebook.com>
References: <157907976750.14189.12829891067375600434.stgit@devnote2>
        <20200115192528.kq44bg24ezsgo5hm@ast-mbp.dhcp.thefacebook.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 15 Jan 2020 11:25:30 -0800
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> On Wed, Jan 15, 2020 at 06:16:07PM +0900, Masami Hiramatsu wrote:
> > To support pthread correctly, it is better to use -pthread
> > instead of -lpthread.
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >  tools/testing/selftests/bpf/Makefile               |    2 +-
> >  tools/testing/selftests/membarrier/Makefile        |    2 +-
> >  tools/testing/selftests/mqueue/Makefile            |    2 +-
> >  tools/testing/selftests/net/Makefile               |    4 ++--
> >  .../testing/selftests/powerpc/benchmarks/Makefile  |    4 ++--
> >  tools/testing/selftests/powerpc/dscr/Makefile      |    2 +-
> >  tools/testing/selftests/powerpc/mm/Makefile        |    2 +-
> >  tools/testing/selftests/rseq/Makefile              |    2 +-
> >  tools/testing/selftests/rtc/Makefile               |    2 +-
> >  tools/testing/selftests/seccomp/Makefile           |    2 +-
> >  tools/testing/selftests/timers/Makefile            |    2 +-
> >  tools/testing/selftests/vm/Makefile                |    2 +-
> >  12 files changed, 14 insertions(+), 14 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> > index e2fd6f8d579c..419f58c53d12 100644
> > --- a/tools/testing/selftests/bpf/Makefile
> > +++ b/tools/testing/selftests/bpf/Makefile
> > @@ -22,7 +22,7 @@ CFLAGS += -g -Wall -O2 $(GENFLAGS) -I$(APIDIR) -I$(LIBDIR) -I$(BPFDIR)	\
> >  	  -I$(GENDIR) -I$(TOOLSDIR) -I$(CURDIR)				\
> >  	  -Dbpf_prog_load=bpf_prog_test_load				\
> >  	  -Dbpf_load_program=bpf_test_load_program
> > -LDLIBS += -lcap -lelf -lrt -lpthread
> > +LDLIBS += -lcap -lelf -lrt -pthread
> 
> Please split this bit into separate patch and send it to bpf@vger targeting
> bpf-next. selftests/bpf are going through a lot of changes and I'd like to
> avoid any chance of conflicts.

OK, I'll split it.

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
