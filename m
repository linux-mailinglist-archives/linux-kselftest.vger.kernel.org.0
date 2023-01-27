Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7194F67DD63
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jan 2023 07:22:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbjA0GV3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Jan 2023 01:21:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjA0GV3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Jan 2023 01:21:29 -0500
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155B65999A
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Jan 2023 22:21:28 -0800 (PST)
Received: by mail-vk1-xa32.google.com with SMTP id v5so1937359vkc.10
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Jan 2023 22:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Tt+YDrfHwbP/tcqrYWX78c8eWt6PlwIsaHwmczL9W/8=;
        b=Lc0HoLn4SumSw3g/7Q0fmfwQdUGLwQtH9azFyLymVbaroIbQr9j361vb7I7LVPwNoZ
         khlpsS+0BcPw9FSegocOalyL0J8VRO05esrxqf6ptVdK6HOjA3L519+IYIorqNuxDpGs
         ECTacR/nUdVmKWrXTWtaL/BxFTkJi++aZP3A/zsLrZU0jbRZpV9sl1/A9CcOca00uWQO
         vVeSAyUzrTD1IV0jFO+gYDudj6sxQQTFLXyPNKrbgpeyuh84/tk3XPkjymUWub/5bz34
         RStm890CYMcZUuKTZQnDXYB1WSwfd0q9BNOzgz9sjkvh24e5nE/s5WMaySsz5RXHA/53
         VliA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tt+YDrfHwbP/tcqrYWX78c8eWt6PlwIsaHwmczL9W/8=;
        b=wbFIkG6TjxZ1otHlbPpJ33QAHMDdJOK4AatbXBCgS0khpNjTEtXLILyZEKVaVDodGI
         NxooIhsHlZGKN1WXPShl4rWT06Uo2n2S6ft8XtDsYRH/YA5RTN28IAYbfeml3jPSDzcS
         1Gt9eEqkyuStWch0r2ag9nJGrD7O5KK7k6e1MTvHDjn5L1mc5u8jrhu+KTCUPvm9GyZo
         9ANkVARkA/IFxJCHfGwQQ8UaSO5h0V7Av8L8BYHD5Bl57NI0/y0GayEHl7qfxKlvI3gG
         Wk0p+G4V+8R2efKD1hJh5daaXf5/kmehtv67RoI+UmUP8bPstze6t6IKHoVN7KDAGtyB
         xHYw==
X-Gm-Message-State: AO0yUKXrQZutvNi04n6XfkKW70/K33uOlfy2ErGoQiC/Yol/0YK9Fzj8
        X88c//Y00le4mBmSVcusLJuAWEc6LS9q2Ny0r4oBmg==
X-Google-Smtp-Source: AK7set8AcJdo7lxMknpIr8EMrr/k6YI700Ac3qvKocMqzX82hKGCVFSAaduSx6qZuz8Jvaoa45m6sSpYNNwMQI5oicM=
X-Received: by 2002:ac5:c193:0:b0:3e8:35d9:7a6f with SMTP id
 z19-20020ac5c193000000b003e835d97a6fmr569665vkb.34.1674800487107; Thu, 26 Jan
 2023 22:21:27 -0800 (PST)
MIME-Version: 1.0
References: <20230124080350.2275652-1-davidgow@google.com> <CAGS_qxq4vWvRJ89477S+rxHYLvnc2xN435GQ4+BvpLgqon8miw@mail.gmail.com>
In-Reply-To: <CAGS_qxq4vWvRJ89477S+rxHYLvnc2xN435GQ4+BvpLgqon8miw@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 27 Jan 2023 14:21:15 +0800
Message-ID: <CABVgOSn+F3WOA5hR+H5x_fW=jRTGATmO+nycZ7R7mXN8X7qNvw@mail.gmail.com>
Subject: Re: [RFC PATCH v2] kunit: Add "hooks" to call into KUnit when it's
 built as a module
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Rae Moar <rmoar@google.com>,
        Sadiya Kazi <sadiyakazi@google.com>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, 27 Jan 2023 at 13:38, 'Daniel Latypov' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> On Tue, Jan 24, 2023 at 12:04 AM David Gow <davidgow@google.com> wrote:
