Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B27567585
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Jul 2022 19:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbiGERYX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Jul 2022 13:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbiGERYV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Jul 2022 13:24:21 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525B71C92D
        for <linux-kselftest@vger.kernel.org>; Tue,  5 Jul 2022 10:24:19 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id e69so16471287ybh.2
        for <linux-kselftest@vger.kernel.org>; Tue, 05 Jul 2022 10:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5e8U35PaIrJWquC7BxkxdNfD7FPQvOY1UJKYTwQZSkM=;
        b=hWTA/pwJJBrlNoWP6gkRVXoLOFru6NZVViPF9ZyKYS1hcSgIKnUjJ3LipxLT0AkdQt
         ha79KzH1DfTiC6vuYJK+s06v4IHp856qAP+0YpOLRuIEntDDO0YH/kiKqVxroHqIEXNp
         pMtfpXlKJ15T7yq33Lb873sE1KJBBMwsjKcgPg0wU6S+Y3upWej/Ys3FHYuIx8QP9Iox
         78WWWKW43p8fI4OxWfc3aqCtCK1j3qHQ0kZRX19cjcCRO0PgbDGVutnylhw+1raOfveG
         sdzQwXfq1EBXv99aLTtmpGbtSw22rDVCs0mDy1+d1lycBOiEQhHIb7l+y4yet62IP2Dq
         X1sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5e8U35PaIrJWquC7BxkxdNfD7FPQvOY1UJKYTwQZSkM=;
        b=5oo/NywHCU2aCNBPqOOhHybrNyITSrRtjtOmvvpWOS3WK3nqkJ8NG7A9vUIYD4n6Di
         69x4GezL8ckZACyCVxEsu1aU5PEcAjNJ/QumPnn9rWffYUQfv8hU/gsBWp5BR81n2txa
         rNHMKSJgivEAl2XyfL3JzGKYFtUJTk4IdlkPhEBuK8TOADtFbTOC57ZGPdYVP16HGNOi
         VkvJl3Q63eco9sGbRsefAey37ChLd1++aVMzIQfjSOPwTWpRIA9JPyPSoGEftmIB5k8e
         XwZ2HVYhs0lGjncl2O254fGReiQBJjPURl2etfFAJCPU0uP0sn8cZHgpyCYMK96Wiu4e
         Ltsg==
X-Gm-Message-State: AJIora8XvT8W7vPTuGu+Btgcp3dg6O0EOOd7BBRDsp6fRBsg7ggduWME
        hLngzqK8bNUEC0NsaXFgmWC8YxpOn8PLy4oteK5bRw==
X-Google-Smtp-Source: AGRyM1tU7x3FA8K1Sj+Bhm/Qn/0xEwAwL4v5km/eCdYFcPNq7BAeSYUCW3DFj0NCeaEgFuKj4EXZKDrfxQnrt04RgMg=
X-Received: by 2002:a05:6902:70e:b0:66e:86f5:af79 with SMTP id
 k14-20020a056902070e00b0066e86f5af79mr2652220ybt.229.1657041858321; Tue, 05
 Jul 2022 10:24:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0d:f944:0:0:0:0:0 with HTTP; Tue, 5 Jul 2022 10:24:17 -0700 (PDT)
In-Reply-To: <CABVgOS=V+-AN65mZRnzZo8LqDZgEPXrwGPXTSsPUsnBvzi7+WA@mail.gmail.com>
References: <20220704135833.1496303-1-martin.fernandez@eclypsium.com>
 <20220704135833.1496303-8-martin.fernandez@eclypsium.com> <CABVgOS=V+-AN65mZRnzZo8LqDZgEPXrwGPXTSsPUsnBvzi7+WA@mail.gmail.com>
From:   Martin Fernandez <martin.fernandez@eclypsium.com>
Date:   Tue, 5 Jul 2022 14:24:17 -0300
Message-ID: <CAKgze5ahanzdTWawTkNxG8KbkX0GRX2YRQROPjpm7AjHpFp_fA@mail.gmail.com>
Subject: Re: [PATCH v9 7/9] x86/e820: Add unit tests for e820_range_* functions
To:     David Gow <davidgow@google.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, tglx@linutronix.de,
        Ingo Molnar <mingo@redhat.com>, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ardb@kernel.org, dvhart@infradead.org, andy@infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rafael@kernel.org, rppt@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        daniel.gutson@eclypsium.com, hughsient@gmail.com,
        alex.bazhaniuk@eclypsium.com, alison.schofield@intel.com,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/4/22, David Gow <davidgow@google.com> wrote:
