Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB07351AD26
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 May 2022 20:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354844AbiEDSrx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 May 2022 14:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377014AbiEDSrs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 May 2022 14:47:48 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3F36576
        for <linux-kselftest@vger.kernel.org>; Wed,  4 May 2022 11:44:08 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id z5-20020a17090a468500b001d2bc2743c4so2017915pjf.0
        for <linux-kselftest@vger.kernel.org>; Wed, 04 May 2022 11:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oe43FQiG0EzUZSwlDenCMxyLflMORQ+HtlOEqB8VlVA=;
        b=XnA1TFA9Fh6f4piPiyq/dAyT6o7T0dTKnHiP+r9bZmMi+ttga/YwNQElvol4XlIqg8
         5afqHEdKCXO8QEpF1JeXagIhRUl2ROvzgixxZYFDTn66biqzPl+4+cGrWlckcxesbs0V
         PpV6dmWyTSyykxOdOOANji5wyMDUd4cls3uhg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oe43FQiG0EzUZSwlDenCMxyLflMORQ+HtlOEqB8VlVA=;
        b=rXeNK0sbUp6KWj2BPvnzF5T1bfu6sNU0ZeJV7nbzS6PPEZF8VWe/5l4QB4yOP39G8r
         0ZKuaoRCFtE7vlKjVJDTWH5pyn1RP0bZKXwWk1HpFXw159lO+DsLeml84OAU6C+0MsMr
         f3O0UgRKduyRXTcYd+KRu1XmoGDTu1KBjlZCgc8prTMfHf0ZeMvpf/yVuojKKdMHFGWf
         ds+ruT2o0clsNbf8vbp9eA6z877sQGz2YcRRTL/XKYeo8dg8Kfar/4hkQU92H2TKZoVc
         jo2rz6UT0SiRZPordGZtCMc8kpQ7liICUv3w5b4JFXmu11qyaHzFP5HQV6f73zNyjCeH
         dyBA==
X-Gm-Message-State: AOAM533mUunZIHV7GH4wsV6MblyKbpLcxovv3Faq0T3j2RPO3NdKCBK9
        pityWtfQj/lByZJJd4pzOZMctjzLoAkV7w==
X-Google-Smtp-Source: ABdhPJygwZxM4lRozsPV6mEjYbV+xHDzUeqet/CyZZIxT24CiVokiYTttmc6WzTwJfsOpKtodAXblA==
X-Received: by 2002:a17:903:18b:b0:15e:92b9:783 with SMTP id z11-20020a170903018b00b0015e92b90783mr20706653plg.30.1651689848360;
        Wed, 04 May 2022 11:44:08 -0700 (PDT)
Received: from [192.168.120.250] (wsip-70-166-189-147.ph.ph.cox.net. [70.166.189.147])
        by smtp.gmail.com with ESMTPSA id q12-20020a63f94c000000b003c14af50635sm15141662pgk.77.2022.05.04.11.44.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 11:44:07 -0700 (PDT)
Subject: Re: [PATCH] selftests: mqueue: fix all errors
To:     Sebin Sebastian <mailmesebin00@gmail.com>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220504101720.5201-1-mailmesebin00@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <fb86cba0-e9dd-7e66-d3c9-53b8b89d9469@linuxfoundation.org>
Date:   Wed, 4 May 2022 12:44:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220504101720.5201-1-mailmesebin00@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/4/22 4:17 AM, Sebin Sebastian wrote:
> All errors and styling issues were fixed.
> 
> Signed-off-by: Sebin Sebastian <mailmesebin00@gmail.com>

Please include details on how you found the problems and the log from the tool

> ---
>   .../testing/selftests/mqueue/mq_open_tests.c  | 19 ++++++++++++-------
>   1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/mqueue/mq_open_tests.c b/tools/testing/selftests/mqueue/mq_open_tests.c
> index 9403ac01ba11..c3cb40eae1e9 100644
> --- a/tools/testing/selftests/mqueue/mq_open_tests.c
> +++ b/tools/testing/selftests/mqueue/mq_open_tests.c
> @@ -59,12 +59,12 @@ char *default_queue_path = "/test1";
>   mqd_t queue = -1;
>   
>   static inline void __set(FILE *stream, int value, char *err_msg);
> -void shutdown(int exit_val, char *err_cause, int line_no);
> + void shutdown(int exit_val, char *err_cause, int line_no);
I don't see any change in this line

Including the log helps me understand why these changes are necessary.

thanks,
-- Shuah