> >
> > KUnit has several macros and functions intended for use from non-test
> > code. These hooks, currently the kunit_get_current_test() and
> > kunit_fail_current_test() macros, didn't work when CONFIG_KUNIT=m.
> >
> > In order to support this case, the required functions and static data
> > need to be available unconditionally, even when KUnit itself is not
> > built-in. The new 'hooks.c' file is therefore always included, and has
> > both the static key required for kunit_get_current_test(), and a
> > function pointer to the real implementation of
> > __kunit_fail_current_test(), which is populated when the KUnit module is
> > loaded.
> >
> > A new header, kunit/hooks-table.h, contains a table of all hooks, and is
> > repeatedly included with different definitions of the KUNIT_HOOK() in
> > order to automatically generate the needed function pointer tables. When
>
> Perhaps I'm overlooking something and this is a dumb question.
>
> Is there a reason we can't go with a less-clever approach?
> Like have a global struct?
> We could memset it to 0 to clear it instead of defining a macro to set
> individual variables to NULL?
>

I didn't think of that: it'd definitely fix the need to have a macro
for resetting the pointers to NULL, as well as the definitions.

We'd still have the repetition of the function names in the
kunit_set_hooks function and the table definition. (As well as needing
all of the implementation functions around.)

Still, I think there's value in putting this in a struct, even if we
also use the macro magic for other things. If we, for instance,
instead of setting individual members of struct kunit_hook_table, we
re-initialised it in one go, that might give the compiler enough
context to warn about uninitialised values if we missed one.

The only downside of the struct is that it's slightly uglier if people
want to call the hook function pointer directly. This is not as likely
at the moment, as it could be NULL, but it'd be possible to extend the
macro to generate a stub implementation which just returned nothing.
(Still, it'd be equally possible to autogenerate a wrapper function
which checks kunit_running, so this isn't a dealbreaker.)

> i.e.
>
> // hooks.h
> extern struct kunit_hook_table {
>         __printf(3, 4) void (*fail_current_test)(const char*, int,
> const char*, ...);
> } kunit_hooks;
>
> //hooks.c
> struct kunit_hook_table kunit_hooks;
>
> // in test.c
> // here all the functions should be in scope for us to use

This is actually the bit which pushed me over the line and made me
write the macro-based version: if the hook implementations are not all
in test.c (and the static stub ones are in static_stub.c), we'd have
to declare the hook implementation function somewhere, either
introducing a new hooks-impl.h or having a bunch of function
declarations in test.c.

My thought was, if we were going to need an extra header with more
definitions, we might as well just have one, which would also stop us
from worrying about missing an assignment in one place or the other.

> static void kunit_set_hooks(void)
> {
>   kunit_hooks.fail_current_test = __kunit_fail_current_test;
>   ...
> }
>
>  static int __init kunit_init(void)
>  {
>   ...
>   kunit_set_hooks();
>   ...
> }
>
> static void __exit kunit_exit(void)
> {
>   ...
>   memset(&kunit_hooks, 0, sizeof(kunit_hooks));
> }
>

I'll give moving this to a struct a go, it should be an improvement
even if I still use the macros to generate the struct.

The real advantage of the macro is only having to add the new hook in
two or three places:
- The hooks-table.h entry
- The _impl function (which can be in any file)
- (Optionally) a wrapper so that people don't need to check for NULL /
kunit_running themselves.

Without it, they'll have to:
- Add an entry to the struct kunit_hooks_table
- Write the implementation function.
- Add a declaration for the _impl function in test.c, if the function
isn't defined there.
- Add an entry to kunit_set_hooks()
- (Optionally) a wrapper, etc.

That's potentially twice as many things to get right. Still, it's a
lot better with the struct than doing each function individually, so
it's a closer tradeoff.
Personally, I still feel the macro-based version will eventually be
useful, but it's probably 50/50 whether it's worth it for just two or
three hooks.

Worst-case, we can do just the manual struct-based version, and
replace it with the macro one later.

Thanks,
-- David

> > KUnit is disabled, or the module is not loaded, these function pointers
> > are all NULL. This shouldn't be a problem, as they're all used behind
> > wrappers which check kunit_running and/or that the pointer is non-NULL.
> >
> > This can then be extended for future features which require similar
> > "hook" behaviour, such as static stubs:
> > https://lore.kernel.org/all/20221208061841.2186447-1-davidgow@google.com/
> >
> > Signed-off-by: David Gow <davidgow@google.com>
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/CAGS_qxq4vWvRJ89477S%2BrxHYLvnc2xN435GQ4%2BBvpLgqon8miw%40mail.gmail.com.
