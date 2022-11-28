Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD2F63A472
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Nov 2022 10:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbiK1JNm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Nov 2022 04:13:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiK1JNd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Nov 2022 04:13:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C0F10D0
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Nov 2022 01:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669626752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HQQZLn0FmMUCFZ2qQSadnIASvWkmzSJEE5ukh0xjO/g=;
        b=Dmv1EJ31VeCFnrclnd+uG1MpvyEcCOExC0IGBZ+ClaRjcfVHe1hSk+blUWyQEhQCYXFRVP
        6Hijou7Xkg8pTOzPHbuv2X2w9etQxIiN1qzbaGueylxddx4MNvT43XkHRjI5mNA/0XKMhr
        guqixkV+reR4rDN1boOpVm4ndnxCplA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-544-OXY4Ij17PGCgmTUrkuHzKQ-1; Mon, 28 Nov 2022 04:12:27 -0500
X-MC-Unique: OXY4Ij17PGCgmTUrkuHzKQ-1
Received: by mail-qk1-f197.google.com with SMTP id bk30-20020a05620a1a1e00b006fb2378c857so18784699qkb.18
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Nov 2022 01:12:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HQQZLn0FmMUCFZ2qQSadnIASvWkmzSJEE5ukh0xjO/g=;
        b=HcgnKhDlNHXETMqL2mJukv3jaMa0Mtp58Ysl2kukV9RvYQ+1I6M19C2oV8B9qvw96x
         gAlK5Rnto7dqOJDvEtMgdB908oTvHFoNDNsKjb1nhNbnGVTfdbmpiyGH6fCccsbYY+ra
         cEdExNg0OFdRZ+Y18jTgRImEaRc5k4c/4gS1ul9W62jm+p7wBRKJo8e5ftILxm7p+xV/
         HuJyk8eErZjny+tCpRnkFi4HBe+JpqplxSxhzI+xcn9Obvm1xZvqixnlYaipfDkZyaYc
         JPuabOzKcz7UDqFeshzpLDY38crAUxXFSLxvao2Lm2Uz6EJs87VDttmfl6C++pg1IaEu
         x5vw==
X-Gm-Message-State: ANoB5pnvGlbYYDLRM+SIxAc+Ab9EANw5aAQNqR3Y9hzA5NfnFJfAXgMd
        DRGk8ESCb25LmP6GdWiCMN3d9uqSRBARk2jo+fd6dslH0qp9KLtV9QNM9R0TfEPjoVIC+QK5/U9
        X+kfopJmTtLQNhLlWp3E/y35G/G7S
X-Received: by 2002:ac8:67c5:0:b0:3a4:f665:7791 with SMTP id r5-20020ac867c5000000b003a4f6657791mr47725047qtp.380.1669626746988;
        Mon, 28 Nov 2022 01:12:26 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4TpyycggVFsgND4ClCc6B8wuSrlaMN9i6IiH2GGnjUkvpSlhiiKgBPMNkKYR5hfJv9q1VGdQ==
X-Received: by 2002:ac8:67c5:0:b0:3a4:f665:7791 with SMTP id r5-20020ac867c5000000b003a4f6657791mr47725033qtp.380.1669626746696;
        Mon, 28 Nov 2022 01:12:26 -0800 (PST)
Received: from [192.168.0.146] ([139.47.72.25])
        by smtp.gmail.com with ESMTPSA id dm32-20020a05620a1d6000b006e702033b15sm7875652qkb.66.2022.11.28.01.12.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 01:12:26 -0800 (PST)
Message-ID: <753d995d-d4f4-bf2e-994d-435a36414127@redhat.com>
Date:   Mon, 28 Nov 2022 10:12:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [ovs-dev] [RFC net-next 1/6] openvswitch: exclude kernel flow key
 from upcalls
Content-Language: en-US
To:     Ilya Maximets <i.maximets@ovn.org>,
        Aaron Conole <aconole@redhat.com>, netdev@vger.kernel.org
