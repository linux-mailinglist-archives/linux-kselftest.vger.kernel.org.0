Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B5875102D
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jul 2023 20:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbjGLSCo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Jul 2023 14:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231836AbjGLSCn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Jul 2023 14:02:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC0711B;
        Wed, 12 Jul 2023 11:02:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A8B5618A8;
        Wed, 12 Jul 2023 18:02:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F23DCC433C7;
        Wed, 12 Jul 2023 18:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689184961;
        bh=U2OA5AbewW9cU7RByClE25sKH4R8ibU9NqasHsYKFjg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RwyPZx8jjn/q4m6QFr9vjgdNYSHMv/HGmvdyVS4EWdrY8pNAMltUL/Bd6cclvip6m
         XlfSKduwD/ku5DcbQxzGFwFhcC1loub39lct/8iwzwguArUCLep7w3TriUS0P7vsx7
         vUhgc0cgcFWObt3qyioVatpC73K/fng86l96MKHbqhR5Mq8e8vETYj1wYEfrAcfLkL
         K6bg0jiNanHSizFefp/P1pCUBiL0hXWdYdVU+SFSKMPnuglpj08S3m3eGuxnfzEDzd
         jv+4zmi7b2L7PbXYIcxLXL9YwXVZPkmxoD16n1yI8IoCxrLkcOZIS2P50CCNt/kVKZ
         G36pWSwWtwyrg==
Date:   Wed, 12 Jul 2023 11:02:40 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     David Ahern <dsahern@gmail.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Netdev <netdev@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, Qingfang DENG <qingfang.deng@siflower.com.cn>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>,
        Masahide NAKAMURA <nakam@linux-ipv6.org>,
        Ville Nuorvala <vnuorval@tcs.hut.fi>,
        Arnd Bergmann <arnd@arndb.de>, Pavel Machek <pavel@denx.de>
Subject: Re: [PATCH 6.4 0/6] 6.4.3-rc2 review
Message-ID: <20230712110240.2b232f84@kernel.org>
In-Reply-To: <CA+G9fYvEJgcNhvJk6pvdQOkaS_+x105ZgSM1BVvYy0RRW+1TvA@mail.gmail.com>
References: <20230709203826.141774942@linuxfoundation.org>
        <CA+G9fYtEr-=GbcXNDYo3XOkwR+uYgehVoDjsP0pFLUpZ_AZcyg@mail.gmail.com>
        <20230711201506.25cc464d@kernel.org>
        <ZK5k7YnVA39sSXOv@duo.ucw.cz>
        <CA+G9fYvEJgcNhvJk6pvdQOkaS_+x105ZgSM1BVvYy0RRW+1TvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 12 Jul 2023 18:41:46 +0530 Naresh Kamboju wrote:
> That is the commit id from stable-rc tree.
> 
> I have re-tested the reported issues multiple times and
> it seems that it is intermittently reproducible.
> Following list of links shows kernel crashes while testing
> selftest net pmtu.sh
> 
> 1)
> Unable to handle kernel paging request at virtual address
> https://lkft.validation.linaro.org/scheduler/job/6579624#L4648
> 
> 
> 2)
> include/net/neighbour.h:302 suspicious rcu_dereference_check() usage!
> 
> https://lkft.validation.linaro.org/scheduler/job/6579625#L7500
> https://lkft.validation.linaro.org/scheduler/job/6579626#L7509
> https://lkft.validation.linaro.org/scheduler/job/6579622#L7537
> https://lkft.validation.linaro.org/scheduler/job/6579623#L7469

Nothing jumps out at me.

David, any ideas?
