Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A248373A94C
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Jun 2023 22:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjFVUGS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Jun 2023 16:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjFVUGR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Jun 2023 16:06:17 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17BB019B;
        Thu, 22 Jun 2023 13:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
        bh=1iD8w/UaK9dH9GDXVeWytepJSEZs7Q5LQ6mZtRTdGts=; b=YjVq4FYEcrC1Dgn9RLYRS1nxdI
        bi6yhwreXs5jK6TuluDPgdN//C1PkW7hqJJnd4O+hF7XlExibr+YONoYIt6c63CAnHoEFL0F/cabX
        dxcBMAjul/Nl8+QiNu/bUlEewdI4DtoNRmxvNoKyd619Nr2Rfk8l3kpogJBjGaJp5b+5+AAb2Gs9q
        E5JiCNtOZ2HJb4NHsDDNq09BtITs9crF11Lt+k9HCVXeDgaRjosprTiX3Va09t7iFoBTHh9HJjbZT
        4qnOvMrXVM9DRaIt6DDJH5lHjBnW/J9xcKg48TVwop0RHgzfGtFsePSrK4yZY1Ipn/6chu9tn3yuh
        TIx0FzWw==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1qCQZG-0000cq-RN; Thu, 22 Jun 2023 22:06:10 +0200
Received: from [178.197.249.45] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1qCQZE-000EiN-KH; Thu, 22 Jun 2023 22:06:10 +0200
Subject: Re: [PATCH bpf-next v3 1/2] net: bpf: Always call BPF cgroup filters
 for egress.
To:     Yonghong Song <yhs@meta.com>, Kui-Feng Lee <sinquersw@gmail.com>,
        Kui-Feng Lee <thinker.li@gmail.com>, bpf@vger.kernel.org,
        ast@kernel.org, martin.lau@linux.dev, song@kernel.org,
        kernel-team@meta.com, andrii@kernel.org, yhs@fb.com,
        kpsingh@kernel.org, shuah@kernel.org, john.fastabend@gmail.com,
        sdf@google.com, mykolal@fb.com, linux-kselftest@vger.kernel.org,
        jolsa@kernel.org, haoluo@google.com
Cc:     Kui-Feng Lee <kuifeng@meta.com>
References: <20230620171409.166001-1-kuifeng@meta.com>
 <20230620171409.166001-2-kuifeng@meta.com>
 <4d46ba3a-61e9-2482-a359-7a8805f1dbc8@meta.com>
 <2693aaa4-eb33-553c-291c-3eb555452ea6@gmail.com>
 <94226479-8d79-cc83-9ecf-6db0b376a7fd@meta.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <461e9be3-d533-d727-8ef9-0e20972ae0b4@iogearbox.net>
Date:   Thu, 22 Jun 2023 22:06:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <94226479-8d79-cc83-9ecf-6db0b376a7fd@meta.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26947/Thu Jun 22 09:29:54 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/22/23 8:28 PM, Yonghong Song wrote:
> On 6/22/23 10:15 AM, Kui-Feng Lee wrote:
>> On 6/21/23 20:37, Yonghong Song wrote:
>>> On 6/20/23 10:14 AM, Kui-Feng Lee wrote:
>>>> Always call BPF filters if CGROUP BPF is enabled for EGRESS without
>>>> checking skb->sk against sk.
>>>>
>>>> The filters were called only if skb is owned by the sock that the
>>>> skb is sent out through.  In another words, skb->sk should point to
>>>> the sock that it is sending through its egress.  However, the filters would
>>>> miss SYNACK skbs that they are owned by a request_sock but sent through
>>>> the listening sock, that is the socket listening incoming connections.
>>>> This is an unnecessary restrict.
>>>
>>> The original patch which introduced 'sk == skb->sk' is
>>>    3007098494be  cgroup: add support for eBPF programs
>>> There are no mentioning in commit message why 'sk == skb->sk'
>>> is needed. So it is possible that this is just restricted
>>> for use cases at that moment. Now there are use cases
>>> where 'sk != skb->sk' so removing this check can enable
>>> the new use case. Maybe you can add this into your commit
>>> message so people can understand the history of 'sk == skb->sk'.
>>
>> After checking the code and the Alexei's comment[1] again, this check
>> may be different from what I thought. In another post[2],
>> Daniel Borkmann mentioned
>>
>>      Wouldn't that mean however, when you go through stacked devices that
>>      you'd run the same eBPF cgroup program for skb->sk multiple times?
>>
>> I read this paragraph several times.
>> This check ensures the filters are only called for the device on
>> the top of a stack.  So, I probably should change the check to
>>
>>      sk == skb_to_full_sk(skb)
> 
> I think this should work. It exactly covers your use case:
>    they are owned by a request_sock but sent through
>    the listening sock, that is the socket listening incoming connections
> and sk == skb->sk for non request_sock/listening_sock case.

Just a thought, should the test look like the below?

         int __ret = 0;                                                         \
         if (cgroup_bpf_enabled(CGROUP_INET_EGRESS) && sk) {                    \
                 typeof(sk) __sk = sk_to_full_sk(sk);                           \
                 if (sk_fullsock(__sk) && __sk == skb_to_full_sk(skb) &&        \
                     cgroup_bpf_sock_enabled(__sk, CGROUP_INET_EGRESS))         \
                         __ret = __cgroup_bpf_run_filter_skb(__sk, skb,         \
                                                       CGROUP_INET_EGRESS); \
         }                                                                      \

Iow, we do already convert __sk to full sk, so we should then also use that
for the test with skb_to_full_sk(skb).

Thanks,
Daniel
