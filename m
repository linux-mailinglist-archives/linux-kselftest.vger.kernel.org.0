Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8864B2967
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Feb 2022 16:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349382AbiBKPti (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Feb 2022 10:49:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232550AbiBKPtg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Feb 2022 10:49:36 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D67F1CF
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Feb 2022 07:49:35 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id k25so23809737ejp.5
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Feb 2022 07:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jOGYj+Ddot3c2dYIVm3IUDs6tgN4/isqSj2clhmBLQM=;
        b=FP56XRMN2citj2/x3QYyAr1V07IJbXwbxDRxru5L6thDLicEt2Z0EobdWW4laUErhF
         GRn7vLXrPm6MclSh5y/cTuUZXPxwrnMjnMv+QQMgxGLGujTyhY680bcpUFh8hGAnWsde
         JQvpXJrFxSSa9coKK9ATgAHi6TlNX5Xbe+NsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jOGYj+Ddot3c2dYIVm3IUDs6tgN4/isqSj2clhmBLQM=;
        b=kbo6ALhwoY4fVubzD9qRpszbmPM1IPkya+T/sU5+IITog3b8ZhHDnFDOh+PR2ZSCsF
         GLnx2TZHZnEQ9yc2zfptTC2dJ5/ZnSFgRf7qPk0PsHBFZ+BGiMf51mLX9ekaX2wwBYlq
         Y6MY1CGdb940+XIlH7Uh2H9DBPiri0uJcWxAd4xsUs2eFX7mc9LfaUmgg9/fvZq4Jr2k
         7PJiOasbby2gQnGsZOlgWimZJjuHJ2zGUF1J06+yUGQMlsD/nj7DcaqvTEnLZKo0qdXd
         RgOuwhUSfJ+Usx/fOfGB/z3tAxDGkh2+LCpgGlpzvZ4LhtHM2WfeMet2Y9M5VwAkNOU9
         PMtw==
X-Gm-Message-State: AOAM530dg7cxbfP+lBS6W4PKzPDkUpx317Cen7mlDjC/YRjWFPRXo9nQ
        sx15mcyiDwkA9GGWfHhcostBiMYuJBCDEHAp
X-Google-Smtp-Source: ABdhPJzjTL3AspczulhCMkLfW8t6YaZrncMGMuL2CKhWYQLpAJ+qn2QMqZQBhmiBJmHqxLmrChfXLQ==
X-Received: by 2002:a17:907:6eab:: with SMTP id sh43mr1946016ejc.152.1644594573341;
        Fri, 11 Feb 2022 07:49:33 -0800 (PST)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id qx22sm7024597ejb.135.2022.02.11.07.49.32
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Feb 2022 07:49:32 -0800 (PST)
Received: by mail-ed1-f46.google.com with SMTP id s7so17168258edd.3
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Feb 2022 07:49:32 -0800 (PST)
X-Received: by 2002:aa7:d84e:: with SMTP id f14mr2555166eds.46.1644594572132;
 Fri, 11 Feb 2022 07:49:32 -0800 (PST)
MIME-Version: 1.0
References: <20220211094133.265066-1-ribalda@chromium.org> <20220211094133.265066-3-ribalda@chromium.org>
 <YgY1lzA20zyFcVi3@lahna>
In-Reply-To: <YgY1lzA20zyFcVi3@lahna>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 11 Feb 2022 16:49:21 +0100
X-Gmail-Original-Message-ID: <CANiDSCs3+637REhtGjKy+MSnUm-Mh-k1S7Lk9UKqC8JY-k=zTw@mail.gmail.com>
Message-ID: <CANiDSCs3+637REhtGjKy+MSnUm-Mh-k1S7Lk9UKqC8JY-k=zTw@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] thunderbolt: test: use NULL macros
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     kunit-dev@googlegroups.com, kasan-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Mika

