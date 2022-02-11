Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5EA4B2BE3
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Feb 2022 18:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352229AbiBKRhf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Feb 2022 12:37:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352225AbiBKRhf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Feb 2022 12:37:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AC581397
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Feb 2022 09:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644601052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lb+5m3UkvEcY0i6pZfp3uff/KtF/0biJeSNgO+ZhLKc=;
        b=B2a7BOywXMwk5FHx9FLZrFWHH9xc11A656TSlLqDMoJqyyIWNpGLfV+HVNYYxshThYT2CS
        /yA1WR2lZEDrPa9zcnly4KcUZc6uE3eUiEcg0CrUw6t3qcCom4wSWTXEBeBNJUVMs67MsP
        zjyX3gyj6TePjPXdL8aMKdZuiGG2t3Q=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-19-57-tVjuqM9C6g56Seg5Dlg-1; Fri, 11 Feb 2022 12:37:31 -0500
X-MC-Unique: 57-tVjuqM9C6g56Seg5Dlg-1
Received: by mail-ej1-f70.google.com with SMTP id o7-20020a170906860700b006cbe6deec1bso4380736ejx.22
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Feb 2022 09:37:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Lb+5m3UkvEcY0i6pZfp3uff/KtF/0biJeSNgO+ZhLKc=;
        b=C+XzFLocWI7Jo/IRen02MND03CEj7Cp6WWyl3pfQeU4QWed/m4eh8M1zoEv6rqItro
         oJbXrPY5whS6v6QU9NHmQea9o3+tf1zDO2Ewc0A013vhPhSawB83jgUV8zrkAUuT464x
         UBSqO2xudHTYuvieGUI8OQmy7E0k48NYSosI2LMkw2owa+mgQZlQ5l/ttLOR0GwxVK1b
         4F1c5gmooQmBS3p729Fp4fWPvSWLyefRkM+W3XELjlriHa+aU8izzVWQiGhybwOy+SgS
         7NieYsfbkmEvHC2yNE0SeoS3kCT+vLO3FZXdu4uK0bcdl9FRNtqpyFvZAgm4vvDgr7P9
         Un1Q==
X-Gm-Message-State: AOAM530cMltrH6VBoti3sdPHbyclK6lBWWKH3ABkYRQk/pknYVk4AIMb
        wv9vMtkzBvoG+6VqOBwf2OYIWSoXMWRpVtUL//7dPKGQIr/8ivQdCd/Btz0M44guTxJ5ZshRqW2
        xv01DsjcVYBezBc0P86hRVNfR7PJO
X-Received: by 2002:a17:906:b116:: with SMTP id u22mr2339321ejy.427.1644601049751;
        Fri, 11 Feb 2022 09:37:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJysRgOQX6h5hRe6xafAimOWoRs3+jppMqkGmJ61EpELY50wNI9nETyBQTfyjx9OM1/mztWdtg==
X-Received: by 2002:a17:906:b116:: with SMTP id u22mr2339244ejy.427.1644601048751;
        Fri, 11 Feb 2022 09:37:28 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.googlemail.com with ESMTPSA id e4sm1062414ejm.116.2022.02.11.09.37.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Feb 2022 09:37:28 -0800 (PST)
Message-ID: <e9f1166d-78a0-1806-42bb-03f2e1671128@redhat.com>
Date:   Fri, 11 Feb 2022 18:37:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V2] selftests: kvm: Remove absent target file
Content-Language: en-US
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Shuah Khan <shuah@kernel.org>, Peter Gonda <pgonda@google.com>
Cc:     kernel@collabora.com, kernelci@groups.io,
        "kernelci.org bot" <bot@kernelci.org>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220210172352.1317554-1-usama.anjum@collabora.com>
 <f9893f6a-b68b-e759-54f5-eef73e8a9eef@linuxfoundation.org>
 <eb4e24c6-41d0-4f3a-2af0-3008db408da6@redhat.com>
 <9198c43b-e5e2-fa58-5862-598dc7019ad6@linuxfoundation.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <9198c43b-e5e2-fa58-5862-598dc7019ad6@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/11/22 18:34, Shuah Khan wrote:
> On 2/10/22 11:56 AM, Paolo Bonzini wrote:
>> On 2/10/22 19:02, Shuah Khan wrote:
>>>
>>> I am fine with the change itself. For this patch:
>>>
>>> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
>>>
>>> However, are we missing a vmx_pi_mmio_test and that test needs to be 
>>> added.
>>>
>>> Just in case the test didn't make it into the 6a58150859fd and the 
>>> intent
>>> was to add it - hence the Makefile addition? This can be addressed in
>>> another patch. Just want to make sure we aren't missing a test.
>>
>> This was probably a rebase resolution issue.  The vmx_pi_mmio_test 
>> fails in the mainline tree, and is lingering in my tree together with 
>> the fix because somebody promised a better fix for it.  I included the 
>> TEST_GEN_PROGS_x86_64 line by mistake when rebasing Peter Gonda's test 
>> below vmx_pi_mmio_test.
>>
>> Thanks for the fix,
>>
>> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
>>
> 
> Paolo,
> 
> Thank you for explaining the discrepancy. Would you like take
> this through your tree? This patch depends on
> 
> commit: de1956f48543e90f94b1194395f33140898b39b2

Yes, of course.  Queued now.

Paolo

