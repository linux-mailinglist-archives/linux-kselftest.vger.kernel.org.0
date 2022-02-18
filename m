Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D74A4BC16C
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Feb 2022 21:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239572AbiBRUzb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Feb 2022 15:55:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233019AbiBRUz3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Feb 2022 15:55:29 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447A9174D43
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Feb 2022 12:55:12 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id c18so6486513ioc.6
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Feb 2022 12:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=G+Nk3Ul8ZofZGlECV35FaczdZLbFxqJtymW7VkmqAf4=;
        b=eu8Q571+jCRn45TU/+tjBOUYgv2oxcsCnPicaM5xfdFC0nUZ8NrDf6/0ECOdpVhf05
         c67wuGN2pLB+Z3JonOrf6OlLDQ0NgIzdDQRdMpG8DuS7ht7vVjGhM1KThw/MFe4u/Pmf
         DfwR1f7w9bwIJ+vRiTYgXa4M6nw3zILyPsL/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G+Nk3Ul8ZofZGlECV35FaczdZLbFxqJtymW7VkmqAf4=;
        b=ISo+XOc3qSqmfQHEsvUDGnKZWd2JYqX5+95YjbEyfewgfo5TMwtbfoHBxGLIwA3PyG
         cH0vsh+HigtQuQ8cAXe4LQg8doNm5d1WP+ttsQmqVwnYLCFaagnR0a/mAVyGCxsfUFT9
         YdxjZ1Zx1xjV1iL1S1WL8KaPB1Rinnmg2qMJuD14BDR3PkxXcjlXfSsznYAGddTI5Nbj
         UIRs8yNOzgRlF16e7ghTFzI+Nn61C6ulmhHEL0bkmXdESATJqwf8DtKdRdyhLr2jUq+7
         1izDmdup+Zjc3Nu0CMC/fvPqsw0ns4gzw7wiJj/1VQg2A68Gqj302eCR9Lbm3qrnt4wD
         j/fw==
X-Gm-Message-State: AOAM532J/eX/kk5qzfKmdIKcrf6yMYueYtrxTnHk0otpCJu9xj7QYsDS
        cBkbpQt0sn5kmZIA9Nj+ccG3JQ==
X-Google-Smtp-Source: ABdhPJzC5Ui1Ck6NMD5fi9OWGky4aR3TsSlVjOUWZ8pyscjh+UpvL6znB2junqICWLXmttT9Q1lwTg==
X-Received: by 2002:a05:6602:2f10:b0:638:3f31:f282 with SMTP id q16-20020a0566022f1000b006383f31f282mr6849046iow.171.1645217711703;
        Fri, 18 Feb 2022 12:55:11 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id j14sm4113991ilc.62.2022.02.18.12.55.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Feb 2022 12:55:11 -0800 (PST)
Subject: Re: [PATCH] selftests/resctrl: Add missing SPDX license to Makefile
To:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220216022826.2999382-1-tan.shaopeng@jp.fujitsu.com>
 <4e8297a0-f2a5-2bee-912e-005de2c03b50@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <dd1507fe-4948-38fd-98f1-26e15306b150@linuxfoundation.org>
Date:   Fri, 18 Feb 2022 13:55:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <4e8297a0-f2a5-2bee-912e-005de2c03b50@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/18/22 1:47 PM, Shuah Khan wrote:
> On 2/15/22 7:28 PM, Shaopeng Tan wrote:
>> Add the missing SPDX(SPDX-License-Identifier) license header to
>> tools/testing/selftests/resctrl/Makefile.
>>
>> Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
>> ---
>>   tools/testing/selftests/resctrl/Makefile | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/tools/testing/selftests/resctrl/Makefile b/tools/testing/selftests/resctrl/Makefile
>> index de26638540ba..d661eb2df19b 100644
>> --- a/tools/testing/selftests/resctrl/Makefile
>> +++ b/tools/testing/selftests/resctrl/Makefile
>> @@ -1,3 +1,5 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +
>>   CFLAGS += -g -Wall -O2 -D_FORTIFY_SOURCE=2
>>   TEST_GEN_PROGS := resctrl_tests
>>
> 
> This looks good to me. I will queue this up for Linux 5.18-rc1
> 

Looks like this depends on the 5 patch series. Please include this
one on the same series.

thanks,
-- Shuah
