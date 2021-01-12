Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1692F3D29
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Jan 2021 01:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406950AbhALVh1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Jan 2021 16:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437080AbhALU6H (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Jan 2021 15:58:07 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74518C061575;
        Tue, 12 Jan 2021 12:57:26 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id y128so20320ybf.10;
        Tue, 12 Jan 2021 12:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n3T3+iaR+AM+V13vdwyxk7vLyUw4UrQqx629+o9EkLI=;
        b=G/pBptQapRMCZ7Zl4/jCq+ZxJmeau7R/n3EnWa8AS7i7n21nitNz9USFcNcr+GfkHK
         Uu6QPVM5za2KCyCGqnnHriaJouxhLwUxpLRFb1vL55lVPS6KDYTZBgDuF56W7kqhyjeC
         +yMCbr1t5H/FcIxjG+FaQ0GKlrVYlk6mwVEZ4Q/A7PWKA2pU8ZmoxzQBnniYiP/yt8c0
         Fx1CpLIGPuJQxovWvs8vsD/DMxg0rxlGhUniMKJNo7TmkY7+4J0JDo3aCoo0e+Lui73H
         q9jiXYCh2EOKHcvMQTeWZIdr410HhAxAot6RqrTjEVOQtbYjN7Jkx6JlCdhht6fhx/fB
         iUjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n3T3+iaR+AM+V13vdwyxk7vLyUw4UrQqx629+o9EkLI=;
        b=pw+hAzUQ8VmZmCaw1aRzsvPoPqWdmtyYN9cykao7ZokeQ3Wvp3U3kqSIwqUL+JtUt1
         icDJY67tFPEtypppr7wnYjV7/829WKZzfFh0gZJlQfMt443BtJ3xZGq3YNm4VDJRmJxJ
         HuNWPd8kLi/DrPp4mqsSUQ6ewk8gkHSucXfPxIjKkFr3qTBdAc3uAmsOx994e9Hc9F8G
         ynMk5QCd5UI+exRlpLbQaXd+8Ro/ZgOxSG67Ktv8oH2dSGhjP7VgT9+LY4OqyCiTdBHs
         AjQHVYp1s9qzrAghojo/crU915k9Q9mGki/CjtKvOpilJXPBRqmVkaU8KCpHtqeSegIv
         i/lA==
X-Gm-Message-State: AOAM530SHqCoZToolFpAAdHcKsggoSrhBwZDEaKdtCEOYqdasgcn/6Vi
        FrHZS7+qHZrhk/vpKWvI2AV6LZgZJcZDNpNYkfA=
X-Google-Smtp-Source: ABdhPJyyKjcY1WvrqKi5+JxdrhkUBDQ88XvJlIutwJZySodVGvUsbQvDfQYAiILgA3seYNBOqloaEsdTMaz96+hxjGI=
X-Received: by 2002:a25:aea8:: with SMTP id b40mr1912496ybj.347.1610485045651;
 Tue, 12 Jan 2021 12:57:25 -0800 (PST)
MIME-Version: 1.0
References: <20210112135959.649075-1-jean-philippe@linaro.org> <20210112135959.649075-2-jean-philippe@linaro.org>
In-Reply-To: <20210112135959.649075-2-jean-philippe@linaro.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 12 Jan 2021 12:57:14 -0800
Message-ID: <CAEf4BzadNOciqNMO_r9i3sVTQWHVQ4m=Yuqx5zaMdvxMS+gJ=A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/5] selftests/bpf: Enable cross-building
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     bpf <bpf@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jan 12, 2021 at 6:01 AM Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
>
> Build bpftool and resolve_btfids using the host toolchain when
> cross-compiling, since they are executed during build to generate the
> selftests. Add a host build directory in order to build both host and
> target version of libbpf. Build host tools using $(HOSTCC) defined in
> Makefile.include.
>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---

