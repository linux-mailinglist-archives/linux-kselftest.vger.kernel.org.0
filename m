Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 759B3682057
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Jan 2023 01:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjAaAE6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Jan 2023 19:04:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjAaAE5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Jan 2023 19:04:57 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F863EF
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Jan 2023 16:04:56 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id l7so4003058ilf.0
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Jan 2023 16:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8BhSRwMVXxuU+369SFYGj7Ymc7BXj/kKm12kMslOVkM=;
        b=ZSVdaMAKZzRpWwR2cThrlBzJ79H2pkCj6uEqIKXvJTwXvplRmXOQN6pCPhFGER4ixd
         YIBurgyroGALBV7pjIFjvfxCRrI61cbYAM2FFS2klSQ5SjegAq2KwPGj/RLwzf9PCDg/
         xo6qKZpPydrk9sSDL9xqIkwnUltYkwPmC45hYkrehH4QNTOUk+en7oOfJ6mmb2zu23Lq
         aFgtqd7vmMv5qAwYEIIHOA8lf08PjVFlUy/2NSdmIHFuYjGBkwGhKArJENGxb1uyOndc
         MHr+XqGqfeKhZd6iNdHFLp9UHK1n08Kkjz9uMhLPqkwOCbTlMg/qH8+RtM4WzdPlT/e6
         NMUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8BhSRwMVXxuU+369SFYGj7Ymc7BXj/kKm12kMslOVkM=;
        b=R6OvcoWY2PiThjnAdzIamsJPkvazzXfWzZwpaIz+1ftSb4xYqSUMfve5m9WjRglk3D
         zXWL2js3P/lsS22Pwrgx+fkgh3Qma/zJNjPcEuTFAO4RZqxEqkHb6xTQG2xpBzZXMHU/
         9Y8K4ckbW6GS8Mk6O+gNV7U0+HtlEImuqDs3Xz/epvUWbZ3v0zqW//n1fmT9/wdY0wrb
         uSymklriQ+Bjd1iljCXC+63FgWIpRf4mKeVZMkzfjwU7YxxlOPH4W06NIO2LlPSFLWCA
         2BmQufnI98xLBl5DgWkxZ6YpNOa0ZCPT2quq5dYKqYahQ3jfFah/Za/p04jA97M3+fu/
         7Lcw==
X-Gm-Message-State: AO0yUKWc/ZUlSBvvzm6utOJ32pPqR/hBtmbxZuGt+dd0PH9MW4GMqu46
        NukcSxqZQL4xylW3tKgKbWSpeRNgcfCDsZkcrP/eEQ==
X-Google-Smtp-Source: AK7set+HE0Eoj6fa0jUiHRwdtyKKhGLsxOR16qJEZ6t6OUjst5IC0bdCNQvWgGhrj20GQRntSGrPNK87dMpmntyxFxw=
X-Received: by 2002:a92:c981:0:b0:310:99f5:df36 with SMTP id
 y1-20020a92c981000000b0031099f5df36mr3521198iln.65.1675123495672; Mon, 30 Jan
 2023 16:04:55 -0800 (PST)
MIME-Version: 1.0
References: <20230128071007.1134942-1-davidgow@google.com>
In-Reply-To: <20230128071007.1134942-1-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 30 Jan 2023 19:04:44 -0500
Message-ID: <CAFd5g47r-J+0FMt+F3pmVWBBKNXEqRD03Jh_i2HjUBhZBM8rdg@mail.gmail.com>
Subject: Re: [PATCH] kunit: Add "hooks" to call into KUnit when it's built as
 a module
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Daniel Latypov <dlatypov@google.com>,
        Rae Moar <rmoar@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Sat, Jan 28, 2023 at 2:10 AM 'David Gow' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> KUnit has several macros and functions intended for use from non-test
> code. These hooks, currently the kunit_get_current_test() and
> kunit_fail_current_test() macros, didn't work when CONFIG_KUNIT=m.
>
> In order to support this case, the required functions and static data
> need to be available unconditionally, even when KUnit itself is not
> built-in. The new 'hooks.c' file is therefore always included, and has
> both the static key required for kunit_get_current_test(), and a table
> of function pointers in struct kunit_hooks_table. This is filled in with
> the real implementations by kunit_install_hooks(), which is kept in
> hooks-impl.h and called when the kunit module is loaded.
>
> This can  be extended for future features which require similar
> "hook" behaviour, such as static stubs, by simply adding new entries to
> the struct, and the appropriate code to set them.
> Signed-off-by: David Gow <davidgow@google.com>

I agree with Rae that a new file for just setting the pointer seems a
bit much, but I also understand the point of separating it out now -
not sure of a better place for it to live. Aside from that, looks good
to me:

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