> On Mon, Jul 4, 2022 at 9:59 PM 'Martin Fernandez' via KUnit
> Development <kunit-dev@googlegroups.com> wrote:
>>
>> Add KUnit tests for the e820_range_* functions.
>>
>> Signed-off-by: Martin Fernandez <martin.fernandez@eclypsium.com>
>> ---
>
> This looks good to me from a KUnit point of view. I've tested it on
> both 32- and 64- bit x86 under qemu with the following:
> ./tools/testing/kunit/kunit.py run --arch=i386 'e820'
> ./tools/testing/kunit/kunit.py run --arch=x86_64 'e820'

Yes, that's how I ran it. The new qemu executions are great by the way :)

> Two notes inline below:
> - An indentation error in the Kconfig entry, which stops it from compiling.
> - Some minor pontificating about how KUnit wants to name macros in
> general. (No action required: just making a note that this is probably
> okay.)
>
> With the indentation issue fixed, this is:
>
> Reviewed-by: David Gow <davidgow@google.com>
>
> Cheers,
> -- David
>
>>  arch/x86/Kconfig.debug      |  10 ++
>>  arch/x86/kernel/e820.c      |   5 +
>>  arch/x86/kernel/e820_test.c | 249 ++++++++++++++++++++++++++++++++++++
>>  3 files changed, 264 insertions(+)
>>  create mode 100644 arch/x86/kernel/e820_test.c
>>
>> diff --git a/arch/x86/Kconfig.debug b/arch/x86/Kconfig.debug
>> index d872a7522e55..b5040d345fb4 100644
>> --- a/arch/x86/Kconfig.debug
>> +++ b/arch/x86/Kconfig.debug
>> @@ -225,6 +225,16 @@ config PUNIT_ATOM_DEBUG
>>           The current power state can be read from
>>           /sys/kernel/debug/punit_atom/dev_power_state
>>
>> +config E820_KUNIT_TEST
>> +       tristate "Tests for E820" if !KUNIT_ALL_TESTS
>> +       depends on KUNIT=y
>> +       default KUNIT_ALL_TESTS
>> +       help
>> +         This option enables unit tests for the e820.c code. It
>> +         should be enabled only in development environments.
>> +
>> +         If unsure, say N.
>
> The indentation here seems to be one space off, leading to errors building
> it:
>
> arch/x86/Kconfig.debug:236: syntax error
> arch/x86/Kconfig.debug:235:warning: ignoring unsupported character ','
> arch/x86/Kconfig.debug:235:warning: ignoring unsupported character '.'
> arch/x86/Kconfig.debug:235: unknown statement "If"
> make[2]: *** [../scripts/kconfig/Makefile:77: olddefconfig] Error 1

I don't know what happened, I saw checkpatch warning me about the a
help description but since it looked good to me I didn't mind. Now I
see the actual error.

>> +
>>  choice
>>         prompt "Choose kernel unwinder"
>>         default UNWINDER_ORC if X86_64
>> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
>> index dade59758b9f..a6ced3e306dd 100644
>> --- a/arch/x86/kernel/e820.c
>> +++ b/arch/x86/kernel/e820.c
>> @@ -1546,3 +1546,8 @@ void __init e820__memblock_setup(void)
>>
>>         memblock_dump_all();
>>  }
>> +
>> +#ifdef CONFIG_E820_KUNIT_TEST
>> +/* Let e820_test have access the static functions in this file */
>> +#include "e820_test.c"
>> +#endif
>> diff --git a/arch/x86/kernel/e820_test.c b/arch/x86/kernel/e820_test.c
>> new file mode 100644
>> index 000000000000..6b28ea131380
>> --- /dev/null
>> +++ b/arch/x86/kernel/e820_test.c
>> @@ -0,0 +1,249 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +#include <kunit/test.h>
>> +
>> +#include <asm/e820/api.h>
>> +#include <asm/setup.h>
>> +
>> +#define KUNIT_EXPECT_E820_ENTRY_EQ(_test, _entry, _addr, _size, _type,
>>      \
>> +                                  _crypto_capable)
>>     \
>> +       do {
>>     \
>> +               KUNIT_EXPECT_EQ((_test), (_entry).addr, (_addr));
>>     \
>> +               KUNIT_EXPECT_EQ((_test), (_entry).size, (_size));
>>     \
>> +               KUNIT_EXPECT_EQ((_test), (_entry).type, (_type));
>>     \
>> +               KUNIT_EXPECT_EQ((_test), (_entry).crypto_capable,
>>     \
>> +                               (_crypto_capable));
>>     \
>> +       } while (0)
>> +
>
> I'm not 100% sure we ever came to a decision about tests naming their
> own expect macros KUNIT_EXPECT_*. I know KASAN is doing it, though the
> thought there was that other tests might have sensible reasons to
> expect given memory accesses, so it might not be limited to the one
> test.
>
> Personally, I don't mind it, particularly since it's obvious that this
> is specific to the e820 test.

