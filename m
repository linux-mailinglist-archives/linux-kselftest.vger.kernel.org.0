Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3ADB5292CE
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 May 2022 23:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346451AbiEPVXV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 May 2022 17:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349281AbiEPVXS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 May 2022 17:23:18 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDBF937029
        for <linux-kselftest@vger.kernel.org>; Mon, 16 May 2022 14:23:09 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id gh6so31166490ejb.0
        for <linux-kselftest@vger.kernel.org>; Mon, 16 May 2022 14:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I0a0B8Rv0mJ/OtknlrFk7pFGBT0rhDPrGK40+Qo9Qew=;
        b=rA+MXBawcX1dqkELsw9JjGpfUGxbUuxgRwUiBl4b6Or1/IA8xaklp8o+QrXJmg4u6N
         dzsQpLWbdrZYQ1sVhZBbCpkFdtxJD46THecPNqkKIXcKDPY4PmcoG4KY+5L/ir+J6w5T
         AScaAsVDrSu9OsAIX0nDo0Jix3TJlPTDwkrxKCW80xcVETaq9O3VVfXYxBKj4KW2xSLQ
         dn2RZLQ5e39QhXQdGu0gCwn/Jes3cPnAs3Jcs3iUgJWshoUAQ97+KTMrWddd8tKknO+P
         BVoInc2jVFKI3jqDWCo7b1AhXzqHAFA5v1Aphoo68XyH5uS/F85D9eqs0mhUN9UfDaPK
         PxPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I0a0B8Rv0mJ/OtknlrFk7pFGBT0rhDPrGK40+Qo9Qew=;
        b=w2szk+d0LSDVsxbv6Ns9toHWiVpxui5GQgOiYZz/X9frKZnnLRr7EQn1WVrWcvkZcA
         DYsNOx+98K0qDK/eDsUZCy7DUWaZGBCVMvXz5R6sqVyuCyRVNTj8gDZo0Qik2euREThh
         ZR6OnJPQ8i+K5p3OYBleiZXi1GQVwsyMx2OL5M8prVtWeN28oDmt0/1vCJ1W+FJrrorZ
         GQYscb/V6kZCH3gByD/6XA7SzGMARc5d26kOLV9IDjBrHnBbaoBYtDv1b5/Cj9I8xfBH
         GcJmU1c9fMknftUQpt7aJXVmWn9bKenI9gzQCkkJAN022LyrWg1N3BUf73hro+OdJIKy
         bVzA==
X-Gm-Message-State: AOAM532ZcOonDAQJKAcF1mWqreFvvjw44JemhbvsJwAhvod69ne1dDf3
        uul1WJsd2+AQx1CUnueIqoOazAJwa4F+KcZ7g9NI1w==
X-Google-Smtp-Source: ABdhPJywy0Tb8iF+LhJE7kzLQBe5uT7PmY6E6Qm3zmpjX6A0U5IgqJ5gumun0VJuIvITK5vWSI/Oqo36NWeYbiLxxhw=
X-Received: by 2002:a17:906:8696:b0:6f3:a043:6ea7 with SMTP id
 g22-20020a170906869600b006f3a0436ea7mr17336946ejx.387.1652736188135; Mon, 16
 May 2022 14:23:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220513183707.97290-1-dlatypov@google.com>
In-Reply-To: <20220513183707.97290-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 16 May 2022 17:22:56 -0400
Message-ID: <CAFd5g45sOpGhbHUQpP5eeVRmqB=MqcFbSyntsfbEbGuOJWcjqA@mail.gmail.com>
Subject: Re: [PATCH] kunit: fix executor OOM error handling logic on non-UML
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

On Fri, May 13, 2022 at 2:37 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> The existing logic happens to work fine on UML, but is not correct when
> running on other arches.
>
> 1. We didn't initialize `int err`, and kunit_filter_suites() doesn't
>    explicitly set it to 0 on success. So we had false "failures".
>    Note: it doesn't happen on UML, causing this to get overlooked.
> 2. If we error out, we do not call kunit_handle_shutdown().
>    This makes kunit.py timeout when using a non-UML arch, since the QEMU
>    process doesn't ever exit.
>
> Fixes: a02353f49162 ("kunit: bail out of test filtering logic quicker if OOM")
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
