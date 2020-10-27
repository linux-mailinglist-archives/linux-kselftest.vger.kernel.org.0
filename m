Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D911129C248
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Oct 2020 18:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1820265AbgJ0ReQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Oct 2020 13:34:16 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33031 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1820256AbgJ0ReN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Oct 2020 13:34:13 -0400
Received: by mail-qt1-f193.google.com with SMTP id j62so1620876qtd.0
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Oct 2020 10:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DJdrHkP5GhFWBxOBTxYJLlq85LF0Y8rsT83lHf4BoXA=;
        b=rElie7nCB2CSbeT6c/CaRa3JHjFQyZbh0vMF7smW6sS0e7lP2rguaapbfqKZlnXJMt
         H/al2Ps4yGge5TkCv7RwrkHawwOXy7AJkP6a/iHLDnTJvdGRLGrXBrr8QHt4+yioaM7L
         jm5b8mvRFwige6iwO7e8ADEX+VDoGG6tk9ObciKNvJ/nDOLSqFj9Bih4li5/oehtBTtQ
         HTj5kT4vsEwtH4CacmE/gNkfyvQUZep5AoMjgt2VbxMKwj/AeKBpLHynlUJJOdSdLoKM
         ZHyiJ1lH32gzTeEwyueSWFnkIQ8aVPKVnxVB0hEwI3ylp/eOUfkYi538tWiNR0Gj79Ui
         cp8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DJdrHkP5GhFWBxOBTxYJLlq85LF0Y8rsT83lHf4BoXA=;
        b=T/svJZiSEStsi/5wL85Zrl9b2L9xRs/cQgbiegDPWx7zLpQczz/HOZAk9dXgC3fCHM
         w4s19gLeSmikDwGtDgY1UUDZgUU5wdPDfQSHediS9lwKD6+KGu8CGZ6h8wyNh/3IhSK1
         deCOIqy2S5+t0ylp4KikCibMdjFd4Ufb7HNgsDiy4KcBADlj/IMq7mgNfPMxVaczW84C
         ZUM4uRkDq6Z/+5Y3UsvzPBu3UoObUsGq+1QQS9tsVQkHc40LphkYI/yRQCcfiZSPuZfF
         cO9MDRwsrp3BIUEBbrEdjdXzX3oGJOQOlm5wZ6WQ8wr+yamwGNxotfWBg/Fu5edXOzng
         lFDg==
X-Gm-Message-State: AOAM5305xgu+VzMmCVrvg3lFcJQKTBV+IrlYDtBJlyDE3C0EZCK1BvCQ
        sj4Wc+s+Ae+wTUsdv+nAdFUYBTtT9sd2f657uCzq
X-Google-Smtp-Source: ABdhPJz/W/bHvKVWc1klsC77yaMfEuw1Y1K6JU//5irH2wtAr3GVuUgYh1g/Klv2dAUfqxNmvqxd3qxjKjau5y/TcQQ=
X-Received: by 2002:ac8:4e49:: with SMTP id e9mr3216124qtw.114.1603820051180;
 Tue, 27 Oct 2020 10:34:11 -0700 (PDT)
MIME-Version: 1.0
References: <20201026183523.82749-1-98.arpi@gmail.com> <20201026183639.82883-1-98.arpi@gmail.com>
In-Reply-To: <20201026183639.82883-1-98.arpi@gmail.com>
From:   Iurii Zaikin <yzaikin@google.com>
Date:   Tue, 27 Oct 2020 10:33:34 -0700
Message-ID: <CAAXuY3o9Xe-atK0Mja6qXLncUhmmVf4pR7hsANsqaoUX71RXVg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] fs: ext4: Modify inode-test.c to use KUnit
 parameterized testing feature
To:     Arpitha Raghunandan <98.arpi@gmail.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Marco Elver <elver@google.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

