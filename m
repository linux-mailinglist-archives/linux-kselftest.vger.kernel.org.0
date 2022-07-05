Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2E45660EB
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Jul 2022 04:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233209AbiGECEi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 4 Jul 2022 22:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbiGECEi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 Jul 2022 22:04:38 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D0C7675
        for <linux-kselftest@vger.kernel.org>; Mon,  4 Jul 2022 19:04:36 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id d16so9158719wrv.10
        for <linux-kselftest@vger.kernel.org>; Mon, 04 Jul 2022 19:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N4vxhcH78eDM6NhcAwyXFnjauYWcotlatF/qhNMlDPI=;
        b=F9XCGzCvNODUdPC/w5kmPsHX8FFCQK+yFfB+Zd8bj+q5iKim5gS6yAZusFtixVeOwI
         mtIOZg5C0dUnFFAUqpc5JagjfxGFfxMgMTzS5W3bTY/vlWYEcHyrKWhwA1vH6t01BgEr
         gYCwezi1pjoETcYnjzhweEbXgiz5uv3ASbPVOCRs7b5AVhLPtKUs2+okqrVRlTUoDD3D
         QZvQU/eFpahRMeubxZWOEywHzhz9G1lB4u33NJyoS6DoeTrDb5mPSYl7YDKWgaK1NuUN
         pXGxVavMnCQ/c5WQpEqTRcrDKJmeeiwmdvT15OQOJcz418fc4Iacis3fHR0FFnnxaW6M
         3dgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N4vxhcH78eDM6NhcAwyXFnjauYWcotlatF/qhNMlDPI=;
        b=hbjJo7P+CaLkYI2BOfCCZY9KOA8YgIoTwb/akt7DQbE0iR8cKHFpDV3XBkHsAZIrR3
         pPPAQYBt5ljgEPanG7XEi8vt0w7GNHfeW/5ZAWqeAPBB6beIV8rpOGdHdAozffvF3y9K
         Ig8WZJYMpjy+i+Qt8Japcmsf0mX+5+ZZnb0q0weHLtLiDhXgrHmOrpUbc5Lk/luzT92m
         8qqV4rWLcm30vYSUHDA6emhhBGa/ck163n4RmNLpXETr9Vv5mmTiWYoSFXgR1jjg5cQA
         Q46l4CL6idErl3q4konIb4ku1Y9fzQdi92I616TOuazuIpFWn54RJ7/BHnaUr7iAIQMx
         ebjw==
X-Gm-Message-State: AJIora/7namzX//0jWrvfZ5hLn4VHjbizy9YHJc4Hh1mSQ4wZG9XOT6W
        /XBLerb1UyWHfqo7pHPkPuWFcIEMzOsSChrlwwYayg==
X-Google-Smtp-Source: AGRyM1tv3KSsz5ahO9QSNKUaP+zHm1S9VUrQk+2wU0G8MwJX6IyVGW9tMIR1SJntatob6T+oQmj+K+WMhmqXRaM0Kvg=
X-Received: by 2002:a05:6000:1542:b0:21d:28c0:eb43 with SMTP id
 2-20020a056000154200b0021d28c0eb43mr29830169wry.622.1656986674601; Mon, 04
 Jul 2022 19:04:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220704135833.1496303-1-martin.fernandez@eclypsium.com> <20220704135833.1496303-8-martin.fernandez@eclypsium.com>
In-Reply-To: <20220704135833.1496303-8-martin.fernandez@eclypsium.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 5 Jul 2022 10:04:23 +0800
Message-ID: <CABVgOS=V+-AN65mZRnzZo8LqDZgEPXrwGPXTSsPUsnBvzi7+WA@mail.gmail.com>
Subject: Re: [PATCH v9 7/9] x86/e820: Add unit tests for e820_range_* functions
To:     Martin Fernandez <martin.fernandez@eclypsium.com>
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
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000028d5af05e3054682"
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

--00000000000028d5af05e3054682
Content-Type: text/plain; charset="UTF-8"

On Mon, Jul 4, 2022 at 9:59 PM 'Martin Fernandez' via KUnit
Development <kunit-dev@googlegroups.com> wrote:
>
> Add KUnit tests for the e820_range_* functions.
>
> Signed-off-by: Martin Fernandez <martin.fernandez@eclypsium.com>
> ---

This looks good to me from a KUnit point of view. I've tested it on
both 32- and 64- bit x86 under qemu with the following:
./tools/testing/kunit/kunit.py run --arch=i386 'e820'
./tools/testing/kunit/kunit.py run --arch=x86_64 'e820'

