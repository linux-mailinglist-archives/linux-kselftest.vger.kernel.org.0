Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06C234B186C
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Feb 2022 23:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345078AbiBJWmj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Feb 2022 17:42:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345032AbiBJWmh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Feb 2022 17:42:37 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B85026D4;
        Thu, 10 Feb 2022 14:42:37 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id 850A11F467B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644532956;
        bh=bedGo7xcKtSpxhKnR+SjKvtdtKnjMdpeXSz+eoAK79g=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=aDieopZ85m1PLSn0SM2YpgfuPUXWCpFgbf7eegoSQGvbnj+qcVoxsqfwwBj4UXKV/
         jTdy+wGP3V7ojgOOycAjGc1E6awJpB6rzm7pQa7EYynzk7PEvKmqTkDgDT8u4eCgqe
         3YsWQD1/WOUATmWAjME6u18BS7fjFCnSc72kYytUr2+ojQGKihgGQIskMrmsSMS+yt
         +S1AIAkeIGpGksvE/hK7vtZpX4EtXB7RNcE21sNUe/MTfrlQ8nAYlNxn4PRrvkuyFV
         iM5m5OtbVY1vxEiBsgKJ78oHImNSpr8f+ZgTg4ZOysKrNMFHi68rxaEcsOk5oBkPMJ
         gBdQRwAH2Q7eQ==
Message-ID: <81619c13-41e6-3aab-4cf7-9b6d5a11e05c@collabora.com>
Date:   Fri, 11 Feb 2022 03:41:54 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Cc:     usama.anjum@collabora.com, kernel@collabora.com,
        kernelci@groups.io, "kernelci.org bot" <bot@kernelci.org>
Subject: Re: [PATCH 1/2] selftests: x86: allow expansion of $(CC)
Content-Language: en-US
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Jethro Beekman <jethro@fortanix.com>,
        "open list:INTEL SGX" <linux-sgx@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20220210190642.1477814-1-usama.anjum@collabora.com>
 <20220210190642.1477814-2-usama.anjum@collabora.com>
 <a34f2fc8-f4aa-fef4-d1dd-f3fdb5114f72@linuxfoundation.org>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <a34f2fc8-f4aa-fef4-d1dd-f3fdb5114f72@linuxfoundation.org>
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

On 2/11/22 1:51 AM, Shuah Khan wrote:
> On 2/10/22 12:06 PM, Muhammad Usama Anjum wrote:
>> CC can have multiple sub-strings like "ccache gcc". Erorr pops up if
>> it is treated as single string and double quote are used around it.
>> This can be fixed by removing the quotes and not treating CC a single
>> string.
>>
>> Fixes: e9886ace222e ("selftests, x86: Rework x86 target architecture
>> detection")
>> Reported-by: "kernelci.org bot" <bot@kernelci.org>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>>   tools/testing/selftests/x86/check_cc.sh | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/x86/check_cc.sh
>> b/tools/testing/selftests/x86/check_cc.sh
>> index 3e2089c8cf549..aff2c15018b53 100755
>> --- a/tools/testing/selftests/x86/check_cc.sh
>> +++ b/tools/testing/selftests/x86/check_cc.sh
>> @@ -7,7 +7,7 @@ CC="$1"
>>   TESTPROG="$2"
>>   shift 2
>>   -if "$CC" -o /dev/null "$TESTPROG" -O0 "$@" 2>/dev/null; then
>> +if $CC -o /dev/null "$TESTPROG" -O0 "$@" 2>/dev/null; then
>>       echo 1
>>   else
>>       echo 0
>>
> 
> The intent is testing if $CC is set. Does this change work when
> $CC is not set?
> 
Yeah, it works. I've added a debug variable inside sgx/Makefile and it
is detecting empty argument correctly as well.


--- a/tools/testing/selftests/sgx/Makefile
+++ b/tools/testing/selftests/sgx/Makefile
@@ -6,7 +6,7 @@ include ../lib.mk

 CAN_BUILD_X86_64 := $(shell ../x86/check_cc.sh "$(CC)" \
                            ../x86/trivial_64bit_program.c)
-
+$(info $$CAN_BUILD_X86_64 is [${CAN_BUILD_X86_64}])


Wrong examples:
➜  sgx (next-20220210_) ✗ make CC=""
$CAN_BUILD_X86_64 is [0]
➜  sgx (next-20220210_) ✗ make CC="cache gcc"
$CAN_BUILD_X86_64 is [0]

Correct examples:
➜  sgx (next-20220210_) ✗ make CC=gcc
$CAN_BUILD_X86_64 is [1]
➜  sgx (next-20220210_) ✗ make
$CAN_BUILD_X86_64 is [1]
➜  sgx (next-20220210_) ✗ make CC="ccache gcc"
$CAN_BUILD_X86_64 is [1]
➜  sgx (next-20220210_) ✗ make CC="gcc"
$CAN_BUILD_X86_64 is [1]
➜  sgx (next-20220210_) ✗ make CC="clang"
$CAN_BUILD_X86_64 is [1]
➜  sgx (next-20220210_) ✗ make CC="ccache clang"
$CAN_BUILD_X86_64 is [1]


