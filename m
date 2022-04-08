Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B294F8D93
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Apr 2022 08:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233695AbiDHEBn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Apr 2022 00:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234085AbiDHEBn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Apr 2022 00:01:43 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C0411DD01
        for <linux-kselftest@vger.kernel.org>; Thu,  7 Apr 2022 20:59:40 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id k23so14818454ejd.3
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Apr 2022 20:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d8V8QdLVMJ6wCY1wCleLijgS/+KIcQIqn2ncvH/Fzoc=;
        b=V3AdMUChmj+dq2IGkLCjFYgGy3bkWj9uSfQgL1SidJI6/teu6A6qituRa5QfLB7ZAu
         XqtFcrNuZr9QfMvYYQEK1maBU1xC8xf8lsiZN9r7Xe4KDyPG/bpocEqXgIX+VuRmGpLf
         /4HUz+1zTOuC7neGjoHQpEoVJer9oGk4KX123fYwHmy5HLTD/UoJrMyXkFlfaBDtwe0E
         0w/ZV0AGD6PjdoqkbLj8Wjuf2nA36+Z+fs0eZOxc63NDtJDvrV9LG5bz2UCYTBVmJvgp
         ge6O4PSyyZmlnTpdCCiPbuI4RUVNFiZoLs62z723LxZoHAEQFnV6jQQ45tvpqAbevbWM
         HJnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d8V8QdLVMJ6wCY1wCleLijgS/+KIcQIqn2ncvH/Fzoc=;
        b=2YS8ho9AEofJFi67tBNSV0Nc9eS3hMgryLXHY5iESk+oe7IfX0kxJLvRHUBTh1jEaR
         gWqgRXkypPs8RENHr4tJOqNwDDowiJrUpvimxD8alwlFqsgIsvurC1k5RyPp2esXPFm4
         OkV2GpWSJmLkXvQi6T/836nIUHwlOx9ckhzHU9Y5OvmdUeW2F/ef0JGIm2QDL2Dhjpd/
         VYuQU+krNs+3n8H+RgklCxcqP9+RXIkvsDiQU39nEytJcxxQaFFOR94O3WV2cA65x0iT
         vS524CyGQMeBLkkhel4rz9dpqwc/FuLA1Y7dJMFF3YDBzUQcFpRlELzmwjGtaDXLI3Bg
         6ryQ==
X-Gm-Message-State: AOAM531CH4dA6fEWJ1FaIZ9M4CuYL5gTWQBP5k/s9Zh9G+SUfaJkAfmp
        /XtJrs0DwTKyLcexzlFJV3zMqTbeX/k962zaC25hhQ==
X-Google-Smtp-Source: ABdhPJwIdn5HLwoVIc7NHpk2ZNf+qVauWTjSovr4cql3RkyDYXF98CBPpym1pAxa6d6HoGiHoqBLeSpRw9onl6ZmvCA=
X-Received: by 2002:a17:906:a2c2:b0:6e7:efc2:17f2 with SMTP id
 by2-20020a170906a2c200b006e7efc217f2mr15654230ejb.542.1649390378795; Thu, 07
 Apr 2022 20:59:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220407223019.2066361-1-dlatypov@google.com> <20220408034848.2081355-1-davidgow@google.com>
In-Reply-To: <20220408034848.2081355-1-davidgow@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Thu, 7 Apr 2022 22:59:27 -0500
Message-ID: <CAGS_qxrNOPq+akyt2Ee4NXySP+Zxqis2H5CwKs_kNWNvJ+bo5A@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: Print a total count of tests.
To:     David Gow <davidgow@google.com>
Cc:     brendanhiggins@google.com, skhan@linuxfoundation.org,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org
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

On Thu, Apr 7, 2022 at 10:48 PM 'David Gow' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> Add a count of the total number of tests run (including skipped tests,
> which do run a little bit until they decide to skip themselves) to the
> summary line.
>
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>
> This patch depends on:
> https://lore.kernel.org/linux-kselftest/20220407223019.2066361-1-dlatypov@google.com/
>
>  tools/testing/kunit/kunit_parser.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
> index 957907105429..da01998d29b1 100644
> --- a/tools/testing/kunit/kunit_parser.py
> +++ b/tools/testing/kunit/kunit_parser.py
> @@ -96,7 +96,7 @@ class TestCounts:
>                 """
>                 statuses = [('Passed', self.passed), ('Failed', self.failed),
>                         ('Crashed', self.crashed), ('Skipped', self.skipped),
> -                       ('Errors', self.errors)]
> +                       ('Errors', self.errors), ('Total', self.total())]

Hmm, I've never really felt the need for a total to be printed out.
We've had few enough tests and different statuses that the mental
addition is easy enough.

Bikeshedding:
This current output of
  Passed: 40, Skipped: 2, Total: 42
feels a bit awkward to me.
If we did print one out, I think it should probably go first, e.g.
  Ran 42 tests: 40 passed, 2 skipped.

Wdyt?

>                 return ', '.join('{}: {}'.format(s, n) for s, n in statuses if n > 0)
