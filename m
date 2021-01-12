Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A44F2F3D15
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Jan 2021 01:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438133AbhALVh0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Jan 2021 16:37:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437062AbhALUzy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Jan 2021 15:55:54 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC597C061575;
        Tue, 12 Jan 2021 12:55:13 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id b64so35122ybg.7;
        Tue, 12 Jan 2021 12:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vg273i8HjIy6UymSWnRMKSsemhVKM+di1x5efB62R5Q=;
        b=K3TWlToJxzXs2LY2H6Eul0mbbzBmW/EqKvU7DEYpWOwWWEOw0B6225/G2MQHl5BtiH
         H5SaxLbSe3ptqmEKs+i+mRMphFPK9RGv7YHOqfxcUq03AZGOE2sn0kgfHXpkpgVYHZBn
         GuObjKF7kOiLlLoqdDQli7Vfzh/PESIwW/yPH5ZgdfcGklykX+NGyzFlxjNp+vLiTquN
         onueuzAxp4DGD/Mnhz5L4UJM81grES6JsHQXUlfDg42U+2/nZRwTlgWt9WLwEYWGdcfa
         2TDDz+udT02Y7FfHR6CwmVff8gGrER65FckMwHBRsO000/HRgbUxzTMtnN9mvVIZWoIv
         I8yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vg273i8HjIy6UymSWnRMKSsemhVKM+di1x5efB62R5Q=;
        b=ENjsKgNukbG21Wv2rOoKB7AREYlHl1fJ0FNv9RsahzK6265xSv3Euq6e+nGuBkUTGO
         amHM1aAN5Gh7HrSln/lIZ5f+lJGc20Pvu+IXdu/y2/WGR6hO26bUz+UaFj0BG5LlDKOQ
         8JL7vvo57IQxp4f2LSkXdunrqGRp7/ZeqKFwPysbDn+0jSYmgHxugCAlBO5rQXDUnXQL
         GNAt4LEFGcWiwfO/aOHhkRaZQ//ffhKJ5nv5BUgxBQk0xQkwbAKf2f9iIW2fmTTty8AN
         NsOOkA6kOrv6ALEe2ddu9P8HclYerHD/T+ADU3G8byAG4Glx0HXvBpkCFZMoletgidEy
         YhxA==
X-Gm-Message-State: AOAM530TdPlfKsvS4uDQxnnyd+L67oyGmNT7gJOXu6cMFceu/ZOlWPI6
        ejvY3YMUpcra5np9tj3mvdMGvHI9DjcFzOCAZ/4=
X-Google-Smtp-Source: ABdhPJxKDBM4wmn82Ola5dy2FN5qpSAZDdp7cqE9nTsZplPzi5RqNY/evreF5w/rfQ3Sv0csOVISTr44xoe5jVRAi/k=
X-Received: by 2002:a25:48c7:: with SMTP id v190mr1881370yba.260.1610484913139;
 Tue, 12 Jan 2021 12:55:13 -0800 (PST)
MIME-Version: 1.0
References: <20210112135959.649075-1-jean-philippe@linaro.org> <20210112135959.649075-6-jean-philippe@linaro.org>
In-Reply-To: <20210112135959.649075-6-jean-philippe@linaro.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 12 Jan 2021 12:55:02 -0800
Message-ID: <CAEf4BzZhDut7QAG-M7cxtVxehebM=bge6uckeU_aJ6yp+pSu9w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 5/5] selftests/bpf: Install btf_dump test cases
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
> The btf_dump test cannot access the original source files for comparison
> when running the selftests out of tree, causing several failures:
>
> awk: btf_dump_test_case_syntax.c: No such file or directory
> ...
>
> Add those files to $(TEST_FILES) to have "make install" pick them up.
>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  tools/testing/selftests/bpf/Makefile | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index bffb4ad59a3d..fb8cddc410c0 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -46,7 +46,14 @@ endif
>
>  TEST_GEN_FILES = test_lwt_ip_encap.o \
>         test_tc_edt.o
> -TEST_FILES = xsk_prereqs.sh
> +TEST_FILES = xsk_prereqs.sh \
> +       progs/btf_dump_test_case_syntax.c \
> +       progs/btf_dump_test_case_ordering.c \
> +       progs/btf_dump_test_case_padding.c \
> +       progs/btf_dump_test_case_packing.c \
> +       progs/btf_dump_test_case_bitfields.c \
> +       progs/btf_dump_test_case_multidim.c \
> +       progs/btf_dump_test_case_namespacing.c


maybe wildcard(progs/btf_dump_test_case_*) instead? one less thing to
remember to update, if we ever add another test case

>
>  # Order correspond to 'make run_tests' order
>  TEST_PROGS := test_kmod.sh \
> --
> 2.30.0
>
