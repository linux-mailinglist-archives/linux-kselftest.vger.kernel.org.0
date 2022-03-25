Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5944E7D4B
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Mar 2022 01:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbiCYTwO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Mar 2022 15:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbiCYTvt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Mar 2022 15:51:49 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50C114F103
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Mar 2022 12:37:22 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id h18so1324961ila.12
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Mar 2022 12:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=r+I5kgyO1tHgpBki5iRD8MjPGB+7NsBMCsnuZBuuE14=;
        b=MqzuSUS0yr/bPjYga/LEvUUNISlNPEafGymcHkHdDo8eBX7GHuzf6g/+kmf1KtFnxZ
         bTDwiRZWThL8Xi79vFyjF5gbvRgB1jkq42i+mjP3YSVt2Xw310TWdk6Rzk6jKRAdeDfZ
         aQEhrHQGJCIvIk+EpnbENPp1prNGxCxUVBwzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r+I5kgyO1tHgpBki5iRD8MjPGB+7NsBMCsnuZBuuE14=;
        b=iC+jPFeoZ6HO52JSKZfhibMPnnSr7/2GUYGbWQwIiqjnzflNMCxerQJYw97+Wk5aKO
         zgQh7fd0tch+MuVjjxVYv3qvz7ZxoaPPk0GMkIUbGWISjQWSJGRLi+d9LRGF4f2erqGk
         hgOLiJssxUB4wrQYKXSFyZGD3siPsUuFRRPTwDIXYzLEWbwazIRbZ7Flev0qBv3yUG5+
         rteZU8xr7FXJTWCMoYWO7fJ58alOskCNibA2s9g/g/9P+Jfy/NuiusL3COlak4yvFQVH
         VXxWyWBjVt0u1OGq3TbwVfayUqSb1laYdcCrDqzjyai8dWhGBlYEHCZHFUwCWlmrcNZa
         qLIg==
X-Gm-Message-State: AOAM533tFGk5LkfdXe32IYS2Vk96VWeHuXC2mhYls0Dyqt3GerPk5l/t
        7xFGzmjrxhBBbytMRdB4VsvRsg==
X-Google-Smtp-Source: ABdhPJxOiBqtQQ67WxLOxsMZLU4xmrMIRljTj398xq62z9MSAACWfwac6+zmpEx65WXMd4V0g5PdDg==
X-Received: by 2002:a92:d09:0:b0:2c3:f141:848b with SMTP id 9-20020a920d09000000b002c3f141848bmr137372iln.230.1648237042167;
        Fri, 25 Mar 2022 12:37:22 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id d14-20020a056602184e00b00649673c175asm3449967ioi.25.2022.03.25.12.37.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 12:37:21 -0700 (PDT)
Subject: Re: [PATCH 1/2] selftests/harness: Run TEARDOWN for ASSERT failures
To:     Kees Cook <keescook@chromium.org>, shuah@kernel.org
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220324231907.1363887-1-keescook@chromium.org>
 <20220324231907.1363887-2-keescook@chromium.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f705c381-cbe6-0862-e10f-44f2afdef24d@linuxfoundation.org>
Date:   Fri, 25 Mar 2022 13:37:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220324231907.1363887-2-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/24/22 5:19 PM, Kees Cook wrote:
> The kselftest test harness has traditionally not run the registered
> TEARDOWN handler when a test encountered an ASSERT. This creates
> unexpected situations and tests need to be very careful about using
> ASSERT, which seems a needless hurdle for test writers.
> 
> Because of the harness's design for optional failure handlers, the
> original implementation of ASSERT used an abort() to immediately
> stop execution, but that meant the context for running teardown was
> lost. Instead, use setjmp/longjmp so that teardown can be done.
> 

Thanks for the patch. The change look good to me.

> Failed SETUP routines continue to not be followed by TEARDOWN, though.

Does this mean failed setup() routines have to handle TEARDOWN? What
are guidelines to follow for setup() failures?

Can you add a bit more detail on what you meant by " Failed SETUP
routines continue to not be followed by TEARDOWN, though".

With that:

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
