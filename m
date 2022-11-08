Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35D5E620C3E
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Nov 2022 10:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233405AbiKHJa1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Nov 2022 04:30:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233383AbiKHJa0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Nov 2022 04:30:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852F913DDB
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Nov 2022 01:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667899762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G/IvXa3Gtc42ocSwbE6e2PTXEI1xHOCM/WDymiGQVjk=;
        b=EclQgB/BAXWPmHv1CQSriGjM01041EmwLWXrYJNK4SB8YG848WwPaT3gtRThNKwuxzmdw5
        WIGW9R+7AM/5gAAZRH/0L5G44XvsMJQpHiO/l6SjGpDw5LLZtlzG5p9K4gQknYqLCl5Jpf
        5BIWRtsM4d1QsnoJfX3bzespR7vjkbA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-61-mGGM5kAUMIGAfzHKNXK3wA-1; Tue, 08 Nov 2022 04:29:21 -0500
X-MC-Unique: mGGM5kAUMIGAfzHKNXK3wA-1
Received: by mail-wr1-f70.google.com with SMTP id j20-20020adfb314000000b002366d9f67aaso3748495wrd.3
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Nov 2022 01:29:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G/IvXa3Gtc42ocSwbE6e2PTXEI1xHOCM/WDymiGQVjk=;
        b=Q7QoUN6HMjp2Ebi9EjXT/BzHK7aiZ7j7wp4L2HohRxeEYxWKSOzilyvf2xhLJ1fTs2
         SDz8VO7jVsXljVGE5VQF75ikWDBNbVD4HxmGvOIVNWK5Rq8iyQZTn9CflpPLiDPP9cli
         rhJmrc1E0di3FPCvziGk0GOEg9xIvCS2lJnddGKJx9QwpBffZFI2PEiCcgTzmlhYiROS
         Fvp8QOPc6cSL5pcods2rotkHqYqjBsZ3RcKKSTIc93l8BLlRVhmOvT/DXtgYqlhFZaBG
         QSr60XuQRNF92mOIQfm7/n/d6nnSupef5DRqvmK8lPyq13njNahyCXUiMpIiLoQMcbzX
         M6Dg==
X-Gm-Message-State: ACrzQf0QM8reWwoEukW3eqShOQR8Ay1j2ePRwxYkfnmqqTIyad5SXjfm
        qANa2sITNHWSv9UCpnR7/8YQDWVx68XPIRrp3dRiO/cQkAbCXRjgFvSjO631ERl3d6h1ReX8w4f
        4LPCTnX7jEwWH6Y3iDl7ITg9JkFD3
X-Received: by 2002:a1c:7418:0:b0:3cf:703a:4f0c with SMTP id p24-20020a1c7418000000b003cf703a4f0cmr31192092wmc.63.1667899760176;
        Tue, 08 Nov 2022 01:29:20 -0800 (PST)
X-Google-Smtp-Source: AMsMyM5StZVkpugFYppLkRHp5xlGTjmqFOUyferk1nDQuYzjbb+gdKwEthZaHv8SGYCGJ8Geu++6Xg==
X-Received: by 2002:a1c:7418:0:b0:3cf:703a:4f0c with SMTP id p24-20020a1c7418000000b003cf703a4f0cmr31192042wmc.63.1667899759842;
        Tue, 08 Nov 2022 01:29:19 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:db00:6510:da8d:df40:abbb? (p200300cbc708db006510da8ddf40abbb.dip0.t-ipconnect.de. [2003:cb:c708:db00:6510:da8d:df40:abbb])
        by smtp.gmail.com with ESMTPSA id n10-20020a5d420a000000b0023682011c1dsm9563940wrq.104.2022.11.08.01.29.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 01:29:19 -0800 (PST)
Message-ID: <ee9fceb8-f928-8754-d94f-54b662bb0c74@redhat.com>
Date:   Tue, 8 Nov 2022 10:29:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH RFC 00/19] mm/gup: remove FOLL_FORCE usage from drivers
 (reliable R/O long-term pinning)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-media@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Peter Xu <peterx@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>, Nadav Amit <namit@vmware.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Oded Gabbay <ogabbay@kernel.org>, Arnd Bergmann <arnd@arndb.de>
References: <20221107161740.144456-1-david@redhat.com>
 <CAHk-=wj51-dtxf8BQBYP+9Kc3ejq4Y0=-6hCbf_XAnkT3fsgDQ@mail.gmail.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CAHk-=wj51-dtxf8BQBYP+9Kc3ejq4Y0=-6hCbf_XAnkT3fsgDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 07.11.22 18:27, Linus Torvalds wrote:
> On Mon, Nov 7, 2022 at 8:18 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> So instead, make R/O long-term pinning work as expected, by breaking COW
>> in a COW mapping early, such that we can remove any FOLL_FORCE usage from
>> drivers.
> 
> Nothing makes me unhappy from a quick scan through these patches.
> 
> And I'd really love to just have this long saga ended, and FOLL_FORCE
> finally relegated to purely ptrace accesses.
> 
> So an enthusiastic Ack from me.

Thanks Linus! My hope is that we can remove it from all drivers and not 
have to leave it in for some corner cases; so far it looks promising.

-- 
Thanks,

David / dhildenb

