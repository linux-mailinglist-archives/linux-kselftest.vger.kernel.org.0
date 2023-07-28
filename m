Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6194D767687
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 21:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234653AbjG1ToZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 15:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234663AbjG1ToY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 15:44:24 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422953AB1
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Jul 2023 12:44:23 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-7748ca56133so24421239f.0
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Jul 2023 12:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1690573462; x=1691178262;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IVYlyy1phIaXLckqq8rcJcrT6tAP9YEvkh5U2YAuBjA=;
        b=gbxFAICkUa/e7YZ60wNF06DmZ9EZ5eTjiwhQrucRQ4mWWAAWg3UGTbAC5bzenvxANC
         DygyMU802VySwy1Gt+ry6yeNZcqZTl0/N4m47KcwL1CB66nZfXBQCF5cwvAWSGA5lU84
         I8n84qDcqRRotzCACQXhPYr4dFSs9DTZqpJaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690573462; x=1691178262;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IVYlyy1phIaXLckqq8rcJcrT6tAP9YEvkh5U2YAuBjA=;
        b=JhaEGJfGWds0/CTrXCtHnRqRbM19igCmiv9KNH9Rs0FoBhOJ4o/FB/j5VN175QGDSn
         HKqD6aoYZM2kI6EtB+/mJbP/xii9qR33s58xaxXytDKZ0g1MZC67L/MbIrDcqy1g8Zxa
         x34AJ3VBLjuUa2ByzF06IJ4h0GUTCmg+wdWee5Og0JdynNSbz1zQxdghsr4sUJYtCeUF
         OW/COA/4yXfYlikmFcdbSIRon7LauxhYWujapZhbp7tR8Tm3vvuNcscEDk4YnK/uXyGt
         1hqvYFr67o02fDOtYOLLSTLV3L/PeVV686UEwSp6fmOUGu6W/7dDmAZYuu99fnNupBZW
         07Yw==
X-Gm-Message-State: ABy/qLZp3q7WbHSfkYOsi6rr7C0DpzvLlz8TtOM1zfniJt6o6dVKYqa0
        EXb238kDEP6uHt2n8SWx13m5Fg==
X-Google-Smtp-Source: APBJJlHIRa/HS3RQAAZ2Lt+w0eqEG9zHSdhaKUD7cHdWfrtWI3sfdzsr0rUmGfe+T4Wcbja3cx2doQ==
X-Received: by 2002:a6b:c9d3:0:b0:788:2d78:813c with SMTP id z202-20020a6bc9d3000000b007882d78813cmr575240iof.0.1690573462600;
        Fri, 28 Jul 2023 12:44:22 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id f19-20020a056638119300b0042b31920313sm1299632jas.9.2023.07.28.12.44.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 12:44:22 -0700 (PDT)
Message-ID: <ec809279-cc41-7e0f-a567-29400b4c34a9@linuxfoundation.org>
Date:   Fri, 28 Jul 2023 13:44:21 -0600
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
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <5b283f3b-f176-7f19-5db0-1332a94a44be@linuxfoundation.org>
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

On 7/28/23 13:06, Shuah Khan wrote:
> On 7/28/23 12:10, Anjali Kulkarni wrote:
>>
>>
>>> On Jul 28, 2023, at 10:29 AM, Shuah Khan <skhan@linuxfoundation.org> wrote:
>>>
>>> proc_filter test requires root privileges. Add root privilege check
>>> and skip the test. Also fix argument parsing paths to skip in their
>>> error legs.
>>>
>>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
>>> ---
>>> tools/testing/selftests/connector/proc_filter.c | 9 +++++++--
>>> 1 file changed, 7 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/connector/proc_filter.c b/tools/testing/selftests/connector/proc_filter.c
>>> index 4fe8c6763fd8..7b2081b98e5c 100644
>>> --- a/tools/testing/selftests/connector/proc_filter.c
>>> +++ b/tools/testing/selftests/connector/proc_filter.c
>>> @@ -248,7 +248,7 @@ int main(int argc, char *argv[])
>>>
>>>     if (argc > 2) {
>>>         printf("Expected 0(assume no-filter) or 1 argument(-f)\n");
>>> -        exit(1);
>>> +        exit(KSFT_SKIP);
>>>     }
>>>
>>>     if (argc == 2) {
>>> @@ -256,10 +256,15 @@ int main(int argc, char *argv[])
>>>             filter = 1;
>>>         } else {
>>>             printf("Valid option : -f (for filter feature)\n");
>>> -            exit(1);
>>> +            exit(KSFT_SKIP);
>>>         }
>>>     }
>>>
>>> +    if (geteuid()) {
>>> +        printf("Connector test requires root privileges.\n");
>>> +        exit(KSFT_SKIP);
>>> +    }
>>> +
>>
>> I am not sure why you have added this check? proc_filter does not need root privilege to run.
>>
> 
> It failed for me when I ran it saying it requires root privileges.
> I had to run it as root.
> 

The following is what I see when I run the test as non-root
user:

bind failed: Operation not permitted

thanks,
-- Shuah


