Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73DB564410C
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Dec 2022 11:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbiLFKMP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Dec 2022 05:12:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233776AbiLFKLn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Dec 2022 05:11:43 -0500
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056B6FE9;
        Tue,  6 Dec 2022 02:07:41 -0800 (PST)
Received: from [192.168.192.83] (unknown [50.47.134.245])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id EB13C3F12A;
        Tue,  6 Dec 2022 10:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1670321257;
        bh=nplTo9ZKBIapoAm8/cSHXWQq2fSo+p21HcrD9WDHSSI=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=ewCF4cARfYQx42U+vjs8pcyJ5ceRclU0esL78RuH/6PPwmYrIYvzlODDV1AZTz4XZ
         WD9GvlE/h92slGtznwwNsMgshqU4NinourDR2pAzdHud5VydNbQ+Ahli02vko0ov3h
         cruLsaTIDORASyxxWmUldtq/9kN5IrgeutO5AIO0yZ08Mhvf22TxmJr9b61HLd4AhM
         T4wUYEV+E04U/IAMucOP2gVBfhVtaRKP1Gc3ixncNsmPjEdlsQSmP9Z+BE6gr9/MOi
         x1IL6cPUuhvcazAF7cdno2GKnkN3EesMGtwmDaTUgf3A8OJiGki2FogFyV/ywUaR7C
         StNl1GMHofb8w==
Message-ID: <45a7a499-bf80-7cdf-6db8-4792f8bfb7a0@canonical.com>
Date:   Tue, 6 Dec 2022 02:07:33 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 1/2] kunit: add macro to allow conditionally exposing
 static symbols to tests
Content-Language: en-US
To:     David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Cc:     brendanhiggins@google.com, dlatypov@google.com,
        skhan@linuxfoundation.org, tales.aparecida@gmail.com,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, apparmor@lists.ubuntu.com
References: <20221205215058.143688-1-rmoar@google.com>
 <20221205215058.143688-2-rmoar@google.com>
 <CABVgOSkRkN9OGHKcAuG98vV2SeFoSJ6yOUGNoaJ2=8ZFyYBwUA@mail.gmail.com>
From:   John Johansen <john.johansen@canonical.com>
Organization: Canonical
In-Reply-To: <CABVgOSkRkN9OGHKcAuG98vV2SeFoSJ6yOUGNoaJ2=8ZFyYBwUA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/6/22 01:40, David Gow wrote:
> On Tue, Dec 6, 2022 at 5:51 AM Rae Moar <rmoar@google.com> wrote:
>>
>> Create two macros:
>>
>> VISIBLE_IF_KUNIT - A macro that sets symbols to be static if CONFIG_KUNIT
>> is not enabled. Otherwise if CONFIG_KUNIT is enabled there is no change to
>> the symbol definition.
>>
>> EXPORT_SYMBOL_IF_KUNIT(symbol) - Exports symbol into
>> EXPORTED_FOR_KUNIT_TESTING namespace only if CONFIG_KUNIT is enabled. Must
>> use MODULE_IMPORT_NS(EXPORTED_FOR_KUNIT_TESTING) in test file in order to
>> use symbols.
>>
>> Signed-off-by: Rae Moar <rmoar@google.com>
>> Reviewed-by: John Johansen <john.johansen@canonical.com>
>> Reviewed-by: David Gow <davidgow@google.com>
>> ---
>>
>> Changes since v1:
>>   - Separated the documentation comments for macros.
>>   - Changed copyright date and author for new header file.
>>
> 
> This still looks good to me, thanks!
> 
> Reviewed-by: David Gow <davidgow@google.com>

yep, and you already have my Reviewed-by for this one

> 
> Cheers,
> -- David
> 
> 
>>   include/kunit/visibility.h | 33 +++++++++++++++++++++++++++++++++
>>   1 file changed, 33 insertions(+)
>>   create mode 100644 include/kunit/visibility.h
>>
>> diff --git a/include/kunit/visibility.h b/include/kunit/visibility.h
>> new file mode 100644
>> index 000000000000..0dfe35feeec6
>> --- /dev/null
>> +++ b/include/kunit/visibility.h
>> @@ -0,0 +1,33 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * KUnit API to allow symbols to be conditionally visible during KUnit
>> + * testing
>> + *
>> + * Copyright (C) 2022, Google LLC.
>> + * Author: Rae Moar <rmoar@google.com>
>> + */
>> +
>> +#ifndef _KUNIT_VISIBILITY_H
>> +#define _KUNIT_VISIBILITY_H
>> +
>> +#if IS_ENABLED(CONFIG_KUNIT)
>> +    /**
>> +     * VISIBLE_IF_KUNIT - A macro that sets symbols to be static if
>> +     * CONFIG_KUNIT is not enabled. Otherwise if CONFIG_KUNIT is enabled
>> +     * there is no change to the symbol definition.
>> +     */
>> +    #define VISIBLE_IF_KUNIT
>> +    /**
>> +     * EXPORT_SYMBOL_IF_KUNIT(symbol) - Exports symbol into
>> +     * EXPORTED_FOR_KUNIT_TESTING namespace only if CONFIG_KUNIT is
>> +     * enabled. Must use MODULE_IMPORT_NS(EXPORTED_FOR_KUNIT_TESTING)
>> +     * in test file in order to use symbols.
>> +     */
>> +    #define EXPORT_SYMBOL_IF_KUNIT(symbol) EXPORT_SYMBOL_NS(symbol, \
>> +           EXPORTED_FOR_KUNIT_TESTING)
>> +#else
>> +    #define VISIBLE_IF_KUNIT static
>> +    #define EXPORT_SYMBOL_IF_KUNIT(symbol)
>> +#endif
>> +
>> +#endif /* _KUNIT_VISIBILITY_H */
>> --
>> 2.39.0.rc0.267.gcb52ba06e7-goog
>>

