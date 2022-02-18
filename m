Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF6A94BBC35
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Feb 2022 16:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbiBRPby (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Feb 2022 10:31:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237030AbiBRPbw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Feb 2022 10:31:52 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC14B83;
        Fri, 18 Feb 2022 07:31:35 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id 80D321F4413F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645198293;
        bh=6kXNcgeXq4h1TBYpaLPf905wOVvFiiD9fLfLvf0P14Q=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=WfG3p1q7AzzJCJJ3GoThT/g1EW7NmMSa8olh9zWGJyRQh+PNkPwNq56wWe3NSA7Ep
         BTekEFNRJMkXJpZXxhQZENQwT0eGLLiFTbSzz7ix9E4Jfy4Wjt76nigFnnFfSbnMmq
         51qAFUuBuUzPiCGFt6cZAGfJOjz1Wvq93vr4VXfKBWHejUIckhgYFPq7v0/2fk3NDO
         1jvPLyzs+YTtJx8q/Do8IFuAnyxSC0XhUz/LA8nFArHHaV1ALCw9yykEeho1b0jHtZ
         9HfV3ipzABi53lRkvhOnt9zMCryuoZ/+9TWokJfHkSWekZaJ1FCIxRCjsfFys8LcW4
         Bm/S45IwXy8Mg==
Message-ID: <31d4c254-2769-db7c-2a28-3f21c2e8bc52@collabora.com>
Date:   Fri, 18 Feb 2022 20:31:24 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Cc:     usama.anjum@collabora.com, kernel@collabora.com,
        kernelci@groups.io,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] selftests/lkdtm: add config and turn off
 CFI_FORWARD_PROTO
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>
References: <20220217205620.2512094-1-usama.anjum@collabora.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20220217205620.2512094-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SCC_BODY_URI_ONLY,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/18/22 1:56 AM, Muhammad Usama Anjum wrote:
> Add config options which are needed for LKDTM sub-tests.
> STACKLEAK_ERASING test needs GCC_PLUGIN_STACKLEAK config.
> READ_AFTER_FREE and READ_BUDDY_AFTER_FREE tests need
> INIT_ON_FREE_DEFAULT_ON config.
> 
> CFI_FORWARD_PROTO always fails as there is no active CFI system of some
> kind. Turn it off for now by default until proper support.
> 
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Fixes: 46d1a0f03d66 ("selftests/lkdtm: Add tests for LKDTM targets")
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Reported-by: "kernelci.org bot" <bot@kernelci.org>
