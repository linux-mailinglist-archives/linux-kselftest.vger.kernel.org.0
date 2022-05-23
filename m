Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B01531CF7
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 May 2022 22:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239623AbiEWRSL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 May 2022 13:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240135AbiEWRRa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 May 2022 13:17:30 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E594D6FD39
        for <linux-kselftest@vger.kernel.org>; Mon, 23 May 2022 10:17:17 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id wh22so30093059ejb.7
        for <linux-kselftest@vger.kernel.org>; Mon, 23 May 2022 10:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fedUXB9PCZprDJtOf0/YUNtATNS2b1cwPIEIQjz3C5U=;
        b=qSGY95RPQbk/z3IZR2wbR9A+mIAY4Evz9P0y1QbCQZkw9mL3rtDPqjtqier7UAQbRt
         cRXL97xjijcBb2skG6FctVkzFdhkgqSxrsm4wM7wgxjsQvOir4bI7uATxEvuRfIwc44a
         EwpX/thbz01WEwPwaS+BR4fXjazKiGLx21UrszmsB4Jc2evogwNg6KTyok2wBTqDFVSd
         BOqV/5UpARO8gm/18TeR3u86M2cuaIaZHIcg7QWRdC9V1i4j+HshVV1q0YQu1vaAiJb1
         7VeYI4hYWMv/nIBKym0uuUsyDsGjmroQS67KhM474f3HzYsx2G4oK4iZtOuRfwJY/t7S
         JGFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fedUXB9PCZprDJtOf0/YUNtATNS2b1cwPIEIQjz3C5U=;
        b=sh/+5d0drv3mI4kCuGWddVpBky0h7ad/egZyT01kOExe+C35pqbnMdHNsBcgF15a5c
         yPAwPHgT+ndtkHuBPV8W8KNO9foatzslxpLeHbzou4FbRjNgTq2lrb/c29i74Q3RRle6
         V5siQK+dExFLse2EAQBQ0w6fgYhmjmdVQc9dyiUJenHaXXdr1A7+8KiEOrVzZrRc7f1v
         cH+DUbbh7NAoApiUR+/YIV7E0xn1RN0PLjKRGP0Z9kA5KbnO3YzwKHJ8V/EYhijBL57L
         e9jYSpbTeQthxpfFwYNbXU5jQIEg97hsmsALz45BE/fF9feIQuLdqlNINs1NSNXHVKJh
         H8JQ==
X-Gm-Message-State: AOAM530NYWkwfmz/O4R8oGJaQekbJDpeonUrqJzNmBwj+hDKfZe3/Tg0
        Qx4g22N/ef1Ma4AEEx94G23AmjPByJzVFXkCHLqPYA==
X-Google-Smtp-Source: ABdhPJxJp+UOrH5XwC1bW0gxjFCeL9tPbqF9Oys4KOYyLcxhtgzBSwhtxHRu1jsf4X3pcTQXwa5oIGirMCihhSJafo8=
X-Received: by 2002:a17:907:3faa:b0:6fe:d013:b22a with SMTP id
 hr42-20020a1709073faa00b006fed013b22amr7070939ejc.425.1653326161514; Mon, 23
 May 2022 10:16:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220523020209.11810-1-ojeda@kernel.org> <20220523020209.11810-5-ojeda@kernel.org>
In-Reply-To: <20220523020209.11810-5-ojeda@kernel.org>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Mon, 23 May 2022 10:15:50 -0700
Message-ID: <CAGS_qxrW+GpDpD7-jxyGaPtQUzBGTdR7N=_7FRR0KdoJCshAAA@mail.gmail.com>
Subject: Re: [PATCH v7 04/25] kunit: take `kunit_assert` as `const`
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
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

On Sun, May 22, 2022 at 7:03 PM Miguel Ojeda <ojeda@kernel.org> wrote:
>
> The `kunit_do_failed_assertion` function passes its
> `struct kunit_assert` argument to `kunit_fail`. This one,
> in turn, calls its `format` field passing the assert again
> as a `const` pointer.
>
> Therefore, the whole chain may be made `const`.
>
> Reviewed-by: Daniel Latypov <dlatypov@google.com>
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
> This is a prerequisite patch, independently submitted at:
>
>     https://lore.kernel.org/lkml/20220502093625.GA23225@kernel.org/

FYI, we'd asked Shuah to pick this patch up in her "kunit" branch.
It's applied here:
https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/commit/?h=kunit&id=7466886b400b1904ce30fa311904849e314a2cf4

It had previously seemed unclear if this series could make it for the
5.19 merge window (but it now looks like there's interest in trying it
out early on).

Daniel
