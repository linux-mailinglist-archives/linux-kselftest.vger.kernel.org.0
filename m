Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D6B767993
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Jul 2023 02:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbjG2Acs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 20:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjG2Acr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 20:32:47 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424D630FB
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Jul 2023 17:32:44 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-785d3a53ed6so30375839f.1
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Jul 2023 17:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1690590763; x=1691195563;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MezeuiLBEOiNwGr6mc8OEFUZjD210CTEaCKxvSl/02s=;
        b=UhjoldLRSI3zIiYaM9p2F6FpkgWOVeTVt8nb13ht3+/KQdcoOBaHvfcv1HLgcG5FxT
         yXZKK+5PScPz79elmC8w5c7FLw29TxOortbQajsuDpPTOa2FQU7mrDjdq+wi9qeTjnfD
         Z7fWFR+wCRhdLc+Ss1wPtwF1v3Xfr3kiURxAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690590763; x=1691195563;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MezeuiLBEOiNwGr6mc8OEFUZjD210CTEaCKxvSl/02s=;
        b=AZdGqBDXoOdIfQwd1v3WE+2wEfrL/dIiadF3F9zLCjKL9nyy59G7zPpkOuok3M5iFc
         w/N0JgZs5LOpLAvpj4oUCnay3IcjblrWvX21vTjgy0A7Vdlvs8kGnQYIcldhtP15eYEX
         XPv0tgoPEMB1UPpUE7gO8Iaxp4tcIo6tdZIpaky/hpNc66/ZGmyjriszGQ81TWZNwsI2
         VR9FSNtpZLvje4QngAuTDvr3m8leuXa2u+bAYyEEMoYYWG5A11fDCvLXGoZH8uXOrOwQ
         gFVa7yNpiRHkmr4i7ojJ/SdMPi4PHVjdlitxglSSyfYyUdqfS6QayurKZ6cw6DazOer4
         +SBQ==
X-Gm-Message-State: ABy/qLZ2DHoRnspwYZ03yo2oK7TEXgot5F84yMj9F4rVUUfDnNZiQdrH
        DZgxp2PSX0zQjg4ZMBO1Attl8g==
X-Google-Smtp-Source: APBJJlGeUQeupNYE1Duri1xyVlwYTRT4rlJMoCFWa7y1Av5Zgtc/RJHSrcC/9wBP59HSsFs5HIKQ9w==
X-Received: by 2002:a6b:5d02:0:b0:783:6ec1:65f6 with SMTP id r2-20020a6b5d02000000b007836ec165f6mr972706iob.1.1690590763584;
        Fri, 28 Jul 2023 17:32:43 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id v7-20020a5ec207000000b0078680780694sm1482768iop.34.2023.07.28.17.32.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 17:32:43 -0700 (PDT)
Message-ID: <1e3d6e78-9b74-1da0-cb33-7caea5ce7a3a@linuxfoundation.org>
Date:   Fri, 28 Jul 2023 18:32:42 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH next 3/3] selftests:connector: Add root check and fix arg
 error paths to skip
Content-Language: en-US
To:     Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1690564372.git.skhan@linuxfoundation.org>
 <2c0ac97f9c8e6bd46b60854c136099c0dd4a09f6.1690564372.git.skhan@linuxfoundation.org>
 <0CB227BA-69FD-447F-BE73-2482A6998F7E@oracle.com>
 <5b283f3b-f176-7f19-5db0-1332a94a44be@linuxfoundation.org>
 <ec809279-cc41-7e0f-a567-29400b4c34a9@linuxfoundation.org>
 <16B47831-5F53-4BAF-B347-A1404D2ED264@oracle.com>
 <957be0e8-2bdf-80f4-92b7-3b9070c546b3@linuxfoundation.org>
 <3242346A-9B09-44F7-A062-8456F83372C7@oracle.com>
 <84048d13-9311-36f6-9eb4-8169952580d7@linuxfoundation.org>
 <AD8D16A6-63BB-4953-80BA-6410B29416D6@oracle.com>
 <8c92599f-fcb4-3aba-f367-17abd9b52451@linuxfoundation.org>
 <C3669401-536A-4CB0-80E0-5CCF2DCC36D3@oracle.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <C3669401-536A-4CB0-80E0-5CCF2DCC36D3@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/28/23 18:19, Anjali Kulkarni wrote:
