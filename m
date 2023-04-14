Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 029E76E2918
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Apr 2023 19:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjDNRQf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Apr 2023 13:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjDNRQe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Apr 2023 13:16:34 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA6435AA
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Apr 2023 10:16:16 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-760a1c94c28so6757539f.1
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Apr 2023 10:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1681492576; x=1684084576;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Buw5s+0gaY0E7Wr5Fq9wEF/Hip04x/ZdzqMji/rutIE=;
        b=bHOe9TFrH4/VKBj3A+FcHcyWn4+tT1FVtSMNearIfC5jxl102ZfYzmcnXMBsbnCkOI
         aUfliKM8CRbSwru0o9Xh+owG/ntgA2iIemctzdiFqI6Y0eSLWxjKm7vtXeAg1jMTTHqV
         kFhDfQEarNbENRz3xsOU/ErCc7jWXukYsJdqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681492576; x=1684084576;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Buw5s+0gaY0E7Wr5Fq9wEF/Hip04x/ZdzqMji/rutIE=;
        b=G2rlU2o+9peMPx7X0h20eQeJ09R+k4xC0o5Cwj5Lz4M6cDC+Y1/CXU/Piklr0qYmRr
         mkTGCbTpEp/N53P4lMFvMq/LDsbBgkZNtuHisnxsxzxHcEaIzJAybr3HU+SEQlQPZsoc
         e7GlUgnThC7pRPRDeKvlAWB2L2PkcFrn4qFd3cEV6mHfqiULM/3iv00ffIfi5F7fq2Aw
         HJcoY1BT2jIyZh2kWFEZMqg4aXFSUxZdeXd0wlWb7dTaCA99GFQrDO55x1wzA3mP6AbO
         6nzKPsBUH9y/HO3ivzj1UdCjWwWUeSL8noaVbzfwOUCIqqHGt717mKu0mZvkUBZ7AzQY
         3kRg==
X-Gm-Message-State: AAQBX9c+b2ew3Nd+GSVBgrVoQu0xipS1uWY5eEGetU8UFvdkhDYqAl2B
        KeaAc3glkA6YRo9TvgQ7rqy4HR0ecC1rMCa2+b4=
X-Google-Smtp-Source: AKy350aw0bhU7xOJqHwM0rxF0YzFhl8KIwrx3RgDTncD3q1BnV0dHf+lbfE2WZa/5ZYz4MuHw0sElQ==
X-Received: by 2002:a05:6e02:2147:b0:329:5d05:7801 with SMTP id d7-20020a056e02214700b003295d057801mr1903362ilv.0.1681492576111;
        Fri, 14 Apr 2023 10:16:16 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id 62-20020a021141000000b0040bd8fcaa4bsm765874jaf.63.2023.04.14.10.16.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 10:16:15 -0700 (PDT)
Message-ID: <ed27df52-969c-3d07-7c1d-2dc1566cc850@linuxfoundation.org>
Date:   Fri, 14 Apr 2023 11:16:15 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] selftests/resctrl: Fix incorrect error return on test
 complete
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>, shuah@kernel.org
Cc:     ilpo.jarvinen@linux.intel.com, tan.shaopeng@jp.fujitsu.com,
        fenghua.yu@intel.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <37df0986015ecedec9a0244bdb0aa7c073bfe714.1681490161.git.reinette.chatre@intel.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <37df0986015ecedec9a0244bdb0aa7c073bfe714.1681490161.git.reinette.chatre@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/14/23 10:43, Reinette Chatre wrote:
> An error snuck in between two recent conflicting changes:
> Until recently ->setup() used negative values to indicate
> normal test termination. This was changed in
> commit fa10366cc6f4 ("selftests/resctrl: Allow ->setup() to return
> errors") that transitioned ->setup() to use negative values
> to indicate errors and a new END_OF_TESTS to indicate normal
> termination.
> 
> commit 42e3b093eb7c ("selftests/resctrl: Fix set up schemata with 100%
> allocation on first run in MBM test") continued to use
> negative return to indicate normal test termination.
> 
> Fix mbm_setup() to use the new END_OF_TESTS to indicate
> error-free test termination.
> 
> Fixes: 42e3b093eb7c ("selftests/resctrl: Fix set up schemata with 100% allocation on first run in MBM test")
> Reported-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Link: https://lore.kernel.org/lkml/bb65cce8-54d7-68c5-ef19-3364ec95392a@linux.intel.com/
> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
> Hi Shuah,
> 
> Apologies, this error snuck in between the two series
> merged into kselftest's next this week.
> 

No worries. This is now applied on top of others to linux-kselftest
net.

thanks,
-- Shuah