Two notes inline below:
- An indentation error in the Kconfig entry, which stops it from compiling.
- Some minor pontificating about how KUnit wants to name macros in
general. (No action required: just making a note that this is probably
okay.)

With the indentation issue fixed, this is:

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  arch/x86/Kconfig.debug      |  10 ++
>  arch/x86/kernel/e820.c      |   5 +
>  arch/x86/kernel/e820_test.c | 249 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 264 insertions(+)
>  create mode 100644 arch/x86/kernel/e820_test.c
>
> diff --git a/arch/x86/Kconfig.debug b/arch/x86/Kconfig.debug
> index d872a7522e55..b5040d345fb4 100644
> --- a/arch/x86/Kconfig.debug
> +++ b/arch/x86/Kconfig.debug
> @@ -225,6 +225,16 @@ config PUNIT_ATOM_DEBUG
>           The current power state can be read from
>           /sys/kernel/debug/punit_atom/dev_power_state
>
> +config E820_KUNIT_TEST
> +       tristate "Tests for E820" if !KUNIT_ALL_TESTS
> +       depends on KUNIT=y
> +       default KUNIT_ALL_TESTS
> +       help
> +         This option enables unit tests for the e820.c code. It
> +         should be enabled only in development environments.
> +
> +         If unsure, say N.

The indentation here seems to be one space off, leading to errors building it:

arch/x86/Kconfig.debug:236: syntax error
arch/x86/Kconfig.debug:235:warning: ignoring unsupported character ','
arch/x86/Kconfig.debug:235:warning: ignoring unsupported character '.'
arch/x86/Kconfig.debug:235: unknown statement "If"
make[2]: *** [../scripts/kconfig/Makefile:77: olddefconfig] Error 1


> +
>  choice
>         prompt "Choose kernel unwinder"
>         default UNWINDER_ORC if X86_64
> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
> index dade59758b9f..a6ced3e306dd 100644
> --- a/arch/x86/kernel/e820.c
> +++ b/arch/x86/kernel/e820.c
> @@ -1546,3 +1546,8 @@ void __init e820__memblock_setup(void)
>
>         memblock_dump_all();
>  }
> +
> +#ifdef CONFIG_E820_KUNIT_TEST
> +/* Let e820_test have access the static functions in this file */
> +#include "e820_test.c"
> +#endif
> diff --git a/arch/x86/kernel/e820_test.c b/arch/x86/kernel/e820_test.c
> new file mode 100644
> index 000000000000..6b28ea131380
> --- /dev/null
> +++ b/arch/x86/kernel/e820_test.c
> @@ -0,0 +1,249 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <kunit/test.h>
> +
> +#include <asm/e820/api.h>
> +#include <asm/setup.h>
> +
> +#define KUNIT_EXPECT_E820_ENTRY_EQ(_test, _entry, _addr, _size, _type,         \
> +                                  _crypto_capable)                            \
> +       do {                                                                   \
> +               KUNIT_EXPECT_EQ((_test), (_entry).addr, (_addr));              \
> +               KUNIT_EXPECT_EQ((_test), (_entry).size, (_size));              \
> +               KUNIT_EXPECT_EQ((_test), (_entry).type, (_type));              \
> +               KUNIT_EXPECT_EQ((_test), (_entry).crypto_capable,              \
> +                               (_crypto_capable));                            \
> +       } while (0)
> +

I'm not 100% sure we ever came to a decision about tests naming their
own expect macros KUNIT_EXPECT_*. I know KASAN is doing it, though the
thought there was that other tests might have sensible reasons to
expect given memory accesses, so it might not be limited to the one
test.

Personally, I don't mind it, particularly since it's obvious that this
is specific to the e820 test.

