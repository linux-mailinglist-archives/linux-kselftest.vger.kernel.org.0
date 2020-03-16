Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23835187474
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Mar 2020 22:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732623AbgCPVF7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Mar 2020 17:05:59 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:38469 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732621AbgCPVF7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Mar 2020 17:05:59 -0400
Received: by mail-pj1-f68.google.com with SMTP id m15so8636066pje.3
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Mar 2020 14:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=y3IGmPwiq4wbs+3Nm8nYfgQPnK4Ox4cRsRDlqMwvWZw=;
        b=Uq0m1LsnsVeUh9mPhVQCxIpjl7uOSEiupEU1sQZhy+FXtQmH1zskZYSnn8rE3/NVm5
         2YnRwPm+TxZQrC7dYoyhE079DxdG8uJoO9kKvzPXCUP6Ele4cT31xVBvi/S6ffU/Z5BH
         qCHqVQLZkw6PhpSRJN2PSIwyjLj49R+no6jR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y3IGmPwiq4wbs+3Nm8nYfgQPnK4Ox4cRsRDlqMwvWZw=;
        b=EvPk5HPrKfCDXcXbn9G7CZI0r7PTjS9Jr2CBY1F4RlPUTa3muD6zlOLmYk4CqbrTrw
         xJf2sA3DOO0VqNxhMCj+6+eci2FyzAd5FIAi3xXRLjhdaUMVGGoBAVUwHXN9BW0yhksg
         CcOGHL4+cSqiTECseMhn+wHbxO9hPmKnU1Ap1I/otICOs//r26eVFp9qeDoBNvmfNz22
         idIthBpReMtZs82z6o6rR7kqHM9EKwwAPi9WdxF4mQ7FfintG2E2BMOr92aNLnRbhBxS
         vrLuOdFY6sgs0+MoY3e10/8N0xfR7ayxBeB7D6vxPkH6JiVEwlzd8XYgChA6E80gzTfs
         NTwg==
X-Gm-Message-State: ANhLgQ3bmwVcJeP7P8mXJzOGg69JuvqnQv6AFtoIWdC0bzl8MoWqnKPS
        XzFc6m+jrJW72F9kBi1y6lRWeA==
X-Google-Smtp-Source: ADFU+vvTUDyDUjCUl26KBVoud41E3T/YXGVRV8yipj/Wi5LH4KGqaXAvRVMdbUrjOQc3cY7SYA2png==
X-Received: by 2002:a17:90a:8d81:: with SMTP id d1mr1460363pjo.63.1584392758209;
        Mon, 16 Mar 2020 14:05:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c201sm785900pfc.73.2020.03.16.14.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 14:05:57 -0700 (PDT)
Date:   Mon, 16 Mar 2020 14:05:56 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Shuah Khan <skhan@linuxfoundation.org>, shuah@kernel.org,
        luto@amacapital.net, wad@chromium.org, daniel@iogearbox.net,
        kafai@fb.com, yhs@fb.com, andriin@fb.com,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        khilman@baylibre.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH v3] selftests: Fix seccomp to support relocatable build
 (O=objdir)
Message-ID: <202003161404.934CCE0@keescook>
References: <20200313212404.24552-1-skhan@linuxfoundation.org>
 <8736a8qz06.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8736a8qz06.fsf@mpe.ellerman.id.au>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Mar 16, 2020 at 11:12:57PM +1100, Michael Ellerman wrote:
> Shuah Khan <skhan@linuxfoundation.org> writes:
> > Fix seccomp relocatable builds. This is a simple fix to use the right
> > lib.mk variable TEST_GEN_PROGS with dependency on kselftest_harness.h
> > header, and defining LDFLAGS for pthread lib.
> >
> > Removes custom clean rule which is no longer necessary with the use of
> > TEST_GEN_PROGS. 
> >
> > Uses $(OUTPUT) defined in lib.mk to handle build relocation.
> >
> > The following use-cases work with this change:
> >
> > In seccomp directory:
> > make all and make clean
> >
> > From top level from main Makefile:
> > make kselftest-install O=objdir ARCH=arm64 HOSTCC=gcc \
> >  CROSS_COMPILE=aarch64-linux-gnu- TARGETS=seccomp
> >
> > Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> > ---
> >
> > Changes since v2:
> > -- Using TEST_GEN_PROGS is sufficient to generate objects.
> >    Addresses review comments from Kees Cook.
> >
> >  tools/testing/selftests/seccomp/Makefile | 18 ++++++++----------
> >  1 file changed, 8 insertions(+), 10 deletions(-)
> >
> > diff --git a/tools/testing/selftests/seccomp/Makefile b/tools/testing/selftests/seccomp/Makefile
> > index 1760b3e39730..a0388fd2c3f2 100644
> > --- a/tools/testing/selftests/seccomp/Makefile
> > +++ b/tools/testing/selftests/seccomp/Makefile
> > @@ -1,17 +1,15 @@
> >  # SPDX-License-Identifier: GPL-2.0
> > -all:
> > -
> > -include ../lib.mk
> > +CFLAGS += -Wl,-no-as-needed -Wall
> > +LDFLAGS += -lpthread
> >  
> >  .PHONY: all clean
> >  
> > -BINARIES := seccomp_bpf seccomp_benchmark
> > -CFLAGS += -Wl,-no-as-needed -Wall
> > +include ../lib.mk
> > +
> > +# OUTPUT set by lib.mk
> > +TEST_GEN_PROGS := $(OUTPUT)/seccomp_bpf $(OUTPUT)/seccomp_benchmark
> >  
> > -seccomp_bpf: seccomp_bpf.c ../kselftest_harness.h
> > -	$(CC) $(CFLAGS) $(LDFLAGS) $< -lpthread -o $@
> > +$(TEST_GEN_PROGS): ../kselftest_harness.h
> >  
> > -TEST_PROGS += $(BINARIES)
> > -EXTRA_CLEAN := $(BINARIES)
> > +all: $(TEST_GEN_PROGS)
> >  
> > -all: $(BINARIES)
> 
> 
> It shouldn't be that complicated. We just need to define TEST_GEN_PROGS
> before including lib.mk, and then add the dependency on the harness
> after we include lib.mk (so that TEST_GEN_PROGS has been updated to
> prefix $(OUTPUT)).
> 
> eg:
> 
>   # SPDX-License-Identifier: GPL-2.0
>   CFLAGS += -Wl,-no-as-needed -Wall
>   LDFLAGS += -lpthread
>   
>   TEST_GEN_PROGS := seccomp_bpf seccomp_benchmark
>   
>   include ../lib.mk
>   
>   $(TEST_GEN_PROGS): ../kselftest_harness.h

