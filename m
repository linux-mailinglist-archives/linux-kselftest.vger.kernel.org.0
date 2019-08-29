Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59EA7A21C4
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2019 19:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbfH2RGJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Aug 2019 13:06:09 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36319 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727802AbfH2RGJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Aug 2019 13:06:09 -0400
Received: by mail-pg1-f195.google.com with SMTP id l21so1919461pgm.3
        for <linux-kselftest@vger.kernel.org>; Thu, 29 Aug 2019 10:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=i1DJmvd8voYWLbxEBUB8nLGj+ccKrfRNfMLOZPulnv0=;
        b=G8clkpoAG2wM7TmydjOjIMm7fNWG8ep55osvEJVVhpQe84OPg7U+DYdiZtLW5h+LER
         LVxlkBUao1QISYfuzi3UJEEIP+SH7ZlQj3OLcVbDv5XUxkhWXectWPf0MLd3w+TAdwvU
         Ugs/jNHjuICUeUS519629+GrUHSoAHF7v/aUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=i1DJmvd8voYWLbxEBUB8nLGj+ccKrfRNfMLOZPulnv0=;
        b=Q6xcDAap2S2IY1QkIjZzySwPxv+SdDwvXIbgVDmT+0EpoBecj9705XP/AeDDE+NTf6
         /1JG6henSNeH8iIY4eLX/98Bduf4n8OwcN1STOIDebAIEgk9upjPxDfZ7zOX1cmVY9k/
         h4UEVg4tXHhIR7/wk0b7iVa55Bk/N7MMPhoYDovv0Hae3DNuUK9xwz/8MpCxZ8wC3NGg
         yd0Du0Bg57zxc74Ukh+1C0bzDqu2IeUm7UtROpI1bMLMehA40XBjeskr9qcFMuYz7pNO
         xuCuqkxZDlrv5gqBKM0NgwDdvmQH49EVRhso9cy4bn/vB2NLzDfUD1ugyzORds/Ru3Yn
         X7iw==
X-Gm-Message-State: APjAAAUqaibUsG1iL+oT1ofwzk1zchB6hT6KVb/xT0z8caL4bpKqZQOV
        Oegcp8AK7Sp73NbzDiBv1GgxhA==
X-Google-Smtp-Source: APXvYqz0wp9mb9x5mvRK0pA6+zC9B0EAIvxqn7uz8Hh6S3XZ5PoeZHkueVVQ/55Ag8IPJDeVG6h46w==
X-Received: by 2002:a63:2157:: with SMTP id s23mr9520562pgm.167.1567098368482;
        Thu, 29 Aug 2019 10:06:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v15sm3687506pfn.69.2019.08.29.10.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 10:06:07 -0700 (PDT)
Date:   Thu, 29 Aug 2019 10:06:06 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Tycho Andersen <tycho@tycho.ws>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alakesh Haloi <alakesh.haloi@gmail.com>
Subject: Re: [PATCH] selftests/seccomp: fix build on older kernels
Message-ID: <201908291003.005EB96606@keescook>
References: <20190826144302.7745-1-tycho@tycho.ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190826144302.7745-1-tycho@tycho.ws>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Aug 26, 2019 at 08:43:02AM -0600, Tycho Andersen wrote:
> The seccomp selftest goes to some length to build against older kernel
> headers, viz. all the #ifdefs at the beginning of the file. 201766a20e30
> ("ptrace: add PTRACE_GET_SYSCALL_INFO request") introduces some additional
> macros, but doesn't do the #ifdef dance. Let's add that dance here to
> avoid:
> 
> gcc -Wl,-no-as-needed -Wall  seccomp_bpf.c -lpthread -o seccomp_bpf
> In file included from seccomp_bpf.c:51:
> seccomp_bpf.c: In function ‘tracer_ptrace’:
> seccomp_bpf.c:1787:20: error: ‘PTRACE_EVENTMSG_SYSCALL_ENTRY’ undeclared (first use in this function); did you mean ‘PTRACE_EVENT_CLONE’?
>   EXPECT_EQ(entry ? PTRACE_EVENTMSG_SYSCALL_ENTRY
>                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../kselftest_harness.h:608:13: note: in definition of macro ‘__EXPECT’
>   __typeof__(_expected) __exp = (_expected); \
>              ^~~~~~~~~
> seccomp_bpf.c:1787:2: note: in expansion of macro ‘EXPECT_EQ’
>   EXPECT_EQ(entry ? PTRACE_EVENTMSG_SYSCALL_ENTRY
>   ^~~~~~~~~
> seccomp_bpf.c:1787:20: note: each undeclared identifier is reported only once for each function it appears in
>   EXPECT_EQ(entry ? PTRACE_EVENTMSG_SYSCALL_ENTRY
>                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../kselftest_harness.h:608:13: note: in definition of macro ‘__EXPECT’
>   __typeof__(_expected) __exp = (_expected); \
>              ^~~~~~~~~
> seccomp_bpf.c:1787:2: note: in expansion of macro ‘EXPECT_EQ’
>   EXPECT_EQ(entry ? PTRACE_EVENTMSG_SYSCALL_ENTRY
>   ^~~~~~~~~
> seccomp_bpf.c:1788:6: error: ‘PTRACE_EVENTMSG_SYSCALL_EXIT’ undeclared (first use in this function); did you mean ‘PTRACE_EVENT_EXIT’?
>     : PTRACE_EVENTMSG_SYSCALL_EXIT, msg);
>       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ../kselftest_harness.h:608:13: note: in definition of macro ‘__EXPECT’
>   __typeof__(_expected) __exp = (_expected); \
>              ^~~~~~~~~
> seccomp_bpf.c:1787:2: note: in expansion of macro ‘EXPECT_EQ’
>   EXPECT_EQ(entry ? PTRACE_EVENTMSG_SYSCALL_ENTRY
>   ^~~~~~~~~
> make: *** [Makefile:12: seccomp_bpf] Error 1
> 
> Signed-off-by: Tycho Andersen <tycho@tycho.ws>
> Fixes: 201766a20e30 ("ptrace: add PTRACE_GET_SYSCALL_INFO request")

Acked-by: Kees Cook <keescook@chromium.org>

Alakesh Haloi also sent a fix[1] for this. I prefer Tycho's solution
(one #ifndef and a Fixes line). Shuah, can you please apply this?

Thanks!

-Kees

[1] https://lore.kernel.org/lkml/20190822215823.GA11292@ip-172-31-44-144.us-west-2.compute.internal

> ---
>  tools/testing/selftests/seccomp/seccomp_bpf.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
> index 6ef7f16c4cf5..7f8b5c8982e3 100644
> --- a/tools/testing/selftests/seccomp/seccomp_bpf.c
> +++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
> @@ -199,6 +199,11 @@ struct seccomp_notif_sizes {
>  };
>  #endif
>  
> +#ifndef PTRACE_EVENTMSG_SYSCALL_ENTRY
> +#define PTRACE_EVENTMSG_SYSCALL_ENTRY	1
> +#define PTRACE_EVENTMSG_SYSCALL_EXIT	2
> +#endif
> +
>  #ifndef seccomp
>  int seccomp(unsigned int op, unsigned int flags, void *args)
>  {
> -- 
> 2.20.1
> 

-- 
Kees Cook
