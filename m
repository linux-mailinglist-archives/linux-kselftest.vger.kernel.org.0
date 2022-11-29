Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2539763B9A3
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Nov 2022 07:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235627AbiK2GAa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Nov 2022 01:00:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235310AbiK2GA3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Nov 2022 01:00:29 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1C452175;
        Mon, 28 Nov 2022 22:00:28 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id bj12so31165531ejb.13;
        Mon, 28 Nov 2022 22:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2pLzq/SzjaM0KPWKXQrCExQaHgJlHt7QEU3lr44aL8w=;
        b=XYkTC/btf3zjxM2HhgCFpLp1a7ejW0BkcZgv5Wz0DrghPJRGuVHzVbdferWAQK+vwf
         JqEzcRTX7SZjFu0XPKlkeC/ZMwA9gOqeMZyhTrsJE/8QskM5ql2usS6FZHej5Fn/Yw1G
         wmA8CmLWaVvaN47Ho7YIdbCQjiMP9QOgpDJRianeC/37oJztFYEUCCWuuZBWIWlSk4D7
         Dq12BSxoycLRuyC4BYxSswffD7ZgwCmJNcJReq0eWVHZafY/WaZy1hFpxjtkJMU+XXLe
         hXkCjxgFj1nRRzJvw4pMfZAvcTlKL5MVPkJQ/BX222oFhjh6+blnZsngJ5Qm2xdusJFQ
         NLwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2pLzq/SzjaM0KPWKXQrCExQaHgJlHt7QEU3lr44aL8w=;
        b=J09DnPZtpAkikvghpoufjPwYTzk+zZyfEg9TIc2eOzG3VCtc8SwvyBv4RQgvWCZCHE
         uE1Ho64Wl0nsRqNozVW130RXnOKMNhAzx2to95J8ex8/Q5XEUpiiUZZXCc/mnLZQTcMr
         bftlz4/VmEDbIwJJRUbJMi8AKAAd3RCvQUutyk7C+sF+1CN4+TgAjd16KZNPI4Q1XzLn
         l6I2O2p40NKJ7QfExZ2z6S3becVAeseIUwVhKn4lQAfbn30UkYH6Blfp3PYdRFdSdPm5
         mCD/lwuSdekEIRRkJjlrkUdwkp07/MQEKf/e8zcR8QR40Ge0MTVAlXn1APPMfHd2DGAN
         Er8g==
X-Gm-Message-State: ANoB5pmj487c/VuTp4IpCnHr29pir/l4A+mq4QZG2beLSBxXUX6tLOT3
        1vFSl90ihm14fXInTVa5Qv3/XaQHW7pZXQFkWT0=
X-Google-Smtp-Source: AA0mqf4j78MxPWCZzHJealetXBtA+Lv7p4mAJ595hxXlWf1ZVQm1ckrdnZtzZ1hNDbX6B4QJa3hYoEea9Wwtd0ykKFs=
X-Received: by 2002:a17:906:30c1:b0:7b7:eaa9:c1cb with SMTP id
 b1-20020a17090630c100b007b7eaa9c1cbmr32037639ejb.745.1669701626413; Mon, 28
 Nov 2022 22:00:26 -0800 (PST)
MIME-Version: 1.0
References: <20221126111147.199366-1-changbin.du@gmail.com> <20221126111147.199366-3-changbin.du@gmail.com>
In-Reply-To: <20221126111147.199366-3-changbin.du@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 28 Nov 2022 22:00:14 -0800
Message-ID: <CAEf4BzZ6Ks0T=72vtGNc0TyPxHMO6PEFQb8TEYj7XmtqWjfDwQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] makefiles: do not generate empty vmlinux.h
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Nov 26, 2022 at 3:13 AM Changbin Du <changbin.du@gmail.com> wrote:
>
> Remove the empty vmlinux.h if bpftool failed to dump btf info.
> The emptry vmlinux.h can hide real error when reading output
> of make.

wouldn't this be better handled by adding .DELETE_ON_ERROR: to
bpftool's Makefile?

