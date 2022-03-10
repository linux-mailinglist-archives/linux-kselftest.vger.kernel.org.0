Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1744D5054
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Mar 2022 18:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245342AbiCJRXh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Mar 2022 12:23:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245169AbiCJRXO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Mar 2022 12:23:14 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBC6199E0D;
        Thu, 10 Mar 2022 09:22:05 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id F04C31F45971
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646932924;
        bh=i/m/QTnQZtO4pBYr23EP3F44855Vs8iYB2YeC5Sa160=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=lQNDzoqQcQHi40W8Q9fdlv96g/Qst7bGRrx7JPFO2XzG8cMyCq2/ljTUvOXR/3h6o
         Q74NFnvFP+tWixKoVB8+4HgPFZZgqKYQDWyisnA10wrjz2r80y4OmnBBQ0ShSylOq7
         o/J00VuAaH3/YLLFbNmRIjvHxGL8oXs+VjFpz4UgjCK3hLKefJoTiLNua9luhZT70Z
         MPSFaZfACdLIC+p5CRmtJmNyiEiTkgOhe5zSuYc9Y6pSXdL0P0nn0tU5ARwrQKceSg
         mGY8CbJbATym5tGu7VP54KoaA3rfzv5iQ8XOmcQ6wIRKo+JOI7+5AsxhVZuUirgC88
         sSk+UGbI3Xb4A==
Message-ID: <62c11336-cac1-8501-19fe-980ebfa050e9@collabora.com>
Date:   Thu, 10 Mar 2022 22:21:57 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Cc:     usama.anjum@collabora.com, Shuah Khan <shuah@kernel.org>,
        kernel@collabora.com, kernelci@groups.io,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] selftests/lkdtm: add config and turn off
 CFI_FORWARD_PROTO
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
References: <20220217205620.2512094-1-usama.anjum@collabora.com>
 <202203091122.A51B31230A@keescook>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <202203091122.A51B31230A@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/10/22 12:22 AM, Kees Cook wrote:
> On Fri, Feb 18, 2022 at 01:56:19AM +0500, Muhammad Usama Anjum wrote:
>> Add config options which are needed for LKDTM sub-tests.
>> STACKLEAK_ERASING test needs GCC_PLUGIN_STACKLEAK config.
>> READ_AFTER_FREE and READ_BUDDY_AFTER_FREE tests need
>> INIT_ON_FREE_DEFAULT_ON config.
>>
>> CFI_FORWARD_PROTO always fails as there is no active CFI system of some
>> kind. Turn it off for now by default until proper support.
> 
> Building under LTO Clang on arm64, this is available. What's the right
> way to add a CONFIG that isn't always available?
> 
> -Kees
Yeah, as you had mentioned
(https://github.com/kernelci/kernelci-project/issues/84#issuecomment-1042015431):

CFI_FORWARD_PROTO is going to fail unless there is an active CFI system
in place of some kind. Right now this depends on arm64+Clang. In the
future, this will be arch-agnostic+Clang, but for the moment, it should
be safe to exclude this test.

In this patch, I'm turning off CFI_FORWARD_PROTO by default here. We can
re-enable it when it becomes arch agnostic. CFI_FORWARD_PROTO cannot be
turned off by using a config. Please let me know your thoughts otherwise.

-- 
Muhammad Usama Anjum
