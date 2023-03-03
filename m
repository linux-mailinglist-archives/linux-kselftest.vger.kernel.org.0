Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7266AA0B0
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Mar 2023 21:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbjCCUmp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Mar 2023 15:42:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbjCCUmo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Mar 2023 15:42:44 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F745C11C
        for <linux-kselftest@vger.kernel.org>; Fri,  3 Mar 2023 12:42:43 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id s8so2479723ilv.10
        for <linux-kselftest@vger.kernel.org>; Fri, 03 Mar 2023 12:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1677876162;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oyrM72Z2jRw6kq7m7VSw4pzq9PHD7tBUBxa1SWVu9e4=;
        b=GkOa0X+H4TEwHEGgFomKCxJcwnyXh9t8e1mw1QE/tXUy2+3PsHaMlJ1Rzb/0grbShy
         9WNIGAPs4lCU1Wp14AiE4CCopzp+qX2QLUnUUDcpQYC2xEJFMwkchO423Ng5Gc1fUgq4
         5No4AiVK5tDqZDoU5wzQpUCc0fmoMCdjN9Xy0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677876162;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oyrM72Z2jRw6kq7m7VSw4pzq9PHD7tBUBxa1SWVu9e4=;
        b=ShqQq0mucYIvQ5YbGKsudUUIKgkCPSdcjsYTECoCfwBZegX1iGV9iYH7XxsZs4xcRc
         aujn3Bjip2oFSu9cKajR0eAq+mGYAdiSp/AW8BxeqPiZa+NGnXcd60gdrC21lZdCmPgk
         Q1zojn6za03W2PfKxJB0SJwL8zAVl23eUgfUJYnn5RD1fJxFt4EMLQYqhAHppoZ7YSZd
         /RbheMjOmar49howNkENO2oojGYSxhBDuDvpn4AKgwtps0v8/Bl43p8rnCeMTmz7r0FK
         YrJGOFQu7D2/F9Pr8Az54qNw+vCi6efoQePsL7pZFF8kdNy7If+jagXK0rKWvuoyrTFO
         fbLw==
X-Gm-Message-State: AO0yUKV63K18PxPNSBQ/VTEV9sgqPAy0xmb0SRRAzhuZ2+8TMNQRQN7/
        yF6nO1Aw8XLXA0jPce0oNznq5g==
X-Google-Smtp-Source: AK7set+yxi6/63FZ4KhGjkBs/pZftIEsVtHjqjrjK2hLkpNibmRgb4QlXf7NefrJh+o7sY6sSba+ZA==
X-Received: by 2002:a92:194c:0:b0:317:943c:2280 with SMTP id e12-20020a92194c000000b00317943c2280mr1485174ilm.0.1677876162583;
        Fri, 03 Mar 2023 12:42:42 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id h27-20020a056638063b00b003c449a192cdsm978921jar.73.2023.03.03.12.42.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 12:42:41 -0800 (PST)
Message-ID: <5194a1be-73d1-bbc1-879f-bec8353663bc@linuxfoundation.org>
Date:   Fri, 3 Mar 2023 13:42:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] selftests: ir: add config file
Content-Language: en-US
To:     Anders Roxell <anders.roxell@linaro.org>, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230221070301.1323044-1-anders.roxell@linaro.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230221070301.1323044-1-anders.roxell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/21/23 00:03, Anders Roxell wrote:
> Building and running the subsuite 'ir' of kselftest, shows the
> following issues:
>   ir_loopback: module rc-loopback is not found in /lib/modules/6.2.0-rc8-next-20230220 [SKIP]
> 

Why is this an issue? I am not saying this patch isn't necessary.
But the behavior above is valid behavior when config options
aren't enabled?

Perhaps the commit log could reflect that adding config file
with the right options allows the test to run as opposed to
describing a valid behavior is an issue.

> By creating a config file with RC_LOOPBACK=m, LIRC=y and a few
> IR_*DECODER=m in the selftests/ir/ directory the tests pass.
> 
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>   tools/testing/selftests/ir/config | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
>   create mode 100644 tools/testing/selftests/ir/config
> 
> diff --git a/tools/testing/selftests/ir/config b/tools/testing/selftests/ir/config
> new file mode 100644
> index 000000000000..a6031914fa3d
> --- /dev/null
> +++ b/tools/testing/selftests/ir/config
> @@ -0,0 +1,13 @@
> +CONFIG_LIRC=y
> +CONFIG_IR_IMON_DECODER=m
> +CONFIG_IR_JVC_DECODER=m
> +CONFIG_IR_MCE_KBD_DECODER=m
> +CONFIG_IR_NEC_DECODER=m
> +CONFIG_IR_RC5_DECODER=m
> +CONFIG_IR_RC6_DECODER=m
> +CONFIG_IR_RCMM_DECODER=m
> +CONFIG_IR_SANYO_DECODER=m
> +CONFIG_IR_SHARP_DECODER=m
> +CONFIG_IR_SONY_DECODER=m
> +CONFIG_IR_XMP_DECODER=m
> +CONFIG_RC_LOOPBACK=m

thanks,
-- Shuah
