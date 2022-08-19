Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35CD959A9BB
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Aug 2022 02:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244099AbiHSX6e (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Aug 2022 19:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244075AbiHSX6e (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Aug 2022 19:58:34 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72B22CC86
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Aug 2022 16:58:31 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id x64so4445553iof.1
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Aug 2022 16:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc;
        bh=rDwyn1S5gq2Gin6BY6HLPs0LNmV0efWzRqc/7asC50s=;
        b=Aqx53FzjxjyJpnn5MqTwd5ZZ4M51eJjvQiQdEQENCELxfdHkekZbjwYZKskVRyxaKy
         9lu/9m+TxGhmFLB1ej7ff71j24I1hlX4ms5IuyGy4rHDfkiPxYnUZZ1OIsd4zep+3pxg
         vGEFtzE/UCGpGVkGsXKI5OIDQLaKgeIjNzI2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc;
        bh=rDwyn1S5gq2Gin6BY6HLPs0LNmV0efWzRqc/7asC50s=;
        b=Xz7Ch6dpl2A8c0olqQPYrL5QBYA4l9B3iso5i8ZDqe902mO+X7GDJ6qCpU1a62rf49
         SxAFdjItJo20Eae8v80DmUkKRlItkvNxe+k8NnXithbLZDwopGtS5mpg48m/R9uIDa1L
         QX/FCXMxIkS1KnZG4L7X9ef2p9j+eg5sKxIVHYC/wZgt+Aq31EqDHUFy4MGBUlH0FhwD
         r9GjnHoKgfD1vvod62VAzsFBL2bpOpbDMW0T0r7xdXuoH1DZga1KCU5KBRkKwcgeXvjh
         VwVU2zzk/1dnbK3ZU+lR3zTsXMkxE50hUbqN5ZpHdk0NcrJq8qTRuxZO1fF7QRP5oDgh
         hw4A==
X-Gm-Message-State: ACgBeo2SGjwLUCktSlqpTl6ga9sl92l5kH1gg40Xq52HFYS0n8fGN6yn
        d09xCGKVuyPgOlZwHUYPsz9UFA==
X-Google-Smtp-Source: AA6agR6B/FI7i33mcGyyvznmIp2uha+oR/mT+5YCLx3tovXF3/1OvsY7aMDJVKFnTGj8eHp16GPriA==
X-Received: by 2002:a05:6638:3a1a:b0:343:4ae3:9c0f with SMTP id cn26-20020a0566383a1a00b003434ae39c0fmr4774433jab.271.1660953511132;
        Fri, 19 Aug 2022 16:58:31 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id f3-20020a056638112300b003484f2ea3edsm1546644jar.153.2022.08.19.16.58.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Aug 2022 16:58:30 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] selftests/vm: fix inability to build any vm tests
To:     Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20220819191929.480108-1-axelrasmussen@google.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <23f51904-c6b9-2052-e90c-675a3077cad1@linuxfoundation.org>
Date:   Fri, 19 Aug 2022 17:58:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220819191929.480108-1-axelrasmussen@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/19/22 1:19 PM, Axel Rasmussen wrote:
> When we stopped using KSFT_KHDR_INSTALL, a side effect is we also
> changed the value of `top_srcdir`. This can be seen by looking at the
> code removed by commit 49de12ba06ef
> ("selftests: drop KSFT_KHDR_INSTALL make target").
> 
> (Note though that this commit didn't break this, technically the one
> before it did since that's the one that stopped KSFT_KHDR_INSTALL from
> being used, even though the code was still there.)
> 
> Previously lib.mk reconfigured `top_srcdir` when KSFT_KHDR_INSTALL was
> being used. Now, that's no longer the case.
> 
> As a result, the path to gup_test.h in vm/Makefile was wrong, and
> since it's a dependency of all of the vm binaries none of them could
> be built. Instead, we'd get an "error" like:
> 
>      make[1]: *** No rule to make target
>          '/[...]/tools/testing/selftests/vm/compaction_test', needed by
> 	'all'.  Stop.
> 
> So, modify lib.mk so it once again sets top_srcdir to the root of the
> kernel tree.
> 
> Fixes: f2745dc0ba3d ("selftests: stop using KSFT_KHDR_INSTALL")
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> ---
>   tools/testing/selftests/lib.mk | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
> index 947fc72413e9..d44c72b3abe3 100644
> --- a/tools/testing/selftests/lib.mk
> +++ b/tools/testing/selftests/lib.mk
> @@ -40,6 +40,7 @@ ifeq (0,$(MAKELEVEL))
>       endif
>   endif
>   selfdir = $(realpath $(dir $(filter %/lib.mk,$(MAKEFILE_LIST))))
> +top_srcdir = $(selfdir)/../../..
>   
>   # The following are built by lib.mk common compile rules.
>   # TEST_CUSTOM_PROGS should be used by tests that require
> 

Applied to linux-kselftest fixes for the next rc.

thanks,
-- Shuah
