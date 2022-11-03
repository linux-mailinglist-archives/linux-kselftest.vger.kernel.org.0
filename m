Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A594D6187DD
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Nov 2022 19:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbiKCSqL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Nov 2022 14:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiKCSqK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Nov 2022 14:46:10 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB5665A5;
        Thu,  3 Nov 2022 11:46:09 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id kt23so7720377ejc.7;
        Thu, 03 Nov 2022 11:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j7j8fpatI7hctDB5/Xg8uKnBvlsg/p0ILGC2iV1ZV2A=;
        b=hCqDEquaJ67YeB5YKBtZIw6MJmrflZUVmeB9yq8dKG/7vmN6+d+HZTxq9Axoy9HLlF
         u74YOUQgT5nkxKIZzeQgN+KtzXCD2Wvi1eRO/2/nbbFoLO3FtIZHcjFgawPnHoI2eElp
         sxelnry0JgKt650KBcf0bYQvUaITsMPjvjVAikOGIkVxcg2DkyeQxchHTsIrE3G7CNLH
         b1izBh6XYWuRN8SGs8aMY3yqmA3xHpXl6Yq3U0M/MJDoxAI6/hf05JPtZujYJ/vBreSB
         0ju9rhvARCQH84DVd38mPgLMIGABZwBF08hi9HZz+LRVnSPflqvgqGluGXkDeERRxb2B
         MqUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j7j8fpatI7hctDB5/Xg8uKnBvlsg/p0ILGC2iV1ZV2A=;
        b=eYw+57F3/EEG69GS0G2yotlkmIE28+4uDN7r2dl+zsnxqueCWJnZKfLp1Z5A2LCIAQ
         V54LzOZrOTDn8htIgM+3iykUaEy2WQbLGehZNqEAVy8WY09iLLdKaRlTF+b0iWL7p4W1
         K2UTqEN4YCQG2lLDX3kVTolQwGv1dmS9HGiOGLes1rWzQgKNU5M8bUpnIX1GBVhRznS4
         oQIPGLHpckC4uyPoLf3LT+HrrBYFhimg4Z566jsdgD7KfXiYPUiLK5eBaI2YNOGirvHo
         jxYbmXHe5RH7WgK1qIguuhWOUAPKUl3D1dcoXRhTS6m1oohJbvIk23sL3AuZQFYptlqr
         0Cjw==
X-Gm-Message-State: ACrzQf0yDwPTG60YLsIjJRhCVMQWPk17GjGM+VGQPER3fFMtmYvO9EUV
        BVwjtQtgAR4oZ4kP6M0Q2boDgq//X9K3yYesV/8=
X-Google-Smtp-Source: AMsMyM5cjPmhfzKuklASWFxdj0kWtKrTHOk3PK6YwTu2zs13KaHE/C6O3pHb86S8ygc/dU1ydWZyVC//abeOaSKhgnU=
X-Received: by 2002:a17:907:9705:b0:7ad:b14f:d89e with SMTP id
 jg5-20020a170907970500b007adb14fd89emr29242135ejc.745.1667501167813; Thu, 03
 Nov 2022 11:46:07 -0700 (PDT)
MIME-Version: 1.0
References: <fe0e300f-a857-dc42-f9f8-c524be6b212f@iogearbox.net> <tencent_B91CA31B889B06CF4292592F97892A53AF08@qq.com>
In-Reply-To: <tencent_B91CA31B889B06CF4292592F97892A53AF08@qq.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 3 Nov 2022 11:45:55 -0700
Message-ID: <CAEf4BzYAcGgM93r5YfF2ZQWjAnc4k=aN5C3in-bZ-6n+Jrn1vw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: cgroup_helpers.c: Fix strncpy()
 fortify warning
To:     Rong Tao <rtoax@foxmail.com>
Cc:     daniel@iogearbox.net, andrii@kernel.org, ast@kernel.org,
        bpf@vger.kernel.org, david.laight@aculab.com, haoluo@google.com,
        john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        martin.lau@linux.dev, mykolal@fb.com, rongtao@cestc.cn,
        sdf@google.com, shuah@kernel.org, song@kernel.org, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 2, 2022 at 5:59 AM Rong Tao <rtoax@foxmail.com> wrote:
>
> From: Rong Tao <rongtao@cestc.cn>
>
> Move libbpf_strlcpy() to libbpf_common.h, and replace strncpy() with
> libbpf_strlcpy(), fix compile warning.
>
> We can't use libbpf_internal.h directly, because it introduces a lot of
> header dependency issues. So move libbpf_strlcpy() into libbpf_common.h,
> and if you need to use the libbpf_strlcpy() function, you need to include
> the header file libbpf.h

well, no, we should make libbpf_strlcpy as a public API, it's internal
helper. libbpf_common.h is part of libbpf's UAPI.

So don't touch libbpf, please. Name the function as _strlcpy or
something like that, put it into bpf_util.h and use that from
selftests.

>
> How to reproduce this compilation warning:
>
> $ make -C samples/bpf
> cgroup_helpers.c: In function =E2=80=98__enable_controllers=E2=80=99:
> cgroup_helpers.c:80:17: warning: =E2=80=98strncpy=E2=80=99 specified boun=
d 4097 equals destination size [-Wstringop-truncation]
>    80 |                 strncpy(enable, controllers, sizeof(enable));
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Signed-off-by: Rong Tao <rongtao@cestc.cn>
> ---
>  tools/lib/bpf/libbpf_common.h                | 19 +++++++++++++++++++
>  tools/lib/bpf/libbpf_internal.h              | 19 -------------------
>  tools/testing/selftests/bpf/cgroup_helpers.c |  3 ++-
>  tools/testing/selftests/bpf/xsk.c            | 19 -------------------
>  4 files changed, 21 insertions(+), 39 deletions(-)
>

[...]
