Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83356DCABB
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Apr 2023 20:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjDJSZQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Apr 2023 14:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjDJSZQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Apr 2023 14:25:16 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF38F1FD3
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Apr 2023 11:25:11 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-328990497e7so261755ab.1
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Apr 2023 11:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1681151111;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sm7LtAbcDUNkpmMGM6egHDD5rNKG1fSqZdlCU05Q4U0=;
        b=iGlfo6CowedeaCcherjWdXFtfAoSyd7SAZMf9ikA3sxC/uRk54iiVoRJlDgeGLFmjl
         CIrttou4msMNl5JmYqgtTJx0M0F2fp7ZM+q+cxX8x/od2mVnogdB1yORoBcxMTSGCnB0
         3Qp92NWWFUMibGaJpBrQqGTKA118H/9/3WnFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681151111;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sm7LtAbcDUNkpmMGM6egHDD5rNKG1fSqZdlCU05Q4U0=;
        b=pgPTB2acdZB6vlnwWNivFTgCMyEAt3KEOFYchixsJyAjdujLvvwLkY+tLroylbWXEI
         rc4XANTpdXID84wMiKqSDtAxJaEBIiP1knlW1F9sBJv+1ECQB3MalwRNXca/pWWirg3Y
         aWQQrGECq94xYS/AC4Arkd5nBAdbCksBGhXkk0/IrHwHUVqslsF+yvFmxVc5qmd3rifX
         1N0Vh77wg/QHM5c/Yg20ZbDTEhr2LpjsDb9n3Ulm31VgiiGEgGAY8dBJqDCQZdY8vtHx
         vLlD8xDeayokcEmlSa5Q4/EbCw+TdVjv+eGYxxdaBDVSr+tFx3sTGT/cxAtnMZF038Wk
         q5Yw==
X-Gm-Message-State: AAQBX9ezuAHdFmAzmH+knoorpuryiU4c+DFLl1R5jJHcZPh9eJxUytG2
        3wf97raR/DZqxuPllHC2oZ18Ng==
X-Google-Smtp-Source: AKy350YRN2ZlVP9+61pcJb2GzFMuyGQ6NY8jbSWom/TWvGBgY9ZGRWPKxKMCTKEWdwetspYi7HLV8w==
X-Received: by 2002:a05:6e02:11a3:b0:325:e065:8bf8 with SMTP id 3-20020a056e0211a300b00325e0658bf8mr3506904ilj.0.1681151111305;
        Mon, 10 Apr 2023 11:25:11 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id m36-20020a056638272400b00408b9c5f9a6sm3408556jav.15.2023.04.10.11.25.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 11:25:10 -0700 (PDT)
Message-ID: <71b769fd-6cde-0ccc-ca41-c94d4737b596@linuxfoundation.org>
Date:   Mon, 10 Apr 2023 12:25:10 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: resctrl selftest patches
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <eaf96617-2f3e-b573-8990-6e9e6b0cb6fd@intel.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <eaf96617-2f3e-b573-8990-6e9e6b0cb6fd@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/10/23 10:43, Reinette Chatre wrote:
> Hi Shuah and kselftest team,
> 
> There are a couple of resctrl selftest patches that are ready for inclusion. They have been percolating on the list for a while without expecting more feedback. All have "Reviewed-by" tags from at least one reviewer. Could you please consider including them into the kselftest repo? There is one minor merge conflict between two of the series for which the snippet below shows resolution.
> 
> [PATCH v8 0/6] Some improvements of resctrl selftest
> https://lore.kernel.org/lkml/20230215083230.3155897-1-tan.shaopeng@jp.fujitsu.com/
> 
> [PATCH v2 0/9] selftests/resctrl: Fixes to error handling logic and cleanups
> https://lore.kernel.org/lkml/20230215130605.31583-1-ilpo.jarvinen@linux.intel.com/
> 

I was waiting for another ack from x86, don't see one.
I just applied them all.

v9 patches are now in linux-kselftest next for Linux 6.4

thanks,
-- Shuah


