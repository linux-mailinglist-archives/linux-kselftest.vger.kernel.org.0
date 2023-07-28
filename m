Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16DB57677CF
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 23:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234668AbjG1Vlt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 17:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbjG1Vls (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 17:41:48 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7389C3C3C
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Jul 2023 14:41:47 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-7835bbeb6a0so35925739f.0
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Jul 2023 14:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1690580507; x=1691185307;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PUeGfALAME/y+62b/SXO+hiWPsPSwFR5PHWXvkAU+T8=;
        b=Mw+UzKX+v2AR5xR6CrIngAYGwUYqbH+HJAyGE/yOu3fpBBRlrUWaQJ+7vWH45qAe+7
         2d0oZycCE9+uPTmHpUPshSXv+vktEYQC7Zfy3+BW2aOuIEyvwuYBKQjoy0AngU6vBWZy
         MY8MIQ3KF5JbE0gGT27G+628Jc8JCS7tAWGbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690580507; x=1691185307;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PUeGfALAME/y+62b/SXO+hiWPsPSwFR5PHWXvkAU+T8=;
        b=J/0kh5KsN7UnAqeyowpCVIQJDtrDYMbt2COx8bwWCtQYi3DDHvDSNXcj2cjAGxRPlC
         lywPhOa3AuO3eXCpHTZaDTQLO4GOQaWYcWLP5Cd6C384TT7fGZqSVyeXyUfBWMZUjAV/
         uWaiHZ0O0EvUSqAiBkbTXq/JVsjIF/xq+Gz5BXuNe1tNe2SeCOiUHoWhVOOxLb64vX7q
         9IT+P50y3i483fGYc+pvesugNzTFVgKdHx/fLPnmCOFL/LI7vCW9iv13UiO5knRpb4OF
         S6E2FQeaQeSKi4ASGVYmwnMdVw2jYvZpP70jPYU4jIVy7mLItrqzojIVBlz8xKn8HaSb
         LmDw==
X-Gm-Message-State: ABy/qLbDDx/4CNVQEzbZRw+4iSy2DcJ1g4bx++qOut6Q6VcgS3hq3v3K
        UvHDrP3JKGptcwMU+BUccgNsEw==
X-Google-Smtp-Source: APBJJlFyBQa1mgyamrkCASTogeoUQVKr+RzrDBBpAvt2qCZaEbqOU6HCiCKufm+Pr1tdeGiROiuUEA==
X-Received: by 2002:a05:6602:1543:b0:780:c6bb:ad8d with SMTP id h3-20020a056602154300b00780c6bbad8dmr1061026iow.0.1690580506837;
        Fri, 28 Jul 2023 14:41:46 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id h3-20020a02c723000000b0041fb2506011sm1338239jao.172.2023.07.28.14.41.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 14:41:46 -0700 (PDT)
Message-ID: <957be0e8-2bdf-80f4-92b7-3b9070c546b3@linuxfoundation.org>
Date:   Fri, 28 Jul 2023 15:41:45 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH next 3/3] selftests:connector: Add root check and fix arg
 error paths to skip
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
Content-Language: en-US
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <16B47831-5F53-4BAF-B347-A1404D2ED264@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/28/23 15:21, Anjali Kulkarni wrote:
> 
> 
>> On Jul 28, 2023, at 12:44 PM, Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> On 7/28/23 13:06, Shuah Khan wrote:
>>> On 7/28/23 12:10, Anjali Kulkarni wrote:
>>>>
>>>>
>>>>> On Jul 28, 2023, at 10:29 AM, Shuah Khan <skhan@linuxfoundation.org> wrote:
>>>>>
>>>>> proc_filter test requires root privileges. Add root privilege check
>>>>> and skip the test. Also fix argument parsing paths to skip in their
>>>>> error legs.
>>>>>
>>>>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
>>>>> ---
>>>>> tools/testing/selftests/connector/proc_filter.c | 9 +++++++--
>>>>> 1 file changed, 7 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/tools/testing/selftests/connector/proc_filter.c b/tools/testing/selftests/connector/proc_filter.c
>>>>> index 4fe8c6763fd8..7b2081b98e5c 100644
>>>>> --- a/tools/testing/selftests/connector/proc_filter.c
>>>>> +++ b/tools/testing/selftests/connector/proc_filter.c
>>>>> @@ -248,7 +248,7 @@ int main(int argc, char *argv[])
>>>>>
>>>>> if (argc > 2) {
>>>>> printf("Expected 0(assume no-filter) or 1 argument(-f)\n");
>>>>> -  exit(1);
>>>>> +  exit(KSFT_SKIP);
>>>>> }
>>>>>
>>>>> if (argc == 2) {
>>>>> @@ -256,10 +256,15 @@ int main(int argc, char *argv[])
>>>>> filter = 1;
>>>>> } else {
>>>>> printf("Valid option : -f (for filter feature)\n");
>>>>> -  exit(1);
>>>>> +  exit(KSFT_SKIP);
>>>>> }
>>>>> }
>>>>>
>>>>> +  if (geteuid()) {
>>>>> +  printf("Connector test requires root privileges.\n");
>>>>> +  exit(KSFT_SKIP);
>>>>> +  }
>>>>> +
>>>>
>>>> I am not sure why you have added this check? proc_filter does not need root privilege to run.
>>>>
>>> It failed for me when I ran it saying it requires root privileges.
>>> I had to run it as root.
>>
>> The following is what I see when I run the test as non-root
>> user:
>>
>> bind failed: Operation not permitted
>>
> 
> Yes, that’s expected on a kernel which does not have the kernel patches submitted with this selftest installed on it.
> So this check for root needs to be removed.
> 

I will send v2 for this patch without root check. I should have
split the argument error paths and root check anyway.

However, what is strange is if the test run by root, bind() doesn't fail.
This doesn't make sense to me based on what you said about bind() fails
if kernel doesn't support the new feature.

That sounds like a problem if the test can be run by non-root user and
it should fail if kernel doesn't have the feature included. I would
think the bind() should fail for root and non-root users.

The bind() failure should be skip if it is an indication of feature
not being supported on the kernel.

thanks,
-- Shuah

