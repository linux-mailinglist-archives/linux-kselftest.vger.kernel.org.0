Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 183F5569304
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Jul 2022 22:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233306AbiGFUGq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Jul 2022 16:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbiGFUGp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Jul 2022 16:06:45 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5BA1C92F
        for <linux-kselftest@vger.kernel.org>; Wed,  6 Jul 2022 13:06:44 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id r18so20600959edb.9
        for <linux-kselftest@vger.kernel.org>; Wed, 06 Jul 2022 13:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7PiCfuqqFQMm4Z7Pxo/Mkp0vSHbF19ROVfmwHiEwIp8=;
        b=nP8OozGQwV0hugk+1RizuLBuHeDBhO9I1ymaTbz9SVKu5nYndfbg6U0LGPb6gwFfHJ
         ToZbABTlGJpV7Fyk+IMRHWjt2JHxQ45DWhkDuCmFXEEaQbf6RfOr5CSueAaKi6gUsh5a
         Re0l7tzCHIGJ1Dw5CTE7fLIk/lTWUfy8Zu6/EVTWwCBo21YLl5rgE+ag9/k0RxO6uPdv
         GIBGew/Ulw3raH0Q/cIqfI03t9KZH/OVjZiX7syD/4LdZeoIB5GkytSbgTT0CvCF6QEF
         nNNtaoJCr1mmiucox/7veCDibYCx6ha7KADLG+MsqE7dMs9RavPoTfk7C/J1RzUZvtv6
         dOFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7PiCfuqqFQMm4Z7Pxo/Mkp0vSHbF19ROVfmwHiEwIp8=;
        b=2ld/f4J90v4BRYxX2S2UL4GtFXKEfUwORYDlLP4rt+o3qbGk2dKa85Ra+Gwx8DuYWJ
         2th7jt6AVbioAaWArb2dfSRDfgYytVKeFyhBCVOGLmEL4khDEEOcwFRJbTwDOjSKDAkl
         IH3u6vVfJZAYcENzC6rntjJuDRCzC7pvbrsoyNG3M0K4zjsgow7hJ4N9QtTHX55gINEw
         T9pbnmx92+8ciFWU2WKGPKCyOrh9nFB650Xjn0IGhy+fynjstdKsLahLoJVWnEyW99Gv
         B0ygWhTb/xuNUScvPyvqOPPPuRLCM1JtJ131vMT4EE4Y+ppGXWcgOmKkfT+LWdDQgEzp
         yeHg==
X-Gm-Message-State: AJIora+JyPoD7NnamPU4TNQ+KxOu7or+wYfhZM43uf6rGvdYl3WecBQV
        2cxD5FEfM1QsBrC9z6SjNBx7HtFBWLBna02jrwyNow==
X-Google-Smtp-Source: AGRyM1vVw8FO9mBPy3IYwxvYYV3o1j35+YKTnPDfsskfWqT5lbva7gMmrRyi07uXl3B4HhdRXqCM45LkaGsIUGz65VE=
X-Received: by 2002:a05:6402:40c3:b0:439:6b72:483e with SMTP id
 z3-20020a05640240c300b004396b72483emr43951638edb.154.1657138003142; Wed, 06
 Jul 2022 13:06:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220518170124.2849497-1-dlatypov@google.com> <20220518170124.2849497-3-dlatypov@google.com>
In-Reply-To: <20220518170124.2849497-3-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 6 Jul 2022 16:06:31 -0400
Message-ID: <CAFd5g44RLKbDHLeMMsJYeBK+smeioJKQVeBmHwk5uccD-vKvUA@mail.gmail.com>
Subject: Re: [PATCH 2/3] kunit: tool: simplify creating LinuxSourceTreeOperations
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, elver@google.com,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
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

On Wed, May 18, 2022 at 1:01 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> Drop get_source_tree_ops() and just call what used to be
> get_source_tree_ops_from_qemu_config() in both cases.
>
> Also rename the functions to have shorter names and add a "_" prefix to
> note they're not meant to be used outside this function.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
