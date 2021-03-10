Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFE4D3338C4
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Mar 2021 10:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbhCJJcq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 Mar 2021 04:32:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38167 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229657AbhCJJcQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 Mar 2021 04:32:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615368735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a/DGLUjr6IILhrnvlay+wj8znvny6CeX2t2rrG8Z35w=;
        b=ciB9T3xq7P1SFhCuUiVy1do1gcAGm0YIDC38N7Z3jaKajpyyt91ZJxIqfO34q8RYrqhr8Z
        BGsTsi+vH7EA2U7kiIRsIxpq7Av77NFaFUXrMBBSD93l2iXBBXCcIyvG+q3e4blabI5Aou
        1SX4JPNXh64WyUpD4PMXdwCuxWtC61k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-564-L5Wfgc8NOTesoyBzphPIXg-1; Wed, 10 Mar 2021 04:32:13 -0500
X-MC-Unique: L5Wfgc8NOTesoyBzphPIXg-1
Received: by mail-wm1-f71.google.com with SMTP id m17so901348wml.3
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Mar 2021 01:32:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a/DGLUjr6IILhrnvlay+wj8znvny6CeX2t2rrG8Z35w=;
        b=FwloSeX81dIFXRHAO7thAJMtcaJqg+8ZZuzne8GE7Vn4FXBw+z6P3qVatUApsna/BF
         IABvKV+RPI28554mp2M9fh2A4CP2SvJoXGM3iFBjg9LrtYbDlGAoIXajYswP/50/aim1
         2imzBbDD0TLOPus2zT79fhXmIqdjpVTB7SF2BFKMHl9NLFKv1BXfhoVbmjc6vT0uoDra
         3n1kJ6KJU2CldOakdiKgJAuENzaV8jZrHH4FIRbL/2jxxT5tCIK7+qleWB7TcvVbqoeu
         9KnoJ9J7OJDL2T8gD+r7+2niLBczYZRuFCijLyJCQZlJfS8cMnSwUsNj0fokEydwmBki
         eDkw==
X-Gm-Message-State: AOAM533pxIeuBMj1swsfAX4xt4JeY/aUlWYJ6lFAPBdjz4HQyxrp2Iij
        QsjspsehHT24Lv1G+be34c90nxMQUHYwwrOIOHeBNaAuc0HqCK0b4mTZitVbSzXp0unFjx6h05g
        eS8Hlj+L5jUT6cSNRSQRLgBGsYcy5IvJx9jE1vgSzjQXw
X-Received: by 2002:a1c:9a92:: with SMTP id c140mr2302130wme.167.1615368732287;
        Wed, 10 Mar 2021 01:32:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz6CFSwlUzoJ4DXYOWb33EVxww5GlWKF+Jye6YtiyemSL6//yJ3H6N2hZHNqqPE7V+05jeDqd5YlGft8h3cH0w=
X-Received: by 2002:a1c:9a92:: with SMTP id c140mr2302102wme.167.1615368732055;
 Wed, 10 Mar 2021 01:32:12 -0800 (PST)
MIME-Version: 1.0
References: <1615357366-97612-1-git-send-email-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <1615357366-97612-1-git-send-email-jiapeng.chong@linux.alibaba.com>
From:   Yauheni Kaliuta <ykaliuta@redhat.com>
Date:   Wed, 10 Mar 2021 11:31:56 +0200
Message-ID: <CANoWsw=ga1G6_XPhWmvE5QgUmmOVOEVzX_0HDYF9BZagvKD+Tw@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: fix warning comparing pointer to 0
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     shuah <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, andrii@kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, netdev@vger.kernel.org,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Mar 10, 2021 at 8:23 AM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> Fix the following coccicheck warning:
>
> ./tools/testing/selftests/bpf/progs/test_global_func10.c:17:12-13:
> WARNING comparing pointer to 0.

but it's ok from the C standard point of view

>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  tools/testing/selftests/bpf/progs/test_global_func10.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/progs/test_global_func10.c b/tools/testing/selftests/bpf/progs/test_global_func10.c
> index 61c2ae9..97b7031 100644
> --- a/tools/testing/selftests/bpf/progs/test_global_func10.c
> +++ b/tools/testing/selftests/bpf/progs/test_global_func10.c
> @@ -14,7 +14,7 @@ struct Big {
>
>  __noinline int foo(const struct Big *big)
>  {
> -       if (big == 0)
> +       if (!big)
>                 return 0;
>
>         return bpf_get_prandom_u32() < big->y;
> --
> 1.8.3.1
>


-- 
WBR, Yauheni

