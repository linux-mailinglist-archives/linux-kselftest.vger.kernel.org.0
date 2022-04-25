Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A83F50E52A
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Apr 2022 18:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243148AbiDYQJ1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Apr 2022 12:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243220AbiDYQJ1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Apr 2022 12:09:27 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C1A3D490;
        Mon, 25 Apr 2022 09:06:23 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id i5so2514725wrc.13;
        Mon, 25 Apr 2022 09:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=blqu47Mx6LTQVUbobou5/IDLU7rEhbmkIfzaQTG4m8A=;
        b=gjKm36X2xzU6/RWmcvUlbhbvzopGNlSol4DzQcHwkc9K/t0tVDmqHhoRfYEPi29GcJ
         kRzEbf9aiMGa+r+mb90+qzFN4TdGQg/pNEHUNmfViUmT73B14FvezDUVIM23/S95VUUT
         mKd2E2tS7465n+qcCW7OrUMihCBx0+VbzZAiILJPO6E9a6XhjPcQ+bEOq79WJ+3pd3D1
         DKbpwaA8EH994BQegrs2j1J+hjkIRIXaiTFRznD1Ibwnk8Zl8wNjxwesNYrcdjvL7Nxz
         EweshHsisXNOhFcYCjQ1nTZraraOhSsyNtNI2DnI08UrVc666Mzb0fEA5W7ws1kvBESi
         qozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=blqu47Mx6LTQVUbobou5/IDLU7rEhbmkIfzaQTG4m8A=;
        b=lpTvy9AQ6RWb33WVX4f+u1Bxz2H3zEVpPeEgPZXyQTJ2WvR27I1R15M4PCyjZ4gJfM
         MZY2kXKWvPzXuod+QM6Zlynx+RerBC/k6lPTfCBWIlGz4aDG+8pDFdg98eVwg0sv6fGM
         QFiF8B9xY26xSO7Yw5sNAu+VvusPIOPXVAEPmjpOTiHMxmr9U/sjb1GC9ew9+PokVQLm
         vMl7RQA2VKZ+8LxHFM9y+QlzUy52s15KPZTVzlEDR2tPZ++sQP0H1dl+G/wzWnmql3cS
         MgH9XPGNdKkWw3gjhp36DhRKMJrD1xDN4KuEMUTyxdnON7MwwNRan8tvls088bELKqhD
         Seng==
X-Gm-Message-State: AOAM533fKWvnu0Kod7wTXttSbH4Xnu/2XF5DRvLd0muqYNofb9uHcuHj
        H1WUnPJi3N5QCHFbnTyl40I=
X-Google-Smtp-Source: ABdhPJxdQ5VI2gYM49Wkm/hGApwl+pGt0s+YwzPr0CQUrnwglwNs5Armvx4ev2JcQ/MzApojJZq5pw==
X-Received: by 2002:a5d:6e89:0:b0:20a:de31:18d1 with SMTP id k9-20020a5d6e89000000b0020ade3118d1mr3567340wrz.449.1650902781578;
        Mon, 25 Apr 2022 09:06:21 -0700 (PDT)
Received: from [192.168.0.210] (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.googlemail.com with ESMTPSA id l6-20020a1c2506000000b0038e6fe8e8d8sm11229610wml.5.2022.04.25.09.06.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 09:06:21 -0700 (PDT)
Message-ID: <604ea061-c566-e032-67cf-9bc622aa76ae@gmail.com>
Date:   Mon, 25 Apr 2022 17:06:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] selftests/resctrl: Fix null pointer dereference on open
 failed
Content-Language: en-US
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>, Babu Moger <babu.moger@amd.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        linux-kselftest@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220424211536.1373878-1-colin.i.king@gmail.com>
 <04a35a47-d83a-67a1-5ed4-ba314c6e1ecf@linuxfoundation.org>
From:   "Colin King (gmail)" <colin.i.king@gmail.com>
In-Reply-To: <04a35a47-d83a-67a1-5ed4-ba314c6e1ecf@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 25/04/2022 16:51, Shuah Khan wrote:
> On 4/24/22 3:15 PM, Colin Ian King wrote:
>> Currently if opening /dev/null fails to open then file pointer fp
>> is null and further access to fp via fprintf will cause a null
>> pointer dereference. Fix this by returning a negative error value
>> when a null fp is detected.
>>
> 
> How did you find this problem and how can it be reproduced? Is there
> a case where test fails to open "/dev/null"?

Found with static analysis, cppcheck. Open on /dev/null is unlikely to 
fail, but it's good to fail reliably rather than have a SIGSEGV :-)

Colin

> 
>> Fixes: a2561b12fe39 ("selftests/resctrl: Add built in benchmark")
>> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
>> ---
>>   tools/testing/selftests/resctrl/fill_buf.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/resctrl/fill_buf.c 
>> b/tools/testing/selftests/resctrl/fill_buf.c
>> index 51e5cf22632f..56ccbeae0638 100644
>> --- a/tools/testing/selftests/resctrl/fill_buf.c
>> +++ b/tools/testing/selftests/resctrl/fill_buf.c
>> @@ -121,8 +121,10 @@ static int fill_cache_read(unsigned char 
>> *start_ptr, unsigned char *end_ptr,
>>       /* Consume read result so that reading memory is not optimized 
>> out. */
>>       fp = fopen("/dev/null", "w");
>> -    if (!fp)
>> +    if (!fp) {
>>           perror("Unable to write to /dev/null");
>> +        return -1;
>> +    }
>>       fprintf(fp, "Sum: %d ", ret);
>>       fclose(fp);
>>
> 
> thanks,
> -- Shuah

