Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC81951B393
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 May 2022 01:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381294AbiEDXiQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 May 2022 19:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385531AbiEDXIu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 May 2022 19:08:50 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295CC14084;
        Wed,  4 May 2022 16:04:52 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id f4so3093440iov.2;
        Wed, 04 May 2022 16:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ILzkKB4GFyvmkKkoAzfRz5MTJCTm65HgHQFqL1jHiLk=;
        b=i/gQfgcmMDtibRhSvwUM/ZTpCzqbjQ9Qm2G+7QUIqK1tyPSHWXUmYcN/Qyyui24NE0
         HDVDSkPwL7WibbfZoOd3aM6z1du7CJosgr+RNPTU6XgV9vYV20xEdNkI61eSuqd+kgSj
         1BXy+tGggSySRA9yYoXtZ+dRo4Jb5kW5TBtuxiha84iHr75ChX8QCW1Aqt+Ih6bc1GdN
         BevtIQ2dhC4sZaizEyA1wJIx0mBVjDOiDgYFYHJFxbFCyx1CwVQzoH8C6Pdxx/rr/s42
         z2GJv+Tl38zc9qWFHAtwvvFEkDodSXj3/0YPzzOTMKKf5LJrERKVHSfp9GmddqY1a8Q8
         QNiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ILzkKB4GFyvmkKkoAzfRz5MTJCTm65HgHQFqL1jHiLk=;
        b=7USB4VwZmulOhhwvONUG5EBKA0cdVBFQEEfSl5EEcXH8AOA+RWYtf88VmDnpOoO79I
         BHFqIygWHRNBvipFkaTOe9wd/xxLjiq6jdpLm18zzPjV25VWa/LW6MzClcEwR1NNMtaY
         dYogMh/4QIOABJW7LHeEFDZHHc1isdr5ZQixanHlVIro7GsNy5hFauMekhQYnTZA1a24
         2PzOuIiFtLT2EaaTrpn19XLqGKvuybGX6ENUO4rHDlrguEXfXnTmxAn9GP+TFx6OzIz3
         vVML2keZssOkXEkNCCUq3L7TV5J9/o+MwUv9C3jsN0adJHi1veIK2/I61L/l2aVtJbfM
         QzIg==
X-Gm-Message-State: AOAM531mq39Lg2uiOIRiQiy/GOmzekNyxu8wnmBzFJprcQg8IKJ0PI3T
        +b2Ju5OR6O/Jn+g/Z28/oRM=
X-Google-Smtp-Source: ABdhPJzKlDN42/enHfqoRythPwvPy3t4d9tW0TI2VEKciXivlkHqQmLUxBKJM0dT2fP8ZO9eepHOjQ==
X-Received: by 2002:a05:6638:1346:b0:32b:71ec:3a74 with SMTP id u6-20020a056638134600b0032b71ec3a74mr6466213jad.270.1651705491546;
        Wed, 04 May 2022 16:04:51 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:5871:54:c73e:3c22? ([2600:1700:2442:6db0:5871:54:c73e:3c22])
        by smtp.gmail.com with ESMTPSA id b35-20020a05663838a300b0032b3a781741sm73199jav.5.2022.05.04.16.04.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 16:04:51 -0700 (PDT)
Message-ID: <cca4e4ae-0a37-83ea-c740-1085b59a3e1c@gmail.com>
Date:   Wed, 4 May 2022 18:04:49 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 0/2] begin KTAP spec v2 process
Content-Language: en-US
To:     David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, Tim.Bird@sony.com,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, rmr167@gmail.com,
        guillaume.tucker@collabora.com, dlatypov@google.com,
        kernelci@groups.io, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220504225152.1451440-1-frowand.list@gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <20220504225152.1451440-1-frowand.list@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/4/22 17:51, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> The process to create version 2 of the KTAP Specification is documented
> in email discussions.  I am attempting to capture this information at
> 
>    https://elinux.org/Test_Results_Format_Notes#KTAP_version_2
> 
> I am already not following the suggested process, which says:
> "...please try to follow this principal of one major topic per email
> thread."  I think that is ok in this case because the two patches
> are related and (hopefully) not controversial.
> 
> Changes since patch version 1:
>    - drop patch 1/2.  Jonathan Corbet has already applied this patch
>      into version 1 of the Specification
>    - rename patch 2/2 to patch 1/2, with updated patch comment
>    - add new patch 2/2
> 
> Frank Rowand (2):
>   ktap_v2: change version to 2-rc in KTAP specification
>   ktap_v2: change "version 1" to "version 2" in examples
> 
>  Documentation/dev-tools/ktap.rst | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
> 

I should note that I will be maintaining a branch of the KTAP Specification version 2
patches and that they will not be submitted to mainline until we agree on the final
content of version 2.
