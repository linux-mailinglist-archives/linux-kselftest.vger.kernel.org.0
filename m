Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF1B73FA18
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Jun 2023 12:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjF0KXF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Jun 2023 06:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjF0KWm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Jun 2023 06:22:42 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB983E3;
        Tue, 27 Jun 2023 03:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
        bh=hHK2zVsOPsYddg/sW13UtUauH4zY0IBI+dg4QZPPeok=; b=CpHjAc92fm6gtpOtfhLpNGfe5f
        b3dgrXyTuwCU2D10IChbFpAQLVAsA+0qm9sWDAxTJMjHNWBD01h4vhW3slzFiN7cpi5nSpcyVXXis
        im1Xn8hGgWaRKfTkgq0/Gr2yyJgguKFxYiOtRu7a9lPq+S45NZcAvzghjer+pDy1k7Kn8fnJxetuC
        qwvwdG19mGcjetUzXoVVjvfbliw6tQz8W70DMTelmkE6giAFAvldyeDTunQ7/GYwqjdxAmODaVptW
        R2n/SsGubS/ZJxtyYsdfg2n3yLzGUh1c3owPMeZAtI7FUvS/vPkGsBydkS6aTyW4Ah5+0bwwQZlX6
        b3uVed1Q==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1qE5nT-000O7h-DK; Tue, 27 Jun 2023 12:19:43 +0200
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1qE5nS-00020f-Gv; Tue, 27 Jun 2023 12:19:42 +0200
Subject: Re: [PATCH bpf-next v3 2/7] net: export inet_lookup_reuseport and
 inet6_lookup_reuseport
To:     Lorenz Bauer <lmb@isovalent.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
        haoluo@google.com, hemanthmalla@gmail.com, joe@wand.net.nz,
        john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, martin.lau@linux.dev,
        mykolal@fb.com, netdev@vger.kernel.org, pabeni@redhat.com,
        sdf@google.com, shuah@kernel.org, song@kernel.org,
        willemdebruijn.kernel@gmail.com, yhs@fb.com
References: <20230613-so-reuseport-v3-2-907b4cbb7b99@isovalent.com>
 <20230626173249.57682-1-kuniyu@amazon.com>
 <CAN+4W8hnPzhuKPorSjHeOQHFgAuk=A9oa1hW5jckUPoF=5zEQQ@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <e21aa61a-803b-bb82-d56e-2db0c839477b@iogearbox.net>
Date:   Tue, 27 Jun 2023 12:19:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAN+4W8hnPzhuKPorSjHeOQHFgAuk=A9oa1hW5jckUPoF=5zEQQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26952/Tue Jun 27 09:29:10 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/27/23 10:56 AM, Lorenz Bauer wrote:
> On Mon, Jun 26, 2023 at 6:33 PM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
>>
>> From: Lorenz Bauer <lmb@isovalent.com>
>> Date: Mon, 26 Jun 2023 16:08:59 +0100
>>> Rename the existing reuseport helpers for IPv4 and IPv6 so that they
>>> can be invoked in the follow up commit. Export them so that DCCP which
>>> may be built as a module can access them.
>>
>> We need not export the functions unless there is a real user.
>>
>> I added a deprecation notice for DCCP recently, so I bet DCCP
>> will not get SO_REUSEPORT support.
>> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=b144fcaf46d4
> 
> Misleading commit message, it turns out that ipv6 as a module also
> needs (the v6 functions at least) to be EXPORT_SYMBOL'd. That's
> because of some special shenanigans where inet6_hashtables.c is linked
> into vmlinux even when CONFIG_IPV6=m.
> 
> Also not sure how to work around this: DCCP may be deprecated but
> without the export a module build of it fails.

If it breaks the build, then we need to export it.