Exactly. This (with an extra comment) is precisely what I suggested during
v2 review:
https://lore.kernel.org/lkml/202003041815.B8C73DEC@keescook/

-Kees

> 
> 
> Normal in-tree build:
> 
>   selftests$ make TARGETS=seccomp
>   make[1]: Entering directory '/home/michael/linux/tools/testing/selftests/seccomp'
>   gcc -Wl,-no-as-needed -Wall  -lpthread  seccomp_bpf.c ../kselftest_harness.h  -o /home/michael/linux/tools/testing/selftests/seccomp/seccomp_bpf
>   gcc -Wl,-no-as-needed -Wall  -lpthread  seccomp_benchmark.c ../kselftest_harness.h  -o /home/michael/linux/tools/testing/selftests/seccomp/seccomp_benchmark
>   make[1]: Leaving directory '/home/michael/linux/tools/testing/selftests/seccomp'
>   
>   selftests$ ls -l seccomp/
>   total 388
>   -rw-rw-r-- 1 michael michael     41 Jan  9 12:00 config
>   -rw-rw-r-- 1 michael michael    201 Mar 16 23:04 Makefile
>   -rwxrwxr-x 1 michael michael  70824 Mar 16 23:07 seccomp_benchmark*
>   -rw-rw-r-- 1 michael michael   2289 Feb 17 21:39 seccomp_benchmark.c
>   -rwxrwxr-x 1 michael michael 290520 Mar 16 23:07 seccomp_bpf*
>   -rw-rw-r-- 1 michael michael  94778 Mar  5 23:33 seccomp_bpf.c
> 
> 
> O= build:
> 
>   selftests$ make TARGETS=seccomp O=$PWD/build
>   make[1]: Entering directory '/home/michael/linux/tools/testing/selftests/seccomp'
>   gcc -Wl,-no-as-needed -Wall  -lpthread  seccomp_bpf.c ../kselftest_harness.h  -o /home/michael/linux/tools/testing/selftests/build/seccomp/seccomp_bpf
>   gcc -Wl,-no-as-needed -Wall  -lpthread  seccomp_benchmark.c ../kselftest_harness.h  -o /home/michael/linux/tools/testing/selftests/build/seccomp/seccomp_benchmark
>   make[1]: Leaving directory '/home/michael/linux/tools/testing/selftests/seccomp'
>   
>   selftests$ ls -l build/seccomp/
>   total 280
>   -rwxrwxr-x 1 michael michael  70824 Mar 16 23:05 seccomp_benchmark*
>   -rwxrwxr-x 1 michael michael 290520 Mar 16 23:05 seccomp_bpf*
> 
> 
> Build in the directory itself:
>   selftests$ cd seccomp
>   seccomp$ make
>   gcc -Wl,-no-as-needed -Wall  -lpthread  seccomp_bpf.c ../kselftest_harness.h  -o /home/michael/linux/tools/testing/selftests/seccomp/seccomp_bpf
>   gcc -Wl,-no-as-needed -Wall  -lpthread  seccomp_benchmark.c ../kselftest_harness.h  -o /home/michael/linux/tools/testing/selftests/seccomp/seccomp_benchmark
>   
>   seccomp$ ls -l
>   total 388
>   -rw-rw-r-- 1 michael michael     41 Jan  9 12:00 config
>   -rw-rw-r-- 1 michael michael    201 Mar 16 23:04 Makefile
>   -rwxrwxr-x 1 michael michael  70824 Mar 16 23:06 seccomp_benchmark*
>   -rw-rw-r-- 1 michael michael   2289 Feb 17 21:39 seccomp_benchmark.c
>   -rwxrwxr-x 1 michael michael 290520 Mar 16 23:06 seccomp_bpf*
>   -rw-rw-r-- 1 michael michael  94778 Mar  5 23:33 seccomp_bpf.c
> 
> 
> cheers

-- 
Kees Cook
