Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E4D6491E1
	for <lists+linux-kselftest@lfdr.de>; Sun, 11 Dec 2022 03:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiLKC2c (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 10 Dec 2022 21:28:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiLKC2c (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 10 Dec 2022 21:28:32 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01DD010546;
        Sat, 10 Dec 2022 18:28:31 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id m18so20049459eji.5;
        Sat, 10 Dec 2022 18:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kz8UCTQ9WHAf5JhkPjYAXVzTT4HzgSv8RTOSjH8wUj4=;
        b=K9G0WDjvIfRxiA8xrSmt44yBpBQVe0AdlIRTD1yh8vaEmcgFncS9IkxTNR3Rg1kLve
         o3Walf+HtOmGONYALr1A1TDnL9VcsNLakuRdAqwnUPIMm7rdUxXJBYSe9+LPQ/1OIw/G
         Tw1NWUs/8qnCRX6/wuE9OXTvHpJfLruu7uXaSZwtOBuCebyAbO9E4TgvHLH2RMOSo+qX
         P/Ir6AZZO6T5RAn+uAHuoHkV934xUAX0oBXZr5xyZFuYAiQruvWoQcGX1BXLZl+AllN+
         pfsDXS7nEF1stgJAhKktNlzJgmI/3E9CsMbBRywaMqsiN2qiz29Hy/6OwR+xUVw1KUrX
         qWuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kz8UCTQ9WHAf5JhkPjYAXVzTT4HzgSv8RTOSjH8wUj4=;
        b=tv126fXhMCNPl4ZZCIRbG79S4m+jHw8CZ5TSS62pI3gberKnkA+1CUOHQwmI0PtM9B
         cFgjS28ZNvzZvdWKC8jJjKpjTZh3P2YLuGTzRMKcZ3EBSEIVzfp2ijGmKGiLIgSX8gc/
         CvD/3zUesWfo9+J9U8TL03PAIRQuOCQwbTVc/ySSHwrSm8lRPlOMHYIBurhyCLIqZm2B
         2Y23Owur+nhvnjzukSOArL+8pbluuU8WZmfw4jU5pei4w2FBEO8s2kvKcOmsZ9Jqgdof
         BPr68duhxfphGw44GsNWDdMwnoXWItjvbgmIFHHIScPrDmDkJEomTxHPpHUG/hUfP4qt
         a8ZQ==
X-Gm-Message-State: ANoB5pk8RqNNn9L8PykGcI1a4lBf0TG4cSIYeqcW54epXXOIrIHt0PNq
        bTjy0X4oCv3suMCxeDNqCfVqADbI6N5q9r2Iczc=
X-Google-Smtp-Source: AA0mqf5prpvAqhvSogkAQlNu7wWUWpyU4sAQFN1xjbIalUKERm86mEBlmrSum2+sDjBmVH64S0nFkDoFm4KaRT2hoQA=
X-Received: by 2002:a17:906:4351:b0:78d:513d:f447 with SMTP id
 z17-20020a170906435100b0078d513df447mr70015362ejm.708.1670725709381; Sat, 10
 Dec 2022 18:28:29 -0800 (PST)
MIME-Version: 1.0
References: <20221207172434.435893-1-roberto.sassu@huaweicloud.com> <20221207172434.435893-3-roberto.sassu@huaweicloud.com>
In-Reply-To: <20221207172434.435893-3-roberto.sassu@huaweicloud.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sat, 10 Dec 2022 18:28:18 -0800
Message-ID: <CAADnVQKhWEtqAkMnWR8Twpc6uPo_MWnAf68R-xeM=YVqxkLOyQ@mail.gmail.com>
Subject: Re: [RFC][PATCH v2 2/7] bpf: Mark ALU32 operations in bpf_reg_state structure
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Mykola Lysenko <mykolal@fb.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>, bpf <bpf@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
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

On Wed, Dec 7, 2022 at 9:25 AM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> BPF LSM needs a reliable source of information to determine if the return
> value given by eBPF programs is acceptable or not. At the moment, choosing
> either the 64 bit or the 32 bit one does not seem to be an option
> (selftests fail).
>
> If we choose the 64 bit one, the following happens.
>
>       14:       61 10 00 00 00 00 00 00 r0 = *(u32 *)(r1 + 0)
>       15:       74 00 00 00 15 00 00 00 w0 >>= 21
>       16:       54 00 00 00 01 00 00 00 w0 &= 1
>       17:       04 00 00 00 ff ff ff ff w0 += -1
>
> This is the last part of test_deny_namespace. After #16, the register
> values are:
>
> smin_value = 0x0, smax_value = 0x1,
> s32_min_value = 0x0, s32_max_value = 0x1,
>
> After #17, they become:
>
> smin_value = 0x0, smax_value = 0xffffffff,
> s32_min_value = 0xffffffff, s32_max_value = 0x0
>
> where only the 32 bit values are correct.
>
> If we choose the 32 bit ones, the following happens.
>
> 0000000000000000 <check_access>:
>        0:       79 12 00 00 00 00 00 00 r2 = *(u64 *)(r1 + 0)
>        1:       79 10 08 00 00 00 00 00 r0 = *(u64 *)(r1 + 8)
>        2:       67 00 00 00 3e 00 00 00 r0 <<= 62
>        3:       c7 00 00 00 3f 00 00 00 r0 s>>= 63
>
> This is part of test_libbpf_get_fd_by_id_opts (no_alu32 version). In this
> case, 64 bit register values should be used (for the 32 bit ones, there is
> no precise information from the verifier).
>
> As the examples above suggest that which register values to use depends on
> the specific case, mark ALU32 operations in bpf_reg_state structure, so
> that BPF LSM can choose the proper ones.

I have a hard time understanding what is the problem you're
trying to solve and what is the proposed fix.

The patch is trying to remember the bitness of the last
operation, but what for?
The registers are 64-bit. There are 32-bit operations,
but they always update the upper 32-bits of the register.
reg_bounds_sync() updates 32 and 64 bit bounds regardless
whether the previous operation was on 32 or 64 bit.
It seems you're trying to hack around something that breaks
patch 3 which also looks fishy.
Please explain the problem first with a concrete example.
