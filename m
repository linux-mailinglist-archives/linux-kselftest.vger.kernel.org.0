Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB634D1608
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Mar 2022 12:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbiCHLSS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Mar 2022 06:18:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346423AbiCHLSS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Mar 2022 06:18:18 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7F141625;
        Tue,  8 Mar 2022 03:17:21 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id BD1471F43E42
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646738239;
        bh=iIIlUlWD+Bc1GobtHRXLCDOiF4+ae+ixtyxUlRG6iWo=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=jF01mL+I8S6+Kb4PGBewSEtA53E5ojtFJnMSVC6fUgypqvav+xLQh/0ZoGtV3oDYW
         FNZEGphVUQokbKnc8So8OU5aOLEtr9d0PkMZlIyjwQJsL4Md+KZZwl12teRsc2tZX6
         2BxG+kWLRxs9t5cS9H8fcJeDDqPu+AmNIAOI1bjl2/JElIXvIo+KsURuzUbxZ9jItN
         k+KwNDy+MbK/NaQtQ5KzeSJ5gx46XwXMey4N68Ae3ex7Ziz2468sJl7HpZ+xiNb9gy
         Zpw+cq4Js9yXxsZ5czbIQKaAz9Rw1FiqONHoJmiAOmBfJcA9VpXhVXHGzlKPIChA2p
         Xgv0hc1lmTHuw==
Message-ID: <f12e7608-eaf3-2dc9-46fa-4dc656c3e40b@collabora.com>
Date:   Tue, 8 Mar 2022 16:17:13 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Cc:     usama.anjum@collabora.com, kernel@collabora.com,
        kernelci@groups.io,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH 1/2] selftests/lkdtm: add config and turn off
 CFI_FORWARD_PROTO
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, linux-kselftest@vger.kernel.org
References: <20220217205620.2512094-1-usama.anjum@collabora.com>
 <0c22d702-b451-e9b3-8d3f-7c28ca71c1da@collabora.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <0c22d702-b451-e9b3-8d3f-7c28ca71c1da@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Reminder!

On 2/28/22 12:06 PM, Muhammad Usama Anjum wrote:
> Hi,
> 
> Any thoughts?
> 
> On 2/18/22 1:56 AM, Muhammad Usama Anjum wrote:
>> Add config options which are needed for LKDTM sub-tests.
>> STACKLEAK_ERASING test needs GCC_PLUGIN_STACKLEAK config.
>> READ_AFTER_FREE and READ_BUDDY_AFTER_FREE tests need
>> INIT_ON_FREE_DEFAULT_ON config.
>>
>> CFI_FORWARD_PROTO always fails as there is no active CFI system of some
>> kind. Turn it off for now by default until proper support.
>>
>> Cc: Kees Cook <keescook@chromium.org>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Fixes: 46d1a0f03d66 ("selftests/lkdtm: Add tests for LKDTM targets")
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>>  tools/testing/selftests/lkdtm/config    | 2 ++
>>  tools/testing/selftests/lkdtm/tests.txt | 2 +-
>>  2 files changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/lkdtm/config b/tools/testing/selftests/lkdtm/config
>> index 46f39ee762086..adc9fa60057c5 100644
>> --- a/tools/testing/selftests/lkdtm/config
>> +++ b/tools/testing/selftests/lkdtm/config
>> @@ -2,8 +2,10 @@ CONFIG_LKDTM=y
>>  CONFIG_DEBUG_LIST=y
>>  CONFIG_SLAB_FREELIST_HARDENED=y
>>  CONFIG_FORTIFY_SOURCE=y
>> +CONFIG_GCC_PLUGIN_STACKLEAK=y
>>  CONFIG_HARDENED_USERCOPY=y
>>  CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT=y
>> +CONFIG_INIT_ON_FREE_DEFAULT_ON=y
>>  CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
>>  CONFIG_UBSAN=y
>>  CONFIG_UBSAN_BOUNDS=y
>> diff --git a/tools/testing/selftests/lkdtm/tests.txt b/tools/testing/selftests/lkdtm/tests.txt
>> index 6b36b7f5dcf96..aa947b0ce1eeb 100644
>> --- a/tools/testing/selftests/lkdtm/tests.txt
>> +++ b/tools/testing/selftests/lkdtm/tests.txt
>> @@ -72,7 +72,7 @@ USERCOPY_STACK_FRAME_FROM
>>  USERCOPY_STACK_BEYOND
>>  USERCOPY_KERNEL
>>  STACKLEAK_ERASING OK: the rest of the thread stack is properly erased
>> -CFI_FORWARD_PROTO
>> +#CFI_FORWARD_PROTO
>>  FORTIFIED_STRSCPY
>>  FORTIFIED_OBJECT
>>  FORTIFIED_SUBOBJECT
