Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21932767602
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 21:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjG1TGL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 15:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232728AbjG1TGJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 15:06:09 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C970F3C00
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Jul 2023 12:06:07 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-78706966220so24184539f.1
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Jul 2023 12:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1690571167; x=1691175967;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2NNPy7rPO/lCMMndziW/EpNY1o25V+1fs+jf6cHPRNw=;
        b=V3WIZmmX1oLt2xAoO6oPmEmra9hLlVSj3sfWCo1vExVQ9bS6CgzWyz7ntj2aFCUyZ6
         Y7oP9T0fsCKUlRRAljaGHvxdfli6T5gzo4lH0cvPEirxUkLa3gmWhQ0kFPsJuqfvDbCu
         LUZTX5VYURRzbUgEegK+Sy+j1cwUKSl1m3HEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690571167; x=1691175967;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2NNPy7rPO/lCMMndziW/EpNY1o25V+1fs+jf6cHPRNw=;
        b=UPu2Iug6ISgs9jcZRftQReMx5USANn/Jr4u2I01K5bXT0TRyAAw2PGA23izqB11/+h
         pPKaio3eYCrUsPW4gBreCgksbG6QrRDvrbbdkX92oJ9HlL0f2JuRUjtL3gQxXKUU66cs
         W9Eknn08JewSsZ4vKp/eJGMCLaNtVkeFC3qMwV5oZBZAWaKLbm9Nhm2iXm1SdL5IeC0l
         1HYRWUMuHJMkT7271kmPjdLvGOkwSAn4afc5KfX+JZRhywT9gfP226zHDLJYFPYaevfl
         Rml1zAfFd+hVKPAEIuJswqX8lwCbFjhVLRQVTLS/LmdKHk93woTYA31OIjy22bL4WC/Q
         2GxA==
X-Gm-Message-State: ABy/qLYdwyipvqpTVzY18SwaKqmrwsGtxHI3DRjUSifsYqY/dNkzfxyt
        35MDH7GQ5uJFIEgwavQ+WCB0fQ==
X-Google-Smtp-Source: APBJJlFYf5mHcdGi0eoCo1fq9p8haYuhQJz9Ead1fd5lotZmuPleu9Bjz026xEJF6v89daG/mF711A==
X-Received: by 2002:a05:6602:2b91:b0:77a:ee79:652 with SMTP id r17-20020a0566022b9100b0077aee790652mr724573iov.1.1690571167192;
        Fri, 28 Jul 2023 12:06:07 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id r16-20020a02c850000000b0042ad887f705sm1296747jao.143.2023.07.28.12.06.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 12:06:06 -0700 (PDT)
Message-ID: <5b283f3b-f176-7f19-5db0-1332a94a44be@linuxfoundation.org>
Date:   Fri, 28 Jul 2023 13:06:06 -0600
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
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <0CB227BA-69FD-447F-BE73-2482A6998F7E@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/28/23 12:10, Anjali Kulkarni wrote:
> 
> 
>> On Jul 28, 2023, at 10:29 AM, Shuah Khan <skhan@linuxfoundation.org> wrote:
>>
>> proc_filter test requires root privileges. Add root privilege check
>> and skip the test. Also fix argument parsing paths to skip in their
>> error legs.
>>
>> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
>> ---
>> tools/testing/selftests/connector/proc_filter.c | 9 +++++++--
>> 1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/testing/selftests/connector/proc_filter.c b/tools/testing/selftests/connector/proc_filter.c
>> index 4fe8c6763fd8..7b2081b98e5c 100644
>> --- a/tools/testing/selftests/connector/proc_filter.c
>> +++ b/tools/testing/selftests/connector/proc_filter.c
>> @@ -248,7 +248,7 @@ int main(int argc, char *argv[])
>>
>> 	if (argc > 2) {
>> 		printf("Expected 0(assume no-filter) or 1 argument(-f)\n");
>> -		exit(1);
>> +		exit(KSFT_SKIP);
>> 	}
>>
>> 	if (argc == 2) {
>> @@ -256,10 +256,15 @@ int main(int argc, char *argv[])
>> 			filter = 1;
>> 		} else {
>> 			printf("Valid option : -f (for filter feature)\n");
>> -			exit(1);
>> +			exit(KSFT_SKIP);
>> 		}
>> 	}
>>
>> +	if (geteuid()) {
>> +		printf("Connector test requires root privileges.\n");
>> +		exit(KSFT_SKIP);
>> +	}
>> +
> 
> I am not sure why you have added this check? proc_filter does not need root privilege to run.
> 

It failed for me when I ran it saying it requires root privileges.
I had to run it as root.

thanks,
-- Shuah

