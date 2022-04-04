Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 909194F104D
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Apr 2022 09:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243562AbiDDHwO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 4 Apr 2022 03:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377823AbiDDHwL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 Apr 2022 03:52:11 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8970D34641;
        Mon,  4 Apr 2022 00:50:14 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id D826B1F4575C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649058611;
        bh=wRw+FS/liDk8+4/LHOdlgCTWRsMje4kGNd0ZwHY5Gnk=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=NHqpx3h3QOudoE+UAyxOFAjRtQ7Fele4HRnn0OBhKxSN+omOJGLlH4lcz09TieocE
         fc50/oAY7+J28KdLLY0ygIOrYwHxQr9HScvmTzxfC7Eaa+GF77Xa2ktfQNXZBDXOcv
         3Hd+lc539CxodPHwzX+faOrzeY+CbjWWE2Ekg32okJPCU9AmpjNClgrmbZQUetVYmy
         S6QcqatbmZEVggOZSb0Mtp3C4Tp+RWQy9RypO9CF+6dxUTtlzc784WZH7dHu5FsuUB
         iZodFN8aklsktKu/UxhsqgXuijImuWa+XBB1W6gBoSYzuBDT3K5NXcapTY5jlHaLJm
         d3CIZRMXd+Jpw==
Message-ID: <a9c74cc2-491e-678a-8965-86fa6a6002dc@collabora.com>
Date:   Mon, 4 Apr 2022 12:50:01 +0500
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
 <aaeaefb7-3655-2863-46ae-162bf5ab761c@collabora.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <aaeaefb7-3655-2863-46ae-162bf5ab761c@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Kees,

Any thoughts?

On 3/15/22 4:55 PM, Muhammad Usama Anjum wrote:
> On 3/10/22 10:22 PM, Muhammad Usama Anjum wrote:
>> On 3/10/22 12:23 AM, Kees Cook wrote:
>>> On Fri, Feb 18, 2022 at 01:56:20AM +0500, Muhammad Usama Anjum wrote:
>>>> Add config option which is needed for SLAB_LINEAR_OVERFLOW test. It
>>>> needs KASAN enabled.
>>>
>>> I'd prefer this use the SLAB_DEBUG options -- KASAN is very heavy.
>> I'll test it out and update in the next patch version.
>> I've tested by removing KASAN and adding the following config:
> CONFIG_SLAB=y
> CONFIG_DEBUG_SLAB=y
> 
> The result of SLAB_LINEAR_OVERFLOW test doesn't remain deterministic in
> this config. The task never crashes and hence stack trace never appears.
> When executed several times we get "Slab corruption" logs and after some
> more tries whole kernel crashes. I've not used DEBUG_SLAB before and not
> sure if this is the expected behavior. If we aren't sure, we can keep
> KASAN turned on instead.
> 

-- 
Muhammad Usama Anjum
