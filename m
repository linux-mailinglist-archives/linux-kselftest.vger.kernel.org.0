Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D924ACABF
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Feb 2022 21:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234973AbiBGUuX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Feb 2022 15:50:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234500AbiBGUuV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Feb 2022 15:50:21 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A920C06173B;
        Mon,  7 Feb 2022 12:50:19 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id 489061F449A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644267017;
        bh=3lS6N5RJps0OJmMkGwekeXsU2Va8vgdu8W44CQNZmXM=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=movQ8j5Qfu3B5UzmjKxjVkNVTWCBwElWoP+woePSYr7NjRY1jTFKP1lAts5SqQl8g
         eOJdCW973qIxeq3Corq05gMIzs1kOR95/89Z2QDJtpXUYSBnsbALWRU9IL0yLON2Ro
         fmq3Uj9hlX33ztZwnm6ApgNnj/NShdal1MRL6yijnnNE2H4Nu0WevBJUU0idmUMCau
         JIGLnSSrMMnP1fUi8vkGfQv1vg9ulXiUhnnCxZHp7HgNTtSkVgfhO34uiiS+exSerU
         M8iAx2my//x6rg1gLCVc/TPcHks7BVOCvB9efI6GjxuBu985crIr5lbSd5Q2ErkM4R
         hGHDQpneVnCGw==
Message-ID: <24d02704-e590-63d0-4d8a-c76578249bea@collabora.com>
Date:   Tue, 8 Feb 2022 01:50:09 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Cc:     usama.anjum@collabora.com, kernel@collabora.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests: futex: set DEFAULT_INSTALL_HDR_PATH
Content-Language: en-US
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>,
        Shuah Khan <shuah@kernel.org>
References: <20220119103332.2887370-1-usama.anjum@collabora.com>
 <3a4878b9-f175-f16f-a901-efc33b2bf89f@linuxfoundation.org>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <3a4878b9-f175-f16f-a901-efc33b2bf89f@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/7/22 11:40 PM, Shuah Khan wrote:
> On 1/19/22 3:33 AM, Muhammad Usama Anjum wrote:
>> If only futex selftest is compiled, uapi header files are copied to the
>> selftests/futex/functional directory. This copy isn't needed. Set the
>> DEFAULT_INSTALL_HDR_PATH variable to 1 to use the default header install
>> path only. This removes extra copy of header file.
>>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>>   tools/testing/selftests/futex/functional/Makefile | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/tools/testing/selftests/futex/functional/Makefile
>> b/tools/testing/selftests/futex/functional/Makefile
>> index 5cc38de9d8ea..9a8c3700d773 100644
>> --- a/tools/testing/selftests/futex/functional/Makefile
>> +++ b/tools/testing/selftests/futex/functional/Makefile
>> @@ -24,6 +24,7 @@ TEST_PROGS := run.sh
>>     top_srcdir = ../../../../..
>>   KSFT_KHDR_INSTALL := 1
>> +DEFAULT_INSTALL_HDR_PATH := 1
>>   include ../../lib.mk
>>     $(TEST_GEN_FILES): $(HEADERS)
>>
> 
> This will be a good cleanup. However, please make there is no dependencies
> in the futex test sub-dirs on being able to find the headers under futex
> 
I've tried the following variations. The build is fine.

cd tools/testing/selftests/futex/functional
make

cd tools/testing/selftests/futex/
make

make -C tools/testing/selftests/

> I vaguely remember leaving this in place for reason.
> 
This must have been fixed in previous changes made to the build system.

> thanks,
> -- Shuah
> 
