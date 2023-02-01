Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D0D686908
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Feb 2023 15:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbjBAOzL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Feb 2023 09:55:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232078AbjBAOzJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Feb 2023 09:55:09 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF7926601E
        for <linux-kselftest@vger.kernel.org>; Wed,  1 Feb 2023 06:55:07 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-4c24993965eso248796157b3.12
        for <linux-kselftest@vger.kernel.org>; Wed, 01 Feb 2023 06:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4kUhgzVLbq5TTqoBaW+IZPj4jPZOzB9NcxbeByCDCyg=;
        b=KDdI4VU92boIqg2QbRBokocVoXYQOFdLbGrtPmL3QxFfxyXRbQLv8NrBxGQckL4/IF
         YktxUdYNAodd6AX/6XImbtGXLJhz5/VxvKZgJBIcaBquB71sWBSGGq9gAvln4eLhK0Tr
         DmocZbUeeG1I+iBqsstoHwTZZcJkQrkQbhLeOHwnpoHVKKux42krZMM4ihegUWgWF2Ek
         e9BXtCGlPN45AOQDtM+mdWpaTHZkw3LDcA0M2mD9x+QhcQWWn2GO7tbLvBLBRqZkwquC
         KfNMCYP7t8QlApvkILx3XMNAE2w7DXf59mM4fXKdlBwMB0BQiLSA4wUHKMN6e5qgHxYW
         gzNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4kUhgzVLbq5TTqoBaW+IZPj4jPZOzB9NcxbeByCDCyg=;
        b=bSC9kON1mAwIVW4wHBoIcI3k2aKceSoMeQFGd9ee686b4dZVMx+jGq5u7vP6GZfwfG
         z1T/kKcF6P015wDZ/2m3D3H76K6paaS+17xWUM4yk7FhYXBmekNBde/Z0YsMpO/pvKE2
         3SzPB8m2KdUQLQRCX30jz/M31/TLfP9lTztXgXMr1bohiI7PPf9tI/0HRJh1L5iuCLOa
         yt3rc6gQ+O6o7/+EAJPhCaBvXSJa4T9psVS6peTefC316hWa7CDELlBLVZX7/U0r7TJc
         g5f2BYMnvt4aWykKpK94Z+Y6CBcAlVGo0iadTpjWWcNbOaQIb0XXzsM0vfqod7AhYXNz
         Qd4A==
X-Gm-Message-State: AO0yUKWK1SCCZqupHmgMw79AMD70CknQKLS54dCZ37th0UtGk0y0N5eP
        Vr49bt6sANR4RnUhxdPv4vXdXXMmlKzc2g87gYzDJA==
X-Google-Smtp-Source: AK7set8BkTA6xt1F9+12u+EWNEk+E1PMAcxDO5AX2ydNT9vjP9578y5fPLvRaHtqZ0jsF+m7Z4l7+3556NiyRZdQX3s=
X-Received: by 2002:a81:92c6:0:b0:506:3a02:ccfe with SMTP id
 j189-20020a8192c6000000b005063a02ccfemr261363ywg.385.1675263306804; Wed, 01
 Feb 2023 06:55:06 -0800 (PST)
MIME-Version: 1.0
References: <20230201001612.515730-1-andrei.gherzan@canonical.com> <20230201001612.515730-4-andrei.gherzan@canonical.com>
In-Reply-To: <20230201001612.515730-4-andrei.gherzan@canonical.com>
From:   Willem de Bruijn <willemb@google.com>
Date:   Wed, 1 Feb 2023 09:54:30 -0500
Message-ID: <CA+FuTSeFKkJ0L1jc0ojObmBp3+NPT1r1yS8CjrCJ7=9mK+P22A@mail.gmail.com>
Subject: Re: [PATCH net v4 4/4] selftests: net: udpgso_bench_tx: Cater for
 pending datagrams zerocopy benchmarking
To:     Andrei Gherzan <andrei.gherzan@canonical.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Fred Klassen <fklassen@appneta.com>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jan 31, 2023 at 7:19 PM Andrei Gherzan
<andrei.gherzan@canonical.com> wrote:
>
> The test tool can check that the zerocopy number of completions value is
> valid taking into consideration the number of datagram send calls. This can
> catch the system into a state where the datagrams are still in the system
> (for example in a qdisk, waiting for the network interface to return a
> completion notification, etc).
>
> This change adds a retry logic of computing the number of completions up to
> a configurable (via CLI) timeout (default: 2 seconds).
>
> Fixes: 79ebc3c26010 ("net/udpgso_bench_tx: options to exercise TX CMSG")
> Signed-off-by: Andrei Gherzan <andrei.gherzan@canonical.com>
> Cc: Willem de Bruijn <willemb@google.com>
> Cc: Paolo Abeni <pabeni@redhat.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

> ---
>  tools/testing/selftests/net/udpgso_bench_tx.c | 34 +++++++++++++++----
>  1 file changed, 27 insertions(+), 7 deletions(-)
>
> diff --git a/tools/testing/selftests/net/udpgso_bench_tx.c b/tools/testing/selftests/net/udpgso_bench_tx.c
> index b47b5c32039f..477392715a9a 100644
> --- a/tools/testing/selftests/net/udpgso_bench_tx.c
> +++ b/tools/testing/selftests/net/udpgso_bench_tx.c
> @@ -62,6 +62,7 @@ static int    cfg_payload_len = (1472 * 42);
>  static int     cfg_port        = 8000;
>  static int     cfg_runtime_ms  = -1;
>  static bool    cfg_poll;
> +static int     cfg_poll_loop_timeout_ms = 2000;
>  static bool    cfg_segment;
>  static bool    cfg_sendmmsg;
>  static bool    cfg_tcp;
> @@ -235,16 +236,17 @@ static void flush_errqueue_recv(int fd)
>         }
>  }
>
> -static void flush_errqueue(int fd, const bool do_poll)
> +static void flush_errqueue(int fd, const bool do_poll,
> +                          unsigned long poll_timeout, const bool poll_err)
>  {
>         if (do_poll) {
>                 struct pollfd fds = {0};
>                 int ret;
>
>                 fds.fd = fd;
> -               ret = poll(&fds, 1, 500);
> +               ret = poll(&fds, 1, poll_timeout);
>                 if (ret == 0) {
> -                       if (cfg_verbose)
> +                       if ((cfg_verbose) && (poll_err))

small nit: unnecessary parentheses
