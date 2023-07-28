Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D866F7678C6
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Jul 2023 01:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235397AbjG1XAQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 19:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235368AbjG1XAO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 19:00:14 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A41844BE
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Jul 2023 16:00:07 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-77dcff76e35so33168939f.1
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Jul 2023 16:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1690585206; x=1691190006;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MwUGAXlWTnPRJAd9ATS5GD+jmGk/Py4JKBUesXwXH2A=;
        b=d98DSZkdO+2JdfHRp58xcUD6LnqaYwJDvDZpaJyN70zZT2JY8lfcHfRFsUeJzKeUTr
         0HwHHXR9frV3x3oDKHSvV0B3QxqOhanpLkl2q/ayOWCyt7ZeGYK0+RdS7LzDsZzISPDP
         BYu408eZ0VFLR+YSbXX8T/q0e3f+Kf4iKmGcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690585206; x=1691190006;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MwUGAXlWTnPRJAd9ATS5GD+jmGk/Py4JKBUesXwXH2A=;
        b=XJNnZ5MugiUYnO3GUsu4xhtvTqjrUrxHkm7k1Xop4fuBimLGMhveO3q+/1Mu2Fwdew
         VxqQ58sB3oLmW39P/9iKAg4K4pdgDkdsk8WNFu/HL/QGxr9X/qR609/XMoCGafPpsN6K
         T+O3y2z0KcAWH9dcf/u836Q7Xdq5OZ7J2sY5kkTlN4zq5IhDP/Stb3g1jqQjI4ZXRJ4E
         eF90cMAQYD8AQwnn87D0oKMpZjJ2oV5R7HNGtsAPYeUWK0vahBlyZ+kzOeBv0HUGnNal
         7RZHtITSv/UL53JjCb4zqrZMqLwwWiA0ob/+U9OirgGB6oFL4kykYIkkX9R+Y+mY+JNq
         MzUw==
X-Gm-Message-State: ABy/qLY3YnxzfWn2HaBzbrf7v35QVZeXt5RCExT+DQUhl5OCQSGy4HIq
        tYqKOSpBvXcah9oOP6KbwIdhqA==
X-Google-Smtp-Source: APBJJlEl3f9B0LRCAMAtZeUVRE9TycWryhTlDQ4lnn7NVwAHszrL7FHn1XB9SyLXuWu1rJBJoOPqbA==
X-Received: by 2002:a92:cd05:0:b0:345:e438:7381 with SMTP id z5-20020a92cd05000000b00345e4387381mr785191iln.2.1690585206252;
        Fri, 28 Jul 2023 16:00:06 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id w12-20020a02cf8c000000b0042acf934cbasm1346038jar.72.2023.07.28.16.00.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 16:00:05 -0700 (PDT)
Message-ID: <8c92599f-fcb4-3aba-f367-17abd9b52451@linuxfoundation.org>
Date:   Fri, 28 Jul 2023 17:00:05 -0600
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
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <AD8D16A6-63BB-4953-80BA-6410B29416D6@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/28/23 16:40, Anjali Kulkarni wrote:
> 
> 
>> On Jul 28, 2023, at 3:25 PM, Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> On 7/28/23 15:59, Anjali Kulkarni wrote:
>>>> On Jul 28, 2023, at 2:41 PM, Shuah Khan <skhan@linuxfoundation.org> wrote:
>>>>
>>>> On 7/28/23 15:21, Anjali Kulkarni wrote:
>>>>>> On Jul 28, 2023, at 12:44 PM, Shuah Khan <skhan@linuxfoundation.org> wrote:
>>>>>>
>>>>>> On 7/28/23 13:06, Shuah Khan wrote:
>>>>>>> On 7/28/23 12:10, Anjali Kulkarni wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>>> On Jul 28, 2023, at 10:29 AM, Shuah Khan <skhan@linuxfoundation.org> wrote:
>>>>>>>>>
>>>>>>>>> proc_filter test requires root privileges. Add root privilege check
>>>>>>>>> and skip the test. Also fix argument parsing paths to skip in their
>>>>>>>>> error legs.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
>>>>>>>>> ---
>>>>>>>>> tools/testing/selftests/connector/proc_filter.c | 9 +++++++--
>>>>>>>>> 1 file changed, 7 insertions(+), 2 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/tools/testing/selftests/connector/proc_filter.c b/tools/testing/selftests/connector/proc_filter.c
>>>>>>>>> index 4fe8c6763fd8..7b2081b98e5c 100644
>>>>>>>>> --- a/tools/testing/selftests/connector/proc_filter.c
>>>>>>>>> +++ b/tools/testing/selftests/connector/proc_filter.c
>>>>>>>>> @@ -248,7 +248,7 @@ int main(int argc, char *argv[])
>>>>>>>>>
>>>>>>>>> if (argc > 2) {
>>>>>>>>> printf("Expected 0(assume no-filter) or 1 argument(-f)\n");
>>>>>>>>> - exit(1);
>>>>>>>>> + exit(KSFT_SKIP);
>>>>>>>>> }
>>>>>>>>>
>>>>>>>>> if (argc == 2) {
>>>>>>>>> @@ -256,10 +256,15 @@ int main(int argc, char *argv[])
>>>>>>>>> filter = 1;
>>>>>>>>> } else {
>>>>>>>>> printf("Valid option : -f (for filter feature)\n");
>>>>>>>>> - exit(1);
>>>>>>>>> + exit(KSFT_SKIP);
>>>>>>>>> }
>>>>>>>>> }
>>>>>>>>>
>>>>>>>>> + if (geteuid()) {
>>>>>>>>> + printf("Connector test requires root privileges.\n");
>>>>>>>>> + exit(KSFT_SKIP);
>>>>>>>>> + }
>>>>>>>>> +
>>>>>>>>
>>>>>>>> I am not sure why you have added this check? proc_filter does not need root privilege to run.
>>>>>>>>
>>>>>>> It failed for me when I ran it saying it requires root privileges.
>>>>>>> I had to run it as root.
>>>>>>
>>>>>> The following is what I see when I run the test as non-root
>>>>>> user:
>>>>>>
>>>>>> bind failed: Operation not permitted
>>>>>>
>>>>> Yes, that’s expected on a kernel which does not have the kernel patches submitted with this selftest installed on it.
>>>>> So this check for root needs to be removed.
>>>>
>>>> I will send v2 for this patch without root check. I should have
>>>> split the argument error paths and root check anyway.
>>>>
>>>> However, what is strange is if the test run by root, bind() doesn't fail.
>>>> This doesn't make sense to me based on what you said about bind() fails
>>>> if kernel doesn't support the new feature.
>>>>
>>> I didn’t say that - part of the changes introduced by the patches is to remove the root check and add some features on top of existing code.
>>
>> Okay. So what should happen if a root user runs this test on a kernel
>> that doesn't have the kernel patches submitted with this selftest
>> installed on it?
>>
> 
> It will default to the behavior previous to my changes - that is it will report all events as opposed to a subset of events (which is the new feature added by my change)
> 

Okay. Sorry I am unable to follow this explanation. This test has just
been added in commit 73a29531f45fed6423144057d7a844aae46dad9d

Can you please look at the usage for this test:

- What should happen when kernel without filtering is run as
   root or non-root
- What should happen when kernel with filtering is run as
   root or non-root

There seems to be difference in behavior of this test depending
on user privileges. This should reflect in the message the user
sees.

This message "bind failed: Operation not permitted" doesn't tell
user anything - add a better message. Also this needs to be a skip
and not fail.

I just sent v2 without the root check.

thanks,
-- Shuah



