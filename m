Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F094F9F61
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Apr 2022 23:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234866AbiDHV4p (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Apr 2022 17:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbiDHV4o (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Apr 2022 17:56:44 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8913365E8
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Apr 2022 14:54:39 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id l26so19845964ejx.1
        for <linux-kselftest@vger.kernel.org>; Fri, 08 Apr 2022 14:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jSIQ80W+dMFDXZQJvG8kW782kcJcBLa6c9nm/vAjIzg=;
        b=U3TitJwE6bSTIGiHXM6skTGJVfHEbE0d2Gp4Cr4l9lZXA0K34kvevVx5b1QDwnvBX2
         DMNmIlsRud/rGl6uWt0grg3KSoVySB5+wpH/VT638qCPvkJUTOyHeicJ6UdWQv7wEGDj
         jwrTuZE/dGzmWn/diVAFZwuANGnsAY4oo6iht6IHwvyrdn4zNYGZw31fjpDw9TN0GIG0
         7YwbkXbnzVCDsBRhc5+GKt8/oG7myuUGcWcszKj+aPkMDKn0m75ZFrGgR875yiT6+ODu
         XiZBlka4SZq9Cr4qiE11j9xu3+/guhGCdmCPs04gGk9Uw5uULeMLzXuiXhj9fyXywvB6
         6SWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jSIQ80W+dMFDXZQJvG8kW782kcJcBLa6c9nm/vAjIzg=;
        b=USF5xWZUYw475cfTKcoD7l9HeKHaXpvA8naMAngHZ8iaPEPeWo7tulvC/ZdzG8SxMc
         xrWuOg+mEm2iJLtr4JqMDxSERpZm892bXg0/6h6PTTYdGZl/Eb7hLFsU27z0WlW1fcO4
         d2Ao0tPtR7UCUlzq0Q9z8sII/+77qT3tgf85WClE001DsbuI8W+viwfQ5xTTay3GkGUY
         H8I8b/i0RS8dsRu2CCcvTvU+O4h6o7wI7dcctmOHI+HkjY81hgWgCReaQp0GCTOrAYtw
         Zicldgdd5GYbkNSrpi5k+2bB7dbrgXD+Du820uNVo+ed58zsiSam9YgSrmVQ1lSk8lme
         A08A==
X-Gm-Message-State: AOAM532prKzWHuy9ge+orn81m7AmLC2e28nRcSuoqUo8wKP55yOOfjUg
        kHPMfinPtTB2W+K05vae73APKT6hKyw35HId9cjaCA==
X-Google-Smtp-Source: ABdhPJwqYFMFb1OvkyoDQSpvZlblhJVC9NNC7aOaRCcpMbaIqwtn65VoAP3qHd0qzKvkCeg2qOqodlB9n+UgjOS4YL0=
X-Received: by 2002:a17:907:1c06:b0:6df:b257:cbb3 with SMTP id
 nc6-20020a1709071c0600b006dfb257cbb3mr19966811ejc.631.1649454877941; Fri, 08
 Apr 2022 14:54:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220407223019.2066361-1-dlatypov@google.com> <20220408034848.2081355-1-davidgow@google.com>
 <CAGS_qxrNOPq+akyt2Ee4NXySP+Zxqis2H5CwKs_kNWNvJ+bo5A@mail.gmail.com>
 <CABVgOSkKuHCkfpQhzNmzufaVw_6qO-Ve_t5oTub1JeweTiC9RQ@mail.gmail.com> <CAGS_qxqmbgy6KOp1bPF4Pk5SZT+r8L7ASqEyNWF9BtCS2JgXaw@mail.gmail.com>
In-Reply-To: <CAGS_qxqmbgy6KOp1bPF4Pk5SZT+r8L7ASqEyNWF9BtCS2JgXaw@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Fri, 8 Apr 2022 16:54:26 -0500
Message-ID: <CAGS_qxqR_WQ4mn20_bMnWi-F969B5BxrvXr8QiQzufGAs+bHnA@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: Print a total count of tests.
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
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

On Fri, Apr 8, 2022 at 2:04 PM Daniel Latypov <dlatypov@google.com> wrote:
<snip>

> E.g. I get this output
> Ran 173 tests: passed: 137, skipped: 36
>
> with a new combined patch of
>
> diff --git a/tools/testing/kunit/kunit_parser.py
> b/tools/testing/kunit/kunit_parser.py
> index 807ed2bd6832..de1c0b7e14ed 100644
> --- a/tools/testing/kunit/kunit_parser.py
> +++ b/tools/testing/kunit/kunit_parser.py
> @@ -94,11 +94,11 @@ class TestCounts:
>         def __str__(self) -> str:
>                 """Returns the string representation of a TestCounts object.
>                 """
> -               return ('Passed: ' + str(self.passed) +
> -                       ', Failed: ' + str(self.failed) +
> -                       ', Crashed: ' + str(self.crashed) +
> -                       ', Skipped: ' + str(self.skipped) +
> -                       ', Errors: ' + str(self.errors))
> +               statuses = [('passed', self.passed), ('failed', self.failed),
> +                       ('crashed', self.crashed), ('skipped', self.skipped),
> +                       ('errors', self.errors)]
> +               return f'Ran {self.total()} tests: ' + \
> +                       ', '.join(f'{s}: {n}' for s, n in statuses if n > 0)
>
>         def total(self) -> int:
>                 """Returns the total number of test cases within a test
>

Sent this patch out as a v2,
https://lore.kernel.org/linux-kselftest/20220408215105.2332902-1-dlatypov@google.com/
