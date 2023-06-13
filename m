Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D63872DCEC
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jun 2023 10:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238274AbjFMIpK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 13 Jun 2023 04:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241864AbjFMIpF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 13 Jun 2023 04:45:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAEA1A0
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Jun 2023 01:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686645855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DwCdfz6qIzvNJOkrJ4ckCc4rA0w83T1zH7jefpl3y6I=;
        b=D1YeR1RzA5/q+94ZSdJM0DH9jc36QQyrmsYQ55sUUZlS9R2/INJfO37th4Dhwt8puQQN44
        pfdeEilnpXiCRyqYs+2GjTraDLpOInb9PtM76arATwYdyEY7/oTQ03WkZwmyns0pN2P6j2
        JlbGBrATpfiRBJK7zS44q2fc/JiWZsA=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-jMq7Ky4XMF-ZTCiUP1u29Q-1; Tue, 13 Jun 2023 04:44:13 -0400
X-MC-Unique: jMq7Ky4XMF-ZTCiUP1u29Q-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-4f621c76606so3507096e87.0
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Jun 2023 01:44:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686645852; x=1689237852;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DwCdfz6qIzvNJOkrJ4ckCc4rA0w83T1zH7jefpl3y6I=;
        b=HGvUgr/pKO459q/GTBA0vQ8JmsWO6uhHR5k6OZAkDihBdt9GWsQJpGhxi5fBi93sHK
         gRxEjPtIcYzVOmWESSM+kY5jpauU6M+rT+xFEtw+/lnIpX/xWuqRfdy9jmUkMjT0Yxw1
         R0kzxg/eP5xN4byrzDYgnUt5pA6FpVd7LiDwpb5ba5nzHzU++ydycZ+VGwd8Vosa14Vj
         bRVUy33DfOZsq6CJ0dxc08PR36my79AvwQu38WgUmep42LdiXqZYSFbE7hYtg06FSrOl
         gho9nDIAFWjCy3E3ikV32RS1xQ4euzYt9K+BgKRGoSUKBTHSXc6ijQ0iv51UARtZloAv
         9omQ==
X-Gm-Message-State: AC+VfDx+Q0rH5Ws1ZfnJd9VfahDwHtRGJwlKeIqPvDlZwcCGzRmbIouh
        gqPTdyREza/xTa/MB6JVpdI+Bi1Ox7+ZtCcMzEf0H3l2MtcA62RlOgSrDEuyEXqCSYel87w5Ak5
        2qLmKZd5z0bbFu2opInORJqu4JlAa
X-Received: by 2002:a19:2d4e:0:b0:4f6:3ef4:5c78 with SMTP id t14-20020a192d4e000000b004f63ef45c78mr4880070lft.50.1686645852115;
        Tue, 13 Jun 2023 01:44:12 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ76OwP/icHsCrkIlrQSybTRFDNzeJVkIcmQL7YrFmVBPuSL+xWxlAH6cjj+YWuxrRnJybU+Ww==
X-Received: by 2002:a19:2d4e:0:b0:4f6:3ef4:5c78 with SMTP id t14-20020a192d4e000000b004f63ef45c78mr4880059lft.50.1686645851644;
        Tue, 13 Jun 2023 01:44:11 -0700 (PDT)
Received: from ?IPV6:2003:cb:c710:ff00:1a06:80f:733a:e8c6? (p200300cbc710ff001a06080f733ae8c6.dip0.t-ipconnect.de. [2003:cb:c710:ff00:1a06:80f:733a:e8c6])
        by smtp.gmail.com with ESMTPSA id 14-20020a05600c024e00b003f8044b3448sm13350961wmj.9.2023.06.13.01.44.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 01:44:11 -0700 (PDT)
Message-ID: <e05c4897-ea77-bd1e-0bdd-e897107a614f@redhat.com>
Date:   Tue, 13 Jun 2023 10:44:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] selftests: lib.mk: fix out-of-tree builds
Content-Language: en-US
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Anders Roxell <anders.roxell@linaro.org>, shuah@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list : MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        John Hubbard <jhubbard@nvidia.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230613074931.666966-1-anders.roxell@linaro.org>
 <cf6eb3f1-276a-bdcc-7d63-7f4ab3f9cdce@collabora.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <cf6eb3f1-276a-bdcc-7d63-7f4ab3f9cdce@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 13.06.23 10:16, Muhammad Usama Anjum wrote:
> This patch needs to go through mm tree as the commit which it fixes is in mm.
> 
> On 6/13/23 12:49 PM, Anders Roxell wrote:
>> Since commit ("selftests: error out if kernel header files are not yet
>> built") got merged, the kselftest build correctly because the
>> KBUILD_OUTPUT isn't set when building out-of-tree and specifying 'O='
>> This is the error message that pops up.
>>
>> make --silent --keep-going --jobs=32 O=/home/anders/.cache/tuxmake/builds/1482/build INSTALL_PATH=/home/anders/.cache/tuxmake/builds/1482/build/kselftest_install ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- V=1 CROSS_COMPILE_COMPAT=arm-linux-gnueabihf- kselftest-install
>> make[3]: Entering directory '/home/anders/src/kernel/next/tools/testing/selftests/alsa'
>>
>> -e [1;31merror[0m: missing kernel header files.
>> Please run this and try again:
>>
>>      cd /home/anders/src/kernel/next/tools/testing/selftests/../../..
>>      make headers
>>
>> make[3]: Leaving directory '/home/anders/src/kernel/next/tools/testing/selftests/alsa'
>> make[3]: *** [../lib.mk:77: kernel_header_files] Error 1
>>
>> Fixing the issue by assigning KBUILD_OUTPUT the same way how its done in
>> kselftest's Makefile. By adding 'KBUILD_OUTPUT := $(O)' 'if $(origin O)'
>> is set to 'command line'. This will set the the BUILD dir to
>> KBUILD_OUTPUT/kselftest when doing out-of-tree builds which makes them
>> in its own separete output directory.
>>
>> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> Please add fixes tag. ("selftests: error out if kernel header files are not
> yet built")
> 
> Tested-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

This should get squashed into the original patch unless it's already in 
mm-stable (which it isn't) and we have a stable commit id.

-- 
Cheers,

David / dhildenb

