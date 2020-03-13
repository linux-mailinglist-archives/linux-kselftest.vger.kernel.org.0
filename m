Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7810C184D00
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Mar 2020 17:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgCMQwx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Mar 2020 12:52:53 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46082 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgCMQwx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Mar 2020 12:52:53 -0400
Received: by mail-qk1-f196.google.com with SMTP id f28so13598443qkk.13;
        Fri, 13 Mar 2020 09:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hw7w18TjYA8oyS87aWSXG4xrDUqIeBoGEOVum37Dwvg=;
        b=OXL9FulLHRECcvQssP7NLWnSIeEZJJloO3J9n36oQ1b8CpbXCNWHocnGc9Vd5f6Jl6
         JPi7i/8+5wUcktMN864fZy09gqTh94jgeacc3a0mgu07gEZIJ8LkbYMPAY+DAS0EPiYB
         Ezi1et17NPcdWEbvhEw73UcZBdE9wrJpk3qvxJTxQssc0fipKQwmj2/j0WOQw+pxg6/R
         q8IcsVcWCTzAwkmvbmIvjILzgqg3fOpb3X6qayccfWdyPzHuJ6pyAByqNM+XmL5z8uEY
         4KCOOdyqTgZ8LVcMlFUfEY4bDAEgQtREh1by825aoqu2J4fqspSrr7vg6Du6G2LDl2KU
         v5Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hw7w18TjYA8oyS87aWSXG4xrDUqIeBoGEOVum37Dwvg=;
        b=OzMTVg0ifoLpbA2Db8eGbU+elfTK7GbOmIezw6bKbQe7eywwQjgnTTFJawJ/Ocwas7
         jWylJTHOZ1jUCKMlG1S5KhFWvhDo+Fnc9Dt3ZoB8nXKOf0tip5TO64KUBHuoG/zFAv1L
         qXbHrecQyTvrDa9UDsP1TMqRel8jrG2MkyV1n4FYRipAaF+Ye7JUauv4H7O6cRfNctjd
         QO7w7tw2omXSri+f6u0Zz6ZkkHvbpbrulBxmr95Fpa+u7/kNol4H6z4dXTyWxEw2vXze
         N56fxs4FD/MJaLo1gl34ErdetxG/CP4JeZlw5LsKDTLzBBbTNvJfP4FoZkjP5a3gxNtm
         qj/g==
X-Gm-Message-State: ANhLgQ3qHBIs3XJm5SLVdIrA8SJRiTKSYwpd25urSS/KY5JAj4JrEG4t
        2uhUXwl6yJ3vWJrB3K5QeyZqgfD9Lb7Z+wgnqBzeQRpO
X-Google-Smtp-Source: ADFU+vvvMpQn4G3tcfR0eyOUwaX8SwFGPYS6Ay7kr23kOejKIDRtRFpg2giK2VyM9axo5Dim5IzkicHT3fGsBVj7d9s=
X-Received: by 2002:a37:e40d:: with SMTP id y13mr14094279qkf.39.1584118371515;
 Fri, 13 Mar 2020 09:52:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200313113105.6918-1-tklauser@distanz.ch>
