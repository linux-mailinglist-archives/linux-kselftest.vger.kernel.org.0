Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82409780FE9
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Aug 2023 18:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347629AbjHRQJZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Aug 2023 12:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378561AbjHRQJV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Aug 2023 12:09:21 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD86F4492;
        Fri, 18 Aug 2023 09:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
        bh=kUgVNXN7K+7GKfc8lY0hv/dTLzH60H4iTOIfbZHO1cQ=; b=QXE+7twHSkH8pVOSLWchkf/thJ
        sMnpejQX4sHC60XIxUsxwP8vEbrHY5rqpcxwJ+Ax71Phs/ErCpz5+18R+5t7YGuvaXHa9a1xheX5C
        QX5iAoTQYXEomCcCn5RrnIKcQmQDKhZN+7RZC/sb01XoRFB+CUuDaKmEHVbSSDmmjLHM1tRcg3ACp
        Wzqmfr6aStxZdsb/Bd8XM7UPUsLCVGr2Etec7LmOoG68Xrxo8EbYNzV2iUZMz26/wqjEMYzDgZsJP
        BSZciGIr0L7YJ05gNzYvSnVdQmCgsErNDKB9T6WFUSIMegXQI0zJY48WUN/u72Xh8UWx3QczB8C8x
        ngomYJAQ==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1qX21c-000PLU-Hq; Fri, 18 Aug 2023 18:08:36 +0200
Received: from [85.1.206.226] (helo=pc-102.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1qX21b-000Fhq-5b; Fri, 18 Aug 2023 18:08:35 +0200
Subject: Re: [PATCH v6 bpf 0/4] lwt: fix return values of BPF ops
To:     Yan Zhai <yan@cloudflare.com>
Cc:     bpf@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Thomas Graf <tgraf@suug.ch>,
        Jordan Griege <jgriege@cloudflare.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org
References: <cover.1692326837.git.yan@cloudflare.com>
 <10b3dff2-7be4-ab98-e4a5-968ebb93c25f@iogearbox.net>
 <CAO3-PbqUczUxg42ECStsZnAybYKBY-hJePN=V-JbPvq-BS4cGA@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <61e79414-9290-736f-6a50-dfe1585dc2a7@iogearbox.net>
Date:   Fri, 18 Aug 2023 18:08:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAO3-PbqUczUxg42ECStsZnAybYKBY-hJePN=V-JbPvq-BS4cGA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/27004/Fri Aug 18 09:41:49 2023)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/18/23 6:01 PM, Yan Zhai wrote:
> On Fri, Aug 18, 2023 at 9:55 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>>
>> On 8/18/23 4:58 AM, Yan Zhai wrote:
>>> lwt xmit hook does not expect positive return values in function
>>> ip_finish_output2 and ip6_finish_output. However, BPF programs can
>>> directly return positive statuses such like NET_XMIT_DROP, NET_RX_DROP,
>>> and etc to the caller. Such return values would make the kernel continue
>>> processing already freed skbs and eventually panic.
>>>
>>> This set fixes the return values from BPF ops to unexpected continue
>>> processing, checks strictly on the correct continue condition for
>>> future proof. In addition, add missing selftests for BPF redirect
>>> and reroute cases for BPF-CI.
>>>
>>> v5: https://lore.kernel.org/bpf/cover.1692153515.git.yan@cloudflare.com/
>>> v4: https://lore.kernel.org/bpf/ZMD1sFTW8SFiex+x@debian.debian/T/
>>> v3: https://lore.kernel.org/bpf/cover.1690255889.git.yan@cloudflare.com/
>>> v2: https://lore.kernel.org/netdev/ZLdY6JkWRccunvu0@debian.debian/
>>> v1: https://lore.kernel.org/bpf/ZLbYdpWC8zt9EJtq@debian.debian/
>>>
>>> changes since v5:
>>>    * fix BPF-CI failures due to missing config and busybox ping issue
>>
>> Series looks good, thanks! Given we're fairly close to merge window and
>> this has been broken for quite some time, I took this into bpf-next.
>>
> Thanks Daniel! Can you also queue this up for stable (or guide how I can do it)?

Given the Fixes tags, it will be picked up automatically once it lands in
Linus' tree.

Thanks,
Daniel
