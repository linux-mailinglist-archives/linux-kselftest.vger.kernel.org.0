Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 205384BC136
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Feb 2022 21:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237825AbiBRUco (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Feb 2022 15:32:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236885AbiBRUcn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Feb 2022 15:32:43 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9E733354
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Feb 2022 12:32:26 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id c18so6418275ioc.6
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Feb 2022 12:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OC/1gLj8YvBkQUZUrsbQXVRK4g0Fu/RGJXaLX/hTlIE=;
        b=VUYiRxl7QQYbQTzrhoI5VxmE1dxTzS+T3rXsSAxVrz0cjQGpiXzj0nj9SJlA/Tiipu
         jT7JCWmkgKGytpB+3pbmcXMnSKAmmgoorkrtcAdJ7WvEpcRIR47ZaxhN0ItkuEkNcnKf
         PWizezoRmX11NmsQ9ej6OoEbXNe3RiUi+Ff3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OC/1gLj8YvBkQUZUrsbQXVRK4g0Fu/RGJXaLX/hTlIE=;
        b=NZtl95s6QeE9gYiR2VlDHqmaY9kNItI7ScIxMGB4/OuvO9ZbSbs/VKbUmCzQQHS0YU
         0TG4x8BYGIhXdQeRVswE856GR4kRVlVYP4PhlFq0xk/N17+5cBlC5TtOIxCKuc6GodTg
         PexhmNECDamnVvXXLBThRz7Oo+6oM7bKf77rBOR2iTh6aUTBAmU6OMz5+RYWazun4H06
         ui7MgQW5JNEjF0WeTozeCF8aLr5mrsFJOqarGO1BElr3nZwN+HWoGp+plafTuxOQ7KoQ
         YWKC4+iJ572YcmFJXLarKhqitdIzH3+05vlfboGksf8ED1viQknxlM36qRTfmLwPLp3A
         zJGQ==
X-Gm-Message-State: AOAM532Ko+KnxfS+0Fzn9Bs+10zDrYxLKG8Axh5gUB3EMjvX0iF/Oq3Z
        mLLPMKCZIeJ/ZSKQBS7+PUxoMw==
X-Google-Smtp-Source: ABdhPJxcsC5WZ3meD4lZFBEjpZyxGnBOKuRaKCQS2yliGT78npKQinvgqDJK+vrAtBDCyd2ffoFHyQ==
X-Received: by 2002:a05:6638:3043:b0:314:7ce2:4a6e with SMTP id u3-20020a056638304300b003147ce24a6emr6409294jak.258.1645216345652;
        Fri, 18 Feb 2022 12:32:25 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id k11sm4596618iob.23.2022.02.18.12.32.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Feb 2022 12:32:25 -0800 (PST)
Subject: Re: [PATCH v3 4/5] selftests/resctrl: Change the default limited time
 to 120 seconds
To:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220216022641.2998318-1-tan.shaopeng@jp.fujitsu.com>
 <20220216022641.2998318-5-tan.shaopeng@jp.fujitsu.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <fb4db52d-49dc-3df8-8ae7-d2bee80e5a4b@linuxfoundation.org>
Date:   Fri, 18 Feb 2022 13:32:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220216022641.2998318-5-tan.shaopeng@jp.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/15/22 7:26 PM, Shaopeng Tan wrote:
> When testing on a Intel(R) Xeon(R) Gold 6254 CPU @ 3.10GHz the resctrl
> selftests fail due to timeout after exceeding the default time limit of
> 45 seconds. On this system the test takes about 68 seconds.
> Since the failing test by default accesses a fixed size of memory, the
> execution time should not vary significantly between different environment.
> A new default of 120 seconds should be sufficient yet easy to customize
> with the introduction of the "settings" file for reference.
> 
> Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> ---
>  From the perspective of the kselftest framework,
> a rule of "Don't take too long" is a concern.
> To get some better informed opinions from kselftest audience,
> I highlighted this change in the cover letter.
> 
> I adopted most of Reinette's phrase from the discussion in patch v2
> to explain why 120s is appropriate for this test.
> 
>   tools/testing/selftests/resctrl/settings | 1 +
>   1 file changed, 1 insertion(+)
>   create mode 100644 tools/testing/selftests/resctrl/settings
> 
> diff --git a/tools/testing/selftests/resctrl/settings b/tools/testing/selftests/resctrl/settings
> new file mode 100644
> index 000000000000..6091b45d226b
> --- /dev/null
> +++ b/tools/testing/selftests/resctrl/settings
> @@ -0,0 +1 @@
> +timeout=120
> 

This is fine.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
