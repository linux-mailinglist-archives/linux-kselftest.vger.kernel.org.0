Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA3FB50E9B6
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Apr 2022 21:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245023AbiDYTs6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Apr 2022 15:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242446AbiDYTsy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Apr 2022 15:48:54 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A194B1EEE9
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Apr 2022 12:45:49 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id t15so18343559oie.1
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Apr 2022 12:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZX5Ys886fW/dmB+y6iFegf8FHLGn6ZOTOb6+Agc8SSc=;
        b=W6JtEO0fy4FEMHz7GdcCLTFoa3nMGdRUexkGRjdE4DmKHqVMbwdEAXaRezpnGHYW4Y
         71vyN9AX8EumgZpr7rUGaS1eqcWf4/IpOSaszRZMKJb6ISY4FwHJje4ENHBPoWHefpLS
         TFk3aIxgTGsKEuCiKunc+Qlmmon2BGs648krw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZX5Ys886fW/dmB+y6iFegf8FHLGn6ZOTOb6+Agc8SSc=;
        b=oNmhFafSHzrpoZPn7XBmevtWURaYhJsME+6zNrQH1ddhP9GJdkiThOS/MaoX6HbWOt
         ZdyVRk8vj+i8MHHhpwpC0K1a+fEFIBnj4m9R1K5OSDY2cIOTPqShNYxZ3LZOcpuib5rF
         +aIHWnzU9esOsdHZswju9c8oolb2LkOrtbJvSTp4k3y9WyYURFr243bQXnxJkLcy+itk
         ubXtfL1Az1k+T/gxnFu9RGX5vp1bta9ODlFtk4NQavSP3xRacFALniwEGUfkYJgrJTpk
         W74ZOF1iyqn23tuF0/GSALgvvX/xdyeBXUrfVqoRTwhkREwpTsRqmL57VPTLG4vFWTZq
         8bXg==
X-Gm-Message-State: AOAM531pQ3F5xHyVVk9OxE1RBQEK59CFPYNtMQofdSGSxecYUYHyoq82
        Wn4Zv2LFet2A3XbYrjzAujqgLQ==
X-Google-Smtp-Source: ABdhPJxTQzTraVnJy0Bh8b4T5Ky3qs+HiBT9vzOXWWhdmnV1EHCnCrF8OpXJbepsLkiyfOAAH+XhXw==
X-Received: by 2002:a05:6808:1b06:b0:325:2c06:dadf with SMTP id bx6-20020a0568081b0600b003252c06dadfmr3244673oib.159.1650915949018;
        Mon, 25 Apr 2022 12:45:49 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id c19-20020a05687093d300b000e686d1386csm40543oal.6.2022.04.25.12.45.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 12:45:48 -0700 (PDT)
Subject: Re: [PATCH 3/5] selftests: firmware: Fix the
 request_firmware_into_buf() test for XZ format
To:     Takashi Iwai <tiwai@suse.de>, Luis Chamberlain <mcgrof@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Nick Terrell <terrelln@fb.com>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220421152908.4718-1-tiwai@suse.de>
 <20220421152908.4718-4-tiwai@suse.de>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <da541a1d-8d09-7eb1-fa12-9416d1da3366@linuxfoundation.org>
Date:   Mon, 25 Apr 2022 13:45:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220421152908.4718-4-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 4/21/22 9:29 AM, Takashi Iwai wrote:
> The test uses a different firmware name, and we forgot to adapt for
> the XZ compressed file tests.
> 
> Fixes: 1798045900b7 ("selftests: firmware: Add request_firmware_into_buf tests")
> https://lore.kernel.org/all/20210127154939.13288-1-tiwai@suse.de/
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>   tools/testing/selftests/firmware/fw_filesystem.sh | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/firmware/fw_filesystem.sh b/tools/testing/selftests/firmware/fw_filesystem.sh
> index 731f011def78..3ac09b401a83 100755
> --- a/tools/testing/selftests/firmware/fw_filesystem.sh
> +++ b/tools/testing/selftests/firmware/fw_filesystem.sh
> @@ -504,6 +504,7 @@ test "$HAS_FW_LOADER_COMPRESS" != "yes" && exit 0
>   
>   # test with both files present
>   $RUN_XZ -k $FW
> +$RUN_XZ -k $FW_INTO_BUF
>   config_set_name $NAME
>   echo
>   echo "Testing with both plain and xz files present..."
> @@ -529,6 +530,7 @@ done
>   
>   # test with only xz file present
>   mv "$FW" "${FW}-orig"
> +mv "$FW_INTO_BUF" "${FW_INTO_BUF}-orig"
>   echo
>   echo "Testing with only xz file present..."
>   for i in $(seq 1 5); do
> 

Thank you. Looks good to me.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
