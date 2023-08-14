Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D994D77BED9
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Aug 2023 19:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjHNRXA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Aug 2023 13:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjHNRW2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Aug 2023 13:22:28 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62AB10C1
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Aug 2023 10:22:26 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d669fcad15cso4086604276.0
        for <linux-kselftest@vger.kernel.org>; Mon, 14 Aug 2023 10:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692033746; x=1692638546;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=K4kC8VdwRVtwS3SYD2fsCeGdVP47xqsJs+F+kjoCJt8=;
        b=QqppkQfZcvfWKp0It6PxdXG5wNPjeRybUln6bQP8usjcp6RMH5wdXv1pvsVdvDExGS
         Dr5dCDXITZC90isqbPTyutvnqunbZPro5WAvYsA9voVOv6TaBx1VSZGE802vliYDCYoX
         fcFBS1cIrABZu/1ip1lg34dU3gW4ZKm1j1hheQ1kQHLLoDtvairF5/EPr2G1by0E7KSu
         1Asyfx2MwfavXPE8ucSm9UOGGv77HBqnkZipeuSRLAiBp/M4mMHZnxpo8d6myONS35Qq
         lPZZ3tyF0Vgik1AkmzSM2spr3KzohzpW4y5CJ5dt8t+xi1JuTeJ5mRYZSq5ATh2thErn
         by+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692033746; x=1692638546;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K4kC8VdwRVtwS3SYD2fsCeGdVP47xqsJs+F+kjoCJt8=;
        b=E0Z51vIYJnXnLJKxnnz2NthtNWEIpqaCAF6t/wLjZKbTGj5oaFzVKQCJuTiX4dzh3H
         0ImdifQwN3vok+qMlcPg2dlpmUeZRoS+H9u+krl/C99aT7WsxK1gXHWLcwOnG3171Nhx
         41yK09c8xiZC7wtSkGGhPmZs6Tocb+ifFz8Ap7PTLUtMJ5IF8aTP5L3Z542+yD4Mzffp
         dbpdzE8//+cOsXrhoTbT03AFuudeTn9IMY3spSmi+OnJovtaPgirty6MBc1zdJE6hV9b
         4FDXLsdesMxdRSTLwwjNyNwMSi+LWh8fSs0ubhZbdT5vCV1ah3MNRHU2NCrxBDUGAaKQ
         HeFg==
X-Gm-Message-State: AOJu0Yzk9z5BPIxdzRVLR7OEmtadfIxtB/ZeSk1YOhcFYPX8ggYXHgEZ
        kpanxqcJqAq8gb4drWEf/e5xpgo=
X-Google-Smtp-Source: AGHT+IHZ6W/zTV2xaZIGU94xFjfsD19UE705tAS9fruZGyiFxbrRi8Qkewej2Rt6Eky1W/eR4dbeEbo=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6902:1084:b0:d09:17f2:d3b0 with SMTP id
 v4-20020a056902108400b00d0917f2d3b0mr150604ybu.9.1692033746236; Mon, 14 Aug
 2023 10:22:26 -0700 (PDT)
Date:   Mon, 14 Aug 2023 10:22:24 -0700
In-Reply-To: <tencent_50B4B2622FE7546A5FF9464310650C008509@qq.com>
Mime-Version: 1.0
References: <20230812055703.7218-1-rtoax@foxmail.com> <tencent_50B4B2622FE7546A5FF9464310650C008509@qq.com>
Message-ID: <ZNpi0MWUlFiaBUH6@google.com>
Subject: Re: [PATCH bpf-next v3] selftests/bpf: trace_helpers.c: optimize
 kallsyms cache
From:   Stanislav Fomichev <sdf@google.com>
To:     Rong Tao <rtoax@foxmail.com>
Cc:     ast@kernel.org, rongtao@cestc.cn,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
        Shuah Khan <shuah@kernel.org>,
        "open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)" 
        <bpf@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 08/12, Rong Tao wrote:
> From: Rong Tao <rongtao@cestc.cn>
> 
> Static ksyms often have problems because the number of symbols exceeds the
> MAX_SYMS limit. Like changing the MAX_SYMS from 300000 to 400000 in
> commit e76a014334a6("selftests/bpf: Bump and validate MAX_SYMS") solves
> the problem somewhat, but it's not the perfect way.
> 
> This commit uses dynamic memory allocation, which completely solves the
> problem caused by the limitation of the number of kallsyms.
> 
> Signed-off-by: Rong Tao <rongtao@cestc.cn>

I believe this is the one that won the pw race:
https://patchwork.kernel.org/project/netdevbpf/patch/tencent_50B4B2622FE7546A5FF9464310650C008509@qq.com/

Acked-by: Stanislav Fomichev <sdf@google.com>

> ---
> v3: Do not use structs and judge ksyms__add_symbol function return value.
> v2: https://lore.kernel.org/lkml/tencent_B655EE5E5D463110D70CD2846AB3262EED09@qq.com/
>     Do the usual len/capacity scheme here to amortize the cost of realloc, and
>     don't free symbols.
> v1: https://lore.kernel.org/lkml/tencent_AB461510B10CD484E0B2F62E3754165F2909@qq.com/
> ---
>  tools/testing/selftests/bpf/trace_helpers.c | 42 ++++++++++++++++-----
>  1 file changed, 32 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
> index f83d9f65c65b..d8391a2122b4 100644
> --- a/tools/testing/selftests/bpf/trace_helpers.c
> +++ b/tools/testing/selftests/bpf/trace_helpers.c
> @@ -18,10 +18,32 @@
>  #define TRACEFS_PIPE	"/sys/kernel/tracing/trace_pipe"
>  #define DEBUGFS_PIPE	"/sys/kernel/debug/tracing/trace_pipe"
>  
> -#define MAX_SYMS 400000
> -static struct ksym syms[MAX_SYMS];
> +static struct ksym *syms;
> +static int sym_cap;
>  static int sym_cnt;
>  
> +static int ksyms__add_symbol(const char *name, unsigned long addr)
> +{
> +	void *tmp;
> +	unsigned int new_cap;

Nit: reverse Christmas tree, not sure we care for the tests though..
