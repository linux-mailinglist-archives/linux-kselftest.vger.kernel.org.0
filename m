Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1663650E9AB
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Apr 2022 21:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245012AbiDYTqu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Apr 2022 15:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245010AbiDYTqt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Apr 2022 15:46:49 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C5D62E5
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Apr 2022 12:43:44 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id z2so18317400oic.6
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Apr 2022 12:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0aTHmoXAI9ckVhBXYqW+KGFj4vYpnPPYoC21k+D/akY=;
        b=A70sBr3ukAROhfERsnpuaTksTAVdueKAyJnBu8vbCjrrsmHFswHleN5SHj+nPSft1I
         fe9cpOiwFa6zM655tmjdpbWmJ13JYdXj8GhM1s0VBXFhbBihidYe+VWMZf/dvBM6CJG8
         sZ4RFJlj8JLv2PxTtHP78xFyrnYdlIj1bfO4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0aTHmoXAI9ckVhBXYqW+KGFj4vYpnPPYoC21k+D/akY=;
        b=Dl6lsCtiuzVhDVDnkXmJikwCK3RKZPhiiAjIWpbjLEIIrcFmtahlYrT/aaj9noVaCn
         TzQVP4+fnaceR0CvM4ZKx1kjQT3uyfGckYDU9TADQrU7RyseHECX1vREk8LoDo1v7WO6
         4il4TcinTrivqvXfwcgldSGp6lws1Gu6gnqeGqeWNkIjXj9r8GCfZGQioMiU6Crq6lC6
         VYnbzNZPS8Q4dRBnp7Fgq0FBXfi9CrDpiYqD3CWgzOY6rHilPFpoLUOdGQnQ8ym80JbP
         nhnIxw8MV65/8EpXoPnI2hllDPxdvoqFDNyXrs9MaQEadfiVLJuZc1glkvG3h8tOQmzy
         XXzg==
X-Gm-Message-State: AOAM532vFkIokLqN60DZOfXi9IIXV1fikuXwUWUy7si2XS7E0A+bAJDk
        0iFzJ8/Shl77DDytBg5FDDsfPg==
X-Google-Smtp-Source: ABdhPJzXOpDGltCA1h4xv5EReUs7VallhjEZ2YKzIS/Apm5GZuqqQnXUisUGfkL/Ki318t8MqD23vg==
X-Received: by 2002:a05:6808:1819:b0:322:9337:9030 with SMTP id bh25-20020a056808181900b0032293379030mr9059262oib.297.1650915823542;
        Mon, 25 Apr 2022 12:43:43 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id q203-20020acad9d4000000b002f8ee3f69e2sm4125393oig.52.2022.04.25.12.43.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 12:43:43 -0700 (PDT)
Subject: Re: [PATCH 2/5] selftests: firmware: Use smaller dictionary for XZ
 compression
To:     Takashi Iwai <tiwai@suse.de>, Luis Chamberlain <mcgrof@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Nick Terrell <terrelln@fb.com>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220421152908.4718-1-tiwai@suse.de>
 <20220421152908.4718-3-tiwai@suse.de>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <156bafb7-19e2-ed2f-63aa-64236d28a06e@linuxfoundation.org>
Date:   Mon, 25 Apr 2022 13:43:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220421152908.4718-3-tiwai@suse.de>
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
> The xz -9 option leads to an unnecessarily too large dictionary that
> isn't really suitable for the kernel firmware loader.  Pass the
> dictionary size explicitly, instead.
> 
> While we're at it, make the xz command call defined in $RUN_XZ for
> simplicity.
> 
> Fixes: 108ae07c5036 ("selftests: firmware: Add compressed firmware tests")
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>   tools/testing/selftests/firmware/fw_filesystem.sh | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/firmware/fw_filesystem.sh b/tools/testing/selftests/firmware/fw_filesystem.sh
> index c2a2a100114b..731f011def78 100755
> --- a/tools/testing/selftests/firmware/fw_filesystem.sh
> +++ b/tools/testing/selftests/firmware/fw_filesystem.sh
> @@ -11,6 +11,8 @@ TEST_REQS_FW_SET_CUSTOM_PATH="yes"
>   TEST_DIR=$(dirname $0)
>   source $TEST_DIR/fw_lib.sh
>   
> +RUN_XZ="xz -C crc32 --lzma2=dict=2MiB"
> +
>   check_mods
>   check_setup
>   verify_reqs
> @@ -410,9 +412,9 @@ test_request_firmware_nowait_custom()
>   	RANDOM_FILE_PATH=$(setup_random_file)
>   	RANDOM_FILE="$(basename $RANDOM_FILE_PATH)"
>   	if [ "$2" = "both" ]; then
> -		xz -9 -C crc32 -k $RANDOM_FILE_PATH
> +		$RUN_XZ -k $RANDOM_FILE_PATH
>   	elif [ "$2" = "xzonly" ]; then
> -		xz -9 -C crc32 $RANDOM_FILE_PATH
> +		$RUN_XZ $RANDOM_FILE_PATH
>   	fi
>   	config_set_name $RANDOM_FILE
>   	config_trigger_async
> @@ -501,7 +503,7 @@ test_request_partial_firmware_into_buf_nofile 2 10
>   test "$HAS_FW_LOADER_COMPRESS" != "yes" && exit 0
>   
>   # test with both files present
> -xz -9 -C crc32 -k $FW
> +$RUN_XZ -k $FW
>   config_set_name $NAME
>   echo
>   echo "Testing with both plain and xz files present..."
> 

Thank you. Looks good to me.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

