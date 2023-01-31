Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 936C868391F
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Jan 2023 23:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjAaWQq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 Jan 2023 17:16:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbjAaWQo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 Jan 2023 17:16:44 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1E546157
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Jan 2023 14:16:42 -0800 (PST)
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id DA59D442FD
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Jan 2023 22:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1675203399;
        bh=3LEsGOPfaWLvr4rWba86yn4WIRMiISgxju1CpktcCjc=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=KVXMjjv6Tn6BrWBhdN/0riJ+crbzZZ6I71EWEtw9+4xywkQjMbZGsKdT5IvJ3Htll
         N5UR9IrSq73zOs7LDIqIdrLKGhAajPN4bTU86LlVysHAsDkaEJjv1/Ikd+X+8GI1DC
         zAD0NpBZhuApVSH/kQCem4imAwnE3rYT3siM1bTVN3PLMe9NMuh3RJxGh7fbP1xIqL
         0WXLVqupAGP8wQWUzUFkoyxxddSZb7YbiCV8V/gbhE1cF/CFYJh1q7ZiUY4Fc14Cwo
         CP1OkE30pE7rF30hEcaerxrrRk02H+e0bfWwykSjZ0Gm0waDtwCTXoY8lhupkkXNWk
         t01xL9raESwvA==
Received: by mail-wm1-f71.google.com with SMTP id k17-20020a05600c1c9100b003dd41ad974bso34277wms.3
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Jan 2023 14:16:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3LEsGOPfaWLvr4rWba86yn4WIRMiISgxju1CpktcCjc=;
        b=a/NeTan58fe+U1PyZJ9P6qtcdZ3WIg7b/d6mYy7zG5RfYFqc53jJzvc7pbMPhqkb06
         qIoqhyAyb3HAFugkX9OHoDHMAEafmBMesjffxZtxNQvWFVmFV4yRVbRWv/Pon3ZNu42G
         r+yfXMRwRTBUM/Z1zw6qYSJgVk0GPcRaWqJbH0xSS/LHU8rYuriGbmkK27MFaukL40cs
         m6F8T94IIYPTD7E01ow1nKSfCp5u0z43GlDt+PiHF7QY+cb+Lz5AG5spVvMQJ2vHPA0n
         Zmg0m8eQc+VhUSMbmV6qBFvotbV9Z3qSpWgQXREtlF81P3CSsyzuXITFfM09kRQb4q+c
         0j7w==
X-Gm-Message-State: AO0yUKU6pt+JMr5t5dACc0UipQA5Wv7S1pSMe9eDuQk/Aa15qJ4HcRML
        cxaq7Feax5iLojV4dXrxuvFJpNgKViEInwqIlqyyAofvK81OCh2SkMnQjxA2tyVZZSJi32df4Zv
        nNxIHNv5FH1V6bqDlrhNb0/8m15J4k4GBOU/5l1u5udYmyw==
X-Received: by 2002:a05:6000:78e:b0:2bf:bd69:234a with SMTP id bu14-20020a056000078e00b002bfbd69234amr557226wrb.1.1675203398876;
        Tue, 31 Jan 2023 14:16:38 -0800 (PST)
X-Google-Smtp-Source: AK7set/lLbaZ/D3uEBeeWj1ztr3m9PU6oxrO8Aw1mQVoXGJAEXY6mmm1ITFn3HWksaCmXOb8EwiiaA==
X-Received: by 2002:a05:6000:78e:b0:2bf:bd69:234a with SMTP id bu14-20020a056000078e00b002bfbd69234amr557209wrb.1.1675203398639;
        Tue, 31 Jan 2023 14:16:38 -0800 (PST)
Received: from qwirkle ([81.2.157.149])
        by smtp.gmail.com with ESMTPSA id y8-20020adfdf08000000b002bfb31bda06sm16905072wrl.76.2023.01.31.14.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 14:16:38 -0800 (PST)
