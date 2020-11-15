Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D76D32B38D0
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Nov 2020 20:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbgKOTpJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 15 Nov 2020 14:45:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727582AbgKOTpJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 15 Nov 2020 14:45:09 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F418C0613D2
        for <linux-kselftest@vger.kernel.org>; Sun, 15 Nov 2020 11:45:09 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id 79so13902515otc.7
        for <linux-kselftest@vger.kernel.org>; Sun, 15 Nov 2020 11:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6zNjOkpCVoYdq5SpvfJCUuoFxEeE/HXUKkYfS/pJSPQ=;
        b=YGqgAsRPCcFEYGbkYFYFYF7c6IZTiUtw/7UtjsOW/6+vpk09z2RB5iBAvx2tDpeqPa
         x1axtuQ84E7Rco2Vg3VjKEvRBLHgd2h7kgIZwNvC2RC4tHeu3k5fizrI0IJLpuo+Bxui
         fR5kt64PckZC5KfiM7rDnIZFmXzDayvC4kRPWWYRkxWBOvcr9hoMPyQqxVl9yTkb5itJ
         V3cHUvlgbtSHHPGKhKjcXMGZ/jFAyJricyZAkGCS2EH7klMhEXQ4RImb+cxj0pejdAGc
         tO5imJcxIlNH4iw47ArLS/Z2NReC5lg45qAR7Yu6+WV5YWxBGzy/LbgfoHLMY5FsZ/FX
         EgtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6zNjOkpCVoYdq5SpvfJCUuoFxEeE/HXUKkYfS/pJSPQ=;
        b=FdZqBlO2TgUtyhMPthFpSB6a9V6FXWpviTB2Nz1Rdktb4Ot/b99CSHcSKMvEKC/V5Q
         ZSViwieDRhHwWpjpfAMHRpDmWuT9elEVdrGbBFpT0rc6xtYBBVIYAZHcxzXg9pmVg+ys
         6931B5fpmEoNFFaR2j1A9zQLNAafhl6Hs25+KutgNmeP1gPRMzgiaiyh5hfJTRHJZm29
         lRfEnDgiRN6vlEBQ55ytQSL4Yl22/7XUoMB94p+RceqL1E9gEYsG0VeULnavnuGV3msu
         O02zegK4vEGtMPwEUId3PbSax08I2X+/eqxtEnH2p4vE+blh4CARI0hHMnoZrffDTH6d
         OJKA==
X-Gm-Message-State: AOAM531lO8Npl+/N2PZFe/FIHcZHf4rd/hEHZXE67kBdK3sFl8k1ruIj
        il8CVGwYUaimBcnZaoqm8Vap8EwaZVBy1CLsJfHE1w==
X-Google-Smtp-Source: ABdhPJz6faio6eUJA+ICMoEJv/bY0IEMAmFaezB9H58f8aYdotirk71yWz/OqihHIepXw9oidy4ryfi7C2l9l0H9eBA=
X-Received: by 2002:a9d:69:: with SMTP id 96mr4599418ota.233.1605469508232;
 Sun, 15 Nov 2020 11:45:08 -0800 (PST)
MIME-Version: 1.0
References: <20201115185759.169279-1-98.arpi@gmail.com> <20201115185905.169349-1-98.arpi@gmail.com>
In-Reply-To: <20201115185905.169349-1-98.arpi@gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Sun, 15 Nov 2020 20:44:56 +0100
Message-ID: <CANpmjNPKfPeiXUUPwz1aU6iKwOXpSZNV5ZJq22NkZZWEhE9r1w@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] fs: ext4: Modify inode-test.c to use KUnit
 parameterized testing feature