> 
> 
>> On Jul 28, 2023, at 4:00 PM, Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> On 7/28/23 16:40, Anjali Kulkarni wrote:
>>>> On Jul 28, 2023, at 3:25 PM, Shuah Khan <skhan@linuxfoundation.org> wrote:
>>>>
>>>> On 7/28/23 15:59, Anjali Kulkarni wrote:
>>>>>> On Jul 28, 2023, at 2:41 PM, Shuah Khan <skhan@linuxfoundation.org> wrote:
>>>>>>
>>>>>> On 7/28/23 15:21, Anjali Kulkarni wrote:
>>>>>>>> On Jul 28, 2023, at 12:44 PM, Shuah Khan <skhan@linuxfoundation.org> wrote:
>>>>>>>>
>>>>>>>> On 7/28/23 13:06, Shuah Khan wrote:
>>>>>>>>> On 7/28/23 12:10, Anjali Kulkarni wrote:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>> On Jul 28, 2023, at 10:29 AM, Shuah Khan <skhan@linuxfoundation.org> wrote:
>>>>>>>>>>>
>>>>>>>>>>> proc_filter test requires root privileges. Add root privilege check
>>>>>>>>>>> and skip the test. Also fix argument parsing paths to skip in their
>>>>>>>>>>> error legs.
>>>>>>>>>>>
>>>>>>>>>>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
>>>>>>>>>>> ---
>>>>>>>>>>> tools/testing/selftests/connector/proc_filter.c | 9 +++++++--
>>>>>>>>>>> 1 file changed, 7 insertions(+), 2 deletions(-)
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/tools/testing/selftests/connector/proc_filter.c b/tools/testing/selftests/connector/proc_filter.c
>>>>>>>>>>> index 4fe8c6763fd8..7b2081b98e5c 100644
>>>>>>>>>>> --- a/tools/testing/selftests/connector/proc_filter.c
>>>>>>>>>>> +++ b/tools/testing/selftests/connector/proc_filter.c
>>>>>>>>>>> @@ -248,7 +248,7 @@ int main(int argc, char *argv[])
>>>>>>>>>>>
>>>>>>>>>>> if (argc > 2) {
>>>>>>>>>>> printf("Expected 0(assume no-filter) or 1 argument(-f)\n");
>>>>>>>>>>> - exit(1);
>>>>>>>>>>> + exit(KSFT_SKIP);
>>>>>>>>>>> }
>>>>>>>>>>>
>>>>>>>>>>> if (argc == 2) {
>>>>>>>>>>> @@ -256,10 +256,15 @@ int main(int argc, char *argv[])
>>>>>>>>>>> filter = 1;
>>>>>>>>>>> } else {
>>>>>>>>>>> printf("Valid option : -f (for filter feature)\n");
>>>>>>>>>>> - exit(1);
>>>>>>>>>>> + exit(KSFT_SKIP);
>>>>>>>>>>> }
>>>>>>>>>>> }
>>>>>>>>>>>
>>>>>>>>>>> + if (geteuid()) {
>>>>>>>>>>> + printf("Connector test requires root privileges.\n");
>>>>>>>>>>> + exit(KSFT_SKIP);
>>>>>>>>>>> + }
>>>>>>>>>>> +
>>>>>>>>>>
>>>>>>>>>> I am not sure why you have added this check? proc_filter does not need root privilege to run.
>>>>>>>>>>
>>>>>>>>> It failed for me when I ran it saying it requires root privileges.
>>>>>>>>> I had to run it as root.
>>>>>>>>
>>>>>>>> The following is what I see when I run the test as non-root
>>>>>>>> user:
>>>>>>>>
>>>>>>>> bind failed: Operation not permitted
>>>>>>>>
>>>>>>> Yes, that’s expected on a kernel which does not have the kernel patches submitted with this selftest installed on it.
>>>>>>> So this check for root needs to be removed.
>>>>>>
>>>>>> I will send v2 for this patch without root check. I should have
>>>>>> split the argument error paths and root check anyway.
>>>>>>
>>>>>> However, what is strange is if the test run by root, bind() doesn't fail.
>>>>>> This doesn't make sense to me based on what you said about bind() fails
>>>>>> if kernel doesn't support the new feature.
>>>>>>
>>>>> I didn’t say that - part of the changes introduced by the patches is to remove the root check and add some features on top of existing code.
>>>>
>>>> Okay. So what should happen if a root user runs this test on a kernel
>>>> that doesn't have the kernel patches submitted with this selftest
>>>> installed on it?
>>>>
>>> It will default to the behavior previous to my changes - that is it will report all events as opposed to a subset of events (which is the new feature added by my change)
>>
>> Okay. Sorry I am unable to follow this explanation. This test has just
>> been added in commit 73a29531f45fed6423144057d7a844aae46dad9d
> 
> Yes, the test has been added just now, but it also tests kernels previous to the new feature addition. So it is adding a selftest to kernels previous to this commit.
> That is, the connector module in kernel (before my changes) was sending to a listener user process messages for all process events - fork, exit, exec etc. This was only being done if the user process was run as root.
> With my changes, we add filtering based on an option added by user, which filters based on input and gives back to the user only fork, or only exit, or a combination of those. This is a new feature added. In addition to this filtering, we have also made the change to allow user process to be non-root when receiving these messages.
> 
>>
>> Can you please look at the usage for this test:
>>
>> - What should happen when kernel without filtering is run as
>> root or non-root
> 
> By kernel without filtering you mean a kernel without my patches? In that case, it should run only as root - non-root should fail. In this case, it falls back to default behavior before my change, where listener user process gets all messages related to process events. I have not tested this a lot, I am working on testing this on a kernel without my changes.
> 

Then you definitely need better messages when bind() fails
on kernels without the feature. It has to be clear to the
user why the test is exiting without running.

So this is what is needed:
- Check if the test can be run as non-root (whatever that means)
- It is still not clear to me if bind() fails does that mean the
   kernel doesn't doesn't support the new feature.

Since this test essentially behaves differently when the feature
is supported vs. not. So it has to behave consistently somehow
checking for the feature and report correctly.

thanks,
-- Shuah