>
> Modify fs/ext4/inode-test.c to use the parameterized testing
> feature of KUnit.
>
> Signed-off-by: Arpitha Raghunandan <98.arpi@gmail.com>
> ---
> Changes v2->v3:
> - Marked hardcoded test data const
> - Modification based on latest implementation of KUnit parameterized testing
> Changes v1->v2:
> - Modification based on latest implementation of KUnit parameterized testing
>
>  fs/ext4/inode-test.c | 314 ++++++++++++++++++++++---------------------
>  1 file changed, 158 insertions(+), 156 deletions(-)
>
> diff --git a/fs/ext4/inode-test.c b/fs/ext4/inode-test.c
> index d62d802c9c12..3a449623b775 100644
> --- a/fs/ext4/inode-test.c
> +++ b/fs/ext4/inode-test.c
> @@ -80,6 +80,139 @@ struct timestamp_expectation {
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
> +KUNIT_PARAM_GENERATOR(ext4_inode, test_data);
> +
>  static time64_t get_32bit_time(const struct timestamp_expectation * const test)
>  {
>         if (test->msb_set) {
> @@ -101,166 +234,35 @@ static time64_t get_32bit_time(const struct timestamp_expectation * const test)
>   */
>  static void inode_test_xtimestamp_decoding(struct kunit *test)
>  {
> -       const struct timestamp_expectation test_data[] = {
> -               {
> -                       .test_case_name = LOWER_BOUND_NEG_NO_EXTRA_BITS_CASE,
> -                       .msb_set = true,
> -                       .lower_bound = true,
> -                       .extra_bits = 0,
> -                       .expected = {.tv_sec = -0x80000000LL, .tv_nsec = 0L},
> -               },
> -
> -               {
> -                       .test_case_name = UPPER_BOUND_NEG_NO_EXTRA_BITS_CASE,
> -                       .msb_set = true,
> -                       .lower_bound = false,
> -                       .extra_bits = 0,
> -                       .expected = {.tv_sec = -1LL, .tv_nsec = 0L},
> -               },
> -
> -               {
> -                       .test_case_name = LOWER_BOUND_NONNEG_NO_EXTRA_BITS_CASE,
> -                       .msb_set = false,
> -                       .lower_bound = true,
> -                       .extra_bits = 0,
> -                       .expected = {0LL, 0L},
> -               },
> -
> -               {
> -                       .test_case_name = UPPER_BOUND_NONNEG_NO_EXTRA_BITS_CASE,
> -                       .msb_set = false,
> -                       .lower_bound = false,
> -                       .extra_bits = 0,
> -                       .expected = {.tv_sec = 0x7fffffffLL, .tv_nsec = 0L},
> -               },
> -
> -               {
> -                       .test_case_name = LOWER_BOUND_NEG_LO_1_CASE,
> -                       .msb_set = true,
> -                       .lower_bound = true,
> -                       .extra_bits = 1,
> -                       .expected = {.tv_sec = 0x80000000LL, .tv_nsec = 0L},
> -               },
> -
> -               {
> -                       .test_case_name = UPPER_BOUND_NEG_LO_1_CASE,
> -                       .msb_set = true,
> -                       .lower_bound = false,
> -                       .extra_bits = 1,
> -                       .expected = {.tv_sec = 0xffffffffLL, .tv_nsec = 0L},
> -               },
> -
> -               {
> -                       .test_case_name = LOWER_BOUND_NONNEG_LO_1_CASE,
> -                       .msb_set = false,
> -                       .lower_bound = true,
> -                       .extra_bits = 1,
> -                       .expected = {.tv_sec = 0x100000000LL, .tv_nsec = 0L},
> -               },
> -
> -               {
> -                       .test_case_name = UPPER_BOUND_NONNEG_LO_1_CASE,
> -                       .msb_set = false,
> -                       .lower_bound = false,
> -                       .extra_bits = 1,
> -                       .expected = {.tv_sec = 0x17fffffffLL, .tv_nsec = 0L},
> -               },
> -
> -               {
> -                       .test_case_name = LOWER_BOUND_NEG_HI_1_CASE,
> -                       .msb_set = true,
> -                       .lower_bound = true,
> -                       .extra_bits =  2,
> -                       .expected = {.tv_sec = 0x180000000LL, .tv_nsec = 0L},
> -               },
> -
> -               {
> -                       .test_case_name = UPPER_BOUND_NEG_HI_1_CASE,
> -                       .msb_set = true,
> -                       .lower_bound = false,
> -                       .extra_bits = 2,
> -                       .expected = {.tv_sec = 0x1ffffffffLL, .tv_nsec = 0L},
> -               },
> -
> -               {
> -                       .test_case_name = LOWER_BOUND_NONNEG_HI_1_CASE,
> -                       .msb_set = false,
> -                       .lower_bound = true,
> -                       .extra_bits = 2,
> -                       .expected = {.tv_sec = 0x200000000LL, .tv_nsec = 0L},
> -               },
> -
> -               {
> -                       .test_case_name = UPPER_BOUND_NONNEG_HI_1_CASE,
> -                       .msb_set = false,
> -                       .lower_bound = false,
> -                       .extra_bits = 2,
> -                       .expected = {.tv_sec = 0x27fffffffLL, .tv_nsec = 0L},
> -               },
> -
> -               {
> -                       .test_case_name = UPPER_BOUND_NONNEG_HI_1_NS_1_CASE,
> -                       .msb_set = false,
> -                       .lower_bound = false,
> -                       .extra_bits = 6,
> -                       .expected = {.tv_sec = 0x27fffffffLL, .tv_nsec = 1L},
> -               },
> -
> -               {
> -                       .test_case_name = LOWER_BOUND_NONNEG_HI_1_NS_MAX_CASE,
> -                       .msb_set = false,
> -                       .lower_bound = true,
> -                       .extra_bits = 0xFFFFFFFF,
> -                       .expected = {.tv_sec = 0x300000000LL,
> -                                    .tv_nsec = MAX_NANOSECONDS},
> -               },
> -
> -               {
> -                       .test_case_name = LOWER_BOUND_NONNEG_EXTRA_BITS_1_CASE,
> -                       .msb_set = false,
> -                       .lower_bound = true,
> -                       .extra_bits = 3,
> -                       .expected = {.tv_sec = 0x300000000LL, .tv_nsec = 0L},
> -               },
> -
> -               {
> -                       .test_case_name = UPPER_BOUND_NONNEG_EXTRA_BITS_1_CASE,
> -                       .msb_set = false,
> -                       .lower_bound = false,
> -                       .extra_bits = 3,
> -                       .expected = {.tv_sec = 0x37fffffffLL, .tv_nsec = 0L},
> -               }
> -       };
> -
>         struct timespec64 timestamp;
> -       int i;
> -
> -       for (i = 0; i < ARRAY_SIZE(test_data); ++i) {
> -               timestamp.tv_sec = get_32bit_time(&test_data[i]);
> -               ext4_decode_extra_time(&timestamp,
> -                                      cpu_to_le32(test_data[i].extra_bits));
> -
> -               KUNIT_EXPECT_EQ_MSG(test,
> -                                   test_data[i].expected.tv_sec,
> -                                   timestamp.tv_sec,
> -                                   CASE_NAME_FORMAT,
> -                                   test_data[i].test_case_name,
> -                                   test_data[i].msb_set,
> -                                   test_data[i].lower_bound,
> -                                   test_data[i].extra_bits);
> -               KUNIT_EXPECT_EQ_MSG(test,
> -                                   test_data[i].expected.tv_nsec,
> -                                   timestamp.tv_nsec,
> -                                   CASE_NAME_FORMAT,
> -                                   test_data[i].test_case_name,
> -                                   test_data[i].msb_set,
> -                                   test_data[i].lower_bound,
> -                                   test_data[i].extra_bits);
> -       }
> +
> +       struct timestamp_expectation *test_param =
> +                       (struct timestamp_expectation *)(test->param_values);
> +
> +       timestamp.tv_sec = get_32bit_time(test_param);
> +       ext4_decode_extra_time(&timestamp,
> +                              cpu_to_le32(test_param->extra_bits));
> +
> +       KUNIT_EXPECT_EQ_MSG(test,
> +                           test_param->expected.tv_sec,
> +                           timestamp.tv_sec,
> +                           CASE_NAME_FORMAT,
> +                           test_param->test_case_name,
> +                           test_param->msb_set,
> +                           test_param->lower_bound,
> +                           test_param->extra_bits);
> +       KUNIT_EXPECT_EQ_MSG(test,
> +                           test_param->expected.tv_nsec,
> +                           timestamp.tv_nsec,
> +                           CASE_NAME_FORMAT,
> +                           test_param->test_case_name,
> +                           test_param->msb_set,
> +                           test_param->lower_bound,
> +                           test_param->extra_bits);
>  }
>
>  static struct kunit_case ext4_inode_test_cases[] = {
> -       KUNIT_CASE(inode_test_xtimestamp_decoding),
> +       KUNIT_CASE_PARAM(inode_test_xtimestamp_decoding, ext4_inode_gen_params),
>         {}
>  };
>
> --
> 2.25.1
>

Reviewed-by: Iurii Zaikin <yzaikin@google.com>
