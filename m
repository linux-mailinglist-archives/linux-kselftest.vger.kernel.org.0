Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5E2682F74
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Jan 2023 15:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbjAaOk3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 Jan 2023 09:40:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjAaOk1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 Jan 2023 09:40:27 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7B33EC57
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Jan 2023 06:40:26 -0800 (PST)
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 20E7C442ED
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Jan 2023 14:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1675176025;
        bh=XHZduMLns3Y7r5k79prz1oAhShsJx/gipbVLJCHhlGk=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=VB1JA+e1Q99GCdcdhSzo5p9TPOSz0Jj8ArKt93UZMlxo2TQdUdA6shPJts7uczSfS
         7OS1I6DMwpKL6dc/EQGEt1PTyGqh6dFna924TmuDvL+e9i37iOxbM48iakiM26mPiB
         1Fckulf7R9ljbGAyNJ4ZX10l0kicVq6bMB0DQ4+ZWYp4cok6UD8Tz8Q047nlzIHfZK
         9r3V0Qx2svvMBpR5S3J0sru5mq/g6cOswRdYv0c8En6AJaI2lJgtnvstJtigJhNF6/
         XVRxul3lM4/d048rbcSLIFZpPYfDaLdCvLVJPPoXg/ugnnC7OJIecStHEQ6tiFDGt6
         5MHoPwRJlC+LA==
Received: by mail-wm1-f72.google.com with SMTP id o5-20020a05600c4fc500b003db0b3230efso11372179wmq.9
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Jan 2023 06:40:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XHZduMLns3Y7r5k79prz1oAhShsJx/gipbVLJCHhlGk=;
        b=JeSV38rYpVXmxMIYc/1XUZe0lIHUL8QNViQArLnFT9OOrAjsJLNQ5zvcoZGE4wWSsT
         6qsVOL6f5+7gcVGy4Bqiy8tkfLqPS4HFxGj3d3FbuERW2gjJpOn0R2Af5AIWHpPu3dg2
         CO2S1EcQKM1GYVFO1wFfiskzNx8tzccIYNHnEXvRauiLJmYcxW6bb4s5Kmi0+X02Ypf9
         OXUlZWkFVCrFw7gaEV8ZrCRW9EWEFmB6pzU68MGlXBCYAlMZE19fFEAGMk7YwsK1q3a2
         yKN1uJ4qQbAMk14Sm3WVJsg8aqAR8TM7wvXBydZNzNP3q/5oAUShvTCAqyXYqY2t6s2E
         OpPQ==
X-Gm-Message-State: AO0yUKVAiUkYxOE8vkv64jMWVTfBmyGs7wEo78Qcu/GT0TcL5UjEiS0t
        v2g6RN0LyPsEM1MsjbqXuoQRGfcay23tfYYaSXxuTHolcTkPXrhajdh8HiJdyClvhQ9bpfcZoQd
        hVYnCnl2Jt2yGSaqtVk4eo2StPmS1L1HiH91OVuLZGRYk+Q==
X-Received: by 2002:a05:600c:3b8f:b0:3dc:4633:9844 with SMTP id n15-20020a05600c3b8f00b003dc46339844mr15329503wms.17.1675176021641;
        Tue, 31 Jan 2023 06:40:21 -0800 (PST)
X-Google-Smtp-Source: AK7set+EbSgEyXZd4rdDr0ISKIc/bI1f2vwrKcgwG0bUb2kTOVWw33DTexl9UMEDfIuhWw4JxLpblg==
X-Received: by 2002:a05:600c:3b8f:b0:3dc:4633:9844 with SMTP id n15-20020a05600c3b8f00b003dc46339844mr15329456wms.17.1675176021119;
        Tue, 31 Jan 2023 06:40:21 -0800 (PST)
Received: from qwirkle ([2001:67c:1560:8007::aac:c4dd])
        by smtp.gmail.com with ESMTPSA id c3-20020a1c3503000000b003dc1d668866sm19414222wma.10.2023.01.31.06.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 06:40:20 -0800 (PST)
Date:   Tue, 31 Jan 2023 14:40:18 +0000
From:   Andrei Gherzan <andrei.gherzan@canonical.com>
To:     Willem de Bruijn <willemb@google.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] selftests: net: udpgso_bench_rx/tx: Stop when
 wrong CLI args are provided
Message-ID: <Y9koUno9kGkNJkma@qwirkle>
References: <20230131130412.432549-1-andrei.gherzan@canonical.com>
 <20230131130412.432549-2-andrei.gherzan@canonical.com>
 <CA+FuTSf1ffpep=wV=__J96Ju_nPkd96=c+ny4mC+SxrhRp0ofA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+FuTSf1ffpep=wV=__J96Ju_nPkd96=c+ny4mC+SxrhRp0ofA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 23/01/31 08:35AM, Willem de Bruijn wrote:
> On Tue, Jan 31, 2023 at 8:08 AM Andrei Gherzan
> <andrei.gherzan@canonical.com> wrote:
> >
> > Leaving unrecognized arguments buried in the output, can easily hide a
> > CLI/script typo. Avoid this by exiting when wrong arguments are provided to
> > the udpgso_bench test programs.
> >
> > Signed-off-by: Andrei Gherzan <andrei.gherzan@canonical.com>
> 
> I'm on the fence on this. Test binaries are not necessarily robust
> against bad input. If you insist.

I'll keep it in the set (for next v), but I don't mind if it doesn't end
up applied. It was just something I stumbled into.

> When sending patches to net, please always add a Fixes tag.

I'll keep that in mind.

-- 
Andrei Gherzan