Cc:     dev@openvswitch.org, linux-kernel@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>,
        linux-kselftest@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
References: <20221122140307.705112-1-aconole@redhat.com>
 <20221122140307.705112-2-aconole@redhat.com>
 <c04242ee-f125-6d95-e263-65470222d3cf@ovn.org>
 <83a0b3e4-1327-c1c4-4eb4-9a25ff533d1d@redhat.com>
 <bf975714-7edc-efdd-de84-56194aa6eb60@ovn.org>
From:   Adrian Moreno <amorenoz@redhat.com>
In-Reply-To: <bf975714-7edc-efdd-de84-56194aa6eb60@ovn.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 11/25/22 16:51, Ilya Maximets wrote:
> On 11/25/22 16:29, Adrian Moreno wrote:
>>
>>
>> On 11/23/22 22:22, Ilya Maximets wrote:
>>> On 11/22/22 15:03, Aaron Conole wrote:
>>>> When processing upcall commands, two groups of data are available to
>>>> userspace for processing: the actual packet data and the kernel
>>>> sw flow key data.  The inclusion of the flow key allows the userspace
>>>> avoid running through the dissection again.
>>>>
>>>> However, the userspace can choose to ignore the flow key data, as is
>>>> the case in some ovs-vswitchd upcall processing.  For these messages,
>>>> having the flow key data merely adds additional data to the upcall
>>>> pipeline without any actual gain.  Userspace simply throws the data
>>>> away anyway.
>>>
>>> Hi, Aaron.  While it's true that OVS in userpsace is re-parsing the
>>> packet from scratch and using the newly parsed key for the OpenFlow
>>> translation, the kernel-porvided key is still used in a few important
>>> places.  Mainly for the compatibility checking.  The use is described
>>> here in more details:
>>>     https://docs.kernel.org/networking/openvswitch.html#flow-key-compatibility
>>>
>>> We need to compare the key generated in userspace with the key
>>> generated by the kernel to know if it's safe to install the new flow
>>> to the kernel, i.e. if the kernel and OVS userpsace are parsing the
>>> packet in the same way.
>>>
>>
>> Hi Ilya,
>>
>> Do we need to do that for every packet?
>> Could we send a bitmask of supported fields to userspace at feature
>> negotiation and let OVS slowpath flows that it knows the kernel won't
>> be able to handle properly?
> 
> It's not that simple, because supported fields in a packet depend
> on previous fields in that same packet.  For example, parsing TCP
> header is generally supported, but it won't be parsed for IPv6
> fragments (even the first one), number of vlan headers will affect
> the parsing as we do not parse deeper than 2 vlan headers, etc.
> So, I'm afraid we have to have a per-packet information, unless we
> can somehow probe all the possible valid combinations of packet
> headers.
> 

Surely. I understand that we'd need more than just a bit per field. Things like 
L4 on IPv6 frags would need another bit and the number of VLAN headers would 
need some more. But, are these a handful of exceptions or do we really need all 
the possible combinations of headers? If it's a matter of naming a handful of 
corner cases I think we could consider expressing them at initialization time 
and safe some buffer space plus computation time both in kernel and userspace.

-- 
Adrián Moreno

>>
>>
>>> On the other hand, OVS today doesn't check the data, it only checks
>>> which fields are present.  So, if we can generate and pass the bitmap
>>> of fields present in the key or something similar without sending the
>>> full key, that might still save some CPU cycles and memory in the
>>> socket buffer while preserving the ability to check for forward and
>>> backward compatibility.  What do you think?
>>>
>>>
>>> The rest of the patch set seems useful even without patch #1 though.
>>>
>>> Nit: This patch #1 should probably be merged with the patch #6 and be
>>> at the end of a patch set, so the selftest and the main code are updated
>>> at the same time.
>>>
>>> Best regards, Ilya Maximets.
>>> _______________________________________________
>>> dev mailing list
>>> dev@openvswitch.org
>>> https://mail.openvswitch.org/mailman/listinfo/ovs-dev
>>>
>>
>> Thanks
> 

