Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 403AB4628AA
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Nov 2021 00:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbhK2X5V (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Nov 2021 18:57:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhK2X5V (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Nov 2021 18:57:21 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10331C061574;
        Mon, 29 Nov 2021 15:54:03 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id x32so47068927ybi.12;
        Mon, 29 Nov 2021 15:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ihgaAo5WogGBIFfA3JZxyc+oZmIt9Qx839HnIX4rjoI=;
        b=guDk9nJM7g1OQB8G516LjubGKYIcju2I7Qlm5/Xi1wuO3ehF4L3sdWHF0u7kqb1Ho3
         O3A+9zNvaYMoEM+ZTmQkBWV2Iaf2C9hvieQ0UKDOK7Fd5QslztB/YHwnKvPMwSf2aQLM
         okz/tT8jGYS7+r/Dvl96bZs2FaJez8bS/UaZOriw9BstCfOLCCWh6zqjoJmsbSTOcGt4
         yb+QkoTPp42OjVW9VyBMOCKu4k8GQWQvjRq231IMc8pfjXePBVx4OoWoQ/XTSxN2o3Hw
         8FJlrULUPl7vSnRXnnXLfQqz/R6dv9dZzvVFD0cLv2aHc4OC3N4RxYIOfdoyWpWZxswX
         75hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ihgaAo5WogGBIFfA3JZxyc+oZmIt9Qx839HnIX4rjoI=;
        b=BAnr999Df0AslcqrLIgnWSsp8Y+7b7Kr6IznMCNc1Vky7ZJkSoksirZB+LZaDbmmEq
         gURE/iWLwwF1/z+IGJLz3XkDglNwdRF4KYttOCvp3n4rDtX0vTVZpwWBqL0dikugx+pu
         D/p9E1qIt6jJ8vcWYAyRFTlme4W4XoQeKpzB6NgqdAnpUArdqB9vOIcWSKxKAZItEzp8
         41GJBzG88oMBFjQeYMLmTU52KrIYGZm1wBOopaWHheyhSnTGMiE0KgRK0lrAOVsAnXEs
         DciA8qcVtQ13nLKKNEgne51WZheWjNF9kNbLqpFNq3gxmbnbSYE1tKYrAJVdoSyv1Ryf
         qxng==
X-Gm-Message-State: AOAM533C8szVrUUKdw3XcQFegPJHo1U0zzT34xnF//m4P7CogPIPzE8o
        pmQzG4kz+NkjubCr0p4vud+VoVFjVEdg2HtpVS4=
X-Google-Smtp-Source: ABdhPJwdcmgKmBpWz4w+ApPLRcuF96Te+4ObOthk2sNbDOGKdiu3XWwv4T4b9DIlUez7Ic7VMbhmtS0RjoLNAJi4BVg=
X-Received: by 2002:a25:abaa:: with SMTP id v39mr37900854ybi.367.1638230042280;
 Mon, 29 Nov 2021 15:54:02 -0800 (PST)
MIME-Version: 1.0
References: <20211122192019.1277299-1-jean-philippe@linaro.org> <20211122192019.1277299-5-jean-philippe@linaro.org>
In-Reply-To: <20211122192019.1277299-5-jean-philippe@linaro.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 29 Nov 2021 15:53:51 -0800
Message-ID: <CAEf4BzbwYoaN8aBF+w=VK7MAv=-WNzffyA-puwAm8633Not-6g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/6] bpftool: Enable cross-building with clang
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Martin Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 22, 2021 at 11:23 AM Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
>
> Cross-building using clang requires passing the "-target" flag rather
> than using the CROSS_COMPILE prefix. Makefile.include transforms
> CROSS_COMPILE into CLANG_CROSS_FLAGS, and adds that to CFLAGS. Filter
> out the cross flags for the bootstrap bpftool, and erase the
> CROSS_COMPILE flag for the bootstrap libbpf.
>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  tools/bpf/bpftool/Makefile | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> index 42eb8eee3d89..b0f3e17d981a 100644
> --- a/tools/bpf/bpftool/Makefile
> +++ b/tools/bpf/bpftool/Makefile
> @@ -57,7 +57,7 @@ $(LIBBPF_INTERNAL_HDRS): $(LIBBPF_HDRS_DIR)/%.h: $(BPF_DIR)/%.h | $(LIBBPF_HDRS_
>  $(LIBBPF_BOOTSTRAP): $(wildcard $(BPF_DIR)/*.[ch] $(BPF_DIR)/Makefile) | $(LIBBPF_BOOTSTRAP_OUTPUT)
>         $(Q)$(MAKE) -C $(BPF_DIR) OUTPUT=$(LIBBPF_BOOTSTRAP_OUTPUT) \
>                 DESTDIR=$(LIBBPF_BOOTSTRAP_DESTDIR) prefix= \
> -               ARCH= CC=$(HOSTCC) LD=$(HOSTLD) $@ install_headers
> +               ARCH= CROSS_COMPILE= CC=$(HOSTCC) LD=$(HOSTLD) $@ install_headers
>
>  $(LIBBPF_BOOTSTRAP_INTERNAL_HDRS): $(LIBBPF_BOOTSTRAP_HDRS_DIR)/%.h: $(BPF_DIR)/%.h | $(LIBBPF_BOOTSTRAP_HDRS_DIR)
>         $(call QUIET_INSTALL, $@)
> @@ -152,6 +152,9 @@ CFLAGS += -DHAVE_LIBBFD_SUPPORT
>  SRCS += $(BFD_SRCS)
>  endif
>
> +HOST_CFLAGS = $(subst -I$(LIBBPF_INCLUDE),-I$(LIBBPF_BOOTSTRAP_INCLUDE),\
> +               $(filter-out $(CLANG_CROSS_FLAGS),$(CFLAGS)))

Isn't this dangerous? CLANG_CROSS_FLAGS are treated as space-separated
array of values, so if you have something like '-I whatever' it will
actually filter out unrelated -Is from CFLAGS, no? I'd rather subst
into empty string instead, just like we do for LIBBPF_INCLUDE.

> +
>  BPFTOOL_BOOTSTRAP := $(BOOTSTRAP_OUTPUT)bpftool
>
>  BOOTSTRAP_OBJS = $(addprefix $(BOOTSTRAP_OUTPUT),main.o common.o json_writer.o gen.o btf.o xlated_dumper.o btf_dumper.o disasm.o)
> @@ -202,7 +205,7 @@ endif
>  CFLAGS += $(if $(BUILD_BPF_SKELS),,-DBPFTOOL_WITHOUT_SKELETONS)
>
>  $(BOOTSTRAP_OUTPUT)disasm.o: $(srctree)/kernel/bpf/disasm.c
> -       $(QUIET_CC)$(HOSTCC) $(CFLAGS) -c -MMD $< -o $@
> +       $(QUIET_CC)$(HOSTCC) $(HOST_CFLAGS) -c -MMD $< -o $@
>
>  $(OUTPUT)disasm.o: $(srctree)/kernel/bpf/disasm.c
>         $(QUIET_CC)$(CC) $(CFLAGS) -c -MMD $< -o $@
> @@ -213,15 +216,13 @@ ifneq ($(feature-zlib), 1)
>  endif
>
>  $(BPFTOOL_BOOTSTRAP): $(BOOTSTRAP_OBJS) $(LIBBPF_BOOTSTRAP)
> -       $(QUIET_LINK)$(HOSTCC) $(CFLAGS) $(LDFLAGS) $(BOOTSTRAP_OBJS) $(LIBS_BOOTSTRAP) -o $@
> +       $(QUIET_LINK)$(HOSTCC) $(HOST_CFLAGS) $(LDFLAGS) $(BOOTSTRAP_OBJS) $(LIBS_BOOTSTRAP) -o $@
>
>  $(OUTPUT)bpftool: $(OBJS) $(LIBBPF)
>         $(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $(OBJS) $(LIBS) -o $@
>
>  $(BOOTSTRAP_OUTPUT)%.o: %.c $(LIBBPF_BOOTSTRAP_INTERNAL_HDRS) | $(BOOTSTRAP_OUTPUT)
> -       $(QUIET_CC)$(HOSTCC) \
> -               $(subst -I$(LIBBPF_INCLUDE),-I$(LIBBPF_BOOTSTRAP_INCLUDE),$(CFLAGS)) \
> -               -c -MMD $< -o $@
> +       $(QUIET_CC)$(HOSTCC) $(HOST_CFLAGS) -c -MMD $< -o $@
>
>  $(OUTPUT)%.o: %.c
>         $(QUIET_CC)$(CC) $(CFLAGS) -c -MMD $< -o $@
> --
> 2.33.1
>
