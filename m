Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBB23B96A9
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Jul 2021 21:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233681AbhGATnl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Jul 2021 15:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbhGATnk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Jul 2021 15:43:40 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28481C061762
        for <linux-kselftest@vger.kernel.org>; Thu,  1 Jul 2021 12:41:09 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id c15so4223238pls.13
        for <linux-kselftest@vger.kernel.org>; Thu, 01 Jul 2021 12:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nJcbG0Lztm5zUO4KSS6JbG8DSMcv2xjffIaUs/IPuG8=;
        b=NppJJIEdya/aEG3IwmErYGiBOMgdUFUnJMU9HTI4GSxs09P8+t0QrX99EUBq/UtxM5
         zG7oskh/M++GFmyQ6hHqU0qMGIF+O3YmJorfMZxAFOQ4QyImia/VfcR6Ht/ofveIbOCX
         W5fx7T5L72CY5E4f/boLsKdyMdYgIPI616z+LJ6kK+z5Eaz0rsNm8dBcXdi6Px0NpvbC
         zB1bTdNMDW9FLX6XWtlFUw3uhkmZv56omEp6Gx1P0DogmsYG9ueanHft2IHLguK8Um3z
         9Tp8lXWxPFnzkwfhyAjQcsE4uV8WEHgXDudIezb+3jDaIJgttjoI1eBLQFqN4OjplY0q
         6O3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nJcbG0Lztm5zUO4KSS6JbG8DSMcv2xjffIaUs/IPuG8=;
        b=C3p4P5+DXRnoE9JGih6XAutKdO2QHvTrwwzN9z9c8w1mDkGj2XGLV7PLb7TqDRrjW0
         cJ5RScCqfg3WULizR6af3NjZGbOl6j5athuMJnhGprDQbNC+wcfrRam28h0/+txDi75u
         ngLqCarGciHlnBJ2jXnuxx/G6MYiVJ9831hMUouRq8sp0ksJFt6+01fArp01vCKN31IE
         IponOxnqpPHZSTNhlz/gYyID83XYnSBTehb2FwO4v0JtWM1mPSpeAQ2CfzSdn0ZnXgMv
         Ad1ibHGjmVMQXCsJiHPFh4FVZCqaTmmpRJU33zRTCWnNP52GSaGDAnAtypzoCR/k5uPH
         BldA==
X-Gm-Message-State: AOAM5318vTDoPqTjJpWNF9FrSpUxV2ViVEzjvQyzRPtDWcMyXaCRByj+
        h3eegN8DxY29CW75FKZamulH1k3rx+3FQjSs1S9AFQ==
X-Google-Smtp-Source: ABdhPJxKWFlismvJH6nDZOfh8S4ZeRImquygXAS3Xes6tmuuUxmwCOv8vqSWb9gR5ZjO7Mz4eavq2kdpSNUt0fdRQ94=
X-Received: by 2002:a17:90a:1941:: with SMTP id 1mr11633636pjh.217.1625168468317;
 Thu, 01 Jul 2021 12:41:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210701175231.1734589-1-rmoar@google.com>
In-Reply-To: <20210701175231.1734589-1-rmoar@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 1 Jul 2021 12:40:57 -0700
Message-ID: <CAFd5g46VgFGHA7P+Wc=civvW4SnH5xxzOXXAdnkQ4DBKzHU-9A@mail.gmail.com>
Subject: Re: [PATCH v2] kunit: tool: Fix error messages for cases of no tests
 and wrong TAP header
To:     Rae Moar <rmoar@google.com>
Cc:     davidgow@google.com, dlatypov@google.com, shuah@kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jul 1, 2021 at 10:52 AM Rae Moar <rmoar@google.com> wrote:
>
> This patch addresses misleading error messages reported by kunit_tool in
> two cases. First, in the case of TAP output having an incorrect header
> format or missing a header, the parser used to output an error message of
> 'no tests run!'. Now the parser outputs an error message of 'could not
> parse test results!'.
>
> As an example:
>
> Before:
> $ ./tools/testing/kunit/kunit.py parse /dev/null
> [ERROR] no tests run!
> ...
>
> After:
> $ ./tools/testing/kunit/kunit.py parse /dev/null
> [ERROR] could not parse test results!
> ...
>
> Second, in the case of TAP output with the correct header but no
> tests, the parser used to output an error message of 'could not parse
> test results!'. Now the parser outputs an error message of 'no tests
> run!'.
>
> As an example:
>
> Before:
> $ echo -e 'TAP version 14\n1..0' | ./tools/testing/kunit/kunit.py parse
> [ERROR] could not parse test results!
>
> After:
> $ echo -e 'TAP version 14\n1..0' | ./tools/testing/kunit/kunit.py parse
> [ERROR] no tests run!
>
> Additionally, this patch also corrects the tests in kunit_tool_test.py
> and adds a test to check the error in the case of TAP output with the
> correct header but no tests.
>
> Signed-off-by: Rae Moar <rmoar@google.com>
> Reviewed-by: David Gow <davidgow@google.com>
> Reviewed-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
