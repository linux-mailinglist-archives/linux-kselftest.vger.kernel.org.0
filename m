Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E78597630
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Aug 2022 21:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238309AbiHQTAw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 Aug 2022 15:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbiHQTAt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 Aug 2022 15:00:49 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F8960539;
        Wed, 17 Aug 2022 12:00:48 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id f8so3545813wru.13;
        Wed, 17 Aug 2022 12:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:to:from:references
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=XcG5s3Tfu/W3kHM07ebvHVaTnvwR81AmUKWeI5aXt/I=;
        b=kB+XCl9vZ8QZcqlhRAxdBsHv0PxTVMb2z2fovbL5/BONHI6IdHkbBIvwP4XAmsTBkS
         UCPey/jc+ObjQh7xCscH6ph27nKrK83ItPZ2jSmRPKy6+w94DHL5NoVARJ+UDdqfpUwq
         /v6egD3ftjaleMwWo6aPiUc7I3SAAKnd81eHY3W02WX2NbABUTfhBiTpaqi4uRTWq+wp
         5WIM8jaRb5btjaF+kY4uTOSh8w6K8DYut4IMCJYF1/dZHLKNXRXo7/8tnaXF0gtTAqNJ
         PNk4LrcHXm+R6e0VaytvjqeqZnfpI6JbDo3FO580nYjw2Y8t/2dciFOh7rucyt7VHJ2U
         WQog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:to:from:references
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=XcG5s3Tfu/W3kHM07ebvHVaTnvwR81AmUKWeI5aXt/I=;
        b=rJOKBjew/Uh5Iwzxe+C5QDMuz406Whv5ojzLAOKqTJWFyL5UG8M2HZIV++1RBQFbAF
         DNrSbEDcmoz8ZNHN5QdHJRjPDqLbSPtQVi1fwwejteavH+ppne7nf448MJysXgvkavH2
         16c+cXhh/51R+ycpD10+eD/H0BejLB19jKzLyD3rf0pbYzzTdxv5Lgdl7QYlNesazjz8
         xxayEKTYXe7UBOFC7vHdVvwJHTF1k3lBclSuu34aOyL7+o/vOzvab/9fH7SHhBxan5xC
         PXX+yugE3QWAiMnOjntKK8HV9kREP5vY1yE5KIuTJzv3KZu6e6f9NDvhAbvkM/pIX2XL
         iiwQ==
X-Gm-Message-State: ACgBeo0usGP/ea43VtDmnJWzN7VwE4NukMpaoBt77jCKoB2tDEQbgU1w
        ajQeR+/rP7PxGdHL1IWp6l4=
X-Google-Smtp-Source: AA6agR4eWLv0XfY/Im9zh+uIyg0eqPnNknRq2/DocmyKhIE5F4AvzB+tnF+JoJYgqsptaRFsiIG+ow==
X-Received: by 2002:adf:f909:0:b0:225:c35:8242 with SMTP id b9-20020adff909000000b002250c358242mr7915907wrr.550.1660762846612;
        Wed, 17 Aug 2022 12:00:46 -0700 (PDT)
Received: from [192.168.0.209] (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.googlemail.com with ESMTPSA id ay29-20020a05600c1e1d00b003a5fa79005csm3276453wmb.11.2022.08.17.12.00.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Aug 2022 12:00:46 -0700 (PDT)
Message-ID: <ce90b1a4-777f-9cd7-48bc-7d85150d8dcc@gmail.com>
Date:   Wed, 17 Aug 2022 20:00:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH][next] selftests/bpf: Fix spelling mistake "succesful" ->
 "successful"
Content-Language: en-US
References: <20220817083417.50884-1-colin.i.king@gmail.com>
 <818C5CC9-31CA-4DED-90E8-455B03AA9352@fb.com>
From:   "Colin King (gmail)" <colin.i.king@gmail.com>
To:     undisclosed-recipients:;
In-Reply-To: <818C5CC9-31CA-4DED-90E8-455B03AA9352@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 17/08/2022 19:46, Mykola Lysenko wrote:
> Hi Colin,
> 
> Thanks for your patch!
> 
> Can you change patch title to "[PATCH bpf-next] selftests/bpf: Fix spelling mistake "succesful” (kfunc_call.c)”?

Personally I think the kfunc_call.c part in the title is extraneous, 
it's clear it's patching that file from the diff and it's not the style
I've used of the 3,900+ patches I've had accepted in the kernel.

Colin


> 
> Regards,
> Mykola
> 
>> On Aug 17, 2022, at 1:34 AM, Colin Ian King <colin.i.king@gmail.com> wrote:
>>
>> !-------------------------------------------------------------------|
>>   This Message Is From an External Sender
>>
>> |-------------------------------------------------------------------!
>>
>> There is a spelling mistake in an ASSERT_OK literal string. Fix it.
>>
>> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
>> ---
>> tools/testing/selftests/bpf/prog_tests/kfunc_call.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/kfunc_call.c b/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
>> index 351fafa006fb..eede7c304f86 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
>> @@ -109,7 +109,7 @@ static void test_destructive(void)
>> {
>> 	__u64 save_caps = 0;
>>
>> -	ASSERT_OK(test_destructive_open_and_load(), "succesful_load");
>> +	ASSERT_OK(test_destructive_open_and_load(), "successful_load");
>>
>> 	if (!ASSERT_OK(cap_disable_effective(1ULL << CAP_SYS_BOOT, &save_caps), "drop_caps"))
>> 		return;
>> -- 
>> 2.37.1
>>
> 

