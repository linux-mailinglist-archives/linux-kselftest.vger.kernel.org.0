Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4EA3500C35
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Apr 2022 13:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237118AbiDNLeO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Apr 2022 07:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234754AbiDNLeN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Apr 2022 07:34:13 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB5285BE4;
        Thu, 14 Apr 2022 04:31:49 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id 45C821F4158A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649935908;
        bh=GPpOOW8Wi1fl7Wg5T7uDGlFz2uhTlfR0tze2KF/L4Lg=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=UNTcHiMRdJz5bAEsKI68i50wj9NtfZnA/r0GFYHgPGAzdykI8Cq47yn9uuSLN8P0/
         Y+GZxS4QY2rf3BFceguyH2Q7YREa74twPjBXhiZRiAoliwknDoeHuOapiLOFPkCzX4
         fxhgIYrM2NT7va7AGXGb9KRV38vvEQkQJymIu95UzYNy7pFjfu05WlLicOp4Uu8sTG
         v30hsDPOUT+lRCJHhdo+QwxFU1Xrva8VBi8mMKXMb0rePIvuZIwvgLtIXYceQa7tTU
         ZtF2sfEbHEt6elpONPggbDbNmwXS4SfyaZqt2xsiPjftonwtq+aDNn7pDmt2ZGXmKm
         grhM6pIdIWhrA==
Message-ID: <8049e2a9-a478-4c6a-afcd-3aa4434a0590@collabora.com>
Date:   Thu, 14 Apr 2022 16:31:42 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Cc:     usama.anjum@collabora.com, kernel@collabora.com,
        kernelci@groups.io,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] selftests/lkdtm: add config and turn off
 CFI_FORWARD_PROTO
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org
References: <20220217205620.2512094-1-usama.anjum@collabora.com>
 <202203091122.A51B31230A@keescook>
 <62c11336-cac1-8501-19fe-980ebfa050e9@collabora.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <62c11336-cac1-8501-19fe-980ebfa050e9@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Any thoughts?

On 3/10/22 10:21 PM, Muhammad Usama Anjum wrote:
> On 3/10/22 12:22 AM, Kees Cook wrote:
>> On Fri, Feb 18, 2022 at 01:56:19AM +0500, Muhammad Usama Anjum wrote:
>>> Add config options which are needed for LKDTM sub-tests.
>>> STACKLEAK_ERASING test needs GCC_PLUGIN_STACKLEAK config.
>>> READ_AFTER_FREE and READ_BUDDY_AFTER_FREE tests need
>>> INIT_ON_FREE_DEFAULT_ON config.
>>>
>>> CFI_FORWARD_PROTO always fails as there is no active CFI system of some
>>> kind. Turn it off for now by default until proper support.
>>
>> Building under LTO Clang on arm64, this is available. What's the right
>> way to add a CONFIG that isn't always available?
>>
>> -Kees
> Yeah, as you had mentioned
> (https://github.com/kernelci/kernelci-project/issues/84#issuecomment-1042015431):
> 
> CFI_FORWARD_PROTO is going to fail unless there is an active CFI system
> in place of some kind. Right now this depends on arm64+Clang. In the
> future, this will be arch-agnostic+Clang, but for the moment, it should
> be safe to exclude this test.
> 
> In this patch, I'm turning off CFI_FORWARD_PROTO by default here. We can
> re-enable it when it becomes arch agnostic. CFI_FORWARD_PROTO cannot be
> turned off by using a config. Please let me know your thoughts otherwise.
> 

-- 
Muhammad Usama Anjum
