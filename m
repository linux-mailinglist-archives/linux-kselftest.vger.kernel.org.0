Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4966461150A
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Oct 2022 16:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbiJ1OrK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Oct 2022 10:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbiJ1Oq1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Oct 2022 10:46:27 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B691F5269
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Oct 2022 07:46:15 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id f27so13492367eje.1
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Oct 2022 07:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KESgtxp98yTHUoZtlQU4tbNiD6fIKzl1fVdZR1xYpYg=;
        b=CREjyA8iKBGLrlScxh1MaZcu5JW1Eaclq9/mWkUrqcirUTHEuerOj6LJNS98dEH485
         x/3tJ4el/hzWs3zDY2z4494TbS/XS/As+ZsdFatVbc8o00L8yJsyVSvtcmF7opWM3efi
         btaOl5H6a9FRYYtHnbKODvAzL23JLPoKteUpYxpnTzccOgY6JQcBVlqYxMN1FF68P/Ju
         DQco4x47+9VnXGtp3e2ECngJOPkiW+AAKQOAmK5Y7KApvQ2TAbOGHSCEVGERS0mS+6Ru
         h/ycWT2PK3iLLXa2s09SwbRlVFXjdBcB3xO2Crsh7jpCKY1/J19Zcde6HBO+HOEhFbYv
         D4Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KESgtxp98yTHUoZtlQU4tbNiD6fIKzl1fVdZR1xYpYg=;
        b=UhIEMTBpttgRNb7ws4bEb6b0BBllsDSBWi1227zUcJFStnnSWx6+zb6KAGYk3sa4RK
         94zrt+2HZv7/qxboFBMARf4KY1L883oBIgGcJun7MoQSai1kI+hnc3wbIp0a5CsOe/QF
         o26hQA3AVNdmIvDdJ6T/YQBW/ojLTKIxErAEq/V59hy98OMt8vIs7M38mXni6FN0f8oS
         mxSowAD+BdI8paFOb+6Mf/yWS4D4490rUDH/9V7b3zvav7QIMQSYmyuDR9hL6thKvwQI
         Y1BUUSlvotHB7bxC4zdkvoXNVzMqP8LyofkY8r3mmqCZ4ct1mGMb3QYOEswoyFmRH5zc
         MdIg==
X-Gm-Message-State: ACrzQf0S1fJa5zedZc4pRJaiVpk4vrMJcF7Tz0H8cBrk+V5Ng0UQEfgy
        EGJ3NUbBgnNbEsEQq1mASKjktWqPw10QxPiUEEzTwA==
X-Google-Smtp-Source: AMsMyM4c+jz9XP+w/jlcPjuQFKcHTiI57Ya7OGNFA+kO/tG8L0ZPHIf3166jtslk3EZHPl3mfQFm5XZRMutOpzCZzhc=
X-Received: by 2002:a17:907:2705:b0:7ad:8460:7d30 with SMTP id
 w5-20020a170907270500b007ad84607d30mr10658222ejk.693.1666968374179; Fri, 28
 Oct 2022 07:46:14 -0700 (PDT)
MIME-Version: 1.0
References: <20221028063055.2817-1-liubo03@inspur.com>
In-Reply-To: <20221028063055.2817-1-liubo03@inspur.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Fri, 28 Oct 2022 07:46:02 -0700
Message-ID: <CAGS_qxrzd5MnPgu0wTNiLaPKx-w_5BK2f=i8fuUFXTQcMQi9wA@mail.gmail.com>
Subject: Re: [PATCH] kunit: Include missing header
To:     Bo Liu <liubo03@inspur.com>
Cc:     brendan.higgins@linux.dev, davidgow@google.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 27, 2022 at 11:31 PM Bo Liu <liubo03@inspur.com> wrote:
>
> The file debugfs.c missed the header debugfs.h, which
> resulted on the following warning:
>
> lib/kunit/debugfs.c:28:6: warning: no previous prototype for 'kunit_debugfs_cleanup' [-Wmissing-prototypes]
>  void kunit_debugfs_cleanup(void)
>       ^~~~~~~~~~~~~~~~~~~~~
> lib/kunit/debugfs.c:33:6: warning: no previous prototype for 'kunit_debugfs_init' [-Wmissing-prototypes]
>  void kunit_debugfs_init(void)
>       ^~~~~~~~~~~~~~~~~~
> lib/kunit/debugfs.c:92:6: warning: no previous prototype for 'kunit_debugfs_create_suite' [-Wmissing-prototypes]
>  void kunit_debugfs_create_suite(struct kunit_suite *suite)
>       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> lib/kunit/debugfs.c:108:6: warning: no previous prototype for 'kunit_debugfs_destroy_suite' [-Wmissing-prototypes]
>  void kunit_debugfs_destroy_suite(struct kunit_suite *suite)
>
> Signed-off-by: Bo Liu <liubo03@inspur.com>

Tested-by: Daniel Latypov <dlatypov@google.com>

Looks good to me, one minor nit below.
Brendan, can you take a look when you get a moment?

Question for context: is there a plan to enable this flag by default
or something like that?
I was a bit surprised that -Wall doesn't seem to enable this flag when
I was testing locally.

> ---
>  lib/kunit/debugfs.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/lib/kunit/debugfs.c b/lib/kunit/debugfs.c
> index 1048ef1b8d6e..83411075f614 100644
> --- a/lib/kunit/debugfs.c
> +++ b/lib/kunit/debugfs.c
> @@ -10,6 +10,7 @@
>  #include <kunit/test.h>
>
>  #include "string-stream.h"
> +#include "debugfs.h"

Very minor nit: could we swap the order of these?
#include "debugfs.h"
#include "string-stream.h"
