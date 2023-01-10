Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3D4663A2B
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jan 2023 08:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbjAJHvL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Jan 2023 02:51:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237209AbjAJHvJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Jan 2023 02:51:09 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB7CFD08;
        Mon,  9 Jan 2023 23:51:06 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 226B94E025;
        Tue, 10 Jan 2023 07:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1673337062; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/cbvjj95MLi+ox83pnz3idNl14zzkT1olk9CfjRT+DY=;
        b=XZhwQMFPmTqgjRcddpgf6wH9FL2iLJk3EQddEFO0hxzi7/cNyZBAC71jFZBZ4j5WnNjJz9
        mFBWwjTqkta1VTwFtx8AeQ76SwZ2CrX0ORDULJMX1x5neEU12e5dyn4m7LwMR975bE+qGW
        ini1e1HcTFf7OnWoY/r3BDMNJwhswvs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1673337062;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/cbvjj95MLi+ox83pnz3idNl14zzkT1olk9CfjRT+DY=;
        b=3BS8mRyES+f2UwYlXmmxOoiuLcIfxpOpHW/kjQQjqzpD1HYTDP2Rn11q7xX/AqmM5dfZ6j
        BkHp7QXcOnFEoADw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CDC711358A;
        Tue, 10 Jan 2023 07:51:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kat+MeUYvWM0fAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 10 Jan 2023 07:51:01 +0000
Message-ID: <ae952aa5-f113-8786-6fe4-60e5fa0ced2b@suse.cz>
Date:   Tue, 10 Jan 2023 08:51:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] kunit: memcpy: Split slow memcpy tests into
 MEMCPY_SLOW_KUNIT_TEST
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Kees Cook <keescook@chromium.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-hardening@vger.kernel.org, David Gow <davidgow@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Isabella Basso <isabbasso@riseup.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>
References: <20230107040203.never.112-kees@kernel.org>
 <CAMuHMdURtDNzzaoBM4DpEHKiDsgnA-7Yc9QO=5gsmwz9PHWK5w@mail.gmail.com>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAMuHMdURtDNzzaoBM4DpEHKiDsgnA-7Yc9QO=5gsmwz9PHWK5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

+Cc rest of kunit from MAINTAINERS

On 1/7/23 11:55, Geert Uytterhoeven wrote:
> Hi Kees,
> 
> On Sat, Jan 7, 2023 at 5:02 AM Kees Cook <keescook@chromium.org> wrote:
>> Since the long memcpy tests may stall a system for tens of seconds
>> in virtualized architecture environments, split those tests off under
>> CONFIG_MEMCPY_SLOW_KUNIT_TEST so they can be separately disabled.
>>
>> Reported-by: Guenter Roeck <linux@roeck-us.net>
>> Link: https://lore.kernel.org/lkml/20221226195206.GA2626419@roeck-us.net
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Nathan Chancellor <nathan@kernel.org>
>> Cc: linux-hardening@vger.kernel.org
>> Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Thanks for your patch!
> 
>> --- a/lib/Kconfig.debug
>> +++ b/lib/Kconfig.debug
>> @@ -2621,6 +2621,15 @@ config MEMCPY_KUNIT_TEST
>>
>>           If unsure, say N.
>>
>> +config MEMCPY_SLOW_KUNIT_TEST
>> +       tristate "Include exhaustive memcpy tests" if !KUNIT_ALL_TESTS
> 
> Why the tristate?
> 
>> +       depends on MEMCPY_KUNIT_TEST
>> +       default KUNIT_ALL_TESTS
>> +       help
>> +         Some memcpy tests are quite exhaustive in checking for overlaps
>> +         and bit ranges. These can be very slow, so they are split out
>> +         as a separate config.
>> +
>>  config IS_SIGNED_TYPE_KUNIT_TEST
>>         tristate "Test is_signed_type() macro" if !KUNIT_ALL_TESTS
>>         depends on KUNIT
>> diff --git a/lib/memcpy_kunit.c b/lib/memcpy_kunit.c
>> index 89128551448d..cc1f36335a9b 100644
>> --- a/lib/memcpy_kunit.c
>> +++ b/lib/memcpy_kunit.c
>> @@ -307,8 +307,12 @@ static void set_random_nonzero(struct kunit *test, u8 *byte)
>>         }
>>  }
>>
>> -static void init_large(struct kunit *test)
>> +static int init_large(struct kunit *test)
>>  {
>> +       if (!IS_ENABLED(CONFIG_MEMCPY_SLOW_KUNIT_TEST)) {
>> +               kunit_skip(test, "Slow test skipped. Enable with CONFIG_MEMCPY_SLOW_KUNIT_TEST=y");
> 
> So I can't make the slower tests available for when I need them,
> but not run them by default?

Indeed it seems weird to tie this to a config option without runtime override.

> I guess that's why you made MEMCPY_SLOW_KUNIT_TEST tristate originally,
> to have a separate module with the slow tests?

On the other hand I can imagine requiring a separate module for slow tests
would lead to more churn - IIUC there would need to be two files instead of
memcpy_kunit.c, possibly a duplicated boilerplate code (or another shared .c
file).

So the idea is to have a generic way to mark some tests as slow and a way to
opt-in/opt-out for those when running the tests. Maybe KUnit folks already
have such mechanism or have an idea how to implement that.

>> +               return -EBUSY;
>> +       }
>>
>>         /* Get many bit patterns. */
>>         get_random_bytes(large_src, ARRAY_SIZE(large_src));
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

