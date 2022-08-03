Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B348589318
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Aug 2022 22:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238410AbiHCUWz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 3 Aug 2022 16:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236282AbiHCUWy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 3 Aug 2022 16:22:54 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25306140DA;
        Wed,  3 Aug 2022 13:22:54 -0700 (PDT)
Received: from [192.168.43.224] (92.40.178.37.threembb.co.uk [92.40.178.37])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: gtucker)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 07DD366017FE;
        Wed,  3 Aug 2022 21:22:51 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1659558172;
        bh=cy75vdn4JdMPEqBq87inas1egtw1peeBE+7rLpHybOo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=UN/tCVdpZLT+IuW5XhExXmk36VLB8dkAackhDzqdFU17RMLk9XzpR/zaxgn+u0bJD
         rR/S5RcgebkfkzTfXJ289Zm+7HIsfgzHUL9YVFL4zv56Mzn6ogkGm1dqNKyNTMvzzA
         9AmRQNhzFjOCLrWveBqAVWwqPg9kTi96Ukk61fZq52YJq1HKfwgNCMfLKZl0SAuBai
         E87hkQK3GoMf3jdq/f8Y3b1f4khNtgAtDYf+6gX9a3Ykc/r2/ygJBwMeO0iSWRnn2V
         igTHuhxFdtzEheHvrSXVJaIBTaCXJdJHFDL+KTlpvgvZEGZCnSIeREHzOCTgO3lTBU
         NiQOuMJAQERrQ==
Message-ID: <7a412c45-4536-1f0b-d04e-24b2063ac034@collabora.com>
Date:   Wed, 3 Aug 2022 22:22:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [GIT PULL] Kselftest update for Linux 5.20-rc1
Content-Language: en-US
To:     Shuah Khan <skhan@linuxfoundation.org>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8?= =?UTF-8?Q?n?= <mic@digikod.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
References: <430ef132-2ac7-e1be-68ed-3d9c27382143@linuxfoundation.org>
 <2838c247-0648-3828-efb3-e11d7a0616b2@digikod.net>
 <84560b65-12ed-da24-3698-45484f80802a@linuxfoundation.org>
 <fa7fb9b3-169a-199f-22da-006777a14e03@collabora.com>
 <15a23d4b-ee26-a6a1-a785-b640c550bfb8@linuxfoundation.org>
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
In-Reply-To: <15a23d4b-ee26-a6a1-a785-b640c550bfb8@linuxfoundation.org>
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

On 03/08/2022 16:32, Shuah Khan wrote:
> On 8/2/22 10:44 PM, Guillaume Tucker wrote:
>> On 02/08/2022 15:29, Shuah Khan wrote:
>>> On 8/2/22 3:51 AM, Mickaël Salaün wrote:
>>>> Hi,
>>>>
>>>> This change breaks the Landlock test build when performed on the tools/testing/selftests/landlock directory because the (non-system/up-to-date) kernel headers aren't found. Looking at the use of top_srcdir and HDR_PATH, it seems that multiple subsystems are using this feature. I consider this change a regression.
>>>>
>>>
>>> I did a build test from the top level before sending the pull request
>>> and didn't catch this breakage as a result. This breaks when build is
>>> run from the test directory.
>>>
>>> We have had several problems related to khdr_dir and target and decided
>>> to move away from it with this change.
>>>
>>>> It also removes the check on up-to-date kernel headers (thanks to the Makefile's target timestamp).
>>>>
>>>> I wasn't CCed for this change impacting Landlock [1]. Please keep in mind to add at least maintainers and related mailing-lists for changes on related subsystems.
>>>>
>>>
>>> That is the usual practice and if I notice missing maintainers, I add
>>> them. We missed this one.
>>>
>>>> The following patch almost revert commit a917dd94b832 ("selftests/landlock: drop deprecated headers dependency") and partially fixes commit 49de12ba06ef ("selftests: drop KSFT_KHDR_INSTALL make target"):
>>>>
>>>
>>> Guillaume,
>>>
>>> Will you be able to look at this and send a patch on top? I will
>>> send another pull request before merge window closes?
>>
>> Sure, I'll take a look today.
>>
> 
> Thank you.

OK I just sent "selftests/landlock: fix broken include of linux/landlock.h"

This does fix the build when doing:

  make -C tools/testing/selftests/landlock

However I've also noticed the landlock test is failing to build
when make is invoked from the top-level directory and using a
sub-directory for the build output, in other words my earlier
patches didn't fix the build for this test, but that's not a
regression.

I'll see if that can be fixed too while also not breaking
the "-C" sub-make build.

>> Also I'll see if we can add some extra build tests in KernelCI
>> for the kselftest tree to catch issues like these automatically.
>>
> 
> Yes. Adding tests to catch these automatically will be great.
> Please refer to use-cases for kselftest for tips on tests to
> add. Beig able to build from individual test directory is one
> of the use-cases.

Great.  Well I shall try and get that set up before making further changes ;)

Best wishes,
Guillaume


P.S. The output of gen_tar is showing "-ne " on every line, is that expected?
     For example: -ne Emit Tests for alsa
