Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBE84D2315
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Mar 2022 22:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350399AbiCHVND (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Mar 2022 16:13:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350362AbiCHVM4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Mar 2022 16:12:56 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD8849C8D
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Mar 2022 13:11:59 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id r2so517754iod.9
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Mar 2022 13:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zUVnJnwEjZJL8+dTPwpcunjYHDxh5zugyYiBWwMQA2A=;
        b=g9LiXm6RT5fB+mpR2lm+xjC/c5lIobrltaz1yuBf5SbMwKRiVkDbkB5DbElkN6S4kV
         xfTn5sXFyYuZjuCxCeczalTm5mehEO7knOY8Cu1AIpNdq5601KfMvYmLufC38B2VFU1o
         CQbEOzg/CF2VchBeLVx9ohrMKnj2xn8+dPmFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zUVnJnwEjZJL8+dTPwpcunjYHDxh5zugyYiBWwMQA2A=;
        b=kvIW9LyKvsTCifpGUnEeZlFbfc3974521SQ/0A+mcKKGS2NIkGacVTxOFMPIxXkbLx
         AgY09gzXqITtWWzIUPqE7q7+Fko/lKZ9Zw8gVqWYu977KEIfqAohsxu7fQoGGcfhqz+a
         rx4PIStTQrao5LEzRjgiCeeoM2g04RiQYWUL+iY94/3GD6iz0hf2NL7HoKV47BxmNQ9y
         DMDtgVzrdBRClFHzIodAgxD3NyZqk13FtaW3y9MxRkqmRRxrGQw3T70JpnxRzaE1Xo/J
         XClnvkLZ0Kc6u/ZSsRfmE4czonJQg0Tato2/xM4/DLxsu5fneFSQd004Ps/s8Wvw3/t7
         AXpA==
X-Gm-Message-State: AOAM532PvNfnNCItWjRz0hF29duxu3JX3q2EaPnsVsWyGhx98Ra9omiB
        FPetmsp9DvIPD/A8yJ/gfvWmNA==
X-Google-Smtp-Source: ABdhPJyBA2wcvXs7S3mxVqp6cnAQV/Mbubzkk/N+FL/TulH4fzCJVRqtLp3n+0i07K+uAzltY3t45w==
X-Received: by 2002:a02:6022:0:b0:317:c6ee:c3dd with SMTP id i34-20020a026022000000b00317c6eec3ddmr9742697jac.91.1646773918579;
        Tue, 08 Mar 2022 13:11:58 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id d8-20020a056e021c4800b002c6467c0c8bsm3878003ilg.51.2022.03.08.13.11.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 13:11:58 -0800 (PST)
Subject: Re: [PATCH v2 0/5] memop selftest for storage key checking
To:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janis Schoetterl-Glausch <scgl@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Thomas Huth <thuth@redhat.com>,
        David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220211182215.2730017-11-scgl@linux.ibm.com>
 <20220225155311.3540514-1-scgl@linux.ibm.com>
 <821e840f-c167-611a-e954-38173a90c0a5@linux.ibm.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <26357218-22b1-9622-83b6-4a5d9d6224e3@linuxfoundation.org>
Date:   Tue, 8 Mar 2022 14:11:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <821e840f-c167-611a-e954-38173a90c0a5@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/8/22 3:16 AM, Christian Borntraeger wrote:
> Can you send this as a separate thread (not inside the original thread). Otherwise things like b4 get confused and people might also overlook this.
> 
> 

+1 - I missed the v2 until now.

> Am 25.02.22 um 16:53 schrieb Janis Schoetterl-Glausch:
>> Refactor memop selftest and add tests.
>> Add storage key tests, both for success as well as failure cases.
>> Similarly test both vcpu and vm ioctls.
>>
>> v1 -> v2
>>   * restructure commits
>>   * get rid of test_* wrapper functions that hid vm.vm
>>   * minor changes
>>

thanks,
-- Shuah


