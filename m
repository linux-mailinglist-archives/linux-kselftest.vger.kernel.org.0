Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6B154A1B5
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jun 2022 23:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbiFMVou (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Jun 2022 17:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234387AbiFMVos (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Jun 2022 17:44:48 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5DC6419
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Jun 2022 14:44:47 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id bf7so8123722oib.11
        for <linux-kselftest@vger.kernel.org>; Mon, 13 Jun 2022 14:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=i0AbTdWcrDZUL/vQXPK2Kl8iFZfr3ZDD8IC3e0CyePQ=;
        b=LFy63I/lYQRqHD5OAOuMxyZyACp2b47R74otgsporlyHdxOZNSrgsmIziwAKAnnQWB
         Z8G6BGfrpPByvQkT7zjMULWLWLNQBBTBIhv02Vc0/JJVWpcp50sppzCWWYKD9dLbF83y
         de2PAVHZKw/IQoebqtAWML+0q0qTm34aZf9vQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i0AbTdWcrDZUL/vQXPK2Kl8iFZfr3ZDD8IC3e0CyePQ=;
        b=r7NmSPR4oWbMBCXzhiRKoUEvdcnH23zUZUk1xFBzQsViMIxwv6O5UKAntAAcORiQHQ
         7Hj/tp7dFlVMbaRee1C6HiV+YxmbNe2vgfOe9usfOWOw9WST8XOqiLVTucxPYfx+zo60
         k4KweTCH+ofFTEYTEKHWOA5nni9pNbhp9IzRk1n+1RUypHs6VQiFkIkwgi212aqMfEDM
         eoNSymOEL/DtXl6T6n8Nr+CEs/nk/grjP8KnkS0LsL/KP/vfkrBSTHAoGtbvlG3GCqtV
         g9RAxj0jbexKO3/c5Bq8d4CBBSWGx3sYp/rXN1/LuWZ/bc06wIncUc+TYaLMWWJ9RHjF
         cfoQ==
X-Gm-Message-State: AOAM531LsAsmAAEJ4v19nBpHIy/V9Rsf7E4ndu66KUNrxjvKrUKYq2mh
        TUZgkH8DiAPvYfCFTsOR0OdRNYtM4ectiA==
X-Google-Smtp-Source: ABdhPJyeYW9g+3oRKWXSLOmX/k1DbQgeLfMZjMKkZf0NzKpmkGZl2pvxqlWqYW8PlEzcJMnwN/Jx5w==
X-Received: by 2002:aca:786:0:b0:32e:3005:813a with SMTP id 128-20020aca0786000000b0032e3005813amr407973oih.135.1655156686996;
        Mon, 13 Jun 2022 14:44:46 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id fw11-20020a056870080b00b000f28a948dd2sm4622742oab.21.2022.06.13.14.44.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jun 2022 14:44:46 -0700 (PDT)
Subject: Re: [PATCH V2] selftests/vm: Add protection_keys tests to run_vmtests
To:     Kalpana Shetty <kalpana.shetty@amd.com>, akpm@linux-foundation.org,
        shuah@kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220610090704.296-1-kalpana.shetty@amd.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <8e7fca3a-096c-7d6c-e43b-9292995ab970@linuxfoundation.org>
Date:   Mon, 13 Jun 2022 15:44:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220610090704.296-1-kalpana.shetty@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/10/22 3:07 AM, Kalpana Shetty wrote:
> Adding "protected_keys" tests to "run_vmtests.sh" would help out to run all VM related tests
> from a single shell script.
> 

Makes sense - can you explain why you can't just run
protection_keys_32 without checks? Why are you checking
for VADDR64? All of this information helps us review the
patch and give you feedback and suggest a different approach.

> Signed-off-by: Kalpana Shetty <kalpana.shetty@amd.com>
> ---
>   Changes in V2:
>    * Added patch description.
> 

thanks,
-- Shuah
