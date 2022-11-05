Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2A1361DBF5
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Nov 2022 17:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiKEQUi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 5 Nov 2022 12:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiKEQUh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 5 Nov 2022 12:20:37 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60AC61A3AC;
        Sat,  5 Nov 2022 09:20:36 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id v17so11650529edc.8;
        Sat, 05 Nov 2022 09:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=srQ3lTh3ov/uW1CynRa0KjN77ReKbgwHiOujQ3nMVGI=;
        b=P0kLwQwYClIZzoWMQF0niGOEZY4ILluvbFpoIzNEfGSiaBf5YEbKrtilG8yOZt23rS
         A9Vn4TNmkIG8F/Z4HcJKJDpzol0995YgFK9jc/y9B+yZZWZv3sE6Q+tDvgndaqqA8tUa
         GBpk7naq0m1IqFdv0pbGxcfdRsz4I9XaPo0zt2YVWaQFjQ16FTBxaHdpFw/y0izCcaEf
         oSaYqWxONukSWy28TM0SRTQyooBPLQeQKL1DxvUuvEI00eHM33jFhETT2xm6tzTXGmwY
         O1RaLVhp/FW7yx2zx0x9KAWRtwguiW83/3ZEaOUVaVPx4HoKCop39fY8BUTvITaxccsp
         st1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=srQ3lTh3ov/uW1CynRa0KjN77ReKbgwHiOujQ3nMVGI=;
        b=E9vVk8RXVOmGELl63j9QVDIKz0oEMf4Akj95O+VoAwrfat0qSa8hDdwlC/XWa1H8mv
         ool3eplXKN8lDD9bxIFLdDL6Y3Ux3JWUWfPS5aN1Rk75EUV53t6juzXaPlqXki0Klqfy
         shRJ/7eBbpr6Cq5DtnaKTcxiFfyt36CV1Rbvk0Cn8fPv+ND3yGEb6uBOHNLDUm3r9lHD
         B5igVF6hha87e5NrCSz+GaQ7XKaU8MD8bsXlMCPOJNCLgmtOL/ds+okcXJHKzLBJNrCK
         98b9GqDD/QPU8VP8MMptWeAeO0R6GMInLZuIwUwMQo1p7YfYTKOC9JqYMNPjQQ1l+ukJ
         gbfQ==
X-Gm-Message-State: ACrzQf0xAgfL6Z5DPXjoPh7rE7frbNZRe/Th3F0DR+9/G79f3xB12RIT
        +/4/XJO2cxw8G2RXa0H6+lmLd95Eow2VqPXe4iLXy2pJ
X-Google-Smtp-Source: AMsMyM7zSz2xzkf30t95QCMUe/+35Au5IQDfWUWwp1tGv7KynUmdAkPytr6E2YTxR4NYApaYSEmfEf0uMjZO7JpmzeE=
X-Received: by 2002:a05:6402:5406:b0:452:1560:f9d4 with SMTP id
 ev6-20020a056402540600b004521560f9d4mr41547613edb.333.1667665234700; Sat, 05
 Nov 2022 09:20:34 -0700 (PDT)
MIME-Version: 1.0
References: <20221105025146.238209-1-horenchuang@bytedance.com>
In-Reply-To: <20221105025146.238209-1-horenchuang@bytedance.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sat, 5 Nov 2022 09:20:23 -0700
Message-ID: <CAADnVQK5t0YWGgdWmjiWX6vA0SjANrnf5x=yzu7PtDKpoK6cJQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 0/4] Add BPF htab map's used size for monitoring
To:     "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Cc:     Alexei Starovoitov <ast@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, Jiri Olsa <olsajiri@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Joanne Koong <joannelkoong@gmail.com>,
        Kui-Feng Lee <kuifeng@fb.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Maxim Mikityanskiy <maximmi@nvidia.com>,
        Hao Xiang <hao.xiang@bytedance.com>,
        Punit Agrawal <punit.agrawal@bytedance.com>,
        Yifei Ma <yifeima@bytedance.com>,
        Xiaoning Ding <xiaoning.ding@bytedance.com>,
        bpf <bpf@vger.kernel.org>, Ho-Ren Chuang <horenc@vt.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>
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

On Fri, Nov 4, 2022 at 7:52 PM Ho-Ren (Jack) Chuang
<horenchuang@bytedance.com> wrote:
>
> Hello everyone,
>
> We have prepared patches to address an issue from a previous discussion.
> The previous discussion email thread is here: https://lore.kernel.org/all/CAADnVQLBt0snxv4bKwg1WKQ9wDFbaDCtZ03v1-LjOTYtsKPckQ@mail.gmail.com/

Rephrasing what was said earlier.
We're not keeping the count of elements in a preallocated hash map
and we are not going to add one.
The bpf prog needs to do the accounting on its own if it needs
this kind of statistics.
Keeping the count for non-prealloc is already significant performance
overhead. We don't trade performance for stats.
