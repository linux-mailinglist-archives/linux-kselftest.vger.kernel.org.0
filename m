Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C26A4E7D57
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Mar 2022 01:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbiCYUAn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Mar 2022 16:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231750AbiCYUAg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Mar 2022 16:00:36 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580231DE5BE
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Mar 2022 12:50:13 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id k18-20020a9d7012000000b005cdb11186f2so4974300otj.9
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Mar 2022 12:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ofQyyG4WMeOqTiRCxXPOTx0/Wivov5xRx7qheRvM/dU=;
        b=BTLrQc+pAf4GklQAuYbgpvaE5IYRRYpws9LxKmgbafhhKqWOaBUlZ1kY/PXDiEpsMq
         IEPQ3wqmWivLAUs2jTzh1qeNenL6XV9D70b0I+pAEtuxNCS/BVaFrYeETTfp1FhkSq/H
         HZRyRj7J2wnOX45stHVB7hpDU5NLeFcL5MyzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ofQyyG4WMeOqTiRCxXPOTx0/Wivov5xRx7qheRvM/dU=;
        b=dRR34b6aUG7Vh4wUj+a17iOOSuFzH1Nt55UqPUCl6OJPXcseHGzBs7Idp5EYEKRC1q
         02IGboveVSZ8/jq3hQd0d80ZrKDTnogwlAiwnvBtagPWsIDyGF6xnRNrC5TcY07cA/Hl
         4Xcca26To97GLqDk6xhSHFN8T92dM8DomNRc8/Hv4XM53PnGzOitXxe2E6BnQx/sT480
         4aWxv7GLXPgrWFWeYXaWCIFjO61gYOywYxB4uI1KSdIt1O10EhJ83iurMY6I3ZKn1cjo
         sTEa2kULdxMYI2dOfP+B53zeG9W97q9AZTDi57b/V4Tv0BFbBZ0ZB9E89zHmUWDbRXu+
         N2uw==
X-Gm-Message-State: AOAM533KqBcreRaBHyBsMXDFtCBajeh9N63Cyqs7pgY50ctYt0/SeZg3
        SIdPx6awT8hN+YCEwqU39+pNQQ==
X-Google-Smtp-Source: ABdhPJwP3eYIiKNUU8RG4VjsD8Eaq3hNhzdfy5M2puZwXKfZ42MjKCjobbrF6RFOi5BsoaaUw58PxA==
X-Received: by 2002:a9d:67d4:0:b0:5b2:2644:7696 with SMTP id c20-20020a9d67d4000000b005b226447696mr5224826otn.322.1648237810859;
        Fri, 25 Mar 2022 12:50:10 -0700 (PDT)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id r129-20020acac187000000b002ef358c6e0esm3198399oif.49.2022.03.25.12.50.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 12:50:10 -0700 (PDT)
Subject: Re: [PATCH 1/2] selftests: fix header dependency for pid_namespace
 selftests
To:     Axel Rasmussen <axelrasmussen@google.com>,
        Christian Brauner <brauner@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        llvm@lists.linux.dev, Shuah Khan <skhan@linuxfoundation.org>
References: <20220324223929.1893741-1-axelrasmussen@google.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <8fc440d2-2278-b554-3f56-18daa47aef85@linuxfoundation.org>
Date:   Fri, 25 Mar 2022 13:50:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220324223929.1893741-1-axelrasmussen@google.com>
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

On 3/24/22 4:39 PM, Axel Rasmussen wrote:
> The way the test target was defined before, when building with clang we
> get a command line like this:
> 
> clang -Wall -Werror -g -I../../../../usr/include/ \
> 	regression_enomem.c ../pidfd/pidfd.h  -o regression_enomem
> 
> This yields an error, because clang thinks we want to produce both a *.o
> file, as well as a precompiled header:
> 
> clang: error: cannot specify -o when generating multiple output files
> 
> gcc, for whatever reason, doesn't exhibit the same behavior which I
> suspect is why the problem wasn't noticed before.
> 

Thank you fixing this.

> This can be fixed simply by using the LOCAL_HDRS infrastructure the
> selftests lib.mk provides. It does the right think and marks the target
> as depending on the header (so if the header changes, we rebuild), but
> it filters the header out of the compiler command line, so we don't get
> the error described above.
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> ---
>   tools/testing/selftests/pid_namespace/Makefile | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/pid_namespace/Makefile b/tools/testing/selftests/pid_namespace/Makefile
> index dcaefa224ca0..edafaca1aeb3 100644
> --- a/tools/testing/selftests/pid_namespace/Makefile
> +++ b/tools/testing/selftests/pid_namespace/Makefile
> @@ -1,8 +1,8 @@
>   # SPDX-License-Identifier: GPL-2.0
>   CFLAGS += -g -I../../../../usr/include/
>   
> -TEST_GEN_PROGS := regression_enomem
> +TEST_GEN_PROGS = regression_enomem
>   
> -include ../lib.mk
> +LOCAL_HDRS += $(selfdir)/pidfd/pidfd.h
>   
> -$(OUTPUT)/regression_enomem: regression_enomem.c ../pidfd/pidfd.h
> +include ../lib.mk
> 

Will apply this for Linux 5.18-rc2

thanks,
-- Shuah
