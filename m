Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A50F66DE45E
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Apr 2023 20:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjDKSyg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Apr 2023 14:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjDKSyf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Apr 2023 14:54:35 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E06930C0
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Apr 2023 11:54:31 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-32931475169so56645ab.0
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Apr 2023 11:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1681239270;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZV1VFO4BwOGmTu5eeP/n7pt3iT6IE643agWTPuh3G3Q=;
        b=DaVl9mSDc2bA1XJpVY/OPzKb4MvDhkvQlDbt5I/XunPwitCBKGSX1bEpm/5dM2k+Xi
         ml3kg+m66A57SjWHLnEOrJCnNTBeufUP4scPzA+IJza7ycm5cZIeSpuNACLxoEMwnVVx
         vd9R58YLw57t/FfCiuhKBKh0hv73g0bE3s2yo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681239270;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZV1VFO4BwOGmTu5eeP/n7pt3iT6IE643agWTPuh3G3Q=;
        b=TS5PAMNZnREjmiB358wUAJ4bal1Fkx3vfJt8d12DT2TjS6DnFkgPlSNQYG3OQ7KFuS
         dK+6AQd56KoyMT6iqHtnYqVK5TmfCstY+MkyXasfSxrD77MoUWOtWS2biMMpeV3ZvWez
         2Wqo0GQxPPm8wKfrvoFSzu0Luau4Q0/CpC+CGWH8pspoCbtVvxBc7ScyMSgj5u5rFz6k
         us8+C8VBhW59WmxtbjMayrxbckilkUD0Z2gshW6qPrgazFCBQzfkDEgNwaPWQY2M8oCN
         E/GwQ6a3ZP0sYjVds38TkNnkxMLMR4sgIXHDI8RF+xfrNbK7AYwXh+0jVMvl/Ph1Z8/7
         Mpjw==
X-Gm-Message-State: AAQBX9ceci4+xvt8ntTP4Dgx8FNj3+WWBgjrfb3kIP4jAa6wNiLw9JHY
        LsG34tx31RddEK1lC/33J2sM/A==
X-Google-Smtp-Source: AKy350YXICKD5X2IKxUuBIcAPBrrCjd+CmVQG6MMNHZTmReDEB8r7kzQBe0IDZV9T2VfGHNp3b/mfA==
X-Received: by 2002:a05:6e02:12c9:b0:326:3b2e:95b1 with SMTP id i9-20020a056e0212c900b003263b2e95b1mr83576ilm.2.1681239270390;
        Tue, 11 Apr 2023 11:54:30 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id i4-20020a056638380400b00408d59eccdcsm4218785jav.20.2023.04.11.11.54.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 11:54:29 -0700 (PDT)
Message-ID: <e81d0c3b-f301-e2cf-077d-fe9a934e7590@linuxfoundation.org>
Date:   Tue, 11 Apr 2023 12:54:29 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 1/3] tools/nolibc/stdio: Implement vprintf()
Content-Language: en-US
To:     paulmck@kernel.org, Mark Brown <broonie@kernel.org>
Cc:     Will Deacon <will@kernel.org>, Willy Tarreau <w@1wt.eu>,
        Shuah Khan <shuah@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230405-kselftest-nolibc-v2-0-2ac2495814b5@kernel.org>
 <20230405-kselftest-nolibc-v2-1-2ac2495814b5@kernel.org>
 <ZC8OwUPAC4s413jP@1wt.eu>
 <cbece9a0-b8d0-4f3e-9a55-9fe87e111392@paulmck-laptop>
 <fc52d5c1-61db-b8e3-e608-12434b0ee740@linuxfoundation.org>
 <9dfb88e8-2a61-47a8-876e-581e4c717217@sirena.org.uk>
 <20230411150320.GA23045@willie-the-truck>
 <0144ab97-f34a-4803-8fdb-52340f2d73f2@sirena.org.uk>
 <6a323775-6274-4d0c-844a-da53146c2abe@paulmck-laptop>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <6a323775-6274-4d0c-844a-da53146c2abe@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/11/23 10:44, Paul E. McKenney wrote:
> On Tue, Apr 11, 2023 at 04:13:11PM +0100, Mark Brown wrote:
>> On Tue, Apr 11, 2023 at 04:03:21PM +0100, Will Deacon wrote:
>>> On Tue, Apr 11, 2023 at 03:31:10PM +0100, Mark Brown wrote:
>>
>>>> It seems like more of a kselftest change than anything else so probably
>>>> makes sense for it to go that way?  The example user isn't really even
>>>> needed.
>>
>>> Fine by me, as long as it doesn't conflict with any other arm64 selftest
>>> changes you hope to land for 6.4.
>>
>> That shouldn't be an issue.
> 
> Shuah, looks to me like this one is yours in kselftest, then.  ;-)
> 
> 							Thanx, Paul

I will pick these up for Linux 6.4
thanks,
-- Shuah