To:     Arpitha Raghunandan <98.arpi@gmail.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Iurii Zaikin <yzaikin@google.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Tim Bird <Tim.Bird@sony.com>, David Gow <davidgow@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, 15 Nov 2020 at 19:59, Arpitha Raghunandan <98.arpi@gmail.com> wrote:
>
> Modify fs/ext4/inode-test.c to use the parameterized testing
> feature of KUnit.
>
> Signed-off-by: Arpitha Raghunandan <98.arpi@gmail.com>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
> Changes v7->v8:
> - Replace strcpy() with strncpy() in timestamp_expectation_to_desc()
> Changes v6->v7:
> - Introduce timestamp_expectation_to_desc() to convert param to
>   description.
> Changes v5->v6:
> - No change to this patch of the patch series
> Changes v4->v5:
> - No change to this patch of the patch series
> Changes v3->v4:
> - Modification based on latest implementation of KUnit parameterized testing
> Changes v2->v3:
> - Marked hardcoded test data const
> - Modification based on latest implementation of KUnit parameterized testing
> Changes v1->v2:
> - Modification based on latest implementation of KUnit parameterized testing
>
>  fs/ext4/inode-test.c | 323 ++++++++++++++++++++++---------------------
>  1 file changed, 167 insertions(+), 156 deletions(-)
>
> diff --git a/fs/ext4/inode-test.c b/fs/ext4/inode-test.c
> index d62d802c9c12..2c0c00c45c6b 100644
> --- a/fs/ext4/inode-test.c
> +++ b/fs/ext4/inode-test.c
> @@ -80,6 +80,148 @@ struct timestamp_expectation {
>         bool lower_bound;
>  };
>
> +static const struct timestamp_expectation test_data[] = {
> +       {
> +               .test_case_name = LOWER_BOUND_NEG_NO_EXTRA_BITS_CASE,
> +               .msb_set = true,
> +               .lower_bound = true,
> +               .extra_bits = 0,
> +               .expected = {.tv_sec = -0x80000000LL, .tv_nsec = 0L},
> +       },
> +
> +       {
> +               .test_case_name = UPPER_BOUND_NEG_NO_EXTRA_BITS_CASE,
> +               .msb_set = true,
> +               .lower_bound = false,
> +               .extra_bits = 0,
> +               .expected = {.tv_sec = -1LL, .tv_nsec = 0L},
> +       },
> +
> +       {
> +               .test_case_name = LOWER_BOUND_NONNEG_NO_EXTRA_BITS_CASE,
> +               .msb_set = false,
> +               .lower_bound = true,
> +               .extra_bits = 0,
> +               .expected = {0LL, 0L},
> +       },
> +
> +       {
> +               .test_case_name = UPPER_BOUND_NONNEG_NO_EXTRA_BITS_CASE,
> +               .msb_set = false,
> +               .lower_bound = false,
> +               .extra_bits = 0,
> +               .expected = {.tv_sec = 0x7fffffffLL, .tv_nsec = 0L},
> +       },
> +
> +       {
> +               .test_case_name = LOWER_BOUND_NEG_LO_1_CASE,
> +               .msb_set = true,
> +               .lower_bound = true,
> +               .extra_bits = 1,
> +               .expected = {.tv_sec = 0x80000000LL, .tv_nsec = 0L},
> +       },
> +
> +       {
> +               .test_case_name = UPPER_BOUND_NEG_LO_1_CASE,
> +               .msb_set = true,
> +               .lower_bound = false,
> +               .extra_bits = 1,
> +               .expected = {.tv_sec = 0xffffffffLL, .tv_nsec = 0L},
> +       },
> +
> +       {
> +               .test_case_name = LOWER_BOUND_NONNEG_LO_1_CASE,
> +               .msb_set = false,
> +               .lower_bound = true,
> +               .extra_bits = 1,
> +               .expected = {.tv_sec = 0x100000000LL, .tv_nsec = 0L},
> +       },
> +
> +       {
> +               .test_case_name = UPPER_BOUND_NONNEG_LO_1_CASE,
> +               .msb_set = false,
> +               .lower_bound = false,
> +               .extra_bits = 1,
> +               .expected = {.tv_sec = 0x17fffffffLL, .tv_nsec = 0L},
> +       },
> +
> +       {
> +               .test_case_name = LOWER_BOUND_NEG_HI_1_CASE,
> +               .msb_set = true,
> +               .lower_bound = true,
> +               .extra_bits =  2,
> +               .expected = {.tv_sec = 0x180000000LL, .tv_nsec = 0L},
> +       },
> +
> +       {
> +               .test_case_name = UPPER_BOUND_NEG_HI_1_CASE,
> +               .msb_set = true,
> +               .lower_bound = false,
> +               .extra_bits = 2,
> +               .expected = {.tv_sec = 0x1ffffffffLL, .tv_nsec = 0L},
> +       },
> +
> +       {
> +               .test_case_name = LOWER_BOUND_NONNEG_HI_1_CASE,
> +               .msb_set = false,
> +               .lower_bound = true,
> +               .extra_bits = 2,
> +               .expected = {.tv_sec = 0x200000000LL, .tv_nsec = 0L},
> +       },
> +
> +       {
> +               .test_case_name = UPPER_BOUND_NONNEG_HI_1_CASE,
> +               .msb_set = false,
> +               .lower_bound = false,
> +               .extra_bits = 2,
> +               .expected = {.tv_sec = 0x27fffffffLL, .tv_nsec = 0L},
> +       },
> +
> +       {
> +               .test_case_name = UPPER_BOUND_NONNEG_HI_1_NS_1_CASE,
> +               .msb_set = false,
> +               .lower_bound = false,
> +               .extra_bits = 6,
> +               .expected = {.tv_sec = 0x27fffffffLL, .tv_nsec = 1L},
> +       },
> +
> +       {
> +               .test_case_name = LOWER_BOUND_NONNEG_HI_1_NS_MAX_CASE,
> +               .msb_set = false,
> +               .lower_bound = true,
> +               .extra_bits = 0xFFFFFFFF,
> +               .expected = {.tv_sec = 0x300000000LL,
> +                            .tv_nsec = MAX_NANOSECONDS},
> +       },
> +
> +       {
> +               .test_case_name = LOWER_BOUND_NONNEG_EXTRA_BITS_1_CASE,
> +               .msb_set = false,
> +               .lower_bound = true,
> +               .extra_bits = 3,
> +               .expected = {.tv_sec = 0x300000000LL, .tv_nsec = 0L},
> +       },
> +
> +       {
> +               .test_case_name = UPPER_BOUND_NONNEG_EXTRA_BITS_1_CASE,
> +               .msb_set = false,
> +               .lower_bound = false,
> +               .extra_bits = 3,
> +               .expected = {.tv_sec = 0x37fffffffLL, .tv_nsec = 0L},
> +       }
> +};
> +
> +static void timestamp_expectation_to_desc(const struct timestamp_expectation *t,
> +                                         char *desc)
> +{
> +       int desc_length = strlen(t->test_case_name);
> +
> +       strncpy(desc, t->test_case_name, desc_length);
> +       desc[desc_length] = '\0';
> +}

This unfortunately won't prevent out-of-bounds accesses if the
description is longer than KUNIT_PARAM_DESC_SIZE.

With strncpy() we want to avoid copying more bytes than the
destination buffer can hold. This can be done by simply a
strncpy(desc, t->test_case_name, KUNIT_PARAM_DESC_SIZE). But,
strncpy() is unsafe in certain cases, too, so the kernel introduced
strscpy() -- see the note about strncpy() in
Documentation/process/deprecated.rst. Also have a look at the
documentation about str{n,l,s}cpy() in lib/string.c.

So, finally, what we want here is just 1 line:

    strscpy(desc, t->test_case_name, KUNIT_PARAM_DESC_SIZE);

Patch 1/2 looks fine though, so hopefully v9 will be final. :-)

Thanks,
-- Marco
