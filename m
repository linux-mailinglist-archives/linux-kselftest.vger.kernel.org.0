Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7307468179C
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jan 2023 18:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237569AbjA3Rbd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Jan 2023 12:31:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236098AbjA3Rbc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Jan 2023 12:31:32 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A3BEB50
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Jan 2023 09:31:31 -0800 (PST)
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6E96C414A7
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Jan 2023 17:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1675099889;
        bh=91+DfYQMicDTMAyqOQABo+i06zKxgv3+SZbX3v9tZKQ=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=ovJX29n22vIPMqjYEIGhurNxCCNjIQ82kPpLdQ0sAF9jZtym916a/l/5/5NfN1YVA
         QPH2Zl7g9mXabvCZhrUqcRfMWfVmoExOm4R5Xu3tdnvThv11KnosIINn9q0P9V6Z2w
         IzUl0pmHD4aS/V3wB74r8QZ61rr8onzdeqwr3xJlmMVqCNm3295hx7RqyW25/21Upr
         kQQRvO0tR7/IW/81dKjRVF6rswRo2eZj6vRTbmg2L0KD6+NrWySqFM/uAOnCvclbGi
         mzvTcvDb5IYM0+0Lc67RDb+l3SzJTKjluSeDJLuazrwQsVml5WZFKI7QH6hfwslb+T
         K5mzs9PQTw6WA==
Received: by mail-wm1-f71.google.com with SMTP id iv6-20020a05600c548600b003dc4b8ee42fso3883637wmb.1
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Jan 2023 09:31:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=91+DfYQMicDTMAyqOQABo+i06zKxgv3+SZbX3v9tZKQ=;
        b=dQCvxhKQCFu+P5x+jONcqVJZwf7Ll4+7jH5MV7fyakFP9Ln9sEJgtZtIr2St25WoAg
         HNDp1K1WcDYhQneijA7cl1+vhLff/oH0LNqmmPOay64NCZcfLKryHLws9raYiRzpQ40W
         vaO1LdZszTs1X4+4y0k8D3tiKgewqgd/AvKiYhGAk+7RDpKaIz9eflWN6hT49GF47pVw
         eLENSVckQNItSWY18L+M8rLygdq7EHfJ4TV2x/yK61tgD7CdUvJdOGf6/dLYrCXE8esb
         z+sXgvEKlMZczhP3eIMCqhTLoHWsQW/FizH2q9GDhSCYBNH2seJ3V2h/wFqstyRWy2FK
         3C8w==
X-Gm-Message-State: AFqh2kpTY543i+7MA/KQMCHk0LUwNPA4FLLGnp97sTo/aWAm7sCGqHFe
        /Uw0wAPeqzmNVwFFr89y6y/un4pJzZqKOc9wPDKqhRbwpCQI0nRbOcgPN0hkgaGgNHs5zaWXWgy
        OcqhXT28L6eEN30u3WdsMZeRj2BOqlB/k8azG0MVGg40htg==
X-Received: by 2002:a05:6000:1c08:b0:2bd:f5bd:5482 with SMTP id ba8-20020a0560001c0800b002bdf5bd5482mr52761591wrb.28.1675099889037;
        Mon, 30 Jan 2023 09:31:29 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtUAs2VP7pSZTa1pCs13hcGycrXuxvSeBNypISFdYaUGfztB8PQpg01nlheHhEC2kNpsQV0VQ==
X-Received: by 2002:a05:6000:1c08:b0:2bd:f5bd:5482 with SMTP id ba8-20020a0560001c0800b002bdf5bd5482mr52761577wrb.28.1675099888859;
        Mon, 30 Jan 2023 09:31:28 -0800 (PST)
Received: from qwirkle ([81.2.157.149])
        by smtp.gmail.com with ESMTPSA id z14-20020a5d4d0e000000b002bde537721dsm12380088wrt.20.2023.01.30.09.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 09:31:28 -0800 (PST)
Date:   Mon, 30 Jan 2023 17:31:26 +0000
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
Message-ID: <Y9f+7tMWMtPACLz9@qwirkle>
References: <20230127181625.286546-1-andrei.gherzan@canonical.com>
 <CA+FuTSewU6bjYLsyLzZ1Yne=6YBPDJZ=U1mZc+6cJVdr06BhiQ@mail.gmail.com>
 <a762638b06684cd63d212d1ce9f65236a08b78b1.camel@redhat.com>
 <Y9e9S3ENl0oszAH/@qwirkle>
 <CA+FuTSe_NMm6goSmCNfKjUWPGYtVnnBMv6W54a_GOeLJ2FqyOQ@mail.gmail.com>
 <Y9fT+LABhW+/3Nal@qwirkle>
 <CA+FuTScSfLG7gXS_YqJzsC-Teiryj3jeSQs9w0D1PWJs8sv5Rg@mail.gmail.com>
 <Y9ftL5c4klThCi9Q@qwirkle>
 <Y9fu7TR5VC33j+EP@qwirkle>
 <CA+FuTSf1tJ7kw+GCXf0YBRv0HaR8v7=iy6b36hrsmx8hEr5knQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+FuTSf1tJ7kw+GCXf0YBRv0HaR8v7=iy6b36hrsmx8hEr5knQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 23/01/30 11:29AM, Willem de Bruijn wrote:
> On Mon, Jan 30, 2023 at 11:23 AM Andrei Gherzan
> <andrei.gherzan@canonical.com> wrote:
> >
> > On 23/01/30 04:15PM, Andrei Gherzan wrote:
> > > On 23/01/30 11:03AM, Willem de Bruijn wrote:
> > > > On Mon, Jan 30, 2023 at 9:28 AM Andrei Gherzan
> > > > <andrei.gherzan@canonical.com> wrote:
> > > > >
> > > > > On 23/01/30 08:35AM, Willem de Bruijn wrote:
> > > > > > On Mon, Jan 30, 2023 at 7:51 AM Andrei Gherzan
> > > > > > <andrei.gherzan@canonical.com> wrote:
> > > > > > >
> > > > > > > On 23/01/30 09:26AM, Paolo Abeni wrote:
> > > > > > > > On Fri, 2023-01-27 at 17:03 -0500, Willem de Bruijn wrote:
> > > > > > > > > On Fri, Jan 27, 2023 at 1:16 PM Andrei Gherzan
> > > > > > > > > <andrei.gherzan@canonical.com> wrote:
> > > > > > > > > >
> > > > > > > > > > The tx and rx test programs are used in a couple of test scripts including
> > > > > > > > > > "udpgro_bench.sh". Taking this as an example, when the rx/tx programs
> > > > > > > > > > are invoked subsequently, there is a chance that the rx one is not ready to
> > > > > > > > > > accept socket connections. This racing bug could fail the test with at
> > > > > > > > > > least one of the following:
> > > > > > > > > >
> > > > > > > > > > ./udpgso_bench_tx: connect: Connection refused
> > > > > > > > > > ./udpgso_bench_tx: sendmsg: Connection refused
> > > > > > > > > > ./udpgso_bench_tx: write: Connection refused
> > > > > > > > > >
> > > > > > > > > > This change addresses this by adding routines that retry the socket
> > > > > > > > > > operations with an exponential back off algorithm from 100ms to 2s.
> > > > > > > > > >
> > > > > > > > > > Fixes: 3a687bef148d ("selftests: udp gso benchmark")
> > > > > > > > > > Signed-off-by: Andrei Gherzan <andrei.gherzan@canonical.com>
> > > > > > > > >
> > > > > > > > > Synchronizing the two processes is indeed tricky.
> > > > > > > > >
> > > > > > > > > Perhaps more robust is opening an initial TCP connection, with
> > > > > > > > > SO_RCVTIMEO to bound the waiting time. That covers all tests in one
> > > > > > > > > go.
> > > > > > > >
> > > > > > > > Another option would be waiting for the listener(tcp)/receiver(udp)
> > > > > > > > socket to show up in 'ss' output before firing-up the client - quite
> > > > > > > > alike what mptcp self-tests are doing.
> > > > > > >
> > > > > > > I like this idea. I have tested it and it works as expected with the
> > > > > > > exeception of:
> > > > > > >
> > > > > > > ./udpgso_bench_tx: sendmsg: No buffer space available
> > > > > > >
> > > > > > > Any ideas on how to handle this? I could retry and that works.
> > > > > >
> > > > > > This happens (also) without the zerocopy flag, right? That
> > > > > >
> > > > > > It might mean reaching the sndbuf limit, which can be adjusted with
> > > > > > SO_SNDBUF (or SO_SNDBUFFORCE if CAP_NET_ADMIN). Though I would not
> > > > > > expect this test to bump up against that limit.
> > > > > >
> > > > > > A few zerocopy specific reasons are captured in
> > > > > > https://www.kernel.org/doc/html/latest/networking/msg_zerocopy.html#transmission.
> > > > >
> > > > > I have dug a bit more into this, and it does look like your hint was in
> > > > > the right direction. The fails I'm seeing are only with the zerocopy
> > > > > flag.
> > > > >
> > > > > From the reasons (doc) above I can only assume optmem limit as I've
> > > > > reproduced it with unlimited locked pages and the fails are transient.
> > > > > That leaves optmem limit. Bumping the value I have by default (20480) to
> > > > > (2048000) made the sendmsg succeed as expected. On the other hand, the
> > > > > tests started to fail with something like:
> > > > >
> > > > > ./udpgso_bench_tx: Unexpected number of Zerocopy completions:    774783
> > > > > expected    773707 received
> > > >
> > > > More zerocopy completions than number of sends. I have not seen this before.
> > > >
> > > > The completions are ranges of IDs, one per send call for datagram sockets.
> > > >
> > > > Even with segmentation offload, the counter increases per call, not per segment.
> > > >
> > > > Do you experience this without any other changes to udpgso_bench_tx.c.
> > > > Or are there perhaps additional sendmsg calls somewhere (during
> > > > initial sync) that are not accounted to num_sends?
> > >
> > > Indeed, that looks off. No, I have run into this without any changes in
> > > the tests (besides the retry routine in the shell script that waits for
> > > rx to come up). Also, as a data point.
> >
> > Actually wait. I don't think that is the case here. "expected" is the
> > number of sends. In this case we sent 1076 more messages than
> > completions. Am I missing something obvious?
> 
> Oh indeed.
> 
> Receiving fewer completions than transmission is more likely.

Exactly, yes.

> This should be the result of datagrams still being somewhere in the
> system. In a qdisc, or waiting for the network interface to return a
> completion notification, say.
> 
> Does this remain if adding a longer wait before the final flush_errqueue?

Yes and no. But not realiably unless I go overboard.

> Or, really, the right fix is to keep polling there until the two are
> equal, up to some timeout. Currently flush_errqueue calls poll only
> once.

That makes sense. I have implemented a retry and this ran for a good
while now.

-               flush_errqueue(fd, true);
+               while (true) {
+                       flush_errqueue(fd, true);
+                       if ((stat_zcopies == num_sends) || (delay >= MAX_DELAY))
+                               break;
+                       usleep(delay);
+                       delay *= 2;
+               }

What do you think?

-- 
Andrei Gherzan
