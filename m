Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87BCD62B25D
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Nov 2022 05:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbiKPEez (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Nov 2022 23:34:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiKPEex (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Nov 2022 23:34:53 -0500
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F0A2E68F
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Nov 2022 20:34:52 -0800 (PST)
Received: by mail-vk1-xa2b.google.com with SMTP id g26so7663051vkm.12
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Nov 2022 20:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FmxnDIRF3z4tVcQHy0ykyvRCfKyX9vqd9nq5zuayq/o=;
        b=EQyJmb5NzuW7Lrmx1UMxwNMSc7k121+UGTlaW+fgEO57T29KUzUO0pmfXzmd8y6CEX
         Jb3QyrZ9WjcPq86aZ8yqUrw5KQDgEPoG8QhlKNlUADgwOfATxqgKrEr6LqoSYsM6st9F
         1YVMfFr3J7Rv1hNFVw7rtRRlXDXgV+gO7KxZyMIEDI6sDa0iQZA9CeGZkVRURnldsycn
         9zWJcqg8TV3Eq/6Y3L/D5LnkBqDr1ilu/BIrAUOpJgd28mtis4ijip0tlVxLeNAe1btT
         jTuwD3azfLPaYk1AtMV8e2lR0u5IFvrMzqMbVXeMNWV2jztW9hZGf3dGowpd6wgudenl
         3RWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FmxnDIRF3z4tVcQHy0ykyvRCfKyX9vqd9nq5zuayq/o=;
        b=mjVnfY84gg1bxYyEFzVMjWSihebNc7LfTQLQ7GFWI/PgefvlU8EulPkImAG5MMGVk+
         OFumlf0nWRidYcs65qit3zXYoMh3pQm8IB9nrgCDO92XcqweU46zXFROaZPaIABBPFJQ
         YEoEvmU6suWohWbrQqw11ombjnLKRF3W2PaJ79y9DO3rIzYfbcnmAnrUkjPsvayxOtNK
         OJFy8ZAt42vWDo3WidDzF63bXyI5hWH5RqCBAh0yf6YOxp7RP0Cqxq6kN/J4MnR2x4jU
         v0dyBCcX6nam1O0UxihjVxwRNSoxK+lw4DgBDdbtnd4FuRFOI1hwZfAe1S8SREioJ/8Y
         Xf7w==
X-Gm-Message-State: ANoB5pkvO9nzmlqVlpi9IaRNRh6oPrg3FO4W6Ad44AiaaQ5IaDd1uCl7
        5aM1pjocvuzoRVkZct2bvionDDP8iKikckTGC0ZYhg==
X-Google-Smtp-Source: AA0mqf71S572lwU6nUh1KCBE2iEeZgtF1t/Kg31iPNqx35YME43NQlTnmOzGQHbpzsQxj91vADhe3iC/FCPOG1OhHDc=
X-Received: by 2002:a05:6122:d06:b0:3bb:d1fb:15f2 with SMTP id
 az6-20020a0561220d0600b003bbd1fb15f2mr11898407vkb.37.1668573291838; Tue, 15
 Nov 2022 20:34:51 -0800 (PST)
MIME-Version: 1.0
References: <20221106021657.1145519-1-pedro.falcato@gmail.com> <202211061948.46D3F78@keescook>
In-Reply-To: <202211061948.46D3F78@keescook>
From:   David Gow <davidgow@google.com>
Date:   Wed, 16 Nov 2022 12:34:40 +0800
Message-ID: <CABVgOSm9V37KgiP-eHxfYF4tTT+ZDQKVxEAzh8P0SH3WrECM9A@mail.gmail.com>
Subject: Re: [PATCH] fs/binfmt_elf: Fix memsz > filesz handling
To:     Kees Cook <keescook@chromium.org>
Cc:     Pedro Falcato <pedro.falcato@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, sam@gentoo.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org, Rich Felker <dalias@libc.org>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
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

On Mon, Nov 7, 2022 at 11:59 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Sun, Nov 06, 2022 at 02:16:57AM +0000, Pedro Falcato wrote:
> David, has there been any work on adding a way to instantiate
> userspace VMAs in a KUnit test? I tried to write this myself, but I
> couldn't figure out how to make the userspace memory mappings appear.
> Here's my fumbling attempt:
> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=devel/kunit/usercopy
>
> I really wish KUnit had userspace mapping support -- I have a bunch of
> unit tests that need to get built up around checking for regressions
> here, etc.

Hi Kees,

Sorry the the delayed response!

Alas, my attempts to get this to work haven't been much more
successful than yours. It's definitely something we'd like to support,
but I confess to not knowing enough about the mm code to know exactly
what would be involved.

The workaround is to load tests as modules, and use something like
Vitor's original patch here:
https://lore.kernel.org/all/20200721174036.71072-1-vitor@massaru.org/

Basically, using the existing mm of the module loader. Adapting those
changes to your branch (and fixing a couple of back-to-front KUnit
assertions) does work for me when built as a module, in an x86_64 vm:

root@slicestar:~# modprobe usercopy_kunit
[   52.986290]     # Subtest: usercopy
[   52.986701]     1..1
[   53.246058]     ok 1 - usercopy_test
[   53.246628] ok 1 - usercopy

But getting it to work with built-in tests hasn't been successful so
far. I wondered if we could just piggy-back on init_mm or similar, but
that doesn't seem to work either.

So, in the short-term, this is only possible for modules. If that's
useful enough, we can get Vitor's support patch (or something similar)
in, and just mark any tests module-only (or have them skip if there's
no mm). Because kunit.py only runs built-in tests, though, it's
definitely less convenient.

Cheers,
-- David
