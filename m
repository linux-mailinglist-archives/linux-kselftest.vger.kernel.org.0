Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60FAC63E6B4
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Dec 2022 01:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbiLAAw1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Nov 2022 19:52:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiLAAw0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Nov 2022 19:52:26 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78CFC7B4F9;
        Wed, 30 Nov 2022 16:52:25 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id bj12so542747ejb.13;
        Wed, 30 Nov 2022 16:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EcYtG8fJSEFaCTYWXfq8R84dSZ3VnLHvz4JUlumXUv0=;
        b=JmfG+COHj9Da/GW0CY8kh7AJfSJyMm9+YNe16nEaUflGBG6szpdDdtghgAIiqIxHtq
         R7u81kK2IxZyx0MmKk2Dy3kunXIwYV4HlgjYGhOqa6za8zpbMwZ3fteFGHcfAmAD5CbI
         g1OV7jCWgVse0lMZF1RSqZf3E20f1mo5mg4gqeZf8b6gL3jqwyuA4A4fe7k0E2tK/QDA
         tdOJLRZfkXO+PCWZ5wlaO61EBzzPw4PvEaD/0/53fAUuVxi4Y8smSCK7jKN5/nLqhDGm
         S/oH1QtsjA53QdtF8+yloWmnBLr8L3xo8nEZErqUZiflzgOz2DzsdE8zPgUW1YKRwJro
         giaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EcYtG8fJSEFaCTYWXfq8R84dSZ3VnLHvz4JUlumXUv0=;
        b=RMT0L8pEG5vksa24zi5eGTWyfY83MHY7Lz5ZcCpnPJOHSKEEPjfEQghNMxSkmMP4xg
         lHay6xW0GPs/TVga/NBRW97DL7r3UTuo5aGPezKCSpOUPccYUmnR+Wy8dn0Ty+O9eO5L
         xzYAqb4bIWqmq7lhJMQQqvFnw6DJntCvir/X8M64DMtZSyDcdvZxk5onvP2Dade+89se
         S4kPrsOV75IYEAwfmTnvcCf3QY7hrWVCTyCLJ1EJb9770WQG1gycWS9Rg1ie4LRB4IFV
         ICd+nNZK8PYEKFBFZqrnPUhrZwXctFZgxAm2FOc4SsxgIylmOvpbY0bsLKGBFD+DTZ7L
         003g==
X-Gm-Message-State: ANoB5pkp2SHbC1HMO52cbvfZ6wLtUJJMnSCy14f8ajX458sdDMqO5dSt
        i2XK1byiMKGcZjzJw8Avjec4diTIknyFHi8seto=
X-Google-Smtp-Source: AA0mqf6dDvYisUlUN1Gsr07MRUCfV4BhoiCvKwdt+tl2x5lYg06ZyMUT9ehXEzASQCkZ66ZQYbfL6pluykPBul1Ep5k=
X-Received: by 2002:a17:906:414c:b0:7a9:ecc1:2bd2 with SMTP id
 l12-20020a170906414c00b007a9ecc12bd2mr42513746ejk.545.1669855943871; Wed, 30
 Nov 2022 16:52:23 -0800 (PST)
MIME-Version: 1.0
References: <20221129134217.52767-1-changbin.du@gmail.com> <20221129134217.52767-3-changbin.du@gmail.com>
In-Reply-To: <20221129134217.52767-3-changbin.du@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 30 Nov 2022 16:52:11 -0800
Message-ID: <CAEf4BzZPZeeGJTZC3NSm+Km4RZirGrwr8d8dXepLmBLTiUn8Hg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] bpf: makefiles: do not generate empty vmlinux.h
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

On Tue, Nov 29, 2022 at 5:42 AM Changbin Du <changbin.du@gmail.com> wrote:
>
> Remove the empty vmlinux.h if bpftool failed to dump btf info.
> The emptry vmlinux.h can hide real error when reading output

typo: empty

> of make.
>
> This is done by adding .DELETE_ON_ERROR special target in related
> makefiles.
>
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  tools/bpf/bpftool/Makefile           | 3 +++
>  tools/perf/Makefile.perf             | 2 ++
>  tools/testing/selftests/bpf/Makefile | 3 +++
>  3 files changed, 8 insertions(+)
>
> diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> index 4a95c017ad4c..f6b1e65085db 100644
> --- a/tools/bpf/bpftool/Makefile
> +++ b/tools/bpf/bpftool/Makefile
> @@ -265,3 +265,6 @@ FORCE:
>  .PHONY: all FORCE bootstrap clean install-bin install uninstall
>  .PHONY: doc doc-clean doc-install doc-uninstall
>  .DEFAULT_GOAL := all
> +
> +# Delete partially updated (corrupted) files on error
> +.DELETE_ON_ERROR:
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index a432e59afc42..265254fc641a 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -1149,3 +1149,5 @@ FORCE:
>  .PHONY: libtraceevent_plugins archheaders
>
>  endif # force_fixdep
> +
> +.DELETE_ON_ERROR:

please split out perf changes, they should go through perf tree

> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index e6cf21fad69f..f41c4b011221 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -617,3 +617,6 @@ EXTRA_CLEAN := $(TEST_CUSTOM_PROGS) $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)      \
>                                liburandom_read.so)
>
>  .PHONY: docs docs-clean
> +
> +# Delete partially updated (corrupted) files on error
> +.DELETE_ON_ERROR:
> --
> 2.37.2
>
