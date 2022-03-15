Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6CB14D9AB3
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Mar 2022 12:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241395AbiCOL40 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Mar 2022 07:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237957AbiCOL40 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Mar 2022 07:56:26 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4A338BCE;
        Tue, 15 Mar 2022 04:55:14 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id E527E1F4063A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647345312;
        bh=q9ZMDxGcBq6i17q95dW6qoYLwEwtrTbxOKEO8H8wJAc=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=KDGhPyRI3qYm86VqFmBHaGQyL25cUs4aIooCH/NdL5uIuHurRz6L9f81Ypm6iz2L0
         JP+DJDf4fj5WIsnizGU8uJTrVT1Zja2hST2oUwqu79n75NLXAUoXyHoaYUJnMtV8vm
         hiPhMjaClA7xkP6XC7+3RTyqMb0xGGe98LCbD2bDQl2ooLKMQ7jIirW1Nl0Ld0H/Jl
         vcRTgeYZ8nrwS6lr/NzeTDFB4BrypQfhRifexzdZon4ymNJVSRDAnSHWg3gDMG88fV
         8OSefyyevmZZ9xOvuN1qToSCfBiBzL6I4ExRH/ng5nCOOcyx23cMvagXDQwTklGUuK
         kr2zfqs8uKL6Q==
Message-ID: <aaeaefb7-3655-2863-46ae-162bf5ab761c@collabora.com>
Date:   Tue, 15 Mar 2022 16:55:05 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Cc:     usama.anjum@collabora.com, Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel@collabora.com, kernelci@groups.io,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] selftests/lkdtm: add config
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
References: <20220217205620.2512094-1-usama.anjum@collabora.com>
 <20220217205620.2512094-2-usama.anjum@collabora.com>
 <202203091123.33E89F5@keescook>
 <76529762-1a36-142d-0aa9-beb5fa2bb27b@collabora.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <76529762-1a36-142d-0aa9-beb5fa2bb27b@collabora.com>
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

On 3/10/22 10:22 PM, Muhammad Usama Anjum wrote:
> On 3/10/22 12:23 AM, Kees Cook wrote:
>> On Fri, Feb 18, 2022 at 01:56:20AM +0500, Muhammad Usama Anjum wrote:
>>> Add config option which is needed for SLAB_LINEAR_OVERFLOW test. It
>>> needs KASAN enabled.
>>
>> I'd prefer this use the SLAB_DEBUG options -- KASAN is very heavy.
> I'll test it out and update in the next patch version.
> I've tested by removing KASAN and adding the following config:
CONFIG_SLAB=y
CONFIG_DEBUG_SLAB=y

The result of SLAB_LINEAR_OVERFLOW test doesn't remain deterministic in
this config. The task never crashes and hence stack trace never appears.
When executed several times we get "Slab corruption" logs and after some
more tries whole kernel crashes. I've not used DEBUG_SLAB before and not
sure if this is the expected behavior. If we aren't sure, we can keep
KASAN turned on instead.

-- 
Muhammad Usama Anjum
