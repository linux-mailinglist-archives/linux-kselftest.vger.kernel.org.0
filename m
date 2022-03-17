Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B914DC43C
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Mar 2022 11:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbiCQKuY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Mar 2022 06:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiCQKuX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Mar 2022 06:50:23 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8604D170DB9;
        Thu, 17 Mar 2022 03:49:07 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id E500D1F4519A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647514146;
        bh=xW3AOufoexV11X2NAflpjFj8ZRB7g0geMwcYPVtRYFc=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=D4t+t/lzMggF3whMTf6r5BvWPCYZGyKJPdVS9pNy2kDkqG0h2u1z35csTJsfR+LbM
         QMKRuFMlnuAdQM+F6KBWMIPFT+qpxO3rK8pbUC9jBlisf7yc7htukVAiacKnqb5wGL
         dQvxOD8eBrmdbRuOHIAxmMZy5CsPRdHJplbQwNB3qjOv1JlatvxrZo3Oom+ducfEQT
         PG3c9Gc+W0eeMUZSo3FT83g4mn2iDUuj9r864GbEqilIh7lIVHmiF2d4yu2edJ/P4M
         I/0b/Tfv2hYDAuKpru+6nu6BGr91aW6oz4fepuAqfCcbWTGUcOfGsGfkdgHaSLoMSm
         MXIxO2JyIPwOg==
Message-ID: <63c5d7ad-b0b2-9b37-16c3-354ac10858b6@collabora.com>
Date:   Thu, 17 Mar 2022 15:48:59 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Cc:     usama.anjum@collabora.com, kernel@collabora.com,
        kernelci@groups.io, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, keescook@chromium.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Makefile: Fix separate output directory build of
 kselftests
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
References: <20220223191016.1658728-1-usama.anjum@collabora.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20220223191016.1658728-1-usama.anjum@collabora.com>
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

Reminder. Shuah is okay with this patch. Any thoughts?

On 2/24/22 12:10 AM, Muhammad Usama Anjum wrote:
> Build of kselftests fail if kernel's top most Makefile is used for
> running or building kselftests with separate output directory. The
> absolute path is needed to reference other files during this kind of
> build. Set KBUILD_ABS_SRCTREE to use absolute path during the build. It
> fixes the following different types of errors:
> 
> make kselftest-all O=/linux_mainline/build
> Makefile:1080: ../scripts/Makefile.extrawarn: No such file or directory
> 
> make kselftest-all O=build
> Makefile:1080: ../scripts/Makefile.extrawarn: No such file or directory
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> I've tested this patch on top of next-20220217. The latest next-20220222
> have missing patches.
> ---
>  Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 86f633c2809ea..62b3eb8a102ab 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1411,10 +1411,10 @@ tools/%: FORCE
>  
>  PHONY += kselftest
>  kselftest:
> -	$(Q)$(MAKE) -C $(srctree)/tools/testing/selftests run_tests
> +	$(Q)$(MAKE) -C $(srctree)/tools/testing/selftests KBUILD_ABS_SRCTREE=1 run_tests
>  
>  kselftest-%: FORCE
> -	$(Q)$(MAKE) -C $(srctree)/tools/testing/selftests $*
> +	$(Q)$(MAKE) -C $(srctree)/tools/testing/selftests KBUILD_ABS_SRCTREE=1 $*
>  
>  PHONY += kselftest-merge
>  kselftest-merge:

-- 
Muhammad Usama Anjum
