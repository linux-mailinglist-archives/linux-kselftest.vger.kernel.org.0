Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 811C15EC9D4
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Sep 2022 18:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233056AbiI0Qoz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Sep 2022 12:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbiI0Qou (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Sep 2022 12:44:50 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0270BC9;
        Tue, 27 Sep 2022 09:44:45 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id s26so9903940pgv.7;
        Tue, 27 Sep 2022 09:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=BWgKxUk31+J2+2MSd46wU4vlOnJG3Yc8AiZ9YkHKoOw=;
        b=RPz+oGaXBgnWrNZkao9myAW+JIeB14subN6cQTIoHYYD+ugeMtypU+830O25ILYK7O
         G/IKSCYBSyTr3XUJxW12BiCEpY6OgqMDNlVYvVC1EDcTeQ1Q36H/A8NkvNxDQ6MXSRI+
         aJKl5drrDxwWBed3HvWdZO6c8bBkvkXcbH2zdNdpXGena7uwMJe58Ps7ID+bplm+O4PE
         tVrvgHf95mkeqPj8J8ARzL4lmJSwP+F6rCsVmMizfY42R+BnYrMLtNGvLg+kEpC732+p
         Z+PUer58KgcwURonAZoKBovdGO//6XIQ9HsVqzkKwoPahxJ0W+YQap86VPv3UGbqks7R
         Nsdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=BWgKxUk31+J2+2MSd46wU4vlOnJG3Yc8AiZ9YkHKoOw=;
        b=8KXExfuQy7hGBctKa+3gJAC9i8lDEn/5JwhV6ADpVVhrB/ZG9e5OzKA7cfBFOte3s2
         DbCfWp2sKbHvVNEVBrJsdguhMbWAItu2GQSOorTP7XJo20JAgRQsuDcvarwu0B+WLjMb
         KR32BrvrhYLY+QWPi5VNfhBTDjjfspM/BgSnWje/6YD3finpYvXOUX608q3rU3D6ac8w
         4KwjfntFedKi7rfDcvFp1p5oyoDKExioA6W1xwbrDfbWmb0j6PItaD6JoJ5fVkuw4KI2
         HDlrbsQS07n3Yi+GXI2pPp0UaWVUZpyaHytoCWqvsYmqKsrcJL8aWF4xYdwrf8wNwljJ
         uQiw==
X-Gm-Message-State: ACrzQf1pyqqId+xfCmL8v1C/iEzBUqcYw4ugfgSDM7k+ar1UrLbwy21T
        TBwRTkuumOaTEd1k3lhgGBI=
X-Google-Smtp-Source: AMsMyM7lXlUEqdYMJEwpDow4qNfPvfCwMrN01PHaXlLmv+QcFcQ92RJndlw8wjyhzmbTuH7O+FOrMg==
X-Received: by 2002:a05:6a00:2409:b0:54e:a3ad:d32d with SMTP id z9-20020a056a00240900b0054ea3add32dmr29903648pfh.70.1664297085046;
        Tue, 27 Sep 2022 09:44:45 -0700 (PDT)
Received: from ?IPV6:2620:10d:c083:3603:1885:b229:3257:6535? ([2620:10d:c090:500::1:5b3])
        by smtp.gmail.com with ESMTPSA id o3-20020a170902d4c300b00174ea015ee2sm1863469plg.38.2022.09.27.09.44.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 09:44:44 -0700 (PDT)
Message-ID: <0c989c58-2aa6-eca6-2bb9-24b1ae71694a@gmail.com>
Date:   Tue, 27 Sep 2022 09:44:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [net-next v2 0/6] net: support QUIC crypto
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     Xin Long <lucien.xin@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
        davem <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        David Ahern <dsahern@kernel.org>, shuah@kernel.org,
        imagedong@tencent.com, network dev <netdev@vger.kernel.org>,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <adel.abushaev@gmail.com>
 <20220817200940.1656747-1-adel.abushaev@gmail.com>
 <CADvbK_fVRVYjtSkn29ec70mko9aEwnwu+kHYx8bAAWm-n25mjA@mail.gmail.com>
 <f479b419-b05d-2cae-4fd0-4e88707b8d8b@gmail.com>
 <CA+FuTSf_8MjF4jeUjEqDrOwqXzf485jX_GJyVP5kPUDzOFezkg@mail.gmail.com>
Content-Language: en-US
From:   Adel Abouchaev <adel.abushaev@gmail.com>
In-Reply-To: <CA+FuTSf_8MjF4jeUjEqDrOwqXzf485jX_GJyVP5kPUDzOFezkg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 9/25/22 11:04 AM, Willem de Bruijn wrote:
>>> The patch seems to get the crypto_ctx by doing a connection hash table
>>> lookup in the sendmsg(), which is not good from the performance side.
>>> One QUIC connection can go over multiple UDP sockets, but I don't
>>> think one socket can be used by multiple QUIC connections. So why not
>>> save the ctx in the socket instead?
>> A single socket could have multiple connections originated from it,
>> having different destinations, if the socket is not connected. An
>> optimization could be made for connected sockets to cache the context
>> and save time on a lookup. The measurement of kernel operations timing
>> did not reveal a significant amount of time spent in this lookup due to
>> a relatively small number of connections per socket in general. A shared
>> table across multiple sockets might experience a different performance
>> grading.
> I'm late to this patch series, sorry. High quality implementation. I
> have a few design questions similar to Xin.
>
> If multiplexing, instead of looking up a connection by { address, port
> variable length connection ID }, perhaps return a connection table
> index on setsockopt and use that in sendmsg.


It was deliberate to not to return anything other than 0 from 
setsockopt() as defined in the spec for the function. Despite that it 
says "shall", the doc says that 0 is the only value for successful 
operation. This was the reason not to use setsockopt() for any 
bidirectional transfers of data and or status. A more sophisticated 
approach with netlink sockets would be more suitable for it. The second 
reason is the API asymmetry for Tx and Rx which will be introduced - the 
Rx will still need to match on the address, port and cid. The third 
reason is that in current implementations there are no more than a few 
connections per socket, which does not abuse the rhashtable that does a 
lookup, although it takes time to hash the key into a hash for a seek. 
The performance measurement ran against the runtime and did not flag 
this path as underperforming either, there were other parts that 
substantially add to the runtime, not the key lookup though.


>>> The patch is to reduce the copying operations between user space and
>>> the kernel. I might miss something in your user space code, but the
>>> msg to send is *already packed* into the Stream Frame in user space,
>>> what's the difference if you encrypt it in userspace and then
>>> sendmsg(udp_sk) with zero-copy to the kernel.
>> It is possible to do it this way. Zero-copy works best with packet sizes
>> starting at 32K and larger.  Anything less than that would consume the
>> improvements of zero-copy by zero-copy pre/post operations and needs to
>> align memory.
> Part of the cost of MSG_ZEROCOPY is in mapping and unmapping user
> pages. This series re-implements that with its own get_user_pages.
> That is duplicative non-trivial code. And it will incur the same cost.
> What this implementation saves is the (indeed non-trivial)
> asynchronous completion notification over the error queue.
>
> The cover letter gives some performance numbers against a userspace
> implementation that has to copy from user to kernel. It might be more
> even to compare against an implementation using MSG_ZEROCOPY and
> UDP_SEGMENT. A userspace crypto implementation may have other benefits
> compared to a kernel implementation, such as not having to convert to
> crypto API scatter-gather arrays and back to network structures.
>
> A few related points
>
> - The implementation support multiplexed connections, but only one
> crypto sendmsg can be outstanding at any time:
>
>    + /**
>    + * To synchronize concurrent sendmsg() requests through the same socket
>    + * and protect preallocated per-context memory.
>    + **/
>    + struct mutex sendmsg_mux;
>
> That is quite limiting for production workloads.

The use case that we have with MVFST library currently runs a single 
worker for a connection and has a single socket attached to it. QUIC 
allows simultaneous use of multiple connection IDs to swap them in 
runtime, and implementation would request only a handful of these. The 
MVFST batches writes into a block of about 8Kb and then uses GSO to send 
them all at once.

> - Crypto operations are also executed synchronously, using
> crypto_wait_req after each operationn. This limits throughput by using
> at most one core per UDP socket. And adds sendmsg latency (which may
> or may not be important to the application). Wireguard shows an
> example of how to parallelize software crypto across cores.
>
> - The implementation avoids dynamic allocation of cipher text pages by
> using a single ctx->cipher_page. This is protected by sendmsg_mux (see
> above). Is that safe when packets leave the protocol stack and are
> then held in a qdisc or when being processed by the NIC?
> quic_sendmsg_locked will return, but the cipher page is not free to
> reuse yet.
There is currently no use case that we have in hands that requires 
parallel transmission of data for the same connection. Multiple 
connections would have no issue running in parallel as each of them will 
have it's own preallocated cipher_page in the context.

There is a fragmentation further down the stack with 
ip_generic_getfrag() that eventually does copy_from_iter() and makea a 
copy of the data. This is executed as part of __ip_append_data() called 
from udp_sendmsg() in ipv4/udp.c. The assumption was that this is 
executed synchronously and the queues and NIC will see a mapping of a 
different memory area than the ciphertext in the pre-allocated page.

>
> - The real benefit of kernel QUIC will come from HW offload. Would it
> be better to avoid the complexity of an in-kernel software
> implementation and only focus on HW offload? Basically, pass the
> plaintext QUIC packets over a standard UDP socket and alongside in a
> cmsg pass either an index into a HW security association database or
> the immediate { key, iv } connection_info (for stateless sockets), to
> be encoded into the descriptor by the device driver.
Hardware usually targets a single ciphersuite such as AES-GCM-128/256, 
while QUIC also supports Chacha20-Poly1305 and AES-CCM. The generalized 
support for offload prompted implementation of these ciphers in kernel 
code. The kernel code could also engage if the future hardware has 
capacity caps preventing it from handling all requests in the hardware.
> - With such a simpler path, could we avoid introducing ULP and just
> have udp [gs]etsockopt CRYPTO_STATE. Where QUIC is the only defined
> state type yet.
>
> - Small aside: as the series introduces new APIs with non-trivial
> parsing in the kernel, it's good to run a fuzzer like syzkaller on it
> (if not having done so yet).
Agreed.
>> The other possible obstacle would be that eventual support
>> of QUIC encryption and decryption in hardware would integrate well with
>> this current approach.
>>> Didn't really understand the "GSO" you mentioned, as I don't see any
>>> code about kernel GSO, I guess it's just "Fragment size", right?
>>> BTW, it‘s not common to use "//" for the kernel annotation.
> minor point: fragment has meaning in IPv4. For GSO, prefer gso_size.
Sure, will change it to gso_size.
>
>> Once the payload arrives into the kernel, the GSO on the interface would
>> instruct L3/L4 stack on fragmentation. In this case, the plaintext QUIC
>> packets should be aligned on the GSO marks less the tag size that would
>> be added by encryption. For GSO size 1000, the QUIC packets in the batch
>> for transmission should all be 984 bytes long, except maybe the last
>> one. Once the tag is attached, the new size of 1000 will correctly split
>> the QUIC packets further down the stack for transmission in individual
>> IP/UDP packets. The code is also saving processing time by sending all
>> packets at once to UDP in a single call, when GSO is enabled.
>>> I'm not sure if it's worth adding a ULP layer over UDP for this QUIC
>>> TX only. Honestly, I'm more supporting doing a full QUIC stack in the
>>> kernel independently with socket APIs to use it:
>>> https://github.com/lxin/tls_hs.
>>>
>>> Thanks.