Date:   Tue, 31 Jan 2023 22:16:36 +0000
From:   Andrei Gherzan <andrei.gherzan@canonical.com>
To:     Willem de Bruijn <willemb@google.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Fred Klassen <fklassen@appneta.com>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 4/4] selftests: net: udpgso_bench_tx: Cater
 for pending datagrams zerocopy benchmarking
Message-ID: <Y9mTRER69Z7BGqB5@qwirkle>
References: <20230131210051.475983-4-andrei.gherzan@canonical.com>
 <CA+FuTScJCaW+UL0dDDg-7nNdhdZV7Xs5MrfBkGAg-jR4az+DRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+FuTScJCaW+UL0dDDg-7nNdhdZV7Xs5MrfBkGAg-jR4az+DRQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 23/01/31 04:51PM, Willem de Bruijn wrote:
> On Tue, Jan 31, 2023 at 4:01 PM Andrei Gherzan
> <andrei.gherzan@canonical.com> wrote:
> >
> > The test tool can check that the zerocopy number of completions value is
> > valid taking into consideration the number of datagram send calls. This can
> > catch the system into a state where the datagrams are still in the system
> > (for example in a qdisk, waiting for the network interface to return a
> > completion notification, etc).
> >
> > This change adds a retry logic of computing the number of completions up to
> > a configurable (via CLI) timeout (default: 2 seconds).
> >
> > Fixes: 79ebc3c26010 ("net/udpgso_bench_tx: options to exercise TX CMSG")
> > Signed-off-by: Andrei Gherzan <andrei.gherzan@canonical.com>
> > Cc: Willem de Bruijn <willemb@google.com>
> > Cc: Paolo Abeni <pabeni@redhat.com>
> > ---
> >  tools/testing/selftests/net/udpgso_bench_tx.c | 34 +++++++++++++++----
> >  1 file changed, 27 insertions(+), 7 deletions(-)
> >
> > diff --git a/tools/testing/selftests/net/udpgso_bench_tx.c b/tools/testing/selftests/net/udpgso_bench_tx.c
> > index b47b5c32039f..ef887842522a 100644
> > --- a/tools/testing/selftests/net/udpgso_bench_tx.c
> > +++ b/tools/testing/selftests/net/udpgso_bench_tx.c
> > @@ -62,6 +62,7 @@ static int    cfg_payload_len = (1472 * 42);
> >  static int     cfg_port        = 8000;
> >  static int     cfg_runtime_ms  = -1;
> >  static bool    cfg_poll;
> > +static int     cfg_poll_loop_timeout_ms = 2000;
> >  static bool    cfg_segment;
> >  static bool    cfg_sendmmsg;
> >  static bool    cfg_tcp;
> > @@ -235,16 +236,17 @@ static void flush_errqueue_recv(int fd)
> >         }
> >  }
> >
> > -static void flush_errqueue(int fd, const bool do_poll)
> > +static void flush_errqueue(int fd, const bool do_poll,
> > +               unsigned long poll_timeout, const bool poll_err)
> 
> nit: his indentation looks off though

This one I've missed but I couldn't find any guidelines on it. Could you
clarify to me what this should be or point me to soem docs? Happy to fix
otherwise. I'm currently using vim smartindent but it is definitely not
in line with what is here already.

> 
> >  {
> >         if (do_poll) {
> >                 struct pollfd fds = {0};
> >                 int ret;
> >
> >                 fds.fd = fd;
> > -               ret = poll(&fds, 1, 500);
> > +               ret = poll(&fds, 1, poll_timeout);
> >                 if (ret == 0) {
> > -                       if (cfg_verbose)
> > +                       if ((cfg_verbose) && (poll_err))
> >                                 fprintf(stderr, "poll timeout\n");
> >                 } else if (ret < 0) {
> >                         error(1, errno, "poll");
> > @@ -254,6 +256,20 @@ static void flush_errqueue(int fd, const bool do_poll)
> >         flush_errqueue_recv(fd);
> >  }

-- 
Andrei Gherzan
