Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 672236EB07D
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Apr 2023 19:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233157AbjDURWk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Apr 2023 13:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232630AbjDURWj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Apr 2023 13:22:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E8210D1
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Apr 2023 10:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682097711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F5BUIZCZG7tWuEnNiXnezg1wpCr6XGmaYZLZ1JJftNg=;
        b=f2/2kk20U+Iop9wYx6XlW3+Hi3HdXMPy05QDDkDItx2RXUacaBuAWcCO1C/DCmhXh9Mwbo
        s0TjnDOAJMeXS6r2F38YtIvft4Zk9Sj1hG2QYoFkN7xzK83u1ZctC8NX4wtUIPbFwrAQRI
        ygHuCUEmgc4yMJBbfJ6t5Jz8aiy3WA8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-MQ27-BHYPBujYEoIIhpgqw-1; Fri, 21 Apr 2023 13:21:41 -0400
X-MC-Unique: MQ27-BHYPBujYEoIIhpgqw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f173bd0d1bso13022745e9.3
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Apr 2023 10:21:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682097699; x=1684689699;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F5BUIZCZG7tWuEnNiXnezg1wpCr6XGmaYZLZ1JJftNg=;
        b=jiIKLkDeptBvKN1v4uDUNDkdpxzNZmbHtYJwg8yq0lUgx2yhjw+ytmo9y7Y6Dpfrxr
         SGaImP8we13aQ7MJr+PPIDpfbJ2SehRGcA1Ju+FaKC3POvycK1J30/PMIMNxQ4eOqGS+
         +uKtJPiOWSCdf0Jr7+eXnftqt1kUSQYrHaWxbgXrZfypvhyJdUeeImQIPt/NW9t6nJoV
         MK6ZVfklDS+jogVLavvFY3vnx+jAcGF4OY8RDc6KTUvG1ExkBhkE1X4hvLaBL1bEW7Mt
         thdKXh6qSGrvqdTgh6yDD/NDrUGV+DIN+JyqnwFesI7KWuBaCQztkI3h2GeRNJg7kOuS
         64vQ==
X-Gm-Message-State: AAQBX9fLyxlXEjJl3Qk88vRLCTpkbCpyZ8TG/XtLlV1c5ws/7/xjAwEj
        HTj9uYLQ9XItVtrrpmKA+mrsojlVzBLm8ktPWGRykb+Cp2bVFE/4brZLjN/XdkUz++NcRP8Mbdh
        zBXWqopqEL9ar+Rhqpj/TavCmruZl
X-Received: by 2002:a05:600c:2306:b0:3f1:72ec:4016 with SMTP id 6-20020a05600c230600b003f172ec4016mr2580974wmo.0.1682097699584;
        Fri, 21 Apr 2023 10:21:39 -0700 (PDT)
X-Google-Smtp-Source: AKy350aFn+YAjtfSjCVKeXGhCWAiZWMdwsuDncB3Nwm1fVnTmqMnOAjnMKFGp80Ll5DTm/pP7pP0nA==
X-Received: by 2002:a05:600c:2306:b0:3f1:72ec:4016 with SMTP id 6-20020a05600c230600b003f172ec4016mr2580947wmo.0.1682097699200;
        Fri, 21 Apr 2023 10:21:39 -0700 (PDT)
Received: from ?IPV6:2003:cb:c717:6a00:e38f:c852:dc11:9146? (p200300cbc7176a00e38fc852dc119146.dip0.t-ipconnect.de. [2003:cb:c717:6a00:e38f:c852:dc11:9146])
        by smtp.gmail.com with ESMTPSA id g10-20020a7bc4ca000000b003f171234a08sm5302275wmk.20.2023.04.21.10.21.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Apr 2023 10:21:38 -0700 (PDT)
Message-ID: <f809162e-4adc-cf9b-35f4-0f1b098ad283@redhat.com>
Date:   Fri, 21 Apr 2023 19:21:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1 1/3] mm/ksm: unmerge and clear VM_MERGEABLE when
 setting PR_SET_MEMORY_MERGE=0
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
To:     Stefan Roesch <shr@devkernel.io>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Rik van Riel <riel@surriel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Shuah Khan <shuah@kernel.org>
References: <20230418051342.1919757-1-shr@devkernel.io>
 <20230418152849.505124-1-david@redhat.com>
 <20230418152849.505124-2-david@redhat.com>
 <qvqwr0sei6sl.fsf@devbig1114.prn1.facebook.com>
 <d476d75d-74a8-9cad-a60e-4b5ecb149719@redhat.com>
Organization: Red Hat
In-Reply-To: <d476d75d-74a8-9cad-a60e-4b5ecb149719@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

>> I understand we want to keep the name "symmetric" with
>> ksm_enable_merge_any, but it also unmerges the ksm pages. Do we want to
>> reflect that in the function name?
> 
> ksm_disable_merge_any_umerge() is suboptimal.
> 
> As ksm_disable_merge_any() now reverts what ksm_enable_merge_any() ended
> up doing, I think it's just fine.
> 
> (it would be a different story if we'd be using "set" / "clear"
> terminology instead of "enable" / "disable").
> 
> We can describe that in the comment.
> 
>>
>> Can we add a comment for the function?
> 
> Can do for symmetry with ksm_enable_merge_any().
> 

+/**
+ * ksm_disable_merge_any - Disable merging on all compatible VMA's of the mm,
+ *                        previously enabled via ksm_enable_merge_any().
+ *
+ * Disabling merging implies unmerging any merged pages, like setting
+ * MADV_UNMERGEABLE would. If unmerging fails, the whole operation fails and
+ * merging on all compatible VMA's remains enabled.
+ *
+ * @mm: Pointer to mm
+ *
+ * Returns 0 on success, otherwise error code
+ */


-- 
Thanks,

David / dhildenb

