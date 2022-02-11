Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D5E4B3114
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Feb 2022 23:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233304AbiBKWy5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Feb 2022 17:54:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiBKWy4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Feb 2022 17:54:56 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BAB2C63
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Feb 2022 14:54:51 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id s7so18615753edd.3
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Feb 2022 14:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MNyMAxSIRfmX6E7yXPlJDgtVqsNPCnT37/UNnUhdfcg=;
        b=PN9gtVb6nSnvnmYjzjkpar1jLF7GagSkv+xQr42ThW3tkgFPyh5shJv4uUq+9uowwk
         hAMckfSuryI9zgaiB/0OKuIGElkEmt/7wAMrTlot2O4f0J6Je7NesXPW6lvD+tlI5sOp
         6HUeYP4mTBPxy1SIeC90fuVLNrH2GQUdLF81ee23vBhHQGmSt6n+tiSW8wsMbQlkAJdI
         U5iEETDzJhV78YQSZfKjT29DXQsWSj33/Mqg3xgd3NaiWX9aFoEK12eOzd+gPfEybadh
         Hc4UDro//JidGXk8V/5JIh0UsmaB00MYxGhlbnbaEg7qK6yfcc9nTB5bI6IojQLwQvLy
         cJVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MNyMAxSIRfmX6E7yXPlJDgtVqsNPCnT37/UNnUhdfcg=;
        b=KaNz9RCKVYJjbO68Z+EjHrgq/sbMvRUy+fZoIIxNxpzHzKtveym6k3AhmQy091pk6k
         5EeXLGGM4o4orUBytVOyhDyePFcsUrEX0EJWrqojBwf8IcZFlbxxIL2z1fydLZmbMHXM
         V+rvzF1xA/IB9DeKuWkd1oYTxv68WoYdhXOIZrTmGo5VnWkARZS0ryVJObkbdCRcHD44
         Dfoa1TV0fYkuQ/th/jPd6Sfb/yqIanzBNg+w3G3HmO8WjsyBWGtOhz95OUw49a38dKHL
         xDySfAEgAXERN0lG7itpUjeY428InXnUwKcH3/UGFfsknI9Ij5H0KnpWB5QwgQcznjWz
         1T8A==
X-Gm-Message-State: AOAM532m3l1dXh6TOVi6qNgFPC6sOaQ/s4Y7B3nVNbmHQj4D99b5e1Ux
        o5oLaroGXvv58Ee63/h8fg0ein8NqJHRYLMDWwXmFQ==
X-Google-Smtp-Source: ABdhPJzPOkMa9Yfx2cK2rXg9vNZWhy2XXDei6adD9tdqXmeicrpJGROv/oH9u7zS4GKx4ElGyaSyuLujHB+nvPRtLh8=
X-Received: by 2002:a05:6402:289:: with SMTP id l9mr4272896edv.272.1644620090064;
 Fri, 11 Feb 2022 14:54:50 -0800 (PST)
MIME-Version: 1.0
References: <20220211094133.265066-1-ribalda@chromium.org> <20220211094133.265066-3-ribalda@chromium.org>
 <YgY1lzA20zyFcVi3@lahna> <CANiDSCs3+637REhtGjKy+MSnUm-Mh-k1S7Lk9UKqC8JY-k=zTw@mail.gmail.com>
 <YgaOS8BLz23k6JVq@lahna> <YgaPXhOr/lFny4IS@lahna> <CANiDSCs7M_hSb2njr50_d3z=cx=N9gWHzVe-HkpCV1Au8yVwOw@mail.gmail.com>
In-Reply-To: <CANiDSCs7M_hSb2njr50_d3z=cx=N9gWHzVe-HkpCV1Au8yVwOw@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Fri, 11 Feb 2022 14:54:37 -0800
Message-ID: <CAGS_qxp3OHFwK__wCHBGr9cMsLR=gfD2rhjejXcmFNJ276_ciw@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] thunderbolt: test: use NULL macros
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        kunit-dev@googlegroups.com, kasan-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>
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

On Fri, Feb 11, 2022 at 8:33 AM Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> Hi Mika
>
> On Fri, 11 Feb 2022 at 17:31, Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> >
> > On Fri, Feb 11, 2022 at 06:26:56PM +0200, Mika Westerberg wrote:
> > > > To test it I had enabled:
> > > > PCI, USB4 and USB4_KUNIT_TEST
> > > >
> > > > and then run it with
> > > >
> > > > ./tools/testing/kunit/kunit.py run --jobs=$(nproc) --arch=x86_64
> > > >
> > > > Unfortunately, kunit was not able to run the tests
> > > >
> > > > This hack did the trick:
> > > >
> > > >
> > > >  int tb_test_init(void)
> > > >  {
> > > > -       return __kunit_test_suites_init(tb_test_suites);
> > > > +       //return __kunit_test_suites_init(tb_test_suites);
> > > > +       return 0;
> > > >  }
> > > >
> > > >  void tb_test_exit(void)
> > > >  {
> > > > -       return __kunit_test_suites_exit(tb_test_suites);
> > > > +       //return __kunit_test_suites_exit(tb_test_suites);
> > > >  }
> > > > +
> > > > +kunit_test_suites(&tb_test_suite);
> > > >
> > > > I looked into why we do this and I found:
> > > >
> > > > thunderbolt: Allow KUnit tests to be built also when CONFIG_USB4=m
> > > >
> > > >
> > > > I am a bit confused. The patch talks about build coverage, but even
> > > > with that patch reverted if
> > > > USB4_KUNIT_TEST=m
> > > > then test.c is built.
> > > >
> > > > Shouldn't we simply revert that patch?
> > >
> > > Nah, either build it into the kernel or load the driver manually:
> > >
> > >   # modprobe thunderbolt
> >
> > Forgot to explain why this does not run the tests (I think):
> >
> >  ./tools/testing/kunit/kunit.py run --jobs=$(nproc) --arch=x86_64
> >
> > The driver depends on PCI and I don't think that's enabled on UML at
> > least. I typically run it inside QEMU.

You can get it working on UML now.
If you apply the patch upthread for the test to use kunit_test_suites(), then

$ cat usb4_kunitconfig
CONFIG_PCI=y
CONFIG_VIRTIO_UML=y
CONFIG_UML_PCI_OVER_VIRTIO=y

CONFIG_KUNIT=y
CONFIG_USB4=y
CONFIG_USB4_KUNIT_TEST=y

$ ./tools/testing/kunit/kunit.py run --kunitconfig=usb4_kunitconfig
...
[14:48:55] [PASSED] tb_test_property_copy
[14:48:55] =================== [PASSED] thunderbolt ===================
[14:48:55] ============================================================
[14:48:55] Testing complete. Passed: 37, Failed: 0, Crashed: 0,
Skipped: 0, Errors: 0

Mika, should I propose a patch that updates the test and adds a
drivers/thunderbolt/.kunitconfig with the above contents?

Then it could be invoked as
$ ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/thunderbolt
