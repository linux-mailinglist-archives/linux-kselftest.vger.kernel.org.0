Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA7926D0349
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Mar 2023 13:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbjC3LeP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Mar 2023 07:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbjC3LeN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Mar 2023 07:34:13 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C244C30D2;
        Thu, 30 Mar 2023 04:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=YSIs52b21zyInxWClUTq6s+3r8CYhc2j57pfS1jP3gk=; b=VOF4Yh5YMeiyC/WDVqSSjtymBZ
        37JiST8TqyXEOeq53+EKVBRWs3BX8WUE518j5bz5rFarhSwt8oM3OpQJHlwbYfLbGBLW4nKGM+BmJ
        JZedwNrHNb21Jo7LbsSyA1DrUSXshJrE3GsKb4L65mXr8N8WgKkIKr7Gji6ENi3TufjlkmzBvq/RL
        7zZJfK4Uxb/4apPvViqidyw1tfopJQMf7RCYhQ3hn8MsH55gVVMJ1tTUWVhIkyj7bQUg8+/7pub09
        HM7j0Q8iHYwhbW7VJohScomZVImnoD687uFYDGdVouL9WhDDbDW62eC482mCPT3U0XDqGydtY3GP1
        bH/uWR9A==;
Received: from [177.34.168.16] (helo=[192.168.0.3])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1phqXe-001G8V-Rd; Thu, 30 Mar 2023 13:34:07 +0200
Message-ID: <ac3ec611-f7f5-af08-ec25-00c820d73b87@igalia.com>
Date:   Thu, 30 Mar 2023 08:33:58 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] .gitignore: Exclude KUnit config dot-files
Content-Language: en-US
To:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-kselftest@vger.kernel.org, David Gow <davidgow@google.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Enric Balletbo i Serra <eballetbo@redhat.com>,
        kunit-dev@googlegroups.com, Daniel Latypov <dlatypov@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Alex Gaynor <alex.gaynor@gmail.com>, Andrew Davis <afd@ti.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@google.com>
References: <20230330112743.2331141-1-javierm@redhat.com>
From:   =?UTF-8?Q?Ma=c3=adra_Canal?= <mcanal@igalia.com>
In-Reply-To: <20230330112743.2331141-1-javierm@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Javier,

On 3/30/23 08:27, Javier Martinez Canillas wrote:
> There's a rule to ignore all the dot-files (.*) but we want to exclude the
> config files used by KUnit (.kunitconfig) since those are usually added to
> allow executing test suites without having to enable custom config symbols.
> 
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

This seems like a pretty nice improvement for the KUnit development.

Reviewed-by: Maíra Canal <mcanal@igalia.com>

Best Regards,
- Maíra Canal

> ---
> 
>   .gitignore | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/.gitignore b/.gitignore
> index 70ec6037fa7a..7f86e0837909 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -103,6 +103,7 @@ modules.order
>   !.get_maintainer.ignore
>   !.gitattributes
>   !.gitignore
> +!.kunitconfig
>   !.mailmap
>   !.rustfmt.toml
>   
> 
> base-commit: ffe78bbd512166e0ef1cc4858010b128c510ed7d
