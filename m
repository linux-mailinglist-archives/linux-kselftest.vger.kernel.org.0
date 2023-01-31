Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26791682E22
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Jan 2023 14:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjAaNkT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 Jan 2023 08:40:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjAaNkS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 Jan 2023 08:40:18 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA31B2D75
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Jan 2023 05:40:17 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-4ff1fa82bbbso203325107b3.10
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Jan 2023 05:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sRjRWg8BiQAEYzHJmfFWEdLhQevP1X8g61dDqXlCDRs=;
        b=qOPmkLs0bRQhDaSbiljSJs1LVLsoqJaRtnm/hX/HRxFRYP0Xbzee0a9304zOqaA95W
         yO+bdzHm5XpkKPWWmafdW1iLpl6CSW7Mb/6LGxsgMQT6wp/b0LrCQMv95BBYJhHDEBsM
         WaZGJZ9g3x6RQpM4vSmGXYMasP4xouYhqE6vZChrpXKv/x32Cs+Ntq9c5aPQqSt5LPel
         lKEB5XGsUWsekEhgYqR2oJiqbZa7Pu0bPIqIkl2Y/J5WgPbczsNDAZ53xThkHMFllVT2
         ymelqxZeyQi8x7nU2R9z0ZSTT1mbXdRB0xYvp255LT2OUZIN9Pzd4OuP1e2MoXn6mNqF
         CMYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sRjRWg8BiQAEYzHJmfFWEdLhQevP1X8g61dDqXlCDRs=;
        b=rr8SazisRIVdKDJtytArwnyX07cV9q1pZ6Xkw4ZtxN5nbU+a1S+T3Ncg7SQtP007FR
         wHgAn1u8HGBLGpYIPPsu6aWqymL7royfdmGZpxynjavAHzUC2abbpXx6ibZHxFphhDCy
         ODOkHeNjnP/zPD7sUfxy0XJxjhgDXaO+9MmPq87mDFt3Nbntl+rMKVpvP11TnjfoN7I6
         3OS8ujdzEFKhX4HNjRbl/6UGYTe2znjRelwrPJ+rHDltTz/4XBtcYPMVU7OMzzcD/Hkj
         xpopIGt1F3tGPSXmVk1JknorHMUeE+48GVRiJlQiJbd8uJHnFw/ogrR9nWPj7d0KpMrC
         GswA==
X-Gm-Message-State: AFqh2kqjGfS9PeAcQayX4HqvMP1p0kUhI+/OdmC3Umw5CuKT8Q2nL9rO
        Wat8yGLQe+iPQPPNHzclbIPdIXKXLXlSV4ows1QXtw==
X-Google-Smtp-Source: AMrXdXs6226+aucJHF/vmsL+nYravuFR4DnXiJdO+R2xk1tGeCiukdkkus6Y//joZTkadUNrLACyc3K7jy7G5YNrhX0=
X-Received: by 2002:a81:4d57:0:b0:4fe:8e35:3c89 with SMTP id
 a84-20020a814d57000000b004fe8e353c89mr4242770ywb.287.1675172416850; Tue, 31
 Jan 2023 05:40:16 -0800 (PST)
MIME-Version: 1.0
References: <20230131130412.432549-1-andrei.gherzan@canonical.com> <20230131130412.432549-4-andrei.gherzan@canonical.com>
In-Reply-To: <20230131130412.432549-4-andrei.gherzan@canonical.com>
From:   Willem de Bruijn <willemb@google.com>
Date:   Tue, 31 Jan 2023 08:39:40 -0500
Message-ID: <CA+FuTSe-C+rOx+zUYzhGCm24hnBXUNpAM5iUqf4shVNEL6niSQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] selftests: net: udpgso_bench_tx: Cater for pending
 datagrams zerocopy benchmarking
To:     Andrei Gherzan <andrei.gherzan@canonical.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
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

On Tue, Jan 31, 2023 at 8:06 AM Andrei Gherzan
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
> Signed-off-by: Andrei Gherzan <andrei.gherzan@canonical.com>
> ---
>  tools/testing/selftests/net/udpgso_bench_tx.c | 38 +++++++++++++++----
>  1 file changed, 30 insertions(+), 8 deletions(-)
>
> diff --git a/tools/testing/selftests/net/udpgso_bench_tx.c b/tools/testing/selftests/net/udpgso_bench_tx.c
> index b47b5c32039f..5a29b5f24023 100644
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
> @@ -254,6 +256,22 @@ static void flush_errqueue(int fd, const bool do_poll)
>         flush_errqueue_recv(fd);
>  }
>
> +static void flush_errqueue_retry(int fd, const bool do_poll, unsigned long num_sends)
> +{
> +       unsigned long tnow, tstop;
> +       bool first_try = true;
> +
> +       tnow = gettimeofday_ms();
> +       tstop = tnow + cfg_poll_loop_timeout_ms;
> +       do {
> +               flush_errqueue(fd, do_poll, tstop - tnow, first_try);
> +               first_try = false;
> +               if (!do_poll)
> +                       usleep(1000);  // a throttling delay if polling is enabled

never reached
