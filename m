Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38CA6FB59B
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 May 2023 19:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233361AbjEHRBw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 8 May 2023 13:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233059AbjEHRBv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 8 May 2023 13:01:51 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98FA349CF
        for <linux-kselftest@vger.kernel.org>; Mon,  8 May 2023 10:01:50 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-760b6765f36so15737739f.0
        for <linux-kselftest@vger.kernel.org>; Mon, 08 May 2023 10:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1683565310; x=1686157310;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uGkkepj9uIdDICMrxMndUulUvecqVCgR4rzaumC4TR4=;
        b=NsfnKeTWD/dyy+Vv4GYVh6EgWJb1I4xeUJFMzOIzq3y7cFVqS4ha8TvttIiye4Nyr3
         WdTpM1RIhcJ+zpDrAw1EQ0pGum6SO8WvcOg6fi3gM7td4g8AvF/NwY693JJUztXcHK6/
         U2NujO+k5PrYREi2hV921EJ/o1nJe2TrzST9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683565310; x=1686157310;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uGkkepj9uIdDICMrxMndUulUvecqVCgR4rzaumC4TR4=;
        b=HxXv4WFTtbzMEkD9vuRrdlGDz7QORfmOpgLs1MEPGJur/v9xAkqtWnuBGDEWVSBMae
         fDHojtYt6rugcVPCroofhyA+kj7j9d8x4eGGUc0IF3wQduSdZ0euR64Taj0gsiRBfZnH
         0UOLDkEsdWPnNMlUBEl0c5ghP/asWBWe8X4pLc04cAR/vglSadxotRwWi7eKAXJ/S2nI
         8dJVb3XnMVoOAW6DbEStNpPkjWemey+ZbdjNWGU99JaEoV8G8TXM3zeX41/SWHTq7Fqz
         bg/2nlFl8EV2RbHJDsBsYpYG74PzTmDTboVq1fzpO4SHLxyk3xeUoRgWOKPUMwpocVcR
         1Izg==
X-Gm-Message-State: AC+VfDwITljCQ0k8lNmaZBRoIgVFxBjUq9wdu8Cdp0Km6biVrU4E8LOu
        pDLcznWu4ttERuF3uKyk1ZHliw==
X-Google-Smtp-Source: ACHHUZ6jVUf/GP5+8HvKeWtAVlZngdDEaPyLPQzXAJ+T4LtB5UhxLCBKBfTRa1t99uZiyw8f/K4bMQ==
X-Received: by 2002:a6b:5f09:0:b0:760:f7e4:7941 with SMTP id t9-20020a6b5f09000000b00760f7e47941mr5308383iob.0.1683565309907;
        Mon, 08 May 2023 10:01:49 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id z12-20020a5ec90c000000b007635e28bc11sm2324584iol.6.2023.05.08.10.01.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 10:01:49 -0700 (PDT)
Message-ID: <ab721d9a-5209-d961-6eb7-38f5b6272a60@linuxfoundation.org>
Date:   Mon, 8 May 2023 11:01:48 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RESEND PATCH] selftests/sgx: Add "test_encl.elf" to TEST_FILES
Content-Language: en-US
To:     Yi Lai <yi1.lai@intel.com>, jarkko@kernel.org,
        dave.hansen@linux.intel.com, shuah@kernel.org, jethro@fortanix.com,
        bp@suse.de
Cc:     linux-sgx@vger.kernel.org, linux-kselftest@vger.kernel.org,
        heng.su@intel.com, pengfei.xu@intel.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230421033123.445883-1-yi1.lai@intel.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230421033123.445883-1-yi1.lai@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/20/23 21:31, Yi Lai wrote:
> The "test_encl.elf" file used by test_sgx is not installed in
> INSTALL_PATH. Attempting to execute test_sgx causes false negative:
> 
> "
> enclave executable open(): No such file or directory
> main.c:188:unclobbered_vdso:Failed to load the test enclave.
> "
> 
> Add "test_encl.elf" to TEST_FILES so that it will be installed.
> 
> Fixes: 2adcba79e69d ("selftests/x86: Add a selftest for SGX")
> Signed-off-by: Yi Lai <yi1.lai@intel.com>

Applied now to linux-kselftest fixes for the next rc.

Thank for your the fix.

thanks,
-- Shuah

