Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6195F1ADC
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Oct 2022 10:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiJAINt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 1 Oct 2022 04:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiJAINs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 1 Oct 2022 04:13:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066AB195D4A
        for <linux-kselftest@vger.kernel.org>; Sat,  1 Oct 2022 01:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664612026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M08d8mMJzKqyE4XeCsUdHwS/W+NoO/HZQNW27SDN4Bo=;
        b=et3Mc9qFOJskwP8kgWy/6R1YF2ADYUDgjq0FUNqSqWWj3zZORMkH5wFQFHTMrjX43+Gz5e
        OQL155FBaRaCQd9vHRfu493A3A+oTyCG/mfsr1FzyJ/wplyzmGx8X48tkz66BUkLjYudWw
        qvBQSFByk5XOExPn9BNnR+FYlExzXAI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-562-Ta6CVEGqOxqgn7ZAZCQ05Q-1; Sat, 01 Oct 2022 04:13:44 -0400
X-MC-Unique: Ta6CVEGqOxqgn7ZAZCQ05Q-1
Received: by mail-wm1-f69.google.com with SMTP id h187-20020a1c21c4000000b003b51369ff1bso5640934wmh.3
        for <linux-kselftest@vger.kernel.org>; Sat, 01 Oct 2022 01:13:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=M08d8mMJzKqyE4XeCsUdHwS/W+NoO/HZQNW27SDN4Bo=;
        b=Uj0pnh94aaYdcfkDSnHcH/sHKchnD8zmMHJI+zWHmf8YFDqHTKgy58LBhVX7m44JDl
         UwkVPHx0cmuDQPYzcM+mskrCe7lr3Q4zpgKGQAKXxW78MlT8HI9C1nIVc1VEb/cOZA61
         kBFkI64Bb3qog98JyuLxKaao59IBAuhksU++JoUSijMQOAkvkf2y8dl1d7KlW4Y7drv4
         mWPln48B9Sy0GLblWAHS7MXhlx/Obot4xOuBQE6+H7xYeueF7HLKbnu0LmzUJM14YVNM
         +vzoIQH6kLd5IKF7uP7tAEvxEnRtKdWPo2icDAguGeHT00jcZ9e2OdkxtNmlFqAWAp+v
         EMbw==
X-Gm-Message-State: ACrzQf2pFMe8lGHvPqAZ4XYh5Wvq/XWmH+fbffMSoPVIWEpV6USrgHJX
        8ecolq8pFCSSeg+H2s9yTx19q1FII4KORLrFTEbvADpFh6Ld/kVNiLNlr5eLRIcCKD8fY/2DAoQ
        p5L5F5oxPIo3Kfj+dgll6YFUi/Ej4
X-Received: by 2002:a5d:414c:0:b0:22c:de8a:d233 with SMTP id c12-20020a5d414c000000b0022cde8ad233mr5789673wrq.194.1664612023736;
        Sat, 01 Oct 2022 01:13:43 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM59J3GMiF+4a1a0pX2sMbyZVeGafvQfLvRP8m46tATdItS6jpn5p/0CVb+9uH6Ql4pCwB6UDw==
X-Received: by 2002:a5d:414c:0:b0:22c:de8a:d233 with SMTP id c12-20020a5d414c000000b0022cde8ad233mr5789640wrq.194.1664612023379;
        Sat, 01 Oct 2022 01:13:43 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71e:300:9aa5:eac5:37df:f14? (p200300cbc71e03009aa5eac537df0f14.dip0.t-ipconnect.de. [2003:cb:c71e:300:9aa5:eac5:37df:f14])
        by smtp.gmail.com with ESMTPSA id u8-20020a5d5148000000b0022e04bfa661sm3010049wrt.59.2022.10.01.01.13.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Oct 2022 01:13:43 -0700 (PDT)
Message-ID: <e9d19ba0-2a92-02a1-3f1f-e21f65d2a3c5@redhat.com>
Date:   Sat, 1 Oct 2022 10:13:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v1 4/7] mm/ksm: fix KSM COW breaking with userfaultfd-wp
 via FAULT_FLAG_UNSHARE
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
References: <20220930141931.174362-1-david@redhat.com>
 <20220930141931.174362-5-david@redhat.com>
 <20220930152742.55ee9c25b89ba483ec211be8@linux-foundation.org>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220930152742.55ee9c25b89ba483ec211be8@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 01.10.22 00:27, Andrew Morton wrote:
> On Fri, 30 Sep 2022 16:19:28 +0200 David Hildenbrand <david@redhat.com> wrote:
> 
>> Let's stop breaking COW via a fake write fault and let's use
>> FAULT_FLAG_UNSHARE instead. This avoids any wrong side effects of the fake
>> write fault, such as mapping the PTE writable and marking the pte
>> dirty/softdirty.
>>
>> Also, this fixes KSM interaction with userfaultfd-wp: when we have a KSM
>> page that's write-protected by userfaultfd, break_ksm()->handle_mm_fault()
>> will fail with VM_FAULT_SIGBUS and will simpy return in break_ksm() with 0.
>> The warning in dmesg indicates this wrong handling:
> 
> We're at -rc7.  I'd prefer to avoid merging larger patchsets at this
> time.

Yes, this is 6.1 material.

> 
> Is there some minimal fix for 6.0 and -stable?  Or is the problem
> non-serious enough to only fix it in 6.1 and later?
> 

See the end of this lengthy patch description:

"This is primarily a fix for KSM+userfaultfd-wp, however, the fake write
fault was always questionable. As this fix is not easy to backport and 
it's not very critical, let's not cc stable."

This can wait, thanks!

-- 
Thanks,

David / dhildenb

