Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F28F7CE753
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Oct 2023 21:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbjJRTHd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Oct 2023 15:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjJRTHc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Oct 2023 15:07:32 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89304119
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Oct 2023 12:07:30 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-7a66bf80fa3so18854239f.0
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Oct 2023 12:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1697656050; x=1698260850; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/7T63UFHo2QxZQJJnC9K/ZprAjRwwywsiaee/Wxi3/8=;
        b=OiQgogza0racz/81GhemwyeUfek2BI7m5m/yEPl381PAlvEq36CtB35Q9SqC/rgfr8
         Pf0U3Pzz1FDA/J5xeRheFcdFCHap+xwBc1SBnowR71PgaHYYvsfWvrkj2ayS5s68Rsh8
         IvV1VHc1AnXnBR1VcneGrjiCqS1lBnhIFYlws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697656050; x=1698260850;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/7T63UFHo2QxZQJJnC9K/ZprAjRwwywsiaee/Wxi3/8=;
        b=N9va4hmqUMZqLNpaU6RXW7rWfK+QUhkyK72dJzQ5wkq2Cbq4oNLOAEwTSgvIcfZ9uW
         dK42BmiZhntShB7SfBVFoiGbHynATuG8Ef6cVw3Eb/N+xNnQaNgC/SRIT7QUIcmXN/SU
         A17jCCmxmprR3k99KV5sGHiLnkMQy71Wz/SF+vHYVTaBFdzEspNlNop10PwkjT8Lwnv3
         WaYEqq2NvtG+/n/LU2gE5QiQQ+eM2t7fBVsiMqsEl+EqHe8pEjovm7Af1nlRf7lnPUZk
         oRdYg+1t46rSYsPysgC+cH7eXfJRKBJfONmHx3hqEgLo40Ub+dOYc/MEYi5qCfdN/SAx
         rJOw==
X-Gm-Message-State: AOJu0YyciXHfOt3wbvFFQSaWRND7jvGn9lPzf7Qi4sSBGTv+13AGfVFA
        9UDnikI2/ImwH8DYGyTNgc1hJw==
X-Google-Smtp-Source: AGHT+IHCjWF0kEx5u5i8Nu4z+5QEo0u28FkahGZqewYvMftykH8QjzHzfdOaLODX9xhoe2VSG3/H0Q==
X-Received: by 2002:a6b:5801:0:b0:79f:a8c2:290d with SMTP id m1-20020a6b5801000000b0079fa8c2290dmr234365iob.0.1697656049907;
        Wed, 18 Oct 2023 12:07:29 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id 9-20020a5d9c09000000b0079199e52035sm269584ioe.52.2023.10.18.12.07.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 12:07:29 -0700 (PDT)
Message-ID: <2ec50632-15ae-44c3-9851-02660584dd05@linuxfoundation.org>
Date:   Wed, 18 Oct 2023 13:07:28 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] selftests/resctrl: Fix MBM test failure when MBA
 unavailable
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20231018075526.2251-1-ilpo.jarvinen@linux.intel.com>
 <9965dc22-16fb-cadc-2b5f-ff7c2c91a173@linux.intel.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <9965dc22-16fb-cadc-2b5f-ff7c2c91a173@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/18/23 02:10, Ilpo Järvinen wrote:
> On Wed, 18 Oct 2023, Ilpo Järvinen wrote:
> 
>> Commit 20d96b25cc4c ("selftests/resctrl: Fix schemata write error
>> check") exposed a problem in feature detection logic in MBM selftest.
>> If schemata does not support MB:x=x entries, the schemata write to
>> initialize 100% memory bandwidth allocation in mbm_setup() will now
>> fail with -EINVAL due to the error handling corrected by the commit
>> 20d96b25cc4c ("selftests/resctrl: Fix schemata write error check").
>> That commit just uncovers the failed write, it is not wrong itself.
>>
>> If MB:x=x is not supported by schemata, it is safe to assume 100%
>> memory bandwidth is always set. Therefore, the previously ignored error
>> does not make the MBM test itself wrong.
>>
>> Restore the previous behavior of MBM test by checking MB support before
>> attempting to write it into schemata which results in behavior
>> equivalent to ignoring the write error.
>>
>> Fixes: 20d96b25cc4c ("selftests/resctrl: Fix schemata write error check")
>> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
>> ---
> 
> It seems it's too early morning for me so I entirely forgot to describe
> the changes I made... doh. So here it is (nothing earth-shattering here
> really):
> 
> v2:
> - Make checkpatch --strict happy.
>    - Remove () that --strict called "extra".
>    - Duplicate the referenced commit description in the changelog
>      to follow the commit formatting guidelines.
>    - Alter the wording at one of the references into the commit
>      20d96b25cc4c in order to avoid having to copy the description
>      there too.
> - Added Reinette's rev-by.
> 


Thank you. Applied to linux-kselftest next for Linux 6.7-rc1

thanks,
-- Shuah
