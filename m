Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36E67633CB6
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Nov 2022 13:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233101AbiKVMjs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Nov 2022 07:39:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbiKVMjo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Nov 2022 07:39:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AEFBF5B1
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Nov 2022 04:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669120723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TlBwJNp/jitu4dnjNvCRWCp8vuWXGMZrB45QP9OtTb4=;
        b=IpzmBLNyACs49jY7lgm++c8lhjtDTgOXfwTpMANdyIWb3BfgSbDCeyxhy1qhFETXdDsd0G
        An5awmOQ49LKZxGh5izikymF4VR9bXLTXwERrsalSCWWgRSGPg0Pw+ndj60IUPIGdPJpKh
        EWzeYEpE3ou6yA2Us7yJHfSCe5bm1GU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-649-Nw1wy4uKN2eRyRt6gtWPoQ-1; Tue, 22 Nov 2022 07:38:42 -0500
X-MC-Unique: Nw1wy4uKN2eRyRt6gtWPoQ-1
Received: by mail-wm1-f72.google.com with SMTP id r81-20020a1c4454000000b003d02dc20735so73872wma.0
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Nov 2022 04:38:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TlBwJNp/jitu4dnjNvCRWCp8vuWXGMZrB45QP9OtTb4=;
        b=7T/fqxZuCVQVl+yo+HSd7sVTi5bKOWDQczW9SW/XMvgn77Il8FUG1aHj902M6Aj6EF
         SnEdS5aCr7E7iNpRVpsSGAY6AEU29SIiid8aci7/8i2dIoS4Rfp4dStcCLDsABGdN3Vx
         ZCpELHpEUltqREnT+ELp59Ee6KpyDBfi/yQicZ73diDWiBv7JLhfA0SbV6lcSXhg/Fm3
         sx7jvXPhcN2qO1CGVyEklksg4vV86noKrgaonrRFPfmGuoDqN9/7hqW0VleArXwmVcHD
         Bs4VKfb4WBfy0Yr335AJNJsySdZf0oEzMvCtU5BKhKnww0lu42iee3ydPvXrd8sp5TpK
         oUMA==
X-Gm-Message-State: ANoB5pkvClYXRcUkFw4e4Er4wuW3RlcRORKB906zuliGlPVoq3VYW+mh
        g7r4yrX/BQiqteLqLw8FnYv3+7dqE+/dthbKw+iA60KFhVS21g0amMTnZm9H1VhP46IC/L/lTaq
        p4bYg++G2DTDUq1+DexVw8bj4j9vo
X-Received: by 2002:adf:e844:0:b0:241:bfc9:5975 with SMTP id d4-20020adfe844000000b00241bfc95975mr6721667wrn.605.1669120721074;
        Tue, 22 Nov 2022 04:38:41 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7FQCDctLOc6CMomYnGKvCTF1tBw+hwXPXd04O7+t428MWI9RvMvJ15rLs2ESKiQpMYCXYY+g==
X-Received: by 2002:adf:e844:0:b0:241:bfc9:5975 with SMTP id d4-20020adfe844000000b00241bfc95975mr6721629wrn.605.1669120720555;
        Tue, 22 Nov 2022 04:38:40 -0800 (PST)
Received: from ?IPV6:2003:cb:c706:c300:b066:75e3:f1d2:b69b? (p200300cbc706c300b06675e3f1d2b69b.dip0.t-ipconnect.de. [2003:cb:c706:c300:b066:75e3:f1d2:b69b])
        by smtp.gmail.com with ESMTPSA id e18-20020a5d5952000000b00236883f2f5csm13821707wri.94.2022.11.22.04.38.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 04:38:40 -0800 (PST)
Message-ID: <6ace6cd4-3e13-8ec1-4c2a-49e2e14e81a6@redhat.com>
Date:   Tue, 22 Nov 2022 13:38:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Content-Language: en-US
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Tomasz Figa <tfiga@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-media@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
        Oded Gabbay <ogabbay@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
References: <20221107161740.144456-1-david@redhat.com>
 <20221107161740.144456-17-david@redhat.com>
 <CAAFQd5C3Ba1WhjYJF_7tW06mgvzoz9KTakNo+Tz8h_f6dGKzHQ@mail.gmail.com>
 <6175d780-3307-854c-448a-8e6c7ad0772c@xs4all.nl>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH RFC 16/19] mm/frame-vector: remove FOLL_FORCE usage
In-Reply-To: <6175d780-3307-854c-448a-8e6c7ad0772c@xs4all.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 22.11.22 13:25, Hans Verkuil wrote:
> Hi Tomasz, David,
> 
> On 11/8/22 05:45, Tomasz Figa wrote:
>> Hi David,
>>
>> On Tue, Nov 8, 2022 at 1:19 AM David Hildenbrand <david@redhat.com> wrote:
>>>
>>> FOLL_FORCE is really only for debugger access. According to commit
>>> 707947247e95 ("media: videobuf2-vmalloc: get_userptr: buffers are always
>>> writable"), the pinned pages are always writable.
>>
>> Actually that patch is only a workaround to temporarily disable
>> support for read-only pages as they seemed to suffer from some
>> corruption issues in the retrieved user pages. We expect to support
>> read-only pages as hardware input after. That said, FOLL_FORCE doesn't
>> sound like the right thing even in that case, but I don't know the
>> background behind it being added here in the first place. +Hans
>> Verkuil +Marek Szyprowski do you happen to remember anything about it?
> 
> I tracked the use of 'force' all the way back to the first git commit
> (2.6.12-rc1) in the very old video-buf.c. So it is very, very old and the
> reason is lost in the mists of time.
> 
> I'm not sure if the 'force' argument of get_user_pages() at that time
> even meant the same as FOLL_FORCE today. From what I can tell it has just
> been faithfully used ever since, but I have my doubt that anyone understands
> the reason behind it since it was never explained.
> 
> Looking at this old LWN article https://lwn.net/Articles/28548/ suggests
> that it might be related to calling get_user_pages for write buffers
> (non-zero write argument) where you also want to be able to read from the
> buffer. That is certainly something that some drivers need to do post-capture
> fixups.
> 
> But 'force' was also always set for read buffers, and I don't know if that
> was something that was actually needed, or just laziness.
> 
> I assume that removing FOLL_FORCE from 'FOLL_FORCE|FOLL_WRITE' will still
> allow drivers to read from the buffer?

Yes. The only problematic corner case I can imagine is if someone has a 
VMA without write permissions (no PROT_WRITE/VM_WRITE) and wants to pin 
user space pages as a read buffer. We'd specify now FOLL_WRITE without 
FOLL_FORCE and GUP would reject that: write access without write 
permissions is invalid.

There would be no way around "fixing" this implementation to not specify 
FOLL_WRITE when only reading from user-space pages. Not sure what the 
implications are regarding that corruption that was mentioned in 
707947247e95.

Having said that, I assume such a scenario is unlikely -- but you might 
know better how user space usually uses this interface. There would be 
three options:

1) Leave the FOLL_FORCE hack in for now, which I *really* want to avoid.
2) Remove FOLL_FORCE and see if anybody even notices (this patch) and
    leave the implementation as is for now.
3) Remove FOLL_FORCE and fixup the implementation to only specify
    FOLL_WRITE if the pages will actually get written to.

3) would most probably ideal, however, I am no expert on that code and 
can't do it (707947247e95 confuses me). So naive me would go with 2) first.

-- 
Thanks,

David / dhildenb

