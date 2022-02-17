Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0B3D4BA740
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Feb 2022 18:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236605AbiBQRgf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Feb 2022 12:36:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233182AbiBQRge (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Feb 2022 12:36:34 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4322B357C
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Feb 2022 09:36:20 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id d3so2792086ilr.10
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Feb 2022 09:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IDkmkuICMD0GBUFdglrzboVl2xOTROzNihfxF3HUYOI=;
        b=LUz6HJnAr3QvZg7fZl1dRg6z+fbryWq7p15eSxwfbqvBhNyopS2Dsm7YKI5Y5r5NaN
         NFaoV8M/WfR96MNLj49SeNp9/Qbyoh9iTM29qW/C8/RgDbEs+gJEw/kjkUOSJIkAxzlz
         qL5YLStcIK/6wHU46yAbTfFw6bEE0Ffm44UhU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IDkmkuICMD0GBUFdglrzboVl2xOTROzNihfxF3HUYOI=;
        b=DPxlJpQ6kysCzdLna3ewqjro/HEWzlt/KCXruAF+ZryXI15MyqTyKa6P+uBn3wi7kK
         aw7D1EnJNEHahy+YsIcst+tZdCuvP7rrgYN6NrAwgcVmnYJET5NIwtyhPSWbaLhvtB2D
         Nf5dquiC/bhJMm7FSRLzjcVqvB3HZIsHmYxpdEQ7i8i1TaKhxr+TQSd3zPNpSZro0zjW
         e2dvigmsTgxvNWGKCsWDk0q9FgQ49qj0R9/P9YqS0JhVwcj3wrmFJMvXGVtOCPzi99p6
         HqtbZqv9xETp0iAZNCzRdcoh3Sq95qLwZOCvUATVF1tutQMahMzSqvp+6ZwokCUPe1mV
         wbFg==
X-Gm-Message-State: AOAM533QTbleO84afNTfn9kqTwkDTB7s/LLh/xsKYfjUhCqQeKb5MQAJ
        zeglOMLZxdvjJKLUhNT+KgWGBQ==
X-Google-Smtp-Source: ABdhPJykB0DMj9uLVBhuDfqDOeURZhtb+jbGA7GfSaBsNbhqhdUIkXyg6L0cpXMjTz4lGIh5w5nc4g==
X-Received: by 2002:a92:dc44:0:b0:2bf:adaa:7a2a with SMTP id x4-20020a92dc44000000b002bfadaa7a2amr2707205ilq.172.1645119379738;
        Thu, 17 Feb 2022 09:36:19 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id u26sm2200082ior.52.2022.02.17.09.36.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 09:36:19 -0800 (PST)
Subject: Re: [PATCH 1/2] KVM: s390: selftests: Refactor memop test
To:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     Thomas Huth <thuth@redhat.com>,
        David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220211182215.2730017-11-scgl@linux.ibm.com>
 <20220217145336.1794778-1-scgl@linux.ibm.com>
 <20220217145336.1794778-2-scgl@linux.ibm.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <ce27dcb4-c2a3-fad6-8277-f5b86e184892@linuxfoundation.org>
Date:   Thu, 17 Feb 2022 10:36:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220217145336.1794778-2-scgl@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/17/22 7:53 AM, Janis Schoetterl-Glausch wrote:
> Introduce macro for performing MEM_OP ioctls in a concise way.

How does this help? What is the value in re-writing existing
code and turning it into a macro?


> Split test cases into multiple host/guest pairs making them independent.

This is a good change.

> Make various minor improvements.
> All in all this lays the groundwork for future extensions.

Also good if these changes make it easier to add test. Would be helpful
to know the details of the groundwork.

thanks,
-- Shuah
