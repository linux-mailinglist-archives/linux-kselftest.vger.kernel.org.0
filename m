Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACDD681628
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jan 2023 17:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237511AbjA3QQA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Jan 2023 11:16:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237353AbjA3QPz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Jan 2023 11:15:55 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE14D1027A
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Jan 2023 08:15:50 -0800 (PST)
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A4358423CE
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Jan 2023 16:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1675095347;
        bh=PhHq+Ycbej3d4KYhLJP72cMynQrcbDuGLZK2reA+9Qc=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=QeCy4qSnL8tq6xYTgCOzfe98y2Cz3ifHtO7Pi6d7sLWg+ovANEy+auCByc3PVXDp7
         ANUwzteqjoAliI5pEbsx2rzRWn/u1rTjrOB4d+BoFJyQ4sOuV+ch1zxJP2LICpFcb4
         EC8yn+XuRkNgKLwXaFbpXm/Ip5aY7E9CqR5O5a76847neRs4uzvAuEU509UOppai5E
         2AAnr6H8cS8ud11wuzQU865H2uPr53PjmHwT4dqcOwzGSJmp66LWJbjI750jDnVnA+
         dW+e66EY4j6yZ0NKg/fQzFYfIQWU5LLzOpwiWMsjrBc5ZRFyFZYW4b3CRFqhP6asDc
         vrPa4hZ2eNsSQ==
Received: by mail-wm1-f70.google.com with SMTP id n7-20020a05600c3b8700b003dc55dcb298so2121151wms.8
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Jan 2023 08:15:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PhHq+Ycbej3d4KYhLJP72cMynQrcbDuGLZK2reA+9Qc=;
        b=KHR8f+MsZN7IG7Evv6UaraIrFV4WPRw8/Fl1aSICxwBjmFIgVla7zJbYvqzX3/S63p
         QZwUi+GdDp+IGMeP/mAGvIb19y/2Fkn4mVNxQ4esJIfoxKRmd4mOJtfqSRSp0qpJCDYy
         /JMcYUExPglfVx4TLrMth7tgD/D2BDLFqCK5aHE9vWkSdOibEZisckNLEDFkwzbUMJhf
         QHum1auT7GWub7K3cAhI+z6hQtLozdoqLTj99dDyhyUdwDoM4Jx9qF9ZHUN5fHVltTHw
         IMGnZza9A7SiesyuOSEr/Ld0PKbVcrg/Jc7XGEvenX0bOpU6JsUWe/3mPYgpKWQhdpVv
         tccQ==
X-Gm-Message-State: AO0yUKXRTflCcf0Mt3p4wtIDWECngjIO8nB9Jsnim+PIWdJncjp+ybW7
        HpjVJARqufopIlsvS+M7LY6cO4qxdrDqnL6o9MygFWnmb6hOsKdxJa6uKN31Q3CXXprF7HFfCZ/
        a7zw4llnSgTgBWcbvQOP8oKCH+yysvbQq2zx77UGdbvKOFw==
X-Received: by 2002:a05:600c:ad4:b0:3dc:47d4:58d2 with SMTP id c20-20020a05600c0ad400b003dc47d458d2mr5113wmr.25.1675095346209;
        Mon, 30 Jan 2023 08:15:46 -0800 (PST)
X-Google-Smtp-Source: AK7set9fyJTl68upM4rfOAOBzxTOsPvwzOjZLDdq0b4y3tuA36UHt2WfvdM1Z7LBWRpq9EvqbsBWRA==
X-Received: by 2002:a05:600c:ad4:b0:3dc:47d4:58d2 with SMTP id c20-20020a05600c0ad400b003dc47d458d2mr5091wmr.25.1675095346028;
        Mon, 30 Jan 2023 08:15:46 -0800 (PST)
Received: from qwirkle ([81.2.157.149])
        by smtp.gmail.com with ESMTPSA id m14-20020a5d6a0e000000b002bfd09f2ca6sm10363418wru.3.2023.01.30.08.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 08:15:45 -0800 (PST)
Date:   Mon, 30 Jan 2023 16:15:43 +0000
From:   Andrei Gherzan <andrei.gherzan@canonical.com>
To:     Willem de Bruijn <willemb@google.com>
Cc:     Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: net: udpgso_bench_tx: Introduce exponential
 back-off retries
