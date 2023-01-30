Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D913B680E09
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jan 2023 13:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236362AbjA3Mvk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Jan 2023 07:51:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236126AbjA3Mvg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Jan 2023 07:51:36 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4F12C67A
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Jan 2023 04:51:29 -0800 (PST)
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B184340259
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Jan 2023 12:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1675083086;
        bh=+3uGoE1lOv0ml5cvNUK29pAUdPjmYWUbapuyqS72mm8=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=gaUtSDAYnmo6tc6z+xq9C/FcMj+MiDKWFOIEd9ZIo1P8cbgQSIwuC2EdO+ewx/k/X
         uXprXS9Apsigr5r0fQkS/dZRBbGVhFkeyH5Yu0PykX+g8aXbmavwORXnHkwVZXVIPh
         +vtPKUZcuc8zrC9NQeN/j4arUDWt37kNuljBCLaVXvx10+rYTaNxUe5eihvISrvNF9
         f0Sk/ZqOSO5fjvoLDOX256lmwxDrpbM31ENeavZfgvLhNA9105qC8sqc238FxiJkiJ
         EP3OMKb8MD4b+vGM2zpw4t0sAYrZURPQI7p5J/f+dLpWFe3at1yX7rKMbtl8B30ldz
         pHOb5xN6HB3BQ==
Received: by mail-wm1-f70.google.com with SMTP id l8-20020a05600c1d0800b003dc25f6bb5dso7540919wms.0
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Jan 2023 04:51:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+3uGoE1lOv0ml5cvNUK29pAUdPjmYWUbapuyqS72mm8=;
        b=2/JmIw1UaTwWAAxan2oit8CX655qa4GUiXvMvJMxDzrOimVKYK6Ko0HnfZfQJlGsRa
         oaxFntyMn9JBQCyKiYbMKVcVS1RyfNnSSCD6dgU9qujUwDNUvC+pj/V6LuDXzLVLsI2I
         h2B6KobJ5NiYVNHEvgALLUglkhuKuV2phaSRDD89YA2lIQAmW2etTiv8qQh71lzlpmWb
         wPx/gK1LD9FyxcM6I6edBbvkCGlLuzw1AQs+3FbutzAdbXUWo6f5qr3pKGK+HLBNkDad
         S9DQDbUUd/Z0H7N0T2SnZg5EDQGrOPncg6ClesEr2BU1gJuPKHbD24RAmFZ10RNj8iJl
         ZWWQ==
X-Gm-Message-State: AFqh2krprjyWJIiskXYpsnjdp+BTBUP7PKChgIs4Klit3ju0z+Xf/v3H
        BmVH90xSQR7LYNNxuVWqwH8/kZ7vOp+h63rUM0iCP7gg7oTKV99Hg7TW9nX8Cw/H+QwwlQJSua3
        4Mu3grZnE/rl0BLDf2fFzfuPxdi6CAZy0qQyC/2xwXnKT1g==
X-Received: by 2002:a05:600c:4256:b0:3da:1d51:ef9e with SMTP id r22-20020a05600c425600b003da1d51ef9emr48495756wmm.17.1675083086423;
        Mon, 30 Jan 2023 04:51:26 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsAaga7uSr6kkAnFQbEMoEkyVHoPqI6rA+OICQ2N8MLyMCI2NM/vIqr7BZmmZwroNWvfiCX6w==
X-Received: by 2002:a05:600c:4256:b0:3da:1d51:ef9e with SMTP id r22-20020a05600c425600b003da1d51ef9emr48495739wmm.17.1675083086235;
        Mon, 30 Jan 2023 04:51:26 -0800 (PST)
Received: from qwirkle ([81.2.157.149])
        by smtp.gmail.com with ESMTPSA id m21-20020a05600c161500b003dc522dd25esm5231264wmn.30.2023.01.30.04.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 04:51:25 -0800 (PST)
Date:   Mon, 30 Jan 2023 12:51:23 +0000
From:   Andrei Gherzan <andrei.gherzan@canonical.com>
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     Willem de Bruijn <willemb@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: net: udpgso_bench_tx: Introduce exponential
 back-off retries
Message-ID: <Y9e9S3ENl0oszAH/@qwirkle>
References: <20230127181625.286546-1-andrei.gherzan@canonical.com>
 <CA+FuTSewU6bjYLsyLzZ1Yne=6YBPDJZ=U1mZc+6cJVdr06BhiQ@mail.gmail.com>
 <a762638b06684cd63d212d1ce9f65236a08b78b1.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a762638b06684cd63d212d1ce9f65236a08b78b1.camel@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 23/01/30 09:26AM, Paolo Abeni wrote:
> On Fri, 2023-01-27 at 17:03 -0500, Willem de Bruijn wrote:
> > On Fri, Jan 27, 2023 at 1:16 PM Andrei Gherzan
> > <andrei.gherzan@canonical.com> wrote:
> > > 
> > > The tx and rx test programs are used in a couple of test scripts including
> > > "udpgro_bench.sh". Taking this as an example, when the rx/tx programs
> > > are invoked subsequently, there is a chance that the rx one is not ready to
> > > accept socket connections. This racing bug could fail the test with at
> > > least one of the following:
> > > 
> > > ./udpgso_bench_tx: connect: Connection refused
> > > ./udpgso_bench_tx: sendmsg: Connection refused
> > > ./udpgso_bench_tx: write: Connection refused
> > > 
> > > This change addresses this by adding routines that retry the socket
> > > operations with an exponential back off algorithm from 100ms to 2s.
> > > 
> > > Fixes: 3a687bef148d ("selftests: udp gso benchmark")
> > > Signed-off-by: Andrei Gherzan <andrei.gherzan@canonical.com>
> > 
> > Synchronizing the two processes is indeed tricky.
> > 
> > Perhaps more robust is opening an initial TCP connection, with
> > SO_RCVTIMEO to bound the waiting time. That covers all tests in one
> > go.
> 
> Another option would be waiting for the listener(tcp)/receiver(udp)
> socket to show up in 'ss' output before firing-up the client - quite
> alike what mptcp self-tests are doing.

I like this idea. I have tested it and it works as expected with the
exeception of:

./udpgso_bench_tx: sendmsg: No buffer space available

Any ideas on how to handle this? I could retry and that works.

-- 
Andrei Gherzan