On Fri, 11 Feb 2022 at 11:08, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Hi,
>
> On Fri, Feb 11, 2022 at 10:41:30AM +0100, Ricardo Ribalda wrote:
> > Replace the NULL checks with the more specific and idiomatic NULL macros.
> >
> > Acked-by: Daniel Latypov <dlatypov@google.com>
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
>
> ...
>
> > @@ -2496,50 +2496,50 @@ static void tb_test_property_parse(struct kunit *test)
> >       struct tb_property *p;
> >
> >       dir = tb_property_parse_dir(root_directory, ARRAY_SIZE(root_directory));
> > -     KUNIT_ASSERT_TRUE(test, dir != NULL);
> > +     KUNIT_ASSERT_NOT_NULL(test, dir);
> >
> >       p = tb_property_find(dir, "foo", TB_PROPERTY_TYPE_TEXT);
> > -     KUNIT_ASSERT_TRUE(test, !p);
> > +     KUNIT_ASSERT_NOT_NULL(test, p);
>
> This should be KUNIT_ASSERT_NULL(test, p) as we specifically want to
> check that the property does not exist (!p is same as p == NULL).
>
> >       p = tb_property_find(dir, "vendorid", TB_PROPERTY_TYPE_TEXT);
> > -     KUNIT_ASSERT_TRUE(test, p != NULL);
> > +     KUNIT_ASSERT_NOT_NULL(test, p);
> >       KUNIT_EXPECT_STREQ(test, p->value.text, "Apple Inc.");
> >
> >       p = tb_property_find(dir, "vendorid", TB_PROPERTY_TYPE_VALUE);
> > -     KUNIT_ASSERT_TRUE(test, p != NULL);
> > +     KUNIT_ASSERT_NOT_NULL(test, p);
> >       KUNIT_EXPECT_EQ(test, p->value.immediate, 0xa27);
> >
> >       p = tb_property_find(dir, "deviceid", TB_PROPERTY_TYPE_TEXT);
> > -     KUNIT_ASSERT_TRUE(test, p != NULL);
> > +     KUNIT_ASSERT_NOT_NULL(test, p);
> >       KUNIT_EXPECT_STREQ(test, p->value.text, "Macintosh");
> >
> >       p = tb_property_find(dir, "deviceid", TB_PROPERTY_TYPE_VALUE);
> > -     KUNIT_ASSERT_TRUE(test, p != NULL);
> > +     KUNIT_ASSERT_NOT_NULL(test, p);
> >       KUNIT_EXPECT_EQ(test, p->value.immediate, 0xa);
> >
> >       p = tb_property_find(dir, "missing", TB_PROPERTY_TYPE_DIRECTORY);
> > -     KUNIT_ASSERT_TRUE(test, !p);
> > +     KUNIT_ASSERT_NOT_NULL(test, p);
>
> Ditto here.
>
> With those fixed (please also run the tests if possible to see that they
> still pass) you can add,
>

Thanks!

To test it I had enabled:
PCI, USB4 and USB4_KUNIT_TEST

and then run it with

./tools/testing/kunit/kunit.py run --jobs=$(nproc) --arch=x86_64

Unfortunately, kunit was not able to run the tests

This hack did the trick:


 int tb_test_init(void)
 {
-       return __kunit_test_suites_init(tb_test_suites);
+       //return __kunit_test_suites_init(tb_test_suites);
+       return 0;
 }

 void tb_test_exit(void)
 {
-       return __kunit_test_suites_exit(tb_test_suites);
+       //return __kunit_test_suites_exit(tb_test_suites);
 }
+
+kunit_test_suites(&tb_test_suite);

I looked into why we do this and I found:

thunderbolt: Allow KUnit tests to be built also when CONFIG_USB4=m


I am a bit confused. The patch talks about build coverage, but even
with that patch reverted if
USB4_KUNIT_TEST=m
then test.c is built.

Shouldn't we simply revert that patch?

Thanks!

> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>
> Thanks!



-- 
Ricardo Ribalda