> +struct e820_table test_table __initdata;
> +
> +static void __init test_e820_range_add(struct kunit *test)
> +{
> +       u32 full = ARRAY_SIZE(test_table.entries);
> +       /* Add last entry. */
> +       test_table.nr_entries = full - 1;
> +       __e820__range_add(&test_table, 0, 15, 0, 0);
> +       KUNIT_EXPECT_EQ(test, test_table.nr_entries, full);
> +       /* Skip new entry when full. */
> +       __e820__range_add(&test_table, 0, 15, 0, 0);
> +       KUNIT_EXPECT_EQ(test, test_table.nr_entries, full);
> +}
> +
> +static void __init test_e820_range_update(struct kunit *test)
> +{
> +       u64 entry_size = 15;
> +       u64 updated_size = 0;
> +       /* Initialize table */
> +       test_table.nr_entries = 0;
> +       __e820__range_add(&test_table, 0, entry_size, E820_TYPE_RAM,
> +                         E820_NOT_CRYPTO_CAPABLE);
> +       __e820__range_add(&test_table, entry_size, entry_size, E820_TYPE_RAM,
> +                         E820_NOT_CRYPTO_CAPABLE);
> +       __e820__range_add(&test_table, entry_size * 2, entry_size,
> +                         E820_TYPE_ACPI, E820_NOT_CRYPTO_CAPABLE);
> +
> +       updated_size = __e820__range_update(&test_table, 0, entry_size * 2,
> +                                           E820_TYPE_RAM, E820_TYPE_RESERVED);
> +
> +       /* The first 2 regions were updated */
> +       KUNIT_EXPECT_EQ(test, updated_size, entry_size * 2);
> +       KUNIT_EXPECT_E820_ENTRY_EQ(test, test_table.entries[0], 0, entry_size,
> +                                  E820_TYPE_RESERVED, E820_NOT_CRYPTO_CAPABLE);
> +       KUNIT_EXPECT_E820_ENTRY_EQ(test, test_table.entries[1], entry_size,
> +                                  entry_size, E820_TYPE_RESERVED,
> +                                  E820_NOT_CRYPTO_CAPABLE);
> +       KUNIT_EXPECT_E820_ENTRY_EQ(test, test_table.entries[2], entry_size * 2,
> +                                  entry_size, E820_TYPE_ACPI,
> +                                  E820_NOT_CRYPTO_CAPABLE);
> +
> +       updated_size = __e820__range_update(&test_table, 0, entry_size * 3,
> +                                           E820_TYPE_RESERVED, E820_TYPE_RAM);
> +
> +       /*
> +        * Only the first 2 regions were updated,
> +        * since E820_TYPE_ACPI > E820_TYPE_RESERVED
> +        */
> +       KUNIT_EXPECT_EQ(test, updated_size, entry_size * 2);
> +       KUNIT_EXPECT_E820_ENTRY_EQ(test, test_table.entries[0], 0, entry_size,
> +                                  E820_TYPE_RAM, E820_NOT_CRYPTO_CAPABLE);
> +       KUNIT_EXPECT_E820_ENTRY_EQ(test, test_table.entries[1], entry_size,
> +                                  entry_size, E820_TYPE_RAM,
> +                                  E820_NOT_CRYPTO_CAPABLE);
> +       KUNIT_EXPECT_E820_ENTRY_EQ(test, test_table.entries[2], entry_size * 2,
> +                                  entry_size, E820_TYPE_ACPI,
> +                                  E820_NOT_CRYPTO_CAPABLE);
> +}
> +
> +static void __init test_e820_range_remove(struct kunit *test)
> +{
> +       u64 entry_size = 15;
> +       u64 removed_size = 0;
> +
> +       struct e820_entry_updater updater = { .should_update =
> +                                                     remover__should_update,
> +                                             .update = remover__update,
> +                                             .new = NULL };
> +
> +       struct e820_remover_data data = { .check_type = true,
> +                                         .old_type = E820_TYPE_RAM };
> +
> +       /* Initialize table */
> +       test_table.nr_entries = 0;
> +       __e820__range_add(&test_table, 0, entry_size, E820_TYPE_RAM,
> +                         E820_NOT_CRYPTO_CAPABLE);
> +       __e820__range_add(&test_table, entry_size, entry_size, E820_TYPE_RAM,
> +                         E820_NOT_CRYPTO_CAPABLE);
> +       __e820__range_add(&test_table, entry_size * 2, entry_size,
> +                         E820_TYPE_ACPI, E820_NOT_CRYPTO_CAPABLE);
> +
> +       /*
> +        * Need to use __e820__handle_range_update because
> +        * e820__range_remove doesn't ask for the table
> +        */
> +       removed_size = __e820__handle_range_update(&test_table,
> +                                                  0, entry_size * 2,
> +                                                  &updater, &data);
> +
> +       /* The first two regions were removed */
> +       KUNIT_EXPECT_EQ(test, removed_size, entry_size * 2);
> +       KUNIT_EXPECT_E820_ENTRY_EQ(test, test_table.entries[0], 0, 0, 0, 0);
> +       KUNIT_EXPECT_E820_ENTRY_EQ(test, test_table.entries[1], 0, 0, 0, 0);
> +
> +       removed_size = __e820__handle_range_update(&test_table,
> +                                                  0, entry_size * 3,
> +                                                  &updater, &data);
> +
> +       /* Nothing was removed, since nothing matched the target type */
> +       KUNIT_EXPECT_EQ(test, removed_size, 0);
> +       KUNIT_EXPECT_E820_ENTRY_EQ(test, test_table.entries[0], 0, 0, 0, 0);
> +       KUNIT_EXPECT_E820_ENTRY_EQ(test, test_table.entries[1], 0, 0, 0, 0);
> +       KUNIT_EXPECT_E820_ENTRY_EQ(test, test_table.entries[2], entry_size * 2,
> +                                  entry_size, E820_TYPE_ACPI,
> +                                  E820_NOT_CRYPTO_CAPABLE);
> +}
> +
> +static void __init test_e820_range_crypto_update(struct kunit *test)
> +{
> +       u64 entry_size = 15;
> +       u64 updated_size = 0;
> +       /* Initialize table */
> +       test_table.nr_entries = 0;
> +       __e820__range_add(&test_table, 0, entry_size, E820_TYPE_RAM,
> +                         E820_CRYPTO_CAPABLE);
> +       __e820__range_add(&test_table, entry_size, entry_size, E820_TYPE_RAM,
> +                         E820_NOT_CRYPTO_CAPABLE);
> +       __e820__range_add(&test_table, entry_size * 2, entry_size,
> +                         E820_TYPE_RAM, E820_CRYPTO_CAPABLE);
> +
> +       updated_size = __e820__range_update_crypto(&test_table,
> +                                                  0, entry_size * 3,
> +                                                  E820_CRYPTO_CAPABLE);
> +
> +       /* Only the region in the middle was updated */
> +       KUNIT_EXPECT_EQ(test, updated_size, entry_size);
> +       KUNIT_EXPECT_E820_ENTRY_EQ(test, test_table.entries[0], 0, entry_size,
> +                                  E820_TYPE_RAM, E820_CRYPTO_CAPABLE);
> +       KUNIT_EXPECT_E820_ENTRY_EQ(test, test_table.entries[1], entry_size,
> +                                  entry_size, E820_TYPE_RAM,
> +                                  E820_CRYPTO_CAPABLE);
> +       KUNIT_EXPECT_E820_ENTRY_EQ(test, test_table.entries[2], entry_size * 2,
> +                                  entry_size, E820_TYPE_RAM,
> +                                  E820_CRYPTO_CAPABLE);
> +}
> +
> +static void __init test_e820_handle_range_update_intersection(struct kunit *test)
> +{
> +       struct e820_entry_updater updater = {
> +               .should_update = type_updater__should_update,
> +               .update = type_updater__update,
> +               .new = type_updater__new
> +       };
> +
> +       struct e820_type_updater_data data = { .old_type = E820_TYPE_RAM,
> +                                              .new_type = E820_TYPE_RESERVED };
> +
> +       u64 entry_size = 15;
> +       u64 intersection_size = 2;
> +       u64 updated_size = 0;
> +       /* Initialize table */
> +       test_table.nr_entries = 0;
> +       __e820__range_add(&test_table, 0, entry_size, E820_TYPE_RAM,
> +                         E820_NOT_CRYPTO_CAPABLE);
> +
> +       updated_size =
> +               __e820__handle_range_update(&test_table, 0,
> +                                           entry_size - intersection_size,
> +                                           &updater, &data);
> +
> +       KUNIT_EXPECT_EQ(test, updated_size, entry_size - intersection_size);
> +
> +       /* There is a new entry */
> +       KUNIT_EXPECT_EQ(test, test_table.nr_entries, intersection_size);
> +
> +       /* The original entry now is moved */
> +       KUNIT_EXPECT_E820_ENTRY_EQ(test, test_table.entries[0],
> +                                  entry_size - intersection_size,
> +                                  intersection_size, E820_TYPE_RAM,
> +                                  E820_NOT_CRYPTO_CAPABLE);
> +
> +       /* The new entry has the correct values */
> +       KUNIT_EXPECT_E820_ENTRY_EQ(test, test_table.entries[1], 0,
> +                                  entry_size - intersection_size,
> +                                  E820_TYPE_RESERVED, E820_NOT_CRYPTO_CAPABLE);
> +}
> +
> +static void __init test_e820_handle_range_update_inside(struct kunit *test)
> +{
> +       struct e820_entry_updater updater = {
> +               .should_update = type_updater__should_update,
> +               .update = type_updater__update,
> +               .new = type_updater__new
> +       };
> +
> +       struct e820_type_updater_data data = { .old_type = E820_TYPE_RAM,
> +                                              .new_type = E820_TYPE_RESERVED };
> +
> +       u64 entry_size = 15;
> +       u64 updated_size = 0;
> +       /* Initialize table */
> +       test_table.nr_entries = 0;
> +       __e820__range_add(&test_table, 0, entry_size, E820_TYPE_RAM,
> +                         E820_NOT_CRYPTO_CAPABLE);
> +
> +       updated_size = __e820__handle_range_update(&test_table, 5,
> +                                                  entry_size - 10,
> +                                                  &updater, &data);
> +
> +       KUNIT_EXPECT_EQ(test, updated_size, entry_size - 10);
> +
> +       /* There are two new entrie */
> +       KUNIT_EXPECT_EQ(test, test_table.nr_entries, 3);
> +
> +       /* The original entry now shrunk */
> +       KUNIT_EXPECT_E820_ENTRY_EQ(test, test_table.entries[0], 0, 5,
> +                                  E820_TYPE_RAM, E820_NOT_CRYPTO_CAPABLE);
> +
> +       /* The new entries have the correct values */
> +       KUNIT_EXPECT_E820_ENTRY_EQ(test, test_table.entries[1], 5,
> +                                  entry_size - 10, E820_TYPE_RESERVED,
> +                                  E820_NOT_CRYPTO_CAPABLE);
> +       /* Left over of the original region */
> +       KUNIT_EXPECT_E820_ENTRY_EQ(test, test_table.entries[2], entry_size - 5,
> +                                  5, E820_TYPE_RAM, E820_NOT_CRYPTO_CAPABLE);
> +}
> +
> +static struct kunit_case e820_test_cases[] __initdata = {
> +       KUNIT_CASE(test_e820_range_add),
> +       KUNIT_CASE(test_e820_range_update),
> +       KUNIT_CASE(test_e820_range_remove),
> +       KUNIT_CASE(test_e820_range_crypto_update),
> +       KUNIT_CASE(test_e820_handle_range_update_intersection),
> +       KUNIT_CASE(test_e820_handle_range_update_inside),
> +       {}
> +};
> +
> +static struct kunit_suite e820_test_suite __initdata = {
> +       .name = "e820",
> +       .test_cases = e820_test_cases,
> +};
> +
> +kunit_test_init_section_suite(e820_test_suite);
> --
> 2.30.2
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20220704135833.1496303-8-martin.fernandez%40eclypsium.com.

