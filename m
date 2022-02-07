Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C2C4ACA9F
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Feb 2022 21:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbiBGUrr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Feb 2022 15:47:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243124AbiBGUbl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Feb 2022 15:31:41 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F02C0401DA
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Feb 2022 12:31:40 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id w14so32756068edd.10
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Feb 2022 12:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GD9WbSwS36ZJGxaF9Sl8pq7QQD63VifIib0L26eGX/g=;
        b=JahJ6uLWlIbMOBh/qYrFm74Be8WoReMG3JlGaBsp3MPCUDwwBqEozJSwgUA19WGaEd
         9C1oXFseSfohJNhbhBTE3ofAC6fAOKTcxtVQtrUV3qOriOBPk0kbowHy3aBmZR9N+zCU
         PlS/SSkXiSZVVgJMMJT2vDQze5lmugmZXIYEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GD9WbSwS36ZJGxaF9Sl8pq7QQD63VifIib0L26eGX/g=;
        b=lFU0aWRcrvIfG3itwei5ErtXO+XDBGuWaY1mrsuIcTbzMb+Yr7W2MgVzX+NKvF+leV
         m3+ATcDJtvZmyZEyNY0T71/7h3MxUCv7wHri7t6CYLIZYY5PBaUz31ZBXfKyFOxA6ee0
         VXVIEjeH176hMfkvfKeAOtsMfVQbd6mF1C6Hs1tDGaY/hXxdNO2AAcCPKIpQlV5GA3o0
         3OddMpQwn4XX+xEW6IAID0dTbPDgvzVqLkqEhHz8q31QkyR2oQU8R91jldkAfF/RoslS
         AkiHoXSbEt2IgZlL/4OPtZeoP1bjOiTWk7awv9gVRL99bcabeLIegucQ8yKYnpg3EIyZ
         mwkw==
X-Gm-Message-State: AOAM531jC6E5VzCPLzBoKtxaH8cynZ73jfmK2jDYrGk9QPdXd2a9xYCz
        TH9n9tLIa9VWWWU85Ew3yihPNhJ4vofN9K4I
X-Google-Smtp-Source: ABdhPJxN/WS5ezrn7lsHegWrzGOnzibQCkMB327KZHtgxi71qYq2IHLAghZ89P1PG9i/7RLYsbIiNg==
X-Received: by 2002:a50:cdcc:: with SMTP id h12mr1195673edj.107.1644265899234;
        Mon, 07 Feb 2022 12:31:39 -0800 (PST)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id f19sm1894391edr.96.2022.02.07.12.31.38
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 12:31:38 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id eg42so16954479edb.7
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Feb 2022 12:31:38 -0800 (PST)
X-Received: by 2002:a05:6402:510b:: with SMTP id m11mr1237037edd.290.1644265897849;
 Mon, 07 Feb 2022 12:31:37 -0800 (PST)
MIME-Version: 1.0
References: <20220207183308.1829495-1-ribalda@chromium.org>
 <CAGS_qxoTLwvVjDGbfeOjMrGvh7sck7TDmiVeDXS2S5oyDWiKzA@mail.gmail.com> <CAGS_qxrkswforSv4XKGChwOZ0MbTGzCqYKsZq=0Sx6ThMOrheQ@mail.gmail.com>
In-Reply-To: <CAGS_qxrkswforSv4XKGChwOZ0MbTGzCqYKsZq=0Sx6ThMOrheQ@mail.gmail.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Mon, 7 Feb 2022 21:31:26 +0100
X-Gmail-Original-Message-ID: <CANiDSCvJ0AnHwqZ66caT9xUidTFp1Akck_UkpQxwojQRpSLMyA@mail.gmail.com>
Message-ID: <CANiDSCvJ0AnHwqZ66caT9xUidTFp1Akck_UkpQxwojQRpSLMyA@mail.gmail.com>
Subject: Re: [PATCH 1/6] kunit: Introduce _NULL and _NOT_NULL macros
To:     Daniel Latypov <dlatypov@google.com>
Cc:     kunit-dev@googlegroups.com, kasan-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
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

Hi Daniek

On Mon, 7 Feb 2022 at 21:29, Daniel Latypov <dlatypov@google.com> wrote:
>
> On Mon, Feb 7, 2022 at 11:09 AM Daniel Latypov <dlatypov@google.com> wrote:
> >
> > On Mon, Feb 7, 2022 at 10:33 AM Ricardo Ribalda <ribalda@chromium.org> wrote:
> > >
> > > Today, when we want to check if a pointer is NULL and not ERR we have
> > > two options:
> > >
> > > EXPECT_TRUE(test, ptr == NULL);
> > >
> > > or
> > >
> > > EXPECT_PTR_NE(test, ptr, (struct mystruct *)NULL);
> > >
> > > Create a new set of macros that take care of NULL checks.
> >
> > I think we've usually had people do
> >   KUNIT_EXPECT_FALSE(test, nullptr);
> >
> > I'm not personally against having an explicit NULL check, however.
> >
> > But if we want to continue with this, we'll want to rebase on top of
> > https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/?h=kunit
> > since a lot of this code has been deleted or refactored.
> > E.g. see https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/tree/include/kunit/test.h?h=kunit
>
> I forgot to mention, it'd also be a good idea to update the new
> example test case:
> https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/tree/lib/kunit/kunit-example-test.c?h=kunit#n76

Already in v2

Thanks for your flash review :)

>
> e.g. just adding
>   KUNIT_EXPECT_NULL(test, NULL);
> with the rest of the pointer assertions



-- 
Ricardo Ribalda
