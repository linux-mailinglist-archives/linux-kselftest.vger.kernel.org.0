Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7524422F7
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Nov 2021 23:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbhKAWC6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 1 Nov 2021 18:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbhKAWC5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 1 Nov 2021 18:02:57 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5CBC061714;
        Mon,  1 Nov 2021 15:00:23 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id k4so3026106plx.8;
        Mon, 01 Nov 2021 15:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lQidb9JCO2tS/0bSUKgi1+mcgxOacGZsvxUTQHhQVCo=;
        b=clC7qZvzfmQnXJfsuJsBcm+xJ5bkWRiWPjWISgR24F4fyl3VUF5Ss5xuqotGo0zjXE
         A3l9ic0D7evlfSTL405qR2G0i7kNJtjEXMOngR/bd6S0GgkGFob2ldX9y7ZDveNVx/ga
         dgN6WcsoV19FXTc5KyT4G5Qun84rFPEZ+ovOqjqSC6AFp6IHz+l5K2gq3FgN4v9F7NHP
         JH8y2s7euqOSP9tI1ZgimkiC6HxULTLCnnA4U658duNPprVcftZFSczvxFa4sdT+zmaY
         hcpNSFqSP+6KZDHOKXlbNJji/kqI357JYXVyFmjrBlU8VNQd2uQIAXRMAau8PZH9HKLs
         btcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lQidb9JCO2tS/0bSUKgi1+mcgxOacGZsvxUTQHhQVCo=;
        b=3epESxORpcRAXrN7FtbLkffYSWtxnUseupuLDZHFl7qJXk8iJu6T0NmQAZXWRNsYsm
         eeVU8D20J4Ib6sX7LS8bvKD1FkcMdJUpdrGWmLzG6UXKY3RZJCp7AYBwk/tiPp+10xs/
         F8rk7K1yVFBHtuS9KV/SNs/sXKj3CFRxyp4frfIuDgarcV32/1DWfrF4X9vFUC0ysTS+
         rfsTGnRsVicUz9wQLDwu9f3FJa/rYfU55RdXkwP80QhIQmQTg1bRCdcnv+hGqnF+OxPC
         +pxD1xiddap1wcH492/H+W2a90Ko/GGuzL2Y+gkXc2WRPGLii+EsZrukbVS7hYWNZubv
         vubQ==
X-Gm-Message-State: AOAM5320yIEHistRavJVZiT/nMt56hy9JvFEo2h0taim0vVIKD6R50iA
        kSWG5JwBk06yAL+nsrDl8vJzc6D15zwH40nvuMU=
X-Google-Smtp-Source: ABdhPJxsuUlznQMiJfwR4AYM4OltePlg0lfGOqzeFIiCgNE6YPQ0+SnbfkmsYDVcB6cHSBeVY91V0Lz+V3+X/0baJSQ=
X-Received: by 2002:a17:902:7246:b0:138:a6ed:66cc with SMTP id
 c6-20020a170902724600b00138a6ed66ccmr28298780pll.22.1635804022932; Mon, 01
 Nov 2021 15:00:22 -0700 (PDT)
MIME-Version: 1.0
References: <20211101124310.3947887-1-yangyingliang@huawei.com>
In-Reply-To: <20211101124310.3947887-1-yangyingliang@huawei.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 1 Nov 2021 15:00:11 -0700
Message-ID: <CAADnVQJS_2St=iaqHU+zasy_0A0bidJN=STnkHrNcSNL5vO1Dg@mail.gmail.com>
Subject: Re: [PATCH -next v2] bpf/benchs: Fix return value check of bpf_program__attach()
To:     Yang Yingliang <yangyingliang@huawei.com>,
        Joanne Koong <joannekoong@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 1, 2021 at 5:35 AM Yang Yingliang <yangyingliang@huawei.com> wrote:
>
> If bpf_program__attach() fails, it never returns NULL,
> we should use libbpf_get_error() to check the return value.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> Acked-by: Yonghong Song <yhs@fb.com>
> ---
> v2:
>   don't use 'int err'
> ---
>  .../selftests/bpf/benchs/bench_bloom_filter_map.c      | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/benchs/bench_bloom_filter_map.c b/tools/testing/selftests/bpf/benchs/bench_bloom_filter_map.c
> index 6eeeed2913e6..4afaa4adb327 100644
> --- a/tools/testing/selftests/bpf/benchs/bench_bloom_filter_map.c
> +++ b/tools/testing/selftests/bpf/benchs/bench_bloom_filter_map.c
> @@ -304,7 +304,7 @@ static void bloom_lookup_setup(void)
>         populate_maps();
>
>         link = bpf_program__attach(ctx.skel->progs.bloom_lookup);
> -       if (!link) {
> +       if (libbpf_get_error(link)) {

Please use ASSERT_OK_PTR() instead.
See how other tests are doing it.
