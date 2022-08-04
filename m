Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D026589E80
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Aug 2022 17:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239145AbiHDPSo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 4 Aug 2022 11:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbiHDPSn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 4 Aug 2022 11:18:43 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB86CBDC;
        Thu,  4 Aug 2022 08:18:41 -0700 (PDT)
Received: from [192.168.10.7] (unknown [39.45.237.6])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A70726601BE2;
        Thu,  4 Aug 2022 16:18:38 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1659626320;
        bh=ZfCnR7NuN++iEa7aj14pbFZsVKTB3C5DlbZ/si2y4q0=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=LbG7M2UueSp1MsMFjixYO8Y24VjVGpyNhOL9YNbiXgyZf/CfpnS6ZDca2DrY0xp26
         tzgTwwXAVhKMuLgMWC0aN+2uDXSQz+5qbuPtXWEg6OIesAE9aetbdPTCJ6mCyfpedC
         kLBdiCgX2edXhb+UfXQu5xUA5N4qFRGM4AdwjjRsPgsHuG/fGWDzcLVrxadfbY+Kyp
         40jw55kS+EnmRdJSmvyJ4YkcAlYNg8AZWWnY4yxV4JlOQJmuHAyT0gJziyofoOrpXS
         qQ6teImj33ZnuNUiXmRie/X9NbqqQpzld6oJtWX5m+pdYCxcVoplAEESphoiDFFTSD
         LKkjFOAqPYaAw==
Message-ID: <0e721d07-8ca1-47f2-9ce8-769dac4f57d3@collabora.com>
Date:   Thu, 4 Aug 2022 20:18:34 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Cc:     usama.anjum@collabora.com, kernel@collabora.com,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH] docs/kselftest: Fix build commands in guidelines
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>
References: <20220704083426.1867401-1-usama.anjum@collabora.com>
 <58aad5c5-339f-85b9-8f48-0ffbd133b0cb@linuxfoundation.org>
 <3e48da77-68b3-e94a-b428-2e628ca1d46b@collabora.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <3e48da77-68b3-e94a-b428-2e628ca1d46b@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/26/22 9:59 AM, Muhammad Usama Anjum wrote:
> On 7/8/22 9:51 PM, Shuah Khan wrote:
>> On 7/4/22 2:34 AM, Muhammad Usama Anjum wrote:
>>> Build commands start with "make". It is missing. Add "make" to the start
>>> of the build command.
>>>
>>> Fixes: 820636106342 ("docs/kselftest: add more guidelines for adding
>>> new tests")
>>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>>> ---
>>>   Documentation/dev-tools/kselftest.rst | 6 +++---
>>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/Documentation/dev-tools/kselftest.rst
>>> b/Documentation/dev-tools/kselftest.rst
>>> index ee6467ca8293..9dd94c334f05 100644
>>> --- a/Documentation/dev-tools/kselftest.rst
>>> +++ b/Documentation/dev-tools/kselftest.rst
>>> @@ -255,9 +255,9 @@ Contributing new tests (details)
>>>      * All changes should pass::
>>>   -    kselftest-{all,install,clean,gen_tar}
>>> -    kselftest-{all,install,clean,gen_tar} O=abo_path
>>> -    kselftest-{all,install,clean,gen_tar} O=rel_path
>>> +    make kselftest-{all,install,clean,gen_tar}
>>> +    make kselftest-{all,install,clean,gen_tar} O=abs_path
>>> +    make kselftest-{all,install,clean,gen_tar} O=rel_path
>>>       make -C tools/testing/selftests {all,install,clean,gen_tar}
>>>       make -C tools/testing/selftests {all,install,clean,gen_tar}
>>> O=abs_path
>>>       make -C tools/testing/selftests {all,install,clean,gen_tar}
>>> O=rel_path
>>>
>>
>> Looks like it depends on a patch already in doc tree?
> Yes, the dependent patch is in doc tree. Corbet should pick up this patch.
Reminder!

>> Acked-by: Shuah Khan <skhan@linuxfoundation.org>
>>
>> thanks,
>> -- Shuah
> 

-- 
Muhammad Usama Anjum
