Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF6B68AA38
	for <lists+linux-kselftest@lfdr.de>; Sat,  4 Feb 2023 14:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbjBDNfz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 4 Feb 2023 08:35:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233713AbjBDNfx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 4 Feb 2023 08:35:53 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8359F1A5;
        Sat,  4 Feb 2023 05:35:52 -0800 (PST)
Received: from [151.216.142.144] (unknown [151.216.142.144])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: gtucker)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2503266029A5;
        Sat,  4 Feb 2023 13:35:51 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675517751;
        bh=aazq/Vh7j/hkkupZJNXPInbf51BnuvyG/TWDf8xxa60=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=J8dDdOCno3fqx7hJxu5iKusckWXFbwz7wcV47HKXG2KxwSXk6X6FrDIzl+EktCBKs
         gbogHAZPx4eQeoPHDkb6JO8UVw7OAM2zH7WydtwP16L1GpSQ9P8pWpsqn3E/grVbKC
         2mscPF8P4QufvPRZ4uG22BnEXejckbh+Mr4YUE7eL24AkKVd7nnPAGYgvyXI9hXCWM
         tiMQYr6NEuKWDzDoXnU+bC3E4OIxSN2IxJq+hHl5NycwikF8LolLEJoxrOB/OrAn9F
         0Hzywro6+UyBDP8allsO1a7m1ZDhfGrR0v02w00a6Hcmn4OaNMDTCG3OY3hwmhHWSL
         liViOuU6UELKg==
Message-ID: <51e62348-9e8e-2769-6372-f217f894a917@collabora.com>
Date:   Sat, 4 Feb 2023 14:36:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] selftests: find echo binary to use -ne options
Content-Language: en-US
To:     David Laight <David.Laight@ACULAB.COM>,
        Shuah Khan <shuah@kernel.org>,
        Gautam <gautammenghani201@gmail.com>
Cc:     "kernel@collabora.com" <kernel@collabora.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernelci@lists.linux.dev" <kernelci@lists.linux.dev>
References: <20230203152603.11450-1-guillaume.tucker@collabora.com>
 <90ace4f466ee4f79bf2dd94c5830e57a@AcuMS.aculab.com>
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
In-Reply-To: <90ace4f466ee4f79bf2dd94c5830e57a@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 04/02/2023 14:04, David Laight wrote:
> From: Guillaume Tucker
>> Sent: 03 February 2023 15:26
>>
>> Find the actual echo binary using $(which echo) and use it for
>> formatted output with -ne.  On some systems, the default echo command
>> doesn't handle the -e option and the output looks like this (arm64
>> build):
>>
>> -ne Emit Tests for alsa
>>
>> -ne Emit Tests for amd-pstate
>>
>> -ne Emit Tests for arm64
> 
> Nack.
> There is no reason to suppose that /bin/echo is any different from
> the version of echo builtin to the shell that make uses.
> 
> Not only that 'which' is a horrid shell script that is trying to
> emulate csh builtin.
> The bourne shell equivalent is 'type' and the posix one 'command'.
> 
> In any case the portable way to fix this is to use printf.
> This is a well defined program and is bultin to all modern shells.

Ah great, thanks for the review.  Will send a v2 with printf.

Guillaume

>> This is for example the case with the KernelCI Docker images
>> e.g. kernelci/gcc-10:x86-kselftest-kernelci.  With the actual echo
>> binary (e.g. in /bin/echo), the output is formatted as expected (x86
>> build this time):
>>
>> Emit Tests for alsa
>> Emit Tests for amd-pstate
>> Skipping non-existent dir: arm64
>>
>> Only the install target is using "echo -ne" so keep the $ECHO variable
>> local to it.
>>
>> Reported-by: "kernelci.org bot" <bot@kernelci.org>
>> Fixes: 3297a4df805d ("kselftests: Enable the echo command to print newlines in Makefile")
>> Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>
>> ---
>>  tools/testing/selftests/Makefile | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
>> index 41b649452560..9619d0f3b2ff 100644
>> --- a/tools/testing/selftests/Makefile
>> +++ b/tools/testing/selftests/Makefile
>> @@ -234,10 +234,11 @@ ifdef INSTALL_PATH
>>  	@# While building kselftest-list.text skip also non-existent TARGET dirs:
>>  	@# they could be the result of a build failure and should NOT be
>>  	@# included in the generated runlist.
>> +	ECHO=`which echo`; \
>>  	for TARGET in $(TARGETS); do \
>>  		BUILD_TARGET=$$BUILD/$$TARGET;	\
>> -		[ ! -d $(INSTALL_PATH)/$$TARGET ] && echo "Skipping non-existent dir: $$TARGET" &&
>> continue; \
>> -		echo -ne "Emit Tests for $$TARGET\n"; \
>> +		[ ! -d $(INSTALL_PATH)/$$TARGET ] && $$ECHO "Skipping non-existent dir: $$TARGET" &&
>> continue; \
>> +		$$ECHO -ne "Emit Tests for $$TARGET\n"; \
>>  		$(MAKE) -s --no-print-directory OUTPUT=$$BUILD_TARGET COLLECTION=$$TARGET \
>>  			-C $$TARGET emit_tests >> $(TEST_LIST); \
>>  	done;
>> --
>> 2.30.2
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 
> 

