Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F497E3185
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Nov 2023 00:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233267AbjKFXhM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Nov 2023 18:37:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233143AbjKFXhL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Nov 2023 18:37:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6788F;
        Mon,  6 Nov 2023 15:37:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C7A0C433C7;
        Mon,  6 Nov 2023 23:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699313828;
        bh=h0S79LVjAan/iH3IkQASAF7+37BYiP+aZRxXCZvJPsg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LeNrbB8z4RQxY05FYKNoTzKmbq+g4U4chZEqsB8U7wMLOQG5bQ00zLdcyG4zk2FSG
         sirRWy1WHKJhDp/lGJ0F8oiw6DOkHpLvYDGVEKW9C5q4nj0/qBG6zXeKaQkvDK8aUM
         bIFoenc6lxo6qZ+gEpxnFBLEyj0YCdplMxiItzB0OGgld+kfO6gcCZakR1w3AKA1n/
         n08qdlKTcDb7Bq7Gf/jUXn/bc+NR6WHwi5vJfJpTSFNxYJNiHRT29kU9u3xFsSMMve
         JKSRGtgbD1cdZ/3+1ROyEWy5Jo2sgtaWruuPCseAAQcb+VhSeNfdbNIIH+UuAv/Xd7
         3UtKrn82JB/Jw==
Message-ID: <00883386-0c4b-4ba7-84c6-553f468304e6@kernel.org>
Date:   Mon, 6 Nov 2023 16:37:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 09/12] net: add support for skbs with unreadable
 frags
Content-Language: en-US
To:     Mina Almasry <almasrymina@google.com>,
        Stanislav Fomichev <sdf@google.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Shakeel Butt <shakeelb@google.com>,
        Jeroen de Borst <jeroendb@google.com>,
        Praveen Kaligineedi <pkaligineedi@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Kaiyuan Zhang <kaiyuanz@google.com>
References: <20231106024413.2801438-1-almasrymina@google.com>
 <20231106024413.2801438-10-almasrymina@google.com>
 <ZUk03DhWxV-bOFJL@google.com>
 <19129763-6f74-4b04-8a5f-441255b76d34@kernel.org>
 <CAHS8izMrnVUfbbS=OcJ6JT9SZRRfZ2MC7UnggthpZT=zf2BGLA@mail.gmail.com>
 <ZUlhu4hlTaqR3CTh@google.com>
 <CAHS8izMaAhoae5ChnzO4gny1cYYnqV1cB8MC2cAF3eoyt+Sf4A@mail.gmail.com>
From:   David Ahern <dsahern@kernel.org>
In-Reply-To: <CAHS8izMaAhoae5ChnzO4gny1cYYnqV1cB8MC2cAF3eoyt+Sf4A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/6/23 3:18 PM, Mina Almasry wrote:
>>>>>> @@ -991,7 +993,7 @@ struct sk_buff {
>>>>>>  #if IS_ENABLED(CONFIG_IP_SCTP)
>>>>>>      __u8                    csum_not_inet:1;
>>>>>>  #endif
>>>>>> -
>>>>>> +    __u8                    devmem:1;
>>>>>>  #if defined(CONFIG_NET_SCHED) || defined(CONFIG_NET_XGRESS)
>>>>>>      __u16                   tc_index;       /* traffic control index */
>>>>>>  #endif
>>>>>> @@ -1766,6 +1768,12 @@ static inline void skb_zcopy_downgrade_managed(struct sk_buff *skb)
>>>>>>              __skb_zcopy_downgrade_managed(skb);
>>>>>>  }
>>>>>>
>>>>>> +/* Return true if frags in this skb are not readable by the host. */
>>>>>> +static inline bool skb_frags_not_readable(const struct sk_buff *skb)
>>>>>> +{
>>>>>> +    return skb->devmem;
>>>>>
>>>>> bikeshedding: should we also rename 'devmem' sk_buff flag to 'not_readable'?
>>>>> It better communicates the fact that the stack shouldn't dereference the
>>>>> frags (because it has 'devmem' fragments or for some other potential
>>>>> future reason).
>>>>
>>>> +1.
>>>>
>>>> Also, the flag on the skb is an optimization - a high level signal that
>>>> one or more frags is in unreadable memory. There is no requirement that
>>>> all of the frags are in the same memory type.
>>
>> David: maybe there should be such a requirement (that they all are
>> unreadable)? Might be easier to support initially; we can relax later
>> on.
>>
> 
> Currently devmem == not_readable, and the restriction is that all the
> frags in the same skb must be either all readable or all unreadable
> (all devmem or all non-devmem).

What requires that restriction? In all of the uses of skb->devmem and
skb_frags_not_readable() what matters is if any frag is not readable,
then frag list walk or collapse is avoided.

