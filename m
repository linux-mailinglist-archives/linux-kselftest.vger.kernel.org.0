Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F6C654FC5
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Dec 2022 12:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbiLWLhS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 23 Dec 2022 06:37:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiLWLhP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 23 Dec 2022 06:37:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97622BF64
        for <linux-kselftest@vger.kernel.org>; Fri, 23 Dec 2022 03:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671795387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qZVGgPTNWGADuWoZI7HOeF7SAOUCre/9YcTHNf70vXc=;
        b=H6HHVdQnzUe1ZS7vtRza/lStOFKvYvS6BCIk6E0UKQyP3HVwWhKUlWsu2aRkeo+lbjCRK7
        r/vFjMOo/f9CbbP+AZADBrGNa4sf+H4J014hLt2uBmOMEzfmrCEBMIyiBofNLQ3ZqrMETJ
        4SN0d0ZOa35oITRCSfjvb7biTC/FJgw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-516-4TK-Uv-nPae-zuK6MI5CHw-1; Fri, 23 Dec 2022 06:36:26 -0500
X-MC-Unique: 4TK-Uv-nPae-zuK6MI5CHw-1
Received: by mail-wm1-f70.google.com with SMTP id f20-20020a7bc8d4000000b003d1cda5bd6fso1087235wml.9
        for <linux-kselftest@vger.kernel.org>; Fri, 23 Dec 2022 03:36:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qZVGgPTNWGADuWoZI7HOeF7SAOUCre/9YcTHNf70vXc=;
        b=usRkrzdcrQwqhLJD7wNNdrzxMkwrOCYvGjECVRbKBZ1UWTlyv0jQTyK+LzQKgaXrNT
         EYgpIeIb7oNLqPseetxg1Z3bILMSguFektqEEu4615BNhYwv45ZG1A8YgjC2SOUF5WUa
         hG+Qrrn/WOTrmoCzjMUXePYlH/sgUqdh0gicVOLpSFyI+KEJ7FUFcWMKOBSQEQMIHrmf
         gIu926RzU9m10lTvTgUYuEiQd9s6vl4QWcbagun0qhigmERTPdfRWaOtRh/pb5g/jxMu
         ij7gBuOOKvHjXP0v82Pyhf3hEwWObmlDxBS/lwrOWBA1tIoQN253vW1bgLQBDlgZRazI
         +JOA==
X-Gm-Message-State: AFqh2kojJW4OP0UQQgK9gQcm2CFi7nTSHPHzF0nXsOQKo47dO2BKhHRh
        ronl6cUqqQQnYdbB9CsPl7D75O6fyeMPLflPFvq1HToqQ3XvWasHkareb00uETsCxbpucWHpAAk
        jYHhGs2fPZgdm5jY0szdGXSe/qVnO
X-Received: by 2002:a05:600c:35d1:b0:3d3:58d1:2588 with SMTP id r17-20020a05600c35d100b003d358d12588mr6708987wmq.41.1671795385326;
        Fri, 23 Dec 2022 03:36:25 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtkPN6eEWxTrC7lLZcH+iG3j7l0iPTvyPOAXtFD27IisrlURCW2ZiUXzav5J0iZsvhIwf0Ndw==
X-Received: by 2002:a05:600c:35d1:b0:3d3:58d1:2588 with SMTP id r17-20020a05600c35d100b003d358d12588mr6708968wmq.41.1671795385026;
        Fri, 23 Dec 2022 03:36:25 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:ab00:3d8e:16c4:a38d:2827? (p200300cbc707ab003d8e16c4a38d2827.dip0.t-ipconnect.de. [2003:cb:c707:ab00:3d8e:16c4:a38d:2827])
        by smtp.gmail.com with ESMTPSA id x15-20020a1c7c0f000000b003c6bbe910fdsm11462465wmc.9.2022.12.23.03.36.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Dec 2022 03:36:24 -0800 (PST)
Message-ID: <199991ec-bcd4-35b4-6835-0f1f13e11457@redhat.com>
Date:   Fri, 23 Dec 2022 12:36:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH linux-next] selftests/vm: ksm_functional_tests: fix a typo
 in comment
Content-Language: en-US
To:     yang.yang29@zte.com.cn, akpm@linux-foundation.org
Cc:     shuah@kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        xu.panda@zte.com.cn, xu.xin16@zte.com.cn
References: <202212231050245952617@zte.com.cn>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <202212231050245952617@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 23.12.22 03:50, yang.yang29@zte.com.cn wrote:
> From: Xu Panda <xu.panda@zte.com.cn>
> 
> Fix a typo of "comaring" which should be "comparing".
> 
> Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
> Signed-off-by: xu xin <xu.xin16@zte.com.cn>

Two people to fix a typo, wow. :)

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

