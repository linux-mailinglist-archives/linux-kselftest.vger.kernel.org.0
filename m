Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E860E640F2D
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Dec 2022 21:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233637AbiLBU1U (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Dec 2022 15:27:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbiLBU1S (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Dec 2022 15:27:18 -0500
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9B8ECA01
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Dec 2022 12:27:13 -0800 (PST)
Message-ID: <4cf2ecd4-2f21-848a-00df-4e4fd86667eb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1670012831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NUcEALuux82cTjstILvzqBke9w8vB4f799oxTJvNJ0Y=;
        b=rgsljsucGydqBrYw+l7rotjrX/oVrOk7tpEFaDxm9NO0nrNpXPgum9XLfUHhUKSsxsl22W
        WcsIMySL2O40G/zJZyozp1a+WQGByA4zzq+1unUQj9KktzMJ9PxRMKYbTmRcn9hsCM5Vgi
        uf4iisiXfmbCRLvGWo2NKm+jz7pVRZw=
Date:   Fri, 2 Dec 2022 12:27:01 -0800
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next,v4 2/4] xfrm: interface: Add unstable helpers for
 setting/getting XFRM metadata from TC-BPF
Content-Language: en-US
To:     Eyal Birger <eyal.birger@gmail.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
        andrii@kernel.org, daniel@iogearbox.net, nicolas.dichtel@6wind.com,
        razor@blackwall.org, mykolal@fb.com, ast@kernel.org,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, shuah@kernel.org, liuhangbin@gmail.com,
        lixiaoyan@google.com
References: <20221202095920.1659332-1-eyal.birger@gmail.com>
 <20221202095920.1659332-3-eyal.birger@gmail.com>
 <6d0e13eb-63e0-a777-2a27-7f2e02867a13@linux.dev>
 <CAHsH6Gtt4vihaZ5kCFsjT8x1SmuiUkijnVxgAA9bMp4NOgPeAw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <CAHsH6Gtt4vihaZ5kCFsjT8x1SmuiUkijnVxgAA9bMp4NOgPeAw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/2/22 11:42 AM, Eyal Birger wrote:
> Hi Martin,
> 
> On Fri, Dec 2, 2022 at 9:08 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>>
>> On 12/2/22 1:59 AM, Eyal Birger wrote:
>>> +__used noinline
>>> +int bpf_skb_set_xfrm_info(struct __sk_buff *skb_ctx,
>>> +                       const struct bpf_xfrm_info *from)
>>> +{
>>> +     struct sk_buff *skb = (struct sk_buff *)skb_ctx;
>>> +     struct metadata_dst *md_dst;
>>> +     struct xfrm_md_info *info;
>>> +
>>> +     if (unlikely(skb_metadata_dst(skb)))
>>> +             return -EINVAL;
>>> +
>>> +     md_dst = this_cpu_ptr(xfrm_md_dst);
>>> +
>>> +     info = &md_dst->u.xfrm_info;
>>> +
>>> +     info->if_id = from->if_id;
>>> +     info->link = from->link;
>>> +     skb_dst_force(skb);
>>> +     info->dst_orig = skb_dst(skb);
>>> +
>>> +     dst_hold((struct dst_entry *)md_dst);
>>> +     skb_dst_set(skb, (struct dst_entry *)md_dst);
>>
>>
>> I may be missed something obvious and this just came to my mind,
>>
>> What stops cleanup_xfrm_interface_bpf() being run while skb is still holding the
>> md_dst?
>>
> Oh I think you're right. I missed this.
> 
> In order to keep this implementation I suppose it means that the module would
> not be allowed to be removed upon use of this kfunc. but this could be seen as
> annoying from the configuration user experience.
> 
> Alternatively the metadata dsts can be separately allocated from the kfunc,
> which is probably the simplest approach to maintain, so I'll work on that
> approach.

If it means dst_alloc on every skb, it will not be cheap.

Another option is to metadata_dst_alloc_percpu() once during the very first 
bpf_skb_set_xfrm_info() call and the xfrm_md_dst memory will never be freed.  It 
is a tradeoff but likely the correct one.  You can take a look at 
bpf_get_skb_set_tunnel_proto().

