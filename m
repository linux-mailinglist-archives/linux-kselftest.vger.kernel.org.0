Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C002590D27
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Aug 2022 10:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236270AbiHLIH0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 12 Aug 2022 04:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiHLIHZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 12 Aug 2022 04:07:25 -0400
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1514A8307;
        Fri, 12 Aug 2022 01:07:23 -0700 (PDT)
Received: by mail-qk1-f172.google.com with SMTP id n21so254212qkk.3;
        Fri, 12 Aug 2022 01:07:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=aFJNyT5Djgzn7r7XrxfkkghlVBwDmpHCizKv7Git9FM=;
        b=v3yGdnFZKTDUdi+wldQjvwCeMY0EhHPqcg+Br3ec2gTsfR4632qjo2wXVj4stKWe1O
         ftVUB879s8Y0o8hIZlve75ZrpAiQIpP32ARXapmlcD421di0l0Gb8NDUip42nGirrsf5
         rphC0qKZ8sjsM9cecvSQ5AOT5hpjCXDr5qAhpTy+EbImtzI9tN341S5Tmx4gg8bPOEGo
         n/+9DC3QDEzbzHVbaJHL4kOk1/h0Ij6ahIifa6qr+GDeeK9k4//vIOInKOYAgo1bv3hA
         Yxj3ItFnN/BwnfZH27dM/fbDIXuqTAvF1NJmWHUW40/u9bB7FkFoaDN139OgpXyjV29b
         7xaA==
X-Gm-Message-State: ACgBeo2ubKjiXIOALbeylA0jyLHH2ceU6f9bSG5kiMPNULHyStf/D48J
        WhpHcvDLx/cViAs8XPyePMrGiH4H8QC6oQ==
X-Google-Smtp-Source: AA6agR4+8cNfaP3mJTrhLDDdvRqVKb+2Oz2XMyx8aaaqNQ4yXDtYYjEpNm/AXWgzTFR1Of6WnFdOkQ==
X-Received: by 2002:a05:620a:424e:b0:6ab:96ea:40cb with SMTP id w14-20020a05620a424e00b006ab96ea40cbmr1992179qko.483.1660291642681;
        Fri, 12 Aug 2022 01:07:22 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id u12-20020ac858cc000000b003437b558f48sm41919qta.3.2022.08.12.01.07.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 01:07:22 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id i62so371548yba.5;
        Fri, 12 Aug 2022 01:07:22 -0700 (PDT)
X-Received: by 2002:a05:6902:100a:b0:676:ed53:25b0 with SMTP id
 w10-20020a056902100a00b00676ed5325b0mr2288014ybt.365.1660291641943; Fri, 12
 Aug 2022 01:07:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220713005221.1926290-1-davidgow@google.com>
In-Reply-To: <20220713005221.1926290-1-davidgow@google.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 12 Aug 2022 10:07:10 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWLcakTVEVYwN_Z_Ed8AZK8+WUuzcVbtwKhg7O61FTDPw@mail.gmail.com>
Message-ID: <CAMuHMdWLcakTVEVYwN_Z_Ed8AZK8+WUuzcVbtwKhg7O61FTDPw@mail.gmail.com>
Subject: Re: [PATCH] module: kunit: Load .kunit_test_suites section when CONFIG_KUNIT=m
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Daniel Latypov <dlatypov@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        linux-modules@vger.kernel.org,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi David,

On Wed, Jul 13, 2022 at 2:55 AM David Gow <davidgow@google.com> wrote:
> The new KUnit module handling has KUnit test suites listed in a
> .kunit_test_suites section of each module. This should be loaded when
> the module is, but at the moment this only happens if KUnit is built-in.
>
> Also load this when KUnit is enabled as a module: it'll not be usable
> unless KUnit is loaded, but such modules are likely to depend on KUnit
> anyway, so it's unlikely to ever be loaded needlessly.
>
> Fixes: 3d6e44623841 ("kunit: unify module and builtin suite definitions")
> Signed-off-by: David Gow <davidgow@google.com>

Thanks for your patch!

This fixes the regression where modular tests are no longer run
after loading them.
Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
