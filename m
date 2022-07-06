Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78E2C56943B
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Jul 2022 23:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbiGFVVx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Jul 2022 17:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234115AbiGFVVw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Jul 2022 17:21:52 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6102228C
        for <linux-kselftest@vger.kernel.org>; Wed,  6 Jul 2022 14:21:49 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id dn9so23913867ejc.7
        for <linux-kselftest@vger.kernel.org>; Wed, 06 Jul 2022 14:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b+jNR09nevXwyZD3QcB2efT/aRwjkNE4wZb+r0B6XwE=;
        b=I6DkDmx26h+CaG/uyqSSoQf0Kpgi3UibjsyI7hR3HtcwlbuXqjSaN373PhsoVA8c/q
         dP48qLIWwvOkDivqhfCZ9qhqTvobqYE1RdzdhZgsY9X6p1WRrO8y8vZlwC4mJguHh3J2
         QVHtybfrf6REnR+cLGEVSkcYhTZoN+EAZzqyp91YnDE2h0AB5urwdz4ZAbag8iGXPhdf
         +G7Qe/WEhy5mYP3bU+JrpZquZQ5DIQOI4BCF/cQ1ezg8Awhq0CRvK74F06s5exP/dLGW
         dhns8DWwOEGwfzBkdzyAULDjp5+Hd43di+1wckPzbttZOsctcdW6qtLlSLhGgc2hRwlB
         lU9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b+jNR09nevXwyZD3QcB2efT/aRwjkNE4wZb+r0B6XwE=;
        b=mGoTe2PO6KUaCduqY+G6myIOgljZFfVZiQeuCAiHcBL4I/HWPasm3zxCILcq/3wk3U
         64J75pjHtQoIXwhIyM1cshVKxfSQt1U24dz6bQHWGmA6tq/Q/2mBj9RLRwoQK0V4cLqJ
         0JSeoDv9DFZqvRqJlwZshQyH/LHtCImsJh+fnRIRilJ8VOxn6tE2SpDMZyZ/4lOy7CpL
         h/a/7GK6lW2ZRs2QkpjyCzQJHqh5rFuzQPPgKAmQpad+5fVgd4j1xE10q+Y4Mek+EVDm
         4F33gtUoKxJjvncnUMpfkGdDIET3G4bKKGSb76RLCQxCRVNBzLoHjNC7iIBZXaXRjQ+M
         EvAA==
X-Gm-Message-State: AJIora+ZJGRlG6aIkW20hCvJp9LqaZfbV3ISAZ2lyr8bCkTytfAsINlq
        XYLL4/ypT+pOJXDitCpm/AbPDuZja6jemAwrHe3fVA==
X-Google-Smtp-Source: AGRyM1unmOCSqJ1JoDSIrmquHUHd+3hyWJM/lpJegqaohJgOcShxHgQq8EC+4/uCGtnOiBPC//jVBWUzROPdZlv/7Ms=
X-Received: by 2002:a17:906:cc96:b0:728:baf0:ba03 with SMTP id
 oq22-20020a170906cc9600b00728baf0ba03mr40471193ejb.52.1657142508217; Wed, 06
 Jul 2022 14:21:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220625050838.1618469-1-davidgow@google.com> <20220625050838.1618469-5-davidgow@google.com>
In-Reply-To: <20220625050838.1618469-5-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 6 Jul 2022 17:21:37 -0400
Message-ID: <CAFd5g45www4FZ0BoXN+mbqAJEkub07mM-nfzMtjm4p3q_VSCXw@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] nitro_enclaves: test: Use kunit_test_suite() macro
To:     David Gow <davidgow@google.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andra Paraschiv <andraprs@amazon.com>,
        Longpeng <longpeng2@huawei.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?TWHDrXJhIENhbmFs?= <maira.canal@usp.br>,
        linux-mmc@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org, linux-usb@vger.kernel.org,
        linux-modules@vger.kernel.org,
        Matt Johnston <matt@codeconstruct.com.au>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Jun 25, 2022 at 1:10 AM David Gow <davidgow@google.com> wrote:
>
> The kunit_test_suite() macro previously conflicted with module_init,
> making it unsuitable for use in the nitro_enclaves test. Now that it's
> fixed, we can use it instead of a custom call into internal KUnit
> functions to run the test.
>
> As a side-effect, this means that the test results are properly included
> with other suites when built-in. To celebrate, enable the test by
> default when KUNIT_ALL_TESTS is set (and NITRO_ENCLAVES enabled).
>
> The nitro_enclave tests can now be run via kunit_tool with:
>         ./tools/testing/kunit/kunit.py run --arch=x86_64 \
>         --kconfig_add CONFIG_PCI=y --kconfig_add CONFIG_SMP=y \
>         --kconfig_add CONFIG_HOTPLUG_CPU=y \
>         --kconfig_add CONFIG_VIRT_DRIVERS=y \
>         --kconfig_add CONFIG_NITRO_ENCLAVES=y \
>         'ne_misc_dev_test'
>
> (This is a pretty long command, so it may be worth adding a .kunitconfig
> file at some point, instead.)
>
> Reviewed-by: Andra Paraschiv <andraprs@amazon.com>
> Signed-off-by: David Gow <davidgow@google.com>

Acked-by: Brendan Higgins <brendanhiggins@google.com>
