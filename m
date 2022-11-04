Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A0A6192FB
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Nov 2022 09:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbiKDIzN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Nov 2022 04:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbiKDIzL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Nov 2022 04:55:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC50825EAF
        for <linux-kselftest@vger.kernel.org>; Fri,  4 Nov 2022 01:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667552055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gr1wY6sSt1hoS3mYpommqdVuyVTPiwyA2H0wzIyKK8M=;
        b=NP9JpIuX+i9pu5EXpTpCIzsoF/1n5l3C8GBlfNjXl3UJiXxn9A0L1TVddeFmQyGhb2Izji
        bXEuZ0CKCHpZoUEYU9taghQLvKGzVH2E+NSt2nzptlOGWhnInnP+fd8c6xIqoZUevE4Svs
        5L3pV4xqJMptU6Pz8WlwY0M5mUjAzvQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-652-n19oHCc3NVeAEIdxEyRQIw-1; Fri, 04 Nov 2022 04:54:13 -0400
X-MC-Unique: n19oHCc3NVeAEIdxEyRQIw-1
Received: by mail-wm1-f69.google.com with SMTP id h204-20020a1c21d5000000b003cf4e055442so2038633wmh.1
        for <linux-kselftest@vger.kernel.org>; Fri, 04 Nov 2022 01:54:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gr1wY6sSt1hoS3mYpommqdVuyVTPiwyA2H0wzIyKK8M=;
        b=Psv62Oso1VbgQzBXKnO48HeC2BAN2zyibkyu/KvBVy9MzSSf5ViXBZTDAQrqT3M1G5
         TwNhfaoQmV9fqoIJGcc9urTWp5oSd41/YHw9lIlovXblDKbHStk2+BaETsvC0JyKbz75
         j1TEhxNpRe9fjdVL1LHAHdM3M96/OJ61yf6i9H9tj0wqRny2ieo3EkRKoZI6HZqzjrq7
         hY+ctUVBf3xfYgsrqih/4eKJgBEcfPn2rHOTd+Gy9v7k6tIExB0UuT+7fsAzND3gcVIF
         iLQnvELqERQyiU/M08Hj0BOyw8QoSM4PxRTkBFlXio54uvDV8wqF1IkgC/iFk7Gku1VR
         uDmw==
X-Gm-Message-State: ACrzQf3PvgH02USjo1hGAB+rHO1R+M3cipZMhC5Ue1J4b3+wNRleGIQG
        diH8TN8lAReK4z0Dl49PksIRGyOQbNuIFDM5B27vXffHMmcTfyRafZGTaVblWCyViraiOqfv8kC
        NBo6jnP5Vm65xfV8JFYZrhCEMsrcC
X-Received: by 2002:a05:6000:118c:b0:236:bc26:7e0d with SMTP id g12-20020a056000118c00b00236bc267e0dmr19218593wrx.662.1667552052686;
        Fri, 04 Nov 2022 01:54:12 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7yXnIGxikq2vzqVFl87h+g1TzaFa9UX/NPHekL+f5fGRz5+gG0TPEkydfQE8mAAeCzMDGaCg==
X-Received: by 2002:a05:6000:118c:b0:236:bc26:7e0d with SMTP id g12-20020a056000118c00b00236bc267e0dmr19218581wrx.662.1667552052425;
        Fri, 04 Nov 2022 01:54:12 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-124-216.dyn.eolo.it. [146.241.124.216])
        by smtp.gmail.com with ESMTPSA id h19-20020a05600c351300b003b4ff30e566sm10543308wmq.3.2022.11.04.01.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 01:54:11 -0700 (PDT)
Message-ID: <da8cb23e4b0909a3bdde8e267b4df7df4c1575f7.camel@redhat.com>
Subject: Re: [PATCH] selftests/net: give more time to udpgro bg processes to
 complete startup
From:   Paolo Abeni <pabeni@redhat.com>
To:     Jakub Kicinski <kuba@kernel.org>,
        Adrien Thierry <athierry@redhat.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Date:   Fri, 04 Nov 2022 09:54:10 +0100
In-Reply-To: <20221103204607.520b36ac@kernel.org>
References: <20221101184809.50013-1-athierry@redhat.com>
         <20221103204607.520b36ac@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 2022-11-03 at 20:46 -0700, Jakub Kicinski wrote:
> On Tue,  1 Nov 2022 14:48:08 -0400 Adrien Thierry wrote:
> > In some conditions, background processes in udpgro don't have enough
> > time to set up the sockets. When foreground processes start, this
> > results in the test failing with "./udpgso_bench_tx: sendmsg: Connection
> > refused". For instance, this happens from time to time on a Qualcomm
> > SA8540P SoC running CentOS Stream 9.
> > 
> > To fix this, increase the time given to background processes to
> > complete the startup before foreground processes start.
> > 
> > Signed-off-by: Adrien Thierry <athierry@redhat.com>
> > ---
> > This is a continuation of the hack that's present in those tests. Other
> > ideas are welcome to fix this in a more permanent way.
> 
> Perhaps we can add an option to the Rx side to daemonize itself after
> setting up the socket, that way the bash script will be locked until 
> Rx is ready?

Then it will be less straigh-forward for the running shell waiting for
all the running processes. 

Another option would be replacing the sleep with a loop waiting for 
the rx UDP socket to appear in the procfs or diag interface, alike what
mptcp self-tests (random example;) are doing:

https://elixir.bootlin.com/linux/v6.1-rc3/source/tools/testing/selftests/net/mptcp/mptcp_join.sh#L424

Cheers,

Paolo

