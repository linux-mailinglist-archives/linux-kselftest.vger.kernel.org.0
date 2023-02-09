Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F51690E3C
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Feb 2023 17:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjBIQT5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Feb 2023 11:19:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjBIQTy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Feb 2023 11:19:54 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C61060BB2
        for <linux-kselftest@vger.kernel.org>; Thu,  9 Feb 2023 08:19:48 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-520dad0a7d2so32007077b3.5
        for <linux-kselftest@vger.kernel.org>; Thu, 09 Feb 2023 08:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GlZRd41K0U+KP9r4brauY7yZjWAhAwpFA59RBThBcPw=;
        b=eYSaPjytR6e1YtVWU78vCni4OsGr+H50oE8zveFDkE72S3iysIkbXHTC29ydnKhB6N
         yzp2dvxWGTmrzP08y7IFyUI1wh1Qr3o5lSzxFdwhWxnHRl/ehjqXFLf8nFMhwOZ3Nrm6
         YHxzrdzH6e5i+pshM0zBQ8okF7Y3yisMErIxhwGKvYXpfIBuWCy/j9RVPQt+B723ShIr
         +/Y/5DPghqgzxgcDTTRq+9gnUQOk0otYh5o0w7fobXbQ6ChZ/vk2xMcn9GfapdZFK2S9
         WjHZMRp2eBMg2QFhiCZ09O5P+8V88640tiOxHIVTNx6G2Bnw7keMa+tBDtR85LQ2iiW6
         tDtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GlZRd41K0U+KP9r4brauY7yZjWAhAwpFA59RBThBcPw=;
        b=QA1oUiIP2oldAF6Gv0JQ8LZ/+n3CVRij1IbC3uuOQTakAGxN3lLqBBeOyeqz9Sp9Cc
         4gTBpdKCiyCi43R+oYTQKJ5pk+ghmZjCtOaUIzUKNGA6s9w0R3YbRI+A6B7bvAmPLZhM
         Ei5QChgu+byYDWpwuoQG77XoYkIKicNIDzr1DTiA4qWDARe9tI36zYN9zLgiSLmnO3sT
         N4GixyUWdCtYPhhhWmGPnf+c4xoFOOcVu4b2nJIBduHQDRQXsCHoTKOeCgQ0AD6vMAJp
         5aHEUGZEGxRjlvCCRjRI43IogDNUkRo3MXKxNLAzEqcCZshYB1+0nvqsCa8jvgjNVCwb
         fpdg==
X-Gm-Message-State: AO0yUKV4NqseLHbZBnmquVITg6vfDxbBfWcWnovy/ymBx5ZDHuJeyBwb
        7dHnKX/xD/nbwJZQUgpgbjW0XX8G1Fpe/KbuB+EahA==
X-Google-Smtp-Source: AK7set8OqEMq5GVQpATraghSz4T7y8K22eJbquY9L4FPI3bDQymX3ttwp3VTYr/LsrqmNZTNfL9Hby4JVEz8JTeXrSo=
X-Received: by 2002:a81:69d5:0:b0:506:8253:3444 with SMTP id
 e204-20020a8169d5000000b0050682533444mr1180650ywc.436.1675959587431; Thu, 09
 Feb 2023 08:19:47 -0800 (PST)
MIME-Version: 1.0
References: <20230209085536.1076662-1-guillaume.tucker@collabora.com>
In-Reply-To: <20230209085536.1076662-1-guillaume.tucker@collabora.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Thu, 9 Feb 2023 08:19:36 -0800
Message-ID: <CABXOdTdnntA=oU4==suO-DP-8S9zb0AhqtwekCRCbpOpku7MQg@mail.gmail.com>
Subject: Re: [PATCH v3] selftests: use printf instead of echo -ne
To:     Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Gautam <gautammenghani201@gmail.com>,
        David Laight <David.Laight@aculab.com>, kernel@collabora.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernelci@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Feb 9, 2023 at 12:55 AM Guillaume Tucker
<guillaume.tucker@collabora.com> wrote:
>
> Rather than trying to guess which implementation of "echo" to run with
> support for "-ne" options, use "printf" instead of "echo -ne".  It
> handles escape characters as a standard feature and it is widespread
> among modern shells.
>
> Reported-by: "kernelci.org bot" <bot@kernelci.org>
> Suggested-by: David Laight <David.Laight@ACULAB.COM>
> Fixes: 3297a4df805d ("kselftests: Enable the echo command to print newlines in Makefile")
> Fixes: 79c16b1120fe ("selftests: find echo binary to use -ne options")
> Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>
> Notes:
>     v2: use printf insead of $(which echo)
>     v3: rebase on top of fix with $(which echo)
>
>  tools/testing/selftests/Makefile | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index 9619d0f3b2ff..06578963f4f1 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -234,11 +234,10 @@ ifdef INSTALL_PATH
>         @# While building kselftest-list.text skip also non-existent TARGET dirs:
>         @# they could be the result of a build failure and should NOT be
>         @# included in the generated runlist.
> -       ECHO=`which echo`; \
>         for TARGET in $(TARGETS); do \
>                 BUILD_TARGET=$$BUILD/$$TARGET;  \
> -               [ ! -d $(INSTALL_PATH)/$$TARGET ] && $$ECHO "Skipping non-existent dir: $$TARGET" && continue; \
> -               $$ECHO -ne "Emit Tests for $$TARGET\n"; \
> +               [ ! -d $(INSTALL_PATH)/$$TARGET ] && printf "Skipping non-existent dir: $$TARGET\n" && continue; \
> +               printf "Emit Tests for $$TARGET\n"; \
>                 $(MAKE) -s --no-print-directory OUTPUT=$$BUILD_TARGET COLLECTION=$$TARGET \
>                         -C $$TARGET emit_tests >> $(TEST_LIST); \
>         done;
> --
> 2.30.2
>
>
