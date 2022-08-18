Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87517598ADB
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Aug 2022 20:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbiHRSIJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 Aug 2022 14:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234570AbiHRSII (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 Aug 2022 14:08:08 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A592C5783;
        Thu, 18 Aug 2022 11:08:07 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id j2so2276801vsp.1;
        Thu, 18 Aug 2022 11:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:reply-to:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=OAWX2a0J9UdSFoklohR6ctX/AMyWKaZfgaWNcnK/+Hk=;
        b=hJaThHuu9hm6GZem0qq1z5PwLkj0QgWgx5viJsJbiD6nff9X9xFp6wEMvq8Y03Mv7s
         Br/v3LOKcQSgcuhpQo0xMWk4cjfzChxb6x1xEtDo+dFTZ/jT7tW7z28FDlqn720ODM+O
         wcEeFHvjWshG/G95UmSuT13oJ/EAYfxv80JQvuB9/YHvo/EWTXmeY2prNI8KYqH+y3QG
         yYvbIqIPqXXdlnsiDz2+pULuc3AOCU9rSgAjIyQqh0AI796Tr+0FcUBH9FTOSLKdGhjg
         HOQEvfajBArOKFYwTPcfeFTnmnFY7HHUuQK31lKwv9g8zP94AkZjv6FyguxOXMmboR4E
         SReA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:reply-to:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=OAWX2a0J9UdSFoklohR6ctX/AMyWKaZfgaWNcnK/+Hk=;
        b=q+0LGKiKkARqVfIkyi+SfOhEg4uuK4lUwDYWrzBadXTnTDGeFU1rb3qoJuAb09PKaD
         m0xQ+xNlh99yLK3/UVH/zWioVFAFQvMhoQZH1LlCUpLfmRmQ8AqCKDaezQqpfo9ConQf
         D93/vhpp6WI8ieFnS6FrirJSAowEPd939ZIMK4j4Nm1nWiZbcXNnJoMiXtuYXpRhGTkz
         SjlOSOtKEkkGNxZuKwQHvbLD3DyHsQm80FjOvuRju3e/HSwPkzP+bQrPnqwhx+epIbXe
         6pC5sERFheHP7z1ayR8kHHCB270czLCLgVHpF/EUjF+8FCEnb/fw9MOJPmGeiIpWDP5y
         A85A==
X-Gm-Message-State: ACgBeo3+qVF1yShaGhSiVWg4urR2hJpdnYTzDc0UJsiAocUWE7/S/v2H
        kRJOwGSBcHxvteJ18wxt1jrEHUUa/0c=
X-Google-Smtp-Source: AA6agR4YU9RHEL+lvLA1KINcu25sNsEjLFnyD1APl8y1JOi18TnKgj697XDc7uOtCTSjhD5gkZUptw==
X-Received: by 2002:a67:ec02:0:b0:387:8a2a:fe72 with SMTP id d2-20020a67ec02000000b003878a2afe72mr1674745vso.1.1660846086405;
        Thu, 18 Aug 2022 11:08:06 -0700 (PDT)
Received: from ?IPV6:2804:14c:4c2:8202::1001? ([2804:14c:4c2:8202::1001])
        by smtp.gmail.com with ESMTPSA id n1-20020ab05401000000b003844b2e1462sm1215263uaa.13.2022.08.18.11.08.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 11:08:05 -0700 (PDT)
Message-ID: <443632b6-c589-ef62-2385-3e8406680343@gmail.com>
Date:   Thu, 18 Aug 2022 15:08:01 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: Running kunit tests on platform devices
Content-Language: en-US
To:     Ramon Fried <rfried.dev@gmail.com>, David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <CAGi-RUKv-8zyku-3pjXdjxbyMP_X_YV5rd6y2wyaCOJJ9UOQAw@mail.gmail.com>
 <CABVgOSnxa=H5A-0U0QRCAv+OWCGb0zN_f7gP5FmhGjRy7NCUSw@mail.gmail.com>
 <CAGi-RUL46gA_0ah_TTJVpc9RRS8nvd7yoqt=OLXxvUjL6TAvyQ@mail.gmail.com>
Reply-To: CAGi-RUL46gA_0ah_TTJVpc9RRS8nvd7yoqt=OLXxvUjL6TAvyQ@mail.gmail.com
From:   Tales Lelo da Aparecida <tales.aparecida@gmail.com>
In-Reply-To: <CAGi-RUL46gA_0ah_TTJVpc9RRS8nvd7yoqt=OLXxvUjL6TAvyQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 17/08/2022 09:19, Ramon Fried wrote:
> On Wed, Aug 17, 2022 at 7:43 AM David Gow <davidgow@google.com> wrote:
>>
>> On Mon, Aug 15, 2022 at 5:16 PM Ramon Fried <rfried.dev@gmail.com> wrote:
>>>
>>> Hi.
>>> I implemented a test suite that checks a platform driver, that's the
>>> only way I can test interrupts behavior in the code.
>>> Because it's a platform, I can't use kunit_test_suite(), so I call
>>> __kunit_test_suites_init() as part of the platform driver probe
>>> function.
>>>
>>> This works fine but has the following problems.
>>> "TAP version 14" string is not printed and it's impossible to parse
>>> the results using the script.
>>> In addition, the suite is not displayed in /sys/kernel/debug/kunit.
>>>
>>> It would be my pleasure to provide a patch that fixes this, I just
>>> wanted to make sure that my testing strategy makes sense.
>>>
>>> Thanks,
>>> Ramon
>>>
>> Hi Ramon,
>>
>> Thanks for reaching out. Calling __kunit_test_suites_init() directly
>> is not something we'd recommend (and are trying desperately to remove
>> existing uses), so several of the issues re: the "TAP version 14"
>> string et al are side effects of calling what is supposed to be an
>> internal KUnit function manually.
>>
>> That being said, we definitely do want to make testing platform
>> drivers as convenient as possible. I'm not sure why kunit_test_suite()
>> doesn't work for you for platform drivers: are you just missing some
>> way of instantiating the device from within a test context?
>>
>> I know Brendan has experimented with some hardware faking code, for
>> which there's some example use here:
>> https://kunit-review.googlesource.com/c/linux/+/5275
>> (Note that you'll need to look at the other patches in the 'relation
>> chain' for dependencies.)
>>
>> Equally, I've experimented a bit with testing old soundcard drivers
>> (via a platform device) here, which may be an easier way to look
>> through:
>> https://github.com/sulix/linux/commit/4e1620c86553b9edde7f032318cf417dc13e4d26
>>
>> Note that neither of those examples are anything other than
>> experiments, so may not work as-is, or be ideal.
>>
>> Otherwise, we're always happy to accept patches, though again, if
>> there's any way of getting your tests working without a direct call to
>> __kunit_test_suites_init() --- even if that would require patches to
>> work --- that'd be preferable on our end.
>>
>> Cheers,
>> -- David
> Hi David,
> Thanks for replying.
> I looked at the examples you shared, and they all fake the actual device.
> My intention is to actually interact with the real device. - get a
> real interrupt, etc.
> Is it wrong, was the intention that the platform device be mocked ?
> Thanks,
> Ramon.
> 

Hi, Ramon,

I particularly don't condemn writing tests that require hardware, but 
they're best avoided, mostly to facilitate running those tests.

Can you share your code?
I would be happy to take a look if its not a problem for you!

Kind regards,
Tales
