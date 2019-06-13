Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED014475B
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2019 18:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730244AbfFMQ7G (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jun 2019 12:59:06 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41899 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727639AbfFMQ7G (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jun 2019 12:59:06 -0400
Received: by mail-qk1-f193.google.com with SMTP id c11so13200920qkk.8;
        Thu, 13 Jun 2019 09:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=11OleX27xVveG0LvW8hhS+mOJv2guc7A/BC2mPPxyvA=;
        b=SurKhAYJRBJsFlMemN2kRJ6bXLy/QXFfseNapj78YrX3aHam6qtgP1hZZjIISPV2bE
         G7he95bIpytx3uucms6/j1bkIkz+j/rgUnQS+LFSuGoEO5i32gcranmFDcFRPLCpo6Ct
         Mq+uwM/slJvEhZ6d7K5HTpL/HFTTiBhONMT/FE/LNswyNIFDWUzkEnp7GtZ1cEh8YiC1
         ZT5vYlxczI/4ylayRQWESpJCAEcvJ9o3UTGzyj9oAd1kK2J78jtfB6Jn8HPmaaAM3uRN
         NAqtU1gZaw1ObiwUgVDpSHRGBStlsHgh5fp8Y9wG6NChoLD3qlifr0uec+ja1EeNWx8p
         6z9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=11OleX27xVveG0LvW8hhS+mOJv2guc7A/BC2mPPxyvA=;
        b=YSlzNoOyPDE39EPXHT5oF3MZzQAMNHcRP2XK4A+rLKrLVW+Na7KvK4JfQkZ6uFGJo5
         A6eaejaaVs4/2Ns5NZBX88mDkBho/oUpinS14kWyOf0nRxHnai5ZjdmNuCeXN3oN0wSB
         esdlZi2Y+qBLZCDAytOz91jXFtJAZEB7MA5WY7Ay560dR+EfqU1Q5QOoLJvrx5WBrUWp
         ysB2NBNq8f0VHiTa7bc8IF3n7NIumow7jn/zyoisD0eYEyQDPhDt6S9/uFRWGT/7l7Oa
         Gabkhc9HFS6q1kAL7WvHuFVKJUM5TTmXXzT5zLJfKhHTgcP7BZlRG+w+rytz872/gbS4
         rwuA==
X-Gm-Message-State: APjAAAXnvz4jxthV40j26ShUceu4LcZXL5r4exdGE8X4f4C+ZbjrsZft
        Yb8HJ6dSbIl/13VLbgbeCOpsEQvN7pw0MLQV36g=
X-Google-Smtp-Source: APXvYqydEhoSJBurY1SYbVgwzcyCtxVDPuMxRgTpW+wjNbPpqMDmeECXzdzYcRHH2jfwhtdgtHCfz6vfv62PbxmKdM0=
X-Received: by 2002:ae9:eb53:: with SMTP id b80mr43330382qkg.172.1560445144990;
 Thu, 13 Jun 2019 09:59:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190613070021.GG16334@mwanda>
In-Reply-To: <20190613070021.GG16334@mwanda>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 13 Jun 2019 09:58:53 -0700
Message-ID: <CAEf4BzZn4hHobOBiQmSPQhKTrsi7MC=R-7OjWTMyFC03ehrjgg@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: signedness bug in enable_all_controllers()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Shuah Khan <shuah@kernel.org>, Roman Gushchin <guro@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        linux-kselftest@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jun 13, 2019 at 9:40 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> The "len" variable needs to be signed for the error handling to work
> properly.
>
> Fixes: 596092ef8bea ("selftests/bpf: enable all available cgroup v2 controllers")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---

Thanks for the fix!

Acked-by: Andrii Nakryiko <andriin@fb.com>

>  tools/testing/selftests/bpf/cgroup_helpers.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/cgroup_helpers.c b/tools/testing/selftests/bpf/cgroup_helpers.c
> index 0d89f0396be4..e95c33e333a4 100644
> --- a/tools/testing/selftests/bpf/cgroup_helpers.c
> +++ b/tools/testing/selftests/bpf/cgroup_helpers.c
> @@ -47,7 +47,7 @@ int enable_all_controllers(char *cgroup_path)
>         char buf[PATH_MAX];
>         char *c, *c2;
>         int fd, cfd;
> -       size_t len;
> +       ssize_t len;
>
>         snprintf(path, sizeof(path), "%s/cgroup.controllers", cgroup_path);
>         fd = open(path, O_RDONLY);
> --
> 2.20.1
>