In-Reply-To: <20200313113105.6918-1-tklauser@distanz.ch>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 13 Mar 2020 09:52:40 -0700
Message-ID: <CAEf4BzZS9mrJAhQaDOXvYG+3Hob0ntRu3rWNffHTJ82TDN6x6A@mail.gmail.com>
Subject: Re: [PATCH bpf-next] tools/bpf: move linux/types.h for selftests and bpftool
To:     Tobias Klauser <tklauser@distanz.ch>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Shuah Khan <shuah@kernel.org>, bpf <bpf@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Quentin Monnet <quentin@isovalent.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Mar 13, 2020 at 4:31 AM Tobias Klauser <tklauser@distanz.ch> wrote:
>
> Commit fe4eb069edb7 ("bpftool: Use linux/types.h from source tree for
> profiler build") added a build dependency on tools/testing/selftests/bpf
> to tools/bpf/bpftool. This is suboptimal with respect to a possible
> stand-alone build of bpftool.
>
> Fix this by moving
> tools/testing/selftests/bpf/include/uapi/linux/types.h to
> tools/include/uapi/linux/types.h
>
> This requires an adjustment in the include search path order for the
> tests in tools/testing/selftests/bpf so that tools/include/linux/types.h
> is selected when building host binaries and
> tools/include/uapi/linux/types.h is selected when building bpf binaries.
>
> Verified by compiling bpftool and the bpf selftests on x86_64 with this
> change.
>

Thanks for following up!

My only concern is that tools/include/uapi/ is also used at least by
perf and libperf, we need to double check that they are fine with this
as well.

Given this is needed for BPF target compilation only, one way to limit
the scope of this change would be to have a `#if defined(__bpf__)`
check and falling back to "normal" uapi/linux/types.h. Alternatively,
we could have a bpf-specific subdirectory and put this header into
tools/include/bpf/uapi/linux/types.h.

I don't have any strong preferences, whatever maintainers are happy with.

> Fixes: fe4eb069edb7 ("bpftool: Use linux/types.h from source tree for profiler build")
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Quentin Monnet <quentin@isovalent.com>
> Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> ---
>  tools/bpf/bpftool/Makefile                                 | 1 -
>  .../{testing/selftests/bpf => }/include/uapi/linux/types.h | 0
>  tools/testing/selftests/bpf/Makefile                       | 7 ++++---
>  3 files changed, 4 insertions(+), 4 deletions(-)
>  rename tools/{testing/selftests/bpf => }/include/uapi/linux/types.h (100%)
>
> diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> index 9ca3bfbb9ac4..f584d1fdfc64 100644
> --- a/tools/bpf/bpftool/Makefile
> +++ b/tools/bpf/bpftool/Makefile
> @@ -129,7 +129,6 @@ $(OUTPUT)_bpftool: $(_OBJS) $(LIBBPF)
>  skeleton/profiler.bpf.o: skeleton/profiler.bpf.c $(LIBBPF)
>         $(QUIET_CLANG)$(CLANG) \
>                 -I$(srctree)/tools/include/uapi/ \
> -               -I$(srctree)/tools/testing/selftests/bpf/include/uapi \
>                 -I$(LIBBPF_PATH) -I$(srctree)/tools/lib \
>                 -g -O2 -target bpf -c $< -o $@
>
> diff --git a/tools/testing/selftests/bpf/include/uapi/linux/types.h b/tools/include/uapi/linux/types.h
> similarity index 100%
> rename from tools/testing/selftests/bpf/include/uapi/linux/types.h
> rename to tools/include/uapi/linux/types.h
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index da4389dde9f7..074a05efd1ca 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -20,8 +20,9 @@ CLANG         ?= clang
>  LLC            ?= llc
>  LLVM_OBJCOPY   ?= llvm-objcopy
>  BPF_GCC                ?= $(shell command -v bpf-gcc;)
> -CFLAGS += -g -rdynamic -Wall -O2 $(GENFLAGS) -I$(CURDIR) -I$(APIDIR)   \
> +CFLAGS += -g -rdynamic -Wall -O2 $(GENFLAGS) -I$(CURDIR)               \
>           -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR) -I$(TOOLSINCDIR)     \
> +         -I$(APIDIR)                                                   \
>           -Dbpf_prog_load=bpf_prog_test_load                            \
>           -Dbpf_load_program=bpf_test_load_program
>  LDLIBS += -lcap -lelf -lz -lrt -lpthread
> @@ -194,8 +195,8 @@ MENDIAN=$(if $(IS_LITTLE_ENDIAN),-mlittle-endian,-mbig-endian)
>
>  CLANG_SYS_INCLUDES = $(call get_sys_includes,$(CLANG))
>  BPF_CFLAGS = -g -D__TARGET_ARCH_$(SRCARCH) $(MENDIAN)                  \
> -            -I$(INCLUDE_DIR) -I$(CURDIR) -I$(CURDIR)/include/uapi      \
> -            -I$(APIDIR) -I$(abspath $(OUTPUT)/../usr/include)
> +            -I$(INCLUDE_DIR) -I$(CURDIR) -I$(APIDIR)                   \
> +            -I$(abspath $(OUTPUT)/../usr/include)
>
>  CLANG_CFLAGS = $(CLANG_SYS_INCLUDES) \
>                -Wno-compare-distinct-pointer-types
> --
> 2.24.0
>
