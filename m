Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892085A1CBA
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Aug 2022 00:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244483AbiHYWur (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 25 Aug 2022 18:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244618AbiHYWub (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 25 Aug 2022 18:50:31 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1BEFBF50
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Aug 2022 15:50:24 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id 67so13003587pfv.2
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Aug 2022 15:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=cgiyIbhlK0oTTb9MOi/TmiilB4y7xpSPs1MPQHO3WO0=;
        b=hHesMge/GsZDFgpbHiRU1/UfdcLKj9rRgWjPmiami37jZ/cpClJZ6eI9QHYYYGDkCr
         HmTw03rCd/m3DAOTUGfGhB46uLB4m6KGI7tuAnar6oihXo08kVVgTMWhPEgt3Bcm8bj2
         ZpV+/0uNCoYPnbj9kUhcXx3xWbm0W8xrwqZNF4tejv8+tw9miDtWQGw7eKM9CN24TPjq
         /HyFA4QNbJhzOcIzQgZWlTt9ux6uXvUjRVfwE/5FNCsTkIaVM54A6QO4heiRYgARc2DX
         bzFthjvMGuSWsk0iQETnoHp9yMhrHwGl6RuzO0tXr/jj7bJFzNgyrhmC3zKh8c6OhIr6
         TRpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=cgiyIbhlK0oTTb9MOi/TmiilB4y7xpSPs1MPQHO3WO0=;
        b=NPv7HdGySQyTrwccA2TPC0oBQUJXNd0MMoDa9uIheBJo/pw0YCPymKXLhHxKtVhQ2w
         KRlGvLvLH3FntAJk7e506OFghawwjt1MW72PGiUjAZm2xnNTZc/bk//QFYRLxh4cPtc7
         YFfYaY3HrX3TjXMQ1udXbZPWRKvXeTFaMcAeiW5QA2d8ndlw1SmzxsVD6KW7Et9NevZk
         lms7nIX3Qz95wQMN+FzGjUyZDHqGbWbj8mlTn53YnFcnK6meKJmMQe4HTXgnAPhf7wXJ
         h3XulT6UobZcQtrwed70nNrnX1rzXf4FwV1+29YaGt9VOrIgMenW2JzDFM+3Au2MEWPn
         S7ew==
X-Gm-Message-State: ACgBeo2bqOrCKXcKaIbUMBAkDXgcppqxkSTYyaf5QpHhPSe8Sd4z3/sn
        Xt2AI6GGGQHgrAUa8/niOZHBnfb8s4O6EwY+YmiqTw==
X-Google-Smtp-Source: AA6agR5MbRiN7wmgXR+FaQb78huP8/LjKmNUeHKSsmltko+kS55TjDW9j8bpGNofzu7xPGMkBSxquKsRPCX686J+l5I=
X-Received: by 2002:a65:6953:0:b0:42a:4612:2d7b with SMTP id
 w19-20020a656953000000b0042a46122d7bmr1022618pgq.253.1661467823820; Thu, 25
 Aug 2022 15:50:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220825221751.258958-1-james.hilliard1@gmail.com>
In-Reply-To: <20220825221751.258958-1-james.hilliard1@gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Thu, 25 Aug 2022 15:50:12 -0700
Message-ID: <CAKH8qBu2B+Ac+GoB9FxtD4WGnuE9SFrBnAQY0C-EPZi0dJNwnA@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: Fix bind{4,6} tcp/socket header type conflict
To:     James Hilliard <james.hilliard1@gmail.com>
Cc:     bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 25, 2022 at 3:18 PM James Hilliard
<james.hilliard1@gmail.com> wrote:
>
> There is a potential for us to hit a type conflict when including
> netinet/tcp.h with sys/socket.h, we can replace both of these includes
> with linux/tcp.h to avoid this conflict.
>
> Fixes errors like:
> In file included from /usr/include/netinet/tcp.h:91,
>                  from progs/bind4_prog.c:10:
> /home/buildroot/opt/cross/lib/gcc/bpf/13.0.0/include/stdint.h:34:23: error: conflicting types for 'int8_t'; have 'char'
>    34 | typedef __INT8_TYPE__ int8_t;
>       |                       ^~~~~~
> In file included from /usr/include/x86_64-linux-gnu/sys/types.h:155,
>                  from /usr/include/x86_64-linux-gnu/bits/socket.h:29,
>                  from /usr/include/x86_64-linux-gnu/sys/socket.h:33,
>                  from progs/bind4_prog.c:9:
> /usr/include/x86_64-linux-gnu/bits/stdint-intn.h:24:18: note: previous declaration of 'int8_t' with type 'int8_t' {aka 'signed char'}
>    24 | typedef __int8_t int8_t;
>       |                  ^~~~~~
> /home/buildroot/opt/cross/lib/gcc/bpf/13.0.0/include/stdint.h:43:24: error: conflicting types for 'int64_t'; have 'long int'
>    43 | typedef __INT64_TYPE__ int64_t;
>       |                        ^~~~~~~
> /usr/include/x86_64-linux-gnu/bits/stdint-intn.h:27:19: note: previous declaration of 'int64_t' with type 'int64_t' {aka 'long long int'}
>    27 | typedef __int64_t int64_t;
>       |                   ^~~~~~~
> make: *** [Makefile:537: /home/buildroot/bpf-next/tools/testing/selftests/bpf/bpf_gcc/bind4_prog.o] Error 1
>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

Still compiles in my environment:

Reviewed-by: Stanislav Fomichev <sdf@google.com>

Not sure we want it for the tests, but just in case:

Fixes: a999696c547f ("selftests/bpf: Rewrite test_sock_addr bind bpf into C")




> ---
>  tools/testing/selftests/bpf/progs/bind4_prog.c | 3 +--
>  tools/testing/selftests/bpf/progs/bind6_prog.c | 3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/progs/bind4_prog.c b/tools/testing/selftests/bpf/progs/bind4_prog.c
> index 474c6a62078a..6bd20042fd53 100644
> --- a/tools/testing/selftests/bpf/progs/bind4_prog.c
> +++ b/tools/testing/selftests/bpf/progs/bind4_prog.c
> @@ -6,8 +6,7 @@
>  #include <linux/bpf.h>
>  #include <linux/in.h>
>  #include <linux/in6.h>
> -#include <sys/socket.h>
> -#include <netinet/tcp.h>
> +#include <linux/tcp.h>
>  #include <linux/if.h>
>  #include <errno.h>
>
> diff --git a/tools/testing/selftests/bpf/progs/bind6_prog.c b/tools/testing/selftests/bpf/progs/bind6_prog.c
> index c19cfa869f30..f37617b35a55 100644
> --- a/tools/testing/selftests/bpf/progs/bind6_prog.c
> +++ b/tools/testing/selftests/bpf/progs/bind6_prog.c
> @@ -6,8 +6,7 @@
>  #include <linux/bpf.h>
>  #include <linux/in.h>
>  #include <linux/in6.h>
> -#include <sys/socket.h>
> -#include <netinet/tcp.h>
> +#include <linux/tcp.h>
>  #include <linux/if.h>
>  #include <errno.h>
>
> --
> 2.34.1
>
