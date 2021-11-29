Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 383F5462836
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Nov 2021 00:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbhK2X0c (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Nov 2021 18:26:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbhK2X0c (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Nov 2021 18:26:32 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047D1C061574;
        Mon, 29 Nov 2021 15:23:14 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id d10so14079180ybn.0;
        Mon, 29 Nov 2021 15:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q8Voy5uooWAJ0Wvka4Qc3hVlnpE6qEJdPmnqpYp38tw=;
        b=Y0VjkYMo6hoVvx7A7gPE9fkIwJAYxOP/mjdIQ6awVrYoDpo1s0ZSvG85enpBOlFBmK
         996lrRvDTryQ0pOVyNFlSSEHHLokd2Nzbr5p7m8k0RAoKtihhEoJHZxh7Fx65QAckZ9T
         Cr93YEXtFwv84XavgyDq2jVRqnPTBkVx9IlgBoSa27nmKmUx8uPjBctERss7KHj/KMGt
         GZJvtUPeL5eguSCAefxE+1YPOq4b1ezR4VaS6chHkmGJB83QTGv04KT1wuflQKRbKeJ/
         9tSJlgps0FVmi8DkF+FJIsxm7ezX9eecLl1q20DZO8hmDTWLAv6VitjrDyArcGFWyRDN
         mYkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q8Voy5uooWAJ0Wvka4Qc3hVlnpE6qEJdPmnqpYp38tw=;
        b=ZQgxpofWbd3arA/QYl+hcCpNIKxr46rtihvXmmM47FezFRWHgijBVXbOIuyn0yRBwt
         remmYaXD6aVXBUz07ScfMA7eAnAogR1e1YTxzwHgQhn/HU7CyPWX9lYDj2vjhzLjyS+M
         x57vTmtYBMSiIy3uol7d1HJAgyXUNZghK+cI/oRRwrLgJzP6BuCSQZuoaANa4sUlY32c
         2Va8h6zcGR8jRB2w11x1e43ToUmXcM4YyS5E6UOXkc9+MqU9hG71NPakavxODoSki+Fa
         NXD2Upc+1X1kA1aoUzM0eltEJawHdEEcutrKWkaaqGtV5k4j9E/yMx5EkcoxwnERGb5y
         sqIg==
X-Gm-Message-State: AOAM533Sp5mZYkH7VT9Cdc16q4Q1z7FdtLrNdj0paqCxClxylgL4KBpx
        KRrDhpouSUw/6Cp+V25DTg5YWXleiKh0JIfT6H4=
X-Google-Smtp-Source: ABdhPJzWiqrQ7y0z5r2dPD9XLru3FWQUfNxTZSDjV0LMVc2GUCIt1y6+V16pMVPikbm2STH2C6Ak4x446PqTmIBo38c=
X-Received: by 2002:a25:b204:: with SMTP id i4mr38274867ybj.263.1638228193297;
 Mon, 29 Nov 2021 15:23:13 -0800 (PST)
MIME-Version: 1.0
References: <20211129111508.404367-1-jean-philippe@linaro.org>
In-Reply-To: <20211129111508.404367-1-jean-philippe@linaro.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 29 Nov 2021 15:23:02 -0800
Message-ID: <CAEf4BzZqyiGC-941FwOxRJZPVHn38vkyEp479nfchKZnZ=kehw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Build testing_helpers.o out of tree
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 29, 2021 at 3:17 AM Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
>
> Add $(OUTPUT) prefix to testing_helpers.o, so it can be built out of
> tree when necessary. At the moment, in addition to being built in-tree
> even when out-of-tree is required, testing_helpers.o is not built with
> the right recipe when cross-building.
>
> Fixes: f87c1930ac29 ("selftests/bpf: Merge test_stub.c into testing_helpers.c")
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  tools/testing/selftests/bpf/Makefile | 32 ++++++++++++++--------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 35684d61aaeb..082f6aeec1d9 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -192,22 +192,22 @@ TEST_GEN_PROGS_EXTENDED += $(DEFAULT_BPFTOOL)
>
>  $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED): $(BPFOBJ)
>
> -$(OUTPUT)/test_dev_cgroup: cgroup_helpers.c testing_helpers.o

one of cgroup_helper.c (C source code) or testing_helper.o (object
file) is wrong, let's ensure that the dependencies are correct while
at it?


> -$(OUTPUT)/test_skb_cgroup_id_user: cgroup_helpers.c testing_helpers.o
> -$(OUTPUT)/test_sock: cgroup_helpers.c testing_helpers.o
> -$(OUTPUT)/test_sock_addr: cgroup_helpers.c testing_helpers.o
> -$(OUTPUT)/test_sockmap: cgroup_helpers.c testing_helpers.o
> -$(OUTPUT)/test_tcpnotify_user: cgroup_helpers.c trace_helpers.c testing_helpers.o
> -$(OUTPUT)/get_cgroup_id_user: cgroup_helpers.c testing_helpers.o
> -$(OUTPUT)/test_cgroup_storage: cgroup_helpers.c testing_helpers.o
> -$(OUTPUT)/test_sock_fields: cgroup_helpers.c testing_helpers.o
> -$(OUTPUT)/test_sysctl: cgroup_helpers.c testing_helpers.o
> -$(OUTPUT)/test_tag: testing_helpers.o
> -$(OUTPUT)/test_lirc_mode2_user: testing_helpers.o
> -$(OUTPUT)/xdping: testing_helpers.o
> -$(OUTPUT)/flow_dissector_load: testing_helpers.o
> -$(OUTPUT)/test_maps: testing_helpers.o
> -$(OUTPUT)/test_verifier: testing_helpers.o
> +$(OUTPUT)/test_dev_cgroup: cgroup_helpers.c $(OUTPUT)/testing_helpers.o
> +$(OUTPUT)/test_skb_cgroup_id_user: cgroup_helpers.c $(OUTPUT)/testing_helpers.o
> +$(OUTPUT)/test_sock: cgroup_helpers.c $(OUTPUT)/testing_helpers.o
> +$(OUTPUT)/test_sock_addr: cgroup_helpers.c $(OUTPUT)/testing_helpers.o
> +$(OUTPUT)/test_sockmap: cgroup_helpers.c $(OUTPUT)/testing_helpers.o
> +$(OUTPUT)/test_tcpnotify_user: cgroup_helpers.c trace_helpers.c $(OUTPUT)/testing_helpers.o
> +$(OUTPUT)/get_cgroup_id_user: cgroup_helpers.c $(OUTPUT)/testing_helpers.o
> +$(OUTPUT)/test_cgroup_storage: cgroup_helpers.c $(OUTPUT)/testing_helpers.o
> +$(OUTPUT)/test_sock_fields: cgroup_helpers.c $(OUTPUT)/testing_helpers.o
> +$(OUTPUT)/test_sysctl: cgroup_helpers.c $(OUTPUT)/testing_helpers.o
> +$(OUTPUT)/test_tag: $(OUTPUT)/testing_helpers.o
> +$(OUTPUT)/test_lirc_mode2_user: $(OUTPUT)/testing_helpers.o
> +$(OUTPUT)/xdping: $(OUTPUT)/testing_helpers.o
> +$(OUTPUT)/flow_dissector_load: $(OUTPUT)/testing_helpers.o
> +$(OUTPUT)/test_maps: $(OUTPUT)/testing_helpers.o
> +$(OUTPUT)/test_verifier: $(OUTPUT)/testing_helpers.o
>
>  BPFTOOL ?= $(DEFAULT_BPFTOOL)
>  $(DEFAULT_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] $(BPFTOOLDIR)/Makefile)    \
> --
> 2.34.0
>
