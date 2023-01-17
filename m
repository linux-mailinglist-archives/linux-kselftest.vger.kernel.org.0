Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31A6670B6F
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jan 2023 23:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjAQWLt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Jan 2023 17:11:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjAQWKb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Jan 2023 17:10:31 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA2E1CF71
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Jan 2023 13:56:11 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id s67so23072283pgs.3
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Jan 2023 13:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0cr0RPJmvb7n5x8XTwTIrboLTYQTJE656e9XjHwFqpY=;
        b=G0rIt6F9KwPDQsFFiIGt4cbVtyXK3cjH3I/6w6TjsnFWU6bimnOonwGB/F3Ziyd4Jo
         CyhhE546Qe7O1iA7p9B8kKZlu/AWuV7CnU32Yw4k40hOcYDvqJhYBQ+nxz8Qc/cZkJGm
         C/JUyEfenjifeNDck9wpYBNhHfMbdFyMCvpcQi/taQef9Wb/G0r6Ev7Qb501lU08Z/T7
         qiIcBaK3utVFfoZ19giKv7T5AzWW/hlMaiCleM8YGcEfHsMkrdnFPcQG43iDhM0+UgE/
         +9ZnDQfh0eS25IiLuTdw1jR7ibasSX3wOpYn98VNTDn1wPE5WB1S0nln6hRKzAUjTaBm
         mPSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0cr0RPJmvb7n5x8XTwTIrboLTYQTJE656e9XjHwFqpY=;
        b=6KV8iBVVTAj+zeB0IZOu2FgBFyUaIhTK45Ib70vIjkxbDCaQ6shMhk8n8EmFjI15LM
         TQRvYjZUEhmvGY7V06gI8b8X84OV7ILasyHZKckQJ/dz7xNnOtxNKuQzAVXXXiiPZ6Dj
         ZQDVWEM9yXncp9uYJuhc5hezOWs+GMS8tRcbDlb21nVC8VMEsFqPmYehMnuSH24UH7m0
         VbXoVbvaO5nGDwSOcuW20foxZ3KMvqYq+ews65Pz0/vjmzNu4QV2F6u/UgExkm0eCWDU
         szWcfRiKgm6e29dWVHGxNDOZ22tP4YjlFgoRZ/EoSd/Kn64Dn0fC9yPPnJaqHQJ3otdd
         irdw==
X-Gm-Message-State: AFqh2kodhMEqQwGao7YieeLJ8C5IoyY7eHLUgxJ4iOHq21xz3vRY7T+2
        EBnCygOVPbDX0kQBcSKQEBnutE7P+5jQFKLsNkTcvvyXVBRw8zPn
X-Google-Smtp-Source: AMrXdXsDEy6zVf3HJhsimvTc4pp0ccSZvbDKcY38Skmwmg09mr+MZc6sLygEborMQ2w+qXbe4225XBigheJwqGgL4So=
X-Received: by 2002:a63:500e:0:b0:4d0:6ad7:e5a9 with SMTP id
 e14-20020a63500e000000b004d06ad7e5a9mr17902pgb.464.1673992570808; Tue, 17 Jan
 2023 13:56:10 -0800 (PST)
MIME-Version: 1.0
References: <20230115210535.4085-1-apantykhin@gmail.com>
In-Reply-To: <20230115210535.4085-1-apantykhin@gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Tue, 17 Jan 2023 13:55:59 -0800
Message-ID: <CAGS_qxpoGCXAK=q+unFoYKN0GtH8V9Ojmntz0YZrae8zBeX-qw@mail.gmail.com>
Subject: Re: [PATCH] tools/testing/kunit/kunit.py: remove redundant double check
To:     Alexander Pantyukhin <apantykhin@gmail.com>
Cc:     brendan.higgins@linux.dev, davidgow@google.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org
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

On Sun, Jan 15, 2023 at 1:05 PM Alexander Pantyukhin
<apantykhin@gmail.com> wrote:
>
> The build_tests function contained the doulbe checking for not success

very nit: if we're fixing the "doulbe" typo, can we also do
  "the doulbe" => "double" (drop the "the")

> result. It is fixed in the current patch. Additional small
> simplifications of code like useing ternary if were applied (avoid use
> the same operation by calculation times differ in two places).
>
> Signed-off-by: Alexander Pantyukhin <apantykhin@gmail.com>

Reviewed-by: Daniel Latypov <dlatypov@google.com>

Thanks!
I can't believe we never noticed the duplicate `if not success` blocks
before now.

Some minor suggestions below if we're already going to send a v2 out for typos.

> ---
>  tools/testing/kunit/kunit.py | 17 +++++------------
>  1 file changed, 5 insertions(+), 12 deletions(-)
>
> diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
> index 43fbe96318fe..481c213818bd 100755
> --- a/tools/testing/kunit/kunit.py
> +++ b/tools/testing/kunit/kunit.py
> @@ -77,10 +77,8 @@ def config_tests(linux: kunit_kernel.LinuxSourceTree,
>         config_start = time.time()
>         success = linux.build_reconfig(request.build_dir, request.make_options)
>         config_end = time.time()
> -       if not success:
> -               return KunitResult(KunitStatus.CONFIG_FAILURE,
> -                                  config_end - config_start)
> -       return KunitResult(KunitStatus.SUCCESS,
> +       status = KunitStatus.SUCCESS if success else KunitStatus.CONFIG_FAILURE
> +       return KunitResult(status,
>                            config_end - config_start)

nit: perhaps we can shorten this to one line, i.e.
  return KunitResult(status, config_end - config_start)

>
>  def build_tests(linux: kunit_kernel.LinuxSourceTree,
> @@ -92,13 +90,8 @@ def build_tests(linux: kunit_kernel.LinuxSourceTree,
>                                      request.build_dir,
>                                      request.make_options)
>         build_end = time.time()
> -       if not success:
> -               return KunitResult(KunitStatus.BUILD_FAILURE,
> -                                  build_end - build_start)
> -       if not success:
> -               return KunitResult(KunitStatus.BUILD_FAILURE,
> -                                  build_end - build_start)

Oh huh, I guess this duplication comes from commit 45ba7a893ad8
("kunit: kunit_tool: Separate out config/build/exec/parse")

@@ -64,78 +84,167 @@ def run_tests(linux: kunit_kernel.LinuxSourceTree,
        build_end = time.time()
        if not success:
                return KunitResult(KunitStatus.BUILD_FAILURE, 'could
not build kernel')
+       if not success:
+               return KunitResult(KunitStatus.BUILD_FAILURE,
+                                  'could not build kernel',

> -       return KunitResult(KunitStatus.SUCCESS,
> +       status = KunitStatus.SUCCESS if success else KunitStatus.BUILD_FAILURE
> +       return KunitResult(status,
>                            build_end - build_start)

ditto here,
  return KunitResult(status, build_end - build_start)

>
>  def config_and_build_tests(linux: kunit_kernel.LinuxSourceTree,
> @@ -145,7 +138,7 @@ def exec_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExecRequest) -
>                 tests = _list_tests(linux, request)
>                 if request.run_isolated == 'test':
>                         filter_globs = tests
> -               if request.run_isolated == 'suite':
> +               elif request.run_isolated == 'suite':

This is better, thanks.

Daniel