That's true, I didn't think about, because as you said the naming is
quite obviuos, but I get that it could be an issue.

>> +struct e820_table test_table __initdata;
>> +
>> +static void __init test_e820_range_add(struct kunit *test)
>> +{
>> +       u32 full = ARRAY_SIZE(test_table.entries);
>> +       /* Add last entry. */
>> +       test_table.nr_entries = full - 1;
>> +       __e820__range_add(&test_table, 0, 15, 0, 0);
>> +       KUNIT_EXPECT_EQ(test, test_table.nr_entries, full);
>> +       /* Skip new entry when full. */
>> +       __e820__range_add(&test_table, 0, 15, 0, 0);
>> +       KUNIT_EXPECT_EQ(test, test_table.nr_entries, full);
>> +}
>> +
>> +static void __init test_e820_range_update(struct kunit *test)
>> +{
>> +       u64 entry_size = 15;
>> +       u64 updated_size = 0;
>> +       /* Initialize table */
>> +       test_table.nr_entries = 0;
>> +       __e820__range_add(&test_table, 0, entry_size, E820_TYPE_RAM,
>> +                         E820_NOT_CRYPTO_CAPABLE);
>> +       __e820__range_add(&test_table, entry_size, entry_size,
>> E820_TYPE_RAM,
>> +                         E820_NOT_CRYPTO_CAPABLE);
>> +       __e820__range_add(&test_table, entry_size * 2, entry_size,
>> +                         E820_TYPE_ACPI, E820_NOT_CRYPTO_CAPABLE);
>> +
>> +       updated_size = __e820__range_update(&test_table, 0, entry_size *
>> 2,
>> +                                           E820_TYPE_RAM,
>> E820_TYPE_RESERVED);
>> +
>> +       /* The first 2 regions were updated */
>> +       KUNIT_EXPECT_EQ(test, updated_size, entry_size * 2);
>> +       KUNIT_EXPECT_E820_ENTRY_EQ(test, test_table.entries[0], 0,
>> entry_size,
>> +                                  E820_TYPE_RESERVED,
>> E820_NOT_CRYPTO_CAPABLE);
>> +       KUNIT_EXPECT_E820_ENTRY_EQ(test, test_table.entries[1],
>> entry_size,
>> +                                  entry_size, E820_TYPE_RESERVED,
>> +                                  E820_NOT_CRYPTO_CAPABLE);
>> +       KUNIT_EXPECT_E820_ENTRY_EQ(test, test_table.entries[2], entry_size
>> * 2,
>> +                                  entry_size, E820_TYPE_ACPI,
>> +                                  E820_NOT_CRYPTO_CAPABLE);
>> +
>> +       updated_size = __e820__range_update(&test_table, 0, entry_size *
>> 3,
>> +                                           E820_TYPE_RESERVED,
>> E820_TYPE_RAM);
>> +
>> +       /*
>> +        * Only the first 2 regions were updated,
>> +        * since E820_TYPE_ACPI > E820_TYPE_RESERVED
>> +        */
>> +       KUNIT_EXPECT_EQ(test, updated_size, entry_size * 2);
>> +       KUNIT_EXPECT_E820_ENTRY_EQ(test, test_table.entries[0], 0,
>> entry_size,
>> +                                  E820_TYPE_RAM,
>> E820_NOT_CRYPTO_CAPABLE);
>> +       KUNIT_EXPECT_E820_ENTRY_EQ(test, test_table.entries[1],
>> entry_size,
>> +                                  entry_size, E820_TYPE_RAM,
>> +                                  E820_NOT_CRYPTO_CAPABLE);
>> +       KUNIT_EXPECT_E820_ENTRY_EQ(test, test_table.entries[2], entry_size
>> * 2,
>> +                                  entry_size, E820_TYPE_ACPI,
>> +                                  E820_NOT_CRYPTO_CAPABLE);
>> +}
>> +
>> +static void __init test_e820_range_remove(struct kunit *test)
>> +{
>> +       u64 entry_size = 15;
>> +       u64 removed_size = 0;
>> +
>> +       struct e820_entry_updater updater = { .should_update =
>> +
>> remover__should_update,
>> +                                             .update = remover__update,
>> +                                             .new = NULL };
>> +
>> +       struct e820_remover_data data = { .check_type = true,
>> +                                         .old_type = E820_TYPE_RAM };
>> +
>> +       /* Initialize table */
>> +       test_table.nr_entries = 0;
>> +       __e820__range_add(&test_table, 0, entry_size, E820_TYPE_RAM,
>> +                         E820_NOT_CRYPTO_CAPABLE);
>> +       __e820__range_add(&test_table, entry_size, entry_size,
>> E820_TYPE_RAM,
>> +                         E820_NOT_CRYPTO_CAPABLE);
>> +       __e820__range_add(&test_table, entry_size * 2, entry_size,
>> +                         E820_TYPE_ACPI, E820_NOT_CRYPTO_CAPABLE);
>> +
>> +       /*
>> +        * Need to use __e820__handle_range_update because
>> +        * e820__range_remove doesn't ask for the table
>> +        */
>> +       removed_size = __e820__handle_range_update(&test_table,
>> +                                                  0, entry_size * 2,
>> +                                                  &updater, &data);
>> +
>> +       /* The first two regions were removed */
>> +       KUNIT_EXPECT_EQ(test, removed_size, entry_size * 2);
>> +       KUNIT_EXPECT_E820_ENTRY_EQ(test, test_table.entries[0], 0, 0, 0,
>> 0);
>> +       KUNIT_EXPECT_E820_ENTRY_EQ(test, test_table.entries[1], 0, 0, 0,
>> 0);
>> +
>> +       removed_size = __e820__handle_range_update(&test_table,
>> +                                                  0, entry_size * 3,
>> +                                                  &updater, &data);
>> +
>> +       /* Nothing was removed, since nothing matched the target type */
>> +       KUNIT_EXPECT_EQ(test, removed_size, 0);
>> +       KUNIT_EXPECT_E820_ENTRY_EQ(test, test_table.entries[0], 0, 0, 0,
>> 0);
>> +       KUNIT_EXPECT_E820_ENTRY_EQ(test, test_table.entries[1], 0, 0, 0,
>> 0);
>> +       KUNIT_EXPECT_E820_ENTRY_EQ(test, test_table.entries[2], entry_size
>> * 2,
>> +                                  entry_size, E820_TYPE_ACPI,
>> +                                  E820_NOT_CRYPTO_CAPABLE);
>> +}
>> +
>> +static void __init test_e820_range_crypto_update(struct kunit *test)
>> +{
>> +       u64 entry_size = 15;
>> +       u64 updated_size = 0;
>> +       /* Initialize table */
>> +       test_table.nr_entries = 0;
>> +       __e820__range_add(&test_table, 0, entry_size, E820_TYPE_RAM,
>> +                         E820_CRYPTO_CAPABLE);
>> +       __e820__range_add(&test_table, entry_size, entry_size,
>> E820_TYPE_RAM,
>> +                         E820_NOT_CRYPTO_CAPABLE);
>> +       __e820__range_add(&test_table, entry_size * 2, entry_size,
>> +                         E820_TYPE_RAM, E820_CRYPTO_CAPABLE);
>> +
>> +       updated_size = __e820__range_update_crypto(&test_table,
>> +                                                  0, entry_size * 3,
>> +                                                  E820_CRYPTO_CAPABLE);
>> +
>> +       /* Only the region in the middle was updated */
>> +       KUNIT_EXPECT_EQ(test, updated_size, entry_size);
>> +       KUNIT_EXPECT_E820_ENTRY_EQ(test, test_table.entries[0], 0,
>> entry_size,
>> +                                  E820_TYPE_RAM, E820_CRYPTO_CAPABLE);
>> +       KUNIT_EXPECT_E820_ENTRY_EQ(test, test_table.entries[1],
>> entry_size,
>> +                                  entry_size, E820_TYPE_RAM,
>> +                                  E820_CRYPTO_CAPABLE);
>> +       KUNIT_EXPECT_E820_ENTRY_EQ(test, test_table.entries[2], entry_size
>> * 2,
>> +                                  entry_size, E820_TYPE_RAM,
>> +                                  E820_CRYPTO_CAPABLE);
>> +}
>> +
>> +static void __init test_e820_handle_range_update_intersection(struct
>> kunit *test)
>> +{
>> +       struct e820_entry_updater updater = {
>> +               .should_update = type_updater__should_update,
>> +               .update = type_updater__update,
>> +               .new = type_updater__new
>> +       };
>> +
>> +       struct e820_type_updater_data data = { .old_type = E820_TYPE_RAM,
>> +                                              .new_type =
>> E820_TYPE_RESERVED };
>> +
>> +       u64 entry_size = 15;
>> +       u64 intersection_size = 2;
>> +       u64 updated_size = 0;
>> +       /* Initialize table */
>> +       test_table.nr_entries = 0;
>> +       __e820__range_add(&test_table, 0, entry_size, E820_TYPE_RAM,
>> +                         E820_NOT_CRYPTO_CAPABLE);
>> +
>> +       updated_size =
>> +               __e820__handle_range_update(&test_table, 0,
>> +                                           entry_size -
>> intersection_size,
>> +                                           &updater, &data);
>> +
>> +       KUNIT_EXPECT_EQ(test, updated_size, entry_size -
>> intersection_size);
>> +
>> +       /* There is a new entry */
>> +       KUNIT_EXPECT_EQ(test, test_table.nr_entries, intersection_size);
>> +
>> +       /* The original entry now is moved */
>> +       KUNIT_EXPECT_E820_ENTRY_EQ(test, test_table.entries[0],
>> +                                  entry_size - intersection_size,
>> +                                  intersection_size, E820_TYPE_RAM,
>> +                                  E820_NOT_CRYPTO_CAPABLE);
>> +
>> +       /* The new entry has the correct values */
>> +       KUNIT_EXPECT_E820_ENTRY_EQ(test, test_table.entries[1], 0,
>> +                                  entry_size - intersection_size,
>> +                                  E820_TYPE_RESERVED,
>> E820_NOT_CRYPTO_CAPABLE);
>> +}
>> +
>> +static void __init test_e820_handle_range_update_inside(struct kunit
>> *test)
>> +{
>> +       struct e820_entry_updater updater = {
>> +               .should_update = type_updater__should_update,
>> +               .update = type_updater__update,
>> +               .new = type_updater__new
>> +       };
>> +
>> +       struct e820_type_updater_data data = { .old_type = E820_TYPE_RAM,
>> +                                              .new_type =
>> E820_TYPE_RESERVED };
>> +
>> +       u64 entry_size = 15;
>> +       u64 updated_size = 0;
>> +       /* Initialize table */
>> +       test_table.nr_entries = 0;
>> +       __e820__range_add(&test_table, 0, entry_size, E820_TYPE_RAM,
>> +                         E820_NOT_CRYPTO_CAPABLE);
>> +
>> +       updated_size = __e820__handle_range_update(&test_table, 5,
>> +                                                  entry_size - 10,
>> +                                                  &updater, &data);
>> +
>> +       KUNIT_EXPECT_EQ(test, updated_size, entry_size - 10);
>> +
>> +       /* There are two new entrie */
>> +       KUNIT_EXPECT_EQ(test, test_table.nr_entries, 3);
>> +
>> +       /* The original entry now shrunk */
>> +       KUNIT_EXPECT_E820_ENTRY_EQ(test, test_table.entries[0], 0, 5,
>> +                                  E820_TYPE_RAM,
>> E820_NOT_CRYPTO_CAPABLE);
>> +
>> +       /* The new entries have the correct values */
>> +       KUNIT_EXPECT_E820_ENTRY_EQ(test, test_table.entries[1], 5,
>> +                                  entry_size - 10, E820_TYPE_RESERVED,
>> +                                  E820_NOT_CRYPTO_CAPABLE);
>> +       /* Left over of the original region */
>> +       KUNIT_EXPECT_E820_ENTRY_EQ(test, test_table.entries[2], entry_size
>> - 5,
>> +                                  5, E820_TYPE_RAM,
>> E820_NOT_CRYPTO_CAPABLE);
>> +}
>> +
>> +static struct kunit_case e820_test_cases[] __initdata = {
>> +       KUNIT_CASE(test_e820_range_add),
>> +       KUNIT_CASE(test_e820_range_update),
>> +       KUNIT_CASE(test_e820_range_remove),
>> +       KUNIT_CASE(test_e820_range_crypto_update),
>> +       KUNIT_CASE(test_e820_handle_range_update_intersection),
>> +       KUNIT_CASE(test_e820_handle_range_update_inside),
>> +       {}
>> +};
>> +
>> +static struct kunit_suite e820_test_suite __initdata = {
>> +       .name = "e820",
>> +       .test_cases = e820_test_cases,
>> +};
>> +
>> +kunit_test_init_section_suite(e820_test_suite);
>> --
>> 2.30.2
>>
>> --
>> You received this message because you are subscribed to the Google Groups
>> "KUnit Development" group.
>> To unsubscribe from this group and stop receiving emails from it, send an
>> email to kunit-dev+unsubscribe@googlegroups.com.
>> To view this discussion on the web visit
>> https://groups.google.com/d/msgid/kunit-dev/20220704135833.1496303-8-martin.fernandez%40eclypsium.com.
>
