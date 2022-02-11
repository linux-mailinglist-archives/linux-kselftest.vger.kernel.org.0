Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925BE4B2A73
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Feb 2022 17:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345137AbiBKQdr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Feb 2022 11:33:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351592AbiBKQdl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Feb 2022 11:33:41 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D912FD6A
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Feb 2022 08:33:39 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a8so24066571ejc.8
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Feb 2022 08:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kH7nDg9vlUfZWnMGN6aHfMDBm40Pv48zIdTUyD3E5jE=;
        b=AhUF7uzZApBB+rlNRBF5SB6Enjun/UDrMkwn2sAYEdf+LcqDPRmG/2s4G+ISXefBtN
         AYluIz4T8q+EgHDt1NMC3y75v+JG5N8GlQ2NAkPpYJ93yHdyXj55jrPB2plyBF5KAVO4
         oRyP0iAaIizBxSvjbj0/ZFrJ4xn0nZOKUtjRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kH7nDg9vlUfZWnMGN6aHfMDBm40Pv48zIdTUyD3E5jE=;
        b=oTzCBDDYpEcEPMW+H6NZwAT3JwsFyVWj9NH52Jb65ui9tvjZhSYnE201K4IBrJhfyF
         jldLkb53/qMWWArTmXB2NIY/3/3jj9jJfkQ2oW229Xt1zyZov060BpQ6ztrlG6r/nWOd
         jq+yDOQ/6HbQhgtxAPURJQcth3eQrJ56O1GQwVbDHDP+2qJpwkaGEvBQKmbSGtxQkpAI
         H8God6XF9XhkPlJrXx5jiU+VAXncEfWCW9Ho/j2bWptDeS6bG0gligbJ6lPnfYmeI2rz
         CxKk1c8iSHWnxm/IyHymZWU3EUOehV9eknzf7IkLEhd0UE0NXO7K7Yimk9hdgrX/m3KN
         etrA==
X-Gm-Message-State: AOAM533bMYZkOd0rU+F16O25Khw1Y5V1RxeyZoVtRVTRPdvK9ONrWXNa
        7Dcv1khY92evl3URbiH7dGxZ4Gtgl0NRMMct
X-Google-Smtp-Source: ABdhPJxa9uV2FObW+h8yQ+ExCDCp1WV/EAarLuvii7sCfIQFXixNHwtvxa2WHQe+/OOuyaBDRqGvLw==
X-Received: by 2002:a17:906:7481:: with SMTP id e1mr1994509ejl.573.1644597218208;
        Fri, 11 Feb 2022 08:33:38 -0800 (PST)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id n20sm3974424eje.205.2022.02.11.08.33.37
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Feb 2022 08:33:37 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id u18so17324022edt.6
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Feb 2022 08:33:37 -0800 (PST)
X-Received: by 2002:a05:6402:2947:: with SMTP id ed7mr2823276edb.141.1644597216925;
 Fri, 11 Feb 2022 08:33:36 -0800 (PST)
MIME-Version: 1.0
References: <20220211094133.265066-1-ribalda@chromium.org> <20220211094133.265066-3-ribalda@chromium.org>
 <YgY1lzA20zyFcVi3@lahna> <CANiDSCs3+637REhtGjKy+MSnUm-Mh-k1S7Lk9UKqC8JY-k=zTw@mail.gmail.com>
 <YgaOS8BLz23k6JVq@lahna> <YgaPXhOr/lFny4IS@lahna>
In-Reply-To: <YgaPXhOr/lFny4IS@lahna>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 11 Feb 2022 17:33:25 +0100
X-Gmail-Original-Message-ID: <CANiDSCs7M_hSb2njr50_d3z=cx=N9gWHzVe-HkpCV1Au8yVwOw@mail.gmail.com>
Message-ID: <CANiDSCs7M_hSb2njr50_d3z=cx=N9gWHzVe-HkpCV1Au8yVwOw@mail.gmail.com>
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

On Fri, 11 Feb 2022 at 17:31, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> On Fri, Feb 11, 2022 at 06:26:56PM +0200, Mika Westerberg wrote:
> > > To test it I had enabled:
> > > PCI, USB4 and USB4_KUNIT_TEST
> > >
> > > and then run it with
> > >
> > > ./tools/testing/kunit/kunit.py run --jobs=$(nproc) --arch=x86_64
> > >
> > > Unfortunately, kunit was not able to run the tests
> > >
> > > This hack did the trick:
> > >
> > >
> > >  int tb_test_init(void)
> > >  {
> > > -       return __kunit_test_suites_init(tb_test_suites);
> > > +       //return __kunit_test_suites_init(tb_test_suites);
> > > +       return 0;
> > >  }
> > >
> > >  void tb_test_exit(void)
> > >  {
> > > -       return __kunit_test_suites_exit(tb_test_suites);
> > > +       //return __kunit_test_suites_exit(tb_test_suites);
> > >  }
> > > +
> > > +kunit_test_suites(&tb_test_suite);
> > >
> > > I looked into why we do this and I found:
> > >
> > > thunderbolt: Allow KUnit tests to be built also when CONFIG_USB4=m
> > >
> > >
> > > I am a bit confused. The patch talks about build coverage, but even
> > > with that patch reverted if
> > > USB4_KUNIT_TEST=m
> > > then test.c is built.
> > >
> > > Shouldn't we simply revert that patch?
> >
> > Nah, either build it into the kernel or load the driver manually:
> >
> >   # modprobe thunderbolt
>
> Forgot to explain why this does not run the tests (I think):
>
>  ./tools/testing/kunit/kunit.py run --jobs=$(nproc) --arch=x86_64
>
> The driver depends on PCI and I don't think that's enabled on UML at
> least. I typically run it inside QEMU.


Could you try this out ?

From a clean kernel dir:

./tools/testing/kunit/kunit.py run --jobs=$(nproc) --arch=x86_64
make ARCH=x86_64 menuconfig  O=.kunit
# Enable PCI USB4 and USB4_KUNIT_TEST
./tools/testing/kunit/kunit.py run --jobs=$(nproc) --arch=x86_64

And then I get plenty of:
[16:31:57] [ERROR] Test property-entry: Expected test number N but found N+1

If I revert the previous patch all works fine.

Please note that --arch uses qemu

Thanks!


-- 
Ricardo Ribalda
