Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC96C581B03
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Jul 2022 22:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239899AbiGZU0T (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Jul 2022 16:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239831AbiGZU0T (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Jul 2022 16:26:19 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F41213FBB
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Jul 2022 13:26:16 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id o13so4077850edc.0
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Jul 2022 13:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SCbzcnRoXkiamtSXlne81U8f+vR3j3GE5M+4vscq2sc=;
        b=NfS+0hNrCJyXM32ZQ5he5a2I24pM/fmUJX0SeLd00f/c62yqVB46pTiaWNp8cgjAIM
         0enHnLvSax6YWp/NSGPM1OwCieMq6vcfe1/6dVupcEVDqL2lnAlH7sKYc2qj1h2A1J8O
         0fOxPlkQ0lB/c8EwFrW5W5jfQDsE9JhhCy2Oqkeyb8mkpUcqYWrKirtmC9xFBH7ikGlo
         9uAsIXrXbVz2DMBCs2KEUK/PH4rfPicJo8rn7bXVFv0ZQZhgH+93V1k0/l1x+/eA4TBG
         RKu6bK0PP/AMLAdqEiBfxxAGE5HBvGV9t6xNJN/W13AVylc0aQZfHGD7a7KwKUODcqqk
         Yvcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SCbzcnRoXkiamtSXlne81U8f+vR3j3GE5M+4vscq2sc=;
        b=YBYG8GeBE5rrwz5uVynAPxRX1Pucq3p47ZrXDl2aC/20CNeCulL75WgKvTpCb+d2BK
         piufywD5aeFCNm1tFftLuvH9W/AY/gPz5DL3klt7ekuZRRhQzRmJcYtnWazuVMTDh9qK
         6Ek+NS+bH0pagRHN3lpWj8U5gwf6Wj3PiNNvuT91YEQNSMwmTZJEccFlVhjyxZc7Kii2
         Ohvc8DT9uRicos1UUX3hda4ISemt1wUqcuJ+ma3GWzsoh3fksODNH+SvpQFL6KXHb5XL
         +MuNHpkyxyKxXQsIEKvX/TPQfnI8DrHylRSOqcqgggEn3/DWvpDe8rwLR0PXwb9pTxc4
         JVVg==
X-Gm-Message-State: AJIora/K0j9rnhgRtkDUpsED4mgVjCdmngA0xxNstI0cV3ycxGCdNCrt
        u9WgPZvBP8nH8ZBCQCwfi4wQ4tFD/LbcllEudYGlug==
X-Google-Smtp-Source: AGRyM1uSHZOKNK+16xIOfZQvddbpS0HpVegfv+pnKKrmoIOe8YjelL4vvOcf0EzcoXJA63yuLy0EUEbRLglv73klp74=
X-Received: by 2002:a05:6402:4507:b0:43b:b8df:571d with SMTP id
 ez7-20020a056402450700b0043bb8df571dmr8264202edb.230.1658867174676; Tue, 26
 Jul 2022 13:26:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220711162713.2467476-1-dlatypov@google.com> <20220711204859.3DDD5C34115@smtp.kernel.org>
 <CAGS_qxqxGfQ5tA063XoRbL1ktimyfmt+CuucJ_rsYVnoi4i7gw@mail.gmail.com>
 <CABVgOS=bm5TmEBd8jxuTPJy426OgC14ryqn4FLQR1pHNf5uhsw@mail.gmail.com> <20220726200741.2DDA2C433C1@smtp.kernel.org>
In-Reply-To: <20220726200741.2DDA2C433C1@smtp.kernel.org>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Tue, 26 Jul 2022 13:26:03 -0700
Message-ID: <CAGS_qxpKB_H121kWrCjP6as_FA84ctUz=pv-aKFZq3mV7eqbnw@mail.gmail.com>
Subject: Re: [PATCH] clk: explicitly disable CONFIG_UML_PCI_OVER_VIRTIO in .kunitconfig
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-clk@vger.kernel.org, Maxime Ripard <maxime@cerno.tech>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jul 26, 2022 at 1:07 PM Stephen Boyd <sboyd@kernel.org> wrote:

> > The other option of using function redirection on the io read()
> > write() functions exists, and would be a bit simpler in the
> > short-term, but would probably result in a lot of tests reimplementing
> > this, and also would have some performance impacts, as the I/O
> > accesses wouldn't be able to be inlined if KUNIT is enabled.
> >
>
> That sounds OK to me because nobody is enabling KUNIT in production,
> right?

You'd think so, but...

Android GKI [1] is enabling it. I had thought as =m, but maybe it was =y.
I can't find a good link for it now, but e.g. here's a patch they're
carrying to prevent KUnit from running built-in tests [2]

They could just carry another patch if we go down this route, but it
goes to show that there might be others out there w/ reasons to do
this.

[1] https://source.android.com/devices/architecture/kernel/generic-kernel-image
[2] https://android.googlesource.com/kernel/common-patches/+/refs/heads/master/android-mainline/ANDROID-GKI-Disable-KUnit-built-in-testing.patch
