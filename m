Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48CCD508506
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Apr 2022 11:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377242AbiDTJfT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Apr 2022 05:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377236AbiDTJfS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Apr 2022 05:35:18 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D219BDFFD
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Apr 2022 02:32:32 -0700 (PDT)
Received: from localhost (mdns.lwn.net [45.79.72.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id ACF0C536;
        Wed, 20 Apr 2022 09:32:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net ACF0C536
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1650447150; bh=PbaANqBxm5Yq6NehLblBsrlv5kCxKsUbmAEvoNQEyUI=;
        h=From:To:Subject:In-Reply-To:References:Date:From;
        b=KY5RpXDumXChSYTdA2loCrWgx+BMyPF47wj9XH6RRL6Yvi8WUFJuURoRcIMLv/iPv
         iHT4ZPAuFJdoGPyIvcR0O+KycsHrIF12QJvpQIOL4M22uEjRySOHLcONLT9SHBHV96
         MZGT7V9PnMS8NBMB2NJjsEKHWi3a5sbWSjspfI1sAXZQ3uWURStp0Q+rtsS8a4Kwqn
         y9yCr9tYL7AMFZ24ZFOuvUgn8Puste0esMwO8o0QohgMijrgiisQKg0h5rlgJUtBuZ
         Q7ZMcVN82QQox9/3h9gTXBr98t3TMXqUAF56SA3ky1pS/MG1Rod4r8s5431WIQV6C1
         quH5S4cENZcCg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Andreas-Christian Hagau <ach@hagau.se>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: kunit: change complete_and_exit to
 kthread_complete_and_exit
In-Reply-To: <20220417102807.10b91497ed@19d04f311a0a9de>
References: <20220417102807.10b91497ed@19d04f311a0a9de>
Date:   Wed, 20 Apr 2022 03:32:26 -0600
Message-ID: <877d7k3xsl.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Andreas-Christian Hagau <ach@hagau.se> writes:

> Commit cead18552660 ("exit: Rename complete_and_exit to
> kthread_complete_and_exit") renamed complete_and_exit to
> kthread_complete_and_exit.
>
> Signed-off-by: Andreas-Christian Hagau <ach@hagau.se>
> ---
>  Documentation/dev-tools/kunit/architecture.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/dev-tools/kunit/architecture.rst b/Documentation/dev-tools/kunit/architecture.rst
> index ff9c85a0bff21..cf9e6e3eeae4c 100644
> --- a/Documentation/dev-tools/kunit/architecture.rst
> +++ b/Documentation/dev-tools/kunit/architecture.rst
> @@ -125,7 +125,7 @@ All expectations/assertions are formatted as:
>  		  ``void __noreturn kunit_try_catch_throw(struct kunit_try_catch *try_catch)``.
>  
>  		- ``kunit_try_catch_throw`` calls function:
> -		  ``void complete_and_exit(struct completion *, long) __noreturn;``
> +		  ``void kthread_complete_and_exit(struct completion *, long) __noreturn;``
>  		  and terminates the special thread context.

Applied, thanks.

jon
