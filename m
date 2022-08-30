Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0895A66D2
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Aug 2022 17:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiH3PEJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Aug 2022 11:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiH3PEI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Aug 2022 11:04:08 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2B710D4F7;
        Tue, 30 Aug 2022 08:04:07 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-11f4e634072so3103805fac.13;
        Tue, 30 Aug 2022 08:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=hhxGpGZOo1QkKgu0Jh3XJCpCjGiOYNk5xiHfSDFKE2M=;
        b=CLHm2GaHZnxZVDILj0oTkcJJxMFxEJTWeSIVl9Obxd54useZBSb731VjmvPjDUAoow
         Wt0ast15UHFz9ukxLfKrT9tY2Nu+FbNcA5Gi6ClU2SLLKMoMEErILBwTwjVJPMTtc2Ek
         +7tMQGZavtW3RZCCRSIDhYxT2ic8S7aY5BaUXsqKm+ElPzjkW6vZveamdgRBVEAi9D/f
         +U1bS9/rlKhTBFPCc/sd9GeHOcUwEOzQ0yoB+zXMYF8sPWVQKesaxlDJ2zEeRUewnpqm
         GiNzplQCAYcIpncvo9wE2178+OT+NCS/6IqzVs1FEPUJ01gHRJaMDDXLeFMDzk2rWyzf
         KXGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=hhxGpGZOo1QkKgu0Jh3XJCpCjGiOYNk5xiHfSDFKE2M=;
        b=4XbQwJuqHtEyIGUcREEdu1mLoSEZALGauvZHE2j+4Qw4z0LtRxHzB6ktiOFHEZlXWq
         UdLsagQbNUonVwJ1Bu71CHXx8FHHaXNZOE2PvVmtcnR65N2pL21iVRBv6h+4XXxeKBCo
         m00c42SJG/jM1YpfqvfyYtp2ztewdkXOYCaf5d2fEyh8ErmxzerYKprQ5ETzUY/KudOS
         ATl9krYsNAmAjspfeKc5Y9P6JAp7+cTUsbAEug3ADZ9rKjsiLcre4pOyei4sC07/HMPA
         D4e1rucYINp9jNmxwi8+iF2JfhPtM29Xo+zN703GvKVulJzig6QF8lQsG1sBqQ2DZZaW
         qJtQ==
X-Gm-Message-State: ACgBeo2LRUeShtIiuPrNE7AlLaweVkzKtn8F4KHTz6pLvEOuuHInRZE7
        F895BPmQEam3grrGoje5AQA=
X-Google-Smtp-Source: AA6agR4107wgLXwJjaeNUC1fcgtoLNBNi5rRvTQp1CztaP3LMtbbOwhf59nLftHdgpPUzvb+EKKtsQ==
X-Received: by 2002:a05:6808:2215:b0:344:c8d1:27df with SMTP id bd21-20020a056808221500b00344c8d127dfmr10074066oib.151.1661871846829;
        Tue, 30 Aug 2022 08:04:06 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:1485:e42c:9c81:f760? ([2600:1700:2442:6db0:1485:e42c:9c81:f760])
        by smtp.gmail.com with ESMTPSA id x3-20020a4aaa03000000b0044b46c639easm6840970oom.18.2022.08.30.08.04.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 08:04:06 -0700 (PDT)
Message-ID: <49ed5b56-2c98-e0c1-eedd-bba3dabe08c8@gmail.com>
Date:   Tue, 30 Aug 2022 10:04:05 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 1/2] ktap_v2: change version to 2-rc in KTAP
 specification
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, Tim.Bird@sony.com,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, rmr167@gmail.com,
        guillaume.tucker@collabora.com, dlatypov@google.com,
        kernelci@groups.io, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220829233150.3564612-1-frowand.list@gmail.com>
 <20220829233150.3564612-2-frowand.list@gmail.com>
 <eaf6c56b-c329-2d02-7599-ca83dbe20b0b@gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <eaf6c56b-c329-2d02-7599-ca83dbe20b0b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/29/22 20:48, Bagas Sanjaya wrote:
> On 8/30/22 06:31, frowand.list@gmail.com wrote:
>> From: Frank Rowand <frank.rowand@sony.com>
>>
>> Prepare KTAP Specification for the process of creating version 2.
>>
>> The version will remain "2-rc" until the final commit to complete
>> Version 2.  Adding the "-rc" ensures that none of the development
>> versions will be mistaken for the completed version 2.
>>
>> After this commit, Sphinx complains that we now need more '=' signs:
>>
>>   Documentation/dev-tools/ktap.rst:3: WARNING: Title overline too short.
>>   ===================================================
>>   The Kernel Test Anything Protocol (KTAP), version 2-rc
>>   ===================================================
>>
>> This warning will disappear in the final commit for the release of
>> version 2, when the "-rc" is removed.
>>
> 
> I don't see that -rc stripping in patch [2/2], so please fix the Sphinx
> warning above in this patch.
> 

The "final commit for the release of version 2" is not in this patch
series, but will be sometime in the future after all of the other
various patch series to make the changes to create version 2, and we
agree that we have reached the time to finalize and release version 2.

-Frank
