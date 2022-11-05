Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5418D61DF0B
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Nov 2022 23:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiKEWaf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 5 Nov 2022 18:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKEWae (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 5 Nov 2022 18:30:34 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F22311A12
        for <linux-kselftest@vger.kernel.org>; Sat,  5 Nov 2022 15:30:31 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id x16so4253809ilm.5
        for <linux-kselftest@vger.kernel.org>; Sat, 05 Nov 2022 15:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CbBRCqYlzL5aIOV/FIaD3IiZ/MIQgFytQcTe8Ul9rWk=;
        b=PXiWAzVmOTq6MGJT16VHLmmAgF9HAeDaUY3bKDIRjX1G2Y65KvekkmTwB3jXjs7l8j
         3pwPXGGFlmVDhSaP9TQBDvvS6p+fAWGePMqqaRzzzDXHP3KJe6vIEtBlUYLCnWIeVYWH
         Ur3sBQPhqJ9Oxf9cpbNiQGJDIzJIItYtzHmtxg3clYTMzc4hOrUKhdgu8eInd8uXzmfA
         k95eZ9IVCthx6Phbt4Yks+3rpYJa3InS68hKNKmTwEALPL0g5Nml8gTVHzucq3y6Jb8G
         14nj2uu2GiE7DWFSSY89/Px2IvRk5FMIk9gai01Ied2ap6Bp2Jba4/6u5484C+uU7lis
         IzFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CbBRCqYlzL5aIOV/FIaD3IiZ/MIQgFytQcTe8Ul9rWk=;
        b=ZgHL14fFSr5Hhh0ySQdLJV0xQzDFbZ40hFiwk7Tr1aioLuXVV4+f4jsOqaTay1XRH0
         hyQQgFsNlNZxNuW5Pe7C2vy1xJ3tAR/wdAAnOvU7fRyJdND9RvOnHCLeLRDkEk7l56an
         DCIPVXwZzz78kOqE1tKl2DvVc1N0h5+Wlxu1Xp2RlyBcz/dGZo/Nyr4JAff+Ypu/MhFA
         nf4YFRNl/OWory3cOZ4agIANWU8FvBmCbczVDiw4gvVVs5Y8hq+icAFji4DxcBoPN01o
         q1Ze0SZynieJ0MxoW8cx1cmMF/TSr/kIECzNEcX2QKJ/CjMiqhAi78v9sdcBW4oUJTWz
         LL2Q==
X-Gm-Message-State: ACrzQf1h3BVPJDPDCvMQ7FnSr8x4/rr5QmPXLWQNktX/gB/ipwS4nppI
        Ta7+dCmU7AozI9ZId6JNzrKJL/UW7jjx9xN59FLm+w==
X-Google-Smtp-Source: AMsMyM40J9EK7H7dWx591VUYW8EeLwt7+r08P2BAfLCDJSKXILT7X4jfxhmxeUVbeOgoZHWLsVX+C2ikvjOfOmPCHIo=
X-Received: by 2002:a05:6e02:d49:b0:300:d893:a3f8 with SMTP id
 h9-20020a056e020d4900b00300d893a3f8mr8609481ilj.53.1667687430424; Sat, 05 Nov
 2022 15:30:30 -0700 (PDT)
MIME-Version: 1.0
References: <20221105110611.28920-1-yuehaibing@huawei.com>
In-Reply-To: <20221105110611.28920-1-yuehaibing@huawei.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Sat, 5 Nov 2022 15:29:54 -0700
Message-ID: <CAJD7tkb06mjZ3bvoiR4U47+XknM4nTHY06RYZ8SULOxJ4mAOwQ@mail.gmail.com>
Subject: Re: [PATCH] selftests: cgroup: Fix unsigned comparison with less than zero
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        shuah@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        rientjes@google.com, akpm@linux-foundation.org,
        cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Nov 5, 2022 at 4:06 AM YueHaibing <yuehaibing@huawei.com> wrote:
>
> 'size' is unsigned, it never less than zero.
>
> Fixes: 6c26df84e1f2 ("selftests: cgroup: return -errno from cg_read()/cg_write() on failure")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Thanks for fixing this!
FWIW,

Reviewed-by: Yosry Ahmed <yosryahmed@google.com>




> ---
>  tools/testing/selftests/cgroup/cgroup_util.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/cgroup/cgroup_util.c b/tools/testing/selftests/cgroup/cgroup_util.c
> index 4c52cc6f2f9c..e8bbbdb77e0d 100644
> --- a/tools/testing/selftests/cgroup/cgroup_util.c
> +++ b/tools/testing/selftests/cgroup/cgroup_util.c
> @@ -555,6 +555,7 @@ int proc_mount_contains(const char *option)
>  ssize_t proc_read_text(int pid, bool thread, const char *item, char *buf, size_t size)
>  {
>         char path[PATH_MAX];
> +       ssize_t ret;
>
>         if (!pid)
>                 snprintf(path, sizeof(path), "/proc/%s/%s",
> @@ -562,8 +563,8 @@ ssize_t proc_read_text(int pid, bool thread, const char *item, char *buf, size_t
>         else
>                 snprintf(path, sizeof(path), "/proc/%d/%s", pid, item);
>
> -       size = read_text(path, buf, size);
> -       return size < 0 ? -1 : size;
> +       ret = read_text(path, buf, size);
> +       return ret < 0 ? -1 : ret;
>  }
>
>  int proc_read_strstr(int pid, bool thread, const char *item, const char *needle)
> --
> 2.17.1
>
