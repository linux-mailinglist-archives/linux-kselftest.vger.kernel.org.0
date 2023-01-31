Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7336838E9
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Jan 2023 22:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjAaVwL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 Jan 2023 16:52:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjAaVwK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 Jan 2023 16:52:10 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E805FCE
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Jan 2023 13:52:09 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id u72so19927276ybi.7
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Jan 2023 13:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0NScRuPwPfMDM/N8/VcVwjy7Yl5fpwiPwStKgPzUd2Y=;
        b=RymBQxHFUzGSvQLOAiliGt6uFff+PemP1Asp8QCGF3ck0bLUiy6oEnuR0LGtfOKXo/
         D5flYIB5roOZWet/lGLXQpkLYCWftlUdDG8oZ61YQtVMJER7ZX4M/39k4qjVaB6/X574
         3wxCXM+HNW9f2ZWWtX6D5/7HSp05eHQFcgPfxbzDbOUJaBYgqKP5szIn4/x4va4VeJq6
         aFTiGAWIDvmMI77c+Ln+lwbH6t90NxDkC0GiwDSFtlPOGIABhbqnJiyyY6aH+2m73gGa
         d6ZBpyKIUR7JwXtzcLPlNnDY/mtd15OP2R2jisQMwBMtoKM6S7Nuc2EUi7EWHbvqtcMU
         hOGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0NScRuPwPfMDM/N8/VcVwjy7Yl5fpwiPwStKgPzUd2Y=;
        b=Mskk+mg2x8efGsJOeyCTVhnRsgPREvaFu/vuYmnzbP0wE7fZjDeCkc4hqttq4J7+vf
         mFPWgc+LvE1dWPNrqPLzkxe3cDBJ098CEjJqLtviAFe40fsV85Ch2exm2RTDI875qnQz
         sgFsS18MD6ChvNhp5XTv15g62BniCBNWt0uaJnAsYVYjRJvCtfm+gT6ke0Umoa2jbElP
         BjA+0W5i2cOiw9GAUQYIekwqxrbkc1zLRxeyOA72eZhMwnkReqFV2zCNlDCYyUEaA5TV
         siawbaeOjDwJ36jq2sjGRwx46SEIsugoDf571Z1Mtf6e9/bEIdQPZ4v3DPeQWkKgKVIw
         6EoA==
X-Gm-Message-State: AO0yUKXXGNaUCP3f3HmvL1p5i+BI8uuOYdmA/NiiWIibzA7extXFzcAH
        /gIHu5je3n320ZYSGcbiZY9JGAQnj6ShOxJ5fFVQE+FeGjcsaray
X-Google-Smtp-Source: AK7set+LU8MgBxQuBJ6vqUXZdCSQnH54pihsSDP563/QhkKZy6bWl1C3qRxjflzMHgc/YQ6B/r18wV9q9ZCklneHV0Q=
X-Received: by 2002:a25:ac56:0:b0:73e:1951:3e92 with SMTP id
 r22-20020a25ac56000000b0073e19513e92mr49743ybd.388.1675201928393; Tue, 31 Jan
 2023 13:52:08 -0800 (PST)
MIME-Version: 1.0
References: <20230131210051.475983-4-andrei.gherzan@canonical.com>
In-Reply-To: <20230131210051.475983-4-andrei.gherzan@canonical.com>
From:   Willem de Bruijn <willemb@google.com>
Date:   Tue, 31 Jan 2023 16:51:33 -0500
Message-ID: <CA+FuTScJCaW+UL0dDDg-7nNdhdZV7Xs5MrfBkGAg-jR4az+DRQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 4/4] selftests: net: udpgso_bench_tx: Cater
 for pending datagrams zerocopy benchmarking
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jan 31, 2023 at 4:01 PM Andrei Gherzan
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
> ---
>  tools/testing/selftests/net/udpgso_bench_tx.c | 34 +++++++++++++++----
>  1 file changed, 27 insertions(+), 7 deletions(-)
>
> diff --git a/tools/testing/selftests/net/udpgso_bench_tx.c b/tools/testing/selftests/net/udpgso_bench_tx.c
> index b47b5c32039f..ef887842522a 100644
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
> +               unsigned long poll_timeout, const bool poll_err)

nit: his indentation looks off though

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
>                                 fprintf(stderr, "poll timeout\n");
>                 } else if (ret < 0) {
>                         error(1, errno, "poll");
> @@ -254,6 +256,20 @@ static void flush_errqueue(int fd, const bool do_poll)
>         flush_errqueue_recv(fd);
>  }
