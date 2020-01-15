Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED6C713CD08
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2020 20:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbgAOTZd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Jan 2020 14:25:33 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33992 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgAOTZc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Jan 2020 14:25:32 -0500
Received: by mail-pf1-f193.google.com with SMTP id i6so8974718pfc.1;
        Wed, 15 Jan 2020 11:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6Ov9Uf/cEYbZ4uqilqp6lDBn9/aIskYayGhgPiWt6D0=;
        b=aGjxu4xM7wsOhmdVbow3prGI6Jlt/rpu2qQBxEHWXMRfYiKVEPFEmAmXm4QXNz4KVh
         E4tWoOdMtJYEP8j+PQUnIOW3QYkvpOvl202I64RJk95BZiShYv5HkPR80vWKad8e9wZc
         0RTn69LYOoOMUPPEhioxcDzMj+2nS+0cUKPfOkZywhkObDWerXGOEWnaZlQQt7uRWmgG
         MUCRn5sIbTsqcp5omyiHZZau5Wsu2lffV+cxPNAP8QDmw8Jl9GE9xnxjUkD1rE7X1qNK
         5n3LNTxL2e5UAnobkVGq5f1vojLntqEYVB6hXX5BxWQf18SnifStLKufHV+qSooAPdlZ
         maBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6Ov9Uf/cEYbZ4uqilqp6lDBn9/aIskYayGhgPiWt6D0=;
        b=nNvQbmkg30ukv19Smbd0lehIfdfIlaGq2doPGXguUX2yg8huKdKyj6DLefPvHawsrX
         ZZmjafo07UpPN8BoeOp4xVFFjxAYieBuu3ZXaClHeibcSEqiKSCUNjMFGj0ZKm4YDqMB
         11vI6mUZenuQAochsMvDJ8XW5o5jv3M1dZ+rzwh4zJ9EXmndVz9PedUGZcIi8lhIivhh
         aQc7tINdgyhK3ZYJyhqPyIHJ2BmyPgXFoao7GlWk06MBxsPSfV9wPC77C6ywDyeJ5Vya
         wzTlttwnaf9SamAVwIdWDIqq8dXJ09zKpyjDHWzV3RkpZmQLfuCwrsojJwDmSy9Y40Qf
         CuEA==
X-Gm-Message-State: APjAAAUsOsGaVMsjrTZ4hxsAL601tdmJNMdfvzGRIu3OK5p2a6i+gqUm
        ftUisi3wysaptuIQ9Z37vfbsKHHG
X-Google-Smtp-Source: APXvYqwh4E360ZNUAsV0e5bP29q70BTJhnvA9UjIib4FFM6PlwrsH5Kg25qsi6unPahL/zixzz4qtg==
X-Received: by 2002:a63:6c03:: with SMTP id h3mr32975375pgc.19.1579116332208;
        Wed, 15 Jan 2020 11:25:32 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:200::3:e760])
        by smtp.gmail.com with ESMTPSA id j8sm604063pjb.4.2020.01.15.11.25.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jan 2020 11:25:31 -0800 (PST)
Date:   Wed, 15 Jan 2020 11:25:30 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, jaswinder.singh@linaro.org,
        bpf@vger.kernel.org, daniel@iogearbox.net
Subject: Re: [BUGFIX PATCH] selftests: Fix pthread link option
Message-ID: <20200115192528.kq44bg24ezsgo5hm@ast-mbp.dhcp.thefacebook.com>
References: <157907976750.14189.12829891067375600434.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157907976750.14189.12829891067375600434.stgit@devnote2>
User-Agent: NeoMutt/20180223
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jan 15, 2020 at 06:16:07PM +0900, Masami Hiramatsu wrote:
> To support pthread correctly, it is better to use -pthread
> instead of -lpthread.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  tools/testing/selftests/bpf/Makefile               |    2 +-
>  tools/testing/selftests/membarrier/Makefile        |    2 +-
>  tools/testing/selftests/mqueue/Makefile            |    2 +-
>  tools/testing/selftests/net/Makefile               |    4 ++--
>  .../testing/selftests/powerpc/benchmarks/Makefile  |    4 ++--
>  tools/testing/selftests/powerpc/dscr/Makefile      |    2 +-
>  tools/testing/selftests/powerpc/mm/Makefile        |    2 +-
>  tools/testing/selftests/rseq/Makefile              |    2 +-
>  tools/testing/selftests/rtc/Makefile               |    2 +-
>  tools/testing/selftests/seccomp/Makefile           |    2 +-
>  tools/testing/selftests/timers/Makefile            |    2 +-
>  tools/testing/selftests/vm/Makefile                |    2 +-
>  12 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index e2fd6f8d579c..419f58c53d12 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -22,7 +22,7 @@ CFLAGS += -g -Wall -O2 $(GENFLAGS) -I$(APIDIR) -I$(LIBDIR) -I$(BPFDIR)	\
>  	  -I$(GENDIR) -I$(TOOLSDIR) -I$(CURDIR)				\
>  	  -Dbpf_prog_load=bpf_prog_test_load				\
>  	  -Dbpf_load_program=bpf_test_load_program
> -LDLIBS += -lcap -lelf -lrt -lpthread
> +LDLIBS += -lcap -lelf -lrt -pthread

Please split this bit into separate patch and send it to bpf@vger targeting
bpf-next. selftests/bpf are going through a lot of changes and I'd like to
avoid any chance of conflicts.
