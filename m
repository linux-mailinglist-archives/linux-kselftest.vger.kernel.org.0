Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD501605BD1
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Oct 2022 12:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiJTKFi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Oct 2022 06:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiJTKFg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Oct 2022 06:05:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6351C169CFE
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Oct 2022 03:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666260334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b6yK6XC2fpvM5GYufymBVihPn45YwUGwSfARH9fFd4M=;
        b=Y+jcC3NhgyxsKN3cmKlZr7ZWBxRQEQCu08y0r1Kg55AlbRi8IR8+F87QDBGG6id34ouqFi
        ebW3hOTgnzpQVcvoiL+pQP7H8jB3PtAm3Ns92Ng9f5w7RHca+IkOujpeovPWHbWInIT1CD
        NyOfSi3SrpLUpu4nkt5PTXMAco7CZrg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-496-v2avBa2gM2ytW1y39JEGFA-1; Thu, 20 Oct 2022 06:05:33 -0400
X-MC-Unique: v2avBa2gM2ytW1y39JEGFA-1
Received: by mail-wm1-f70.google.com with SMTP id az11-20020a05600c600b00b003c6e3d4d5b1so10971585wmb.7
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Oct 2022 03:05:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b6yK6XC2fpvM5GYufymBVihPn45YwUGwSfARH9fFd4M=;
        b=cgHs3ZBIeG3KfsumTLQ8yw4oHGTCLTXSrjcUyQq2OVuRu913OwavVuH49InQR34H/3
         IY8tXjt8vgQPTzLsXWXDSQMs9fXOKXmG0Keznk+9+eS2Gwj+gRPOx6oRJfHhFPQ00RhJ
         lgk9QRz/BFtqAVK8oF/esW+iBFZM+Z9f86xRpspTnAgWm6Q1RA06TSVhIfoUZT+k75L+
         V5jyIjcvSXRp1M+QcKFLuf9ARmMC7qB3OXSBrsKaTsABz1ePCPZpWFr2PxMkFrk2VObA
         Kfh7YpbrCYI0LmbqwTd1gpq7G00fo6Jus365xxeo4hpj2vdcd4i2kNiOItzt6EN2LIdO
         GrEw==
X-Gm-Message-State: ACrzQf3BIDt7fLj49tqXX9KKVn7ZU8dLHxTxhiGt3troxPI64/3gjefz
        kOETRoJr/yUCzGiYmJbq+Ebavg9nKKVF/X1W6hayokAu4IWB6w0mvEWeGb33fq5LE0up/yxSIUL
        coCIG5NoQ+HwyGsK7WmRn7X7HaOGH
X-Received: by 2002:adf:dc4b:0:b0:230:5fe6:69d2 with SMTP id m11-20020adfdc4b000000b002305fe669d2mr7935514wrj.469.1666260331791;
        Thu, 20 Oct 2022 03:05:31 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4g+BdVVhP/DCqSzgafKraJ4+5xJgtnKBLUIP0W7QYfpF3Ib4HNHfxW8nd9OyuxmutH2d9vcA==
X-Received: by 2002:adf:dc4b:0:b0:230:5fe6:69d2 with SMTP id m11-20020adfdc4b000000b002305fe669d2mr7935479wrj.469.1666260331411;
        Thu, 20 Oct 2022 03:05:31 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:b100:1443:78d5:341f:c97a? (p200300cbc708b100144378d5341fc97a.dip0.t-ipconnect.de. [2003:cb:c708:b100:1443:78d5:341f:c97a])
        by smtp.gmail.com with ESMTPSA id v10-20020a5d4a4a000000b00236492b3315sm413315wrs.104.2022.10.20.03.05.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 03:05:30 -0700 (PDT)
Message-ID: <95c44cc0-31db-88cf-7296-7c18a1e7f42a@redhat.com>
Date:   Thu, 20 Oct 2022 12:05:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
References: <20220930141931.174362-1-david@redhat.com>
 <20220930141931.174362-5-david@redhat.com> <Yz3qekna97ndP4FK@x1n>
 <bdddfd01-bc7e-2f99-21b9-2762a7041096@redhat.com> <Yz8m0J+UV/O9K5Lk@x1n>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v1 4/7] mm/ksm: fix KSM COW breaking with userfaultfd-wp
 via FAULT_FLAG_UNSHARE
In-Reply-To: <Yz8m0J+UV/O9K5Lk@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Peter,

sorry for replying so late, I only managed now to get back to this patch 
set.

>> Yes, I can give it a try. What I dislike about ksm_test is that it's a
>> mixture of benchmarks and test cases that have to explicitly triggered by
>> parameters. It's not a simple "run all available test cases" tests as we
>> know it. So maybe something separate (or having it as part of the uffd
>> tests) makes more sense.
> 
> We can add an entry into run_vmtests.sh.  That's also what current ksm_test
> does.

Right, but I kind-of don't like that way at all and would much rather do 
it cleaner...

> 
> Yes adding into uffd test would work too, but I do have a plan that we
> should move functional tests out of userfaultfd.c, leaving that with the
> stress test only.  Not really a big deal, though.

... similar to what you want to do with userfaultfd.c

So maybe I'll just add a new test for ksm functional tests.

> 
>>
>>>
>>>>
>>>> Consequently, we will no longer trigger a fake write fault and break COW
>>>> without any such side-effects.
>>>>
>>>> This is primarily a fix for KSM+userfaultfd-wp, however, the fake write
>>>> fault was always questionable. As this fix is not easy to backport and it's
>>>> not very critical, let's not cc stable.
>>>
>>> A patch to cc most of the stable would probably need to still go with the
>>> old write approach but attaching ALLOW_RETRY.  But I agree maybe that may
>>> not need to bother, or a report should have arrived earlier..  The unshare
>>> approach looks much cleaner indeed.
>>
>> A fix without FAULT_FLAG_UNSHARE is not straight forward. We really don't
>> want to notify user space about write events here (because there is none).
>> And there is no way around the uffd handling in WP code without that.
>>
>> FAULT_FLAG_ALLOW_RETRY would rely on userfaultfd triggering and having to
>> resolve the WP event.
> 
> Right it'll be very much a false positive, but the userspace should be fine
> with it e.g. for live snapshot we need to copy page earlier; it still won't
> stop the process from running along the way.  But I agree that's not ideal.

At least the test case at hand will wait until infinitely, because there 
is no handler that would allow break_cow to make progress (well, we 
don't expect write events in the test :) ).

Anyhow, I don't think messing with that for stable kernels is worth the 
pain / complexity / possible issues.

-- 
Thanks,

David / dhildenb