>
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  samples/bpf/Makefile                 | 2 +-
>  tools/bpf/bpftool/Makefile           | 2 +-
>  tools/bpf/runqslower/Makefile        | 2 +-
>  tools/perf/Makefile.perf             | 2 +-
>  tools/testing/selftests/bpf/Makefile | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
> index 727da3c5879b..ab4788b4883e 100644
> --- a/samples/bpf/Makefile
> +++ b/samples/bpf/Makefile
> @@ -362,7 +362,7 @@ ifeq ($(VMLINUX_BTF),)
>         $(error Cannot find a vmlinux for VMLINUX_BTF at any of "$(VMLINUX_BTF_PATHS)",\
>                 build the kernel or set VMLINUX_BTF or VMLINUX_H variable)
>  endif
> -       $(Q)$(BPFTOOL) btf dump file $(VMLINUX_BTF) format c > $@
> +       $(Q)$(BPFTOOL) btf dump file $(VMLINUX_BTF) format c > $@ || { rm $@; exit 1; }
>  else
>         $(Q)cp "$(VMLINUX_H)" $@
>  endif
> diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> index 4a95c017ad4c..d9d6f890884c 100644
> --- a/tools/bpf/bpftool/Makefile
> +++ b/tools/bpf/bpftool/Makefile
> @@ -177,7 +177,7 @@ BUILD_BPF_SKELS := 1
>
>  $(OUTPUT)vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL_BOOTSTRAP)
>  ifeq ($(VMLINUX_H),)
> -       $(QUIET_GEN)$(BPFTOOL_BOOTSTRAP) btf dump file $< format c > $@
> +       $(QUIET_GEN)$(BPFTOOL_BOOTSTRAP) btf dump file $< format c > $@ || { rm $@; exit 1; }
>  else
>         $(Q)cp "$(VMLINUX_H)" $@
>  endif
> diff --git a/tools/bpf/runqslower/Makefile b/tools/bpf/runqslower/Makefile
> index 8b3d87b82b7a..2d7911f4666b 100644
> --- a/tools/bpf/runqslower/Makefile
> +++ b/tools/bpf/runqslower/Makefile
> @@ -77,7 +77,7 @@ ifeq ($(VMLINUX_H),)
>                         "specify its location." >&2;                           \
>                 exit 1;\
>         fi
> -       $(QUIET_GEN)$(BPFTOOL) btf dump file $(VMLINUX_BTF_PATH) format c > $@
> +       $(QUIET_GEN)$(BPFTOOL) btf dump file $(VMLINUX_BTF_PATH) format c > $@ || { rm $@; exit 1; }
>  else
>         $(Q)cp "$(VMLINUX_H)" $@
>  endif
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index a432e59afc42..0546d408aa4e 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -1064,7 +1064,7 @@ VMLINUX_BTF ?= $(abspath $(firstword $(wildcard $(VMLINUX_BTF_PATHS))))
>
>  $(SKEL_OUT)/vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL)
>  ifeq ($(VMLINUX_H),)
> -       $(QUIET_GEN)$(BPFTOOL) btf dump file $< format c > $@
> +       $(QUIET_GEN)$(BPFTOOL) btf dump file $< format c > $@ || { rm $@; exit 1; }
>  else
>         $(Q)cp "$(VMLINUX_H)" $@
>  endif
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index e6cf21fad69f..9aa2475b4ac6 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -284,7 +284,7 @@ endif
>  $(INCLUDE_DIR)/vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL) | $(INCLUDE_DIR)
>  ifeq ($(VMLINUX_H),)
>         $(call msg,GEN,,$@)
> -       $(Q)$(BPFTOOL) btf dump file $(VMLINUX_BTF) format c > $@
> +       $(Q)$(BPFTOOL) btf dump file $(VMLINUX_BTF) format c > $@ || { rm $@; exit 1; }
>  else
>         $(call msg,CP,,$@)
>         $(Q)cp "$(VMLINUX_H)" $@
> --
> 2.37.2
>
