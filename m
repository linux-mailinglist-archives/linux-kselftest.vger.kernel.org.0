Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7D22F3D25
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Jan 2021 01:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437080AbhALVh1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Jan 2021 16:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437085AbhALU6P (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Jan 2021 15:58:15 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667D2C061794;
        Tue, 12 Jan 2021 12:57:35 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id x6so73434ybr.1;
        Tue, 12 Jan 2021 12:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KB7oXI0TdG8mX7iw4ybdkJinKpzFFbGrsIyg/1o6iKg=;
        b=NbeK7XO91vCWhSPRiAsrvyEyiZk0uSK8WqW3GaH8nmgi2u8u9u2d8WmfA2DVItQDpO
         7tE+zG51PjDHCnhvMXMV0gd65biXIdqRx/oOgaiVRnpT8zj4gS4UuCsylJRM2MtL0UZ9
         so6yN7yD7bluxTV2O0AZtm9WBIHapsRylX3F6le1pJCgD5a5nzG9GtVSUL9xco38uAWE
         v4v/1KB81twly2vQzfAyOm3qCObSmscrd2sVJ62ryWGur0oExEqoFh33RrfW+rQ07+IG
         xnQmbjQZU37YJy6YGRTqm/xfxu4AswPZWL+AV2eNK4Tpbi/Pdn2OpgpUHISV8p3QdE3y
         xWLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KB7oXI0TdG8mX7iw4ybdkJinKpzFFbGrsIyg/1o6iKg=;
        b=Apaf307S1OAbC1L61D6o7CPCFRzYZaDmnOig20hXhFe3OsyOaxy/ULl78OwtUU6IzJ
         cEbMV6hy48yA89ybCXl8b9aSiDrYLp9nviFSE+DKW+7/ogunXzJaB+XM8KoFGM4a6LNM
         mk9MuwsGaThOR56xdwT0uhEjIMClBSRpd3InEhT6kLIpf7f1a10tZ8snBQTPPiuGuLBJ
         1+NVS4OTeh0hGWBFO1+IdOx6a0p9FB56PqBLyVmZfqWVFnV82SxinKR7k+crXnBXKQR7
         v9QfBVjI9wr4SoIrwE3+ILdjniMKtcHCJOKmvmZuPKao4SSlVXZBSvNvqw4uDJGyIcev
         JMyQ==
X-Gm-Message-State: AOAM530KijmCmWm0/kEJFZeYo6daX6DTlWTKGADhJ9xiFlaotY7jtSTt
        wjPM2ZxCPn2QCAPfVkeww+gsVjahV1SHoE+sfDc=
X-Google-Smtp-Source: ABdhPJyDNf1y1VzAW0laGnW76nx7M6B3oMZdkGJMTzAkp3FW1bKguyedX5FI9jBiq+J6QgSpt6ye3afG75Wko61tmmY=
X-Received: by 2002:a25:854a:: with SMTP id f10mr1855040ybn.510.1610485054756;
 Tue, 12 Jan 2021 12:57:34 -0800 (PST)
MIME-Version: 1.0
References: <20210112135959.649075-1-jean-philippe@linaro.org> <20210112135959.649075-5-jean-philippe@linaro.org>
In-Reply-To: <20210112135959.649075-5-jean-philippe@linaro.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 12 Jan 2021 12:57:24 -0800
Message-ID: <CAEf4BzYX_6oL=v4wqe2LHAOq0dZJyq5=vDv-Cc3YVJKFOWHvJg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/5] selftests/bpf: Fix installation of urandom_read
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
> For out-of-tree builds, $(TEST_CUSTOM_PROGS) require the $(OUTPUT)
> prefix, otherwise the kselftest lib doesn't know how to install them:
>
> rsync: [sender] link_stat "tools/testing/selftests/bpf/urandom_read" failed: No such file or directory (2)
>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---

Acked-by: Andrii Nakryiko <andrii@kernel.org>


>  tools/testing/selftests/bpf/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 046848c508d1..bffb4ad59a3d 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -82,7 +82,7 @@ TEST_GEN_PROGS_EXTENDED = test_sock_addr test_skb_cgroup_id_user \
>         test_lirc_mode2_user xdping test_cpp runqslower bench bpf_testmod.ko \
>         xdpxceiver
>
> -TEST_CUSTOM_PROGS = urandom_read
> +TEST_CUSTOM_PROGS = $(OUTPUT)/urandom_read
>
>  # Emit succinct information message describing current building step
>  # $1 - generic step name (e.g., CC, LINK, etc);
> --
> 2.30.0
>
