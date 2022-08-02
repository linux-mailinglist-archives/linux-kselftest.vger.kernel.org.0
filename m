Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C43E3587E25
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Aug 2022 16:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234025AbiHBO3l (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 Aug 2022 10:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237286AbiHBO3k (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 Aug 2022 10:29:40 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410F51F2D4
        for <linux-kselftest@vger.kernel.org>; Tue,  2 Aug 2022 07:29:38 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id p81so10763307iod.2
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Aug 2022 07:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=X7Hm0u9qMwzlB0EPKeiGIRJ5T3Cdcf+L/7KSSDvl0hk=;
        b=V3CbIjz0IqwMu9qJT7/0gVE97AFRo6nwNmwyuXcOiFRsIF4gTG63bgySn0IZedd73R
         rWI8/uffPLy8/IaRwVPUOWUgplTP+nC595Hq63FfIRQW7rQsPFe73x9/K1as9/QtP4fI
         l8Zqwp+lo0Dhm+cV6MyiAJTpu9vS7StOH/8PU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X7Hm0u9qMwzlB0EPKeiGIRJ5T3Cdcf+L/7KSSDvl0hk=;
        b=F92veEWKDhDKPVbFfIy9Mn90xeoJVh7ZEC4ywaKagqZdvfLK/uvZoKzbrXB3w325QL
         zb8PN5Fvdy/v73K3py0JEkxGw/J6GQsQxJ3YflhctUBmq2uZ+RJxgxAikpa7G5R4ntzn
         +oCaRDbkPxgfn/WRTZi3H9CSPbR4MqMhr1iZtVKh6W13AwTApFEvt2or6nx9i4UUuQ93
         B0oY648t69ChGYmdVEFHRmYx1mCVoG3ESRfu7KdeIpgy3Z+6PA3GQVmQUDN/Qc0ANakI
         qIkrMK7f/VjLKZ+/VZ7uF7iHrMMFxKvp3hKRhomiDGIQNZnqgrrHbBlm0kXwJwnzgq+E
         4YUQ==
X-Gm-Message-State: AJIora/8ikWflzht5FQD0NdKvv30qKpg+GcZF/2a1zWTH+x9t/8gFE9h
        JqX4hLJ3tJXqDA90e1AQaCRBEw==
X-Google-Smtp-Source: AGRyM1sv2sJthqbr+9zq0hE9qcHjoYD1XTNQ+/fOt/wczi41khz9f7bL+JmEmLJtn1TwRrTbqqma9w==
X-Received: by 2002:a05:6638:37aa:b0:33f:8980:5b50 with SMTP id w42-20020a05663837aa00b0033f89805b50mr8482091jal.103.1659450577255;
        Tue, 02 Aug 2022 07:29:37 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id z11-20020a027a4b000000b00339bae1dab9sm6483462jad.40.2022.08.02.07.29.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 07:29:36 -0700 (PDT)
Subject: Re: [GIT PULL] Kselftest update for Linux 5.20-rc1
To:     =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <430ef132-2ac7-e1be-68ed-3d9c27382143@linuxfoundation.org>
 <2838c247-0648-3828-efb3-e11d7a0616b2@digikod.net>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <84560b65-12ed-da24-3698-45484f80802a@linuxfoundation.org>
Date:   Tue, 2 Aug 2022 08:29:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <2838c247-0648-3828-efb3-e11d7a0616b2@digikod.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/2/22 3:51 AM, Mickaël Salaün wrote:
> Hi,
> 
> This change breaks the Landlock test build when performed on the tools/testing/selftests/landlock directory because the (non-system/up-to-date) kernel headers aren't found. Looking at the use of top_srcdir and HDR_PATH, it seems that multiple subsystems are using this feature. I consider this change a regression.
> 

I did a build test from the top level before sending the pull request
and didn't catch this breakage as a result. This breaks when build is
run from the test directory.

We have had several problems related to khdr_dir and target and decided
to move away from it with this change.

> It also removes the check on up-to-date kernel headers (thanks to the Makefile's target timestamp).
> 
> I wasn't CCed for this change impacting Landlock [1]. Please keep in mind to add at least maintainers and related mailing-lists for changes on related subsystems.
> 

That is the usual practice and if I notice missing maintainers, I add
them. We missed this one.

> The following patch almost revert commit a917dd94b832 ("selftests/landlock: drop deprecated headers dependency") and partially fixes commit 49de12ba06ef ("selftests: drop KSFT_KHDR_INSTALL make target"):
> 

Guillaume,

Will you be able to look at this and send a patch on top? I will
send another pull request before merge window closes?

> --- a/tools/testing/selftests/landlock/Makefile
> +++ b/tools/testing/selftests/landlock/Makefile
> @@ -9,10 +9,13 @@ TEST_GEN_PROGS := $(src_test:.c=)
>   TEST_GEN_PROGS_EXTENDED := true
> 
>   OVERRIDE_TARGETS := 1
> +top_srcdir = ../../../..
>   include ../lib.mk
> 
> +khdr_dir = $(top_srcdir)/usr/include
> +
>   $(OUTPUT)/true: true.c
>       $(LINK.c) $< $(LDLIBS) -o $@ -static
> 
> -$(OUTPUT)/%_test: %_test.c ../kselftest_harness.h common.h
> -    $(LINK.c) $< $(LDLIBS) -o $@ -lcap
> +$(OUTPUT)/%_test: %_test.c $(khdr_dir)/linux/landlock.h ../kselftest_harness.h common.h
> +    $(LINK.c) $< $(LDLIBS) -o $@ -lcap -I$(khdr_dir)
> 
> 
> This doesn't fix the header timestamp check though.
> 

thanks,
-- Shuah
