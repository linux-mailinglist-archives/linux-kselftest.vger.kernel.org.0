Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93005515B13
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Apr 2022 09:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233979AbiD3HwE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 30 Apr 2022 03:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382328AbiD3HwD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 30 Apr 2022 03:52:03 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B0913D50
        for <linux-kselftest@vger.kernel.org>; Sat, 30 Apr 2022 00:48:42 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id p4so11450679edx.0
        for <linux-kselftest@vger.kernel.org>; Sat, 30 Apr 2022 00:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mZrRXivk2wHB6aP0PlOgj0l6NkbmTRIad+kjRkIeDR4=;
        b=okvLxUXU58ImUVPXvh6rNI6m4QzadLdDcLGXEGPUyv9KGiS2NPKYVe946bsjLYLXwv
         YRFTyVmLfH/YWVpfSLJK4i5y+WFUwqBvXi763VpFWdkSmcP9fozdztpG1pzrha91qisc
         mWE3DAhtx7dhBykXPoQj8qymxGRx1b6nrOZIsDI268dIx+JscS9dy7hMEPkqdRqKl6LA
         qyYV0Xl7k98kWbe2UhrKXN9VGuF6bAVp4vrgCKhkwo5wzZOODYVyK/4Bb7QjjGj54Uj6
         lu2AXLaKYRgnxKTaGfTszgLPOJcTjslJv+lTdPjocdIutm0pH6d1jg9vevfBxJ0d0QZO
         WRRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mZrRXivk2wHB6aP0PlOgj0l6NkbmTRIad+kjRkIeDR4=;
        b=YN8OH3E6o+jruxdLoGt5eEoThlPNIFPz8g6Gsomazhfz06TLroaRrL4eAPkwHeHfz0
         bL2asn6wYfMa+mwQl+zp6Ps7uBXVpBZeB3D+2pvw1ByC+AWoNluKsNR94tEAnrp5TQRq
         yXKV9b9R5stpGqtOCHWSICkOdq9Wa9ZYE+NwS9VkFX6Au/OUKuea7PzxjeCRgn5BC7uV
         nnlEmXArbHP7zB7XHKHPZa51FAk9BFt0meFTBtcnWuaD2gCnPYPoVck8XyFq1JRL79VK
         3QsEH+e9+paG/8IfRZibqbZ0PYSVZiJZ6NDL/nY68CDgj4q256apBu2t1hb2J5XqFamq
         /hkw==
X-Gm-Message-State: AOAM531NPrUM1vWu8yJoDUfnr2oV4UYKaHDCURnHIvp0XvGrWGWLmlNZ
        0IeTfFkJlVzKo1gnt7dKmN3wc9/YTegcHecpw9jfZw==
X-Google-Smtp-Source: ABdhPJwzeGHd2jm7gKak2ZQJ0e3UgigF3oGOwiQx6dA4Uc7lXFEf4b3PX+pR+6UCSCa/AaSigzQeaiDH5BqcKzALdNk=
X-Received: by 2002:a05:6402:1e8b:b0:41c:59f6:2c26 with SMTP id
 f11-20020a0564021e8b00b0041c59f62c26mr3397468edf.156.1651304921031; Sat, 30
 Apr 2022 00:48:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220429181259.622060-1-dlatypov@google.com> <20220429181259.622060-4-dlatypov@google.com>
In-Reply-To: <20220429181259.622060-4-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Sat, 30 Apr 2022 03:48:29 -0400
Message-ID: <CAFd5g45UDN52rDPbz7UU+4C8sh7Q-UwC_BCdNKs7J8aeRBco8A@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] kunit: fix debugfs code to use enum kunit_status,
 not bool
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
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

On Fri, Apr 29, 2022 at 2:13 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> Commit 6d2426b2f258 ("kunit: Support skipped tests") switched to using
> `enum kunit_status` to track the result of running a test/suite since we
> now have more than just pass/fail.
>
> This callsite wasn't updated, silently converting to enum to a bool and
> then back.
>
> Fixes: 6d2426b2f258 ("kunit: Support skipped tests")
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