Makes sense.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  tools/testing/selftests/bpf/Makefile | 43 ++++++++++++++++++++++------
>  1 file changed, 34 insertions(+), 9 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index c51df6b91bef..1d85565883ea 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  include ../../../../scripts/Kbuild.include
>  include ../../../scripts/Makefile.arch
> +include ../../../scripts/Makefile.include
>
>  CXX ?= $(CROSS_COMPILE)g++
>
> @@ -113,7 +114,20 @@ SCRATCH_DIR := $(OUTPUT)/tools
>  BUILD_DIR := $(SCRATCH_DIR)/build
>  INCLUDE_DIR := $(SCRATCH_DIR)/include
>  BPFOBJ := $(BUILD_DIR)/libbpf/libbpf.a
> -RESOLVE_BTFIDS := $(BUILD_DIR)/resolve_btfids/resolve_btfids
> +ifneq ($(CROSS_COMPILE),)
> +HOST_BUILD_DIR         := $(BUILD_DIR)/host
> +HOST_SCRATCH_DIR       := $(OUTPUT)/host-tools
> +else
> +HOST_BUILD_DIR         := $(BUILD_DIR)
> +HOST_SCRATCH_DIR       := $(SCRATCH_DIR)
> +endif
> +HOST_BPFOBJ := $(HOST_BUILD_DIR)/libbpf/libbpf.a
> +RESOLVE_BTFIDS := $(HOST_BUILD_DIR)/resolve_btfids/resolve_btfids
> +
> +# sort removes libbpf duplicates when not cross-building
> +MAKE_DIRS := $(sort $(BUILD_DIR)/libbpf $(HOST_BUILD_DIR)/libbpf              \
> +              $(HOST_BUILD_DIR)/bpftool $(HOST_BUILD_DIR)/resolve_btfids      \
> +              $(INCLUDE_DIR))
>
>  VMLINUX_BTF_PATHS ?= $(if $(O),$(O)/vmlinux)                           \
>                      $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux)    \
> @@ -157,7 +171,7 @@ $(OUTPUT)/test_stub.o: test_stub.c $(BPFOBJ)
>         $(call msg,CC,,$@)
>         $(Q)$(CC) -c $(CFLAGS) -o $@ $<
>
> -DEFAULT_BPFTOOL := $(SCRATCH_DIR)/sbin/bpftool
> +DEFAULT_BPFTOOL := $(HOST_SCRATCH_DIR)/sbin/bpftool
>
>  $(OUTPUT)/runqslower: $(BPFOBJ) | $(DEFAULT_BPFTOOL)
>         $(Q)$(MAKE) $(submake_extras) -C $(TOOLSDIR)/bpf/runqslower     \
> @@ -182,10 +196,11 @@ $(OUTPUT)/test_sysctl: cgroup_helpers.c
>
>  BPFTOOL ?= $(DEFAULT_BPFTOOL)
>  $(DEFAULT_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] $(BPFTOOLDIR)/Makefile)    \
> -                   $(BPFOBJ) | $(BUILD_DIR)/bpftool
> +                   $(HOST_BPFOBJ) | $(HOST_BUILD_DIR)/bpftool
>         $(Q)$(MAKE) $(submake_extras)  -C $(BPFTOOLDIR)                        \
> -                   OUTPUT=$(BUILD_DIR)/bpftool/                               \
> -                   prefix= DESTDIR=$(SCRATCH_DIR)/ install
> +                   CC=$(HOSTCC) LD=$(HOSTLD)                                  \
> +                   OUTPUT=$(HOST_BUILD_DIR)/bpftool/                          \
> +                   prefix= DESTDIR=$(HOST_SCRATCH_DIR)/ install
>         $(Q)mkdir -p $(BUILD_DIR)/bpftool/Documentation
>         $(Q)RST2MAN_OPTS="--exit-status=1" $(MAKE) $(submake_extras)           \
>                     -C $(BPFTOOLDIR)/Documentation                             \
> @@ -198,7 +213,16 @@ $(BPFOBJ): $(wildcard $(BPFDIR)/*.[ch] $(BPFDIR)/Makefile)                \
>         $(Q)$(MAKE) $(submake_extras) -C $(BPFDIR) OUTPUT=$(BUILD_DIR)/libbpf/ \
>                     DESTDIR=$(SCRATCH_DIR) prefix= all install_headers
>
> -$(BUILD_DIR)/libbpf $(BUILD_DIR)/bpftool $(BUILD_DIR)/resolve_btfids $(INCLUDE_DIR):
> +ifneq ($(BPFOBJ),$(HOST_BPFOBJ))
> +$(HOST_BPFOBJ): $(wildcard $(BPFDIR)/*.[ch] $(BPFDIR)/Makefile)                \
> +          ../../../include/uapi/linux/bpf.h                                   \
> +          | $(INCLUDE_DIR) $(HOST_BUILD_DIR)/libbpf
> +       $(Q)$(MAKE) $(submake_extras) -C $(BPFDIR)                             \
> +               OUTPUT=$(HOST_BUILD_DIR)/libbpf/ CC=$(HOSTCC) LD=$(HOSTLD)     \
> +                   DESTDIR=$(HOST_SCRATCH_DIR)/ prefix= all install_headers
> +endif
> +
> +$(MAKE_DIRS):
>         $(call msg,MKDIR,,$@)
>         $(Q)mkdir -p $@
>

nit: I'd just put this rule right next to MAKE_DIRS definition


> @@ -211,7 +235,7 @@ else
>         $(Q)cp "$(VMLINUX_H)" $@
>  endif
>
> -$(RESOLVE_BTFIDS): $(BPFOBJ) | $(BUILD_DIR)/resolve_btfids     \
> +$(RESOLVE_BTFIDS): $(HOST_BPFOBJ) | $(HOST_BUILD_DIR)/resolve_btfids   \
>                        $(TOOLSDIR)/bpf/resolve_btfids/main.c    \
>                        $(TOOLSDIR)/lib/rbtree.c                 \
>                        $(TOOLSDIR)/lib/zalloc.c                 \
> @@ -219,7 +243,8 @@ $(RESOLVE_BTFIDS): $(BPFOBJ) | $(BUILD_DIR)/resolve_btfids  \
>                        $(TOOLSDIR)/lib/ctype.c                  \
>                        $(TOOLSDIR)/lib/str_error_r.c
>         $(Q)$(MAKE) $(submake_extras) -C $(TOOLSDIR)/bpf/resolve_btfids \
> -               OUTPUT=$(BUILD_DIR)/resolve_btfids/ BPFOBJ=$(BPFOBJ)
> +               CC=$(HOSTCC) LD=$(HOSTLD) AR=$(HOSTAR) \
> +               OUTPUT=$(HOST_BUILD_DIR)/resolve_btfids/ BPFOBJ=$(HOST_BPFOBJ)
>
>  # Get Clang's default includes on this system, as opposed to those seen by
>  # '-target bpf'. This fixes "missing" files on some architectures/distros,
> @@ -450,7 +475,7 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o $(OUTPUT)/testing_helpers.o \
>         $(call msg,BINARY,,$@)
>         $(Q)$(CC) $(LDFLAGS) -o $@ $(filter %.a %.o,$^) $(LDLIBS)
>
> -EXTRA_CLEAN := $(TEST_CUSTOM_PROGS) $(SCRATCH_DIR)                     \
> +EXTRA_CLEAN := $(TEST_CUSTOM_PROGS) $(SCRATCH_DIR) $(HOST_SCRATCH_DIR) \
>         prog_tests/tests.h map_tests/tests.h verifier/tests.h           \
>         feature                                                         \
>         $(addprefix $(OUTPUT)/,*.o *.skel.h no_alu32 bpf_gcc bpf_testmod.ko)
> --
> 2.30.0
>
