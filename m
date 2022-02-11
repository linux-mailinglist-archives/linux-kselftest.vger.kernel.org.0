Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 436974B2BD6
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Feb 2022 18:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352203AbiBKRfD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Feb 2022 12:35:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352196AbiBKRfC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Feb 2022 12:35:02 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7AF0394
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Feb 2022 09:35:00 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id 9so12315436iou.2
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Feb 2022 09:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3y3ZqDwsG6/xpgo7xYF8Kerepsmj4Eg2hbYokFo3OCg=;
        b=PHVeyVHZm8DBHiE5NRaHNa7haxj+ubLGauBB22za9XGtIABUj6n5UOw+IgyQgITzrh
         h6CGdL4yZywA0xAPsQexxKRI8wW/mBQXjVtyauZOIg6huF+lmotsUBZao/FT8eIeCAid
         ameV//8NSGivd6/ckYpavJZbZJ/7zfRXgExQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3y3ZqDwsG6/xpgo7xYF8Kerepsmj4Eg2hbYokFo3OCg=;
        b=LEvFB91uS74vT+31e3zaOYloNqC47yBr5sHKfUkRLmacP3AVVLStJTxJaDXWJETMhU
         pGOCBdA5lQ4SYSDsiELJYNZ7LuXz8C1x+L6xAU9SEXhmOY3xmmAq7oq9zbBDE88B5d2T
         /p0A+cgSnbGdeg0Oxsiy3XbvPNyzLolHM6PbnKd4tHkcI0ErIqYKykoulsyoDHxldH8Q
         ED/jdUKYtHizuT9j+u1P46NE2jJNzRYp05+NkNgpTQuVMHQUDEUU3G7CNoilmnO4M62p
         oQALSPXshQ/h79S8qtFj/i6xJRO4cYoncpZBmRmzpaAEAPij1OF7n57fAYTv07KQwZWc
         wyDA==
X-Gm-Message-State: AOAM531VyFp8oUZHMevZYcazrBNBE0FBJvNoIfIr1+4S/FVGIULM/akB
        qUl/Fti+37JK0hFip8zoqjUODQ==
X-Google-Smtp-Source: ABdhPJy5vyKsT+NXq6m6zR89mQnYdjgr3vCjLRSWFAoUsnfJJlVwFI0nBt0mNeRSwRS6jhXzPS9J8A==
X-Received: by 2002:a5d:9b15:: with SMTP id y21mr1416916ion.108.1644600900141;
        Fri, 11 Feb 2022 09:35:00 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id y7sm6959042ila.7.2022.02.11.09.34.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Feb 2022 09:34:59 -0800 (PST)
Subject: Re: [PATCH V2] selftests: kvm: Remove absent target file
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Shuah Khan <shuah@kernel.org>, Peter Gonda <pgonda@google.com>
Cc:     kernel@collabora.com, kernelci@groups.io,
        "kernelci.org bot" <bot@kernelci.org>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220210172352.1317554-1-usama.anjum@collabora.com>
 <f9893f6a-b68b-e759-54f5-eef73e8a9eef@linuxfoundation.org>
 <eb4e24c6-41d0-4f3a-2af0-3008db408da6@redhat.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <9198c43b-e5e2-fa58-5862-598dc7019ad6@linuxfoundation.org>
Date:   Fri, 11 Feb 2022 10:34:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <eb4e24c6-41d0-4f3a-2af0-3008db408da6@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/10/22 11:56 AM, Paolo Bonzini wrote:
> On 2/10/22 19:02, Shuah Khan wrote:
>>
>> I am fine with the change itself. For this patch:
>>
>> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
>>
>> However, are we missing a vmx_pi_mmio_test and that test needs to be added.
>>
>> Just in case the test didn't make it into the 6a58150859fd and the intent
>> was to add it - hence the Makefile addition? This can be addressed in
>> another patch. Just want to make sure we aren't missing a test.
> 
> This was probably a rebase resolution issue.  The vmx_pi_mmio_test fails in the mainline tree, and is lingering in my tree together with the fix because somebody promised a better fix for it.  I included the TEST_GEN_PROGS_x86_64 line by mistake when rebasing Peter Gonda's test below vmx_pi_mmio_test.
> 
> Thanks for the fix,
> 
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
> 

Paolo,

Thank you for explaining the discrepancy. Would you like take
this through your tree? This patch depends on

commit: de1956f48543e90f94b1194395f33140898b39b2

thanks,
-- Shuah
