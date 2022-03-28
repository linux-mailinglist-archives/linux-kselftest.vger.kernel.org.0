Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3344D4E9C33
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Mar 2022 18:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237266AbiC1Q3Q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Mar 2022 12:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235479AbiC1Q3P (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Mar 2022 12:29:15 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1378B6004B
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Mar 2022 09:27:34 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id b24so17544935edu.10
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Mar 2022 09:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XEFWEPpsTEXkLdyr1Ezg2gVzCPhUwdW/+QiCX/qKU9c=;
        b=riSaaaSmFdboFZxl9sKIysyEp4a0WnJRns30buM8Q75sbJq8FqwsF9ceVR9o84+p8Y
         YiJ9S2SvldTY4O+dOn6tGIZdXJpd0gLhydf9VSYfJ3ewBp7t+W7aQialZtss9h6DU2dq
         WNuBmEuYuwTlJHTyC3cN9iCnND+vGHdAN9IAo/+2zwTQJdukZGJ5uxvASvO0A1Gr+f4O
         EhwBBSvVIGLFGE9pL4ulxksfM6fEXGMift1+HGvv0n960qow3X5jdGcfC6t1M+DBbLB5
         sYptd4mxJiSAy5rzM1Z4Rac4hccehG5c5Qit+fIWbhts1E4VCMlEy0fyH/AAFmhhZXai
         ne9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XEFWEPpsTEXkLdyr1Ezg2gVzCPhUwdW/+QiCX/qKU9c=;
        b=RmsOA1qqgrLhjr2N+fzjNriAkJ77QZU1fPAE4KkZjfyNw5wEBEBlGoddaPiwbe3xkz
         7JwSIa6srlQyFyHKg2BGHHXcX0pyRfzQ46DWKdzYMWKJ/911ILJKQ+R/Oe8k7Os50lAN
         Wf8n+isPBZ51CBzqcZqqYuiCadO9AObzNkBdzwiIyzDpTZxW+V7FkN0A+xywqZcER0EH
         79Ptw06miAooRPDP5o7iUE0F8RYybEO7hML1c0GQa+XdB8TDlcYgq3UicmKzd2BfbHew
         QCjG/Y1qCd9WlCOSRYEUjO66G9Ui5IfVigkmkmQfXY5lrrJuXij07P+XvfknhQorgfNg
         pHRQ==
X-Gm-Message-State: AOAM53058AA0qFEHKEnEv+Pa1bh07o7nEiWnB8dCp65Yk1urc8cQebfG
        MlYcqrSKZTA+fTs6SGHxi01xk0FfYAFTZ0LEGZKkLg==
X-Google-Smtp-Source: ABdhPJxJaAYUy3dl/HuZh0tMXNHIVdjIu/Vmo2Lr0lwMqJgEr+0K1JO5Mk2kiy+JmRfLtwMldWDClK8WeTepoFdlkvQ=
X-Received: by 2002:aa7:da90:0:b0:418:d7d3:3ceb with SMTP id
 q16-20020aa7da90000000b00418d7d33cebmr17045906eds.129.1648484852398; Mon, 28
 Mar 2022 09:27:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220326003356.487828-1-dlatypov@google.com>
In-Reply-To: <20220326003356.487828-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 28 Mar 2022 12:27:21 -0400
Message-ID: <CAFd5g46J2iNYE3T7JFkckh5nnQ9W_75o9ukMSSD=+v+cVGrLFA@mail.gmail.com>
Subject: Re: [PATCH] Documentation: kunit: update kconfig options needed for
 UML coverage
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        maxime@cerno.tech
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

On Fri, Mar 25, 2022 at 8:34 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> Recent changes have made it so the current set is not sufficient.
> Namely, CONFIG_DEBUG_INFO is not being set even when explicitly asked.
>
> Specifying a version of the debug info fixes this.
> Pick CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT as an option that's
> hopefully less fragile (esp. given we're tied to GCC 6 and lower).
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

I agree with David's comment. Otherwise,

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
