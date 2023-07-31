Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2535676A531
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Aug 2023 01:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjGaXxD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 19:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjGaXwx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 19:52:53 -0400
Received: from out-64.mta1.migadu.com (out-64.mta1.migadu.com [IPv6:2001:41d0:203:375::40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963C610F5
        for <linux-kselftest@vger.kernel.org>; Mon, 31 Jul 2023 16:52:49 -0700 (PDT)
Message-ID: <8c5398ac-1187-97e3-4124-30a6392e8edb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1690847567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fw0m3TLuuN632tVVayNUXrrdys6H1C1Dg1mWpY0EH8U=;
        b=Ig5jGFu/fCYzCvRg7K0/2pAUowLCiwLCuCl70K8WMNz92Lp/eCjQjUMDNfirzH+3WSuapT
        I5YAeWeskif+kjA1r1NMzygvFEvweShaXsK/YJhSBKCOlsoL9ek+7f4TJ0RWgyZXYQHONK
        1D9Oe12dB12juAgsPYUnAy3gmDYVwmg=
Date:   Mon, 31 Jul 2023 16:52:37 -0700
MIME-Version: 1.0
Subject: Re: [PATCH v4 bpf 1/2] bpf: fix skb_do_redirect return values
Content-Language: en-US
To:     Yan Zhai <yan@cloudflare.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kernel-team@cloudflare.com,
        Jordan Griege <jgriege@cloudflare.com>,
        Markus Elfring <Markus.Elfring@web.de>,
        Jakub Sitnicki <jakub@cloudflare.com>
References: <cover.1690332693.git.yan@cloudflare.com>
 <e5d05e56bf41de82f10d33229b8a8f6b49290e98.1690332693.git.yan@cloudflare.com>
 <266ab56e-ae83-7ddc-618e-3af228df81bd@linux.dev>
 <CAO3-Pbon7tCdChnK9kZ4992C-AFPvE5gTDWre6dQT9npEMxS2Q@mail.gmail.com>
 <2f285967-6cc0-c492-6a79-edc233c1368e@linux.dev>
 <CAO3-PboZ5eQUbL3UO1HsaQ0s5CyS0ch=ksFVP1R6s8zv0+FTAg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAO3-PboZ5eQUbL3UO1HsaQ0s5CyS0ch=ksFVP1R6s8zv0+FTAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/31/23 4:01 PM, Yan Zhai wrote:
> What I commented was an exact same issue at different location: BPF
> reroute may trigger the crash as well, since it also returns
> dev_queue_xmit status in bpf_xmit. Need to fix this, or instead fixing
> LWTUNNEL_XMIT_CONTINUE value and correct the behavior at lwtunnel_xmit
> rather than bpf_xmit.

Ah. I think I got it. You meant the bpf_lwt_xmit_reroute() / BPF_LWT_REROUTE 
case? It would be clearer if some of these names were quoted instead. "reroute" 
could mean many things.

Please put details comment in v5. Thanks.

> 
> Yan
> 
>>
>>> As Dan suggested, packets might not have been freed when this is
>>> returned from drivers. The caller of dev_queue_xmit might need to free
>>> skb when this happens.
>>>
>>> Yan
>>

