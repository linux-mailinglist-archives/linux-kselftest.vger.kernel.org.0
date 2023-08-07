Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F56772E20
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Aug 2023 20:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjHGSrW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Aug 2023 14:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjHGSrV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Aug 2023 14:47:21 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460F2171C
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Aug 2023 11:47:20 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-790dcf48546so35642539f.0
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Aug 2023 11:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1691434039; x=1692038839;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+GHKAJRl9DdfBSMeyUURA1mbZ2wW50qlxotvyYewsAY=;
        b=OpkH8wumhnTMobl2+rFAWi6k/fNOlCrequUDfSB75wsgjy99E5Z0E6xhCCQQs+lAg+
         LK3DxfHuSKPFvBzO3xPcxBQbsoNu7bWK3Z7WPZ32OBnbeettCfc09sLDapUmxYfrKwl3
         J7HVA8L6mFHoGp7w/jTUpOBNGPEO1EwEc0hDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691434039; x=1692038839;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+GHKAJRl9DdfBSMeyUURA1mbZ2wW50qlxotvyYewsAY=;
        b=e5tHcNEcmBo1Yg5vACeb5RbC8zwPECGr8S7Rj+hHt3/pchV/YH32qLVRC/VxdWpkg2
         G7j0km+hejzuV35vMZYWo2RS8qFV+WfpgFdlYgivQw57AuzVv87LCsOewhNkT5uZTuDL
         XY3I7f02nHinriuQ5J9GBQQ59780DQCL2IZeXGrvD4K8zjHKKtYuOb858f4cDjTI6v9X
         ORWLP3x4agt+YT2xXlDp/5V9Nl2wrsYkGdG3mibhVtqvzFjLcsZlHNXatGTZAgrx1eGD
         8ZrW1bBQDdjgQ4/OF2KvpSr/yZm0LhErSk56HuToQqs10gisQaMt29mfi0UwEYSDJonu
         B2Ig==
X-Gm-Message-State: AOJu0Yx08I+6DAQ3mcdVGtcc3MS9DN4iVJBbOAn976XRSP36Kmx4wjPA
        v0gLVX9Fq9OpZfziaKkFM/X5uQ==
X-Google-Smtp-Source: AGHT+IHEzbBWbyVa4jckC+DLAXiDracNAkcR8q327mXbiqHsYo+E0XfewTfbdlzUq/xZyHPxLJR8Bg==
X-Received: by 2002:a92:dc84:0:b0:349:67b0:6045 with SMTP id c4-20020a92dc84000000b0034967b06045mr3887892iln.3.1691434039647;
        Mon, 07 Aug 2023 11:47:19 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id fr2-20020a056638658200b0042b0f3f9367sm2695724jab.129.2023.08.07.11.47.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 11:47:19 -0700 (PDT)
Message-ID: <dd320704-a923-2e0e-a8ed-0693d294ee33@linuxfoundation.org>
Date:   Mon, 7 Aug 2023 12:47:18 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 12/19] selftests/resctrl: Remove
 "malloc_and_init_memory" param from run_fill_buf()
To:     Reinette Chatre <reinette.chatre@intel.com>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230717131507.32420-1-ilpo.jarvinen@linux.intel.com>
 <20230717131507.32420-13-ilpo.jarvinen@linux.intel.com>
 <7bba4db8-eaac-238d-b764-89d0ae2a9bba@linuxfoundation.org>
 <856ad175-26f8-90ea-d801-c722d2b19b2e@intel.com>
Content-Language: en-US
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <856ad175-26f8-90ea-d801-c722d2b19b2e@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/25/23 09:26, Reinette Chatre wrote:
> Hi Shuah,
> 
> On 7/25/2023 7:49 AM, Shuah Khan wrote:
>> WARNING: Prefer strscpy over strcpy - see: https://github.com/KSPP/linux/issues/88
>> #233: FILE: tools/testing/selftests/resctrl/resctrl_tests.c:276:
>> +        strcpy(benchmark_cmd[3], "0");
>>
>> WARNING: Prefer strscpy over strcpy - see: https://github.com/KSPP/linux/issues/88
>> #234: FILE: tools/testing/selftests/resctrl/resctrl_tests.c:277:
>> +        strcpy(benchmark_cmd[4], "");
>>
>> total: 0 errors, 2 warnings, 142 lines checked
>>
>> I am applying the patch set to linux-kselftest next - please fix
>> the aboe and send a patch on top of linux-kselftest next
> 
> Is strscpy() available to userspace? I found lib/strscpy_kunit.c
> that makes me think this is currently only available to kernel code.
> 

Very likely. You can ignore the comment. I already applied the
series anyway.

thanks,
-- Shuah