Message-ID: <Y9ftL5c4klThCi9Q@qwirkle>
References: <20230127181625.286546-1-andrei.gherzan@canonical.com>
 <CA+FuTSewU6bjYLsyLzZ1Yne=6YBPDJZ=U1mZc+6cJVdr06BhiQ@mail.gmail.com>
 <a762638b06684cd63d212d1ce9f65236a08b78b1.camel@redhat.com>
 <Y9e9S3ENl0oszAH/@qwirkle>
 <CA+FuTSe_NMm6goSmCNfKjUWPGYtVnnBMv6W54a_GOeLJ2FqyOQ@mail.gmail.com>
 <Y9fT+LABhW+/3Nal@qwirkle>
 <CA+FuTScSfLG7gXS_YqJzsC-Teiryj3jeSQs9w0D1PWJs8sv5Rg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+FuTScSfLG7gXS_YqJzsC-Teiryj3jeSQs9w0D1PWJs8sv5Rg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 23/01/30 11:03AM, Willem de Bruijn wrote:
> On Mon, Jan 30, 2023 at 9:28 AM Andrei Gherzan
> <andrei.gherzan@canonical.com> wrote:
> >
> > On 23/01/30 08:35AM, Willem de Bruijn wrote:
> > > On Mon, Jan 30, 2023 at 7:51 AM Andrei Gherzan
> > > <andrei.gherzan@canonical.com> wrote:
> > > >
> > > > On 23/01/30 09:26AM, Paolo Abeni wrote:
> > > > > On Fri, 2023-01-27 at 17:03 -0500, Willem de Bruijn wrote:
> > > > > > On Fri, Jan 27, 2023 at 1:16 PM Andrei Gherzan
> > > > > > <andrei.gherzan@canonical.com> wrote:
> > > > > > >
> > > > > > > The tx and rx test programs are used in a couple of test scripts including
> > > > > > > "udpgro_bench.sh". Taking this as an example, when the rx/tx programs
> > > > > > > are invoked subsequently, there is a chance that the rx one is not ready to
> > > > > > > accept socket connections. This racing bug could fail the test with at
> > > > > > > least one of the following:
> > > > > > >
> > > > > > > ./udpgso_bench_tx: connect: Connection refused
> > > > > > > ./udpgso_bench_tx: sendmsg: Connection refused
> > > > > > > ./udpgso_bench_tx: write: Connection refused
> > > > > > >
> > > > > > > This change addresses this by adding routines that retry the socket
> > > > > > > operations with an exponential back off algorithm from 100ms to 2s.
> > > > > > >
> > > > > > > Fixes: 3a687bef148d ("selftests: udp gso benchmark")
> > > > > > > Signed-off-by: Andrei Gherzan <andrei.gherzan@canonical.com>
> > > > > >
> > > > > > Synchronizing the two processes is indeed tricky.
> > > > > >
> > > > > > Perhaps more robust is opening an initial TCP connection, with
> > > > > > SO_RCVTIMEO to bound the waiting time. That covers all tests in one
> > > > > > go.
> > > > >
> > > > > Another option would be waiting for the listener(tcp)/receiver(udp)
> > > > > socket to show up in 'ss' output before firing-up the client - quite
> > > > > alike what mptcp self-tests are doing.
> > > >
> > > > I like this idea. I have tested it and it works as expected with the
> > > > exeception of:
> > > >
> > > > ./udpgso_bench_tx: sendmsg: No buffer space available
> > > >
> > > > Any ideas on how to handle this? I could retry and that works.
> > >
> > > This happens (also) without the zerocopy flag, right? That
> > >
> > > It might mean reaching the sndbuf limit, which can be adjusted with
> > > SO_SNDBUF (or SO_SNDBUFFORCE if CAP_NET_ADMIN). Though I would not
> > > expect this test to bump up against that limit.
> > >
> > > A few zerocopy specific reasons are captured in
> > > https://www.kernel.org/doc/html/latest/networking/msg_zerocopy.html#transmission.
> >
> > I have dug a bit more into this, and it does look like your hint was in
> > the right direction. The fails I'm seeing are only with the zerocopy
> > flag.
> >
> > From the reasons (doc) above I can only assume optmem limit as I've
> > reproduced it with unlimited locked pages and the fails are transient.
> > That leaves optmem limit. Bumping the value I have by default (20480) to
> > (2048000) made the sendmsg succeed as expected. On the other hand, the
> > tests started to fail with something like:
> >
> > ./udpgso_bench_tx: Unexpected number of Zerocopy completions:    774783
> > expected    773707 received
> 
> More zerocopy completions than number of sends. I have not seen this before.
> 
> The completions are ranges of IDs, one per send call for datagram sockets.
> 
> Even with segmentation offload, the counter increases per call, not per segment.
> 
> Do you experience this without any other changes to udpgso_bench_tx.c.
> Or are there perhaps additional sendmsg calls somewhere (during
> initial sync) that are not accounted to num_sends?

Indeed, that looks off. No, I have run into this without any changes in
the tests (besides the retry routine in the shell script that waits for
rx to come up). Also, as a data point.

As an additional data point, this was only seen on the IPv6 tests. I've
never been able to replicate it on the IPv4 run.

-- 
Andrei Gherzan
