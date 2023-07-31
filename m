Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3863F76A3F1
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Aug 2023 00:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbjGaWLv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 18:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbjGaWLr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 18:11:47 -0400
Received: from out-83.mta0.migadu.com (out-83.mta0.migadu.com [IPv6:2001:41d0:1004:224b::53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E211BEC
        for <linux-kselftest@vger.kernel.org>; Mon, 31 Jul 2023 15:11:40 -0700 (PDT)
Message-ID: <2f285967-6cc0-c492-6a79-edc233c1368e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1690841496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xeaSvsYEmBCskRg+zXZEB8g7ybgRHrMcw1QMHD9iWQU=;
        b=gK5DS9Fx2+hSI7gjnc8FtEEQbSogDfp/j111F6w2/hWCyTZBR/aCcytDVq3X3mWU9hoMe6
        42zEZTj2zEIkkhioOiSoP+xmAyngv31miQzdtMhmqSmLk0Ty3coELK32xt11Lhq8R7xdEd
        MZDqtW5LJb1/bvGZ5N+RNI36ctNAY8Q=
Date:   Mon, 31 Jul 2023 15:11:27 -0700
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAO3-Pbon7tCdChnK9kZ4992C-AFPvE5gTDWre6dQT9npEMxS2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/31/23 2:35 PM, Yan Zhai wrote:
> On Fri, Jul 28, 2023 at 5:02 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>> On 7/25/23 6:08 PM, Yan Zhai wrote:
>>> skb_do_redirect returns various of values: error code (negative),
>>> 0 (success), and some positive status code, e.g. NET_XMIT_CN,
>>> NET_RX_DROP. Commit 3a0af8fd61f9 ("bpf: BPF for lightweight tunnel
>>> infrastructure") didn't check the return code correctly, so positive
>>> values are propagated back along call chain:
>>>
>>>     ip_finish_output2
>>>       -> bpf_xmit
>>>         -> run_lwt_bpf
>>>           -> skb_do_redirect
>>
>>   From looking at skb_do_redirect, the skb_do_redirect should have consumed the
>> skb except for the -EAGAIN return value. afaik, -EAGAIN could only happen by
>> using the bpf_redirect_peer helper. lwt does not have the bpf_redirect_peer
>> helper available, so there is no -EAGAIN case in lwt. iow, skb_do_redirect
>> should have always consumed the skb in lwt. or did I miss something?
>>
>> If that is the case, it feels like the fix should be in run_lwt_bpf() and the
>> "if (ret == 0)" test in run_lwt_bpf() is unnecessary?
>>
>>                          ret = skb_do_redirect(skb);
>>                          if (ret == 0)
>>                                  ret = BPF_REDIRECT;
>>
>>
> Just fixing skb redirect return code won't be sufficient. I realized
> there are other return paths that need to be treated, e.g. bpf reroute
> path also directly returns dev_queue_xmit status. I plan to check for
> LWTUNNEL_XMIT_CONTINUE (and change it to a value that does not
> conflict with NET_RX_DROP and NET_XMIT_DROP) in the next revision. On
> the other hand, the return value of NETDEV_TX_BUSY is another hassle.

I suspect we are talking about different things or I am still missing something.

I was thinking skb_do_redirect() should have always consumed the skb and 
bpf_xmit should always return LWTUNNEL_XMIT_DONE also (instead of 
LWTUNNEL_XMIT_CONTINUE described in the this patch commit message). It is what 
sch_handle_egress() is doing also. Could you explain how is it different from 
the skb_do_redirect usage in sch_handle_egress() or you are suggesting the 
current sch_handle_egress() has the issue too also?


> As Dan suggested, packets might not have been freed when this is
> returned from drivers. The caller of dev_queue_xmit might need to free
> skb when this happens.
> 
> Yan

