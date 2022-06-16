Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 172EC54EAE8
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jun 2022 22:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378332AbiFPUUn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Jun 2022 16:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378441AbiFPUUe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Jun 2022 16:20:34 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE0A5C75F
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Jun 2022 13:19:56 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id d123so2595087iof.10
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Jun 2022 13:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Dfkm2dRdVxtt3SV4LQI+L9Ln4V2YzTGpPhRrTLCNvI8=;
        b=QSWpvu9pWfaUPtZWEVpGfTPlC4TAzgLKTQazq9FVTmXWjrP7M8kNlU8AN8oqhkIvad
         fQdfo6nlia4m120WWW67tUJiMptbuycHSVLtE4oGfB+/dQMM2VypdNmh+s1ID6SP3flH
         fUryY1g6P4hWm6WOsHv/RZ0oncfsgXIOoT2EQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Dfkm2dRdVxtt3SV4LQI+L9Ln4V2YzTGpPhRrTLCNvI8=;
        b=QCXIogBPn9FMiTIgxCPbROle8tBRLjXoDiJ21K2wZLVlL8EQb3adCcKrkd5D9g8Od+
         RzzYnMjkaD1MPvUmvVHa4393MG8V9hHJ98r+E9QidWi1GCzNRJEA4+PNOq7GBt4KoIOg
         iSpBLWDLLRFWGFcFer4KxxLYI12kVvrmcT3ioJ8ahNnwYUCrvV9o0gJk73M/7R1wpodA
         +sJ+c6WSoksHFM564xTKPJhMIIiDIIa70YBuUa48JsGr5gWjVxCzJK0OMFR67hXQA66o
         VEzczAJrGwOjv+NBs90IJwoNoOImNbWMjs99tCucW2gLspMiRLC6EGVYw/tNtRNpMtmJ
         SvHQ==
X-Gm-Message-State: AJIora9P/z2vVrWyzhT+sbI9VrYQxpr/xoUjJS0BxvAb9+yIEpM08l0E
        GhYGmKN0H1t+Fa2jzBqjGw0aMrPWFsD1og==
X-Google-Smtp-Source: AGRyM1uhjyLP+Q7fR9PxCN3oEeMg+rYmK3g6VQVZBzwNqbTEr5ANByUlMGD6MD/qFY1p/nDnL1xa4A==
X-Received: by 2002:a05:6602:29c3:b0:669:25e5:72d2 with SMTP id z3-20020a05660229c300b0066925e572d2mr3474783ioq.206.1655410795569;
        Thu, 16 Jun 2022 13:19:55 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id s70-20020a025149000000b00331f8fff9a3sm1286586jaa.64.2022.06.16.13.19.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 13:19:55 -0700 (PDT)
Subject: Re: [PATCH] selftests: vm: Fix resource leak when return error
To:     Ding Xiang <dingxiang@cmss.chinamobile.com>,
        akpm@linux-foundation.org, shuah@kernel.org
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220615093629.1330809-1-dingxiang@cmss.chinamobile.com>
 <29be48c7-7178-6f25-c99b-0d11eb967539@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <c2d63817-dc5b-13eb-2698-4ca39bd0d1c1@linuxfoundation.org>
Date:   Thu, 16 Jun 2022 14:19:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <29be48c7-7178-6f25-c99b-0d11eb967539@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/16/22 2:11 PM, Shuah Khan wrote:
> On 6/15/22 3:36 AM, Ding Xiang wrote:
>> When return on an error path, file handle need to be closed
>> to prevent resource leak
>>
>> Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
>> ---
>>   tools/testing/selftests/vm/ksm_tests.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/tools/testing/selftests/vm/ksm_tests.c b/tools/testing/selftests/vm/ksm_tests.c
>> index 2fcf24312da8..f5e4e0bbd081 100644
>> --- a/tools/testing/selftests/vm/ksm_tests.c
>> +++ b/tools/testing/selftests/vm/ksm_tests.c
>> @@ -54,6 +54,7 @@ static int ksm_write_sysfs(const char *file_path, unsigned long val)
>>       }
>>       if (fprintf(f, "%lu", val) < 0) {
>>           perror("fprintf");
>> +        fclose(f);
>>           return 1;
>>       }
>>       fclose(f);
>> @@ -72,6 +73,7 @@ static int ksm_read_sysfs(const char *file_path, unsigned long *val)
>>       }
>>       if (fscanf(f, "%lu", val) != 1) {
>>           perror("fscanf");
>> +        fclose(f);
>>           return 1;
>>       }
>>       fclose(f);
>>
> 
> Looks good to me.
> 
> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
> 

I applied this to linux-kselftest fixes for next rc.

thanks,
-- Shuah
