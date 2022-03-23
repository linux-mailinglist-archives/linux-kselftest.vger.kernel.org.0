Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 041C94E5BD4
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Mar 2022 00:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345551AbiCWXdh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Mar 2022 19:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345539AbiCWXdg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Mar 2022 19:33:36 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3587C90FFB
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Mar 2022 16:32:01 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id o10so5928245ejd.1
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Mar 2022 16:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=87rv/uQgaWVecbXHJd/b7su5U/noF4SgiLK+NkYo0kg=;
        b=bU2dKvO1iB7Nfmq3t5BeQjg5fs2YxOOugE29s4rUq1zTPjndpx2a7Ys38ZXe7DkULq
         5pGdoWZgccBVOu0pkNIJrNdfWyLu3eDn+XU9GF2zWXFuPf4b8+oxumNb+3JYFXfQ/xSn
         uK1oENCWgxYEQ2Dk3u76NHyo2JapuA1o0h2lfOZ1VC1nQaiv1qYziPQOjOIXCU7RdWlE
         6XVUdO5XDQlEf3U2rgMwsmpTiqakYNPyUIT9Zd5y+pP1SUnw3l0rH/M0YKLK+LFlKeNA
         U7eVgHSWTnPNURttcNh7cPHlccKi3/zemaikjtX5CZVxzOat3prafRnwwRbHg9qn3VbF
         U9Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=87rv/uQgaWVecbXHJd/b7su5U/noF4SgiLK+NkYo0kg=;
        b=TLd5q3I8zAywEBEDQEAnEVv2s70xBWO6d+F6snC23i3bLguiGAUqaWAOESMA7gPHU4
         2RWrIjU8c+tCL1vYiaFeEgHwsnvs1LxBlXnf8fR21AIlN5sK3W/qvCOyVXg9aHPI/dI3
         hZIpg6VHbk9zljtOyu/j2T2YY13Nt4w120F42admTaSXlPUaS00WJHxtsGUVmVJea6NF
         HvYyX9dpJVUFL57M8axT9LoccLzKH5xeC3JKA8m0VP7FDGfqw0mhgC9Hme/UyJTICdzF
         mvJpDIhd7VkPGsQdpTy9EdCno5kSdJ1T7JML/HSRUmKOJJVfqIfSGzl1/IA9cgMUVA7s
         I8Fg==
X-Gm-Message-State: AOAM5334nWAsG23OoIbSaDrdpLz6sbwnkzXSaAPvPDGThwg/GKGhJAev
        kVecyXMjGM/1u++qwADwfRpjbnYaiqtr5mY2eH3w/w==
X-Google-Smtp-Source: ABdhPJwUs0aMecxyk7WALt/Mr/ajj8mGFKS5P8r4no322FGnq5kojvSreI1EkBgj/yhMbj3WFKZMtYOMfdll/qXGlWs=
X-Received: by 2002:a17:906:c14b:b0:6da:b30d:76a0 with SMTP id
 dp11-20020a170906c14b00b006dab30d76a0mr2711895ejc.279.1648078320023; Wed, 23
 Mar 2022 16:32:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220226212325.2984807-1-dlatypov@google.com>
In-Reply-To: <20220226212325.2984807-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 23 Mar 2022 19:31:48 -0400
Message-ID: <CAFd5g4509cBW2_NMatiptB7VjR-Z9Dn83d2f_tZdix2jTzXonw@mail.gmail.com>
Subject: Re: [PATCH v2] kunit: tool: more descriptive metavars/--help output
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Feb 26, 2022 at 4:23 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> Before, our help output contained lines like
>   --kconfig_add KCONFIG_ADD
>   --qemu_config qemu_config
>   --jobs jobs
>
> They're not very helpful.
>
> The former kind come from the automatic 'metavar' we get from argparse,
> the uppercase version of the flag name.
> The latter are where we manually specified metavar as the flag name.
>
> After:
>   --build_dir DIR
>   --make_options X=Y
>   --kunitconfig PATH
>   --kconfig_add CONFIG_X=Y
>   --arch ARCH
>   --cross_compile PREFIX
>   --qemu_config FILE
>   --jobs N
>   --timeout SECONDS
>   --raw_output [{all,kunit}]
>   --json [FILE]
>
> This patch tries to make the code more clear by specifying the _type_ of
> input we expect, e.g. --build_dir is a DIR, --qemu_config is a FILE.
> I also switched it to uppercase since it looked more clearly like
> placeholder text that way.
>
> This patch also changes --raw_output to specify `choices` to make it
> more clear what the options are, and this way argparse can validate it
> for us, as shown by the added test case.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> Reviewed-by: David Gow <davidgow@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
