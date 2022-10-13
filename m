Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 746005FE29A
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Oct 2022 21:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiJMTVG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Oct 2022 15:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiJMTVE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Oct 2022 15:21:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97751633AC
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Oct 2022 12:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665688860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wEGx5CxM6rpR8PQ0ecVuxQZMdvNqcMcjoURLAU2YH94=;
        b=DU+VVrWhgNTEXsbZ+or2Q88TFbDCqqSEBp2NYbC27VzWYZpRHlj2WYSXnZX7ENakMA2M9q
        C7v4ul2XkGgmC+Hf7fF5B7LnR+rtokem6QJesJnRqzugMxlrgK7sRSmwfVUz+nlbfvpwHw
        /5jmvy+KtcrMjDtCVsmT4WIrXMTX3iE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-5-84oNMhhrNuaD0CMvCoQSyw-1; Thu, 13 Oct 2022 14:01:03 -0400
X-MC-Unique: 84oNMhhrNuaD0CMvCoQSyw-1
Received: by mail-wr1-f70.google.com with SMTP id u20-20020adfc654000000b0022cc05e9119so870113wrg.16
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Oct 2022 11:01:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wEGx5CxM6rpR8PQ0ecVuxQZMdvNqcMcjoURLAU2YH94=;
        b=nGXn8WIkwmh5A4FvNQuqL7gJ4vt4YcrRFcqfSuih33lxPMZqX8S6uahQzstzzAZWP/
         ZoXi//yqrygxvv1IWmUOAKz94a2TYzqIKq3zLC8Iidn7FV6vcvvBOXfDKpkUnG9tsOVd
         irjUODHXx7SqCrIUGn++yCJIv60Y4fy9AzhIT9atfhZh7CSblerS/YERw+Bs0v1TZF5x
         VrpDv9YLuQ86Qyj1W7ff3dTJhP9g2JnlASUsAl1aNPR47Bv2fg492rExpnwrKNP/RR8H
         08coBLgGD5Ri++ZV60+/72TXexe4IafHl22yCxiWlmFsYulAJRgGTBvBK89eWuTcTZi/
         Xapw==
X-Gm-Message-State: ACrzQf06ua7s01qEiGg8jDM5L6CtFDLiwLZa85ZxGwhR2qgm8KW2V3L4
        RIY+4BotRNwCcveG/VyWZdu+nVBBNtafcDOVtKR/rZd2YZrMJn8yOfjsxmSvNrSlWBbp3j0Jvyb
        5G0ukrQ3Vucn6ZFMlZp5s/ZZ9JIWp
X-Received: by 2002:a5d:6a42:0:b0:22e:6706:647b with SMTP id t2-20020a5d6a42000000b0022e6706647bmr837009wrw.58.1665684062025;
        Thu, 13 Oct 2022 11:01:02 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5vu77l91naDrv/zj84WtHXXF0kGYEVxWW41KqI+56KRQvt1K79CigI/pQK1IShqdnmbvj9vw==
X-Received: by 2002:a5d:6a42:0:b0:22e:6706:647b with SMTP id t2-20020a5d6a42000000b0022e6706647bmr836990wrw.58.1665684061725;
        Thu, 13 Oct 2022 11:01:01 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:9d00:a34c:e448:d59b:831? (p200300cbc7069d00a34ce448d59b0831.dip0.t-ipconnect.de. [2003:cb:c706:9d00:a34c:e448:d59b:831])
        by smtp.gmail.com with ESMTPSA id x17-20020adff0d1000000b00231ed902a4esm231362wro.5.2022.10.13.11.01.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Oct 2022 11:01:01 -0700 (PDT)
Message-ID: <ecebc355-eff8-0046-3749-8738ed1954de@redhat.com>
Date:   Thu, 13 Oct 2022 20:00:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: hmm_test issues with latest mainline
Content-Language: en-US
To:     Vlastimil Babka <vbabka@suse.cz>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Alex Sierra <alex.sierra@amd.com>,
        Alistair Popple <apopple@nvidia.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Christoph Hellwig <hch@lst.de>,
        Jerome Glisse <jglisse@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>
References: <26017fe3-5ad7-6946-57db-e5ec48063ceb@suse.cz>
 <7e2e6679-3205-3540-f522-9eaed2940559@redhat.com>
 <44fcecda-31a4-7288-1848-63003dfe0a7d@linuxfoundation.org>
 <04114304-7b35-d42f-0155-087e3b6237c6@suse.cz>
 <0e02ace6-2fad-47d2-03b9-d8a46f256097@suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <0e02ace6-2fad-47d2-03b9-d8a46f256097@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

>>>> When did that test start failing? Was it still ok for 6.0?
>>
>> Didn't test yet, will try, in case it's my system/config specific thing.
> 
> So it's actually all the same with v6.0 for me. The infinite loops, the test
> failures, the misreported SKIPs.
> 
> #  RUN           hmm.hmm_device_private.exclusive ...
> # hmm-tests.c:1673:exclusive:Expected ret (-16) == 0 (0)
> hmm close returned (-1) fd is (3)
> # exclusive: Test failed at step #1
> #          FAIL  hmm.hmm_device_private.exclusive
> not ok 20 hmm.hmm_device_private.exclusive
> #  RUN           hmm.hmm_device_private.exclusive_mprotect ...
> # hmm-tests.c:1727:exclusive_mprotect:Expected ret (-16) == 0 (0)
> hmm close returned (-1) fd is (3)
> # exclusive_mprotect: Test failed at step #1
> #          FAIL  hmm.hmm_device_private.exclusive_mprotect
> not ok 21 hmm.hmm_device_private.exclusive_mprotect
> #  RUN           hmm.hmm_device_private.exclusive_cow ...
> # hmm-tests.c:1780:exclusive_cow:Expected ret (-16) == 0 (0)
> hmm close returned (-1) fd is (3)
> # exclusive_cow: Test failed at step #1
> #          FAIL  hmm.hmm_device_private.exclusive_cow
> not ok 22 hmm.hmm_device_private.exclusive_cow
> 

Is the kernel compiled with support. I have the feeling that we might 
simply miss kernel support and it's not handled gracefully ...

-- 
Thanks,

David / dhildenb

