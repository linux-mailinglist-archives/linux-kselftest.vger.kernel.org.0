Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C30A94AB16F
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Feb 2022 19:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiBFS4Q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 6 Feb 2022 13:56:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbiBFS4P (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 6 Feb 2022 13:56:15 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D08AC06173B;
        Sun,  6 Feb 2022 10:56:13 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id 5D0931F43BF4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644173771;
        bh=uaaZrJJw9JcGOK9PIknY172Q55CYu4/NTeJTumEesbs=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=dbVC8Y8YrXLz3RhNZsLuwYFgNVjGwim+vJxB+I1yyVSrr/rDNEL9KlaC12Id4b325
         U3NPu5bFpGd8B9YwK7Bo3KDux1ODIFTiVSVujobY7/noLhOS0Rl9ynQFcCg5XNBv9d
         FL0SiWmCPSqXncJW3NWv+dE2HfiQTQgDzd609eTrmfJnjnmt0vARMedVV0lS5UcyLj
         3LZtq0WZgQjoqwM8En1PqXgc4v8erpDzlJiADGvHPzn2PvzpROQsq8ICa9hf88VxOs
         5YALWhlwgqeLapJ3L4L6J7qqLpsNRb+1z6SrmkX+2+fe9XkUxm+cu5WjVA8stF5Uc8
         D+ajJEHaJB3Hg==
Message-ID: <ca9c39a2-7910-c61f-7b0a-308685490f5e@collabora.com>
Date:   Sun, 6 Feb 2022 23:56:05 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Cc:     usama.anjum@collabora.com, kernel@collabora.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests: futex: set DEFAULT_INSTALL_HDR_PATH
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>,
        Shuah Khan <shuah@kernel.org>
References: <20220119103332.2887370-1-usama.anjum@collabora.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20220119103332.2887370-1-usama.anjum@collabora.com>
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

Thoughts?

On 1/19/22 3:33 PM, Muhammad Usama Anjum wrote:
> If only futex selftest is compiled, uapi header files are copied to the
> selftests/futex/functional directory. This copy isn't needed. Set the
> DEFAULT_INSTALL_HDR_PATH variable to 1 to use the default header install
> path only. This removes extra copy of header file.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>  tools/testing/selftests/futex/functional/Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/futex/functional/Makefile b/tools/testing/selftests/futex/functional/Makefile
> index 5cc38de9d8ea..9a8c3700d773 100644
> --- a/tools/testing/selftests/futex/functional/Makefile
> +++ b/tools/testing/selftests/futex/functional/Makefile
> @@ -24,6 +24,7 @@ TEST_PROGS := run.sh
>  
>  top_srcdir = ../../../../..
>  KSFT_KHDR_INSTALL := 1
> +DEFAULT_INSTALL_HDR_PATH := 1
>  include ../../lib.mk
>  
>  $(TEST_GEN_FILES): $(HEADERS)