--00000000000028d5af05e3054682
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPnwYJKoZIhvcNAQcCoIIPkDCCD4wCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz5MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
z/tQRXr3iPeVmZCr7nttMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQAx+EQjLATc/sze
VoZkH7OLz+/no1+y31x4BQ3wjW7lKfay9DAAVym896b7ECttSo95GEvS7pYMikzud57WypK7Bjpi
ep8YLarLRDrvyyvBuYtyDrIewkuASHtV1oy5E6QZZe2VOxMm6e2oJnFFjbflot4A08D3SwqDwV0i
OOYwT0BUtHYR/3903Dmdx5Alq+NDvUHDjozgo0f6oIkwDXT3yBV36utQ/jFisd36C8RD5mM+NFpu
3aqLXARRbKtxw29ErCwulof2dcAonG7cd5j+gmS84sLhKU+BhL1OQVXnJ5tj7xZ5Ri5I23brcwk0
lk/gWqfgs3ppT9Xk7zVit9q8MYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABh9LgIPnlfMFHR0Die8n7MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAZ
X5kOv2Qz9LPT8qJdfY60Cwqrwy3MLKpLhOYnv4xLxDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjA3MDUwMjA0MzRaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAEjh5wJ7Hsrw6ShbSFVWL
OvwZC1amhC1+Ot1F7F4e1oIeeIAONwnSU/T8LFsWKDXK1TIoF34qGIDkHAyMNbvbS7NI9K35ciQC
V0CL4A2ijhsClwsvy3irUI+xOngjH5JAji9IcEFOHvecmqh+qmfzKZbHFxFvpdaQrsGnNF0LzV+4
zl6m5kNYX4Hfamrnjjlw+JTj4G6VqSxVH82bJvkqw/4rBtQfV/mCwdX03RieS2Bhr1VwWlEp0SSX
RBzz3vuPuPzYKrtwtNrVlIOFUtyRu1ptO84q3SojqlZ8/OMproGLJWpD8ZQX1JWBsnNOygn2GLh5
PESvtZPVMRMLdUX4Vw==
--00000000000028d5af05e3054682--
