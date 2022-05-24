Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C30532CF7
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 May 2022 17:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237897AbiEXPJB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 May 2022 11:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238379AbiEXPI7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 May 2022 11:08:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 804049C2CB
        for <linux-kselftest@vger.kernel.org>; Tue, 24 May 2022 08:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653404937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F3oBMgO+hCxSnEMbdD2Kd4e6rlC5Fzw1CIMzw7rrxbA=;
        b=Di96Rolb7nRmdU5QqCC/30lgfJ2IOzv/MnumoOnI9x+Tx6+a3dfxrEEswHGjzjYcelZS3v
        5k6WMYLUuCsAPGZwPQ8Be5r3pAGNF/mLlgelUElWVAXQo45HFJGfyM5PpLjBAAcy+htvTN
        wQp+ilmDP5CoiZ4XINXnu0E5QUXLXno=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-495-j5VWtpmRP4GKZne9zA8-yA-1; Tue, 24 May 2022 11:08:56 -0400
X-MC-Unique: j5VWtpmRP4GKZne9zA8-yA-1
Received: by mail-wr1-f70.google.com with SMTP id c11-20020adffb4b000000b0020ff998391dso398155wrs.8
        for <linux-kselftest@vger.kernel.org>; Tue, 24 May 2022 08:08:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=F3oBMgO+hCxSnEMbdD2Kd4e6rlC5Fzw1CIMzw7rrxbA=;
        b=wS8RW7CJBJOO87Qki7z1corfCpnJ7h447fEIZKRyUUQ1iQE5hONA+3vL5Xb7cC3N4l
         +ioJGrKzOED3mg4ufpO0tvWNjivKsd+2Bnu3MSBCackYx2Nk5oGLqrbo8VDBr2/K2mj5
         up3HZLMrcnoxKwy8nfw1GMf/csz1MDLM07mdwK9DfJuDv91SO9hDffH7WPLgoi749kZx
         CRmLnqePJmENucjPRfs3Gk/eJQQJWGIz4m7TwEwGNgHAO7oIhvNjqiJ15NAlm+AsUjGX
         tv8u8Ll14u0VdGFxVJeZ4dcl5RuOQyXuoWRMzopg6O1VfZ6X+0LLY5g2unTBmzeGf8Mp
         B15g==
X-Gm-Message-State: AOAM530kDpjwZPWH9/HKUWoYMjiZFiOEFp+4d1gkrAqJyeolQmFCIyTb
        2TK69o8Xq8dOy2ATCQ5zWDdZ/mPNz4MopT8Wqcd7Wb1XEvTYgv/1cNZ9vDTxuBeaGq6rPecwn9f
        SuhXzjz2kd38e5XckDPH5lYjAsY+t
X-Received: by 2002:a05:6000:1689:b0:20e:6de0:a578 with SMTP id y9-20020a056000168900b0020e6de0a578mr21835309wrd.85.1653404928499;
        Tue, 24 May 2022 08:08:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyemfL+4xKdX8ASaLUEDrPvWxSWigGFv+/SoWVTCc5P4TEem/qKmwuDwfuAEBHhJQFdhsx4xw==
X-Received: by 2002:a05:6000:1689:b0:20e:6de0:a578 with SMTP id y9-20020a056000168900b0020e6de0a578mr21835290wrd.85.1653404928155;
        Tue, 24 May 2022 08:08:48 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id p13-20020adfba8d000000b0020cdcb0efa2sm13400711wrg.34.2022.05.24.08.08.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 May 2022 08:08:47 -0700 (PDT)
Message-ID: <e917386a-1901-3412-1e7b-537e1cd42b2e@redhat.com>
Date:   Tue, 24 May 2022 17:08:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 3/3] selftests/filesystems: add a vfat RENAME_EXCHANGE
 test
Content-Language: en-US
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        linux-kernel@vger.kernel.org
Cc:     Chung-Chiang Cheng <cccheng@synology.com>,
        Lennart Poettering <lennart@poettering.net>,
        Colin Walters <walters@verbum.org>,
        Peter Jones <pjones@redhat.com>,
        Alexander Larsson <alexl@redhat.com>,
        Alberto Ruiz <aruiz@redhat.com>,
        Christian Kellner <ckellner@redhat.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
References: <20220524073604.247790-1-javierm@redhat.com>
 <20220524073604.247790-4-javierm@redhat.com>
 <170151f7-9d46-6b01-e281-0f675a3b523f@collabora.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <170151f7-9d46-6b01-e281-0f675a3b523f@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello Muhammad,

Thanks a lot for your feedback.

On 5/24/22 16:54, Muhammad Usama Anjum wrote:
> On 5/24/22 12:36 PM, Javier Martinez Canillas wrote:
>> diff --git a/tools/testing/selftests/filesystems/fat/Makefile b/tools/testing/selftests/filesystems/fat/Makefile
>> new file mode 100644
>> index 000000000000..93ee73c16828
>> --- /dev/null
>> +++ b/tools/testing/selftests/filesystems/fat/Makefile
>> @@ -0,0 +1,7 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +
>> +TEST_PROGS := run_fat_tests.sh
>> +TEST_GEN_PROGS_EXTENDED := rename_exchange
> Please create a .gitignore file and add rename_exchange to it.
>

Sorry, you mentioned that in the first revision but I missed.

Yes, I'll do it that on v3.
 
>> +CFLAGS += -O2 -g -Wall -I../../../../usr/include/
> Build may fail if kernel on which this test is being build has old
> headers. Always use $(KHDR_INCLUDES) instead of
> "-I../../../../usr/include/" to use the kernel headers from the kernel
> source instead of the natively installed headers.
> 

Sure, I'll do that as well.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

